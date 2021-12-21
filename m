Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA2D47C951
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 23:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhLUWpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 17:45:35 -0500
Received: from mail-qv1-f46.google.com ([209.85.219.46]:34333 "EHLO
        mail-qv1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbhLUWpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 17:45:35 -0500
Received: by mail-qv1-f46.google.com with SMTP id ke6so674260qvb.1;
        Tue, 21 Dec 2021 14:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=+SlxlPFUAIksbSGbfJhkBNtunIqmSVgKHxJRcHXcQ94=;
        b=AJuXwtOvnE2z2Z2uE1xR5PAV1qYm1FPVqBeZBStfqNw+k1NoxZpQFh74cl5fVjqMTL
         yd47S3qp8F/W2eOECTiH5gSmx7Rr6sQB/jyqhQdkV2/5Nv0cvs0CBpusWuuYEwB6yncc
         mmj9olN2eFdbgCx/nrM8zDA50jLhgA+fLKcXK6KaYdnDhkX8TpNpJNdeTgMTTaHM1nST
         Uzz0zRXPfMCJanaaxYizVn0kU2cGxZgReGpPVPq1QE7064u2FpRunrXkgeSAMlHqXIoe
         iccl/ikakYV5ctT9u85b8sa0QgnxSla+rC9VbBURC3wahWMC/WSYoP1YAeq5B35/uqwK
         uuGw==
X-Gm-Message-State: AOAM530IDGRr9e9rneeYF8Emoixx/Kxn5FB+7M+MkxcvCftT65tC5B0r
        pWYJ/U6yaiav3BVIkeEezqb17gAhtupm
X-Google-Smtp-Source: ABdhPJwICeOv3LZbjDh2U2Dcn/0vXEzNImCZcYu9rQjErZcZ4o6ZGrQ9T/ozNaawRpsqDXgRdrWE2A==
X-Received: by 2002:a05:6214:4008:: with SMTP id kd8mr390066qvb.127.1640126734116;
        Tue, 21 Dec 2021 14:45:34 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id w10sm255592qtj.37.2021.12.21.14.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 14:45:33 -0800 (PST)
Received: (nullmailer pid 1654435 invoked by uid 1000);
        Tue, 21 Dec 2021 22:45:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Niklas Cassel <nks@flawful.org>, linux-arm-msm@vger.kernel.org
In-Reply-To: <20211221133937.173618-1-y.oudjana@protonmail.com>
References: <20211221133937.173618-1-y.oudjana@protonmail.com>
Subject: Re: [PATCH] dt-bindings: power: avs: qcom,cpr: Convert to DT schema
Date:   Tue, 21 Dec 2021 18:45:31 -0400
Message-Id: <1640126731.354790.1654434.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 13:40:05 +0000, Yassine Oudjana wrote:
> Convert qcom,cpr.txt to DT schema format.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../bindings/power/avs/qcom,cpr.txt           | 130 --------------
>  .../bindings/power/avs/qcom,cpr.yaml          | 161 ++++++++++++++++++
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 162 insertions(+), 131 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
>  create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/power/avs/qcom,cpr.example.dt.yaml:0:0: /example-0/cpr-opp-table: failed to match any schema with compatible: ['operating-points-v2-qcom-level']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1571666

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

