Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658F2468088
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383437AbhLCXho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:37:44 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:46841 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376744AbhLCXhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:37:43 -0500
Received: by mail-oi1-f174.google.com with SMTP id s139so8741637oie.13;
        Fri, 03 Dec 2021 15:34:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=dXD3ujoJ+Ol1hRij1M2TL8mmDFnoEkO7pukqJulGr+k=;
        b=N8FHxRps6Mh9oYwKNVOVPnqko75SKMGpusLgr7G4kGy1Kudd0UnrpRr8or96mszjeF
         c+Z/7127uvL/Ah7Yukon694KGRYX5uWW8LAWH2/OuYupS7Y9XjYbIdTT3aX7qdsG9vsZ
         mOUPQxfy5FTdPIFj8caxgIihf0ybu018GfWkHD7um845Vjyf0dDy1Z5+Ej7+HNyKPYIA
         uH4ThAFJL9i8d/A1wZZxZimQisw9ayu4KBnCzDtvIs/YJ8jlGiF9E8PF8Xv4DRQwdaH2
         Yp5LG9+qQX7a4HMoGESQHSby0rwWmZb5fwpfqLYjB1SujgXgU7y/JGLTx8B24apCYzEs
         uYmg==
X-Gm-Message-State: AOAM531qFOc9n+LwGt/S2EMn4TBCgInb+MZg+ssAyV5UNAVbH0OKws6o
        /l3EQAwy7yZ1QJ/UawXjFw==
X-Google-Smtp-Source: ABdhPJw6QS6fsJGv+QpL9azlCRNikWE+y330z+sQRPDPP5v6tmPL6FFgkXT+M0qnV60ohRJj21X+IQ==
X-Received: by 2002:a05:6808:10ce:: with SMTP id s14mr11965670ois.137.1638574458626;
        Fri, 03 Dec 2021 15:34:18 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b22sm945076oib.41.2021.12.03.15.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 15:34:17 -0800 (PST)
Received: (nullmailer pid 1043005 invoked by uid 1000);
        Fri, 03 Dec 2021 23:34:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.com>
Cc:     robh+dt@kernel.org,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        alsa-devel@alsa-project.org, rohitkr@codeaurora.org,
        plai@codeaurora.org, bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org, Linus Walleij <linus.walleij@linaro.org>,
        bgoswami@codeaurora.org, srinivas.kandagatla@linaro.org,
        broonie@kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
        perex@perex.cz, swboyd@chromium.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Venkata Prasad Potturu <potturu@codeaurora.org>
In-Reply-To: <1638531140-25899-3-git-send-email-srivasam@codeaurora.com>
References: <1638531140-25899-1-git-send-email-srivasam@codeaurora.com> <1638531140-25899-3-git-send-email-srivasam@codeaurora.com>
Subject: Re: [PATCH v4 2/5] dt-bindings: pinctrl: qcom: Add sc7280 lpass lpi pinctrl bindings
Date:   Fri, 03 Dec 2021 17:34:15 -0600
Message-Id: <1638574455.236196.1043004.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Dec 2021 17:02:17 +0530, Srinivasa Rao Mandadapu wrote:
> From: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> 
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
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml: duplicate '$id' value 'http://devicetree.org/schemas/pinctrl/qcom,lpass-lpi-pinctrl.yaml#'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1563187

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

