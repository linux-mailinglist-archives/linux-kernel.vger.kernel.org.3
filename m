Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBDD59FDFB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239319AbiHXPM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238039AbiHXPMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:12:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581DA94ECB
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:12:55 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OF9Upx019278;
        Wed, 24 Aug 2022 15:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+rCBXlE2eJPtNFiByAojb+nVkMIi1BdWNzyL7YYx3oo=;
 b=Amo78HK9jQC+fNJUBj1jjooU5Rdgugbpevq4CpiTrHfbF76hz6plTItjGy4XrgcHfCWl
 yUPsSh5d0yjdRx4PRlcJNvJ9tGk5sem94LFsfAKlzh/sVn0uCuWLu241kGWQMHufqQnD
 2C6oCXHxyRqEGCUqjpdYPy8NVBBszbksouUVZIV49tr0q8ozbZx6C5zGkFtltrBvEp2a
 sTVecYXXrdVJOQax6ZDZ5dMj1OGsTQqz95hhHk2D9j+0A+ZX1R2akUQYjqsRBSyo+SQp
 3ynko2kB5UUIwXa8BtXMqUrdWFFm19nLlrIz7/34WrRAsXVzI8F3A0+UWSn0v/xbjV3K lA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w23uv07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 15:12:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27OEp40d008184;
        Wed, 24 Aug 2022 15:12:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n7abv6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 15:12:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gl+baWVn0Sj8X0mBnHfqrCTqTVoB7AOMkP58e0gcBgGMnyiE6y+zVgmsOsbvJuOXtcvz8dsNisMjNqtOkBHWP14zXa7JpNqnxZvIse+zYl8slf6kfbWWuJ1mz5lmvEuaDuye2xAyDnuARXuS47XIFIOGp03MqLc7cZmIM0V5qywZaaZ3KLfftq9dgyrG9UXPjvy+Flzm0U+uV1jAU2J/g32Y999pc0IERIN8DgTk2B/gjoDYT7eVh17C3XzcuveiMwZhiLjXlwkMiB03RNVPjBJ/CN3//dPu7XiDGjRE5BooMUSIPfGikcESDdWhpvQ+IlXmHdNuQyqNB76btX/6vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rCBXlE2eJPtNFiByAojb+nVkMIi1BdWNzyL7YYx3oo=;
 b=g0k9SRT1H0Rtfq5c2RUiKxfRkZLuXMFYcax2xJeTofJ5XmnKunUvA6sBUHEdMbAE6iX4nb17WHHYLXqlFeL+mdtsA0Am3hfqbUhuNrl0wlj0YCWZhzJJTZKYMjnNb38PD3wYAMJDTTBX2rA9cBdSZF68EiZwAV6BAS5VE71CEVXNhv3GqXX6hB/hEbsD8xsyBCxjjU0rYR+6or0kak3BIQZaHr8lVMEJMytNZRZ3YKqW4bH+I/MnKT4I+iREeMFW28IC+RKynJqWxeD6d0LJdDGKVZ8MQZkvrUmHdjy3vfTZMvsewm4gvSlbMqIefKyWOQ7IHeEfTW1izee2IGtejA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rCBXlE2eJPtNFiByAojb+nVkMIi1BdWNzyL7YYx3oo=;
 b=Vg5tkbDWOucXeMRP/F1KsfLTHhMqwfHcidg9ODdTlXDOxTmL/N7Z9DhUJ5QzHw8OOiHHemin0GKeuVBD0JTlfb05vvqGF5MsuSXFAQZVG5jluN/3DadsX7otL4yZrQbM3gUtf7g3vvcCV0ecnFp/nJIT5Pb+n8GrNOFZH3gQpgc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1530.namprd10.prod.outlook.com (2603:10b6:3:14::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Wed, 24 Aug
 2022 15:12:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Wed, 24 Aug 2022
 15:12:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH] fs/proc/base: use maple tree iterators in place of linked
 list
Thread-Topic: [PATCH] fs/proc/base: use maple tree iterators in place of
 linked list
