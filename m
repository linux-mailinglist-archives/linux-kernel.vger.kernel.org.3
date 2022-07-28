Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F91583C52
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbiG1Kp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbiG1Kot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:44:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7982D6566A;
        Thu, 28 Jul 2022 03:44:17 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:44:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659005055;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JWP1Jd8H8eTls6cTNI6gJ1quaY+nA6OQtt7305MD3oY=;
        b=P0+AFAfcT/rghOYY7AqZGDShQevvhS1sgBBLuk7ckNIYMtB/vVvk3DeaSYuWzXmTe6gw/A
        GOlNuHpbxOpdaqwu7p3fV9jASJDwIr/1mkYOqBYFRNkhZSq6dGmae8ciegjG2SExnxm5dp
        crcTa8KH8oQhHahyzhLDGINOyZUmUvPl4W+F6KCP0CbJO0Th/+MnqsF3KkUh4AzTeycJxP
        WbxQf+sM9R+LI1UFxMY/0OUjQvswEL3tk8qMtOvkSltL9ufspvTm5urTt78LX8bdk29uvC
        nOLx4L88zyCn+NswmIavaqrBkF/+ntQ5wtOQVYcCHvEaRoGteoDQ5JGXsCVtsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659005055;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JWP1Jd8H8eTls6cTNI6gJ1quaY+nA6OQtt7305MD3oY=;
        b=mT9ZwjsneeyRajTDsmNDKXo2RIpKIhi9nvwzOAaDF7N88WM9+WzC+giJ0B0cw1SGqd8x1h
        PcubaEG2lEbYGyBA==
From:   "tip-bot2 for Wolfram Sang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] thermal/drivers/rcar_gen3_thermal: Add r8a779f0 support
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        niklas.soderlund@ragnatech.se,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220705195520.2581-1-wsa+renesas@sang-engineering.com>
References: <20220705195520.2581-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Message-ID: <165900505422.15455.14055094669854740799.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5b2ca9bc3f1bb1a65e8a2c636047ea51aaa924b1
Gitweb:        https://git.kernel.org/tip/5b2ca9bc3f1bb1a65e8a2c636047ea51aaa=
924b1
Author:        Wolfram Sang <wsa+renesas@sang-engineering.com>
AuthorDate:    Tue, 05 Jul 2022 21:55:20 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 16 Jul 2022 00:45:33 +02:00

thermal/drivers/rcar_gen3_thermal: Add r8a779f0 support

Add support for R-Car S4.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund@ragnatech.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20220705195520.2581-1-wsa+renesas@sang-engine=
ering.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/rcar_gen3_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_=
thermal.c
index 43eb25b..ccdf8a2 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -399,6 +399,10 @@ static const struct of_device_id rcar_gen3_thermal_dt_id=
s[] =3D {
 		.compatible =3D "renesas,r8a779a0-thermal",
 		.data =3D &rcar_gen3_ths_tj_1,
 	},
+	{
+		.compatible =3D "renesas,r8a779f0-thermal",
+		.data =3D &rcar_gen3_ths_tj_1,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
