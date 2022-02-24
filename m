Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683B44C3680
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbiBXUGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiBXUF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:05:58 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C39A2763E2;
        Thu, 24 Feb 2022 12:05:28 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id z7so4655262oid.4;
        Thu, 24 Feb 2022 12:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EwIjA2cxi6Zdyhj63jC+/ls8eLXGyDyFeI0zXBrFAkQ=;
        b=aCkUbo7c+1hJNe75gFl9xCLsIMg62YGtGXguDrLa0lUOCfjMEcPKlBjykEHLHJFkev
         U5SsHLghXYX61iCJdHxl2Yi0e8p27Dui/adGNG0kRm9SH7O2XRQf9b74ivifisA6azPb
         98oyfccHHvuxcRyETV1xgr/4Q5yCAcwYAObLT/NcuGrY05S2hhJCLQ5Co1bmFNT6sgLc
         i2lucYteRdUJjQ/DmbLik8i2OOaYdzO8dXP8boYR9w0TIfpIi+NN1JGMFwCj+wFFI1Si
         gAiFsEkMEHcxo9Vx66YZ2N64kXMPnTlvZEGUxsBwkn2uTuyN86p6g7SM4b1+AsIDV/D5
         yNpw==
X-Gm-Message-State: AOAM532BzqJBfRrNXo8siHY2sA8bBSzjJAZ/JD4ilsFwgoBKHe06pjfM
        pHPcR+qQmNVKTwYxNBLYRA==
X-Google-Smtp-Source: ABdhPJyjQU+gebS9JGc2UZ/FTDV4dMqOLrfIbq7JvO5O6KblWMX8vIYvqv+UcWPwoh5gzByfhx3U6w==
X-Received: by 2002:a05:6871:419c:b0:d6:e34d:b206 with SMTP id lc28-20020a056871419c00b000d6e34db206mr26562oab.170.1645733127913;
        Thu, 24 Feb 2022 12:05:27 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id ep36-20020a056870a9a400b000d6bd82a92fsm394811oab.18.2022.02.24.12.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:05:27 -0800 (PST)
Received: (nullmailer pid 3498178 invoked by uid 1000);
        Thu, 24 Feb 2022 20:05:24 -0000
Date:   Thu, 24 Feb 2022 14:05:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        jassisinghbrar@gmail.com, manivannan.sadhasivam@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: mailbox: Add binding for SDX65 APCS
Message-ID: <YhflBNX/iRsC8LBq@robh.at.kernel.org>
References: <1645420953-21176-1-git-send-email-quic_rohiagar@quicinc.com>
 <1645420953-21176-2-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645420953-21176-2-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:52:27AM +0530, Rohit Agarwal wrote:
> Add devicetree YAML binding for SDX65 APCS GCC block. The APCS block
> acts as the mailbox controller and also provides a clock output and
> takes 3 clock sources (pll, aux, ref) as input.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> index 01e9d91..688ae8b 100644
> --- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> @@ -91,6 +91,7 @@ allOf:
>          compatible:
>            enum:
>              - qcom,sdx55-apcs-gcc
> +            - qcom,sdx65-apcs-gcc

Did you test this on your dts file? This doesn't work. You need to also 
add the compatible to the main 'compatible' schema.

>      then:
>        properties:
>          clocks:
> -- 
> 2.7.4
> 
> 
