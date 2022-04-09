Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A6C4FA708
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 13:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241516AbiDILLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 07:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiDILLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 07:11:15 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FC23CFF6;
        Sat,  9 Apr 2022 04:09:08 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id h63so13381011iof.12;
        Sat, 09 Apr 2022 04:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mXOsPOedrWh9JPnGJrDbvXsPmuz7lk7F3CL0nw828sw=;
        b=m2A7ZRg72dgIz2UJq8zLcB7VoF7QMuODyG1+HBaIOvauTFlbyi2qMpic9j414OaSqq
         l0da5dQ/6dzIz4qBihIVT/q06S/Z6vUgJOm8RbRA1jApzaTLAShm1ClXHrabBRa77pBK
         T9ss6qJ+01+7LYQyeev7QBA6S6w8vDAX9REGCejPL/0kmbPbQiawi78wnlyScM4sMGxM
         5jo3Ctm0UeJ+YUlrnk7YixcrMobzbf1LAHyHO+/wMtF9gf8AggEKWlrKVfIKApWICZJD
         L5db3ItCqChBzmhrNzgv2LKDqjT87kvzLRS4DEWX3bKd3aBFX0Wz4rxT8PYo32Hp9Yao
         bfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mXOsPOedrWh9JPnGJrDbvXsPmuz7lk7F3CL0nw828sw=;
        b=OK3MFx9vUILGDB80ylP9enc8LB40rOGPjwdgTluIItTKY7jwweHLnkxmG2uPlOJPh8
         eJT3IaMwloaACcQs0u6UDCqdnsdvqGO8U2OlTO+W5YvtWUU2M2ukKFc+JwCSFRE0mEbL
         mDnbkezWXxFdv6pP70cpFbt/W0wSiXt6RSsAEatntQl4i2yIFLwnh2UEZSX6lkIo9eNj
         VuvEDBr8SLkpBj8ggXFyfIYLNYQ0CefkUIONaN3eM1b1FzP/0GLrhybZ2fJYJSMZMHCN
         jutMG4UwBQpId0iOBG3y+O3KEUUh/0t9MCSsr5EGZoR2BXcFp3BoBmPoFHtGfIGt0jwe
         Gknw==
X-Gm-Message-State: AOAM531MztbNSmH1VC7Yv6aOx0LR/Vop82E80Q2k1WxuOxELPnvwA9IO
        0f4CbTsvK5ipifLHVUqBvL41PMetwCTGkTkHbQo=
X-Google-Smtp-Source: ABdhPJxaa0UopXfyxt0OHpLxN+9t8AjQXM2kRDcQzKG1MDoxOn+mEm/HNLg+P44PI8GuE2tZuhFkwUz4vdqaMPODdP0=
X-Received: by 2002:a02:8585:0:b0:321:440c:5e11 with SMTP id
 d5-20020a028585000000b00321440c5e11mr4532439jai.35.1649502548216; Sat, 09 Apr
 2022 04:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220407150652.21885-1-gch981213@gmail.com> <20220407150652.21885-2-gch981213@gmail.com>
 <20220408083214.1473e88a@xps13> <YlAqSQ5w3y39aOy+@sirena.org.uk>
In-Reply-To: <YlAqSQ5w3y39aOy+@sirena.org.uk>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Sat, 9 Apr 2022 19:08:57 +0800
Message-ID: <CAJsYDV+SkL0yCroidGz4yzKbdj5Yx37a0DW9RLftKsceSFGnnw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] mtd: nand: make mtk_ecc.c a separated module
To:     Mark Brown <broonie@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pratyush Yadav <p.yadav@ti.com>, Yu Kuai <yukuai3@huawei.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NAND FLASH SUBSYSTEM" <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark!

On Fri, Apr 8, 2022 at 8:28 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Apr 08, 2022 at 08:32:14AM +0200, Miquel Raynal wrote:
>
> > Otherwise on the MTD side the series looks good (besides the two
> > comments you already received).
>
> What's the plan for merging then?

I just tested this driver on a different chip and found out it's buggy
there. I'm still debugging.
Please wait for v5 of this series. Sorry.

-- 
Regards,
Chuanhong Guo
