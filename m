Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D654B78C9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243430AbiBOTMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:12:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243407AbiBOTMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:12:01 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A747D001;
        Tue, 15 Feb 2022 11:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644952292;
        bh=/eV7B6nrTJsDMEC0tTMXkXZvwysGHhyPjyGcel2jtG8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OYyQtFa+u82O/ty5Op/RvnngfxFHUrRzGCpNlT+e4ks0KIOqoUB8XtdLhYF4ghpK1
         SGlux5Ms6VHy2ehKV05NDiDcpgjTvhx7e0JNNOtn68VxotjJL9PM0JZYZjbxnXxL9p
         pYR1xy7Pfhd/a2GE9MS0kOpxM3x8du8sHOYvdfCA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N1wlv-1oGvJF1VUn-012Kgc; Tue, 15 Feb 2022 20:11:32 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] hwmon: (dell-smm) Reword and mark parameter "force" as unsafe
Date:   Tue, 15 Feb 2022 20:11:13 +0100
Message-Id: <20220215191113.16640-8-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220215191113.16640-1-W_Armin@gmx.de>
References: <20220215191113.16640-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7ISU5hKPe7evY9qmt1TMbBMXI1ApEqd0bkfnSvgIh8Lb6ZCHpuk
 moCZk5IfXhdUDyyXdbAI4LgCQQoEmfNv/Cz0+VzkNPUB+FmU60IpKRRtiQd7mUQqPgzpufE
 Q4RXsen1hWEhnzqLiqhuY6BBz1gyuLBvySErxpFbZyHWtEshuk7YrG7gOxtnYOWuDoVWYyu
 +PAUrRqmkPxE4K9xv3Ohg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gq5iSvW7Glc=:8jfwzbfJW0xHAV0d0ZCrdk
 hLUFlDuhGiHUA34cU6vexpzsgslpsc9Yxd2ZiZc1OM0WsOQ5aVCji6qi6cHJ6g4cppleuSVmV
 QY+lwK8QAZh0BeHQpVBDNcd3+PR+Hdet0c64s9fRp5I0A3N+R+wGdi3ceeIcLGrvyr1vtqjpI
 y6bTt3WEU0v/SqLsVR7oE4iJaq/FR9F0ZbhUjaTcYZ5nrC1+FebI+Kev0Y2png2lB7slhpN5b
 OPMs3Q5LtOYVDcB90gnNnYTqZwpHwr1lfNkMw3+3QQ+S1Uwjbqy+mdsGZ/70CM1Jki+aZQgM+
 pl8eLu8aSiarETTbGl7Nm00Ncsl6icJXtbyTF8Kintir30JX8NAEckmZkvCZgMpmDGo1jkzpH
 vQehC5OhudVB/8vw4rrpYwR1iwscRFZlmfb8npLwyiRDMTXcvevkHpuhzMQSn1NzeyvZKsq2P
 1zl2fvYKaSDYohTodeSQ8HQE4MK6U6oUSWwiQICj/VjUQhz+ohNUwVIS3H5lWh0nuddzosved
 jpv/rZ3Wau2v1s+Z2xxG8FIHTsd1CzqioCrSgYObHTBAM5kyGGeYgOFS4JyLTDk7TFTMG5PJn
 RIN7vDWDW2f7lcW6O4RMsRXgzGuLqndhfpyQfnzvDOPFF9ci1vZW6U6yvHgFUpds1I2YZGCOC
 4NG+btVVQafohVLVJ8vnQnj5S2835O2LBeXMaRFGr0bmSUV8liY7Mmn2pY2nugtSv7LEZrW4w
 TLpe3nWWfimFDNo+/hbOdXpOwK6a8cf4WyJW3LJ8ngna/u/XhAtMYeKlQfMgmugsHd16ucm29
 Lqe/x2eXnlVR5N+iNLyIaoG3jjyFXLTHbjL9TdzGCma7INvSl02rRJhrZ8WWqz+PR5hgYSegi
 3Koi1LdY+mJLy+NSQo5d/ybetTLRmpGvoGjB+h9g/v3+T8fCYd2PMxP58Rn1UXRZSRUmE2soU
 4MapHt4JfcbdsMuNfbj1Kv2/Nil9v5gKe+eS1PSFMjIhWozOh26jVrttf5uaCd5/WLVVT0pKF
 wELUeFVxIoTmIObzGbqI1DVlnJZiK9Bu+k/GHOiTgO4UIvBDI44rZAJ0MDIKamsK6vz640XBo
 Kgwvj74nsPjpCI=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enabling said module parameter, the driver ignores
all feature blacklists on relevant models, which has the
potential for strange side effects. Also there seems to
be a slight chance for unsupported devices to behave
badly when probed for features.
In such cases, the kernel should be tainted to inform
people that these issues might have been caused by
the dell_smm_hwmon driver with "force" enabled.
Also reword the parameter description to remind users
that enabling "force" also enables blacklisted features.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 04a41d59da60..67d63932b48a 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -87,8 +87,8 @@ MODULE_LICENSE("GPL");
 MODULE_ALIAS("i8k");

 static bool force;
-module_param(force, bool, 0);
-MODULE_PARM_DESC(force, "Force loading without checking for supported mod=
els");
+module_param_unsafe(force, bool, 0);
+MODULE_PARM_DESC(force, "Force loading without checking for supported mod=
els and features");

 static bool ignore_dmi;
 module_param(ignore_dmi, bool, 0);
=2D-
2.30.2

