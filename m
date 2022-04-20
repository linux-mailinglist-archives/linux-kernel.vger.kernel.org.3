Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A176B508821
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378524AbiDTMa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiDTMaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:30:25 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2EC286E1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 05:27:39 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 83BC23201F85;
        Wed, 20 Apr 2022 08:27:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 20 Apr 2022 08:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1650457655; x=1650544055; bh=/rO+aZ8SAp
        rl4lZr15B2Vbr+utkXm728+9C6HEl8FOA=; b=SJOZDYm6tD5NGHScFPZ9G+vEob
        fRDNlgTqZ612r1Y814tIFR5au0QTE+u8KOR/MU/0bZ2ZwxVsDy5lJEFvG/3b1aoL
        yKAWzloecpL6tmGPnc8CFMIUtwuR/b2N5D79dcAv/Ixi6TU1CZ7VfMlXezh7JjjH
        Lwk6bomo9OuiV+Y6GzB9Y2veP2+bjrdJ7BAHDfFxVbssew7NyLV2P6wRpwTQJDtJ
        kqwQ6vpPY6Sz/O24hltHGzmQjgFvM1OjifCtsjPjJQ7bOHnZIzl5y8+iiJalbhHK
        1IbiA2RyPxtKNyMVCBx+gY9FbZHCstPBiow0qUbq/CR4u1lduFN4qKicT+FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1650457655; x=1650544055; bh=/
        rO+aZ8SAprl4lZr15B2Vbr+utkXm728+9C6HEl8FOA=; b=O9fziT/oSPzQv4bXr
        2Tms3mUQIZONoSy3qJW0CyRxlwczI04OXOslOd2sGDCNfUwOECibce85+7846jz4
        IRmhpvyX14cJ6chYpcDlAV4BKq36aowYyTbBS9h0LC9DPxk5zArzV7iM+J0cLrL5
        wlYAkFa1oRrOl6X0GMgFJQOHDhY6P6etCB7torJjUUzAfkUeyTGfsVMfOzKN1zSS
        iMs85ECUvS4LGUGfTrirR2oaZ1QOwJ1AoSHs+1jil979TyFdN/8V5ADpH9rmDME5
        s55O4Kku1DBEBBPydUEcwWkQk7wYEzBgEtms/Xcv0PB9RLKIWyldGQQAik0Ei2r8
        H227w==
X-ME-Sender: <xms:N_xfYgEr5PWMrWbRobvSGmAm9Vy8CwSwuYG5Da6vM8z6rwVj2hwJeQ>
    <xme:N_xfYpVRq3tW4mHr0CXVBUkb1y8yejQ5KngLYoMFljCmrYj-t1mpNXgERIJCaNV8D
    j55peggkNcxcX5X9ks>
X-ME-Received: <xmr:N_xfYqLy-fW0LYT9W9RAlkblYvcDVPTNT7hLldU88Rqw-4duryUY7r65H02UnFuOpudPFs_c9pc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtddtgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeegheejueehgeekje
    ffjeehhfejieelfeduudfhgeetieegueehvdeftefhgffhtdenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsth
    grihhrvdefrdhmvg
X-ME-Proxy: <xmx:N_xfYiFHpbnzB0gKP572AVW7ZPIy76_1YxDnarsLYSPAZZ_e3C17mQ>
    <xmx:N_xfYmWz9vVuCiGNqnz8GB9yh9vFGgBb-pRL_F1Xf-alQ8cBmzhPaw>
    <xmx:N_xfYlO8OddGtpFB17RiEyw0myflidz5vzPIoHd0rSVEkvVErD1-9w>
    <xmx:N_xfYofePJM23_57xp8-w5v6MsfWUEL9OZ2tWZrNXhRUmwIpceLumg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Apr 2022 08:27:32 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable RDNIS by default
Date:   Wed, 20 Apr 2022 22:27:28 +1000
Message-Id: <20220420122728.510802-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Supporting Ethernet over USB is very useful for debugging. This allows
debugging systems where the other networking (WiFi or Ethernet) doesn't come
up, while still allowing SSH access.

This is extreamly useful on the reMarkable 2 as it doesn't have UART RX
or a physical ethernet port. If WiFi doesn't work this is the next best
method to access the device.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index f7498df08dfe..f9ddaba1aad2 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -349,12 +349,16 @@ CONFIG_USB_CONFIGFS_F_UVC=y
 CONFIG_USB_CONFIGFS_F_PRINTER=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_AUDIO=m
-CONFIG_USB_ETH=m
+CONFIG_USB_ETH=y
 CONFIG_USB_G_NCM=m
-CONFIG_USB_GADGETFS=m
-CONFIG_USB_FUNCTIONFS=m
+CONFIG_USB_GADGETFS=y
+CONFIG_USB_FUNCTIONFS=y
+CONFIG_USB_FUNCTIONFS_ETH=y
+CONFIG_USB_FUNCTIONFS_RNDIS=y
+CONFIG_USB_FUNCTIONFS_GENERIC=y
 CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
+CONFIG_USB_CDC_COMPOSITE=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
-- 
2.35.1

