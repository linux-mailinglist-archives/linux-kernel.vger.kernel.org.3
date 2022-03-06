Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDAC4CEBE5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 15:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbiCFOYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 09:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiCFOYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 09:24:19 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA874AE28;
        Sun,  6 Mar 2022 06:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646576597;
        bh=fviFSK5y5Aaq+IIWP/+WE3VsHMV+uByyn72NZHtxZGo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=gFuohdMiQxK092zL861CnVC6HhvUDaFQXDoPR5uoy4b2ltLTxiCWQ8D8CqB0b3D/k
         bhk5v6/IL1S13BeBo3jA5DMR6z1dQ1YO+K2aiTgWa54qRuke3D830VRCnXUe7X/7Xa
         nba8RO7xfwWICGkrxRCqVJVP/uFKnrlgbmgswJpo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([89.0.78.102]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2mBQ-1o9nuj1CJg-0139Ak; Sun, 06
 Mar 2022 15:23:17 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-spi@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Mark Brown <broonie@kernel.org>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: npcm-fiu: Fix typo ("npxm")
Date:   Sun,  6 Mar 2022 15:23:12 +0100
Message-Id: <20220306142312.109017-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zRDIEOS8jqLfAJl4QOpA4SuB/spvp9/RlpdN88YIsCOrFgmGdrb
 ZbySwwkT42wTut3PNqASXXlG5Yq07czXCjm2JNUN1tYf1EUIgHL70Lh67dZLphRkmNRupa5
 xijxWZRxen9Tv/OLMfZ95QrsgE+r2V78K35aOA99tIrltg7sOdQhgpN5TOF25kswQm3tVaf
 RynjU6K172AYYubLOAZEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oD/RSu1sJY4=:mI9NtcgMTu+ubTueJ7hMFF
 uoyUXKzGDJzDdKfeQI9rRKfpD1LE8ntAX7+t+XQmGgYz8wlN41Z+aId+Kjilf/G7M+pz4D7Er
 3SAyoa8RN8NSU4ndxJhYd7SacLsqBUoK98kfoh5icQjvtk3lW5eVkWE1uwLd1jRBR6f8SCw0a
 pLYQsSlhYgevKtk7zmqyHbAtKbqo6NJATTHqffYe5Oz0sLZ+BoL+TN9+DJCRMAHSCAfVWX/R5
 dWC+CrtU5IxqZTxToJ7xVRRXOjspx9/SZ6zibOgbfrD0XWWPzmhe+y+tFAOD21cErStMckOUA
 3OP384m9Z0rG5eh6DggWT7f/zr5BGDgn7OxJNB2hmdyrZaNW+jfm3vsDKw1lrKi8/Y4YSKCuB
 3gpkj6f/RhbMhvgz5wBbAujsXLEJut/2Mh3JWjIlQChqovV2BDj/xmhtDTDgTNvjtttlM079E
 4+/At1HKSvpm5PCMmpBR8H9/PDEmlXy4s+K4nb0W0TNl36KgZouyqatw9FUB7X6DafoJ+MdIA
 hkCEK92qh+X4i/+CbZrM2RU6oXt3AK5WHRD4Y16DPubBDadcKGu8d8GphNXIyjVLYJEuGerYM
 u/3TnIpIcQJRkCmz5yFSIJPjX/lmhojoc/PRgvx/rB/wU5yPKHCtvJfVPoTzyn9NARAQ4sSGq
 v0yLfZWvxgbvv7TWMIxuS/nTXjbWo0ChyZsyjibc8HrhmmopNL1U+uEt1gCbFWrIZyTshc9AD
 xmzbQJGnNru6Jra4TpEjXZjc+dl2wMNm+bFpOS558DIx+1frX2CBEA7hinRjMtmmuGPdMxpnN
 NIndXSuFbTNTGPVrR+f75b8h5l8HIYrL2K1CeTAf+T8J2DAvF06HM5F0oCGYpb241rx766Ch2
 6jQf7jv2TjmHz4BiWvkpiGOwGFYoRDxYVZx0YCPrXuqnngqeBH2o1R8enQE+leSHwNLStOrLh
 NxZt4oTY74hSQeER9Mlq1LcCxpT9AKfgX9Gs0tIpIdEnJ6MQsKoui2ILJa+lw840M6Pir60yU
 ASsSrFV142sv+TJuZvqRhz+RNbymJRXqTSr7kwWVLP3PWEV8kZpePEdOxZ4KqPEWc2SWE1Tpv
 U9KncsdR7BOtbU=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform is called NPCM, not NPXM.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/spi/spi-npcm-fiu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index b62471ab6d7f2..f11246884df82 100644
=2D-- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -201,7 +201,7 @@ struct fiu_data {
 	int fiu_max;
 };

-static const struct npcm_fiu_info npxm7xx_fiu_info[] =3D {
+static const struct npcm_fiu_info npcm7xx_fiu_info[] =3D {
 	{.name =3D "FIU0", .fiu_id =3D FIU0,
 		.max_map_size =3D MAP_SIZE_128MB, .max_cs =3D 2},
 	{.name =3D "FIU3", .fiu_id =3D FIU3,
@@ -209,8 +209,8 @@ static const struct npcm_fiu_info npxm7xx_fiu_info[] =
=3D {
 	{.name =3D "FIUX", .fiu_id =3D FIUX,
 		.max_map_size =3D MAP_SIZE_16MB, .max_cs =3D 2} };

-static const struct fiu_data npxm7xx_fiu_data =3D {
-	.npcm_fiu_data_info =3D npxm7xx_fiu_info,
+static const struct fiu_data npcm7xx_fiu_data =3D {
+	.npcm_fiu_data_info =3D npcm7xx_fiu_info,
 	.fiu_max =3D 3,
 };

@@ -664,7 +664,7 @@ static const struct spi_controller_mem_ops npcm_fiu_me=
m_ops =3D {
 };

 static const struct of_device_id npcm_fiu_dt_ids[] =3D {
-	{ .compatible =3D "nuvoton,npcm750-fiu", .data =3D &npxm7xx_fiu_data  },
+	{ .compatible =3D "nuvoton,npcm750-fiu", .data =3D &npcm7xx_fiu_data  },
 	{ /* sentinel */ }
 };

=2D-
2.34.1

