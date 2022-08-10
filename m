Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE0758E78C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 09:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiHJHBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 03:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiHJHBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 03:01:33 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2090.outbound.protection.outlook.com [40.92.98.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD0974CC0;
        Wed, 10 Aug 2022 00:01:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQmXS8rsEmbWUU1V8PctADB0qkJx6oQz9qRGuzZAbE3MWMaOPfM05JlJhlswarxY+SBQX84It3SLtMAkr0XTRZzqUddFwC/nZXphZ/AYndi8+DAtYKf8RLNlEYulxx2He1lgAU54wICVSP0njYNGPJJ1RzeT8yOW0ax1OOx0GSoGNAeIXXcdxoFeKNcPFo3LceFNqShIWml0K/xZYeZAuup3BBmR+amf9pKv7hl461PcqfoLuBzd16fOJ9Ep4it/dLZJrAJABc5hAZV/oqFDxI1oCBDL9HAATEmuw/qpKcndTllFpIJQEAcIhGTmoaVxmqgeuyiXZcEEJjLB1Z2ABw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xatavXPOrfT59onYsAnICAz5KL9G8XNoA/KpYw1hj14=;
 b=LYfOAw9CAbkrvMUDD/2OGxnN82P5Ous/5cjDGOgIwseQ4LiYRcAqYB3kcOcFmZ3zBxo13OeayMumfsBuJ3ltIXrFnQxjHm2sRs0V7jXgRK/IGy0KIVyxKb3A798gI/vQfudW8+E9n1eFiyZ/PPNx5TE46OFaQHDUcR8e612NOUGfMpT15uVqzeI8s9zCaAy+boU4ZZbkU5ZQC9ibPms85C++onuH49MVbcd/rLP4r5k6quu4V8I9NQJVZcvRicqIU+Dml9nrsBFAs/zCQo4viF4eWXep9JAVxSTI6P18Lx8Q6o7TkdSME7Qg+t+pB+X10Bd2+8+VdUF6fHfqMmS0xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xatavXPOrfT59onYsAnICAz5KL9G8XNoA/KpYw1hj14=;
 b=VGrXP2UqQBtSNgXiXDSC30K5bwg0oU22H1YpLJ2Bjo3FqZt/5Z/x2IjrfGZWxPRAV9OJKXyzMt+oiIGOkA/wK0UEcDA7fFyh6aVfIJo+RHQgUn1RMHxNtQInjQq8yNGgCSP4/wOD3eRWXHSrlzbV5p36OOYsWo9CPTHjlJKTDJEtglWNjEtE5pgpV1K76K2PHV7CmVx7MtoY9alMtYPrwqoBtBp15UDoibF/6TBUK7644Hjdi2TpUkBbIO0FD8TUa/oU7zKl9EvTaAQu/qehJUQmf4IgmaD8H/0d80cs5x3ZxFGIDbvyYHAuBHF1wigLH/HZGnIuiu1N3WFqB5I+fA==
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:248::14)
 by OS3P286MB0614.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 10 Aug
 2022 07:01:30 +0000
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::45d6:a31c:aef3:a3e2]) by TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::45d6:a31c:aef3:a3e2%5]) with mapi id 15.20.5504.020; Wed, 10 Aug 2022
 07:01:30 +0000
