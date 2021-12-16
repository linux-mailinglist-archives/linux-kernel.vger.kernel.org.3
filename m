Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BAA4771AB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbhLPMZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:25:52 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:54475 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236373AbhLPMZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:25:49 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id C82505805C9;
        Thu, 16 Dec 2021 07:25:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 16 Dec 2021 07:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=mo4lDbGJIutF/
        EfV6ESK2Jau5DqaSfJJnyr+9T7QDB0=; b=DPRr2mIEGraDdvHaP53C5c7dnC6tp
        h6WN41XUue4Kw/HLiNSMmKGvCWSMR/vBnN0oN1tJEyFbqG+25d/bWEMuP/i+ePBw
        XUINPdpWlGXZw4KekOMZAaBNymDWibV1K80TNHTdcVTgotzzLvKbWYq9SED9LzwM
        n7eXSLBT/mD2IdtintGyXft0Qi6wUV8fvmmTqmQZarEgHCXqlYHQTblqM20E0bmh
        C0a0tO15OCp4S6646Q0okc39kyPiDIqmcOGEZaqZvl7Iq2EHQsDljmj4BtRcawhc
        50I+iJ4QSmhyQj9aMS+xwcEwDrzY2rLujPkMYdzrBctCq3fx/Au/Es9PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=mo4lDbGJIutF/EfV6ESK2Jau5DqaSfJJnyr+9T7QDB0=; b=cVbjrnCt
        kf8t3duB2D32OuiWddoai+r05zCXR0p6Sq5H4M17nGjLylymQ8zk6BwOxz2sfOkW
        NOzQk31P0HOWvaed5DIz+mfjzPvKZ6Z9t8xqLXkZai5V1d6WYt1P15MrCj7/1tKI
        OhbGIRMjysbdQTE9r10ZvveROXYpMfZ9WYaAWbpsvZei4sXAuTSOIeW7oe6RlLB5
        L5jkFXT2T7MNjyMZSYr8lEvD4ILa/D6Rde8WWib47Yh8+0Ui7MK5msCWUnCOf0uv
        SekQYekEmdVycufAd60f+Nn78P86VjImxYUvKWK0catYuZjjR9IYDWRVAvbiQYXK
        j9woyUALJ6Ox/A==
X-ME-Sender: <xms:TDC7YT4U1WC9pzO5msti8pOgGjddvlgYwg1Rno4pXHA_xYE8cSdv7A>
    <xme:TDC7YY5uB2AH46RuA9V4ChyBqPzN0nDtHJcfVOt-1pPbUXGfJzfZK0_9YDw0Mf8n8
    19oPUEybJ4h_nvY8KU>
X-ME-Received: <xmr:TDC7Yaf-xZZkdLqFFGy7ANBC8D0ukFwK2x3wdyW8WqujZ1qZ522IosYoUFqTR54xuYtqA5Sb1g6nWRYIH-i4HOoGxUZFSDAvV286d9ucYyO7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleeggdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:TDC7YULj7u37Go0YB67qnU0UuBdteCFp8_WMdoYBWHmVDWI3ZOfFng>
    <xmx:TDC7YXLT_-fPXl82GUawibFJnaqq_DOh1VPTXJGiO6NsgrNjBDqtoA>
    <xmx:TDC7YdwP5OmCWzIUYDCmzr8KrfYiyf6ZhcAfEpa102WbKcHRN8alkw>
    <xmx:TDC7YQ6YARyGCmv7GgjkUU0CZZbWOCr8xW5YyolpP477yZK3VHF1xQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Dec 2021 07:25:42 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     kernel@pengutronix.de, lgirdwood@gmail.com, robh+dt@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        andreas@kemnade.info, linux-hwmon@vger.kernel.org,
        alistair23@gmail.com, amitk@kernel.org, shawnguo@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v17 2/8] mfd: simple-mfd-i2c: Add a Kconfig name
Date:   Thu, 16 Dec 2021 22:25:19 +1000
Message-Id: <20211216122525.136139-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216122525.136139-1-alistair@alistair23.me>
References: <20211216122525.136139-1-alistair@alistair23.me>
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

