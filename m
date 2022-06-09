Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3977E545363
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344524AbiFIRuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245151AbiFIRur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:50:47 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7628B1BD7C0;
        Thu,  9 Jun 2022 10:50:46 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id n11so3027127iod.4;
        Thu, 09 Jun 2022 10:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HnAifctYdNaT/poGeGfhLUmDWMrLaMg17cclIAxPNog=;
        b=QeOGzhY5q54w99bjRgmCaBoj0PV82iupiQKaQe4hSyywM6E7Q56l07cesrW95eygzb
         3rr6R8AgYMoWO/JtiDUxrYkai4NN8l29mPT8v4B3mFXY7gbq7Asbz0m9UZ+Qfv+D4/+T
         NmuTCUg2kBLT96axs7ODASiiXWy5AX/aCVKG94dbJZTdwszxc6Pqcg1q2uiHdgyAzmeD
         T1VfQnzd7cMTG6YoJcGioqMf0p3vS8ghrAI/c3AzzWzF6RJcQMmHnOI0hKSU0CU2asEE
         GICIVlQjvGTtofaJlBX5FCIioSJWf6xmNhsxpx+2++bS9OErtRxBQw2O3bqjiXHa7oBj
         T4WA==
X-Gm-Message-State: AOAM530nMZ+ZPxug2A/YvJtfQT0Y4CdsmM46LMFm3BYpRm/aA8yilHPL
        cQ999vi+/+elerL3gbM1xQ==
X-Google-Smtp-Source: ABdhPJxAiTUZAr56YxyBVP43w4ziAPRPbjtV7Scut9p9XeaOHBavU3f1WWiKaf+TI5dVsV/oPBVYzA==
X-Received: by 2002:a5d:88c8:0:b0:662:b25a:49b7 with SMTP id i8-20020a5d88c8000000b00662b25a49b7mr18756600iol.159.1654797045693;
        Thu, 09 Jun 2022 10:50:45 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id b28-20020a056638389c00b00331ab545889sm5305064jav.45.2022.06.09.10.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 10:50:45 -0700 (PDT)
Received: (nullmailer pid 4024412 invoked by uid 1000);
        Thu, 09 Jun 2022 17:50:42 -0000
Date:   Thu, 9 Jun 2022 11:50:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sjoerd Simons <sjoerd@collabora.com>
Cc:     linux-rockchip@lists.infradead.org, kernel@collabora.com,
        Akash Gajjar <akash@openedev.com>,
        Alex Bee <knaerzche@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Levin Du <djw@t-chip.com.cn>, Liang Chen <cl@rock-chips.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Peter Geis <pgwipeout@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: add ROCK Pi S DTS support
Message-ID: <20220609175042.GA4021841-robh@kernel.org>
References: <20220606082629.79682-1-sjoerd@collabora.com>
 <20220606082629.79682-2-sjoerd@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606082629.79682-2-sjoerd@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 10:26:27AM +0200, Sjoerd Simons wrote:
> From: Akash Gajjar <akash@openedev.com>
> 
> ROCK Pi S is RK3308 based SBC from radxa.com. ROCK Pi S has a,
> - 256MB/512MB DDR3 RAM
> - SD, NAND flash (optional on board 1/2/4/8Gb)
> - 100MB ethernet, PoE (optional)
> - Onboard 802.11 b/g/n wifi + Bluetooth 4.0 Module
> - USB2.0 Type-A HOST x1
> - USB3.0 Type-C OTG x1
> - 26-pin expansion header
> - USB Type-C DC 5V Power Supply
> 
> This patch enables
> - Console
> - NAND Flash
> - SD Card
> 
> Signed-off-by: Akash Gajjar <akash@openedev.com>
> [sjoerd: Sort dt nodes, drop properties duplicated from dtsi]
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> ---
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +

Bindings should be a separate patch.

>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3308-rock-pi-s.dts    | 204 ++++++++++++++++++
>  3 files changed, 210 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
