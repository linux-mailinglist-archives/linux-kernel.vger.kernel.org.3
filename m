Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6799577350
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbiGQCsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbiGQCrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:47:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C5C1BE9E
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:01 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8g1U031750;
        Sun, 17 Jul 2022 02:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=4bKTi/22rVVubSxPx//uLNvING17kuo/Ws3CaUaVZq8=;
 b=Jhj226m0MH/9nTqn5c0KofoEOdqZnGJDnFKBljFocBX0SAasuIUogW41h6CDYJhnoN03
 QaCQQvUuIjc4f6lsjQBmy2gDCrPKwYLublZs21Fd3MqSzAHPL7cx6hvfgKkgbLWIme6Z
 dbUDU6a8z1aSOvezqUwXytnddUCL6MOK6qt/xxuc0t0BVya3aDXSpGg7YWcUZAQhquPX
 Ym2WOAjyOoJZFgO8C2or342IhxHqlyQreQPOB7927aeSAQRgezUvbH9pV1DfcyGX88Bo
 wSgz5VhtPI4rOi+InX47dU+3LwDqLhVMcXJGVeux8yzbh4gmvyoSCRDAl85uoRDWOArh KQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm428y7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYIma036151;
        Sun, 17 Jul 2022 02:46:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp63m-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRmb6NMdvJ8lWHAChi7hA4oKdeFOnTdzhjcMLDdmdK5yUKNlUZwDIDBGf761SU7BrflX6Wg3ejlqfw1xydgKrzx1ye23wTfUTWCw4Xi55VGbjnO/RMR6F8g1+swgtCi9liRTTNSjjOfvTiEAqz0L5rks8YP1fQ/GLC2vodlY5OaCILSdcuJnlagHY+xYi4vlqrOhBmqoAiyG+qA+oac5rKVrnnG7xBUPlVA/aqRdXBZibsnBhCAUX8ErkMpJ1FrjTm/Ei0KK1oIT476khr+rAOQSVAU5j72Z2dT/81scCLhCPoWyXf9tYzFJDeW3Qt8FEoLBBPQwvv6rd8WTZph5/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bKTi/22rVVubSxPx//uLNvING17kuo/Ws3CaUaVZq8=;
 b=U7E1X2W5YDa4/qYTKNkenTYQBTiiafcD4BAg0DJB6hsYkt9M+e6ZKy6EuY7F7Advlgz2JcEGJpa0HI4qH+ya0uc86QowSUDLX69Vgl7IJOr9opNz/g2T7BZDwdm77y+NkmId7qpt5Vs6yWX1uJEa2oJnFx+JuSvmvtWAKt6sbj9v4mPkGm7BgBJfzV9NmLC1tMFEuT7J3aiS8HiI+kgpzXICbClt2mzmnG9I7h05N30HZSptD7TBdA5MlHKvZ8Zz9Td2FynkuPfUl5aGurSFcPhykKy1hic4WTAZbuaHk11eKU4KoHD5GJH6l6MKEDPbXfq9jhcv7vcStsGJWeFgyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bKTi/22rVVubSxPx//uLNvING17kuo/Ws3CaUaVZq8=;
 b=Yt1vp2VGG/htpm+6UHdub9m4G/e2NKXR8AldUpaJ64YUKOt8dXjdOVnIJoUL6IikXqortCmxv/28spR0OfiFvmM+BIGTTbb9FVi+XzhTN7rv7WeLsieIAPlc+kW5m99HYQdVWgRmMxeeRWDEbcNCRAwTGCxHMwj0CiVgzlD5b8U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2908.namprd10.prod.outlook.com (2603:10b6:5:6e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Sun, 17 Jul
 2022 02:46:45 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:45 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 17/69] mm: remove rb tree.
