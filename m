Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D010B56A7C6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbiGGQMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236119AbiGGQLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:11:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFEE21D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 09:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657210235;
        bh=NN/0vA6OVRB9hbRmvxOKPBcC3OaWeALfMawHvX5MLqY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=CQ+hJiBgxPholSi43up0qCOC64mNJc6a71fr8R1L/Anq2I40q1O0LiB3ONAk4JDRN
         eEDWAGgsZnvdf9TOuswaMnX0LX6k2Vl8+axqND0R6EJ6Y98BxypvUSPq4HQbGPYCmD
         6a/E0Q16Ih+I69qXari+jsHdBwPz0aWltQc6Vs7o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.77.44] ([80.245.77.44]) by web-mail.gmx.net
 (3c-app-gmx-bap68.server.lan [172.19.172.68]) (via HTTP); Thu, 7 Jul 2022
 18:10:35 +0200
MIME-Version: 1.0
Message-ID: <trinity-54ed588d-4b2c-4177-83b0-4eda8ff16a42-1657210235522@3c-app-gmx-bap68>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>
Subject: [BUG] USB broken on rk3568 based R2Pro
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 7 Jul 2022 18:10:35 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:zUnx7/bZtgmbV9sg5VG+TjiBYWfl3ircR+UQUSbzUh3Yh0EGP+vG35CXWfQOs95HWDyj3
 7zkMzLOKfYyLN9PoKNFZ6tUO5Ye2KBV2YnmAPRvS5Y8nVR2ynDjy0mRzoxO04wMrf4Iy1TxRZOik
 vfOmmR5vnEC3/RCoGedP85cWc+QZhaXXujqjpdGTYUi9OD21inUohospvKd1Pb4+e/blyIIDyiiC
 Phwb7NCOHjh5jObQB9ku7J7ZGgQnmtBbnLcrRz7WxglSF+Nmt/tsgQnnu0JrrZ0I/e2iGXvItooR
 9s=
X-UI-Out-Filterresults: notjunk:1;V03:K0:tAuzQFDEqhE=:igPVA6BhQjlvhITOkxIREd
 OemjZvdV1IEOxQeQaiZWwQfrUKOkbkFQGGPXuAgV+HS4yqDbw+FB3/7aBXYCy5PLXYqAEXDOu
 GBeS47Q6jfNww7F2Gd0b9in7V/oy7g3D6wt3KcEvY6qxRsAWVH9QqvMxc+HQHfexY3lgdF4Yl
 SLAKAqouatBUjPqG9Aq6ygjQDV8/bIn4P3yt7MXxYMhzhkqSK1CKLQ7KupGl+Q+0oaHZVvHF6
 Ipya7PKkhLTsBZRjEeC07L46YAN1kQCqKzbReT7+HpiKxrQTeRakuKBs8x1laxB5kCWrzMVr4
 BnDvLDxfympk/8UVPBE+Ioz0um5IJ0r0gUKDTnsN2BSSD/Z5sZALdEzxyQ+JJcuw5/zI4gAqB
 XdC6+NzK02IOpEANKXMQniSr1CSzmfmuskfyUm1/W7ADb41ZTMa0p7CUFAi6tE+XsIbukBBgW
 v79JNJM/2kaoWhID3VelXjGTA9C7FlI8KAeaLF4yHDTKntn/+3N7GS2mQaCbewq3JE7O7CcOn
 DbZOFNNfd8W+PwDiXZLrXl60/uXwtC2YaGwnYSzqs6SF3hD1GD4Uwz+5uSDo3STwz6D01OTYf
 aEVDfttviC4wDRLDHHuh1QsFKuq2yikYBltCtsnC4rptItQAyhbUsP2rILLVjkGy8mxo+gzrI
 gHj6Cyo+NUVI8rTPuEPhvCoaLyRgFcIHpCW55rn4Jp7k7Ij2ueW9tlVMr7NvGogjKOyDBM+WK
 qSvhzJXvyE3tkQIhk6RJP/IpT4W1tE5S1ni2q57gPpG5SOoWa5uI9Xw9OtlhQpsSSvVIyI4Xc
 YmEkYs/
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

i noticed that upper usb-Port (otg) is broken on my Bananapi R2Pro with 5.=
19-rc1, works with 5.18.0

this port is a usb3 (xhci) port which includes an usb2-phy and should supp=
ort otg, but i still want
to use it in host-only mode (USB-A socket).

already tried setting dr_mode in dts back to "host" as this was changed in=
 rk356x.dtsi by this commit:

bc405bb3eeee 2022-04-25 arm64: dts: rockchip: enable otg/drd operation of =
usb_host0_xhci in rk356x

i see no error in dmesg and usb-controllers seem to be initialized complet=
ely (visible in lsusb).

