Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D9C582A35
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbiG0QD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbiG0QDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:03:23 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AE84A838;
        Wed, 27 Jul 2022 09:03:23 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id f8so835524ils.13;
        Wed, 27 Jul 2022 09:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wBsnIffBjiQs1dYf9x9tNvshsRG8mL+pqvf1EO0wYjk=;
        b=fCzXo09KDuA1Jam4oVPaStv29i6W9oYEW3rVDkII+q8Pg/Rwp3UemoYRTdmdeHmAyx
         SKvYQUxEhf8HbDQGMYCUIVyrpqR58mygd71w6F1eE7vfRbvwtoemEOci31DpW82mm4c3
         LUGhpfJxiytIbRaCKy0cUXCVKsIzHsze+Tb9p6Pcw1YCW3Pox+Xu5wBFbdFMaeJ9VuLF
         AAXMxEXusvCK/0SlxEb9igOqb3pjxAHdGDv9C9oUuNTqluLWA/I3V0TZ6e7XN78pEIuO
         0LeLetqBCqPA0HY1tjcaANRfHpO1dHydnbAynzC9caoLuEgnPCIQ7skbI56qPo40JSsu
         M25g==
X-Gm-Message-State: AJIora94+kFUhcZiIYTC+Rb/Zui3h5VvUifmpp12zcVwp1T0m3PT4clp
        GW+q9ZFQLHS8SghwOroEgw==
X-Google-Smtp-Source: AGRyM1tPmy1PxfqCjQmXrwzib4b/M/R/vQyHbMQ1eoFA6LUMW4jtRIa+FKY7nd88pa4eRIcxLfaDhg==
X-Received: by 2002:a05:6e02:1d1b:b0:2dc:dfac:6131 with SMTP id i27-20020a056e021d1b00b002dcdfac6131mr8892921ila.60.1658937802247;
        Wed, 27 Jul 2022 09:03:22 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m4-20020a02a144000000b0033eff75fb32sm7921295jah.15.2022.07.27.09.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:03:21 -0700 (PDT)
Received: (nullmailer pid 2758902 invoked by uid 1000);
        Wed, 27 Jul 2022 16:03:20 -0000
Date:   Wed, 27 Jul 2022 10:03:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bob Moragues <moragues@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moragues <moragues@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: document zoglin board
Message-ID: <20220727160320.GA2755147-robh@kernel.org>
References: <20220726212354.1.I5b9006878bdabd6493b866b46dbd6149968d545b@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726212354.1.I5b9006878bdabd6493b866b46dbd6149968d545b@changeid>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 09:24:31PM -0700, Bob Moragues wrote:
> Zoglin is a Hoglin Chromebook with SPI Flash reduced from 64MB to 8MB.
> Zoglin is identical to Hoglin except for the SPI Flash.
> The actual SPI Flash is dynamically probed at and not specified in DTS.
> 
> Signed-off-by: Bob Moragues <moragues@chromium.org>
> 
> Signed-off-by: Bob Moragues <moragues@google.com>
> ---
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 581485392404..63091df3cbb3 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -475,6 +475,7 @@ properties:
>  
>        - description: Qualcomm Technologies, Inc. sc7280 CRD platform (newest rev)
>          items:
> +          - const: google,zoglin
>            - const: google,hoglin
>            - const: qcom,sc7280

Is just "google,hoglin", "qcom,sc7280" no longer valid? If it is valid, 
you need another entry.

>  
> -- 
> 2.37.1.359.gd136c6c3e2-goog
> 
> 