Thread-Topic: [PATCH v11 17/69] mm: remove rb tree.
Thread-Index: AQHYmYdy1I1Pe6ccEUe7R1PrOp9ucA==
Date:   Sun, 17 Jul 2022 02:46:42 +0000
Message-ID: <20220717024615.2106835-18-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07dd0eb3-259a-4610-d85c-08da679e9659
x-ms-traffictypediagnostic: DM6PR10MB2908:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DYPmL9hjdGtV0Oh5tVTGvgSFrQuK9A+7L6MzGCz6XSKVdM+kHN7W6k5PvRCDxw5+0sI4dzAXWCxantRBdfugvYsrmM/cQoE4GfqQWhNGQlRYKJ+rjIu4BCZ3ztwEaKrIzACiiLkwawimH9zPkJu5nVCp8x28sxT9R6pDgft95T+1jGY/6LG6w7PAR5Eq3jg/o1/xSsQM0hOwae1Vj9ABkVXbpQYBwXQx3WwPb8SkTJGu8irMsrFD147tCc+jbBeMuS1bsl3gFyPPhZWvIKgs/JbC/D4bD9KmmfcxlbADpmJk4OkCwPTik/6t/Bq1ZD+oWa3Y9ZJywSoOp/La5aPBrt4DJla+TN4dYOrtLdEWnQ5Y5EUaZKAtbIW6oK0fGiVSJ7ARJrTWS7KI/OjWMY0vhh2xqjbAMj5UPaFlZ7Vrl+Z1U4RarKL209u6okoOXDWGAauRY0ZJqqcrtWV8Zg2gOWPm/+ct3X6OCXFUbH5/vZ8pOk9aSQE8opVgGGwFJ2NwnGrT1PnViUxvRZvU9SKCKAArdMBNFsBIaqiD9HAmDvasaszhKVTcrlM55eEeUluKb4SQjemxlRKSWhscfiqzS25N8BmdRLwZM601nG2+L4L29R2NzyfeUBr+NdAJyIeKCJgiMjRlJwcIxb9mFJbEpF27Enn+uOjnuq8WyPrDpVya8N/s2kREvRPnscZ9IfKuWzm6ZvlycnaFiJXEC2M7P+qZ/tZaGz+9ACMxuQDeNMLTJXVrCN25egUehYG0QZcepeMHYPuraJqR1yaoL3YgLn7ZueqMo0E48pxcgLvzXMho4UZdJGSH21JRer3hJ5dOxf2bef7iVrdGcuAAaPghB8nHkO0PHZH7zJ6glx1dfxdhF7dzy0eOcXEiVjrcrwKH65+kO8SB/tL2sEWJQhLEHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(136003)(366004)(5660300002)(122000001)(86362001)(38100700002)(38070700005)(6512007)(83380400001)(186003)(36756003)(1076003)(2616005)(6506007)(71200400001)(8676002)(110136005)(316002)(41300700001)(966005)(478600001)(26005)(6666004)(91956017)(6486002)(66446008)(64756008)(66556008)(30864003)(76116006)(66946007)(2906002)(44832011)(8936002)(66476007)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7dQ2E2uDz1rYvXJkItTzsuIg5d+Rg1PdXiy+0S3T+LBuyizNuUkPLIQPRM?=
 =?iso-8859-1?Q?tXKd7NjHDr39xwtJxb3qm6hsvEu7OqpAvIqX1IC51TTo9E1MeDSH+YuWD7?=
 =?iso-8859-1?Q?8vNO50gmC+CxGJxw5gq3u2OhbRQs4noV/TSzMheDT6a4XOrbIWxr59bqYv?=
 =?iso-8859-1?Q?r2z+yXhrmcbsbZJx4eG+cEXYfwfR43Cvqv06oVp2ThE7BUm3rAMCirfyv1?=
 =?iso-8859-1?Q?kgWNSyzxA+j4OsQOy19I2148jBxA5VYWWAu+BpcE/7FS7ZwKy/bvskQDmn?=
 =?iso-8859-1?Q?DP13cbzBXyJvxi7F/TiYHcff2PuC3Pk1GXUN6Q1VB/ACC8/xlIwpOYDtVJ?=
 =?iso-8859-1?Q?+MS5Jf+9RJ0GDl4CmgLBVr35HZrcAp0i9wipxKRTHZ34ELIiXR0jpOrxxC?=
 =?iso-8859-1?Q?WFzMMnD47vgOEjKBxKdznV6RzZ9DKh4DZh2fWCO9dx0grHfVLgC1iYngb3?=
 =?iso-8859-1?Q?zg3RmSp1Oj/Bq8lZYhBTDYLX/0f5z/weF0lAgHkdG2CjISkBBBvzqnnLsU?=
 =?iso-8859-1?Q?LfAQS9N+FBJZvSmemedfkGw5cJd48tyBT5mTdJzPGzSfDLlBfr+D7EXVPW?=
 =?iso-8859-1?Q?p5p4vTIuJcSylL1ri9qRxEnvavx0azmBheTSn9vctaH4eWzYLVDIWZWW7c?=
 =?iso-8859-1?Q?18ndgn2SCK6hwkdsTbEYrejwdro7SAQLEBd0LE2BPljCbdSEukjStIJ47p?=
 =?iso-8859-1?Q?3QQNjkn0qnrrcsFVAl5ZYFFJS697hUcHUYNLOvdK6Lu501OWnjeEc02n1b?=
 =?iso-8859-1?Q?y01KKICPejagioSQa4LT/CXhy/6C5UcoHgk7qWdBG/tGDVFQYntKX3oPva?=
 =?iso-8859-1?Q?fTNTQsPI3l7pJ+BGtjdQrjM4A6fIe49F4AFRIKdMexxzl8umcN/0vE6+lh?=
 =?iso-8859-1?Q?LsoqfMWWsCF6t+9NM8m7X9vkgognT4j2X4LXWnRHRzVMl0WvmE9BK85zat?=
 =?iso-8859-1?Q?jEtSTq7L9ZOm23bV8dUbL60N8ejKEceYWRM8+vY7VlsHZJzQswHpzpbgZX?=
 =?iso-8859-1?Q?ACGkqe6uAOEGJt6eDW2zXHoE3khB1DD8gFx6bYjAR6cVH+H0oSrb4dlGbn?=
 =?iso-8859-1?Q?klvqxwUHP3uCsPrzqvOKG2WvQaiWIrIccElf7iEXcn7Y/qoLL3Yg4QyalZ?=
 =?iso-8859-1?Q?+ELrTFzlcO2M5xJMlxZLgq8G8WJ9nq7EYBuOCXPKbgGDDIlyNVBOgVOICh?=
 =?iso-8859-1?Q?eLvu74m1hIKOd954d1HCKIMevFEz5+OdoGF1cq8b1CUXbiW7AyvDmBFQ2y?=
 =?iso-8859-1?Q?NcYM9ynBOR5edNaNO6HHapACJgb8diOkQQy4g64HwMOEn37dSv2eLcd2pK?=
 =?iso-8859-1?Q?0iXiFLsfrcTNnScboRg4NVu4F+h1rt2tef9ne5vfDioVCbVWZ1wO2IbscX?=
 =?iso-8859-1?Q?Zc2P4JRpt3dhNIkSImR7vAbGKYEuN6JOFicKkiPpAouotnCFSyEVMQViuU?=
 =?iso-8859-1?Q?A+CeoQxguQcYsMdaHf/AZKuu81ZaN0XnUWJVWAI33ctPVqIcGyNamlCbEr?=
 =?iso-8859-1?Q?tiz2jVlcbFFJivLsB6cKlXG8RLZquJaz8FU686Ini+fEPsI9tZN3+xs1U/?=
 =?iso-8859-1?Q?4lBZzq6Gn4p91rIzIQ1/YLd6SD5W9ZRVJSlFKAc5CVuMUGdAY7g/6HOLj9?=
 =?iso-8859-1?Q?tvkEXjhUGKc5CqaqPC3f85DJHHejsbtjRMRxopNSSkam1CdIbpHSkTDg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07dd0eb3-259a-4610-d85c-08da679e9659
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:42.3968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JowU0H2zXt4SeehmJkh6vi5qEH8RCSOHCLrwbY4Faa/GChzeE8iiiGlSde5XhTupAHK+g87ErqAL7UXl6Zju4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-ORIG-GUID: wbBWNYEfK2GxbQbmD2fkeFuwaLRyjorM
X-Proofpoint-GUID: wbBWNYEfK2GxbQbmD2fkeFuwaLRyjorM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Remove the RB tree and start using the maple tree for vm_area_struct
tracking.

Drop validate_mm() calls in expand_upwards() and expand_downwards() as the
lock is not held.

Link: https://lkml.kernel.org/r/20220504011345.662299-2-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-18-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/x86/kernel/tboot.c    |   1 -
 drivers/firmware/efi/efi.c |   1 -
 include/linux/mm.h         |   2 -
 include/linux/mm_types.h   |  14 -
 kernel/fork.c              |   8 -
 mm/init-mm.c               |   2 -
 mm/mmap.c                  | 505 ++++++++-----------------------------
 mm/nommu.c                 |  87 ++-----
 mm/util.c                  |  10 +-
 9 files changed, 144 insertions(+), 486 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 71c54ad3868a..3b388330a106 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -96,7 +96,6 @@ void __init tboot_probe(void)
=20
 static pgd_t *tboot_pg_dir;
 static struct mm_struct tboot_mm =3D {
-	.mm_rb          =3D RB_ROOT,
 	.mm_mt          =3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, tboot_mm.mmap_lock=
),
 	.pgd            =3D swapper_pg_dir,
 	.mm_users       =3D ATOMIC_INIT(2),
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 1eddef189d68..07677fde00af 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -57,7 +57,6 @@ static unsigned long __initdata mem_reserve =3D EFI_INVAL=
ID_TABLE_ADDR;
 static unsigned long __initdata rt_prop =3D EFI_INVALID_TABLE_ADDR;