From:   Riwen Lu <luriwen@hotmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Riwen Lu <luriwen@kylinos.cn>
Subject: [PATCH v1] rtc/rtc-efi: Add wakeup support
Date:   Wed, 10 Aug 2022 15:01:09 +0800
Message-ID: <TYWP286MB260191455377CEBD2336557EB1659@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [tBCb51izRo8m16Mgj5RM4xaUTpB947N3JBzl0AcP7mw=]
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:248::14)
X-Microsoft-Original-Message-ID: <20220810070109.1783104-1-luriwen@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17e1ee71-fd68-4529-1213-08da7a9e26a2
X-MS-TrafficTypeDiagnostic: OS3P286MB0614:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UxAD4Yd84Pq05zcWXIa5EdqCG7jrL3LUr5ya37UaIqGqcnO/fRwWoNV1QgyROVTwvDPaSfncyoLFH8XR/6unQ/aHdntfMrMCfcAaUBB2SFri9hZ/FMBXw8mEA3YDQljiqaw3oHLh9KaEhhcTMb458Io7jy+xFYJoOu3yHvcT/bS/UMORP0Y+KPHdLZ+G2utheFiXmjIzVkdFD2Eg4rZkdu6Pk4SvePglVEta97ibj5NDPpcjizQjEG0AhIHz20b8sxWSjNQo8GTq/1W2FC96zGoxMw77owcm3gKBMd7+8e2RYBcNGXSFZ01O65LWK6yMqRr05S5idzXVW3snVEyV6Z7u1CZxb8xOwzQlQlzsKUOvxqHzQQsPYRkp/+Kj2A0zMMIGrDOM08Fb1IrYv7rqN0TkkxVstT863bcareofsiPPg6MRCB+yVNZJssozrFtJDuiuovGfiVPPF6ZS2ZxbHulRb1YCYtWNV6m8bJR/kuD+eQBiSjzf34rTrQCPAMV1FmNvM9MSM9nFADtBu5uyDOeQLalBJnTwEy0CO6DXVuZOiZIHLSjpCeV42vbMemdd0UyPppQ4NEKoqD1mxGoghDeKp6qr6WQ6HAE2SVFHgyPd5/4zRbWz3v07kCMVDk26cmR+W6WO8s8yjFVKboNCcQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KQe09aZN9pXs9z6s5NBfNPr027wXsE0KIzrdeBPxqXZm4RI2WwFTcQzZTPa0?=
 =?us-ascii?Q?bvWRLfp7txDWyMRhINnTh+JEDXLs4Qhd4aXxJBzKB0T49qcs1zkAV4xZrYK+?=
 =?us-ascii?Q?vqk/B44btK1mWpAEV/8FsrN+XHPMC5IBj1tCHS0GbTLnYbit4KZeBk0aqE6C?=
 =?us-ascii?Q?XUCeCENxB4GteV/j1DD11zDjcZPMSqVpZH4Ydsr+366gh0wO4hWuObe3Er+r?=
 =?us-ascii?Q?6tVwYbDrMAJq0WCHTD3AXOZw3MSV99b9gL1W2bXeMdNlS1PSQCfiv6RKm/Dq?=
 =?us-ascii?Q?MrgFcJ5AELC3gXy1VI0V1vFBoRZJKWQFpKl5KSR8xscDoDMiip06H7EKdnZ0?=
 =?us-ascii?Q?7r142bAP6/etOWw/5mygMw2HbqO88ZKwdBLnyP3rrAwN+p1nBYdLdtfoT6R+?=
 =?us-ascii?Q?qpMpuyCqAbmXylfSpThWowLYJLE8MwMrDyT/W0rC42oOQ91XzBXLtWg1nIF3?=
 =?us-ascii?Q?WA+aGNVnFt1wk4srri6BKsW8GXqWJoUbV4H0iUs2vwHsKhHtloYWpKpd7MBZ?=
 =?us-ascii?Q?1XFsDvL2vgsVQ0SS0xQ0QwXno3ofFwjNSPlFDOzf6lo8QqyK++wXDNqaQ64S?=
 =?us-ascii?Q?MIY+uVOjbO27XfssRil/fd1AZmXYzRxzBX0enTIcA/cTkjTMYoS1ytHetcc9?=
 =?us-ascii?Q?P5MokuBGp+Yv0gnt9d4/Bp5wWPuOjNqjChQIbir++FhvAx+8Fs8dauzWoGx/?=
 =?us-ascii?Q?Oc7lbRcRdmlc7wP8EMf4SGTba8iX7j4pRC1vwWu0ZUan+TP2/e0m7NQu/xUy?=
 =?us-ascii?Q?/NMQK4/CO0WcmmfoUAfFEQNQ5ki+H/d7x4JE9XttJ0veA8q1Tdjs4kwwdJ2R?=
 =?us-ascii?Q?TvPhkapY02ma2/g2XWaw77gPEmnvMRpwUyVQzmTbxKwn4rZ1bS6smJ0mIFeh?=
 =?us-ascii?Q?8TNkzvmZtwQOe1eF+E17Gp/olRpp9MfrG2y9zGy+ZlDOLv0wzElPuuniWA/X?=
 =?us-ascii?Q?i6hd5nK410wt0FEe6ALytQZCT0SbvusXb6QLsIJ7SCjNvIAqYtIjUbVhkweH?=
 =?us-ascii?Q?qRB/7BiGySO54ztZfuq8Tmo5u2gPHHF3SiQ9u5oAyDq39n15Cf1dS4tgin17?=
 =?us-ascii?Q?pX2qvPdIj+ZD3swBkb/nZgvNPIuNuxlLgSjmFSS1RNaV1lY+abzv2LjUgEit?=
 =?us-ascii?Q?/nNVqp85P7Dd4lwhOzo4v6MXatMr6dGygCfe78zw8OWw+C3R5qurTPgQMbEV?=
 =?us-ascii?Q?7/lpjL+qBZjBqrkJD/VQr/bzyIvqCGrrSZA04cV5EFkwyIebO+R56UAkt3gf?=
 =?us-ascii?Q?ZBTQ//BVSg0B/JNZvS4o4PU3IAGcdkKPewobIT4TOA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e1ee71-fd68-4529-1213-08da7a9e26a2
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 07:01:30.0579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB0614
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Riwen Lu <luriwen@kylinos.cn>

Add wakeup support for rtc-efi, so we can wakeup from S3/S4/S5 through
rtcwake.

Signed-off-by: Riwen Lu <luriwen@kylinos.cn>

---
v1: Tested in ARM64 platform.
---
 drivers/rtc/rtc-efi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-efi.c b/drivers/rtc/rtc-efi.c
index 11850c2880ad..e991cccdb6e9 100644
--- a/drivers/rtc/rtc-efi.c
+++ b/drivers/rtc/rtc-efi.c
@@ -271,6 +271,8 @@ static int __init efi_rtc_probe(struct platform_device *dev)
 	clear_bit(RTC_FEATURE_UPDATE_INTERRUPT, rtc->features);
 	set_bit(RTC_FEATURE_ALARM_WAKEUP_ONLY, rtc->features);
 
+	device_init_wakeup(&dev->dev, true);
+
 	return devm_rtc_register_device(rtc);
 }
 
-- 
2.25.1

