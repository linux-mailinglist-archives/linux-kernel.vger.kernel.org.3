Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFEB497E9B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbiAXMKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:10:42 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:39713 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238436AbiAXMKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:10:31 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id A294258035E;
        Mon, 24 Jan 2022 07:10:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 24 Jan 2022 07:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; bh=1+O+BD4KhhqplV
        X1DfTshC/FNHBhlW8RmbwpMMquOa8=; b=nYBg0sVH4ERV/xBNz6d59OaKrPQpyc
        iydArtR3CWU8U58qb3Wbil9xHsdKSMH6U8W4vr4QJj6uTq/pMaa4LQDPKeXx+hE6
        LcNFr6+jkGOfj9MNSgxCHo7apaynr/QGw2RfJL79IdCwylGWuvpx9lv+NcSuQ2Rh
        ryEOT13BkrzM31CFIHvhw4JwL3MkM6vj2qTNUe23awF5kEFcHcP0aaIQ7PRWhlFr
        D/Mu6jyuqZ9Xp6MLlvX4YA49Npn9d1LL9ogh4KBO31yfokF2ktREPCaXR2ayKs68
        s1WUSgWfVKatZLhCMKWx6l+hx+Zfd9nmFMaNlefRRt/YyGbeQa/3PZjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=1+O+BD
        4KhhqplVX1DfTshC/FNHBhlW8RmbwpMMquOa8=; b=GJQN8NyXRTlp29mWRRs+75
        wFVrdTHU2pkQNAFz6z3BcgRl8kn4sZm59saeGqiD5o9pGEqVJcJKZgi2O8EOgXqW
        zatRnyRQ0Xjy9zHVelvIaqv61R/TUtRkSbWSaRyv3sFJ96f1ke7df9S3orAkuX0/
        nbQ/jsg7PyD80Q7K7BconJAhYj7qE9ky+wfLfo0PmL8Bt4gnrhbVv9MPtvctk7Hg
        tIAAZ1Nsq92R0Xttv1wuQB8ac/TOZv+DbVvRE8QdRH2YhLAvkz2UIOgW28rXtvh2
        ZTTZZ0VeaBwLLYfMomPxCwmX5rqqa9u7kcNMr7nqvXvfWG+Ut6XKLtXLYlDEQDtQ
        ==
X-ME-Sender: <xms:NpfuYWsWhwhkYFPwV17Fpn7NBT_rtVhMlGwklqNdsk-zzhzhjh1r3w>
    <xme:NpfuYbfJQrwFyN7soFJU3GDzvdNw4O4ZD7E3X3X16q6xTRm7DUAI0VTQOJXuETyf7
    dBr1vb7RsbcWyYoeQg>
X-ME-Received: <xmr:NpfuYRylvsdL8ooqHIvhx0I1Oru3OuE5dAe4wFXsGb-p4Em4sxgn5Stbh8Qwt9glHjPG5IdS8AqqrOGzlmZo9X30H_5iU0Hd9h1Q5L332Nj4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrvdeigdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:NpfuYRPhNhf36Gw4UkJRy4utaidkZK8co1_NCToqc3MJB_XyvwgoZQ>
    <xmx:NpfuYW-rXGRKjP2hg9M87N58wObcvBIFPYsyqn1hwOhZOANG-Rafug>
    <xmx:NpfuYZVUtcqL1IL3KvtGPW5uOBwG2FMw2kvQr5sWmpy31J9AaGlMBQ>
    <xmx:NpfuYWPnZgfSOnEO6B0sKi4q5CoCv2f0M5z-tMNU54JxebmyDrhJjw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jan 2022 07:10:24 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     broonie@kernel.org, robh+dt@kernel.org, kernel@pengutronix.de,
        lgirdwood@gmail.com, lee.jones@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-imx@nxp.com, rui.zhang@intel.com,
        alistair23@gmail.com, amitk@kernel.org,
        linux-arm-kernel@lists.infradead.org, andreas@kemnade.info,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v18 2/8] mfd: simple-mfd-i2c: Add a Kconfig name
Date:   Mon, 24 Jan 2022 22:10:03 +1000
Message-Id: <20220124121009.108649-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220124121009.108649-1-alistair@alistair23.me>
References: <20220124121009.108649-1-alistair@alistair23.me>
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
index ba0b3eb131f1..e0d2fcb10a0c 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1188,7 +1188,7 @@ config MFD_SI476X_CORE
 	  module will be called si476x-core.
 
 config MFD_SIMPLE_MFD_I2C
-	tristate
+	tristate "Simple Multi-Functional Device support (I2C)"
 	depends on I2C
 	select MFD_CORE
 	select REGMAP_I2C
-- 
2.31.1

