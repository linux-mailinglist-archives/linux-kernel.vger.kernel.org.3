Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF4E466324
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357757AbhLBMML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:12:11 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:38661 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357701AbhLBMLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:11:45 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id CFB5D580342;
        Thu,  2 Dec 2021 07:08:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 02 Dec 2021 07:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=mo4lDbGJIutF/
        EfV6ESK2Jau5DqaSfJJnyr+9T7QDB0=; b=zYRuf3VN1cYLsg/L56uY8EQ5PMFWr
        XEcrKecOoPWRJce9fLYLZ3s4aJi5VnWeffX+b7cyS1Oq42ASfGVavmxxeF6J+fJD
        IM4pNwaghcADZF3uOqWZWna1HD6GqYqUfnhL6tkmsvYzYbVwJDAG3LDnLmnkP8t8
        zH71yMo9ZhLIbcEZKmbqR3i8RXg4n5cZHyiTnKLR4M8+hagg8TAHLA2MMPiBEmW5
        c5sg3Fgv4h6Yh6/c6FBD7KM4IJJtI/Q+EFXSb/VkFxgq+/w7/BjnAuNJ4jWDnrmX
        ikZG1PjuVrBUUyFZsEWW4d39x+yaGrjAaEV0fcdyQ9+O+NnExbR4n68+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=mo4lDbGJIutF/EfV6ESK2Jau5DqaSfJJnyr+9T7QDB0=; b=kkN1goKM
        9UwCzQNtb5ETeZxtX+16wvoCvDITMZO+rZnM9/r2cP1/1GhHXONEtlSiibbHThjI
        kcgI0J0OD8CB1wd+Ck1QJE6RFQND8TLTVE1Qf6/nxB/AqvrdzRnvDwnk3zab9syH
        w9QXr8OIuV15x1A8eUL+dmuTfxmtOtvOKNcYgsPLDvrC20JKidfN4CaGLET4GKkc
        C6Tg92urA/iScmfqN/wH59OTdsqIKdPOYsBF9YSLQh4FbdMbiDetA0a3Db/mqH7/
        wQ37cc49tZVXACQ0xCgXWdKmIo5zBrX6Txc29Xgzc5x5INXzsuVWFnE91B5OFY8W
        +6nylGkXUTUZjQ==
X-ME-Sender: <xms:NreoYfsfxIvElkRr3T0w54E95x0Lb6BI925yQvz5A22IpfoEgKJgqw>
    <xme:NreoYQc8lySvyTJ_VmiHTPewWmbC07LxtrJtILIpR2FYkJ7HmnToqfZvrL4mEiGoY
    bVz_XcmG7MMLAiyJ54>
X-ME-Received: <xmr:NreoYSwxJ9Tjb78mSOwVxPLDtvQnHEf3XVRrFqEohicoZuiwnauKBTQ2L1h82Lib_5_CtNLtoxR_K2Ndfr9HBcCTsEft7uFmSzSWIUSdWl9tjTU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieehgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:NreoYePjUEwyWg0MFqcNoLZA-1H_qdFhi6NbG_gbHJRCuJtiLQ16ig>
    <xmx:NreoYf-9tlbkdL8jpKChpxl5mMDee7kCDPsfQrmfdsUJHUmT7afaeA>
    <xmx:NreoYeWbfORjNOwVX7E_H6GjlgnZvnuAMcGdH3Q4NM4866WXSs59Hg>
    <xmx:NreoYXOJah9A5wpdkT8v1jj5g5wVf0IpayN2PqNiIt7Nhab_EMoXrg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 07:08:15 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     kernel@pengutronix.de, robh+dt@kernel.org, lee.jones@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, andreas@kemnade.info,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, amitk@kernel.org, shawnguo@kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v16 2/8] mfd: simple-mfd-i2c: Add a Kconfig name
Date:   Thu,  2 Dec 2021 22:07:52 +1000
Message-Id: <20211202120758.41478-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202120758.41478-1-alistair@alistair23.me>
References: <20211202120758.41478-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Kconfig name to the "Simple Multi-Functional Device support (I2C)"
device so that it can be enabled via menuconfig.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3fb480818599..97976ea83fdf 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1194,7 +1194,7 @@ config MFD_SI476X_CORE
 	  module will be called si476x-core.
 
 config MFD_SIMPLE_MFD_I2C
-	tristate
+	tristate "Simple Multi-Functional Device support (I2C)"
 	depends on I2C
 	select MFD_CORE
 	select REGMAP_I2C
-- 
2.31.1

