Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB015B0926
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiIGPso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiIGPsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:48:37 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0B2BB00B;
        Wed,  7 Sep 2022 08:48:33 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1280590722dso3558437fac.1;
        Wed, 07 Sep 2022 08:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=CxhmrY80LncaSEn1EseeN0fy0N0jYIOVE/tTa7fzMNI=;
        b=ATdhzi4St7EhYVQEYbImlKHcBvHOK429YmeN7T1+UOAotdqHA6bv+0x9SjLiM7isDX
         P7PFT0Ab2SnfTyYgnH4Syj3HvtLP/ClrWDL5FhhowIfmBrwZaPzn/SSlO6tK32g+hsKP
         3nLLHrdopWCAxbLt5V8lqGkwl4nG5ysht6RMR+BMNoIhIBwzCea3h1bxBWqsBtjdZHUe
         8dMOkHwi8qJvYFjcr6FIJlRimZcs44YiRjwJLF8pZXodhayfRHC5v017nTwhn/0xv37D
         aK4SOGTJV1ewXg9E148vpL8+8glyHXbSrZBhkal32zmrcQiZXpoxBMzaFjAUNdvSOjrz
         eI9g==
X-Gm-Message-State: ACgBeo1YPaWJSP1k2dtMvMNRuX1gKvzsKFryPN4tHgAdVNQ37HGB1Ldj
        YFkH8aVEG1ocxuHIZj84mA==
X-Google-Smtp-Source: AA6agR5VT35lZ6gh3xyi3vhkqFTWcr8X9GgGQ+1WGG/fYM0i48irlZ8x/DTl4QwUjjnqHYchMKky3A==
X-Received: by 2002:a05:6808:2017:b0:345:c5b4:49c3 with SMTP id q23-20020a056808201700b00345c5b449c3mr12079334oiw.212.1662565712412;
        Wed, 07 Sep 2022 08:48:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k14-20020a056870148e00b00127d2005ea1sm2130916oab.18.2022.09.07.08.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 08:48:32 -0700 (PDT)
Received: (nullmailer pid 3515562 invoked by uid 1000);
        Wed, 07 Sep 2022 15:48:31 -0000
Date:   Wed, 7 Sep 2022 10:48:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Georgi Djakov <djakov@kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [RESEND PATCH] dt-bindings: interconnect: fsl,imx8m-noc: drop
 Leonard Crestez
Message-ID: <20220907154831.GA3515480-robh@kernel.org>
References: <20220907120452.52161-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907120452.52161-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 07 Sep 2022 14:04:52 +0200, Krzysztof Kozlowski wrote:
> Emails to Leonard Crestez bounce ("550 5.4.1 Recipient address rejected:
> Access denied:), so change maintainer to Peng Fan from NXP.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Peng Fan <peng.fan@nxp.com>
> 
> ---
> 
> Resend with ack.
> ---
>  .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