=20
 struct mm_struct efi_mm =3D {
-	.mm_rb			=3D RB_ROOT,
 	.mm_mt			=3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, efi_mm.mmap_lock),
 	.mm_users		=3D ATOMIC_INIT(2),
 	.mm_count		=3D ATOMIC_INIT(1),
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 60045508a518..051b503c3fdb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2668,8 +2668,6 @@ extern int __split_vma(struct mm_struct *, struct vm_=
area_struct *,
 extern int split_vma(struct mm_struct *, struct vm_area_struct *,
 	unsigned long addr, int new_below);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
-extern void __vma_link_rb(struct mm_struct *, struct vm_area_struct *,
-	struct rb_node **, struct rb_node *);
 extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 47fbff4d4502..8352689457a2 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -405,19 +405,6 @@ struct vm_area_struct {
=20
 	/* linked list of VM areas per task, sorted by address */
 	struct vm_area_struct *vm_next, *vm_prev;
-
-	struct rb_node vm_rb;
-
-	/*
-	 * Largest free memory gap in bytes to the left of this VMA.
-	 * Either between this VMA and vma->vm_prev, or between one of the
-	 * VMAs below us in the VMA rbtree and its ->vm_prev. This helps
-	 * get_unmapped_area find a free area of the right size.
-	 */
-	unsigned long rb_subtree_gap;
-
-	/* Second cache line starts here. */
-
 	struct mm_struct *vm_mm;	/* The address space we belong to. */
=20
 	/*
@@ -483,7 +470,6 @@ struct mm_struct {
 	struct {
 		struct vm_area_struct *mmap;		/* list of VMAs */
 		struct maple_tree mm_mt;
-		struct rb_root mm_rb;
 		u64 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
 		unsigned long (*get_unmapped_area) (struct file *filp,
diff --git a/kernel/fork.c b/kernel/fork.c
index f575a3bead0e..9f2802eff361 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -581,7 +581,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 					struct mm_struct *oldmm)
 {
 	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
-	struct rb_node **rb_link, *rb_parent;
 	int retval;
 	unsigned long charge =3D 0;
 	LIST_HEAD(uf);
@@ -608,8 +607,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	mm->exec_vm =3D oldmm->exec_vm;
 	mm->stack_vm =3D oldmm->stack_vm;
=20
-	rb_link =3D &mm->mm_rb.rb_node;
-	rb_parent =3D NULL;
 	pprev =3D &mm->mmap;
 	retval =3D ksm_fork(mm, oldmm);
 	if (retval)
@@ -701,10 +698,6 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		tmp->vm_prev =3D prev;
 		prev =3D tmp;
=20
-		__vma_link_rb(mm, tmp, rb_link, rb_parent);
-		rb_link =3D &tmp->vm_rb.rb_right;
-		rb_parent =3D &tmp->vm_rb;
-
 		/* Link the vma into the MT */
 		mas.index =3D tmp->vm_start;
 		mas.last =3D tmp->vm_end - 1;
@@ -1128,7 +1121,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 	struct user_namespace *user_ns)
 {
 	mm->mmap =3D NULL;
-	mm->mm_rb =3D RB_ROOT;
 	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
 	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
 	mm->vmacache_seqnum =3D 0;
diff --git a/mm/init-mm.c b/mm/init-mm.c
index b912b0f2eced..c9327abb771c 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/mm_types.h>
-#include <linux/rbtree.h>
 #include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/spinlock.h>
@@ -29,7 +28,6 @@
  * and size this cpu_bitmask to NR_CPUS.
  */
 struct mm_struct init_mm =3D {
-	.mm_rb		=3D RB_ROOT,
 	.mm_mt		=3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, init_mm.mmap_lock),
 	.pgd		=3D swapper_pg_dir,
 	.mm_users	=3D ATOMIC_INIT(2),
diff --git a/mm/mmap.c b/mm/mmap.c
index 1d683631801c..e50e989b7aa4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -39,7 +39,6 @@
 #include <linux/audit.h>
 #include <linux/khugepaged.h>
 #include <linux/uprobes.h>
-#include <linux/rbtree_augmented.h>
 #include <linux/notifier.h>
 #include <linux/memory.h>
 #include <linux/printk.h>
@@ -294,93 +293,6 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	return origbrk;
 }
=20
-static inline unsigned long vma_compute_gap(struct vm_area_struct *vma)
-{
-	unsigned long gap, prev_end;
-
-	/*
-	 * Note: in the rare case of a VM_GROWSDOWN above a VM_GROWSUP, we
-	 * allow two stack_guard_gaps between them here, and when choosing
-	 * an unmapped area; whereas when expanding we only require one.
-	 * That's a little inconsistent, but keeps the code here simpler.
-	 */
-	gap =3D vm_start_gap(vma);
-	if (vma->vm_prev) {
-		prev_end =3D vm_end_gap(vma->vm_prev);
-		if (gap > prev_end)
-			gap -=3D prev_end;
-		else
-			gap =3D 0;
-	}
-	return gap;
-}
-
-#ifdef CONFIG_DEBUG_VM_RB
-static unsigned long vma_compute_subtree_gap(struct vm_area_struct *vma)
-{
-	unsigned long max =3D vma_compute_gap(vma), subtree_gap;
-	if (vma->vm_rb.rb_left) {
-		subtree_gap =3D rb_entry(vma->vm_rb.rb_left,
-				struct vm_area_struct, vm_rb)->rb_subtree_gap;
-		if (subtree_gap > max)
-			max =3D subtree_gap;
-	}
-	if (vma->vm_rb.rb_right) {
-		subtree_gap =3D rb_entry(vma->vm_rb.rb_right,
-				struct vm_area_struct, vm_rb)->rb_subtree_gap;
-		if (subtree_gap > max)
-			max =3D subtree_gap;
-	}
-	return max;
-}
-
-static int browse_rb(struct mm_struct *mm)
-{
-	struct rb_root *root =3D &mm->mm_rb;
-	int i =3D 0, j, bug =3D 0;
-	struct rb_node *nd, *pn =3D NULL;
-	unsigned long prev =3D 0, pend =3D 0;
-
-	for (nd =3D rb_first(root); nd; nd =3D rb_next(nd)) {
-		struct vm_area_struct *vma;
-		vma =3D rb_entry(nd, struct vm_area_struct, vm_rb);
-		if (vma->vm_start < prev) {
-			pr_emerg("vm_start %lx < prev %lx\n",
-				  vma->vm_start, prev);
-			bug =3D 1;
-		}
-		if (vma->vm_start < pend) {
-			pr_emerg("vm_start %lx < pend %lx\n",
-				  vma->vm_start, pend);
-			bug =3D 1;
-		}
-		if (vma->vm_start > vma->vm_end) {
-			pr_emerg("vm_start %lx > vm_end %lx\n",
-				  vma->vm_start, vma->vm_end);
-			bug =3D 1;
-		}
-		spin_lock(&mm->page_table_lock);
-		if (vma->rb_subtree_gap !=3D vma_compute_subtree_gap(vma)) {
-			pr_emerg("free gap %lx, correct %lx\n",
-			       vma->rb_subtree_gap,
-			       vma_compute_subtree_gap(vma));
-			bug =3D 1;
-		}
-		spin_unlock(&mm->page_table_lock);
-		i++;
-		pn =3D nd;
-		prev =3D vma->vm_start;
-		pend =3D vma->vm_end;
-	}
-	j =3D 0;
-	for (nd =3D pn; nd; nd =3D rb_prev(nd))
-		j++;
-	if (i !=3D j) {
-		pr_emerg("backwards %d, forwards %d\n", j, i);
-		bug =3D 1;
-	}
-	return bug ? -1 : i;
-}
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 extern void mt_validate(struct maple_tree *mt);
 extern void mt_dump(const struct maple_tree *mt);
@@ -408,19 +320,25 @@ static void validate_mm_mt(struct mm_struct *mm)
 		    (vma->vm_end - 1 !=3D mas.last)) {
 			pr_emerg("issue in %s\n", current->comm);
 			dump_stack();
-#ifdef CONFIG_DEBUG_VM
 			dump_vma(vma_mt);
-			pr_emerg("and next in rb\n");
+			pr_emerg("and vm_next\n");
 			dump_vma(vma->vm_next);
-#endif
 			pr_emerg("mt piv: %p %lu - %lu\n", vma_mt,
 				 mas.index, mas.last);
 			pr_emerg("mt vma: %p %lu - %lu\n", vma_mt,
 				 vma_mt->vm_start, vma_mt->vm_end);
-			pr_emerg("rb vma: %p %lu - %lu\n", vma,
+			if (vma->vm_prev) {
+				pr_emerg("ll prev: %p %lu - %lu\n",
+					 vma->vm_prev, vma->vm_prev->vm_start,
+					 vma->vm_prev->vm_end);
+			}
+			pr_emerg("ll vma: %p %lu - %lu\n", vma,
 				 vma->vm_start, vma->vm_end);
-			pr_emerg("rb->next =3D %p %lu - %lu\n", vma->vm_next,
-					vma->vm_next->vm_start, vma->vm_next->vm_end);
+			if (vma->vm_next) {
+				pr_emerg("ll next: %p %lu - %lu\n",
+					 vma->vm_next, vma->vm_next->vm_start,
+					 vma->vm_next->vm_end);
+			}
=20
 			mt_dump(mas.tree);
 			if (vma_mt->vm_end !=3D mas.last + 1) {
@@ -443,21 +361,6 @@ static void validate_mm_mt(struct mm_struct *mm)
 	}
 	VM_BUG_ON(vma);
 }
-#else
-#define validate_mm_mt(root) do { } while (0)
-#endif
-static void validate_mm_rb(struct rb_root *root, struct vm_area_struct *ig=
nore)
-{
-	struct rb_node *nd;
-
-	for (nd =3D rb_first(root); nd; nd =3D rb_next(nd)) {
-		struct vm_area_struct *vma;
-		vma =3D rb_entry(nd, struct vm_area_struct, vm_rb);
-		VM_BUG_ON_VMA(vma !=3D ignore &&
-			vma->rb_subtree_gap !=3D vma_compute_subtree_gap(vma),
-			vma);
-	}
-}
=20
 static void validate_mm(struct mm_struct *mm)
 {
@@ -466,7 +369,10 @@ static void validate_mm(struct mm_struct *mm)
 	unsigned long highest_address =3D 0;
 	struct vm_area_struct *vma =3D mm->mmap;
=20
+	validate_mm_mt(mm);
+
 	while (vma) {
+#ifdef CONFIG_DEBUG_VM_RB
 		struct anon_vma *anon_vma =3D vma->anon_vma;
 		struct anon_vma_chain *avc;
=20
@@ -476,6 +382,7 @@ static void validate_mm(struct mm_struct *mm)
 				anon_vma_interval_tree_verify(avc);
 			anon_vma_unlock_read(anon_vma);
 		}
+#endif
=20
 		highest_address =3D vm_end_gap(vma);
 		vma =3D vma->vm_next;
@@ -490,80 +397,13 @@ static void validate_mm(struct mm_struct *mm)
 			  mm->highest_vm_end, highest_address);
 		bug =3D 1;
 	}
-	i =3D browse_rb(mm);
-	if (i !=3D mm->map_count) {
-		if (i !=3D -1)
-			pr_emerg("map_count %d rb %d\n", mm->map_count, i);
-		bug =3D 1;
-	}
 	VM_BUG_ON_MM(bug, mm);
 }