r2pro has ID-Pin not connected, so i tried also peters Patch without succe=
ss :(

0901c01f8ac4 2022-06-21 phy: rockchip-inno-usb2: Sync initial otg state


so i tried bisect which seems to point to wrong commit (not related)...

$ git bisect log
git bisect start
# bad: [f2906aa863381afb0015a9eb7fefad885d4e5a56] Linux 5.19-rc1
git bisect bad f2906aa863381afb0015a9eb7fefad885d4e5a56
# good: [4b0986a3613c92f4ec1bdc7f60ec66fea135991f] Linux 5.18
git bisect good 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
# good: [4b0986a3613c92f4ec1bdc7f60ec66fea135991f] Linux 5.18
git bisect good 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
# good: [2518f226c60d8e04d18ba4295500a5b0b8ac7659] Merge tag 'drm-next-202=
2-05-25' of git://anongit.freedesktop.org/drm/drm
git bisect good 2518f226c60d8e04d18ba4295500a5b0b8ac7659
# good: [aef1ff15927421a55312b4b9b2881a89a344bd80] Merge tag 'jfs-5.19' of=
 https://github.com/kleikamp/linux-shaggy
git bisect good aef1ff15927421a55312b4b9b2881a89a344bd80
# good: [09a018176ba246f00d6b6b526047d38dcd2955d3] Merge tag 'arm-late-5.1=
9' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect good 09a018176ba246f00d6b6b526047d38dcd2955d3
# good: [54c2cc79194c961a213c1d375fe3aa4165664cc4] Merge tag 'usb-5.19-rc1=
' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect good 54c2cc79194c961a213c1d375fe3aa4165664cc4
# bad: [7036440eab3e2d47a775d4616909f8235488d714] ARM: omap1: enable multi=
platform
git bisect bad 7036440eab3e2d47a775d4616909f8235488d714
# good: [46ee6bcac9838b7f74ff91f9cf38511c901ea9c5] Merge tag 'mhi-for-v5.1=
9' of git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-wor=
k-next
git bisect good 46ee6bcac9838b7f74ff91f9cf38511c901ea9c5
# bad: [dc6a7effb48e7267c9f1314e3aa8cfe539bd6096] Merge tag 'lkdtm-next' o=
f https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux into char-mis=
c-next
git bisect bad dc6a7effb48e7267c9f1314e3aa8cfe539bd6096
# bad: [fa5602c62544ea5303ce870a9a3318fa7695ffc2] Merge tag 'soundwire-5.1=
9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire in=
to char-misc-next
git bisect bad fa5602c62544ea5303ce870a9a3318fa7695ffc2
# bad: [f1b8d3358af77fc453d6b781f40ee7342a230672] phy: core: Add documenta=
tion of phy operation order
git bisect bad f1b8d3358af77fc453d6b781f40ee7342a230672
# bad: [2404387f521eda1d0eded58411bac2c719985d9c] phy/rockchip: Use of_dev=
ice_get_match_data()
git bisect bad 2404387f521eda1d0eded58411bac2c719985d9c
# bad: [45d1f841d5a4afb415415f9f87c9d4ce15e19f42] dt-bindings: phy: uniphi=
er-usb3hs: Fix incorrect clock-names and reset-names
git bisect bad 45d1f841d5a4afb415415f9f87c9d4ce15e19f42
# bad: [6f3652c952d8d8d22da1d535c470906da6e1afde] phy: qcom-qmp: Add SM635=
0 UFS PHY support
git bisect bad 6f3652c952d8d8d22da1d535c470906da6e1afde
# bad: [082ffee0505810bba7c4add343fa178861e26212] dt-bindings: phy: qcom,q=
mp: Add SM6350 UFS PHY bindings
git bisect bad 082ffee0505810bba7c4add343fa178861e26212
# bad: [e4d4371253029528c02bfb43a46c252e1c3d035f] phy: phy-can-transceiver=
: Add support for setting mux
git bisect bad e4d4371253029528c02bfb43a46c252e1c3d035f
# first bad commit: [e4d4371253029528c02bfb43a46c252e1c3d035f] phy: phy-ca=
n-transceiver: Add support for setting mux

have not replaced dtb while testing to exclude these changes

i looked through commits between good-bad-change and there are some for th=
e rockchip-inno-usb2-phy where i guess the problem is located

git log --oneline 46ee6bcac9838b7f74ff91f9cf38511c901ea9c5..dc6a7effb48e72=
67c9f1314e3aa8cfe539bd6096

issue is maybe extcon (pointing to the usb2-phy) related as 5.18 uses extc=
on for this port.

Tried to find something in sysfs/debugfs, but without success.

maybe anyone has an idea? anything i can try/readout (sysfs/debugfs).

regards Frank

