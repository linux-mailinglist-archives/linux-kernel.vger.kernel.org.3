Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D043E5AF513
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiIFTxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiIFTuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D0980EAF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:02 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdLcL014155;
        Tue, 6 Sep 2022 19:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=47yOljL6/6aYkZ3kT4JADxwdilgAuazCf0w688kEYr4=;
 b=CNcGmdQwcWrmISq/FCWnOylJPfnNAe4pT3ncJ4gs4JtHnv0DBJK3VXqdigNhrPtEtnwi
 su3GLcenduJYoNQu+/vbCW5Gw2bktBWM8NPILwb0/Kl9LnoGf5/eulhu1cUftGbVM/fl
 GATTcGoXH1oU2b6Nd6Fs/NIKoMwUl+M0W2k926sJjgKVDvnI+cFzZxYctxKCkyko5Owr
 Zq7sGWRXjuQD7sNo3jxbq+SwhXdJefQ19DuPHXJKzW43IyZCPyFWgAvHqlrUq7CGWe3Y
 GD9lYn9f3u0Ac2lU6lIUq4jGTMZYkN2WhMjZ+YNe8pzhJnCjXEDiRA0A1BxcyaxAgNDc aw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2eyp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286Je5WZ039711;
        Tue, 6 Sep 2022 19:49:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9m7j9-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJ7R7F+k2Og0S7fVSzJVm6hKsLO3EPaHrWExO+2BgRHBHU5HX0b3RVOFiUBmbJ1eaT9CktnJM8Km7Z477fpWQ2+BJ4hQjfo6kRGTDfBuEHJsuLmseSlxgsOiM3JmtCuFYRYynaPt3ho7l6vBEwwCb/sVt1ckCm6uTz9InvQbrPH457uf1clmDZeeHmGso3VjiLDWrK1q3qFHu+Ocj/gdTi6PBI6I1KtHmGo30ABUH6G+O07OoebXOp1WShY5eu28Jml+6LhxemBvZJclVH2/fWtiJHJ3a0f62moX557+x0HolGY7ecJSEeztBD8yq8870c5/HrdVfnGK/rO2WEOI8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47yOljL6/6aYkZ3kT4JADxwdilgAuazCf0w688kEYr4=;
 b=Hqu7xRY4C6GXQ2GNlMFOgvaxxcssYruRT86UzXzTyqJTUxyPmRrRZhj1MNWHL6P0+1Ms6ToYL1gDJOqTjIn48fwyfgaO/pvfBZb2ZDNEXrhSNfnvjOzIi2NRkaMX9ouixlPwBSM6cs5aX0kUKsmN6efaWCJJSqTBYgfHBrkJpfHS00RWQENubYCxrtyv+XQ+vvhIGz+uLPDhIv+U8DXfzu7NBuCwNaKfTk64Jw+cPlfeGLiXIDIGt3O9z8IWa/696UGuXzeiW+MfIWdxpppyANhF6vXu1sEeawHug99U0aQ2Obh4EiwruXVxvNa7AUh9w+apsGZO1bIIAyAXcpscpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47yOljL6/6aYkZ3kT4JADxwdilgAuazCf0w688kEYr4=;
 b=DBtPGW3cjd3ME5L5ufWJx4/zR82NaaKihDQU0LWJQ3vzVC6q4WfpoKf/WWQbWsVruJ22PHCOIjcns9UMv6KZovEe/p/nqPrhIoBsENWK6YlB0LfYhnn4ZMMvWq2NEBE0n8mUVAfp0w1akdGR+S4YkMvGBGz1AHTRfwC/eo0LvcU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:49:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v14 45/70] ipc/shm: use VMA iterator instead of linked list
Thread-Topic: [PATCH v14 45/70] ipc/shm: use VMA iterator instead of linked
 list
