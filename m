Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E4553AFA1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiFAUww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiFAUwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:52:17 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CCF65E4;
        Wed,  1 Jun 2022 13:52:04 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-f33f0f5b1dso4295949fac.8;
        Wed, 01 Jun 2022 13:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gn5G0sk6V7ansC6nBxDu6+mXNt9uJIpkYkYkuE5zjDs=;
        b=WyUKnG4lGjxLKBmD82qOADKFTT/PT9SIY8RJQQYPlMlQ91NR1NXyF9daoejumGt2i/
         IJ87DJC2b24QBJXy50gBn8et3d9g/4JunBK+5jkc+pRNSsbeCLh8+oS3W4f2fqwQ+p3+
         cUJ4+Eo9o/u1NLSrSDTsW2r6WjLMlJ/cV/yCIalaJQ3wKgFB+Je02BRS3wGsP9QPfjpU
         19jaUV6n+I4SyLOn7vmOEdO7yZ8WsUpxf74MrhkMbSFQqQ0RVsUx5P0O1zSO0dZiBbTY
         BbREAfUt6T+iv0wq7JW1EXkHNCRtZ/B4+YLnedTns49z+0L4YuURaF7dlkFaGOZfIE3I
         x5Rw==
X-Gm-Message-State: AOAM5305WkJK2Ux4SNZpyMuCmX+OacvafIeahwwriIL/xaetzGupaDNj
        QymyU0UrpnD5LLnrB0nVsdhGOhNAxQ==
X-Google-Smtp-Source: ABdhPJwAJpzi0PcdaldTmKtUN95zZ7XXm0EePIpfGX5LC4bNAZ845Iwj0Rw0ZOPMk6mqDxpbS339oA==
X-Received: by 2002:aca:f143:0:b0:32b:dc40:c1c4 with SMTP id p64-20020acaf143000000b0032bdc40c1c4mr12678221oih.293.1654113065824;
        Wed, 01 Jun 2022 12:51:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bc32-20020a05682016a000b0035eb4e5a6dasm1361259oob.48.2022.06.01.12.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 12:51:05 -0700 (PDT)
Received: (nullmailer pid 320227 invoked by uid 1000);
        Wed, 01 Jun 2022 19:51:04 -0000
Date:   Wed, 1 Jun 2022 14:51:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        Kelvin Zhang <kelvin.zhang@amlogic.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: nand: meson: fix meson nfc clock
Message-ID: <20220601195104.GA320194-robh@kernel.org>
References: <20220513123404.48513-1-liang.yang@amlogic.com>
 <20220513123404.48513-2-liang.yang@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513123404.48513-2-liang.yang@amlogic.com>
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

On Fri, 13 May 2022 20:34:01 +0800, Liang Yang wrote:
> EMMC and NAND have the same clock control register named 'SD_EMMC_CLOCK'
> which is defined in EMMC port internally. bit0~5 of 'SD_EMMC_CLOCK' is
> the divider and bit6~7 is the mux for fix pll and xtal. At the beginning,
> a common MMC and NAND sub-clock was discussed and planed to be implemented
> as NFC clock provider, but now this series of patches of a common MMC and
> NAND sub-clock are never being accepted and the current binding was never
> valid. the reasons are:
> 1. EMMC and NAND, which are mutually exclusive anyway
> 2. coupling the EMMC and NAND.
> 3. it seems that a common MMC and NAND sub-clock is over engineered.
> and let us see the link for more information:
> https://lore.kernel.org/all/20220121074508.42168-5-liang.yang@amlogic.com
> so The meson nfc can't work now, let us rework the clock.
> 
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> ---
>  .../bindings/mtd/amlogic,meson-nand.txt       | 29 ++++++++-----------
>  1 file changed, 12 insertions(+), 17 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