-#else
-#define validate_mm_rb(root, ignore) do { } while (0)
+
+#else /* !CONFIG_DEBUG_VM_MAPLE_TREE */
 #define validate_mm_mt(root) do { } while (0)
 #define validate_mm(mm) do { } while (0)
-#endif
-
-RB_DECLARE_CALLBACKS_MAX(static, vma_gap_callbacks,
-			 struct vm_area_struct, vm_rb,
-			 unsigned long, rb_subtree_gap, vma_compute_gap)
-
-/*
- * Update augmented rbtree rb_subtree_gap values after vma->vm_start or
- * vma->vm_prev->vm_end values changed, without modifying the vma's positi=
on
- * in the rbtree.
- */
-static void vma_gap_update(struct vm_area_struct *vma)
-{
-	/*
-	 * As it turns out, RB_DECLARE_CALLBACKS_MAX() already created
-	 * a callback function that does exactly what we want.
-	 */
-	vma_gap_callbacks_propagate(&vma->vm_rb, NULL);
-}
-
-static inline void vma_rb_insert(struct vm_area_struct *vma,
-				 struct rb_root *root)
-{
-	/* All rb_subtree_gap values must be consistent prior to insertion */
-	validate_mm_rb(root, NULL);
-
-	rb_insert_augmented(&vma->vm_rb, root, &vma_gap_callbacks);
-}
-
-static void __vma_rb_erase(struct vm_area_struct *vma, struct rb_root *roo=
t)
-{
-	/*
-	 * Note rb_erase_augmented is a fairly large inline function,
-	 * so make sure we instantiate it only once with our desired
-	 * augmented rbtree callbacks.
-	 */
-	rb_erase_augmented(&vma->vm_rb, root, &vma_gap_callbacks);
-}
-
-static __always_inline void vma_rb_erase_ignore(struct vm_area_struct *vma=
,
-						struct rb_root *root,
-						struct vm_area_struct *ignore)
-{
-	/*
-	 * All rb_subtree_gap values must be consistent prior to erase,
-	 * with the possible exception of
-	 *
-	 * a. the "next" vma being erased if next->vm_start was reduced in
-	 *    __vma_adjust() -> __vma_unlink()
-	 * b. the vma being erased in detach_vmas_to_be_unmapped() ->
-	 *    vma_rb_erase()
-	 */
-	validate_mm_rb(root, ignore);
-
-	__vma_rb_erase(vma, root);
-}
-
-static __always_inline void vma_rb_erase(struct vm_area_struct *vma,
-					 struct rb_root *root)
-{
-	vma_rb_erase_ignore(vma, root, vma);
-}
+#endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
=20
 /*
  * vma has some anon_vma assigned, and is already inserted on that
@@ -597,39 +437,26 @@ anon_vma_interval_tree_post_update_vma(struct vm_area=
_struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
=20
-static int find_vma_links(struct mm_struct *mm, unsigned long addr,
-		unsigned long end, struct vm_area_struct **pprev,
-		struct rb_node ***rb_link, struct rb_node **rb_parent)
+/*
+ * range_has_overlap() - Check the @start - @end range for overlapping VMA=
s and
+ * sets up a pointer to the previous VMA
+ * @mm: the mm struct
+ * @start: the start address of the range
+ * @end: the end address of the range
+ * @pprev: the pointer to the pointer of the previous VMA
+ *
+ * Returns: True if there is an overlapping VMA, false otherwise
+ */
+static inline
+bool range_has_overlap(struct mm_struct *mm, unsigned long start,
+		       unsigned long end, struct vm_area_struct **pprev)
 {
-	struct rb_node **__rb_link, *__rb_parent, *rb_prev;
-
-	mmap_assert_locked(mm);
-	__rb_link =3D &mm->mm_rb.rb_node;
-	rb_prev =3D __rb_parent =3D NULL;
-
-	while (*__rb_link) {
-		struct vm_area_struct *vma_tmp;
-
-		__rb_parent =3D *__rb_link;
-		vma_tmp =3D rb_entry(__rb_parent, struct vm_area_struct, vm_rb);
+	struct vm_area_struct *existing;
=20
-		if (vma_tmp->vm_end > addr) {
-			/* Fail if an existing vma overlaps the area */
-			if (vma_tmp->vm_start < end)
-				return -ENOMEM;
-			__rb_link =3D &__rb_parent->rb_left;
-		} else {
-			rb_prev =3D __rb_parent;
-			__rb_link =3D &__rb_parent->rb_right;
-		}
-	}
-
-	*pprev =3D NULL;
-	if (rb_prev)
-		*pprev =3D rb_entry(rb_prev, struct vm_area_struct, vm_rb);
-	*rb_link =3D __rb_link;
-	*rb_parent =3D __rb_parent;
-	return 0;
+	MA_STATE(mas, &mm->mm_mt, start, start);
+	existing =3D mas_find(&mas, end - 1);
+	*pprev =3D mas_prev(&mas, 0);
+	return existing ? true : false;
 }
