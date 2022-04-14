Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94C0501CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 22:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346285AbiDNUbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 16:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240868AbiDNUbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 16:31:18 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3790BF65
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:28:50 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220414202846euoutp010ea754926acd9695bc4e12b4c19aba5d~l3UTTjLOc1079610796euoutp01P
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 20:28:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220414202846euoutp010ea754926acd9695bc4e12b4c19aba5d~l3UTTjLOc1079610796euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649968126;
        bh=8fopOn+BsG7tgfdIJWaWqZa9LoS6fiCnp9r6pVMlrLo=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=lGzIAFoRzGM0K8CDIloPGLBAq6QugELNKmqT3RSYX/aGzL/fp1z6I5Ix8K8QBTAkm
         upwvR7yFhOqJM4GXdWMXRWZeFNUTiyd2BekjAW6exetaR/YdbxHlEjgo1khUcLsYiT
         0EAPBIb673/JUUWP4QRHWIGdyVjdnEEB3Z5ZaKu4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220414202844eucas1p2415e652f3dbef83d0ac0de25e4a1b127~l3USEfTvV0184801848eucas1p2R;
        Thu, 14 Apr 2022 20:28:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B7.6E.10260.CF388526; Thu, 14
        Apr 2022 21:28:44 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220414202843eucas1p211113b6c9c721a3b9c3b76efe16189e5~l3UQblGKX2534925349eucas1p2c;
        Thu, 14 Apr 2022 20:28:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220414202843eusmtrp24a5806523eb0c59e4bbcb18c74edf499~l3UQa0YQG2678226782eusmtrp2A;
        Thu, 14 Apr 2022 20:28:43 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-c0-625883fc22d0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AC.B8.09522.AF388526; Thu, 14
        Apr 2022 21:28:42 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220414202842eusmtip18ae7d76fd80e5de47f1e1bc9fa467bb3~l3UPpuMN31818618186eusmtip13;
        Thu, 14 Apr 2022 20:28:42 +0000 (GMT)
Message-ID: <2f0f0bf4-ceb7-b226-dd76-aea64ee517c4@samsung.com>
Date:   Thu, 14 Apr 2022 22:28:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v5 0/6] gpiolib: more helpers and fwnode conversion
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220414190242.22178-1-andriy.shevchenko@linux.intel.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7djP87p/miOSDLY+0bc4f/cQs0Vv03Qm
        i10PtrFZzFlRafHm0RFmi5/tW5gspvxZzmSxYDa3xabH11gtNs//w2hxedccNotji06yWBzq
        i7Z4/9PRgc/j/Y1Wdo/F126zesxbU+2xc9Zddo+nEyaze9y5tofNY97JQI/NS+o9du74zOTx
        eZNcAFcUl01Kak5mWWqRvl0CV0br0c/sBZ8lKpY/3MXUwHhAuIuRk0NCwETi/PcdzF2MXBxC
        AisYJea+W8IG4XxhlPj1eCojhPOZUeLvmV/sMC1n575hhUgsZ5T403CACcL5yCjxaNFZVpAq
        XgE7icbnH5hBbBYBVYm2J4vZIeKCEidnPmEBsUUFkiTm7rsHViMs4C7x8chCJhCbWUBc4taT
        +WBDRQReMUqcnL2DDSLxjEnifGMsiM0mYCjR9bYLLM4J1Hz70W2oGnmJ7W/ngH0kIbCeU+Ls
        31dAT3AAOS4S99fVQLwgLPHq+Baod2Qk/u8EWQZSki/xd4YxRLhC4trrNcwQtrXEnXO/2EBK
        mAU0Jdbv0ocIO0rM3rAXqpNP4sZbQYgD+CQmbZvODBHmlehoE4KoVpOYdXwd3M6DFy4xT2BU
        moUUJrOQ/D4LySuzEPYuYGRZxSieWlqcm55abJyXWq5XnJhbXJqXrpecn7uJEZjqTv87/nUH
        44pXH/UOMTJxMB5ilOBgVhLhvdkfniTEm5JYWZValB9fVJqTWnyIUZqDRUmcNzlzQ6KQQHpi
        SWp2ampBahFMlomDU6qBSb3hPKP9ttq6lc9v61gefPlsTcjGXeu0PFR3i+tZP87lXch13Kzo
        6vsLl5Kfnb+QtGJuRptk6pMpjM91wzr4/RS84rkffGBKWqk8wWOSSQffYS1PuU9RCx+dXRg2
        tSP1jM0q3aAsztNrb2t8WFy+bYvAEma2PyI34pg4s34EdUw/Lx0qx6l6xDy8ric/2P7epIf+
        h4WWz54quG7Fhrwczzmny05qlTIe+3qM/+C6Y884Hv/bVFQucfyc0Yrfy/T+vFu/Uzdov+wt
        zjOLWEOuVrCEf4tYpZNx/4/YziCpt/maL9o4H09it5HvVjWJmrc26nd6idysjxuPz7rnufpM
        o6NL3MxEy8B7Bbe8viw6ckiJpTgj0VCLuag4EQCJLy1D5AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsVy+t/xu7q/miOSDHYstbE4f/cQs0Vv03Qm
        i10PtrFZzFlRafHm0RFmi5/tW5gspvxZzmSxYDa3xabH11gtNs//w2hxedccNotji06yWBzq
        i7Z4/9PRgc/j/Y1Wdo/F126zesxbU+2xc9Zddo+nEyaze9y5tofNY97JQI/NS+o9du74zOTx
        eZNcAFeUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2C
        Xkbr0c/sBZ8lKpY/3MXUwHhAuIuRk0NCwETi7Nw3rF2MXBxCAksZJVZO2sMOkZCRODmtgRXC
        Fpb4c62LDaLoPaPEiUVHmEESvAJ2Eo3PP4DZLAKqEm1PFrNDxAUlTs58wgJiiwokSbzY9pwR
        xBYWcJf4eGQhE4jNLCAucevJfCaQoSICrxglLk14zA7iMAs8Y5JYsWsqE8S6WYwSW06dAWtn
        EzCU6HoLcgcnByfQqNuPbrNBjDKT6NraxQhhy0tsfzuHeQKj0Cwkl8xCsnEWkpZZSFoWMLKs
        YhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIzybcd+bt7BOO/VR71DjEwcjIcYJTiYlUR4b/aH
        JwnxpiRWVqUW5ccXleakFh9iNAUGx0RmKdHkfGCaySuJNzQzMDU0MbM0MLU0M1YS5/Us6EgU
        EkhPLEnNTk0tSC2C6WPi4JRqYDKZlnORpyx3/Yc+qYz+r8rlk3ftTkkMVGCUtnFdp8oUc+77
        +klzOrtVrRMPpG+u3f3PZ42fceOi2ZuDiz8oayrr2t8sOmPt/V9Nel7rgf8RPtVbd7pIBITJ
        2ap5mqdcmCuRONFs9Yy/u+auXf/FUS8hosCkcd7Ze6bm7Lo/z6Uw6T6aUTLx4DuZwirBGYel
        k2N9bZjF/pXO8UrJbixiiOCcHProJ9O5I082lJ9QSGRR/W58+sLefZlGVyMY1NNYO6fsVa0M
        +BX6hjmM+di0O7mZAt/45Vhf3fkQa13JIyx5ttKJ7QXXCbnDnBMsN9nuXrh4/QKWxg+ubbKL
        3fZqbOLu6o9MmnYn4MSXyMUXlViKMxINtZiLihMBR+HmjHsDAAA=
