Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2408752A241
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346787AbiEQM5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346668AbiEQM5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:57:33 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27673EF24
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:57:30 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220517125728epoutp0334ffc4c2c893be92ec3b89de8ad044f1~v5cskHWwh0497604976epoutp03Z
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:57:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220517125728epoutp0334ffc4c2c893be92ec3b89de8ad044f1~v5cskHWwh0497604976epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652792248;
        bh=jmWJPCoNSSdB7mc2+4CxcSUagZMW6Ixk8+JEUPm5+Lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uOWDc96kP2XKinaNFf4BZ/icXfLyiFbFbeFOHuwxGVp0//7VnMyQnsjYANZAtBhJo
         MThHuoI25BmLURZS943Ri35Du1981oqKO3exDbYyzo3CfxwU1/IrgYPGYYOSs5lB81
         IFptaAfOV0m99P9iLH/XrlBG9ox7+IgqhjwAf4Cw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220517125728epcas5p2b0b9e9a5cdcbe466cb537c1ed912e989~v5cr-fu4a1529715297epcas5p2u;
        Tue, 17 May 2022 12:57:28 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4L2bkD5CY5z4x9Pt; Tue, 17 May
        2022 12:57:24 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.0C.09762.4BB93826; Tue, 17 May 2022 21:57:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220517125551epcas5p42cca7f0a2db6dc1d16d0e27265c43f56~v5bRt356t2591625916epcas5p4k;
        Tue, 17 May 2022 12:55:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220517125551epsmtrp24559d2c789a3a94303777b6de5e95878~v5bRsmRb_0912609126epsmtrp2L;
        Tue, 17 May 2022 12:55:51 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-69-62839bb44b8d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.36.08924.75B93826; Tue, 17 May 2022 21:55:51 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220517125548epsmtip16607e233d1d0cbbd00867e88a2dad971~v5bOuglUM1797117971epsmtip1C;
        Tue, 17 May 2022 12:55:48 +0000 (GMT)
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
        Smitha T Murthy <smitha.t@samsung.com>
