Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E0252A28E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347155AbiEQNCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347163AbiEQNBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:01:20 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2333A4EA1F
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:59:35 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220517125933epoutp03eead9ce03df80e4c2727757ef1e676c5~v5egf0NJU0690806908epoutp03O
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:59:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220517125933epoutp03eead9ce03df80e4c2727757ef1e676c5~v5egf0NJU0690806908epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652792373;
        bh=3+LJ7a9KC6u10L8XTAC6kESxBRaYe/uwgIVvQC8Pts0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cqHNiIPRM7HMf5YSwjb33ieIFuKBpbgrywF4zEnnzclaucaBVR2vda4Zk+fyMvCIs
         A7rFaYGIFjER4SiB5hJTO+SafFNbLvzH/VMUpU20qygdbRPvzGTcNtAvxNCpfRCK1d
         k6sH7g2OVqd9Wva0Uv0I0EqtqAw8YVPrLpB+fiKc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220517125932epcas5p1e33234b7521607333d9147782c06626c~v5efS17zv1830118301epcas5p1a;
        Tue, 17 May 2022 12:59:32 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4L2bmd51cKz4x9Pp; Tue, 17 May
        2022 12:59:29 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.5F.10063.13C93826; Tue, 17 May 2022 21:59:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220517125659epcas5p4f344138f5b8a64f9e49c6cba4f0af92f~v5cRaGUYl3255032550epcas5p4j;
        Tue, 17 May 2022 12:56:59 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220517125659epsmtrp1cd969423219bcc26004953d94e0e21c2~v5cRZAv2U0134401344epsmtrp1L;
        Tue, 17 May 2022 12:56:59 +0000 (GMT)
X-AuditID: b6c32a49-4b5ff7000000274f-43-62839c31f6d7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.46.08924.B9B93826; Tue, 17 May 2022 21:56:59 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220517125656epsmtip1d6f9a2b11deb8a856a0844767a640c3a~v5cOTrQ-c1799817998epsmtip1R;
        Tue, 17 May 2022 12:56:56 +0000 (GMT)
