Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991C947D258
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbhLVMqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:46:13 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:42671 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237086AbhLVMqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:46:12 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id BC9715803CD;
        Wed, 22 Dec 2021 07:46:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 22 Dec 2021 07:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=fm2; bh=VqlIc527blP2jp4gPa9SQqMVfs
        nmoyM43VnTaxx6eXM=; b=gDdnj7PXsQldB2H3IIMfKgbeINwEliZe6ko6k6UdaC
        QdRo9haOXGwqoTRYiI4iBKP6gO/85igSXmlaNjS1L1zJO7VvPl1Si1B1hsO974Uu
        meT5W9I9/MeaWIy78fRIHx27nhe7kXWRxhTOR+o1VTmSh5iIgZZnJhTzlDYkO4sx
        9qEQcxLcQVmfMDaHxywg5Nss/GoGrMV0L+D7+Az5AknU8xJ1rV9RdDv6qBdLhjL7
        dPLJaygJKMeQALbPIK0Gtok9LxGZqqg9eDXOAGTKNdGlDTmJJNaRLUgtwZPUWxyq
        a/w0Hf42aiEj3avjH/HmZr6jpCE/4lEmm059b54MR49Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=VqlIc5
        27blP2jp4gPa9SQqMVfsnmoyM43VnTaxx6eXM=; b=UiIDvWc+15HtCtqY85NRpa
        UD11Sl0aW0y441Aizcb2vPduNkyzibFDiQHdUYAEwsjGNyTzowWRR+Rjz2oj1sHx
        KduJg9Sg7MhpP3JHr49WqQC++QpoyngaaeWCu2GpYHQ22lLBC0zV7odQHgw+WWAP
        POyz09QMWO9waaFHc/Tlkl7Wv1JWSAmnKVTykV8z0QOWtlFZNn6bJimwLGHGX9S3
        CDUFkVStMRYQ1ZMPYVejthfXygUGa8vSrVgt/WwH6VUFgEACKUmWfD2FgRx8Sc9Q
        nsVJzObG3vSzCW5ffs3IJWVRTAMGpn2Ke/h3B8Up38BukZsFCnJibBKwbntG3vig
        ==
X-ME-Sender: <xms:Ex7DYbOLEeTDiLzqdd7U6STHtyDDc1cDPQBkBcRwLvFw0mJzRHj9_A>
    <xme:Ex7DYV9p9SkVCnLdrl1VRlyGD6n8BNx37_7OWXKfud1yHkTmrW7IcOKfjic7G8Jq5
    MJ9Q2O0Jnaw2FpeA5A>
X-ME-Received: <xmr:Ex7DYaSPHdd2qtCKVSq2T7E_yYq9OQ7k3iQI5gXkI6W87D9lclhMJTzQNb8f85aD2Km2v67g2iA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddruddtiedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofggtgfgsehtqhertd
    ertdejnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepffelvdegveefve
    efvddvffeiteefgfejveegieethfekgefhleeukefhjeehfffgnecuffhomhgrihhnpehl
    fihnrdhnvghtpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhm
    vg
X-ME-Proxy: <xmx:Ex7DYfvstg7j1aCd5CV-z_AQTN7ujctRRmYHZpLYN5AzAOW0_VFVEQ>
    <xmx:Ex7DYTctdPqh3fZaCWD8H84sBm_lAVWOJkYitfJPq5SMqXJlq1BaYw>
    <xmx:Ex7DYb1GseU6ayTAnCrkGEORRVnvspevl_CgiyiO1rSjkpQwA6JSLQ>
    <xmx:Ex7DYX5CHclB0N9J9ZYBp_r7fQcusXmf-biPIrRkIqbvreezEVYb-Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Dec 2021 07:46:07 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dmitry.torokhov@gmail.com, alistair23@gmail.com,
        robh+dt@kernel.org, linus.walleij@linaro.org, rydberg@bitmath.org,
        andreas@kemnade.info, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 0/4] Add support for the Cypress cyttsp5
Date:   Wed, 22 Dec 2021 22:45:59 +1000
Message-Id: <20211222124603.326920-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series builds on top of [1] and adds support for the cyttsp5=0D
touchscreen controller for the reMarkable 2.=0D
=0D
I first tried to add an I2C HID device. Although the cyttsp5 has some HID=0D
looking aspects it is not HID compatible. Just in trying to probe the devic=
e=0D
I found:=0D
 - The HID descriptor has extra padding=0D
 - The HID descriptor sets the high bytes of the descriptor length=0D
 - The HID descriptor has extra unrecognised tags=0D
 - The HID reset command doesn't appear to work=0D
=0D
I don't think there is a way to use the I2C HID framework with the cyttsp5.=
=0D
For anyone interested you can see the work here [2]. In that branch though =
I=0D
can only obtain a HID descriptor, nothing else works without more core=0D
changes.=0D
=0D
So instead I rebased the series from [1]. Converted to the new yaml DTS=0D
documentation, added regulator support and fixed a x/y miscalculation bug.=
=0D
=0D
1: https://lwn.net/ml/linux-kernel/20180703094309.18514-1-mylene.josserand@=
bootlin.com/=0D
2: https://github.com/alistair23/linux/commits/rM2-mainline-cyttsp5-hid=0D
=0D
Alistair Francis (2):=0D
  ARM: imx_v6_v7_defconfig: Enable the cyttsp5 touchscreen=0D
  ARM: dts: imx7d-remarkable2: Enable the cyttsp5=0D
=0D
Myl=C3=A8ne Josserand (2):=0D
  Input: Add driver for Cypress Generation 5 touchscreen=0D
  dt-bindings: input: Add Cypress TT2100 touchscreen controller=0D
=0D
 .../input/touchscreen/cypress,tt21000.yaml    |  92 ++=0D
 arch/arm/boot/dts/imx7d-remarkable2.dts       |  89 ++=0D
 arch/arm/configs/imx_v6_v7_defconfig          |   1 +=0D
 drivers/input/touchscreen/Kconfig             |  14 +=0D
 drivers/input/touchscreen/Makefile            |   1 +=0D
 drivers/input/touchscreen/cyttsp5.c           | 922 ++++++++++++++++++=0D
 6 files changed, 1119 insertions(+)=0D
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cyp=
ress,tt21000.yaml=0D
 create mode 100644 drivers/input/touchscreen/cyttsp5.c=0D
=0D
-- =0D
2.31.1=0D
=0D
