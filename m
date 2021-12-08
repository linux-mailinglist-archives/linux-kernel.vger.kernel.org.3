Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB94646D37D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhLHMol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:44:41 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:50367 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233637AbhLHMoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:44:39 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id AD7C6580365;
        Wed,  8 Dec 2021 07:41:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 08 Dec 2021 07:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=26DZ6/M3MgY9T
        a1v7+h0aelpWpuLYRAnVemoNeSeL34=; b=nFBPQMZbNtD9OSoswld4gCf8fKmND
        XsVi0MEr7yGQ9sCbf1MkFiryDklN/cAoRDC6W/qCgFOr3XLT6WGh9ZTOgqD60K2Q
        V/GXuYMQUDHTrkd5B8lAtXNjuIo53wRxFOYjxAks8vTMIVkgZXwIxspClf0O4dx5
        ECyOee0JebA4exMM7l+Tera85Vh36yTRJjtz9LUd6J7//dNTRGnNjmRrpS3BpOV7
        djifjimGMaf08Efp5XvjScWvS02hfDNXyhbi7WAFNMLvJquevqdK9gx5Srm04+vU
        2CQHVJqND4RrDICjwXV4KA6SXawqR2f3tzzYCBMgSDU4ihrQn6nS+lidQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=26DZ6/M3MgY9Ta1v7+h0aelpWpuLYRAnVemoNeSeL34=; b=YL1sR1ZD
        T5HhvV/vS8+1VSQhvQpvv4Ocvvq1CnqLGW3RykeMD4sFgWYnlPPkQ2uHYXVdy1h7
        hqIxNVe0HYe4Wlzv1qseDB8Mz7h1IsmJTEJERYmCnNr1KBELJ19msUwalEgkqV57
        GaR+yTMg57I7W6QbxR8GiGlhUA1FB2HxHilRk76LgnMSkSPnaUoliKhjPLO2TB1q
        Ei9jt0uQ7Fu6FWeIuYIop7gf4ROK5gUj1Eo22xUrRc24M4+r9wMs5PX4yJBXnGGp
        /XhgeuA8sg+ehzQYVoJz038YlYUhvLakHGnmU0MKoGla/cgqUFODLnaVHGyQeV+H
        BW3gKBnzQjY16A==
X-ME-Sender: <xms:46ewYaPny0UfwPix1czycd5tioeuuumurvVhDIXjG4wkYtTBSZLtow>
    <xme:46ewYY8uKBaUPyMLbNZZLci6Fe0xKCQgfJFROMc5Ji-E-qX0vfPZ_XOJtGZ9_r4dT
    Z24GyQIbdt-JXLiijg>
X-ME-Received: <xmr:46ewYRSlJG4KXjyH51ehMrfSYYAb-u9Q7UHyXP7reW0RHjEo5IqfuUsNNPFWqwgmWHet66s3bMk2znWFlOcdx9FGrQvuhxQgIc8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeekgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgr
    ihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqe
    enucggtffrrghtthgvrhhnpeeggedtteejkeeggeeugfehueevudegvdetjeeviedugedv
    tdekffekhedtteduhfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:46ewYautPZ3TQKwfulmC83GoyVmGq6s2bh7TfCaica17jpskbixQvw>
    <xmx:46ewYSdYMv2EiiNGJDK8kA8xXUw2fXuuU-dAxcLfF0KjQZGgnaRaEA>
    <xmx:46ewYe0ufaB4ZTnWY_HUEpoUy8EMe7xYcut7HHeT0UN0eJNUDELeqg>
    <xmx:46ewYe8sp22SDsVeeIunxakq0hBZ286TQAQje-0ZS6ipX0Cc2YDkCw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Dec 2021 07:41:01 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     s.hauer@pengutronix.de, shawnguo@kernel.org,
        dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com
Cc:     jikos@kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, Jason.Gerecke@wacom.com,
        linux-imx@nxp.com, Ping.Cheng@wacom.com,
        devicetree@vger.kernel.org, martin.chen@wacom.com,
        tatsunosuke.tobita@wacom.com,
        Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v16 2/3] HID: i2c-hid-of: Expose the touchscreen-inverted properties
Date:   Wed,  8 Dec 2021 22:40:44 +1000
Message-Id: <20211208124045.61815-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208124045.61815-1-alistair@alistair23.me>
References: <20211208124045.61815-1-alistair@alistair23.me>
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

