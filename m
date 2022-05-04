Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7786E51AF21
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378047AbiEDUe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378037AbiEDUez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:34:55 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCBE4F9EB;
        Wed,  4 May 2022 13:31:18 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id l9-20020a056830268900b006054381dd35so1655766otu.4;
        Wed, 04 May 2022 13:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eqhMwN4tyN2ECyEbdMTwnZxfCbkUyNiMmIExOF8iPPE=;
        b=BqsRaXpLPDBV+f7jLdimuAKNgW57BuKTjJw+8KR8iAqMiAXCNy+f1/bOBbQDv93UZc
         mnP3SxFaxavAmuP0Jg2sxXxOQiaBBD/fzAUHFw8vi9stowEXoT7jTI3jM7n1tshvQJtl
         +2oTaBITgMAxYQm74x/p51XX5R64tR7Kg6II7RwvKE/52C1t4wDoWjirrKgJG9NrhCGg
         T+dcf3Ow0ZxQ6Un/9h3j32okmu0eQWYARSVzu36W2zoollCEMqR3Laz8yug4uOnK8Gxa
         5wsgnUZxUt1Tj4/0JR/076ISJtNtJzjNMdk/i/tulUHg/PlS/jm4BWkJ1pb3uk1M5eRZ
         9LnA==
X-Gm-Message-State: AOAM531+XLWdxY/8EeBdYLYuYLTbm4vcKnr22tNiBfM6laZ+RkaKnEpq
        3pjwl8IysDzWV3cVwZR4xQ==
X-Google-Smtp-Source: ABdhPJwQywTu4F9RwachS/Z+ymS39mbMLYXQjo/u7vJvvBOE89ll6PcoXARhA7T/H6EuKifCvUSMUQ==
X-Received: by 2002:a05:6830:14d4:b0:606:cc5:32cd with SMTP id t20-20020a05683014d400b006060cc532cdmr7035362otq.359.1651696277498;
        Wed, 04 May 2022 13:31:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u36-20020a05687004e400b000e932746d33sm8441359oam.28.2022.05.04.13.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 13:31:16 -0700 (PDT)
Received: (nullmailer pid 2175284 invoked by uid 1000);
        Wed, 04 May 2022 20:31:15 -0000
Date:   Wed, 4 May 2022 15:31:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, mka@chromium.org,
        linux-bluetooth@vger.kernel.org, quic_hemantg@quicinc.com,
        quic_saluvala@quicinc.com, quic_rjliao@quicinc.com,
        mcchou@chromium.org
Subject: Re: [PATCH v1 1/3] dt-bindings: net: bluetooth: Add wlan-gpio entry
 for wcn6750
Message-ID: <YnLik/JKsHs6yfwc@robh.at.kernel.org>
References: <1651228073-1999-1-git-send-email-quic_bgodavar@quicinc.com>
 <1651228073-1999-2-git-send-email-quic_bgodavar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651228073-1999-2-git-send-email-quic_bgodavar@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 03:57:51PM +0530, Balakrishna Godavarthi wrote:
> This patch adds a wlan-gpio entry and its reference usage for

wlan-gpios

> BT SoC wcn6750.
> 
> Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
> Signed-off-by: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml
> index f93c6e7..624f957 100644
> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml
> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.yaml
> @@ -24,6 +24,10 @@ properties:
>        - qcom,qca6390-bt
>        - qcom,wcn6750-bt
>  
> +  wlan-gpios:
> +    maxItems: 1
> +    description: gpio specifier used to wlan chip

How does one 'wlan' a chip?

> +
>    enable-gpios:
>      maxItems: 1
>      description: gpio specifier used to enable chip
> @@ -123,6 +127,7 @@ allOf:
>                - qcom,wcn6750-bt
>      then:
>        required:
> +        - wlan-gpios
>          - enable-gpios
>          - swctrl-gpios
>          - vddio-supply
> @@ -166,6 +171,7 @@ examples:
>              compatible = "qcom,wcn6750-bt";
>              pinctrl-names = "default";
>              pinctrl-0 = <&bt_en_default>;
> +            wlan-gpios = <&tlmm 84 GPIO_ACTIVE_HIGH>;
>              enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
>              swctrl-gpios = <&tlmm 86 GPIO_ACTIVE_HIGH>;
>              vddio-supply = <&vreg_l19b_1p8>;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> 
