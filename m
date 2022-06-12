Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D944B54787A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 06:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbiFLESi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 00:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiFLESg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 00:18:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6D354034;
        Sat, 11 Jun 2022 21:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655007491;
        bh=skbtjaGDK31d2tbbZZs0gIrNpUjqJPlvvjCkvRwoR1U=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=f+rVrp85dAFxbqMzCpoUU3ouBj2vZdB16dl2B4M2Mnqf3XR5WNfRDpMA2b2T1mZ//
         LT01w3KXtQEVJN0VCEZyHUx+Pz9iiNRTeP8CNgh22vYqFxSglawQV6MxEwxV5LLqyb
         BFli6nygvHmbZ875ri3gpC2vWNwtPPb+hl0VgNmU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Ma20k-1oCGAh0tRE-00VvrH; Sun, 12 Jun 2022 06:18:11 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (dell-smm) Add Dell XPS 13 7390 to fan control whitelist
Date:   Sun, 12 Jun 2022 06:18:06 +0200
Message-Id: <20220612041806.11367-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tIQ+jBRsOqGXzOfoKNqR9BWepS73Ni1NYp++ahwD2S/nJIdD9AY
 FN/K4Xin+aB3ZrqOUahnvXm+2RB3jYayZPwf6Mkfs0NzsZYGMGY+7Lb2OoCM/5EtlocPqJq
 xUBoNLHDlzF1/HjKNVEwujc+wJtdQLYDbvklpr500c7RSRdVgjdriD/zClD9UIov4eBRYzy
 JfhHWX5VRWlqSc0r07fXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1jXk27D4EXY=:dD5KUasEpSaSrMN4FWTmu8
 6SHzYJOuU7UPlD8n034/Tnur3tmTgk2kVf1Fh3b0ipT2ENFAHLM+Mqo0ZrrpYCo7tTjO+3Gky
 VqkDrCWWxNl00EsTY96BWCCQk8qC3gQQWOpZYCUWfk5G+6nSJoBBd/dvUytOQUBrNLog37usj
 9Pn0M7i64EL4+oSD7p3hljtlL9Z0HDMxtsbRz2s5nAGdllfCj3XK5w3nKjBnPGSMw4PY8rW4W
 2YCLCvTBmOVJU68qF6qUTUGLwHOplNryboe/Xr9ji46oFwe3m0nCG52sPqNXT8ST0ANHQSOfn
 OLQW1B4EcOyoAwHo+6trewIEXIMUWeqlK6Rl8GV0sHrLAgfxh1Kor2E2d2h8WCdHQtXofcBiR
 aFQllFJ1V4CcrOeoo3ogIUS1jHfTjE3vdJVuJ+2nKFFOe9nnjEM+XaL3AQt3ry/yerI0F94/S
 RqC5CYsqISqQk9MvohAAs5DDcQwm4V/m59e5gnU51xjwO40990XGLMC5G/GeiZkvjjZr8sUJs
 R5+iNfmfCMJkyrB8wJ1/V7Y1zU5aLjJ1/292n5rRqJiAlh9GqgpnQi2eiE/eCRFc3Z+mxGV05
 OIsOQXlN/islY+o6NNSuRUa1IsyH6wvGA2qmGjItt6JEYgao5WznQTpFD9jpbbY7muMz4jbpe
 00ie3NlGc8x04+e3ljPlUzU8YpudXGYUi0EqAV+U0kQhNx78QomaE8NjrjdbWBH7BAMywLJVO
 sW4rXK/GCLZEEme6khysNIDM9rIXA/xvaZgW023IGv2FkweFX0dM6m3eOQlASiSrekiFq4VM8
 YXYi6XNye2RQz27q2zAnDq+MhelTwdn4TEdALu6YevskkflhseJo5aM+cV+HlDkESCVZ0DPVl
 b6DLXG8inmL+qpvlP3fcPiulX086DSKXdDwDA9H4kSjMzEclZ44RzhoqJOOmsDQj5h+L1K44t
 DnUwvgXGGub2o9AXVWefVc5cG0KZv8lD+Odantwa7uDsKb++HN1QwMgvR3uSoUAtzxoZIccyq
 EApn//3RZSlJPv5LCrgE1t70r/zzVZX8NyECoWkYA5hmvE2rw1SNOC8xYhk8qy1IqgP8kZTi8
 nWFX8IHl1NyvCqWHtPrJtC4PvVV9vnQxOYWVUvDd6rFtDZKRJeBcRK0Jw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A user reported that the program dell-bios-fan-control
worked on his Dell XPS 13 7390 to switch off automatic
fan control.
Since it uses the same mechanism as the dell_smm_hwmon
module, add this model to the fan control whitelist.

Compile-tested only.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 071aa6f4e109..16c10ac84a91 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1365,6 +1365,14 @@ static const struct dmi_system_id i8k_whitelist_fan=
_control[] __initconst =3D {
 		},
 		.driver_data =3D (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
 	},
+	{
+		.ident =3D "Dell XPS 13 7390",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 13 7390"),
+		},
+		.driver_data =3D (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
+	},
 	{ }
 };

=2D-
2.30.2