Thread-Index: AQHYwim0iZtZ2ZP+70yIxKjzVtFUFw==
Date:   Tue, 6 Sep 2022 19:48:58 +0000
Message-ID: <20220906194824.2110408-46-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffdf8aed-c6fc-4adb-fd0e-08da9040f135
x-ms-traffictypediagnostic: SJ0PR10MB5598:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yDG7cZ5/C9xEV75wK64BpxwfGHBu29q/LmxAE+EbUEe5LgpqWeVfTnXn1yvu+p9KVDkah2DYiPSFpLLdigFGwsYuXNZWREq/EVT6dUTFWsOSEB5lVIlsdiqpo7d7JP/MaQR7asc/8yDTAOgiqBo3/oa4IrJQjbrFTLw8hv6ZzxdRjX5MtTJPnIB0ESW711DAlwktTwOAPPKYRCER+OcCSSZxwdnMqvdRZrrX0fPZWBNanh5Tz3yJ8EcX9/wR3dJk01Y/Qhg46vwJJWjI99F1O/IdmJ529ifmkRWFz38ci2iAkE//Ho6TAuCSQE11l/XZchcGVZQ1YIxQYMvbATTgw+XSyEBobLu9dNG8X1D1p290eqos0KXwFBNMtl1oB1RVRLKTwQ2vVoHCBUd6Aj2BiIfSupmXbmVpjkYl7maj+lTux7u3zSsduTBEN9w3ahJRMUFuwKxV79dPq+yPlihcWTjXOVVzN27X10ma+7PmlFH/uxPS7CWZWdXTGs2eJOFcJk/ZFv32D8v7ZvzxTEuM6//wXl4ysBtBacytvM2+bOM9ZfcigE+Ie3yh8eFPqPmw3s/c/raqFIZHA5FIaMYp7/az75Jpqx4wK3MSsM90pDNeU1AjdguWXZ0k9ioyfM3qy3Jl+dnLZGdksNh5uhukuQ9CE09binufxhJQWWKU481rSLnLBgob2tgiv+wj9C38ksNmwgVyqRdfsBqe19DYc8OmOneyHf5YeKjlC3MPXwZRJJdkQvmbr+c7jfV/kLcBIETraWpS9fdcl/QaXTsYlg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(376002)(366004)(64756008)(66556008)(41300700001)(91956017)(76116006)(66476007)(66446008)(66946007)(71200400001)(54906003)(110136005)(36756003)(316002)(6512007)(44832011)(8676002)(122000001)(2906002)(6486002)(4326008)(186003)(8936002)(5660300002)(478600001)(38070700005)(38100700002)(2616005)(86362001)(26005)(1076003)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KsKETYp0Z6FhL1fNWd4RHnnS40CiSXdgs7vPaEw/ZcV5v2nCKH1tY5SAmN?=
 =?iso-8859-1?Q?wJ5hY0b13sWw+40HCU0VpKiURjaoPLHgTIPi3jG6uOTFJ9PnEf8AslxbU1?=
 =?iso-8859-1?Q?Kua4O16NpTfCpHBoZ2uvAK5XtzFCcMDX2FAoatq0nUu5+lyfBYYqy0cKFb?=
 =?iso-8859-1?Q?uS0TbNKQ2J0pBs3HEdG6hJ+JiyBUeXpHjUqeEkl6fB3avfOGbn5tJ3Y4YE?=
 =?iso-8859-1?Q?GJjpLshr93iooeyyGbWdVNNcZ4DUejWPiluaii+XsplaGlHoW6nF8a80kJ?=
 =?iso-8859-1?Q?gogyPOiKusa4Ey89qF41UDeo+ACVI7ceKM2rIqaQ2WTyUstPSDKF7t8aXK?=
 =?iso-8859-1?Q?8CVGIgM4E6mWq4n0vjD+8EUevSlvcWMO0nIh3AtWuLHGltWivcoon9+J3i?=
 =?iso-8859-1?Q?bUbPjPX52kUokRcqgH8ksmKzwbrjvXGCig0yIDVR+fP8HFKI9JbBAMAD+n?=
 =?iso-8859-1?Q?Xg2Cp+ZJMLWZVosLVqBqJSyHwEj3EX2Satjvf5eR+4fgBzQNxl5YYydztu?=
 =?iso-8859-1?Q?v4Scq6Ay2HO95X2qT6aa94d7BApU79FuH6VbOrOzYB9b1iT3qpHekU3c2X?=
 =?iso-8859-1?Q?K7x/VlZl1T8luhKpElcjFfBcioL5ROgS1AGd/y1KtsgTngSL9vPgwXt5ZI?=
 =?iso-8859-1?Q?+/KdgbP+Eodp9TZ2PCSd0RTP/d+w1e6wg5X7dQeKmY2IlIhm/JkCZdrg7R?=
 =?iso-8859-1?Q?Q0MGT/ORggOZ/gG9VG/KwFUeifphLLP5oaLdjgZY0a94hXPBXzE2trJoGm?=
 =?iso-8859-1?Q?d9QL8GkCh3IcLTUOJcaRX2fiJsfsiFJ9gB7Z7egc8yk3lcvLp52W1F0/Z7?=
 =?iso-8859-1?Q?5k7jjwQDghOsywPOetmFoqLWZtetLNkXdrSSjccvC5rObKm5K0CGt5w+0I?=
 =?iso-8859-1?Q?C/9n+LQ6LwRoYjRKxraVcEIe1aRow7AaUtBLAUjdI7Ll4yF6mZHF67VP2u?=
 =?iso-8859-1?Q?V8U4glSDgYbN7uDvmH7YR6qk8gnhAgg29eeE1W4Xzol9mAw21jI+P8f8k7?=
 =?iso-8859-1?Q?nCCCIBrF0ktiARV28+vpYWykzl/X51PUTBHWO+CYOkhkJZPiJjNl/e7CJf?=
 =?iso-8859-1?Q?PCWHQnlDYKA4gNOZMLN87EiBZaykW3Kym1Zdr1I0IMcYSIQl5KENFcCYko?=
 =?iso-8859-1?Q?e2QTWWj2GoKhrJ5ebk4Yr4l4rqu1TLpB86y6Zvwmuzr66DPBPxC6AwzoSI?=
 =?iso-8859-1?Q?nWeLK5u+wWy0atxK7L0vfuugUUh5l96DBPOYCbuOTEk8VfWNKIZBlulpKb?=
 =?iso-8859-1?Q?O/x3qIq1036RnYarS5oPMMOwCCscMAbapmI2xQHC/6sqUeAZkHkJ4sJ6hC?=
 =?iso-8859-1?Q?HBVjg2TcDPyTuvLUO6DA0xVIfhdFR+uEAte1WNeb/OToBo2HfYpj9NY77X?=
 =?iso-8859-1?Q?EYFPbwHJD6lWbaI+qFb+g3tSovucQ95x4jIZVkcECS4j0l/NmbkbjygDkw?=
 =?iso-8859-1?Q?EbcKWwD7Kkbe5U5c3RBz0hXnb/JGHY1tT8RMisYEbbq7NHZDX9yvH4cy97?=
 =?iso-8859-1?Q?9U8v2/+UCRuqFjO86mQW8VqAUAzOiA2V6IoRkiyowzxeoYlHJ7ynyvuKdu?=
 =?iso-8859-1?Q?uHBErsS5DT7yZVzXdH5TwynKa3vPd6MMs8DDRqvb9oKC3slCI7OVQ+7PkU?=
 =?iso-8859-1?Q?Rtrl8P+VEeIwEwKjwrTRFHr7G0QUuxy2cWglwma45azdm0YYxoT0NVNg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdf8aed-c6fc-4adb-fd0e-08da9040f135
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:58.3342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLKoWH+LzcdO9B9D2dOnMxpUx40vSpfXEjVlVtLoazmdDRx47bAZW92o+ogBKQVZM5123U8iBd7MIJJZzodoVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060091
X-Proofpoint-GUID: FvJkHa89hNwRk_TXtndkK6V_nOjANPbC
X-Proofpoint-ORIG-GUID: FvJkHa89hNwRk_TXtndkK6V_nOjANPbC
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

