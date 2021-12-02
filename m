Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2804662EC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357528AbhLBMAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:00:18 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:56551 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357516AbhLBMAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:00:06 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 13A685801C3;
        Thu,  2 Dec 2021 06:56:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Dec 2021 06:56:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=26DZ6/M3MgY9T
        a1v7+h0aelpWpuLYRAnVemoNeSeL34=; b=qbPwQzzImtvXmN+nIkzCQiE/Weo4N
        kX2pqBgxepoShTAdmbsf95DweeOYu2L5tDbxLLkldL3URGrjMvr+TPIBcRANOINe
        DB8TkWS//Q9q8A8yWhwM0Cnq0n/CaYP9SdNM7I41cdp2+zD9vjxgrRursbb4jP3q
        Xpwrbk6abtP935Y019KI4TZ5pscXQJGuY31Xr7AZyNcNiMAnWlO0ZWn/d9DNNjap
        sY80I+1WzT/diHpZjZA70dyAqQZAY4APWgsBKVMfEBPUX9ukQb408pEf5C6YBohK
        Jly+9IXsajTv6CaCLQdz6VuYYBs0QCdR/XYMYbKSICvApUVvr8p1TaHWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=26DZ6/M3MgY9Ta1v7+h0aelpWpuLYRAnVemoNeSeL34=; b=ARmz9XA4
        847OSTnv9BdNptn+VAawsdRjCI0a/JJJ5pmS2dP0XB3o6eRlOq7u8IhWtzOO7Agg
        wwjBIXkdk6tfJNDzhwH0j4nWdhI65d/SEXY8U89pcT8JOfI1Lzih/nUaOcpCKMzn
        aLmoXX1gHqEWuArTBD2OVnC16biyDRUEMksAINYdih/jgwF6atoXlVYOTX1LJJok
        PfuARV82nMNffWwbwpaBBTPcGxvxTfoSyyyFJO3N0tWtMzBjlbfs17ORJQx5hj61
        zrHPU7ZJHO4SgNTuCHlusQrUnQ0lmIw4ydQ5YrtOkkrlfbwBg449fhcVzKVqNQnm
        n+H0oY2+pr7TFw==
X-ME-Sender: <xms:erSoYXhdYl_T9hD9_x0sri3k3zIowigm8037-KFpOwxbZfLdVxvBkQ>
    <xme:erSoYUC4cX_ptL7X5Z4JUqgDrCj8n7JiFmGuJ8RAn13FqeGbIIyDR9p5cmjPYB5LK
    fSUVR5MqkqqXfrj2Xc>
X-ME-Received: <xmr:erSoYXFLVcF9cJJJCFlVRz2B9lfC3FOHOTknJhKxczNl6AtC9hi2C9BjObyZTPfLglCgWVJ0rYAy0TFTLet3pHK3nFznNTtX5goBXii6nYVaP9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieehgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgr
    ihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqe
    enucggtffrrghtthgvrhhnpeeggedtteejkeeggeeugfehueevudegvdetjeeviedugedv
    tdekffekhedtteduhfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:erSoYUQRKMLQRx9egQnS9vj5CEFzZ0NaV2KFL0jL4ladIHs5jQiQ2g>
    <xmx:erSoYUw2hsmuNbDgI16_2-qMHDxKsFUQ5-tE7bp-e1ZRBCK2-pk2CQ>
    <xmx:erSoYa4C5NmANYM__kJGCfhdxh95zhJSDIRYm2QK8BBabUlpYXrrmw>
    <xmx:e7SoYQAyeWcB01RKgJhdvUe_1_cNUgsHc_9ZfiyBfM_Phxn4qa69VA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Dec 2021 06:56:37 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     benjamin.tissoires@redhat.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, dmitry.torokhov@gmail.com
Cc:     Ping.Cheng@wacom.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, alistair23@gmail.com,
        tatsunosuke.tobita@wacom.com, linux-input@vger.kernel.org,
        Jason.Gerecke@wacom.com, linux-kernel@vger.kernel.org,
        jikos@kernel.org, martin.chen@wacom.com,
        devicetree@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v15 2/3] HID: i2c-hid-of: Expose the touchscreen-inverted properties
