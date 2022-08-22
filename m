Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436F959C53C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbiHVRmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237151AbiHVRlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:41:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E143242AD4;
        Mon, 22 Aug 2022 10:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661190060;
        bh=hqkDwn7OyhVonBjYZ9m58CBvE/y0tsnF7VukoYGRL78=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ESRCQkPjwaBt/cHauz0pDB3z5bPKPKkNaCwXYPkOqAGYtQTnahABDUWPckDzY+mKA
         GZYvzsImxQbkcoqa39ZyeGE2hd2zCJPh0A0f7WzrtVhppHgYWVaBhYfu/HZObWdgC6
         6sow7o1fQ8hO9nBUZ2Ca+dRvTeaeiNDX1awCz02s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MIMfW-1oeQUp3mpo-00EJvN; Mon, 22 Aug 2022 19:40:59 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] hwmon: (dell-smm) Improve warning messages
Date:   Mon, 22 Aug 2022 19:40:53 +0200
Message-Id: <20220822174053.8750-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220822174053.8750-1-W_Armin@gmx.de>
References: <20220822174053.8750-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:37KllnKf28DLZhPTTlR/DsKuIv8Juob5XNapQ1Rb0oRcKXleYOR
 ApOo+fZ/Ygjisj0cmKEvaiNrjLXStje0rSoU8AFnzES3DF1yWOUWxG6/OFtZeSW0txIu0SN
 HX2RkdzDklrt9meKxIp+AnT3xPCU+i3Lx6Nr0hp7iY5Nv+vZELPoShRsPYuSiNlSscU+OrO
 NyGKisuhPBn6vVq0lm1TA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dHPnzB/+6Os=:dyzBUUJD6vOW3yrvV14rTb
 yRA4FRsuQs5zz/hA6k/+q8w+ilXrBglJNEZp+jp+XFky/TYI54ZgipevcwQWE0bPxrZgGuWnM
 d1EnoDCDez54Tdm35DHdhAOhjfLqNwIhIzAx1osfbIW28YwIQpTsu+WLefsMFj2JuLcTQ5frd
 VmfGtWfga7qydps6l6SZhfnwePevwhm1FjURVE6qe2FS1IkNFrWOmeDzQowKOePfG12kH8coQ
 2W00/N7Rt4U3+mCP8DmNC+1uTwgLGT2/MpA+W5/GWooA214B8l0V8L1yI+Olx13dLfchkzbtQ
 CdkoSbKc2uWYE4AMOkmrvWRduRTMfzTHfYtVqLRfOWorGYSueCSWFcJ/FZyFnSEqocecSIe20
 Dblf8uUIbCU1sjS2MzgOjlwY3SdobF1dgX2QiHj6a90xDSgWLuaVERfW7DT3DaKD00Lg2AnaL
 qnYU8/SARTP2HzqgIyU+vNx+D7Wo8epGaf4sB75m2PCQth75VK2JDBfzehDyQgV3Y8ddsTpSB
 czufSzC2XJHDwj8xaMqsmHQ2BoNwbqJvxEMKASrwJ4D7xmJrYG3ePoUO/SP2CM612Fe7JzEll
 kdYpTSogIEP3ileHO78XdOJKqfGPqMQnhbxQohWA9dOklqTAkURBM9ak5E4UwAGK+tY8P9wTR
 jl/rqpFltM4GbLXV2/VZllTp8YM3KQZn8yhZx/m40M2X9GkhgvwpGQl1/drNWNmas6IcM8FZD
 pSsD1FODsicfoX/9ZE+sjf88du0+p8O0oqbtU1c3zGTbjHQvpvmUhy+Hsikzix2R3Mog4bZJD
 +PsaUHGf/mNaJJ0BHvZbaeS9HiwxToJysixVMlzf4LVxOwspPlfNiCQVDQOJf7Wk6hFgzUfNH
 OFswdqeyQNkhdJNrUPAKMukekiWXz/hSObN45T59MC0yAVpQKuDa5MqsoRWXJgF8Rt9/DP1av
 CgDpt1MNsZerW5w2XGCnxWRU3uHfK2krYnyN9taLzDQ65UAHGfCMpwvNq6rY44L9961QYayXP
 0yAfchsb2ag6e2w2wL4JYYZ9FK/TA/7vqpDim/2uBT6Uf9qu6hJzIgbdD4kNzxYjnF3lsXoQ1
 YaT12By/SaPczNsnI1i3HsMFiivUPXVxHBmLrtAOYa81RnGOZ5M/SI9mg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dell-smm-hwmon is loaded on a machine with a buggy BIOS
with the option "force" being enabled, it wrongly prints
that the buggy features where disabled. This may cause
users to wrongly assume that the driver still protects them
from these BIOS bugs even with "force" being enabled.

Replace the messages with two messages each which are depending
on the value of the "force" parameter. The messages which are
being printed when "force" is not set use dev_notice() instead
of dev_warn() since they only serve as a notice.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 9cac80358072..01a94b62c2ab 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1356,15 +1356,21 @@ static int __init dell_smm_probe(struct platform_d=
evice *pdev)
 	platform_set_drvdata(pdev, data);

 	if (dmi_check_system(i8k_blacklist_fan_support_dmi_table)) {
-		dev_warn(&pdev->dev, "broken Dell BIOS detected, disallow fan support\n=
");
-		if (!force)
+		if (!force) {
+			dev_notice(&pdev->dev, "Disabling fan support due to BIOS bugs\n");
 			data->disallow_fan_support =3D true;
+		} else {
+			dev_warn(&pdev->dev, "Enabling fan support despite BIOS bugs\n");
+		}
 	}

 	if (dmi_check_system(i8k_blacklist_fan_type_dmi_table)) {
-		dev_warn(&pdev->dev, "broken Dell BIOS detected, disallow fan type call=
\n");
-		if (!force)
+		if (!force) {
+			dev_notice(&pdev->dev, "Disabling fan type call due to BIOS bugs\n");
 			data->disallow_fan_type_call =3D true;
+		} else {
+			dev_warn(&pdev->dev, "Enabling fan type call despite BIOS bugs\n");
+		}
 	}

 	strscpy(data->bios_version, i8k_get_dmi_data(DMI_BIOS_VERSION),
=2D-
2.30.2