=20
 /*
@@ -656,8 +483,6 @@ static inline struct vm_area_struct *__vma_next(struct =
mm_struct *mm,
  * @start: The start of the range.
  * @len: The length of the range.
  * @pprev: pointer to the pointer that will be set to previous vm_area_str=
uct
- * @rb_link: the rb_node
- * @rb_parent: the parent rb_node
  *
  * Find all the vm_area_struct that overlap from @start to
  * @end and munmap them.  Set @pprev to the previous vm_area_struct.
@@ -666,14 +491,11 @@ static inline struct vm_area_struct *__vma_next(struc=
t mm_struct *mm,
  */
 static inline int
 munmap_vma_range(struct mm_struct *mm, unsigned long start, unsigned long =
len,
-		 struct vm_area_struct **pprev, struct rb_node ***link,
-		 struct rb_node **parent, struct list_head *uf)
+		 struct vm_area_struct **pprev, struct list_head *uf)
 {
-
-	while (find_vma_links(mm, start, start + len, pprev, link, parent))
+	while (range_has_overlap(mm, start, start + len, pprev))
 		if (do_munmap(mm, start, len, uf))
 			return -ENOMEM;
-
 	return 0;
 }
=20
@@ -694,30 +516,6 @@ static unsigned long count_vma_pages_range(struct mm_s=
truct *mm,
 	return nr_pages;
 }
=20
-void __vma_link_rb(struct mm_struct *mm, struct vm_area_struct *vma,
-		struct rb_node **rb_link, struct rb_node *rb_parent)
-{
-	/* Update tracking information for the gap following the new vma. */
-	if (vma->vm_next)
-		vma_gap_update(vma->vm_next);
-	else
-		mm->highest_vm_end =3D vm_end_gap(vma);
-
-	/*
-	 * vma->vm_prev wasn't known when we followed the rbtree to find the
-	 * correct insertion point for that vma. As a result, we could not
-	 * update the vma vm_rb parents rb_subtree_gap values on the way down.
-	 * So, we first insert the vma with a zero rb_subtree_gap value
-	 * (to be consistent with what we did on the way down), and then
-	 * immediately update the gap to the correct value. Finally we
-	 * rebalance the rbtree after all augmented values have been set.
-	 */
-	rb_link_node(&vma->vm_rb, rb_parent, rb_link);
-	vma->rb_subtree_gap =3D 0;
-	vma_gap_update(vma);
-	vma_rb_insert(vma, &mm->mm_rb);
-}
-
 static void __vma_link_file(struct vm_area_struct *vma)
 {
 	struct file *file;
@@ -785,18 +583,8 @@ static inline void vma_mas_szero(struct ma_state *mas,=
 unsigned long start,
 	mas_store_prealloc(mas, NULL);
 }
=20
-static void
-__vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
-	struct vm_area_struct *prev, struct rb_node **rb_link,
-	struct rb_node *rb_parent)
-{
-	__vma_link_list(mm, vma, prev);
-	__vma_link_rb(mm, vma, rb_link, rb_parent);
-}
-
 static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct vm_area_struct *prev, struct rb_node **rb_link,
