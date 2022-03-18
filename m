Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155804DE11D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 19:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240179AbiCRSfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 14:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236954AbiCRSfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:35:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB44171790;
        Fri, 18 Mar 2022 11:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647628451;
        bh=ZtsPop+g0Zry4luXEYbjWFE5Bk+3qkCDzOGOdMK8b/w=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=RXj7qCmnq60WouHAUuvXOF3hB3i3YeTYytPX0akdz0CQ8Xusy/PFAzii4Qm0im8Sf
         PZqfELdAhmvLkTFhnYE199d7EizFJfJy03/tD6bdBsVRTZQEs9coW0992uHvqCAZzh
         IbaisNPXeKPQgXTD4l9rnZ4sHJCwW2SrFS0kEddk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MNbox-1nlQjo1hyl-00P6qY; Fri, 18 Mar 2022 19:34:11 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (dell-smm) Add Inspiron 3505 to fan type blacklist
Date:   Fri, 18 Mar 2022 19:34:08 +0100
Message-Id: <20220318183408.13286-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LtUJNltOgob3JcDmitMuumEm09A/7QK9hg/LmVS7cmUXKk2SJO8
 7RdRvbZ9WvixFupTeb89WbPAKctL7Hhc14Aj/PeeVsJB4eMJP6Mm6UyN39GYuawRcF2N5jV
 n+Tssf3QaFh03tLz/s31G96vEe6OSkmMbLGooMXd+C+bYZNTPtPU33Q5wk8T89GLTFKdNj6
 eLqAruu2towvbX2CBFYIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UrNlZpohNkI=:By9tbtr9fP6a8/tG2/lZN3
 JaTFot3rXwTamB9H52VNYFQX3q6BsFIG/XprG5lWuXT5nvFmLJPMkr6ZoMJoHRXs+WH7tx3nP
 PlOIKAKZyzcOfhpBgNRAYl8mOpCHsVwJ4kwdA1hvGSi/E7lsv4S0sHNsjwX7C7UFQCzN7Qb7O
 Fk1GdPNsk3+VdxyNuT1AAM7rBcwLpcgcy5MdsMiX4YZNppjk+kOxcaqW2IY5cPa/3OG8/MjVC
 OLlMqsdZ9F7EBAdOIVJYqPr8riL0lQnn43HAK3joy0piDRwKZXyiaXCBjQaRXK3NlYN7EdVII
 9xzxsLZgnIedyvQqBQO6j2A3ngZ022fQBvJlzQUrrhu/48SpfEjFTxU+W4Lt/Mymi/P2qJu10
 oKl5cM+ukoGds7bbjzlzPH3Uh6KJRCGl88EuWHpQiAPLZsnqWuACFlfSB/79K3YpW3WfoMZ2v
 bV8ejKRo+tY1aXpBzSYZVNEKKf31oxdaEQX9BGOi8LQ+RoSh/a/OsPjB6mzhxjJAt6ZuhDgJp
 SipX5Lc08ocDBI9KtINYFYPLoB+KuRkQWoQHpeL6wnn1SxaRiaxNyp0bajvqjpj40OFIIFpCA
 +i3ko3e0IUljnTPLNugZV//s47e6Fr2oZHPOEOKgEk0XMeDxTBTH1EgGWsokmjC9hK/boRjZz
 GhOVN4rH+tOyONVsR32JB9XcPA7pCI2TTEHx58VKoa9OgGL6CCxZPPqHgUrvryJZI648fy/rR
 tlGdNqt0MBLmpb3srJAIbm4NaoifTDvH3ulJbRZdX13io4ReKcWNKnQ+xmvDaDRBz2Nqxracm
 f5ibjj+FN0AHh9h8HwT/ulgdT+xKE7/0AIDPvNPK0XOYkb10uOR0HArE3p50MLdPVT4EuK9j9
 0InETFbZhikHtDctWxRPq6wM5d3lf0reYiRIZK/8YOoQLkLj6+qgXo69Z+3nUh3P/FcdHDYYa
 5I8eN0km07Nr0721ZSaJFrZGEdQHhJJ3pRDFrLAOes6y+3goWaa86INtpvl1gw7YggLMAZhm+
 lJOPvBYk2I9rHQ84ntUiXhh9Z1ZEjmyrUXPGna+KC85gykpZ621Dadedlubgj/qHIoC/gzmu7
 8u0o8oWzgpr73Q=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sadly, while firmware 1.5 fixed temperature labels on my
Inspiron 3505, it also caused fan type calls to take
ca. 4 seconds with the fan being at full speed.
Fix the resulting delays by adding the model to the
blacklist.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index a14e810f5598..c34342253d6e 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1165,6 +1165,13 @@ static const struct dmi_system_id i8k_blacklist_fan=
_type_dmi_table[] __initconst
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Inspiron 580 "),
 		},
 	},
+	{
+		.ident =3D "Dell Inspiron 3505",
+		.matches =3D {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Inspiron 3505"),
+		},
+	},
 	{ }
 };

=2D-
2.30.2

