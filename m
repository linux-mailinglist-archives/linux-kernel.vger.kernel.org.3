Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0409525EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378975AbiEMJSk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 May 2022 05:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378971AbiEMJSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:18:33 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5A15E74C;
        Fri, 13 May 2022 02:18:29 -0700 (PDT)
Received: from mail-yb1-f180.google.com ([209.85.219.180]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MmyzH-1oEZVb0Kt5-00kAoY; Fri, 13 May 2022 11:18:28 +0200
Received: by mail-yb1-f180.google.com with SMTP id y76so14329357ybe.1;
        Fri, 13 May 2022 02:18:27 -0700 (PDT)
X-Gm-Message-State: AOAM5303CDn8ppRYW2dEw2sBsvsw96NIHrE3XqPvmxdto69Pb3zIC8ij
        GYbSIhFCjvqKG2XEbMD9CMzf37dK4572NFyJ3ps=
X-Google-Smtp-Source: ABdhPJzWhKU1AHupx7S1zjfD+kxbZoybdLGRgPZF8fYtv0ubcCFBrL+uhzTP2ciCWXA+iR8431cs7DZFsZ/UlHLEmLQ=
X-Received: by 2002:a25:d3c2:0:b0:645:74df:f43d with SMTP id
 e185-20020a25d3c2000000b0064574dff43dmr3753633ybf.394.1652433506801; Fri, 13
 May 2022 02:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220506085815.5a3cfa83@canb.auug.org.au> <20220513172933.5dbf4ffb@canb.auug.org.au>
In-Reply-To: <20220513172933.5dbf4ffb@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 May 2022 11:18:10 +0200
X-Gmail-Original-Message-ID: <CAK8P3a27bPttwrOBKPwNZ=B1zGZqKV=Js-zWcO7ofnqc=xyHQA@mail.gmail.com>
Message-ID: <CAK8P3a27bPttwrOBKPwNZ=B1zGZqKV=Js-zWcO7ofnqc=xyHQA@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:zuEH0IY2nkJkL6fmf+tietaTulDelKeKaN5PE7gswSn1OztESPM
 6CqUWeuUmdwwZ/v9FqSrFc0zXi4ZDMqo2nO3SO+P2d/VYes0PXmQFvgVSwTOgUoMHMY/Kag
 Ckr5PAzdHsTdBTtqiW4Dz7+uWOU0RP03I8FoPOM0anCLksdHh7sXA0SpZD+2pkLGs4EmxdC
 sY7T7IWYhUSpZ2vyjZcVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y8OJOJ7JzrY=:abGRqrY3e5I0Yy8UHJho2a
 sj+po0ZXPwpwLW23O2U5kd/uiEMrchOOxrPTvR/A7SZvnqB2MRUer3BHs1ZCVKh2ghzk/B2oM
 6V5J8US+T5qh7vIO5quN07zj4ZHsMGZWZnLfYJ3GmTELuh5mdHLqN6QhAdO+Ng145g//VGehg
 ZtoPiPf5precRtI2Hi28ykK0ydx8JYUKGRpGhREEF5zz0StwgLJFrI/9oRJyuDypLsKNqgc+O
 ySTG0DmTlX+DpnT0LbjiuNGurxq5aweWbTF5Vzj/LDN8lZA596Vo3gcZLLKCE0fGGv0lCdUrt
 dxO0LFm1TW4jOyPZmpJkMnbGX9RHa/W7ei8NO7AB3jxw+itW2/6/5iMvvDdXfAr6+XeZ5K/EE
 j4qmN4JyQRqC1dzKeFtY3w+dOU1cpWhbms6gt9dXciDIew3m5W6iPH0F00XvYzLcWQESWjByl
 VnhYq9cRGHzRSxXyX/iuR0nv5hSdACNN4gStsO0tYDSnLee+rf8ZVvg9ILTHcfvtIq/ZDxV3y
 XTy3Vdy4IGuGZs64dLu/T8d/tBjoOgduvx1m0Nk1niWNkXDXq5xYxbcFYA7ZhqTRyia3Ej6ub
 2QoGKIG2SgbASNY2Fq4a+qzzQn5ZUjIJUiIfmwv6qC8+b0IfoL1K75XomHUlZEiYusUlrtoPq
 aTtvemFeMaGnKS1fvgK6/qugJLykyDH6xgR7hOOdbtBjoBeWwu7nh+o1fzFvDZ//WButbSu19
 TmsU4SeFYOw185t/Z2OcjcoeyJ6hP1lx05aRvyQ0S3P3vH9EX/MKEIIQ440IY1u2d6mfMq3FH
 xaPS/rdFAuWXT/Etchh4PTj9Irnv66UHtzZ+cxAuyWYIfQCmhk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 9:29 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Fri, 6 May 2022 08:58:15 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the arm-soc tree, today's linux-next build (arm
> > multi_v7_defconfig) produced these warnings:
> >
> > arch/arm/boot/dts/bcm953012hr.dts:57.3-33: Warning (reg_format): /nand-controller@18028000/nand@0/partition@0:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
> > arch/arm/boot/dts/bcm953012hr.dts:62.3-33: Warning (reg_format): /nand-controller@18028000/nand@0/partition@200000:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
> > arch/arm/boot/dts/bcm953012hr.dts:66.3-33: Warning (reg_format): /nand-controller@18028000/nand@0/partition@600000:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
> > arch/arm/boot/dts/bcm953012hr.dts:70.3-33: Warning (reg_format): /nand-controller@18028000/nand@0/partition@1000000:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
> > arch/arm/boot/dts/bcm953012hr.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
> > arch/arm/boot/dts/bcm953012hr.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> > arch/arm/boot/dts/bcm953012hr.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> > arch/arm/boot/dts/bcm953012hr.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> > arch/arm/boot/dts/bcm953012hr.dts:55.14-59.4: Warning (avoid_default_addr_size): /nand-controller@18028000/nand@0/partition@0: Relying on default #address-cells value
> > arch/arm/boot/dts/bcm953012hr.dts:55.14-59.4: Warning (avoid_default_addr_size): /nand-controller@18028000/nand@0/partition@0: Relying on default #size-cells value
> > arch/arm/boot/dts/bcm953012hr.dts:60.19-63.4: Warning (avoid_default_addr_size): /nand-controller@18028000/nand@0/partition@200000: Relying on default #address-cells value
> > arch/arm/boot/dts/bcm953012hr.dts:60.19-63.4: Warning (avoid_default_addr_size): /nand-controller@18028000/nand@0/partition@200000: Relying on default #size-cells value
> > arch/arm/boot/dts/bcm953012hr.dts:64.19-67.4: Warning (avoid_default_addr_size): /nand-controller@18028000/nand@0/partition@600000: Relying on default #address-cells value
> > arch/arm/boot/dts/bcm953012hr.dts:64.19-67.4: Warning (avoid_default_addr_size): /nand-controller@18028000/nand@0/partition@600000: Relying on default #size-cells value
> > arch/arm/boot/dts/bcm953012hr.dts:68.20-71.4: Warning (avoid_default_addr_size): /nand-controller@18028000/nand@0/partition@1000000: Relying on default #address-cells value
> > arch/arm/boot/dts/bcm953012hr.dts:68.20-71.4: Warning (avoid_default_addr_size): /nand-controller@18028000/nand@0/partition@1000000: Relying on default #size-cells value
> >
> > I don't know what caused this now.
>
> I am still getting these warnings.

Thank you for the reminder, I have now reverted commit 90103611d573 ("ARM: dts:
BCM5301X: Fix DTC warning for NAND node"), which caused the problem.

The patch was meant to fix a different warning

Warning (avoid_unnecessary_addr_size):
/nand-controller@18028000/nand@0: unnecessary
#address-cells/#size-cells without "ranges" or child "reg" property

but I don't see that here, so I don't know if it was actually required.

Arınç, Rafał, Florian: if the original problem comes back now, please
send a follow-up patch
that addresses all the warnings.

      Arnd
