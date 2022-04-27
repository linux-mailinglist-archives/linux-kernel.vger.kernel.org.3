Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC40511A00
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbiD0OI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237145AbiD0OIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:08:21 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210BE4AE25;
        Wed, 27 Apr 2022 07:05:10 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-e93ff05b23so2013768fac.9;
        Wed, 27 Apr 2022 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3hAzmL94k6R9PwkKXXDpGCbbCeAgk5EGfllFRPaGn08=;
        b=HNvd+Ncao495WuWbhT8whxMuymyeDcIYnt+m0HM6k6KkBPP2Sh0pI9S6cJp6DT7HQD
         vCGkd+dNC+MMLnNUOXdJh1s2obJ/IBCUcb/I9sHpWnvraeIcZfBoLP8sB/M6uf5nuZUB
         jVg/y+edEM4PI/G6Eq825jjXMLiy7XTNGUwTa6VKaur4egl01rn38rNdslmGbFbJjdsa
         YaR6DQlWLLV15v5phbJgwas4qaXdBvfndEH0EIyeRnTzfTwonZ8Q/hEHPjPFQQ+R0xrE
         z5vql8ypg+IKoFcY13Rb8CLaOjyouSJ6LW8r9E31Ohf6QEYBEiY3TU4OYEhZC+4Jcc/j
         3gJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hAzmL94k6R9PwkKXXDpGCbbCeAgk5EGfllFRPaGn08=;
        b=UzCuMpIE/kwjUhSN8B2dYHj73uGMvQkx3+bJV9B1zt0sjyuq8xSCUla8F0NPkXgWNl
         cLcgEiXoQ7lFJSC8QBayx9aVxN9bu4iczn38zCWA+aMM50JLpabSqTxSV8EuAgCdh38o
         DjrievTCE/ZCaBG/KhPuntR/+vHomu+i2t1U/bQaxXOu3Jp8YV3S4A3gWtwDZYYincY1
         P8hnfsH7bJhwF18uJZ8ZRIRkSbATnyuhP7rt8bITqENJcnL1wDO804xKYyYi3B3uhhZm
         0kvV8566WRkSgLPUhdMc6q+Q9xRDXH0UkBgZoG0VM5ZeDtknAyLKJiR3BmVRlKXZW0k7
         PZMw==
X-Gm-Message-State: AOAM530tYknnwwWtqVbcvckp/dMZKVrV+gyhvpzfMDxjOI22AQUcNYAD
        xsr6aSvj4et1Xa6n6SMmvb5AAQhdfVkbx0NVz6s=
X-Google-Smtp-Source: ABdhPJyJ03JPry6wbVQvJLHPYEG6SEWlxtrv4m0q9UnxBaFVB1qV8pE7PrJeQOeOS/99rpb2LllTG2sPJShUFpwQQz0=
X-Received: by 2002:a05:6871:824:b0:e9:1a6c:1e76 with SMTP id
 q36-20020a056871082400b000e91a6c1e76mr8582101oap.98.1651068309461; Wed, 27
 Apr 2022 07:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220424032527.673605-1-gch981213@gmail.com> <20220427112857.7ddd7fc8@xps13>
In-Reply-To: <20220427112857.7ddd7fc8@xps13>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Wed, 27 Apr 2022 22:04:57 +0800
Message-ID: <CAJsYDV+DfBEmWr7D1aO8F=3WMurAg6aEhf5gY86BXOUSyJ2nXA@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] spi: add support for Mediatek SPI-NAND controller
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel!

On Wed, Apr 27, 2022 at 5:29 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> [...]
>
> The patch actually look independent, so if it's fine for you I can take
> the two mtd patches and let you merge the spi/binding changes.

Out of curiosity:
Wouldn't that break the build for spi subsystem? Because...

> >  rename drivers/mtd/nand/raw/mtk_ecc.h => include/linux/mtd/nand-ecc-mtk.h (100%)

The spi driver needs this header file which is moved in the mtd patch.

-- 
Regards,
Chuanhong Guo
