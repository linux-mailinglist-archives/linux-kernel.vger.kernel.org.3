Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D891C46D377
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhLHMo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:44:28 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:39155 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231705AbhLHMo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:44:27 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id A6975580247;
        Wed,  8 Dec 2021 07:40:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 08 Dec 2021 07:40:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:content-type:mime-version
        :content-transfer-encoding; s=fm2; bh=FsWeQZxZSSEz8vuc/Z5qWfMulb
        t5I25Zs4HyBrRJlC4=; b=Q7CbvwDh3/+PZLUvxB3vusKmVbqHDsgcnZ4Bq1m+Ni
        QmmOE59SczOw5YcXZJO51qtL3sKhKohOsMQpOCrh7PvTDbmkvpkKse+mGY5oS8uk
        5qnc0RGxh3MIGjHMv97uL2G0q3Km+537fqYjnRI6welmqSESimy62vomEZu5fwEi
        GD8neNObW+6RShoficN0jtP7YnnloU4Wt0S8H7E1XnNHEq8W2M1Ce5EdTejxqcll
        uf88tIUVTQifO6OxdkcubMM+rHx6MiGuXBZlp4PdRznqFCYRxauFEWFNX20NbYFd
        l/JFT7+mM4m3wGli8n+y8XnxlsnQAQCHYrJM8IkbgsGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=FsWeQZ
        xZSSEz8vuc/Z5qWfMulbt5I25Zs4HyBrRJlC4=; b=BDDpzaps6+jlI4Z2TnxQfg
        szQyRPgu6XDD2Z8hEwDKiTaUdKCqcNIQymi7unVC2WAOy8M+lz+s8lyqoOOE2PKs
        egCnfRFTxQwhlvDK/XUKxmMwqDWvcUANvxxDF3edkekgLYgT3l+NAt3GHf1m5GXy
        jmUrNHFxzqO6ZAH2RZcSbXuMYK9rBvTujaWCPzA6JCDBpz5JzweE7LJ6ySw2FXup
        oApE/Jqrynzm5jO1iHwG9dszQVkseTWIBEmhCtgaXwJonouZAWLhHn2aV1xTqxUF
        fSH46LQ44OAqjFufPEYuAj0yXDgJjBXocYEjQM0VVymwx+EczPKd1T5p6HEa/YIg
        ==
X-ME-Sender: <xms:1qewYfvPl6Zjvd805qLgN2P4Sq3VNgYK4MmJSi61lfFY50cfeshzgA>
    <xme:1qewYQcs2QCbheiOCGmv9E3xRMy1YF8nyI3luTfJ54DPkFLK2OQfDZAa3syUPCmk9
    C3HdM21WAGpB3XaA4s>
X-ME-Received: <xmr:1qewYSxh2hlT838ghMg57ZyPwwZsOn17mHEZQId4e_DDkDmwG9ZCGu0DsXZQVxIbTVFP-64UTiWoKc3eoESa_729ilpuXOIoir0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeekgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffotggggfesthhqredtre
    dtjeenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeehteefgfejueejtd
    egvdfggefhiefgheffvdffudevveetjeduhfdukeduteevjeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsth
    grihhrvdefrdhmvg
X-ME-Proxy: <xmx:1qewYeNTvDa6nLPTq3ZOSGg43oVILWjy8zH62bweEr2yZoL70F0ssQ>
    <xmx:1qewYf9tFe102afa0uAOoHXbP-IijzVYPFReUYOrr3KOGJvQSLlpdQ>
    <xmx:1qewYeWL7TwAqXoFIT3ozCamI1TDg_HyyyEyjkHljU2yEI198Jxxvg>
    <xmx:1qewYTXVbNhmMl73WpBQW79Zs_E-INXU__Dz9Rw0wTUkMPy69qzeow>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Dec 2021 07:40:48 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     s.hauer@pengutronix.de, shawnguo@kernel.org,
        dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com
Cc:     jikos@kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, Jason.Gerecke@wacom.com,
        linux-imx@nxp.com, Ping.Cheng@wacom.com,
        devicetree@vger.kernel.org, martin.chen@wacom.com,
        tatsunosuke.tobita@wacom.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v16 0/3] Add Wacom I2C support to rM2
Date:   Wed,  8 Dec 2021 22:40:42 +1000
Message-Id: <20211208124045.61815-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Wacom I2C support for the reMarkable 2 eInk tablet using the=0D
generic I2C HID framework.=0D
=0D
v16:=0D
 - Add commit message to DTS patch=0D
=0D
Alistair Francis (3):=0D
  HID: quirks: Allow inverting the absolute X/Y values=0D
  HID: i2c-hid-of: Expose the touchscreen-inverted properties=0D
  ARM: dts: imx7d: remarkable2: add wacom digitizer device=0D
=0D
 .../bindings/input/hid-over-i2c.txt           |  2 +=0D
 arch/arm/boot/dts/imx7d-remarkable2.dts       | 59 +++++++++++++++++++=0D
 drivers/hid/hid-input.c                       |  6 ++=0D
 drivers/hid/i2c-hid/i2c-hid-acpi.c            |  2 +-=0D
 drivers/hid/i2c-hid/i2c-hid-core.c            |  4 +-=0D
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c       |  2 +-=0D
 drivers/hid/i2c-hid/i2c-hid-of.c              | 11 +++-=0D
 drivers/hid/i2c-hid/i2c-hid.h                 |  2 +-=0D
 include/linux/hid.h                           |  2 +=0D
 9 files changed, 85 insertions(+), 5 deletions(-)=0D
=0D
-- =0D
2.31.1=0D
=0D
