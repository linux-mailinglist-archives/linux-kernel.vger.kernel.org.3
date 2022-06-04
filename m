Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF8253D8AF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 00:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242189AbiFDWCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 18:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbiFDWCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 18:02:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E86C2CC86;
        Sat,  4 Jun 2022 15:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654380129;
        bh=44yWatpj6wF86Z5uuPLeaz6RdApHV2+/i3FmWQnXmvI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=G+kIX1qWg/0AX2kkQvT7kvb0wtWTuks1zLYqyQKLjPBB5zwvUfmDTlbtaHZIG6xF8
         0D+byMfqolnAVXf1pjKvvkvB3Hyg7k0TY3zLOkeKcimV+FkP2fp0r6mYSudGofoVSJ
         IXDC2m8QiasQpXFXcSnoVYK9pRpbJyZ7NIcmbpeo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Md6R1-1nNRsg0gFv-00aACb; Sun, 05 Jun 2022 00:02:09 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (sch56xx-common) Add DMI override table
Date:   Sun,  5 Jun 2022 00:02:00 +0200
Message-Id: <20220604220200.2567-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DP0Yr2k96AiTqZa/hhjr79M75ptPoiB0bWzo8EKAoGumkIjVrUB
 yQDYeSZENXdRH5kQZ4h4DpQu3d2yD6IiUMu0+Ue2TlXyvw11yu1U0Q6OegTfYlFqgC9CalE
 h+/bsFQlVBdToR3rQl12mah2JrPz3JdYdzVZdQMBo0ZbLUzqIRRhY49TP+O69Hcr75+jRsN
 HKWKlDbjzZvcKBwrD99QA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yXcKc3RzeoA=:kHm0lGvUkrH9CFOUS6FRz6
 dSOu/ZDI+10/Kuri0ftZnOjsBe8NsmQXzC7kEjIBrYbY/a43NfyfEHiEtZsGOUVggNLqgXrBk
 WpT++gnsW/jLSBQCfNA/4PhlJNwCgxTLErBrbVmuanTeJLmHNOiO1e4A45eZ3pwIQEuYacbio
 i+9cRX8jFZDCJKdoJQlPIXhpDaAmu3VbDv1dPJzxEqEQcIDahLdUftnVqyxZBsr77ORW5P+Ct
 O61e7APVCIzl6rrp5EI5hPJ3RkfR/L7NcrR4SkxAQ4xIYsVvGAIfCkmGZrnosB+pZVNfJzljQ
 rb9jlHaeCe3M++W0lSrgBs0Bwb1rkcOOpeACLlmz2XiYWqSBOlVzMEKKXvjhxyWbdJzqFOavx
 ca4/KcdFgc6Deu1GQhn7t+QB4qJnRij/2DaUx9+Tl7ZqVcybkeBjwTXhX/ey4iLD5xPb1IKEq
 bkZqvd5kAuBbWEaQDGkFqiaOzC9m65qc6e+u8kuqYoJdU7x9VD+ppaoKjxtBGn1ZWxwTqZ7Za
 j9ybpZc+MVDglF06U856d+LqOp8iCo7fpjsxUboqVAuN1GeEVg/LUH+0Kqab7FTkNzI7FGVXb
 P6YdfgNiwa9AICvBYnIaCOltegyTCncJABKtJmmyhqUuiIhOd54mzmgrzMo8Arq/WRDzB65f0
 6UA+FEmCKg5SrKeSx1AfA2EzV+kbhoPh7q26E6Bqh/PWT3AhQsjTJoit04QWZxxYI8TB4z+aJ
 ZYpUvAzfBfWogOC1upm6eL3mG5jG+pXsxno4eanF+HJ38gL+3OkzTh+moXGKBf47Q2yQrOvEZ
 9+UyCTUmRMkwFrRjexnKaNZ/r+LYtSLLerhTxXrBIq8Wfzw0CS0WrVSSc0tEK7u5FU8A/VW8c
 XncYVPgWYKWWpY5b+77dph0fvjv4OJfF+P8mcMGAMvbpr2nXlaLFcRvYv0d2V/T4t7zyVJvtI
 OYbYbx0iaDBlvwGAOJvhh1mEg74GljvhZlm3mYQy37zZJW79Yw25lehyUwi9CBlma439mwUoH
 vuMkKkzqkXlRrwqXqYpSjUYOcM902IVKqmd6mECEhFdUfc525utxHlMXdH3nLf308h1N3EzPL
 eUiyUNrWUT70JxLZYuP7V9nkzm1XyxhZjG+OW+vqpqbYC0SeWN8uaLsEw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices like the Fujitsu Celsius W380 do contain
a working sch56xx hardware monitoring device, but do
not contain the necessary DMI onboard device.

Do not check for the presence of an suitable onboard device
on these machines. The list of affected machines was created
using data collected by the Linux Hardware Project.

Tested on a Fujitsu Esprimo P720, but sadly not on a affected
machine.

Fixes: 393935baa45e (hwmon: (sch56xx-common) Add automatic module loading =
on supported devices)
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/sch56xx-common.c | 44 ++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common=
.c
index 3ece53adabd6..de3a0886c2f7 100644
=2D-- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -523,6 +523,28 @@ static int __init sch56xx_device_add(int address, con=
st char *name)
 	return PTR_ERR_OR_ZERO(sch56xx_pdev);
 }

+static const struct dmi_system_id sch56xx_dmi_override_table[] __initcons=
t =3D {
+	{
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CELSIUS W380"),
+		},
+	},
+	{
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO P710"),
+		},
+	},
+	{
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO E9900"),
+		},
+	},
+	{ }
+};
+
 /* For autoloading only */
 static const struct dmi_system_id sch56xx_dmi_table[] __initconst =3D {
 	{
@@ -543,16 +565,18 @@ static int __init sch56xx_init(void)
 		if (!dmi_check_system(sch56xx_dmi_table))
 			return -ENODEV;

-		/*
-		 * Some machines like the Esprimo P720 and Esprimo C700 have
-		 * onboard devices named " Antiope"/" Theseus" instead of
-		 * "Antiope"/"Theseus", so we need to check for both.
-		 */
-		if (!dmi_find_device(DMI_DEV_TYPE_OTHER, "Antiope", NULL) &&
-		    !dmi_find_device(DMI_DEV_TYPE_OTHER, " Antiope", NULL) &&
-		    !dmi_find_device(DMI_DEV_TYPE_OTHER, "Theseus", NULL) &&
-		    !dmi_find_device(DMI_DEV_TYPE_OTHER, " Theseus", NULL))
-			return -ENODEV;
+		if (!dmi_check_system(sch56xx_dmi_override_table)) {
+			/*
+			 * Some machines like the Esprimo P720 and Esprimo C700 have
+			 * onboard devices named " Antiope"/" Theseus" instead of
+			 * "Antiope"/"Theseus", so we need to check for both.
+			 */
+			if (!dmi_find_device(DMI_DEV_TYPE_OTHER, "Antiope", NULL) &&
+			    !dmi_find_device(DMI_DEV_TYPE_OTHER, " Antiope", NULL) &&
+			    !dmi_find_device(DMI_DEV_TYPE_OTHER, "Theseus", NULL) &&
+			    !dmi_find_device(DMI_DEV_TYPE_OTHER, " Theseus", NULL))
+				return -ENODEV;
+		}
 	}

 	/*
=2D-
2.30.2