Thread-Index: AQHYt8v0Vq3Ph7IqdUqrxirJlcBD3g==
Date:   Wed, 24 Aug 2022 15:12:42 +0000
Message-ID: <20220824151129.2023451-1-Liam.Howlett@oracle.com>
References: <20220824012121.aj2qkzrmdyywu45t@offworld>
In-Reply-To: <20220824012121.aj2qkzrmdyywu45t@offworld>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e06a02a-f36d-4d36-78b5-08da85e3175c
x-ms-traffictypediagnostic: DM5PR10MB1530:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wC8g/DIZf3Q7HnzPYM+qTzaS3mDjP7Ru3KyYSoxGlIw/9rUk89cI+tsrVRh9s4El0iOsj5v75h8zHJb36PFMx2JUEg7CpkbDU/ptPuqyxapKBeFGaRK1FXMdO6UVPKJp59qnseytbxQf2YTCodm7pZ8SCwO6uoxtCKX+OPhM45t+TKNKOURJLUrLrNC8zzQM+184FwsDL/jHau0QeslN+UuN5jBMCfn1s9yCQ594/4F7WliReLRB/3LEYptLJynhMrY7RZa53kr4ygMI6OVFvLnj3s1lm93Zgpj80ydZ2RgsIblAyEuKmEWe13fXfGMV9PEtNRraV5VDEqxZStwO0sY8eb0POjOclOx4wg/UnOj7VlJ4I/bQFSyuzxjId9w46raire8Rv05ZfK2ZCQiqRLdzN8/rnBCVYt3XMsZ1vTMbBCl9Sh93TixqckZ7TK0pldE/cbRz7ohqXiRGHLDiTAWh4N+5ImJQMQPtuZc/YkY++yCM5AbyS9+r5pDmMgvuhI5GdF5V7H4s7EXkK1mQr2lvAZLhTBQTAWGrgAjFKBnVOjw03mm/yJuTZX62Kaa4fb3u9hjPpIFCqBP43gu+kpowe0JFd9iK7667//ehm2ni9sFQaSLDGD20lgFY7ofrFkicKiRMLnaHa6k57MPFZwxIQ6lTpinnpNjtIxsaRwcZVw3IzKwETh1Qux0pRL82N4yUgxPS8BYGIZXyRXw574GmEmq3+3F5mRCOCNIyjqPH8cpo7YJpQHegIqwNu1o3XnvqaNKGvPloS1W6MNELng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(366004)(346002)(136003)(376002)(2906002)(107886003)(83380400001)(1076003)(2616005)(186003)(122000001)(38100700002)(38070700005)(26005)(316002)(66556008)(110136005)(76116006)(91956017)(64756008)(66946007)(8936002)(5660300002)(66476007)(8676002)(66446008)(6512007)(41300700001)(36756003)(86362001)(6506007)(478600001)(71200400001)(6486002)(44832011)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3om9B7XF+i3bvijKJOPEgbWORAXjiZXcrQL4MVrhYjW5DN2Sl7/SOTSzex?=
 =?iso-8859-1?Q?ooZ6VrP42AWwVK/BKllP63RJtBe4x32x/y7LBIAdlWdDfPc6kAXPcYGQwQ?=
 =?iso-8859-1?Q?+Nd5HNIe7KLx4Ui841+AupdZprZQ9mjlSCC/qvtfES3YFRF8oVjxBXn+K0?=
 =?iso-8859-1?Q?Fbk2g6nYtB24ZjpWCRrVpeBXW2uI944wkhB9UZ25oOqj3PG9DXtFL86n9M?=
 =?iso-8859-1?Q?GhQnaeYzneepAdSu7kagyKlHC5D1TRDUv6yVZori2emoJgX0gyfRtdqGNq?=
 =?iso-8859-1?Q?aanqfoO9XfXPNfTdC1Y9yH8cwfOo5Frk3uH2mSUorD+ogN7/osnQ7fb7qU?=
 =?iso-8859-1?Q?g6TRGxMbrCfsmL+Bcu+h2EDu3gPW1KhH9IQx1vxMGIJMYLv+H14Ls2Vzbj?=
 =?iso-8859-1?Q?oK5MawW1WgaXup300G0VEnHeNnBnERAoY2G6XPIlbdkPNwED8rBcpy2ier?=
 =?iso-8859-1?Q?j1T7MlOmIDEsIm3Sc0XBw3SL+wO8gkffcPQs0O9gc1OPo5q2VN6DB4VIG9?=
 =?iso-8859-1?Q?QA0XVf+1gr6pQ0nyxS3ovkxMt38eRaxIunDxAiwco9MdHT7rLBVl0fYPxk?=
 =?iso-8859-1?Q?xNKiBaraHyVFRt1daI0rOHPUS3aJc/vNsywK2nykGrsK6iB0LCZGHUd37q?=
 =?iso-8859-1?Q?sXOwoIfcg95y1rurVD4YA/RpKUMgKDUk1Me3LzqO9RH8DrVai9bc7V0ONK?=
 =?iso-8859-1?Q?lxVm5Km3FvdKA9dlWEPBGf3iWUKDx9hLhPKv+17UVXYfgbb1pOUgprLTkD?=
 =?iso-8859-1?Q?jnKZZyz3vgYJNkDjKAQRUchh6hwsSWCdyROmFWjVMkWTV+jmxGF9cNEVfJ?=
 =?iso-8859-1?Q?PtJzaQbaaJlHUPMaVN6/WVzmlOKX3xr204kb2Hnzrg0fk/hnXbWW1ADkBR?=
 =?iso-8859-1?Q?g/4xV52aluehl0/yA9IyFPwzsLovjjUYjXfDHs64sIMJyN13DgD5PSUVVC?=
 =?iso-8859-1?Q?cx6kG24Sg9mKlhNOIebs4XzfM1QP42ohvqLzE6HuKX4KZmiwrSful7rizv?=
 =?iso-8859-1?Q?1+hMFwcq0f7L7h52ijdzj446dsFikz9EIDiHKVzWYkfVthslVAFoD9VPM4?=
 =?iso-8859-1?Q?VgQN8vzEhBYWIojF0rFanZeN9GfXLsj6cPugo014rJXdaO0drfBYmZFpFB?=
 =?iso-8859-1?Q?BAwBHnARo+7MaMekr+ZTYZaOCDt92uW9N6gnLZIO444k/X2cWjMCvtQEJg?=
 =?iso-8859-1?Q?AzfzisqJgZKIJXYB8KgB3kPRs3PvNmYVHDc0dqtkP9lnkoPEEaPdpnVFD+?=
 =?iso-8859-1?Q?edisXll44Grbo2X6Cw+ge//ynlw0jfFNKd9JK4SjKORHBV4RGjJsgyEztI?=
 =?iso-8859-1?Q?Z+sELlCwS6ISYbuVWrVeq28GPi2icAmnZk7QWmCiJ2HKR8MH/ina8INtzl?=
 =?iso-8859-1?Q?gxJaBsos1GA1pmiIkDeSglOFla83M7YyD1wc9VndIMKd3K27YPlSmefux3?=
 =?iso-8859-1?Q?MZ9UJqUfYs0YsHM14cqWMOGf5fmSKKjnFU1KgVntagX7T9bsqus2oovsLK?=
 =?iso-8859-1?Q?IHx7Q6NceGBzBUDUYhauQlddIS+NRK/uPp/bG+mlDrPfDXrli6eF7bqw+S?=
 =?iso-8859-1?Q?d7AKFApBrN/Ac+dl6gyIlUBGF3/LUkkx+t/qkEh016X52Kc6rzJkyAtIho?=
 =?iso-8859-1?Q?Ekxhn9BKWRkmLvTcpWEH182gvIMXO+TqhCTGbh15fuC4BDaDWBYenQTw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e06a02a-f36d-4d36-78b5-08da85e3175c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 15:12:42.2196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cM6FRFpaAV0yOXTARqZf8bZt0dW5cQCT0M+QxhJf/PP1GMV/4a+N5BKacUcd1bhAmiR7gsMMCBfWXnza0P/ogg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_08,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208240058
X-Proofpoint-ORIG-GUID: ibJRgoS7bjdcCD8JhEltV7jibkTBnt-A
X-Proofpoint-GUID: ibJRgoS7bjdcCD8JhEltV7jibkTBnt-A
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use mas_for_each to iterate the list of VMAs instead of a for loop
across the linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/proc/base.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 93f7e3d971e4..0b72a6d8aac3 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2350,6 +2350,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	GENRADIX(struct map_files_info) fa;
 	struct map_files_info *p;
 	int ret;
+	MA_STATE(mas, NULL, 0, 0);
=20
 	genradix_init(&fa);
=20
@@ -2377,6 +2378,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	}
=20
 	nr_files =3D 0;
+	mas.tree =3D &mm->mm_mt;
=20
 	/*
 	 * We need two passes here:
@@ -2388,7 +2390,8 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	 * routine might require mmap_lock taken in might_fault().
 	 */
=20
-	for (vma =3D mm->mmap, pos =3D 2; vma; vma =3D vma->vm_next) {
+	pos =3D 2;
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!vma->vm_file)
 			continue;
 		if (++pos <=3D ctx->pos)
--=20
2.35.1
