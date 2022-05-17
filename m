Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4664952A618
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349889AbiEQPWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiEQPWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:22:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A24112AF7;
        Tue, 17 May 2022 08:22:33 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HDw03P003203;
        Tue, 17 May 2022 15:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=39burcCxrlHCTO0uDVkfnfQU1qjDQNk4ypMYIJugzt4=;
 b=NiTKbHe+whFC9X1Zot1jEUD5vUCgRfOe0o3yjHjJ3z3KKK1y33KDfRgGyU7lD93o17rN
 r9N1Bn4Auq9C66q6HbpdJTgndrKVagN6sMF/0dJekvF9BG10jnRzBxEpRH3ymy78SSzR
 JKg44gm6LDc44uuAC4LVH3JQBfCUvSmeUiL3nEQI/Iaax6j1cRpLRka36jmne8V8Uc9x
 daUmtjoS87zyP85lOKOojp7dVl8gyxcQRyMTng4xvM6oAObqjB19j8G9U7phEJLt9yrx
 nw8iObMt8qLctuSYAwMdTBdi8xlqNnqt+0OGTjQQtCzc60Bx2TX8WU8Z7S4OzJ9+RE6R VA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g24aaej9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 15:22:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24HFL1oc029012;
        Tue, 17 May 2022 15:22:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g22v37x65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 15:22:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8SvN/3K6lO0GgBtgI6FQ72DNKn+vFPhQsqxEFUDfF2YNDQOeWu4P7jpdMsjluI0T60iIP4mX7v9hAv+gNnI93jPdK56QGFB+Cd996BIMfE2b/3fvnSVH/UgxJGtjwKa+xkYYSrL4Y8aBDI6AmkJ9W9P5tFA9nNrU8W0WWAhqk+Dzv9It7uRR+Bw9HB0Q0irxi93p4dKTNt/UxpieiyXC6A7Wjt2uIhjE2lkbuARMZUyP4TspHnBgmZ358zw/7MPAZpJA/XwhxA+GjnShyfoE8bQNxFhQEhTAwOco0bt+CmtQ3qgl/N9lnXgw4SnNkE4KlXr4yYNNmfDgdZ6N7VviA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39burcCxrlHCTO0uDVkfnfQU1qjDQNk4ypMYIJugzt4=;
 b=HxPzFvJSpOn4MCFvC8/5y97V8Zzjh1VgcctPZv+oRVz2AHT2wZGr59nYR9/c1DIORTtfLTTcyKH6LD4DYUsvd2oiuW6ZAKv36XTuhwmXXo7beyPALV9zauUE+g3YCxnpnTv4n/Rswxs4rKMUXpHComS1VU7hywUsDXDbS7oHedlqgreU1ORbmcoz2qr3wUsI9MzVed5vhYyrgmznxuzfinYq00Hhv7XrvXkLyk6AgIfuuqNitMh7SXeQZPe0Sd0Awa2YnvFNKL01WZoJIWE/5wpqTvPfeA4ysPtk/MzZQ7Dfj0BfZEe7sj745eenZ9tGndeYKc6mhkAm0DA7eiv01A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39burcCxrlHCTO0uDVkfnfQU1qjDQNk4ypMYIJugzt4=;
 b=jgYSbamVfzfpKFxF9WN5VsOcOR7Sl/iOwigHYkDx8UwpGp6fsiNnImIoFimEwfOfVGplCDvXOht7ZcYAhE1YYOowhKqMjvjKP2Yc3myOvlvPK7g/IQn0Zi/eLvJNatlLxXW0TMH1yiV5gwfV/hd+aIknDIjeCUawx6m8Ej4oYTI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3166.namprd10.prod.outlook.com (2603:10b6:208:124::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 15:22:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 15:22:20 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>
Subject: [PATCH] maple_tree: Fix 32b parent pointers
Thread-Topic: [PATCH] maple_tree: Fix 32b parent pointers
Thread-Index: AQHYagHmsteRxt79AUGaRhDYpWhYoQ==
Date:   Tue, 17 May 2022 15:22:20 +0000
Message-ID: <20220517152209.3486724-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88942948-8299-4cc1-0c13-08da3819092e
x-ms-traffictypediagnostic: MN2PR10MB3166:EE_
x-microsoft-antispam-prvs: <MN2PR10MB316679FEBB93E8BF1DBF9E37FDCE9@MN2PR10MB3166.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ZzpHyeKUd2k9zWjt4jt04fQV3UOD9KVydS5Zzb4AANq04/V+iORg5m1XE+Kt5kmteoefo82TiovDM2t4tsWvYWtNbZOXnTtqFXpXzb38OrgB1bpkkdG9zdrRWFfrmds9+b9N6TpMnr3WlOwGgmhYeqh7611sHU4LyPIQOOYRiCv9D/c8LDQefnvrQvCbLOF3Gt+iZ5jqpdjovPNDCk9eWslcRxAQ+3KMJqWMM2mMSbMNcAoCK45755EzgQnjZDJ903YR6OwnMWwDYBCDxwwSphFck+r7mwGiwaDgveI9whVNppRxi/ZYDpWpv+J3Y9lO/4J1FyIFuANUjP3x20tKqih6WGBLQoxi3L/2fj0DCDBAfSpHepdxstwEdpN2YdIUQcQTxIgu8F+YvKYdyuxE4bRB7ZbdxXEOInTU4zNviHXyM+F3unYl1WuBEaATNQruic6QanNhIof7dNtAfDPpfMpBg/yMceFEhnixgFCWTcwLDy7SZdcNnxBAlOiWE8QeJgJVvdaCgzJ88pQMJwLMjWWgm+9SFzqT0JRd5ryhSJEOSnXKa4pPLg2qRaIeTj9L8xt9IhrdrbVEiMCq0OOGyH1pp7orA4REmyqcO4j5UiDOtcm6roht7RdngCx3uptIFg6gXO3UUBkVfedV7df7787A+nXDDrDbEIHdnPtE591BnnGUuaiUQHc4hEJNr0V+RF1y29wZNHpAr1BZMTL9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8676002)(6486002)(66556008)(64756008)(76116006)(66946007)(66476007)(66446008)(91956017)(186003)(2906002)(38100700002)(38070700005)(8936002)(71200400001)(44832011)(2616005)(83380400001)(508600001)(36756003)(316002)(1076003)(110136005)(6512007)(6506007)(122000001)(26005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Hbk2fIKarnhRcCQdxjEeOVBNXJBei+WJMzPXeJSVO01TyldxywRbl6mkOp?=
 =?iso-8859-1?Q?jgZQ4QXR9EPk/214F5nbmAClxhjnoU7FGmdIwPrU/9a4hY8n5ymtpQP+Sv?=
 =?iso-8859-1?Q?nQzFxglKJCCdwFT7vax7s5MiOF4c9B1UlcRKal6TIqrmiKBDA5+h9nn44v?=
 =?iso-8859-1?Q?kPfdsp5q9mb1ivvG7Cz8ZSjNwdJF7eexvW2g8bnLjd0lHm3O3oIoiNQVhB?=
 =?iso-8859-1?Q?gFCN+I6o4qVKBYPsjSfHfij8qgJAptvyZ6NJN9yMvv+oKsHr32P9ZjW+SN?=
 =?iso-8859-1?Q?aQdqmdtVsEmoEx4SYwXZ8Vq+lzVyCVnhelXq8CkNH1aRdc1SazEnPTLG8+?=
 =?iso-8859-1?Q?t8UeTXxaru5t+BzMWTzBHjhUSSyHPcSUQ5E5ZYyfeP6eGUJ8+KO8EE/TWn?=
 =?iso-8859-1?Q?qgjeHcMpcwH2L8Py9cTdyVKiNZ4nYKHXSddPfyltqHhx92IpmSy7A/Y5Sk?=
 =?iso-8859-1?Q?DsacyZ//JMW+qD2SbZte1wd7+1yP5Mezz7rHBMatB6Bsu+i9gXJYs5Gy+F?=
 =?iso-8859-1?Q?Hue3vbYJTlYKrGj4NZNZPr/pByJq0guCRM0HLSA608qKFUROcSPDHXCvoP?=
 =?iso-8859-1?Q?Ch9pIArkz0um3WNOb/OtlVQ3yShzRhTNz3b7VOFg95JjlnX4et9eLeovgD?=
 =?iso-8859-1?Q?WeVh6pVrQvNqUEiInkIVrKpuGZFUfSuO79v8LXExGE9+WUvO4EuLTI272N?=
 =?iso-8859-1?Q?RAx4zbdZXrtq06AlDq3GZCSSVWK505iIHNYUTYje9e7nC25w5EEe7dU+ho?=
 =?iso-8859-1?Q?Tyu3yLK58knd5QLnK5rvZNxWowuNm2yyXEraYs367D8JinFb+f1s0aT0Zg?=
 =?iso-8859-1?Q?TGj4zmclLM/gqxPlFuLlxXjbGG+V+VT9ap2tAfxXsZfHXXQgIO9VzKejSH?=
 =?iso-8859-1?Q?2Q783mr8kVrX63G/Xrg5iGAbjc7J8UEYiSgjFgWjA5ISY+zmce28eNICvn?=
 =?iso-8859-1?Q?Ktbt1lV1M41+ouQj0E8tJTgVmTnV0gqgj3VovXf4YVy5Db1po/M/WK/KHt?=
 =?iso-8859-1?Q?9RSrlbY2p/qfeyXfCWCtWsau9iRftzaGtZgjxiP2zaP/c4r5uT7PL1NCFp?=
 =?iso-8859-1?Q?r0tHEUr9UXLfWRnM+qqApLCxCkqNZQEdSTRShAIj/poDbg5h+3e3DYsjZh?=
 =?iso-8859-1?Q?CN7KuVV/T7x/+WX7AT/WNgRXoGhN10yHuoGtF6XgX4lXlIl54pwyMi5Z0h?=
 =?iso-8859-1?Q?dA8iBXU76OwPimfYQXdW8ZCaDt64CmQQLjHCleqi5B1Di1x78F7poUoIo/?=
 =?iso-8859-1?Q?gQtrMVu7VlqBuuuRgbdQStWaRDET0cc3hCN+w1cVvucwmqPFMIvBJ3fxEd?=
 =?iso-8859-1?Q?ctWjVtdXHdIBVHc7Trns1Zg0dwjtd19inW4ic7vkfxIqIkquBeGottlN51?=
 =?iso-8859-1?Q?P/WiP5L2WkaNxO9renEODaONDkCr3TdiLRZ/PqpyVM2IKC0pzCNskX6W7Z?=
 =?iso-8859-1?Q?dtrnJOAu9Ak/OpHriEaB0wH/C6e0jyke+SbtWawduJc6OX4L+U/R3DLxp/?=
 =?iso-8859-1?Q?JxJzIC70qhsdQF/BTwI1UBOuvk+b6dR8+vTGuU6DcEQK4HBG6tw/3AD5uE?=
 =?iso-8859-1?Q?F8gVXZdR4tAElWsfvqqt/J5TkZ7lpHv4JfCadgHqDR9JIAhsB6IUyuFuVX?=
 =?iso-8859-1?Q?W98JiDb29TYL4ZpN+U+tPBT82/3GIRCTMyuOfcNIaYeF1vausgMrhs6Rx0?=
 =?iso-8859-1?Q?RG1qjd4EVRaMmQQRmlBCkylqSsv8eK5yeJ98a4IftPsBJ0PXwniT5WoUxh?=
 =?iso-8859-1?Q?r5lHSw3jtAFtEncGckwkR7qrW+oGcaUBAEXieiBxYKA47KBHTgAiZ9JbBH?=
 =?iso-8859-1?Q?fIcM+XopWSQkpkqy8KGgLJ0NFY7YF/I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88942948-8299-4cc1-0c13-08da3819092e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 15:22:20.5540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H66N+Im1rYUFbMD714T0LU7DnU3OEJCvqd66vsrHWY14E9v9lGqDcEqK/a/FpeweUBePO4wiFgyVx4hVr/Y2Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3166
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-17_03:2022-05-17,2022-05-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170094
X-Proofpoint-ORIG-GUID: bLi9VJrQh7pJdXhZoOT5yfYz-JTJYvbK
X-Proofpoint-GUID: bLi9VJrQh7pJdXhZoOT5yfYz-JTJYvbK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

32 bit parent pointers need an extra bit to account for increased slot
count.  Update the constants and documentation to use the remaining high
bit.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h |  2 +-
 lib/maple_tree.c           | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index fb689d628cf7..d044140a3a2d 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -37,7 +37,7 @@
 #define MAPLE_NODE_SLOTS	63	/* 256 bytes including ->parent */
 #define MAPLE_RANGE64_SLOTS	32	/* 256 bytes */
 #define MAPLE_ARANGE64_SLOTS	21	/* 240 bytes */
-#define MAPLE_ARANGE64_META_MAX	22	/* Out of range for metadata */
+#define MAPLE_ARANGE64_META_MAX	31	/* Out of range for metadata */
 #define MAPLE_ALLOC_SLOTS	(MAPLE_NODE_SLOTS - 2)
 #endif /* defined(CONFIG_64BIT) || defined(BUILD_VDSO32_64) */
=20
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 751aafd01c42..8cde2edcb4f8 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -354,7 +354,7 @@ static inline bool mt_is_alloc(struct maple_tree *mt)
 /*
  * The Parent Pointer
  * Excluding root, the parent pointer is 256B aligned like all other tree =
nodes.
- * When storing a 32 or 64 bit values, the offset can fit into 4 bits.  Th=
e 16
+ * When storing a 32 or 64 bit values, the offset can fit into 5 bits.  Th=
e 16
  * bit values need an extra bit to store the offset.  This extra bit comes=
 from
  * a reuse of the last bit in the node type.  This is possible by using bi=
t 1 to
  * indicate if bit 2 is part of the type or the slot.
@@ -366,19 +366,19 @@ static inline bool mt_is_alloc(struct maple_tree *mt)
  *  0x110 =3D 64 bit nodes
  *
  * Slot size and alignment
- *  0x??1 : Root
- *  0x?00 : 16 bit values, type in 0-1, slot in 2-6
- *  0x010 : 32 bit values, type in 0-2, slot in 3-6
- *  0x110 : 64 bit values, type in 0-2, slot in 3-6
+ *  0b??1 : Root
+ *  0b?00 : 16 bit values, type in 0-1, slot in 2-7
+ *  0b010 : 32 bit values, type in 0-2, slot in 3-7
+ *  0b110 : 64 bit values, type in 0-2, slot in 3-7
  */
=20
 #define MAPLE_PARENT_ROOT		0x01
=20
 #define MAPLE_PARENT_SLOT_SHIFT		0x03
-#define MAPLE_PARENT_SLOT_MASK		0x78
+#define MAPLE_PARENT_SLOT_MASK		0xF8
=20
 #define MAPLE_PARENT_16B_SLOT_SHIFT	0x02
-#define MAPLE_PARENT_16B_SLOT_MASK	0x7C
+#define MAPLE_PARENT_16B_SLOT_MASK	0xFC
=20
 #define MAPLE_PARENT_RANGE64		0x06
 #define MAPLE_PARENT_RANGE32		0x04
--=20
2.35.1