-			struct rb_node *rb_parent)
+			struct vm_area_struct *prev)
 {
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct address_space *mapping =3D NULL;
@@ -810,7 +598,7 @@ static int vma_link(struct mm_struct *mm, struct vm_are=
a_struct *vma,
 	}
=20
 	vma_mas_store(vma, &mas);
-	__vma_link(mm, vma, prev, rb_link, rb_parent);
+	__vma_link_list(mm, vma, prev);
 	__vma_link_file(vma);
=20
 	if (mapping)
@@ -823,34 +611,20 @@ static int vma_link(struct mm_struct *mm, struct vm_a=
rea_struct *vma,
=20
 /*
  * Helper for vma_adjust() in the split_vma insert case: insert a vma into=
 the
- * mm's list and rbtree.  It has already been inserted into the interval t=
ree.
+ * mm's list and the mm tree.  It has already been inserted into the inter=
val tree.
  */
 static void __insert_vm_struct(struct mm_struct *mm, struct ma_state *mas,
 			       struct vm_area_struct *vma)
 {
 	struct vm_area_struct *prev;
-	struct rb_node **rb_link, *rb_parent;
-
-	if (find_vma_links(mm, vma->vm_start, vma->vm_end,
-			   &prev, &rb_link, &rb_parent))
-		BUG();
=20
+	mas_set(mas, vma->vm_start);
+	prev =3D mas_prev(mas, 0);
 	vma_mas_store(vma, mas);
 	__vma_link_list(mm, vma, prev);
-	__vma_link_rb(mm, vma, rb_link, rb_parent);
 	mm->map_count++;
 }
=20
-static __always_inline void __vma_unlink(struct mm_struct *mm,
-						struct vm_area_struct *vma,
-						struct vm_area_struct *ignore)
-{
-	vma_rb_erase_ignore(vma, &mm->mm_rb, ignore);
-	__vma_unlink_list(mm, vma);
-	/* Kill the cache */
-	vmacache_invalidate(mm);
-}
-
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -863,21 +637,18 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	struct vm_area_struct *expand)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
-	struct vm_area_struct *next =3D vma->vm_next, *orig_vma =3D vma;
-	struct vm_area_struct *next_next;
+	struct vm_area_struct *next_next, *next =3D find_vma(mm, vma->vm_end);
+	struct vm_area_struct *orig_vma =3D vma;
 	struct address_space *mapping =3D NULL;
 	struct rb_root_cached *root =3D NULL;
 	struct anon_vma *anon_vma =3D NULL;
 	struct file *file =3D vma->vm_file;
-	bool start_changed =3D false, end_changed =3D false;
+	bool vma_changed =3D false;
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
=20
-	validate_mm(mm);
-	validate_mm_mt(mm);
-
 	if (next && !insert) {
 		if (end >=3D next->vm_end) {
 			/*
@@ -1007,21 +778,21 @@ int __vma_adjust(struct vm_area_struct *vma, unsigne=
d long start,
 	}
=20
 	if (start !=3D vma->vm_start) {
-		unsigned long old_start =3D vma->vm_start;
+		if (vma->vm_start < start)
+			vma_mas_szero(&mas, vma->vm_start, start);
+		vma_changed =3D true;
 		vma->vm_start =3D start;
-		if (old_start < start)
-			vma_mas_szero(&mas, old_start, start);
-		start_changed =3D true;
 	}
 	if (end !=3D vma->vm_end) {
-		unsigned long old_end =3D vma->vm_end;
+		if (vma->vm_end > end)
+			vma_mas_szero(&mas, end, vma->vm_end);
+		vma_changed =3D true;
 		vma->vm_end =3D end;
-		if (old_end > end)
-			vma_mas_szero(&mas, end, old_end);
-		end_changed =3D true;
+		if (!next)
+			mm->highest_vm_end =3D vm_end_gap(vma);
 	}
=20
-	if (end_changed || start_changed)
+	if (vma_changed)
 		vma_mas_store(vma, &mas);
=20
 	vma->vm_pgoff =3D pgoff;
@@ -1045,22 +816,12 @@ int __vma_adjust(struct vm_area_struct *vma, unsigne=
d long start,
 		 * Since we have expanded over this vma, the maple tree will
 		 * have overwritten by storing the value
 		 */
-		if (remove_next !=3D 3) {
-			__vma_unlink(mm, next, next);
-			if (remove_next =3D=3D 2)
-				__vma_unlink(mm, next_next, next_next);
-		} else {
-			/*
-			 * vma is not before next if they've been
-			 * swapped.
-			 *
-			 * pre-swap() next->vm_start was reduced so
-			 * tell validate_mm_rb to ignore pre-swap()
-			 * "next" (which is stored in post-swap()
-			 * "vma").
-			 */
-			__vma_unlink(mm, next, vma);
-		}
+		__vma_unlink_list(mm, next);
+		if (remove_next =3D=3D 2)
+			__vma_unlink_list(mm, next_next);
+		/* Kill the cache */
+		vmacache_invalidate(mm);
+
 		if (file) {
 			__remove_shared_vm_struct(next, file, mapping);
 			if (remove_next =3D=3D 2)
@@ -1073,15 +834,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 		 * (it may either follow vma or precede it).
 		 */
 		__insert_vm_struct(mm, &mas, insert);
-	} else {
-		if (start_changed)
-			vma_gap_update(vma);
-		if (end_changed) {
-			if (!next)
-				mm->highest_vm_end =3D vm_end_gap(vma);
-			else if (!adjust_next)
-				vma_gap_update(next);
-		}
 	}
=20
 	if (anon_vma) {
@@ -1109,7 +861,10 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 			anon_vma_merge(vma, next);
 		mm->map_count--;
 		mpol_put(vma_policy(next));
+		if (remove_next !=3D 2)
+			BUG_ON(vma->vm_end < next->vm_end);
 		vm_area_free(next);
+
 		/*
 		 * In mprotect's case 6 (see comments on vma_merge),
 		 * we must remove another next too. It would clutter
@@ -1139,10 +894,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 		if (remove_next =3D=3D 2) {
 			remove_next =3D 1;
 			goto again;
-		}
-		else if (next)
-			vma_gap_update(next);
-		else {
+		} else if (!next) {
 			/*
 			 * If remove_next =3D=3D 2 we obviously can't
 			 * reach this path.
@@ -1169,8 +921,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 		uprobe_mmap(insert);
=20
 	validate_mm(mm);
-	validate_mm_mt(mm);
-
 	return 0;
 }
=20
@@ -1323,7 +1073,6 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	struct vm_area_struct *area, *next;
 	int err;
=20
-	validate_mm_mt(mm);
 	/*
 	 * We later require that vma->vm_flags =3D=3D vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
@@ -1399,7 +1148,6 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 		khugepaged_enter_vma(area, vm_flags);
 		return area;
 	}
-	validate_mm_mt(mm);
=20
 	return NULL;
 }
@@ -1569,6 +1317,7 @@ unsigned long do_mmap(struct file *file, unsigned lon=
g addr,
 	vm_flags_t vm_flags;
 	int pkey =3D 0;
=20
+	validate_mm(mm);
 	*populate =3D 0;
=20
 	if (!len)
@@ -1876,10 +1625,8 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma, *prev, *merge;
 	int error;
-	struct rb_node **rb_link, *rb_parent;
 	unsigned long charged =3D 0;
=20
-	validate_mm_mt(mm);
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
 		unsigned long nr_pages;
@@ -1895,8 +1642,8 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			return -ENOMEM;
 	}
=20
-	/* Clear old maps, set up prev, rb_link, rb_parent, and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, &rb_link, &rb_parent, uf))
+	/* Clear old maps, set up prev and uf */
+	if (munmap_vma_range(mm, addr, len, &prev, uf))
 		return -ENOMEM;
 	/*
 	 * Private writable mapping: check memory availability
@@ -1994,7 +1741,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			goto free_vma;
 	}
=20
-	if (vma_link(mm, vma, prev, rb_link, rb_parent)) {
+	if (vma_link(mm, vma, prev)) {
 		error =3D -ENOMEM;
 		if (file)
 			goto unmap_and_free_vma;
@@ -2040,7 +1787,6 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
=20
 	vma_set_page_prot(vma);
=20
-	validate_mm_mt(mm);
 	return addr;
=20
 unmap_and_free_vma:
@@ -2057,7 +1803,6 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
-	validate_mm_mt(mm);
 	return error;
 }
=20
@@ -2416,7 +2161,6 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	int error =3D 0;
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	validate_mm_mt(mm);
 	if (!(vma->vm_flags & VM_GROWSUP))
 		return -EFAULT;
=20
@@ -2468,15 +2212,13 @@ int expand_upwards(struct vm_area_struct *vma, unsi=
gned long address)
 			error =3D acct_stack_growth(vma, size, grow);
 			if (!error) {
 				/*
-				 * vma_gap_update() doesn't support concurrent
-				 * updates, but we only hold a shared mmap_lock
-				 * lock here, so we need to protect against
-				 * concurrent vma expansions.
-				 * anon_vma_lock_write() doesn't help here, as
-				 * we don't guarantee that all growable vmas
-				 * in a mm share the same root anon vma.
-				 * So, we reuse mm->page_table_lock to guard
-				 * against concurrent vma expansions.
+				 * We only hold a shared mmap_lock lock here, so
+				 * we need to protect against concurrent vma
+				 * expansions.  anon_vma_lock_write() doesn't
+				 * help here, as we don't guarantee that all
+				 * growable vmas in a mm share the same root
+				 * anon vma.  So, we reuse mm->page_table_lock
+				 * to guard against concurrent vma expansions.
 				 */
 				spin_lock(&mm->page_table_lock);
 				if (vma->vm_flags & VM_LOCKED)
@@ -2487,9 +2229,7 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 				/* Overwrite old entry in mtree. */
 				vma_mas_store(vma, &mas);
 				anon_vma_interval_tree_post_update_vma(vma);
-				if (vma->vm_next)
-					vma_gap_update(vma->vm_next);
-				else
+				if (!vma->vm_next)
 					mm->highest_vm_end =3D vm_end_gap(vma);
 				spin_unlock(&mm->page_table_lock);
=20
@@ -2499,8 +2239,6 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	}
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma(vma, vma->vm_flags);
-	validate_mm(mm);
-	validate_mm_mt(mm);
 	mas_destroy(&mas);
 	return error;
 }
@@ -2509,15 +2247,13 @@ int expand_upwards(struct vm_area_struct *vma, unsi=
gned long address)
 /*
  * vma is the first one with address < vma->vm_start.  Have to extend vma.
  */
-int expand_downwards(struct vm_area_struct *vma,
-				   unsigned long address)
+int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct *prev;
 	int error =3D 0;
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	validate_mm(mm);
 	address &=3D PAGE_MASK;
 	if (address < mmap_min_addr)
 		return -EPERM;
@@ -2559,15 +2295,13 @@ int expand_downwards(struct vm_area_struct *vma,
 			error =3D acct_stack_growth(vma, size, grow);
 			if (!error) {
 				/*
-				 * vma_gap_update() doesn't support concurrent
-				 * updates, but we only hold a shared mmap_lock
-				 * lock here, so we need to protect against
-				 * concurrent vma expansions.
-				 * anon_vma_lock_write() doesn't help here, as
-				 * we don't guarantee that all growable vmas
-				 * in a mm share the same root anon vma.
-				 * So, we reuse mm->page_table_lock to guard
-				 * against concurrent vma expansions.
+				 * We only hold a shared mmap_lock lock here, so
+				 * we need to protect against concurrent vma
+				 * expansions.  anon_vma_lock_write() doesn't
+				 * help here, as we don't guarantee that all
+				 * growable vmas in a mm share the same root
+				 * anon vma.  So, we reuse mm->page_table_lock
+				 * to guard against concurrent vma expansions.
 				 */
 				spin_lock(&mm->page_table_lock);
 				if (vma->vm_flags & VM_LOCKED)
@@ -2579,7 +2313,6 @@ int expand_downwards(struct vm_area_struct *vma,
 				/* Overwrite old entry in mtree. */
 				vma_mas_store(vma, &mas);
 				anon_vma_interval_tree_post_update_vma(vma);
-				vma_gap_update(vma);
 				spin_unlock(&mm->page_table_lock);
=20
 				perf_event_mmap(vma);
@@ -2588,7 +2321,6 @@ int expand_downwards(struct vm_area_struct *vma,
 	}
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma(vma, vma->vm_flags);
-	validate_mm(mm);
 	mas_destroy(&mas);
 	return error;
 }
@@ -2721,10 +2453,8 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, str=
uct ma_state *mas,
=20
 	insertion_point =3D (prev ? &prev->vm_next : &mm->mmap);
 	vma->vm_prev =3D NULL;
-	mas_set_range(mas, vma->vm_start, end - 1);
-	mas_store_prealloc(mas, NULL);
+	vma_mas_szero(mas, vma->vm_start, end);
 	do {
-		vma_rb_erase(vma, &mm->mm_rb);
 		if (vma->vm_flags & VM_LOCKED)
 			mm->locked_vm -=3D vma_pages(vma);
 		mm->map_count--;
@@ -2732,10 +2462,9 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, str=
uct ma_state *mas,
 		vma =3D vma->vm_next;
 	} while (vma && vma->vm_start < end);
 	*insertion_point =3D vma;
-	if (vma) {
+	if (vma)
 		vma->vm_prev =3D prev;
-		vma_gap_update(vma);
-	} else
+	else
 		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
 	tail_vma->vm_next =3D NULL;
=20
@@ -2854,11 +2583,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long =
start, size_t len,
 	if (len =3D=3D 0)
 		return -EINVAL;
=20
-	/*
-	 * arch_unmap() might do unmaps itself.  It must be called
-	 * and finish any rbtree manipulation before this code
-	 * runs and also starts to manipulate the rbtree.
-	 */
+	 /* arch_unmap() might do unmaps itself.  */
 	arch_unmap(mm, start, end);
=20
 	/* Find the first overlapping VMA where start < vma->vm_end */
@@ -2869,6 +2594,11 @@ int __do_munmap(struct mm_struct *mm, unsigned long =
start, size_t len,
 	if (mas_preallocate(&mas, vma, GFP_KERNEL))
 		return -ENOMEM;
 	prev =3D vma->vm_prev;
+	/* we have start < vma->vm_end  */
+
+	/* if it doesn't overlap, we have nothing.. */
+	if (vma->vm_start >=3D end)
+		return 0;
=20
 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -2929,6 +2659,8 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 	/* Fix up all other VM information */
 	remove_vma_list(mm, vma);
=20
+
+	validate_mm(mm);
 	return downgrade ? 1 : 0;
=20
 map_count_exceeded:
@@ -3067,11 +2799,11 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, st=
art, unsigned long, size,
  *  anonymous maps.  eventually we may be able to do some
  *  brk-specific accounting here.
  */
-static int do_brk_flags(unsigned long addr, unsigned long len, unsigned lo=
ng flags, struct list_head *uf)
+static int do_brk_flags(unsigned long addr, unsigned long len,
+			unsigned long flags, struct list_head *uf)
 {
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma, *prev;
-	struct rb_node **rb_link, *rb_parent;
 	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
 	int error;
 	unsigned long mapped_addr;
@@ -3090,8 +2822,8 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	if (error)
 		return error;
=20
-	/* Clear old maps, set up prev, rb_link, rb_parent, and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, &rb_link, &rb_parent, uf))
+	/* Clear old maps, set up prev and uf */
+	if (munmap_vma_range(mm, addr, len, &prev, uf))
 		return -ENOMEM;
=20
 	/* Check against address space limits *after* clearing old maps... */
@@ -3125,7 +2857,7 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	vma->vm_pgoff =3D pgoff;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	if (vma_link(mm, vma, prev, rb_link, rb_parent))
+	if (vma_link(mm, vma, prev))
 		goto no_vma_link;
=20
 out:
@@ -3244,26 +2976,10 @@ void exit_mmap(struct mm_struct *mm)
 int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	struct vm_area_struct *prev;
-	struct rb_node **rb_link, *rb_parent;
-	unsigned long start =3D vma->vm_start;
-	struct vm_area_struct *overlap =3D NULL;
=20
-	if (find_vma_links(mm, vma->vm_start, vma->vm_end,
-			   &prev, &rb_link, &rb_parent))
+	if (range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev))
 		return -ENOMEM;
=20
-	overlap =3D mt_find(&mm->mm_mt, &start, vma->vm_end - 1);
-	if (overlap) {
-
-		pr_err("Found vma ending at %lu\n", start - 1);
-		pr_err("vma : %lu =3D> %lu-%lu\n", (unsigned long)overlap,
-				overlap->vm_start, overlap->vm_end - 1);
-#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-		mt_dump(&mm->mm_mt);
-#endif
-		BUG();
-	}
-
 	if ((vma->vm_flags & VM_ACCOUNT) &&
 	     security_vm_enough_memory_mm(mm, vma_pages(vma)))
 		return -ENOMEM;
@@ -3285,7 +3001,7 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_=
area_struct *vma)
 		vma->vm_pgoff =3D vma->vm_start >> PAGE_SHIFT;
 	}
=20
-	if (vma_link(mm, vma, prev, rb_link, rb_parent))
+	if (vma_link(mm, vma, prev))
 		return -ENOMEM;
=20
 	return 0;
@@ -3303,9 +3019,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	unsigned long vma_start =3D vma->vm_start;
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct *new_vma, *prev;
-	struct rb_node **rb_link, *rb_parent;
 	bool faulted_in_anon_vma =3D true;
-	unsigned long index =3D addr;
=20
 	validate_mm_mt(mm);
 	/*
@@ -3317,10 +3031,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struc=
t **vmap,
 		faulted_in_anon_vma =3D false;
 	}
=20
-	if (find_vma_links(mm, addr, addr + len, &prev, &rb_link, &rb_parent))
+	if (range_has_overlap(mm, addr, addr + len, &prev))
 		return NULL;	/* should never get here */
-	if (mt_find(&mm->mm_mt, &index, addr+len - 1))
-		BUG();
+
 	new_vma =3D vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
@@ -3361,12 +3074,16 @@ struct vm_area_struct *copy_vma(struct vm_area_stru=
ct **vmap,
 			get_file(new_vma->vm_file);
 		if (new_vma->vm_ops && new_vma->vm_ops->open)
 			new_vma->vm_ops->open(new_vma);
-		vma_link(mm, new_vma, prev, rb_link, rb_parent);
+		if (vma_link(mm, new_vma, prev))
+			goto out_vma_link;
 		*need_rmap_locks =3D false;
 	}
 	validate_mm_mt(mm);
 	return new_vma;
=20
+out_vma_link:
+	if (new_vma->vm_ops && new_vma->vm_ops->close)
+		new_vma->vm_ops->close(new_vma);
 out_free_mempol:
 	mpol_put(vma_policy(new_vma));
 out_free_vma:
diff --git a/mm/nommu.c b/mm/nommu.c
index 5af0b050eba8..f2031f865dbb 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -566,9 +566,9 @@ void vma_mas_remove(struct vm_area_struct *vma, struct =
ma_state *mas)
  */
 static void add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma=
)
 {
-	struct vm_area_struct *pvma, *prev;
 	struct address_space *mapping;
-	struct rb_node **p, *parent, *rb_prev;
+	struct vm_area_struct *prev;
+	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
=20
 	BUG_ON(!vma->vm_region);
=20
@@ -586,42 +586,10 @@ static void add_vma_to_mm(struct mm_struct *mm, struc=
t vm_area_struct *vma)
 		i_mmap_unlock_write(mapping);
 	}
=20
+	prev =3D mas_prev(&mas, 0);
+	mas_reset(&mas);
 	/* add the VMA to the tree */
-	parent =3D rb_prev =3D NULL;
-	p =3D &mm->mm_rb.rb_node;
-	while (*p) {
-		parent =3D *p;
-		pvma =3D rb_entry(parent, struct vm_area_struct, vm_rb);
-
-		/* sort by: start addr, end addr, VMA struct addr in that order
-		 * (the latter is necessary as we may get identical VMAs) */
-		if (vma->vm_start < pvma->vm_start)
-			p =3D &(*p)->rb_left;
-		else if (vma->vm_start > pvma->vm_start) {
-			rb_prev =3D parent;
-			p =3D &(*p)->rb_right;
-		} else if (vma->vm_end < pvma->vm_end)
-			p =3D &(*p)->rb_left;
-		else if (vma->vm_end > pvma->vm_end) {
-			rb_prev =3D parent;
-			p =3D &(*p)->rb_right;
-		} else if (vma < pvma)
-			p =3D &(*p)->rb_left;
-		else if (vma > pvma) {
-			rb_prev =3D parent;
-			p =3D &(*p)->rb_right;
-		} else
-			BUG();
-	}
-
-	rb_link_node(&vma->vm_rb, parent, p);
-	rb_insert_color(&vma->vm_rb, &mm->mm_rb);
-
-	/* add VMA to the VMA list also */
-	prev =3D NULL;
-	if (rb_prev)
-		prev =3D rb_entry(rb_prev, struct vm_area_struct, vm_rb);
-
+	vma_mas_store(vma, &mas);
 	__vma_link_list(mm, vma, prev);
 }
=20
@@ -634,6 +602,7 @@ static void delete_vma_from_mm(struct vm_area_struct *v=
ma)
 	struct address_space *mapping;
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct task_struct *curr =3D current;
+	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
=20
 	mm->map_count--;
 	for (i =3D 0; i < VMACACHE_SIZE; i++) {
@@ -656,8 +625,7 @@ static void delete_vma_from_mm(struct vm_area_struct *v=
ma)
 	}
=20
 	/* remove from the MM's tree and list */
-	rb_erase(&vma->vm_rb, &mm->mm_rb);
-
+	vma_mas_remove(vma, &mas);
 	__vma_unlink_list(mm, vma);
 }
