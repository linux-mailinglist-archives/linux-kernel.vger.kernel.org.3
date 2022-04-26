Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA5451015A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352073AbiDZPKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348347AbiDZPJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:09:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CC71399B9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:06:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSxgc032179;
        Tue, 26 Apr 2022 15:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UMVtfXJ0Dlf1aeg6H3yWSnihQ4t5SMLU/QgHB0zb7ck=;
 b=swruYEg6TsGumNej/SdgovgBzyln0ph1yJwW3N8KpQMBwQaeytx4dmu69REDkj3J1tqf
 XT2qytaCmO78AUrVnp0dXFJMnt4xNIOfzm4FQq8Ygpfw8o2kOu9pGV+x3UuBn3zs9VT/
 uhsojjsKQsO5UVUG1XbQm6S8Jb6LGKnT1uYfS/K3sF7gBQv3tj8On4Aubbtzd8y+vZQ/
 TvwEKmTPvJsPr4lo1Debg1vF4DVbM0qeWfzfg0SpEinIx0Kf9EE+HmDjAVeQA8G84DSI
 IqJpzxxx/lYApS5DmbJVb4rCdB4MBN5ikdl5CVvgbnx+UOmS4IIPUjsUxIaOi/pCoVsL TA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yx4xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF63Eb012545;
        Tue, 26 Apr 2022 15:06:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3gq7k-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loVNCwmrDE7bt3cLYCQAYiWAeL3bGsWX6plLohwegd8X9q8ALUBYnQWM0jfpOnRKB2nYbOulaHMFRFo5+8YKneLpuF5eGxJKZ4kQ6isTKpVGZWD7E7rX8ZoqrmqKrx5mmKE/vkF5UuXu6BydmWBwlYoB/EUsOOOnnqpvyf3zObDGGaduVTxUCo6HOvTozNobkQPlWPsgHWynkfmc+65DNxoAv6UvfJ/5/YYy95spZhJ/jPIgLQKhmsC7/2bE5wakB0VtMdWWipK8GVwwKYhpLZ0NzWtssC4NV+biR/jqv3Ta5fV4l5kR23VMyUKbw+V5Q7Lz21QxL+Hd9xACAC6gSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMVtfXJ0Dlf1aeg6H3yWSnihQ4t5SMLU/QgHB0zb7ck=;
 b=VY0wKe36sh8UpR9TKYnUKeMMyueDANOhSByj63bNS82AmSmtQEo0pMZAyqtw4HTyJeXlmdjAbC7GZgtCtKIx/VCjipb+KjWNzckqPx4QOjRYtYfj1gENQXadmBvxXHQ2juwuSzzkx8LXUOepOAHUkZ2m9Qfcuo4D//onVRwNYrdY1YPAELK0JrwNNUH62XLxOmafpMlAcp/e3pb6FQlTE9ByTBUABmS2vdnCQvm/SvhqP0HaXXcXX72HtvQpHD19aIj8QGrzvZVlxkFPsXbkMw8fppmZe41e1kyU5ucenOrqgq5vbrwMf1nCmjyi1+Ftj2PwY/1XcUvayfyEkmvNBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMVtfXJ0Dlf1aeg6H3yWSnihQ4t5SMLU/QgHB0zb7ck=;
 b=imT3Myn1u/rSS+UGxCliOqTuuWJPQJbRodw66DjWO85kNttOjZh8gDE6IrEeza7M3fAe4bphMoPaIVV5AGZlu8aodoL2OrjjggKY1P06WHnbPKVw/ocs614rwm1dP5A41ci0vRarOdFgcN8mIC5OW4GY4E7IlfI30FMdvr8lm2A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4659.namprd10.prod.outlook.com (2603:10b6:303:6c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:06:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:23 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 06/70] mips: rename mt_init to mips_mt_init
