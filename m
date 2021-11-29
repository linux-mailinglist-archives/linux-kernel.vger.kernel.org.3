Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A96461B02
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 16:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346885AbhK2PgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:36:19 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:45824 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhK2Pd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:33:57 -0500
Received: by mail-oi1-f169.google.com with SMTP id 7so35213391oip.12;
        Mon, 29 Nov 2021 07:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=6THXcIGoLp6QwGKfw0cyj8oia8wwhQE6ljHde1y7tgU=;
        b=4Lph2TiYqFWRcvLjlRA9QWAVlJyEAr93Epd/zL8ijjFvij0zoQuXXziy63GKYUDzBl
         BkcdchQCcZILD1W5dGilTgbJHWDY0eavjtXET7H/m9K4pwOpIfWnDUnpWJSauAwPIvZI
         VBTw9BfylhECkUyS6+Emb9aavajxyDJKD4cLTogVxX/q6Jls1yTQUnyBOjfX5GN3hnXO
         0IWJXb1yKdt1dP+JPti9nYg6uzXyKx53vj3nZQ5zfDXs328+nlbP0VdbPCo1PLIs1jVJ
         hW2qVezTSta4fpCuCtvHGkQbWODWK8iFerKuiYkvqhrjt13XXbzj76gNAe7a3EX7ZZt2
         5J7g==
X-Gm-Message-State: AOAM530JHdPwAWvhBo8tVbDR9PtFY16KA/0f4sdM/oGL8RzdjQQof6j5
        OxilTjZFP/KaQkrgjxz51A==
X-Google-Smtp-Source: ABdhPJzSL0gcqzaakshHOOyWn+i3lg8/UoCkqqvEtyH87CsQRjyrYnvjJR22ShYlDpIIpvfFrqxLDw==
X-Received: by 2002:a05:6808:1185:: with SMTP id j5mr41185468oil.16.1638199839402;
        Mon, 29 Nov 2021 07:30:39 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id ay40sm3107794oib.1.2021.11.29.07.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 07:30:38 -0800 (PST)
Received: (nullmailer pid 123617 invoked by uid 1000);
        Mon, 29 Nov 2021 15:30:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Cc:     Venkata Prasad Potturu <potturu@codeaurora.org>, agross@kernel.org,
        lgirdwood@gmail.com, bgoswami@codeaurora.org, robh+dt@kernel.org,
        linux-gpio@vger.kernel.org, judyhsiao@chromium.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org,
        srinivas.kandagatla@linaro.org, tiwai@suse.com, perex@perex.cz,
        linux-arm-msm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>, broonie@kernel.org,
        plai@codeaurora.org, rohitkr@codeaurora.org,
        alsa-devel@alsa-project.org
In-Reply-To: <1638179932-3353-3-git-send-email-srivasam@codeaurora.org>
References: <1638179932-3353-1-git-send-email-srivasam@codeaurora.org> <1638179932-3353-3-git-send-email-srivasam@codeaurora.org>
Subject: Re: [PATCH v3 2/5] dt-bindings: pinctrl: qcom: Add sc7280 lpass lpi pinctrl bindings
Date:   Mon, 29 Nov 2021 09:30:31 -0600
Message-Id: <1638199831.132589.123616.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 15:28:49 +0530, Srinivasa Rao Mandadapu wrote:
> Add device tree binding Documentation details for Qualcomm SC7280
> LPASS LPI pinctrl driver.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> Co-developed-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> ---
>  .../pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml     | 115 +++++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml: duplicate '$id' value 'http://devicetree.org/schemas/pinctrl/qcom,lpass-lpi-pinctrl.yaml#'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1561073

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