The VMA iterator is faster than the linked llist, and it can be walked
even when VMAs are being removed from the address space, so there's no
need to keep track of 'next'.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 ipc/shm.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index b3048ebd5c31..7d86f058fb86 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1721,7 +1721,7 @@ long ksys_shmdt(char __user *shmaddr)
 #ifdef CONFIG_MMU
 	loff_t size =3D 0;
 	struct file *file;
-	struct vm_area_struct *next;
+	VMA_ITERATOR(vmi, mm, addr);
 #endif
=20
 	if (addr & ~PAGE_MASK)
@@ -1751,12 +1751,9 @@ long ksys_shmdt(char __user *shmaddr)
 	 * match the usual checks anyway. So assume all vma's are
 	 * above the starting address given.
 	 */
-	vma =3D find_vma(mm, addr);
=20
 #ifdef CONFIG_MMU
-	while (vma) {
-		next =3D vma->vm_next;
-
+	for_each_vma(vmi, vma) {
 		/*
 		 * Check if the starting address would match, i.e. it's
 		 * a fragment created by mprotect() and/or munmap(), or it
@@ -1774,6 +1771,7 @@ long ksys_shmdt(char __user *shmaddr)
 			file =3D vma->vm_file;
 			size =3D i_size_read(file_inode(vma->vm_file));
 			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
+			mas_pause(&vmi.mas);
 			/*
 			 * We discovered the size of the shm segment, so
 			 * break out of here and fall through to the next
@@ -1781,10 +1779,9 @@ long ksys_shmdt(char __user *shmaddr)
 			 * searching for matching vma's.
 			 */
 			retval =3D 0;
-			vma =3D next;
+			vma =3D vma_next(&vmi);
 			break;
 		}
-		vma =3D next;
 	}
=20
 	/*
@@ -1794,17 +1791,19 @@ long ksys_shmdt(char __user *shmaddr)
 	 */
 	size =3D PAGE_ALIGN(size);
 	while (vma && (loff_t)(vma->vm_end - addr) <=3D size) {
-		next =3D vma->vm_next;
-
 		/* finding a matching vma now does not alter retval */
 		if ((vma->vm_ops =3D=3D &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE =3D=3D vma->vm_pgoff) &&
-		    (vma->vm_file =3D=3D file))
+		    (vma->vm_file =3D=3D file)) {
 			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
-		vma =3D next;
+			mas_pause(&vmi.mas);
+		}
+
+		vma =3D vma_next(&vmi);
 	}
=20
 #else	/* CONFIG_MMU */
+	vma =3D vma_lookup(mm, addr);
 	/* under NOMMU conditions, the exact address to be destroyed must be
 	 * given
 	 */
--=20
2.35.1
