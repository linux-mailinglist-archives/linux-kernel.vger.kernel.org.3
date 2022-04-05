Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA4D4F4E48
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1588644AbiDFAQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1450182AbiDEPvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:51:19 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607491BA46F;
        Tue,  5 Apr 2022 07:39:40 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id 8so9358288ilq.4;
        Tue, 05 Apr 2022 07:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u/cO9n221kA+5ADZGdYnf+fYVWdb03GaAd0bxZEtbWk=;
        b=MzQwaTornZRnR7GuZfl0GZwph6GH8tWgEbCituXvQX40VL/XmXvrRmKIQY6iKlsfSa
         0Dv9GxL9KDMnR0Tot7B+e8OibqFGRTemBt5ikaubRHbq3SG4nIFZwSiXe9i93yqv1tYS
         j8Cdxq/NQ4CM47pBPl8gxNP9vigDbtE6S9Sf3GkxlUO+7SDmtzt1dGtJPAGjs/9NyIJh
         GzD6CqSrVRfr0Hx9po1gGBbuQLtPvpAAGbH9uwGR3hMO5aIBmlwrfHtccEi60hUKZ4ak
         p82hT8o9SsUDJh+bfE6Pg08evMuzcL3YrAxRem7+SCLg5D2RPDdot+Nn3iAzkJC31ZZl
         Bhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u/cO9n221kA+5ADZGdYnf+fYVWdb03GaAd0bxZEtbWk=;
        b=sb79zo1q+vhylwK6Z8mg+74qTVaRH7oe7UTyH/8atWTlNWRPtnyA15rl2PoSuitebv
         cv7qLJ2ydTJ1BN+Osq+4T+k+QWRnaIeSiYj9TQLbgUiEwpoWvu6S0eVupGHxJBebRHRh
         D9lgvBnsSL6lLwOO7oSTu2gHYFWxowu4zvAjTPwpw69jQUIS3u3HZ5UCrHu5Y4pDsziq
         bdmEWbQlbHmE42AN/VTKN9V95NbKExJfhrdJ5mLKbTCUW9M012ca2VA8d7O7wgo69dKg
         6zomPs1p2WXtxoGKeI9a82REnX2FuAOfaPdxgKMeyW7PTyYzl94VVYaXARYsoyVEv7iI
         r0vQ==
X-Gm-Message-State: AOAM5337T0DfG8d4FVKFsYsSgpe/bKztMY1JGkpowVKw5hJa2bZb+e1W
        UDTzLRVeGZ7KPAGbyF6lFnHC3x4DCjTzQ0QVJY0=
X-Google-Smtp-Source: ABdhPJyLSwS3gzvbWUvgnsZHY5oFlCEmIY5mpJYVzgiyLEFiDb2hEM9naW3CpjZf8nK9nUhDxM162/gpsl29HLJzf30=
X-Received: by 2002:a92:3405:0:b0:2c8:70ad:fa86 with SMTP id
 b5-20020a923405000000b002c870adfa86mr1949268ila.268.1649169579699; Tue, 05
 Apr 2022 07:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220404131818.1817794-1-gch981213@gmail.com> <20220404131818.1817794-5-gch981213@gmail.com>
 <1649088538.050456.1436949.nullmailer@robh.at.kernel.org> <CAJsYDVLaXAoL=TcPun6rckcA_cdUS-zFy_7M6uCpfzX+jbQEag@mail.gmail.com>
 <20220405092024.25d97c33@xps13>
In-Reply-To: <20220405092024.25d97c33@xps13>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Tue, 5 Apr 2022 22:39:28 +0800
Message-ID: <CAJsYDVKVaZtrUr5C_BCr+oVECJ1xJwfh5TOMpo-w3xgkYCBYSQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] dt-bindings: spi: add binding doc for spi-mtk-snfi
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-spi@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Pratyush Yadav <p.yadav@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Roger Quadros <rogerq@kernel.org>,
        Yu Kuai <yukuai3@huawei.com>,
        linux-mediatek@lists.infradead.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-mtd@lists.infradead.org
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

Hi!

On Tue, Apr 5, 2022 at 3:20 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> You can try including spi-nand.yaml (like you do with
> spi-controller.yaml). You should no longer need to define
> nand-ecc-engine then as it is already described there?

This doesn't work. I added
- $ref: /schemas/mtd/spi-nand.yaml#
to the allOf property and dt_binding_check complains the following:

Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.example.dtb:
spi@1100d000: compatible:0: 'spi-nand' was expected
From schema: /home/user/src/kernels/linux/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml

BTW I still can't get dt_binding_check to complain anything about
spi-nand. Here's the command I used:

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- DT_CHECKER_FLAGS=-m
dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml

-- 
Regards,
Chuanhong Guo
