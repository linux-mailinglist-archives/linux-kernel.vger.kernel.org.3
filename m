Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3E64EB66D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbiC2XCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239217AbiC2XCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:02:35 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E019A4E3A8;
        Tue, 29 Mar 2022 16:00:49 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id p10-20020a056820044a00b00320d7d4af22so3330774oou.4;
        Tue, 29 Mar 2022 16:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0ufsH4kPmkwYwUY4XrUsn1zP4xDV7A/GblHEkZpfic4=;
        b=wY9q5p2BWT09dM4HY7NO7JepkpuzMT6AjkaCbJp959bQNLoL3gGhe192v7LV+I2nRM
         veiO9umvfkAuPkSuxvFwZY2TqJp58UrJC/mf2Z/SDqukoni6nFGqAbYcM8Dv88EK9ECx
         2MswD06F7wQyQnhyplFRXbJvmAc2gMI4qDLm//kdGF+lcqzXWAzC53R9LLNfu5DXpeRX
         MJTDc395F0hPpPA25dby3gQqDyDfdBA8o0m7ZN1bGm9yMCIPk2Ee1j7ONyZFUo1L7wES
         EbC1WMqWDvCHpYEvXpl+ZoH93IL6lwFxyM6hHT3RjeU/YAj6/J/Cmd/rG0y2xJxEBvRl
         j1cw==
X-Gm-Message-State: AOAM531clsUXr3DbCF88FrjM/GNdg4X+5Sjy6VsvXEZOfjYt1EzQFPnm
        bxJ1bsP4I+DO8CmSaGVMIQ==
X-Google-Smtp-Source: ABdhPJy7C1m1dEvCRktWVO5I/Fo2UO/XKIY/6vOY1H7aF/ef2qykqq61ZyIH386G0Fd71hfq7+6S8w==
X-Received: by 2002:a4a:2f0f:0:b0:320:f7cd:58d2 with SMTP id p15-20020a4a2f0f000000b00320f7cd58d2mr1912170oop.85.1648594849162;
        Tue, 29 Mar 2022 16:00:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m17-20020a0568301e7100b005b256697d7csm9487340otr.72.2022.03.29.16.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:00:48 -0700 (PDT)
Received: (nullmailer pid 1509915 invoked by uid 1000);
        Tue, 29 Mar 2022 23:00:46 -0000
Date:   Tue, 29 Mar 2022 18:00:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     Tian Tao <tiantao6@hisilicon.com>,
        Satya Tangirala <satyat@google.com>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mediatek@lists.infradead.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        angelogioacchino.delregno@collabora.com,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        devicetree@vger.kernel.org, Yue Hu <huyue2@yulong.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Lucas Stach <dev@lynxeye.de>
Subject: Re: [PATCH v9 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and
 pinctrls properties
Message-ID: <YkOPnkFz2DDx7Qr0@robh.at.kernel.org>
References: <20220329032913.8750-1-axe.yang@mediatek.com>
 <20220329032913.8750-2-axe.yang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329032913.8750-2-axe.yang@mediatek.com>
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

On Tue, 29 Mar 2022 11:29:11 +0800, Axe Yang wrote:
> Extend interrupts and pinctrls for SDIO wakeup interrupt feature.
> This feature allow SDIO devices alarm asynchronous interrupt to host
> even when host stop providing clock to SDIO card. An extra wakeup
> interrupt and pinctrl states for SDIO DAT1 pin state switching are
> required in this scenario.
> 
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> ---
>  .../devicetree/bindings/mmc/mtk-sd.yaml         | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
