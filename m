Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B8F4BCAA8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 22:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiBSVBC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 19 Feb 2022 16:01:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiBSVBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 16:01:01 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0057026E4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 13:00:41 -0800 (PST)
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MqJuN-1nzYTk38F9-00nQKg for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022
 22:00:39 +0100
Received: by mail-wr1-f48.google.com with SMTP id v12so20271637wrv.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 13:00:39 -0800 (PST)
X-Gm-Message-State: AOAM5304xKsg5uQveqfaCsdBfePd329xI3aZHtST2V9SKY65NGVfCWPx
        4FJPg0jTSR90d85EYK4rE2iKHVx/SM2DsZC9eNs=
X-Google-Smtp-Source: ABdhPJyK+brNWsemqU2E8vj62LPsF2iDADHS94yfka/zGBuxOs7G8C08zWSee9iQv2Rztz2xIez3qhbv6bwnxBOo5Fo=
X-Received: by 2002:adf:ea01:0:b0:1e4:b3e6:1f52 with SMTP id
 q1-20020adfea01000000b001e4b3e61f52mr10374772wrm.317.1645304439352; Sat, 19
 Feb 2022 13:00:39 -0800 (PST)
MIME-Version: 1.0
References: <20220218212526.16021-1-pali@kernel.org> <20220219123445.14940a12@thinkpad>
In-Reply-To: <20220219123445.14940a12@thinkpad>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 19 Feb 2022 22:00:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2VW1zFAVqfBGucL2qpnQWsih457Dg8iFE3nR=Zrp+iSQ@mail.gmail.com>
Message-ID: <CAK8P3a2VW1zFAVqfBGucL2qpnQWsih457Dg8iFE3nR=Zrp+iSQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Remap IO space to bus
 address 0x0
To:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:mNsPBbgPA7HOrQ5toM0sTisK0Bu7WTdlx6csi8l6IckUS67SgZU
 NNRyB3LuIW/NJH98FrZGAeD8XF+Zvp63BZyeKPfFNkd6s24dciF02NHlQg4F6UUsh4MQWR2
 XH+1j3c4Q5EjQToc5fh1aZvGx0N9O+msz88FyrdMVvcvSOHwk+5erpcYZtedcqJ6O+KCn6I
 L4nKbQ2h2mGimazpFeXSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YOYic9OjnIU=:msYOehppmJ6wwBzkXq3Y7t
 NbBI3yHcMuo38KrPxB/u6G7meTRYVxwpkdRdQ51Jfgxu5M7TEMJJ//mkpbHeu/cTR7zTSfKMR
 0LLTMpj933/rDqD/XYSi2XpOfLpuSfLnmsPp+0QifWE4vwxRTIr0mLCxxZjlRvplYVTpVwHa8
 zGcskTqqFEizTnnmP9wMI8eURKLnHP6oMoEdph0r1EXMn45xdS666Q1xb8//uu2G74YTDk6K8
 eTGtDb2wj0oQhcnnIenGlrTmu8/GbrXFk6xbWbRYL3Hlej0b0ULBvkUBQXJ0oulyOHm3NsQSK
 4ur859YJCQ7QyZ7PxoFizDpq7p580OvY0geu7dkcCl8T5ehLuPkw1hUTBWYFeDv0ax2U1eSsD
 nsgIQSVagL22X1oWY+cuvMpJ3UDliW3M224bHAAAOv/7fPth05V5Avhh9sCbtueWvCL+hIO0s
 +FjwPqqP75LRxj7u7Bh0Wybl19nztBPaiuBcRH82CFoFVdL2XF/F8w+JKvOTRb4mH2oQn0wGn
 TDnRgWpuJon+m1Bqa1S0YgcjLT3hwrRIfatlnhH2SzX7by7gU8v271Eo5VHWgsJQOnyPVa53P
 GpfBmELFVwPmHDLKolGgRKtTkmCxvqLRDI5ZB4FKSO7kvdbKZXNtK8FjSZfL+f3IqjIdx0tJL
 tccqEiXN7r9k7nWsoVEx1R3X8LAHug8JwFFAjc0cI4xsDPvb4cFKypfRMMIOOfvjiVew=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2022 at 12:34 PM Marek Behún <kabel@kernel.org> wrote:
>
> On Fri, 18 Feb 2022 22:25:26 +0100
> Pali Rohár <pali@kernel.org> wrote:
>
> > Remap PCI I/O space to the bus address 0x0 in the Armada 37xx
> > device-tree in order to support legacy I/O port based cards which have
> > hardcoded I/O ports in low address space.
> >
> > Some legacy PCI I/O based cards do not support 32-bit I/O addressing.
> >
> > Since commit 64f160e19e92 ("PCI: aardvark: Configure PCIe resources from
> > 'ranges' DT property") this driver can work with I/O windows which have
> > a different address for CPU than for PCI bus (unless there is some
> > conflict with other A37xx mapping), without needing additional support
> > for this in the firmware.
> >
> > Note that DDR on A37xx is mapped to bus address 0x0 and that mapping of
> > I/O space can be set to address 0x0 too because MEM space and I/O space
> > are separate and so they do not conflict.
> >
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
>
> Reviewed-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