=20
@@ -681,24 +649,19 @@ static void delete_vma(struct mm_struct *mm, struct v=
m_area_struct *vma)
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	/* check the cache first */
 	vma =3D vmacache_find(mm, addr);
 	if (likely(vma))
 		return vma;
=20
-	/* trawl the list (there may be multiple mappings in which addr
-	 * resides) */
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
-		if (vma->vm_start > addr)
-			return NULL;
-		if (vma->vm_end > addr) {
-			vmacache_update(addr, vma);
-			return vma;
-		}
-	}
+	vma =3D mas_walk(&mas);
=20
-	return NULL;
+	if (vma)
+		vmacache_update(addr, vma);
+
+	return vma;
 }
 EXPORT_SYMBOL(find_vma);
=20
@@ -730,26 +693,23 @@ static struct vm_area_struct *find_vma_exact(struct m=
m_struct *mm,
 {
 	struct vm_area_struct *vma;
 	unsigned long end =3D addr + len;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	/* check the cache first */
 	vma =3D vmacache_find_exact(mm, addr, end);
 	if (vma)
 		return vma;
=20
-	/* trawl the list (there may be multiple mappings in which addr
-	 * resides) */
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
-		if (vma->vm_start < addr)
-			continue;
-		if (vma->vm_start > addr)
-			return NULL;
-		if (vma->vm_end =3D=3D end) {
-			vmacache_update(addr, vma);
-			return vma;
-		}
-	}
+	vma =3D mas_walk(&mas);
+	if (!vma)
+		return NULL;
+	if (vma->vm_start !=3D addr)
+		return NULL;
+	if (vma->vm_end !=3D end)
+		return NULL;
=20
-	return NULL;
+	vmacache_update(addr, vma);
+	return vma;
 }