Subject: [PATCH 01/20] MAINTAINERS: Add git repo path for MFC
Date:   Tue, 17 May 2022 18:25:29 +0530
Message-Id: <20220517125548.14746-2-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517125548.14746-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf0xTVxTHc997fe+VpMsLMnbF6eARskEEWi3dBel+RMaesimJmXNGxQJv
        lFHari3Klgg4hEzCz0ycIj8cpZtBRQSKyA8DrMLWTTaVCQl0MNhQCptIHTAluJaW7b/vOedz
        ftxz76Vx7zukH52qNvA6tULFkl5E67fBwaEt53ITxRPmIDRe3Uoi49J9DI0ZHQTqbTZTqGXw
        HI6+6e8WoBrLgABd65kg0NUHzujtszYC3a9pAGi64lcSNU3eE6C77ZUkKmw0C9Bli41CpqHb
        GPq6aRlDtebHFMrrslDI1tkK0Il8C/aGL3ep+hLg2mx1gBuqm8e56xU2ijN2TmNcU/1Jkhu9
        10lyzXXZXN7NJwRX3FIPuALLEMk5mjZx1r8dVLxof1q0klck8zp/Xp2kSU5Vp8jZuD0J2xMi
        ZGJJqCQSvcr6qxXpvJyNeSc+NDZV5Tw4639EocpwuuIVej0b/lq0TpNh4P2VGr1BzvLaZJVW
        qg3TK9L1GeqUMDVviJKIxVsinODhNOVS8QildRCZd6wXqRxQThQAmoaMFFafyS4AXrQ30wFg
        yekG0m3MA2ge7fIYDgCLFqqcGcLVjOLxRdwdaAdwcWyWchsnMNiXPyNwUSSzGS48/IF0aR/m
        OICTnxtcEM5M4XC6+/EqtI6RQ/NyLnBpggmCvX0LlEuLmEg4fHMOc7d7CV5s7MZdwwqZKFi1
        ctBVBzJzNJx91EK5mRhou2EFbr0O2vvX/H7Q8VcX6dYpcMyR62G0sCqnxVP/ddg9WLm6DJwJ
        hlfaw93ujbDc2rCK4MxzsOjp7x5cBNuq1zQLa3/8ztMKwl/+NAvcmoNfnizwbKgIQFPuElkK
        NlX83+I8APVgPa/Vp6fw+gjtVjV/9L9bS9KkN4HVxx0S1wYmxufCegFGg14AaZz1EYkzcxK9
        RcmKTz7ldZoEXYaK1/eCCOf+ynC/55M0zt+hNiRIpJFiqUwmk0ZulUnYF0TMs+OJ3kyKwsCn
        8byW163lYbTQLwdrTxjMLPz43VOW07vP3qrBD8StMMKAwrIRzUBA0uZdMyHR8aYvcjKfDflg
        3gNb3qoKsE9mjccKv/IpsRgWlIF0HmG6cqY7+pWDWbH7+sx3gzr6rCXDj8JW5Oej+hcapRdG
        P1qftSFpZNsNXokxu2pDB8p37iR/sy3bKvdZ30zz3VO8OGHMj520v23fy2gdw14FnS/a/wnM
        zoj5oFlWWj8022A88scGle+hhwfSp3s6ntLXt/Vcy7ZfDRw5dmj5swbhctyFMt3PS4Pfl0yE
        W3Z7/fS+9UGoxVR6ufxW0SmwI/fofPSKtm9qcIbYcXi26GXTh9Ync+8dK9m+fzRm496a+Cmx
        PI8l9EqFJATX6RX/AssWOYhlBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42LZdlhJTjd8dnOSwbmVPBYP5m1js1j84zmT
        xf3Fn1ksDm3eym6x5cpsZovlxw+wWsw/co7VYvvBRywWG18AZS/OvMti8Xz+OkaLl7PusVls
        enyN1eLyrjlsFj0btrJarD1yl91i6fWLTBbLNv1hsli09Qu7ReveI+wWd/dsY7RoaTvC5CDm
        sWbeGkaPHXeXMHpcX/KJ2WPnrLvsHov3vGTy2LSqk83jzrU9bB6bl9R7tB79xeLRt2UVo0fX
        ketsHp83yXmc+vqZPYA3issmJTUnsyy1SN8ugSvjR99t9oLPLBWXTq1mb2CcytLFyMkhIWAi
        0ffgO3MXIxeHkMAORokvi3dAJSQkVv6exAhhC0us/PecHaKoiUliw5njYAk2AR2Jb+9Ps4Ek
        RARaGSWur+xkAnGYBX4xSyx8dRqsSljAVmLrn2Ywm0VAVeLQsW/sIDavgKXEjaMfmCBWyEus
        3nAA6A4ODk4BK4m5/2JBTCGgkqf7LSYw8i1gZFjFKJlaUJybnltsWGCUl1quV5yYW1yal66X
        nJ+7iREcW1paOxj3rPqgd4iRiYPxEKMEB7OSCK9BRUOSEG9KYmVValF+fFFpTmrxIUZpDhYl
        cd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUyeSxuaxCf/tuC8ecQsLHu2XbPL5i39rE/nf/+w
        onLBDzlp9w/fu+5bPs96p5dqynt7nUe3i6QRt/KtQK/HfxjP36+XufCSTzprQ3xn3prOPItp
        76PVxOu2XJ6+6vGdr9xK2/6EvpmgLbdVOlJyk2OU6OSvX6q++2eZn6o+c+GafJbJJrtcoc1v
        un3XTmBfm1SkpWjUoLPBXkp+n9fb79kGzdM89h39FDg/TPoFm0Bli0zCjo43rt2dLOdDMhcc
        86g8srNtumpf41rdlZdVU2w4HmZVzuZRaHxl7jLTff7B7x2Cnp//8Cm4tTU57/KZvCt0GcN7
        lsw7dpf992/eofnqdGz07L1C7sInDvmoKiixFGckGmoxFxUnAgBeVZ+FHAMAAA==
X-CMS-MailID: 20220517125551epcas5p42cca7f0a2db6dc1d16d0e27265c43f56
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125551epcas5p42cca7f0a2db6dc1d16d0e27265c43f56
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125551epcas5p42cca7f0a2db6dc1d16d0e27265c43f56@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add git repo path for MFC.

Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d43e048..e53c7333562b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2703,6 +2703,7 @@ M:	Andrzej Hajda <andrzej.hajda@intel.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-media@vger.kernel.org
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media.git
 F:	drivers/media/platform/samsung/s5p-mfc/
 
 ARM/SHMOBILE ARM ARCHITECTURE
-- 
2.17.1

