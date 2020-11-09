#!/usr/bin/env bash

export AWS_PROFILE=review-aggregator
exec sops "${@}"