Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC26A461B01
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 16:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345907AbhK2PgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:36:15 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:33763 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhK2Pdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:33:55 -0500
Received: by mail-ot1-f49.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso26119047otf.0;
        Mon, 29 Nov 2021 07:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=o9/xltpZS8/e+Fx8LAzHE+t3v33y8dbhp5g24ocDpeA=;
        b=rh9Hed8N1XXyqnoie48/wZUjQP3PxBmbIjT9cWHviAwisnWId833pRaA7PRV4wc194
         e81rQK7kaweOsiGdNuk5jidwDTkLsi9FCc59I6lL2O3tRdH+Z56Gv4QWX5B339m7clLA
         4whnUPQ0uTFDOyNHEWAd5mcl6cpOIaKE2q3Ehpsyl9C756Wmj3+/y3GUxb6A3RUHi+OU
         zkGRul5IcTFoNwjVIbXuVdSAgOiu28zG12QhIFODa48mUpkk+5wvvvp1EkchpgbM0/y+
         S39OEmhb76m4QfhO+PhCmHahSHtAc3XNmPakiElVfl3lIBWwz2TE0fmvaJ8rgsWfYqDM
         A4yA==
X-Gm-Message-State: AOAM530Rbo56P/1hW6u1TUB25VRrkyXeYrjVCXJvtWo2wSbJDre6VG6a
        XBp4ohXo5IOx/ngA3qbTaw==
X-Google-Smtp-Source: ABdhPJzmfe6xuhnb21hy8AM/h3XzDFm6oGuf3rxxPOA0K4txwqSNxF0l8aXDu8NZZ8L0OV75xjneug==
X-Received: by 2002:a05:6830:1204:: with SMTP id r4mr45833918otp.34.1638199837059;
        Mon, 29 Nov 2021 07:30:37 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m5sm3007643oim.45.2021.11.29.07.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 07:30:36 -0800 (PST)
Received: (nullmailer pid 123615 invoked by uid 1000);
        Mon, 29 Nov 2021 15:30:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org,
        Venkata Prasad Potturu <potturu@codeaurora.org>,
        bjorn.andersson@linaro.org, swboyd@chromium.org, perex@perex.cz,
        Linus Walleij <linus.walleij@linaro.org>,
        rohitkr@codeaurora.org, devicetree@vger.kernel.org,
        bgoswami@codeaurora.org, plai@codeaurora.org, lgirdwood@gmail.com,
        agross@kernel.org, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, tiwai@suse.com,
        judyhsiao@chromium.org, srinivas.kandagatla@linaro.org,
        broonie@kernel.org, robh+dt@kernel.org, linux-gpio@vger.kernel.org
In-Reply-To: <1638179932-3353-2-git-send-email-srivasam@codeaurora.org>
References: <1638179932-3353-1-git-send-email-srivasam@codeaurora.org> <1638179932-3353-2-git-send-email-srivasam@codeaurora.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: pinctrl: qcom: Update lpass lpi file name to SoC specific
Date:   Mon, 29 Nov 2021 09:30:31 -0600
Message-Id: <1638199831.124829.123614.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 15:28:48 +0530, Srinivasa Rao Mandadapu wrote:
> Change generic lpass lpi pincotrol bindings file to SoC specific file,
> to distinguish and accomadate other SoC specific dt bindings.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> Co-developed-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> ---
>  .../bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml   | 130 ---------------------
>  .../pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml     | 130 +++++++++++++++++++++
>  2 files changed, 130 insertions(+), 130 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1561071

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