From:   Smitha T Murthy <smitha.t@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        Smitha T Murthy <smitha.t@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH 20/20] arm64 defconfig: Add MFC in defconfig
Date:   Tue, 17 May 2022 18:25:48 +0530
Message-Id: <20220517125548.14746-21-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517125548.14746-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf1BUVRTH5763+3ah1t6sGtedAWFndMQEdmtZLsaPRqgeowXFmNWMrg94
        AsOyu+4uRAK1BBJRUPQDgvih/GpCJH4siAi2LBRGaDL8GoQViBQhQXChDA3a5WH99znnfM89
        3zn3Xj4uHCFE/FiVntGqaKWYcOS0dLnv8ZAWp0dIFgt2ocnSFgJVPJjB0ESFlYPMTc08ZBz8
        Bkff9pi4qKz7Ghdd6PyNgxru2Kr9hRYOmimrA2i26CaBGqeHuWhq7ggaaCsm0Cf1zVx0vtvC
        Q1Uj/RiqbnyEofLmZR463dHNQ5b2FoAyMruxF5yo2tJaQLVaKgE1Unkfpy4WWXhURfssRjXW
        fERQ48PtBNVU+T51+sdVDpVrrAHU2gclPCq7e4SgrI0uVO+KlRe25e04vxiGjmK0rowqUh0V
        q4r2Fx8MVwQpvOUSqYfUF/mIXVV0POMvDj4U5vFSrNK2AbFrIq1MsKXCaJ1O7BXgp1Un6BnX
        GLVO7y9mNFFKjUzjqaPjdQmqaE8Vo98vlUie9bYJj8fFzC+VcTSdvKR7VZO4AVwnsgGfD0kZ
        vDKWmg0c+ULyEoBNEyYeG9wH8IahGmMDK4ALU0O2isNGR8/UAmFnIdkG4Pn1FFaUgcH2pi+A
        vUCQ++Cf937ZEG0j0wCcztLbGScf4rBw0MXOW0k/OFv8HW5nDrkLLnescO0sIPfDlZWfueyw
        nfBcvQm3W3Ww5UvWjrLpdT4cMfuxHAxHB0wEy1vhXI9x06cIzn6aucnRcMKaDljWwBKDEWM5
        EJoGizn243HSHX7f5sWmneFXvXUY63gLzHn4+6ZcAFtLH7MYlvdd2TwewqH55k3HFMy7NMhh
        15MD4FzuK58Bl6L/J5wBoAbsYDS6+GhG562Rqph3/ruxSHV8I9h44XtDWoFlctHTDDA+MAPI
        x8XbBJIkQ4RQEEW/e4rRqhXaBCWjMwNv2/bycNH2SLXti6j0CqnMVyKTy+Uy3+fkUrGTgFxP
        ixCS0bSeiWMYDaN93IfxHUQGzOfmulei27njBbcCYw+kjF5NfbD0Wj/FebTb9LX0jSmtYLTr
        iPzN9/KwpJyn4g6b8UMCfV2NhyA/ObTvZF7o4t930nvr1o4lZyZ9mF/+zJc+14fWAk00Wb3s
        Way4GKJ2rO49eaPktnG6sHQpyE1O99Ue3XkiuWG1/NiegGZDn/JClr9TmqVDG3ybyk/tutbp
        +9PnSueCpkLDX1VG3fNxGU6tq+sLATvOhJP8y7L2jxfqa2UzuZlC6glDwSShmE85fOpyvPXF
        kpAs7xZV+ImVu/g/ryeHLznMXVUL618Nmhwbu/WDHp51+5UeH9/39B8HPILHzpaHOg+4v5zY
        MCx6UvSWfPtdMUcXQ0v34lod/S82POIdagQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRe0hTYRjG/c45O+c4sg5T2udCi5UR4jUqvsJMo+gEEd0gEtOmHmalc22Z
        drHMmuEsu5dlarSt8hY2nS6blNvSTArFckiuNCsvoJW6VRorp/Tf73l+D7x/vDQuuEyI6P2y
        w5xCJkkRk3yiziL2Dy4qOpMQpnMtRr0ldSTS/BrA0EfNOIHMNQYK1b4twtGDluc8VGp9w0P1
        TZ8I9Hhw2nbcshNooPQRQEO3P5BI39/FQ33Du1Fnwx0Sna828FCV1U4hna0DQ/f1fzB0zzBB
        IVWjlUJ2Ux1AZ3OtWJSQrSypBKzRrgWsTTuGs09u2ylWYxrCWH15Hsn2dJlItkZ7ilW9mCTY
        gtpywLpyiilWbbWR7Ljen33lGKe2zY3hRyRxKfuPcIrQyH385JEfpYS8icr8puvFs0E7qQae
        NGRWwJa+0RkWMEYAsy/6zPYQlk1dAbPsDctcA5Qa8Kc3ORjs1ubjbkEyQdD5rY10Cx9GBaCt
        LA9zB5y5TMBrtsmZlTcTAYfulM0wwQTAiUYHz81ezBrocLTyZk8shBXVz6c3NO053Re79rpR
        wKyGX56hS2DuXeBRDnw5uTJVmqoMly+XcRkhSkmqMl0mDUlMS9WDma8FBhqBqfx7iBlgNDAD
        SONiH6+wzOwEgVeS5OgxTpEWr0hP4ZRmsIAmxEKvdnVrvICRSg5zBzlOzin+W4z2FGVj8/Iy
        WlcCHz99f9TY5rGIOJFaFnt9fmNPWOx7rWrbVqf4RmbhzxHL8AHUJJ1ouWauip8fuNR03+Ou
        ODQHn2NQBN9c6+f0OPLqpfNktPF70ztVs2pZTNeiGA9d21Vd38mEyaP8rCBJ5NODwTkNJzpy
        B3MD/u5gLh3S/K2O3OhQEbUbThcVVjgTV8F7nlveFfda5v0OTeI//FWwq2fTTt+490xc95lI
        /QHhheEsCX3j+sjilEJfS/CHbhCduWFzWujXYS7Dr1mzfs/q0WPbmx/QNQtbhVNXwz9zPzpE
        S1y+66TjnaP1V0KOs1lWYaPQUjVY0P7aWVFFy7vrpOdE+f1Gg5hQJkvCA3GFUvIPcqGLyyQD
        AAA=
X-CMS-MailID: 20220517125659epcas5p4f344138f5b8a64f9e49c6cba4f0af92f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125659epcas5p4f344138f5b8a64f9e49c6cba4f0af92f
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125659epcas5p4f344138f5b8a64f9e49c6cba4f0af92f@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MFC into defconfig.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 arch/arm64/configs/defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 50aa3d75ab4f..e35765f2d78f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -661,7 +661,7 @@ CONFIG_RC_DECODERS=y
 CONFIG_RC_DEVICES=y
 CONFIG_IR_MESON=m
 CONFIG_IR_SUNXI=m
-CONFIG_MEDIA_SUPPORT=m
+CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
 CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
@@ -678,7 +678,7 @@ CONFIG_VIDEO_SUN6I_CSI=m
 CONFIG_VIDEO_RCAR_ISP=m
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_SAMSUNG_S5P_JPEG=m
-CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
+CONFIG_VIDEO_SAMSUNG_S5P_MFC=y
 CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=m
 CONFIG_VIDEO_RENESAS_FDP1=m
 CONFIG_VIDEO_RENESAS_FCP=m
-- 
2.17.1

