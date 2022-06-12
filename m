Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDA9547CEC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 01:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbiFLXWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 19:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbiFLXWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 19:22:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D154707E;
        Sun, 12 Jun 2022 16:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655076132;
        bh=NCg0owc1+e7i6CzrGr7pXzriqT7EIvm5beku5O6o7jk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=T1j5k1bilErWHYt0TUu0m2fA0QEyXeQL98uDRj3DK3wfVrQlF8XEfPK6GY4W/ACRE
         H4QX3W8YX/IDz69Fvqyf/W4m3OApnk1/at++k89USPSUDKzU3p2supyY0r7i67fQK6
         Olboxh4IyU7KnWKLZRKgUxDin2Zf1vdpAg0ihvr4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N5VHM-1ngD4I1Ha6-016vNA; Mon, 13 Jun 2022 01:22:12 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (dell-smm) Add Dell G5 5590 to DMI table
Date:   Mon, 13 Jun 2022 01:22:08 +0200
Message-Id: <20220612232208.27901-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lvN5PFNqrRdbqRUoWptpSHnZLEW7j/SnKX98ucjMjFjepgOIIpn
 KjgN4A70Qoj9p0ShD/1x2qNBen8anP97cA4vEpFQYBO6KUnPH7p6mAYL947ewuoS5OZj6zS
 0+wuRc09CNNdHSkx428ktWU48dZ6AT8u9g1yDeW0TUHYHFHWtYeorZU59JtnMaOzN+dRK23
 QeTmAfYmu1ZC7UiNddwdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3FRBnyiUyfE=:/vWwwmEXW8/6oyCdbOtMAX
 E/JvRNNJu2ZMVZmHh4G4Z8q+agwNFQsqE/c63y9+guRUtQPfmjL2nnX+o7wkQXLMVF189+Vam
 ZaevL88thSXFXOBwIL2OTOaogagDbzVUUQ/PfJe90y4f9z+lqMYu1i9fjzth+6UGRU6Ye0vGY
 x/oYOMhw7riXdcVy1xj+OX3WXuvU6pyElPdHDBcVn1B8ZUb+5sUOi6rvYrtmnMM1D0MGxMP3O
 s8DKb98AY5twRqtssL2i+ZHWrTFWTBYLm+OUoiLsN/Hbxe1cQPAHg68KCtc+l5Yf5Qo7OScr6
 TTnEXo7+5WqnH35UCqaT1QlBxJFOaJlP4iNA9oZsmxSLGKgrei/pPLnW7JA6LtlcoQvwItqxg
 Jo4F5fXrFUHvJEeNf91pR19yL5sfWO/cmP/lVHcc0ghPhyPBET64cmHp1QKsO2ST3mXvh4yvP
 nfxKigNeUB89YFRoKfnZrSBpfDMf3siBJbZBSi1UY2jk/G7c9nvc9Wt8V80Gs5QZVow38GHr5
 YPK3MsSHd3B6MYtbrvkS3VP2+ds7PUef9Da8xk6x1RALFjWWJZMhPHEaEFUpH0ytE+kBAPffm
 /i90N10j5Sx5N68yXB2aXgnYPXhGzGWwUZJHdhYfjPTwzxLt9QXxA/v3MGr2qBHVS8upVcT0P
 laXMSX9YL32vjaxyJiWyiv8MEmiRCc4LFxaQpc+ddNXQaKndmxoRbhF1OhlxD38oEUVw95Yun
 7nb7G1gr7MHMVrvofo3zxv3F5dLsWnwUTKoy50qyGqqAP6j1iwqJAUNCLoTdUjw9OAhFK0Uvb
 a0nHTXRfeloG6NdhZ+sNE6PJvepL5xImD+ez0QOs+tkJGyWI9teIdqWYFGqNELqrEHFAzbCXH
 5ezX4V0OK+WBlKL5R4ioOd0helzsiPyYhCqbncnU/fVNavYqSnziF5MWhTr7XPvmwCL/yJa7L
 WMLZt/gKFG0oC7ZIy6Z7ZRQ0AaZXf1C6QrIHSH2dLuKJzSHEwII2KdGzR7q+iURaXd8x2C7TP
 0hBiWR1rh69Q2FureFdBdPg8TD5nVGHHgP3Ddvsa0YKumSQj5QAf07T01+WDw8jo2IMWMdBeJ
 WvawnBGPo212lk5qIrQ5CQeD9YPUbZj4sp6fFg808NQRa6yeRcQs+tphg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Bug 215983 at bugzilla.kernel.org,
the Dell G5 5590 supports the SMM interface and
can thus be loaded with ignore_dmi being set.
Add the model the DMI table to allow for
automatic loadig on this model.

Compile-tested only.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 16c10ac84a91..d419885dd771 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1131,6 +1131,13 @@ static const struct i8k_config_data i8k_config_data=
[] __initconst =3D {
 };

 static const struct dmi_system_id i8k_dmi_table[] __initconst =3D {
+	{
+		.ident =3D "Dell G5 5590",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G5 5590"),
+		},
+	},
 	{
 		.ident =3D "Dell Inspiron",
 		.matches =3D {
=2D-
2.30.2

