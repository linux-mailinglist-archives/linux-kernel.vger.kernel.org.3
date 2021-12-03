Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DB5468095
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383499AbhLCXhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:37:54 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:38823 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383477AbhLCXhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:37:48 -0500
Received: by mail-ot1-f42.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso5401190ota.5;
        Fri, 03 Dec 2021 15:34:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=iC865KFxTLPcMpjh7ZOt0xoZbvZ+6a6MRjUFIn4wKjE=;
        b=tXAtokrSJjTaMBto288pNrE9He1Czgt9g4x0k4313Tcm4GQkYI8X3e/uyTxCMyhhs3
         6gPuHrwPxYv22PQI7UGWyVVEVj7/MoLdhcaGPOUeQPYlz7A8/S7Qur0wqzlQCMZ/iYuF
         OKSabJ9H9DHdwbOkHRFHt5m0CPwO7oldSj9tSbg1PZN3mDy2PWgYZl8nWIG91gMqGm63
         6RgbdAd3oXXre110lHau1C/QwqbpFNBfSDfLkaLjd88Yd+20bD13EszACw7Bja5rQh18
         g+LD9Af+3fzgWFkIx7WikdrWNmLkV2wb3PAiKY5WC5kGfdCdw3LLNNeoAHgl03gm1j1l
         MEhQ==
X-Gm-Message-State: AOAM530YHYeUMZGdufyNaQzQD6+Q1M9ajHjJpcB45yMeTJLjPLgc10Wq
        2jGTAQ/vVMAKYvu0ntJVMg==
X-Google-Smtp-Source: ABdhPJw9SZBJilhMiAFCEuqmdNCHQzZc2/FYmICpgHv78bkjKjYOPiDzcdolwABRd3lABaKDyJ5BFQ==
X-Received: by 2002:a9d:4d08:: with SMTP id n8mr18258991otf.368.1638574463756;
        Fri, 03 Dec 2021 15:34:23 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w71sm939507oiw.6.2021.12.03.15.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 15:34:23 -0800 (PST)
Received: (nullmailer pid 1043003 invoked by uid 1000);
        Fri, 03 Dec 2021 23:34:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.com>
Cc:     swboyd@chromium.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        plai@codeaurora.org,
        Venkata Prasad Potturu <potturu@codeaurora.org>,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        srinivas.kandagatla@linaro.org, bjorn.andersson@linaro.org,
        tiwai@suse.com, bgoswami@codeaurora.org,
        linux-gpio@vger.kernel.org, rohitkr@codeaurora.org, perex@perex.cz,
        agross@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        lgirdwood@gmail.com
In-Reply-To: <1638531140-25899-2-git-send-email-srivasam@codeaurora.com>
References: <1638531140-25899-1-git-send-email-srivasam@codeaurora.com> <1638531140-25899-2-git-send-email-srivasam@codeaurora.com>
Subject: Re: [PATCH v4 1/5] dt-bindings: pinctrl: qcom: Update lpass lpi file name to SoC specific
Date:   Fri, 03 Dec 2021 17:34:15 -0600
Message-Id: <1638574455.221589.1043002.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Dec 2021 17:02:16 +0530, Srinivasa Rao Mandadapu wrote:
> Change generic lpass lpi pincotrol bindings file to SoC specific file,
> to distinguish and accomadate other SoC specific dt bindings.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.com>
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

See https://patchwork.ozlabs.org/patch/1563181

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