Date:   Thu,  2 Dec 2021 21:56:21 +1000
Message-Id: <20211202115622.40153-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202115622.40153-1-alistair@alistair23.me>
References: <20211202115622.40153-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the touchscreen-inverted-x/y device tree properties to control the
HID_QUIRK_X_INVERT/HID_QUIRK_Y_INVERT quirks for the hid-input device.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/input/hid-over-i2c.txt        |  2 ++
 drivers/hid/i2c-hid/i2c-hid-acpi.c                    |  2 +-
 drivers/hid/i2c-hid/i2c-hid-core.c                    |  4 +++-
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c               |  2 +-
 drivers/hid/i2c-hid/i2c-hid-of.c                      | 11 ++++++++++-
 drivers/hid/i2c-hid/i2c-hid.h                         |  2 +-
 6 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.txt b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
index c76bafaf98d2..34c43d3bddfd 100644
--- a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
+++ b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
@@ -32,6 +32,8 @@ device-specific compatible properties, which should be used in addition to the
 - vdd-supply: phandle of the regulator that provides the supply voltage.
 - post-power-on-delay-ms: time required by the device after enabling its regulators
   or powering it on, before it is ready for communication.
+- touchscreen-inverted-x: See touchscreen.txt
+- touchscreen-inverted-y: See touchscreen.txt
 
 Example:
 
diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
index a6f0257a26de..b96ae15e0ad9 100644
--- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
@@ -111,7 +111,7 @@ static int i2c_hid_acpi_probe(struct i2c_client *client)
 	}
 
 	return i2c_hid_core_probe(client, &ihid_acpi->ops,
-				  hid_descriptor_address);
+				  hid_descriptor_address, 0);
 }
 
 static const struct acpi_device_id i2c_hid_acpi_match[] = {
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 517141138b00..4804d71e5293 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -912,7 +912,7 @@ static void i2c_hid_core_shutdown_tail(struct i2c_hid *ihid)
 }
 
 int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
-		       u16 hid_descriptor_address)
+		       u16 hid_descriptor_address, u32 quirks)
 {
 	int ret;
 	struct i2c_hid *ihid;
@@ -1009,6 +1009,8 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 		goto err_mem_free;
 	}
 
+	hid->quirks |= quirks;
+
 	return 0;
 
 err_mem_free:
diff --git a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
index 52674149a275..b4dad66fa954 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
@@ -150,7 +150,7 @@ static int i2c_hid_of_goodix_probe(struct i2c_client *client,
 		goodix_i2c_hid_deassert_reset(ihid_goodix, true);
 	mutex_unlock(&ihid_goodix->regulator_mutex);
 
-	return i2c_hid_core_probe(client, &ihid_goodix->ops, 0x0001);
+	return i2c_hid_core_probe(client, &ihid_goodix->ops, 0x0001, 0);
 }
 
 static const struct goodix_i2c_hid_timing_data goodix_gt7375p_timing_data = {
diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-hid-of.c
index 4bf7cea92637..b16349d6e9de 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of.c
@@ -21,6 +21,7 @@
 
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/hid.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -71,6 +72,7 @@ static int i2c_hid_of_probe(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	struct i2c_hid_of *ihid_of;
 	u16 hid_descriptor_address;
+	u32 quirks = 0;
 	int ret;
 	u32 val;
 
@@ -105,8 +107,15 @@ static int i2c_hid_of_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
+	if (device_property_read_bool(dev, "touchscreen-inverted-x")) {
+		quirks |= HID_QUIRK_X_INVERT;
+	}
+	if (device_property_read_bool(dev, "touchscreen-inverted-y")) {
+		quirks |= HID_QUIRK_Y_INVERT;
+	}
+
 	return i2c_hid_core_probe(client, &ihid_of->ops,
-				  hid_descriptor_address);
+				  hid_descriptor_address, quirks);
 }
 
 static const struct of_device_id i2c_hid_of_match[] = {
diff --git a/drivers/hid/i2c-hid/i2c-hid.h b/drivers/hid/i2c-hid/i2c-hid.h
index 05a7827d211a..236cc062d5ef 100644
--- a/drivers/hid/i2c-hid/i2c-hid.h
+++ b/drivers/hid/i2c-hid/i2c-hid.h
@@ -32,7 +32,7 @@ struct i2chid_ops {
 };
 
 int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
-		       u16 hid_descriptor_address);
+		       u16 hid_descriptor_address, u32 quirks);
 int i2c_hid_core_remove(struct i2c_client *client);
 
 void i2c_hid_core_shutdown(struct i2c_client *client);
-- 
2.31.1