Thread-Topic: [PATCH v8 06/70] mips: rename mt_init to mips_mt_init
Thread-Index: AQHYWX8wMWtZOqyCAUe05mjGtPHAkg==
Date:   Tue, 26 Apr 2022 15:06:22 +0000
Message-ID: <20220426150616.3937571-7-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7dbe1b5-4f4d-4194-59b8-08da2796543a
x-ms-traffictypediagnostic: CO1PR10MB4659:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4659CB47656702D243334B8CFDFB9@CO1PR10MB4659.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xbK2N28kxNTl/gj7bEoSUgZhLqaAlUeDrzzDLS+u1HAkwr/74lwKMAC/B6MVfjy444sRdeFK4XmFHfPQgb3rWiBHPIhXUQpkn0bN1XEegamMAtdUf4n13La8QhU+DLlP4TVn1ui5yMju7Vc5jyS0rOIZ9Vm605kAnMmQB8iR6qu6OYsT9S0Ask6nmTZY8tv/I28o2dFsf22vE2xbvdC8Ybu3lQDHstX+mAOHSxveLva3nkOEG/eD1Z1K/PHs5zuMyLRUujNRzQR9j1CaOORnnRyZbBAOiNAQm4lvsG7z0l92XTABnREFyIYWXucMu9hsDSpKJ40NxK4X5cdV8stFkYWg7WLUqAEzIIysX/AxLnmfNMvqhNySmMPRJg9bkVXS07geyBBvBOwnKEQ5rReOYdMy7jGYEIWx2wJECEFyP+BJ/0/gsQK0S6e6Rf/qH06UKt0DTgN5MD8X56S9Okh+ttf9KMMet4LsYON0L4Mmf/2ise5BdfxJy1S7FrKo7VbPVJQn5rovh46+RoBTbG0Gi9jS/lDqEz87+cjt4QO0RVmUA6NjlyRd8sTohhI5Tip5otbCju2OlLh7XdRcpkFEcTTsrMYygC/+n84ujI5DIv3P4BW4IgDluhSr8egXq83V2kxYTk7Htl8wCbvKyFUI/Zf/X+ux7RL6CLAtgyNC/ifZVDHd7Rz6tu7KbfZ0atGtLsgZ3q6vgEzmyLXA0C7GgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(66946007)(66446008)(2906002)(4744005)(76116006)(508600001)(122000001)(316002)(8676002)(71200400001)(5660300002)(110136005)(44832011)(8936002)(64756008)(86362001)(66476007)(66556008)(38070700005)(38100700002)(6486002)(1076003)(186003)(6512007)(36756003)(26005)(83380400001)(2616005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LFoa5lcZPxWBFACcC/rZwCQ9PBkEl5Pg5z2V9F4TtR25pwidQ9v93GaVeg?=
 =?iso-8859-1?Q?uY9uRSDRqoviSGrbQhLxKKHjoDvIE3h6DgJH2hjf9K7wLGCsU1E6g74qnV?=
 =?iso-8859-1?Q?MicWNMg7rqW+cYW2Gq9hA2CLric5DFcTlI8KQ3Og88Au5dVTzOWPQuaLiq?=
 =?iso-8859-1?Q?GSBpe/WlCYaT/Kvt8qzVS6BM8ahagnhT1PWAVcN7ogqNUJnX6gWiGU/SjE?=
 =?iso-8859-1?Q?OIp0bnD20VnUnDPI0Bm0gwAAWXY4wh6H8otyg9Ki5AjTCsZVRagORpkf+E?=
 =?iso-8859-1?Q?lzSMH0GxS7YucANmvkderKqp9xz/m4RnAZs+K0JJCRbP7S49FR77/szd1p?=
 =?iso-8859-1?Q?7kvTyD0keNNCzby6fxjyHod5OevfD7nLidbjUwMZfgjqDHS4uKX5ozc4HH?=
 =?iso-8859-1?Q?j/+DL3qGkTVyZYc713gh6mFEjcmHH2RQRQ++U8Xe8Oo5jKrHk0p6dHLWdk?=
 =?iso-8859-1?Q?OH+mBqzerM7ImCgbQtxmCdeP71cRB1lNC3cHW0DALxFbqb2tMnWRsn1MVM?=
 =?iso-8859-1?Q?z3OG3h/Q2ddbPZ1B1E6/oh3wWueGoGDIuO+e6Y8QQD2DovH3ibhJFEUqrb?=
 =?iso-8859-1?Q?L7JMtBteErPcrEPrnKClolg7v2dvzF8Ubx+2pkfUxSbh4BED6oqsTiKEvh?=
 =?iso-8859-1?Q?sa/CqbQR7oNbPo6O6zr4wxARXFmDv+GaE8axQNOzAuOon6QPxDD13qdFpb?=
 =?iso-8859-1?Q?D15ZRBNHHAVPusawH3Ja2Cx99oukTtWc5mkJq28TrNMSjgLfpsT47nQhxA?=
 =?iso-8859-1?Q?WLj66PFxkSk+AhTV7Tpr/xIPulbmyTuT1OwDjIrgIvC/d23GplBGiTPudX?=
 =?iso-8859-1?Q?f7IoqdhRS5N7sbHSmNsURQbP1PHiBGfbn711C8wHFrtIBxW4Dq50wIhdKh?=
 =?iso-8859-1?Q?PEWNGS1fE8NCVSgCM7QWZlifUAzkNH53uiHnbfHWeDsqShA9WV0rnv3L1l?=
 =?iso-8859-1?Q?wp1sSOrfKKxOn80y2sBxuP6QbQA5YIx/4qV8xg9JGqSANsXRzwa1awOGB6?=
 =?iso-8859-1?Q?n8PBwQsJ3Jq7XmOZaryeT3itCbHPUoogAUcGyC6nEa9/mSBd4UjFdqzWoB?=
 =?iso-8859-1?Q?Rkk/28rJOSiNFt4afViTczLgm1zX88q9yVr7p3/BTEH99GYQ8TSyPNjKhk?=
 =?iso-8859-1?Q?yL/m/xDDHexHMVwXgW5ypHG3k8RvygO0HBsEoErvlzN+Fc/OgvSrCiRDpf?=
 =?iso-8859-1?Q?Xz/rDmu3MUCGUmN3n9kk/Fu3udjBy+Te5hpGXABs9Lj0/6GjSRbCA+R8aQ?=
 =?iso-8859-1?Q?pA54fbkT07tlqHaaFTyLh9hJNZkYEcBOuB5902H/R6Vqgut62awOud1VTS?=
 =?iso-8859-1?Q?ngKeCOuHRYL7AuLv/CqdExH/b/rYfmhQV3T2w5XVieEDBacBTMeL1HNGyP?=
 =?iso-8859-1?Q?jCROZKKaUp1Ivzj5swSIzcB1UfHOE29hzK0ruE+RROe/sErcsJbTpTLZ/l?=
 =?iso-8859-1?Q?ipFR2RzTZEEwHIg6R2PQ7OOzohQwNUcHCWTnJz7K5UytqTSfDg/DFb2usz?=
 =?iso-8859-1?Q?jr5KU/Xbu3+FtqLz5/NYjxP1zroSheTh/oDSRABWHS7KHzBnuT9esDerrv?=
 =?iso-8859-1?Q?2UlMI0KzAiegbitTLz5F9KR83l2Qe6vrViQMJUlksFEw/kNnLK9Tknu+jE?=
 =?iso-8859-1?Q?IM7oKtx/Cf8RtrQuiS490RKpIHh8biMfYLd0dl5sGHIj0LfjASG76CM8Yv?=
 =?iso-8859-1?Q?PX5LEieTpmAJF7ziw7vhIiZZHxWNSYZe5q7DVKW6RMZdg0l5QaCc2Wnmnl?=
 =?iso-8859-1?Q?cI/ibdTTmX4WdcQk1iW7BVHDwYauDmKOREOfFd3lhoBLL2U/BLCq2ZhoyO?=
 =?iso-8859-1?Q?a/nWjWGm4GV34ssEdHQ+G7fW2WnChfg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7dbe1b5-4f4d-4194-59b8-08da2796543a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:22.3347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uL98XCuBee2Dy5G7IztiwliNuQ5E0kBi75nV3GTB3EqBn2woHRu2/6Nno4O8QgUX1pV34/y70GldFdsz4ct6rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4659
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: wP1sX1mkgOvw7XNWcPwjHu3ChUESeb4h
X-Proofpoint-GUID: wP1sX1mkgOvw7XNWcPwjHu3ChUESeb4h
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Move mt_init out of the way for the maple tree.  Use mips_mt prefix to
match the rest of the functions in the file.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 arch/mips/kernel/mips-mt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/mips-mt.c b/arch/mips/kernel/mips-mt.c
index d5f7362e8c24..dc023a979803 100644
--- a/arch/mips/kernel/mips-mt.c
+++ b/arch/mips/kernel/mips-mt.c
@@ -230,7 +230,7 @@ void mips_mt_set_cpuoptions(void)
=20
 struct class *mt_class;
=20
-static int __init mt_init(void)
+static int __init mips_mt_init(void)
 {
 	struct class *mtc;
=20
@@ -243,4 +243,4 @@ static int __init mt_init(void)
 	return 0;
 }
=20
-subsys_initcall(mt_init);
+subsys_initcall(mips_mt_init);
--=20
2.35.1
