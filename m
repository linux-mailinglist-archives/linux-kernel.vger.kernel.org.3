Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7198F4888E6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 12:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbiAILl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 06:41:29 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:37417 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229945AbiAILl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 06:41:28 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2F07658017F;
        Sun,  9 Jan 2022 06:41:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 09 Jan 2022 06:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:content-type:mime-version
        :content-transfer-encoding; s=fm3; bh=1iO9Xacgo2IEiAUwgTfhkQCJyw
        B+vMt9GrLcUsFja0U=; b=AbxB4VaIT2geck4+hTBATJ2n4MoLscgC767PQZXopH
        Mz/oe8QJnumSQDJH08/z+ZGOB382BLTk3LPU2CEWkEl0VyumURASmf5uMFwrVrM4
        hxuGck3Jwh25vwVAfpoLx/Rtveu/A5XI4Jm6LsvmIhp0035DxGjOtuZkBSqmq5Nc
        iLAVAV2tPLk5ed8Y9yO8/fwQw9bF8dfuzuHINgGfWpvctvjsqUAPY9Qgl4SaeNZN
        QbUIAFpqb4MBLkt669pb2W49l77Mn4/9cr3JEzynsYVlSgjWUkqL9yu6E4AAv/rj
        JZiLM5wUH/xRpR5Qg13UDKTr1uJdISKCgZWbMDImZbxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=1iO9Xa
        cgo2IEiAUwgTfhkQCJywB+vMt9GrLcUsFja0U=; b=NrlfcFgbOtu48Hj0N1ZLnl
        rzXj314N//bo2GW0hBpRc7moR/rU2agot92JP0c+u3XpjSgL201+z5I5kmge+vuD
        hbjti3jnUDukk06vlcVWb3hJaR/fi4WTeDy/ZB21fVD/LESRY9BHxYXvU6BW1F9d
        oQOWzmPXiv6IS0H96myWDGo4WLiOTEZjIp+sSC+Wa7vv3rHKcGtguVOOEPiX13YG
        D/K7Tc6XzHS9ODwdm29ERjnihltm+8jS3CDS0J/rua1cho5X0FHbx2jHIv/O2uZS
        8J36IObsQQ7gxcVgEmttNVQfJjc0is2YbPYl3nV2gCYRI6xmam+kTZaifw+ZQsdg
        ==
X-ME-Sender: <xms:58naYeQbGgHDd-qVcmVOlBCgFWt1540zjAjmvIQX0o3fcgrNmvEsmA>
    <xme:58naYTzUUqODWhjKsEB-sD-_O0gW8ovwTnAM-xr3HUmfbb1JvAnvvoxAcREvwFpkc
    a1xnoK2g3OffdyiWjQ>
X-ME-Received: <xmr:58naYb2dopvlZFbtuMHPRvEQQ9uxlMUIFGUxTgNIW-KIBZA-sFDH_o1g5bfnJQgceI1vzB2HYpv0mYsWmJ5sogiWEBKagHndER0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegkedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgtggfgsehtqhertd
    ertdejnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepheetfefgjeeuje
    dtgedvgfeghfeigfehffdvffduveevteejudfhudekudetveejnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:58naYaBjFPPXnWBRaxM6HyzaTX47xMoamCGsVCdlaO8_jMZgNiuj5A>
    <xmx:58naYXjv86S3s92NbABe1R0ILnTrvIpLV8huCIOACTkY40-xzziuKA>
    <xmx:58naYWpiibhj0NAjG5HT-zwR_3nBr4yq68TAR24odmXAKdHc4uJ0Nw>
    <xmx:6MnaYarjRIShryYNXqkVgqYvos5qeCUg8Z29ce-kPiq55h0-Y_0AYA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Jan 2022 06:41:22 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        shawnguo@kernel.org, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, s.hauer@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 0/2] watchdog: imx_wdt2: Enable ping on suspend support
Date:   Sun,  9 Jan 2022 21:41:18 +1000
Message-Id: <20220109114120.386013-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running Linux on the reMarkable2 tablet the device reboots two=0D
minutes after suspend. This is because we don't go into low power=0D
mode so the watchdog timer is still running and triggers a reboot.=0D
=0D
This series adds optional support for ping on suspend for the=0D
i.MX watchdog timer and then enables it for the reMarkable2 tablet.=0D
=0D
Alistair Francis (2):=0D
  watchdog: imx2_wdg: Alow ping on suspend=0D
  ARM: dts: imx7d: remarkable2: set ping-during-suspend for watchdog=0D
=0D
 .../bindings/watchdog/fsl-imx-wdt.yaml        |  7 ++++++=0D
 arch/arm/boot/dts/imx7d-remarkable2.dts       |  1 +=0D
 drivers/watchdog/imx2_wdt.c                   | 22 +++++++++++++------=0D
 3 files changed, 23 insertions(+), 7 deletions(-)=0D
=0D
-- =0D
2.31.1=0D
=0D
