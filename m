Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0F356AA0D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbiGGRvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbiGGRvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:51:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9FD59253
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 10:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657216287;
        bh=eRYbd4WlZHGFlVSm3qXeJePVlVFwXtMQqRvFFzWW8sA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CPCF48bnbKzeUJhPMiovgoEnC+vEixzZVTJv7LclOVBt0KONOCHOI2ocJYtObJk18
         Nun8P/23Ka2GOvFVBiarlQSvGMuYzHFpuSlTqXNW3tPpOtYDP9X4TGlPUsnM7WmWNJ
         OKxU1+NInSyFY0Bv0KjGUKVC79s3LtS6KyspU/mA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.77.44] ([80.245.77.44]) by web-mail.gmx.net
 (3c-app-gmx-bap68.server.lan [172.19.172.68]) (via HTTP); Thu, 7 Jul 2022
 19:51:27 +0200
MIME-Version: 1.0
Message-ID: <trinity-ec3b4258-cb12-42c2-9058-362260a275d2-1657216287085@3c-app-gmx-bap68>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>
Subject: Aw: [BUG] USB broken on rk3568 based R2Pro
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 7 Jul 2022 19:51:27 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <trinity-54ed588d-4b2c-4177-83b0-4eda8ff16a42-1657210235522@3c-app-gmx-bap68>
References: <trinity-54ed588d-4b2c-4177-83b0-4eda8ff16a42-1657210235522@3c-app-gmx-bap68>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:24r+j66QKvqyftybingAK3M/KSPL4PIEXDBNqezfGswC5ckMvODK/GKotZjbvO3p6PPEo
 2L9wrLhmlGGFa9gLz+V633gEyKdfsg3ymqAUqvA89f4swLY1IkBrIuU3uk88xQPbK79ZeyHVxSxZ
 qJjit5vCIO0tZaq4gTIi/q+n3NsB9hTdSet3EFaMr/DYyFYohDbkb2KbhqHc5kgnl17gkFHacvv9
 E5lxV6UVejslIEfZdgk8bqBUXlMV5DdvwJ5k3HYbaqrLzmCE5Fi26HW5j+L9300IV5aG73Q4Qc1G
 t4=
X-UI-Out-Filterresults: notjunk:1;V03:K0:IjCByH4FtZs=:jDoGUfUZr5RlWZlr5iWBZw
 qDLSgJsqF63mqfpHrJABrqUB6JFU5XKRh2N1dcj//OZfA0BmckB2nEfY+/VqcKMnFlVZbE1ms
 h44ezUMG0yKnKRYQfX5yLKiMdum+en/T1vUj5FqOCq5kkPf1B8cAymRl84eSqH4uvj/j+kDKT
 6r05tVJidN4aCg5vW/kLJlRH3YQ1Eaexz4miP5VWrHs78OPK31GZvr7i9hYU2d9bUt/XOTlWf
 Jzj393El1vigBdv8fZGL7y4QQaDmxmqsTYSYFpMJMlPEpLym+SezWzH8TX+2UyXg9EEvgGOeh
 5JS39wIC8jBRYuio6S/LXS6yZKbSceAfg3ONHxIzVPMYE82m3fKznFQI52EuuTAgb4meq1jAB
 ILu/l9OftbRe+5La1zyBAwY2M72E7dadwmn+9L0Z5v4mKHcyMb6AMGezFIWwY2TIq0nzkU1FB
 HZZ/eahsoBrZ0W3nXiYQ+js5Uv8SWmsL82bhhMAEDfA82uYOgR8wdDPv5FKEm5XwHVlKDdiPu
 z+fVuOG/ZLkzKQK2/J55fVSV9sTlrV7BlnRno5CS3XFEcHXQ6fuLg1mOCZS+EWzw6YgCC8jPT
 r0kr6B9hVD0EIFWkeTMuy4bEAlTjJSWaszI3WHL0hBH95UTDMOZrhV2F0ekjqXDShmp8+bQHn
 t2/wqJhtu8oQ7ejFYqNGkWxfBfTs00u54QBopVAUaxrQCGqigostXvlzo+2ZK8d9AzlOLouqQ
 lqAEdJsFLIfp1/goTGES/+M+8ZNOzMXbBLHE7kAQ5HCsRlkL6BJEhBzgUCQbt80bAIeQml6Od
 Hx6Eu0k
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

traced it down with manual reverts to this one:

commit 6a98df08ccd55e87947d253b19925691763e755c
    phy: rockchip-inno-usb2: Fix muxed interrupt support

luckily i can revert only this and now upper usb-port works again

@samuel: have you an idea how to fix your problem without breaking my boar=
d? :)

@greg/Vinod: maybe we can add a revert of this in mainline till issue is r=
esolved?

regards Frank


> Von: "Frank Wunderlich" <frank-w@public-files.de>
> i noticed that upper usb-Port (otg) is broken on my Bananapi R2Pro with =
5.19-rc1, works with 5.18.0
>
> this port is a usb3 (xhci) port which includes an usb2-phy and should su=
pport otg, but i still want
> to use it in host-only mode (USB-A socket).
>
> already tried setting dr_mode in dts back to "host" as this was changed =
in rk356x.dtsi by this commit:
>
> bc405bb3eeee 2022-04-25 arm64: dts: rockchip: enable otg/drd operation o=
f usb_host0_xhci in rk356x
>
> i see no error in dmesg and usb-controllers seem to be initialized compl=
etely (visible in lsusb).
>
> r2pro has ID-Pin not connected, so i tried also peters Patch without suc=
cess :(

