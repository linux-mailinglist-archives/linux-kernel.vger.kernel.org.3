Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F6555A567
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 02:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiFYASE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 20:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiFYASA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 20:18:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137EDE3C;
        Fri, 24 Jun 2022 17:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656116271;
        bh=cLxJQWmf88S/+nPbJ0VZCgg17GshktmH/0yWyalFWok=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Zbdo2DGOiEsR1LZq47TDGCUixYgGYZ4aKdejmEjlj8dfsy4JW8dNx2kWXLh46su02
         g/X+niRp/B8q+PmWiWfGzcmCId+M0wlCy9j9Py8sZh0Ja4Y/XmHa6mzjMnNqJ+Q4cC
         J+RgJSfEslFpIZqgbf4Smg0mP5oczPQCx8Vhfkcs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([188.155.157.251]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MSbxD-1oG8yU2sZd-00SsEa; Sat, 25 Jun 2022 02:17:51 +0200
From:   Lucien Buchmann <lucien.buchmann@gmx.net>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lucien Buchmann <lucien.buchmann@gmx.net>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: serial: ftdi_sio: add Belimo PCI ids
Date:   Sat, 25 Jun 2022 02:17:44 +0200
Message-Id: <20220625001744.28055-1-lucien.buchmann@gmx.net>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bkB1zQGWN1TVByc871uAGQHgqnMq+K+r4ZScWjOTwZNQHmqRybR
 JFp126jABfvPfFobmCvPXaDwk32cSZNzFWE5tGCI1PMpK4TQi+Gv/+srJKpcET9B6X2RaxJ
 0aPbbcgRrDYUcZWvS4NYC0xEtTNGEqpKuTpsdZX+No4AN/sIbFR2RSyyETO9tlIP19BdMcn
 2NEJEeyD1lSeYAq9S3aVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vTQGQqjWfco=:G4Y3B1Zl/H+xNEkDoohsIX
 Lg9KyxMBAYwc5HrtfCp0wgAZVLjwFdAcrI0jNRtnHtu68LtimhtGaRf/X/lejr97RPeN12mpI
 zdjstke0CxuYtFdg/xiFIQLju8jLdstAKwC0ykqv1Vaaxkqd25tdDhTmM6C+DYUT38dmfqdrh
 Q1p7g0th2X7nDNFL5QGCZqgJQpgmhU3W1bLru6lZhuuBlHT9nlYGxIQHXL20sKWgYx1j2+F0k
 TAd09735zevv5B+sk0ay8QPNuOTwE4DK0S9sfTdXHjx41SqIy3jHZyD4KA1wsF3caeSTWN7B/
 ZnZNcKUSLPPJQc/+0Cji2Vd+hkKvv8z0qD67DBWYGRDB4UGxkMW693PocSQaZmwTsOV7VisLU
 bXg+OHXFygdLYu3fYMdsjJsE8gDr5BjRsehBL0gMlXewTa+GRUmF69mGFggUU/QFkqLnwsk9U
 xism02LZnnJAlxqbLmpOUm9Qz4MTRn32v2thzNXN8F44xrcML9q3gOz//ElT3Laj5qRqpBn1V
 YPZwyUJL2v/qTUFOXsKI/dCXeC1cDgRCWbh98ZRxlggQqjjJzNw39L5cyHMsJ5YInHW+y8a58
 uodkxu4COjN2cZeESBypcGVi2AQxzo5YVMZ0qh68UtEm3uvQVUJXr7CoY5RGV5Yzfncm4Bpjo
 I3r9jPoYgdeQaMTbFGlVIBWVkwhMsgNdwPe9pRWkKDHosM7xrqDvEdUIbL99xZfQTn7iYG2TT
 QgmhtN6bqo/v9nw3e6k9BUdi7S1cfXdTVNzjbPLZxbGaofv0ybC3AmmnqVV1mPcLqLe0Vbcti
 i+vY2QjCyqUWUuDOgdTP02KhlGeBe4rrBm5e9T0CspwFcn/bybV9cVVvnkJ/NpRu2sdsO4JES
 yTQeOxxdyV9l/ubj79ZSACL3p+6Yjc4Tv4996f70VSKONLLU+dAACtHBa92Yc4E3ep4KEvxbD
 MiJhBQlbwgW4QxUzohU+XfrSu5tSSIMjzWMq3qmFIuOyRXmt5hx2xPaG8czzre0XxU0HEKmCP
 lQOKCQeTtsz+MGfLjL7cNsrYvGyYyu8F7hXVkxKBvodd9FmaM3/GXlh920/eMzACGIMRko4/c
 O6f1JptiDzFri3Y1VWl3tBYQgXvboWHYgA9skEJrgG/NzWYexnP9sggew==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those two product ids are known.

Signed-off-by: Lucien Buchmann <lucien.buchmann@gmx.net>
=2D--
 drivers/usb/serial/ftdi_sio.c     | 3 +++
 drivers/usb/serial/ftdi_sio_ids.h | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index b440d338a895..d5a3986dfee7 100644
=2D-- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1023,6 +1023,9 @@ static const struct usb_device_id id_table_combined[=
] =3D {
 	{ USB_DEVICE(FTDI_VID, CHETCO_SEASMART_DISPLAY_PID) },
 	{ USB_DEVICE(FTDI_VID, CHETCO_SEASMART_LITE_PID) },
 	{ USB_DEVICE(FTDI_VID, CHETCO_SEASMART_ANALOG_PID) },
+	/* Belimo Automation devices */
+	{ USB_DEVICE(FTDI_VID, BELIMO_ZTH_PID) },
+	{ USB_DEVICE(FTDI_VID, BELIMO_ZIP_PID) },
 	/* ICP DAS I-756xU devices */
 	{ USB_DEVICE(ICPDAS_VID, ICPDAS_I7560U_PID) },
 	{ USB_DEVICE(ICPDAS_VID, ICPDAS_I7561U_PID) },
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_s=
io_ids.h
index d1a9564697a4..4e92c165c86b 100644
=2D-- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -1568,6 +1568,12 @@
 #define CHETCO_SEASMART_LITE_PID	0xA5AE /* SeaSmart Lite USB Adapter */
 #define CHETCO_SEASMART_ANALOG_PID	0xA5AF /* SeaSmart Analog Adapter */

+/*
+ * Belimo Automation
+ */
+#define BELIMO_ZTH_PID			0x8050
+#define BELIMO_ZIP_PID			0xC811
+
 /*
  * Unjo AB
  */
=2D-
2.36.0

