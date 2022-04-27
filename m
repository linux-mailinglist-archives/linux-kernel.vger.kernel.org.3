Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C4251214E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiD0SoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiD0Snl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:43:41 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96117E49FC;
        Wed, 27 Apr 2022 11:24:32 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-e2fa360f6dso2864024fac.2;
        Wed, 27 Apr 2022 11:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c/GnVwnwo3swW/L/hGOyOJtE6p0V0pOOR6iVj+FsDdg=;
        b=cwIdCPKZ91V+jL/RXBOmlwHxXfGYs4sS0tgW9VFwFmAthi+vPyG+9EAiKUOVw+n4pM
         vDgh4Do5W5nC6uEVU/Yp3G0p5imu7kmEMPY23+0GRmCmur/Aol7QyoUi6xHkivNPshRQ
         83pOdJCN54ZEL40OfJbJweswbr34eQJI3BLHIgih4UCxgYoNEbuiZtnPw8sRx+2mNsEO
         iIFO7j+9uYcWZsAoDwwPj31cyDiKBoOS8BUavMDyeRvobt34eQytMSCKU+kmlgUPdlNe
         Qpw0TCnHH8sm+UjnTbuPTnJc9SgyWhGk7A+CzK3Wg4XhD8j+IqzH9MQSRahc0gT+Qkwt
         5KHw==
X-Gm-Message-State: AOAM533TGzqSM+gbLWoA8Ybj+2S/NZkSZoX3/KuTOdkBjsMX8ec8sGzA
        /cUQirZDh7ZXj2R4H6z4euzRwTW/Mg==
X-Google-Smtp-Source: ABdhPJy3516HzZA9HqzDNS3+2KEHA9tbv+VMkBH8NqyFmymWYl8qrC2BTdv1Cci5bujI6bC3dRkaCA==
X-Received: by 2002:a05:6871:89e:b0:e9:5368:10ed with SMTP id r30-20020a056871089e00b000e9536810edmr5840479oaq.182.1651083871893;
        Wed, 27 Apr 2022 11:24:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id eg20-20020a056870989400b000e686d1387asm972903oab.20.2022.04.27.11.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:24:31 -0700 (PDT)
Received: (nullmailer pid 406603 invoked by uid 1000);
        Wed, 27 Apr 2022 18:24:30 -0000
Date:   Wed, 27 Apr 2022 13:24:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jan Kotas <jank@cadence.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH] dt-bindings: ufs: cdns,ufshc: Add power-domains
Message-ID: <YmmKXqIRrXWJ1wvD@robh.at.kernel.org>
References: <20220427065802.110402-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427065802.110402-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 08:58:02 +0200, Krzysztof Kozlowski wrote:
> The Cadence UFS controller can be part of power domain (as it is in
> example DTS of TI J721e UFS Host Controller Glue), so allow such
> property.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks!