=20
 /*
@@ -1546,6 +1506,7 @@ void exit_mmap(struct mm_struct *mm)
 		delete_vma(mm, vma);
 		cond_resched();
 	}
+	__mt_destroy(&mm->mm_mt);
 }
=20
 int vm_brk(unsigned long addr, unsigned long len)
diff --git a/mm/util.c b/mm/util.c
index 0837570c9225..2ffc32294a97 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -288,6 +288,8 @@ void __vma_link_list(struct mm_struct *mm, struct vm_ar=
ea_struct *vma,
 	vma->vm_next =3D next;
 	if (next)
 		next->vm_prev =3D vma;
+	else
+		mm->highest_vm_end =3D vm_end_gap(vma);
 }
=20
 void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma)
@@ -300,8 +302,14 @@ void __vma_unlink_list(struct mm_struct *mm, struct vm=
_area_struct *vma)
 		prev->vm_next =3D next;
 	else
 		mm->mmap =3D next;
-	if (next)
+	if (next) {
 		next->vm_prev =3D prev;
+	} else {
+		if (prev)
+			mm->highest_vm_end =3D vm_end_gap(prev);
+		else
+			mm->highest_vm_end =3D 0;
+	}
 }
=20
 /* Check if the vma is being used as a stack by this task */
--=20
2.35.1