X-CMS-MailID: 20220414202843eucas1p211113b6c9c721a3b9c3b76efe16189e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220414190251eucas1p1ef520fa995057550fa533eb34a02ae63
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220414190251eucas1p1ef520fa995057550fa533eb34a02ae63
References: <CGME20220414190251eucas1p1ef520fa995057550fa533eb34a02ae63@eucas1p1.samsung.com>
        <20220414190242.22178-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 14.04.2022 21:02, Andy Shevchenko wrote:
> This is a spin-off (*) of the previous work of switching GPIO library
> to use fwnode instead of of_node. Here we introduce a couple of
> a new macro helpers, which allows to switch some of the drivers
> to use fwnode and partially fwnode APIs. As a result of this cleanup
> a few drivers switched to use GPIO fwnode instead of of_node.
>
> *) it's subset of it with a new (patch 1) helper.
>
> Marek, Martin, can you give this a try?
> This requires at least two patches for GPIO library to be applied.

I've applied patch #1 and #6 on top of linux next-20220413 with commit 
88834c75cae5 ("pinctrl: meson: Replace custom code by 
gpiochip_node_count() call") reverted. All my Meson-based test boards 
(Odroid C4, N2, Khadas VIM3/3l) work fine now. Thanks! Feel free to add:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> Bart, Linus, I can take it thru my tree with an immutable branch if
> it's the way you prefer, otherwise please suggest on how to proceed.
>
> Changelog v5:
> - dropped tested patches (this series based on them, though)
> - introduced a new helper (thanks Marek and Martin for reporting an issue)
> - redone Armada and Meson code using newly introduced helper
>
> Changelog v4:
> - fixed compilation of the Samsung pin control drivers (LKP)
> - explained in the commit message why namespacing is good for meson defs
> - added tag to one of meson patches (Neil)
>
> Changelog v3:
> - moved count initialization to the definition in patch 2 (Geert)
> - replaced of_args by args, used %pfwP in patch 7 (Geert)
> - fixed kernel doc warning in patch 7
> - added tags to patches 1, 2, 6, and 7 (Geert)
> - added tag to patch 4 (Fabien)
> - renamed MREG to MESON_REG in patch 9 (Neil)
> - added tag to patch 10 (Neil)
> - used --base for cover-letter
>
> Changelog v2:
> - properly based, so kbuild bot may test it (LKP)
> - fixed typo in the macro (Geert)
> - split to two macro helpers and rename the gpiochip_count()
> - tagged one of stm32 and one of meson patches (Fabien, Neil)
> - unified previously standalone armada patch
> - due to above rewrote the armada patch from v1 completely (Sergey)
> - added a lot of a new patches
> - compile tested all of them on x86
>
> Andy Shevchenko (6):
>    gpiolib: Introduce a helper to get first GPIO controller node
>    pinctrl: armada-37xx: Switch to use fwnode instead of of_node
>    pinctrl: armada-37xx: Reuse GPIO fwnode in
>      armada_37xx_irqchip_register()
>    pinctrl: meson: Rename REG_* to MESON_REG_*
>    pinctrl: meson: Enable COMPILE_TEST
>    pinctrl: meson: Replace custom code by gpiochip_node_count() call
>
>   drivers/pinctrl/meson/Kconfig               |  2 +-
>   drivers/pinctrl/meson/pinctrl-meson.c       | 52 ++++++++++-----------
>   drivers/pinctrl/meson/pinctrl-meson.h       | 28 +++++------
>   drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 34 ++++----------
>   include/linux/gpio/driver.h                 | 10 ++++
>   5 files changed, 59 insertions(+), 67 deletions(-)
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

