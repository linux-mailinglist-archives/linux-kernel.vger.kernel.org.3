Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBEC59C244
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbiHVPJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbiHVPJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:09:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD443E754
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:07:12 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEirHw017918;
        Mon, 22 Aug 2022 15:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=MCqpLgWgrae1tU96KhVs39JzimDTZHFFBrcSRwIT5nI=;
 b=nmF9MsWtWqSZDdOsYLXPS20JwnYxn/U4uXg5WxcqpXN0WNXKqZPFefqcjaFREggllRfi
 UoGIAaG8aDsnd9mxARjlU5cZWzTd+qoydDBCjeFOiuxm9pWwuNjZTApGrC6IlkOXTLWH
 ql6IoToquZqwASvGwrTRpfMDj47SVOLq/3rS1jXYFOfpQ4JL6jQT/CTPmBttUMFh/FIS
 8R47ca94Oih5fptcqd1REww/euzg0d9RmH5lCD2zxf9+E4mEjXddHTF08+Gl5xJ94Xh9
 lIIN7ppZtkIv2wSSUVM7cOo0v0vNqh53asalur66z5TrY8KpJ726TeRUSsJPLFBW/LyE ww== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bkt049a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Nac031868;
        Mon, 22 Aug 2022 15:06:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjd3986-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SO7yn7WmuFxhMH7Fd4iDWAVAzCHuwlWIY0TbgsZPjrFUihIDc1UHfKP5J37NENryl8tHF+pwULU46XrTzjKJPxI0HaMB06YVmL4dbTR0aS/q0tED9U8HFte6Dqk8H2v/ysSQ/iveC86CfDBFxSD8GCqStEXa+Sm1YTQQwE9aumtKTxxOAXREDzNqIr5iJZk7DmaRxBQlw873OSyUYiT7cvwtEDCZ1xCe5TX9fRDJLAHberxQbsiouaSHiTsbaqDkvRBZRgqOfOdWmwmqApELs2rQrWVRt5fkRyS3VImLMVJWTRzWPWFbZcdVbXetuYqQO6H0He4mV1JoKDdQVLjtDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCqpLgWgrae1tU96KhVs39JzimDTZHFFBrcSRwIT5nI=;
 b=A1NsFPwGstIVlJZibEgy3x9lGoNMQv6NpONiVZ2yXxsE/3LWWYzOTn5PJOCBaFRkiRHc/GR2e6BJZmklOlKXUeKABn9hxMuHU0M7MZpK1CZt1KPgYWdQ9cS2bFmJ+EcwNRjRW30yfoVp7uldHDKTyaZE0ub3oYAKeqeyrp/nS6+OGQnds+2rq07znqDwUtuGiwK64VSQPyPBi2qnokxjZOuVPL03cUCzI8Gd5Bswp0agJge7K0noSqbl2w73wphCDkrmFVCdQJoE0tZtnrlcFr5IIX/uErhWu4iyvApn8z3XZO58ldSjSPe4wWC3PoOfhwOkYMMI0linpXD3VpAkHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCqpLgWgrae1tU96KhVs39JzimDTZHFFBrcSRwIT5nI=;
 b=Hy5fKHOtkFCw593lFaOA1svwWCHMJ7xnsPxFmawL0NluiVvmwANP0tCF1GcQfiWNVu+2GPJ3PsEuRfTHMw0nwcKckid1+/h/f2ErMxpTS7B4Wt/G8rUbRu13caQQx5+nBIBa4zMwnfpN+PQyvUgon3+qrTZroi1Y58eQSrbby7M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1433.namprd10.prod.outlook.com (2603:10b6:3:e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Mon, 22 Aug 2022 15:06:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:27 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 44/70] userfaultfd: use maple tree iterator to iterate
 VMAs
Thread-Topic: [PATCH v13 44/70] userfaultfd: use maple tree iterator to
 iterate VMAs
Thread-Index: AQHYtjjAEcKiyYmCRkGyRSArkZvwYA==
Date:   Mon, 22 Aug 2022 15:06:26 +0000
Message-ID: <20220822150128.1562046-45-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25a1075d-f0cb-4ef9-8b14-08da844fe35f
x-ms-traffictypediagnostic: DM5PR10MB1433:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /yN/ZLQ3hQC6kPIfJPUyZNF+BE3/mhD+ilJVTG+AJiWzJ0454CbXY9st32fvtsh6ThEqvHs+BGxJ7Pr6AcozGYKFTzUHHYXCa1yexLR9as2ugFP8SzH65gdlogDTGueFZ1dVOS+zY07Kzeek2ORLKEkGaHxPHdE+hvtWwFho6rpKUxegPHCpSeZMb3EkTTA+0J6jzO5v1qT5sf/bzppRPNoi5VdDR0cg19SYctCtsaVbFPa7u/Jc5JyPd7rJT7P8Ma3NrNMlDJFvIh7W7+it2+0bxjxw5gtvAxKgH9OVIJoJEyQz2ynDQjk5GeikvlbYY19YBwkDEpasTzXrGI2Jx2I9tCieOo6ZiLgcUlXED5EgqXzwFcVnVqMtdkSpMcr0jbTEpAcnhIGqgJvnqLLVTSD5+DfKih1cYStp9yVndzv28WhdLVEO7IRCwJUM9Jnfet2qdCGXVMpSvV9zAREdq3AdBedqKDq8tDWz55sSb0ZUa3VV09PwhzKkt+mkb+2EcD9f/74WXV9j8i9g7GanErB56lgBunijEkI/ZhQDxK3X9esyH9RDl2NKe/v1BzMJ/yIravvVXXWyrp/zYcW8kP/aixyq70PNJx/DztF/QHa318zdd5KZ8DaMvN9rsAraReGxKV41TUOc6bsfJXlZ42tl7UvYeOdNjfLaRYdVVym3vXkmujUwdZmnlEHs6hnbWxtG55KpyIXLa/3mzIDFxe8wqPURwxmQc7jF83T7F1muqn6sGyubCbkpdT34Lqx+PRvBKh0bC05zB3NHFG0PpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(5660300002)(8936002)(38100700002)(122000001)(36756003)(41300700001)(44832011)(6486002)(316002)(71200400001)(76116006)(91956017)(110136005)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(478600001)(186003)(1076003)(107886003)(6512007)(26005)(83380400001)(2616005)(6506007)(2906002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qpkn8Sc6SxVRVnSNYByXBpMHVEjoqmM36pYKfjss8BiM3oXCKboAIO4Sha?=
 =?iso-8859-1?Q?A4KaCBQ4F8xCiHYZaduIxtqM1NPguEZrB1YVDUneJTF80zpSG1Uyh+ddps?=
 =?iso-8859-1?Q?yqmj332YHcF/I8ETIF4NRakt/MFL4DWXgXlSnJp3BzLs+8Py/HQV8RO+Qz?=
 =?iso-8859-1?Q?jHNWXE9urr1HXCOIH+TuUAeLPoOTtgxauW2mBL8jHr2MnyFbRQmQN702OV?=
 =?iso-8859-1?Q?o1Il83TUCOVI3l2/n89/BhuYmFU8Fdg7L0KgYvy5hwoWv2Urgzh++3Ci0d?=
 =?iso-8859-1?Q?Wi/7RmTgLh3iL8u5Q3kyAKMC7gJEC2Z9p1P1tP866sCFovFCXt4HP5Mv9g?=
 =?iso-8859-1?Q?kCzn8DlmPRxqppJiEkaOrX9QNquA+qpaflIS7FE4wl6uLCmz3kPwq+lER6?=
 =?iso-8859-1?Q?8h0UXN1boAO+Dd8kjBrs6bXMX0CFE5/jakPyRJP4jVyJVAvwO7P4qMZ1a4?=
 =?iso-8859-1?Q?/Wgt/wq2VWgZZ7HqWlaoE1QLawBn45R0FcGPV2A0wqbzTTW8M9eTolYbBH?=
 =?iso-8859-1?Q?BT76Q265abduEQzm+bGQwz3wM7ISHt3gheAMm/bopX4UquTHxCsjUqTbOk?=
 =?iso-8859-1?Q?PjRB3hNFb+Oz28xSoNIHvW87Ja2biyrJKup6yWqUdt/OcMY984hat6ZM0y?=
 =?iso-8859-1?Q?hLmmJq3CxTdv0VbSyGEsVHZkyH4nYGMFg4QjjFAYUdNK5f0JfETAnTB5KN?=
 =?iso-8859-1?Q?jyBIMKl6cJeoZLCXYuYpiH3zvVqvv6X4Z7YWz007zvnpuW9QKtkCJg/QWl?=
 =?iso-8859-1?Q?gbQ9aWq3xLHe4unm7oIrHg60GQXtkdpR7jJKX67MspiXVLXej9FqdxlTAr?=
 =?iso-8859-1?Q?tHBFC0RFPK0McaNMhYUj4sfRDkI2rfusojH6Ns1c09RO2da5aG9OrS4YQE?=
 =?iso-8859-1?Q?bIvY+PAWSvixGOwaWenC54Tv1UE09MzwW6wKe+dRecQ2P11foX7tBmz7un?=
 =?iso-8859-1?Q?f7sGsCI2ovZZezV2paAgbdy+ZIRBW/EE//zaBvhYtaRExka1QFTko0la4M?=
 =?iso-8859-1?Q?j1nquMvflngj0vJT1bl+hYiNvqJ+pcItG/jJQcNaoVXlNw+3RcJRCy4zqR?=
 =?iso-8859-1?Q?/GMWW4Akw23DpT3YglYofptfg06Xd/buGWE8aVY8GUPeqN8BFabAtCFJRa?=
 =?iso-8859-1?Q?yjmTkd1lOlOFJpovA7hRgg2PQrvhvCcVSKERdEFvzIRvexBzbPFPD2ye6/?=
 =?iso-8859-1?Q?4BjX1AhY26DZAY4XeO17KgXypWgiSTd6dxl/0Yf1F+zK8w6H7C1KhAlAJY?=
 =?iso-8859-1?Q?6tThXoYh8iV8/lX845zaDD7WITp7ErXQCC3rcZoP9qITJw3DPpNGCBs9PF?=
 =?iso-8859-1?Q?74XPtGzS6sDemRWfmPFwxHC+ASQKQFcsN1LKDiFXa0Og9HRbzaLA/urcU4?=
 =?iso-8859-1?Q?p+V0eJHE7NTZbdGNEPXQdpmJQX3PKPIhwYgmDtw3ouFaxvZqdKG8zjNaNh?=
 =?iso-8859-1?Q?Dh32dSW8Liq1UAEB6Ta3EQt6xKIdtR9Gw+iLpf421AN0sDQQtgrh19pQRL?=
 =?iso-8859-1?Q?hq78aHB8HVtUEzXaXdiQk+xqyz76zOvKsUiLmOywBe3aBJY2FBLNg6heCc?=
 =?iso-8859-1?Q?W8PfBK05wBKViMN524nmKukjrfQ/fSlPmTy7VqU2IeGOr+nESXNxE+8ssX?=
 =?iso-8859-1?Q?/4wof6AeyhkW2DAPDn0em6aTaizft8cbcykutXBSKb4TmNJmCOz7T8dA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a1075d-f0cb-4ef9-8b14-08da844fe35f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:26.3788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ptirF+s8j/HB+UTqEkbVzbQ6dRhE2VQSge3kkod1QkIOpjDtnuoNxbuipRsmggTYGjasn9x+9+vMILY707CRlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: mtR6lKScDtnGByW8hTaugXfhTvCFNAX2
X-Proofpoint-GUID: mtR6lKScDtnGByW8hTaugXfhTvCFNAX2
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

Don't use the mm_struct linked list or the vma->vm_next in prep for
removal.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/userfaultfd.c              | 62 ++++++++++++++++++++++++-----------
 include/linux/userfaultfd_k.h |  7 ++--
 mm/mmap.c                     |  2 +-
 3 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 941ede31a9da..f728fb98ce6d 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -611,14 +611,16 @@ static void userfaultfd_event_wait_completion(struct =
userfaultfd_ctx *ctx,
 	if (release_new_ctx) {
 		struct vm_area_struct *vma;
 		struct mm_struct *mm =3D release_new_ctx->mm;
+		VMA_ITERATOR(vmi, mm, 0);
=20
 		/* the various vma->vm_userfaultfd_ctx still points to it */
 		mmap_write_lock(mm);
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+		for_each_vma(vmi, vma) {
 			if (vma->vm_userfaultfd_ctx.ctx =3D=3D release_new_ctx) {
 				vma->vm_userfaultfd_ctx =3D NULL_VM_UFFD_CTX;
 				vma->vm_flags &=3D ~__VM_UFFD_FLAGS;
 			}
+		}
 		mmap_write_unlock(mm);
=20
 		userfaultfd_ctx_put(release_new_ctx);
@@ -799,11 +801,13 @@ static bool has_unmap_ctx(struct userfaultfd_ctx *ctx=
, struct list_head *unmaps,
 	return false;
 }
=20
-int userfaultfd_unmap_prep(struct vm_area_struct *vma,
-			   unsigned long start, unsigned long end,
-			   struct list_head *unmaps)
+int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long start,
+			   unsigned long end, struct list_head *unmaps)
 {
-	for ( ; vma && vma->vm_start < end; vma =3D vma->vm_next) {
+	VMA_ITERATOR(vmi, mm, start);
+	struct vm_area_struct *vma;
+
+	for_each_vma_range(vmi, vma, end) {
 		struct userfaultfd_unmap_ctx *unmap_ctx;
 		struct userfaultfd_ctx *ctx =3D vma->vm_userfaultfd_ctx.ctx;
=20
@@ -853,6 +857,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	/* len =3D=3D 0 means wake all */
 	struct userfaultfd_wake_range range =3D { .len =3D 0, };
 	unsigned long new_flags;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	WRITE_ONCE(ctx->released, true);
=20
@@ -869,7 +874,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	 */
 	mmap_write_lock(mm);
 	prev =3D NULL;
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		cond_resched();
 		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
 		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
@@ -883,10 +888,13 @@ static int userfaultfd_release(struct inode *inode, s=
truct file *file)
 				 vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
-		if (prev)
+		if (prev) {
+			mas_pause(&mas);
 			vma =3D prev;
-		else
+		} else {
 			prev =3D vma;
+		}
+
 		vma->vm_flags =3D new_flags;
 		vma->vm_userfaultfd_ctx =3D NULL_VM_UFFD_CTX;
 	}
@@ -1268,6 +1276,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	bool found;
 	bool basic_ioctls;
 	unsigned long start, end, vma_end;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	user_uffdio_register =3D (struct uffdio_register __user *) arg;
=20
@@ -1310,7 +1319,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 		goto out;
=20
 	mmap_write_lock(mm);
-	vma =3D find_vma_prev(mm, start, &prev);
+	mas_set(&mas, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma)
 		goto out_unlock;
=20
@@ -1335,7 +1345,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	 */
 	found =3D false;
 	basic_ioctls =3D false;
-	for (cur =3D vma; cur && cur->vm_start < end; cur =3D cur->vm_next) {
+	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1395,8 +1405,10 @@ static int userfaultfd_register(struct userfaultfd_c=
tx *ctx,
 	}
 	BUG_ON(!found);
=20
-	if (vma->vm_start < start)
-		prev =3D vma;
+	mas_set(&mas, start);
+	prev =3D mas_prev(&mas, 0);
+	if (prev !=3D vma)
+		mas_next(&mas, ULONG_MAX);
=20
 	ret =3D 0;
 	do {
@@ -1426,6 +1438,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 				 ((struct vm_userfaultfd_ctx){ ctx }),
 				 anon_vma_name(vma));
 		if (prev) {
+			/* vma_merge() invalidated the mas */
+			mas_pause(&mas);
 			vma =3D prev;
 			goto next;
 		}
@@ -1433,11 +1447,15 @@ static int userfaultfd_register(struct userfaultfd_=
ctx *ctx,
 			ret =3D split_vma(mm, vma, start, 1);
 			if (ret)
 				break;
+			/* split_vma() invalidated the mas */
+			mas_pause(&mas);
 		}
 		if (vma->vm_end > end) {
 			ret =3D split_vma(mm, vma, end, 0);
 			if (ret)
 				break;
+			/* split_vma() invalidated the mas */
+			mas_pause(&mas);
 		}
 	next:
 		/*
@@ -1454,8 +1472,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	skip:
 		prev =3D vma;
 		start =3D vma->vm_end;
-		vma =3D vma->vm_next;
-	} while (vma && vma->vm_start < end);
+		vma =3D mas_next(&mas, end - 1);
+	} while (vma);
 out_unlock:
 	mmap_write_unlock(mm);
 	mmput(mm);
@@ -1499,6 +1517,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	bool found;
 	unsigned long start, end, vma_end;
 	const void __user *buf =3D (void __user *)arg;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	ret =3D -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1517,7 +1536,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 		goto out;
=20
 	mmap_write_lock(mm);
-	vma =3D find_vma_prev(mm, start, &prev);
+	mas_set(&mas, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma)
 		goto out_unlock;
=20
@@ -1542,7 +1562,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	 */
 	found =3D false;
 	ret =3D -EINVAL;
-	for (cur =3D vma; cur && cur->vm_start < end; cur =3D cur->vm_next) {
+	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1562,8 +1582,10 @@ static int userfaultfd_unregister(struct userfaultfd=
_ctx *ctx,
 	}
 	BUG_ON(!found);
=20
-	if (vma->vm_start < start)
-		prev =3D vma;
+	mas_set(&mas, start);
+	prev =3D mas_prev(&mas, 0);
+	if (prev !=3D vma)
+		mas_next(&mas, ULONG_MAX);
=20
 	ret =3D 0;
 	do {
@@ -1632,8 +1654,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	skip:
 		prev =3D vma;
 		start =3D vma->vm_end;
-		vma =3D vma->vm_next;
-	} while (vma && vma->vm_start < end);
+		vma =3D mas_next(&mas, end - 1);
+	} while (vma);
 out_unlock:
 	mmap_write_unlock(mm);
 	mmput(mm);
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index e1b8a915e9e9..f07e6998bb68 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -175,9 +175,8 @@ extern bool userfaultfd_remove(struct vm_area_struct *v=
ma,
 			       unsigned long start,
 			       unsigned long end);
=20
-extern int userfaultfd_unmap_prep(struct vm_area_struct *vma,
-				  unsigned long start, unsigned long end,
-				  struct list_head *uf);
+extern int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long star=
t,
+				  unsigned long end, struct list_head *uf);
 extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 				       struct list_head *uf);
=20
@@ -258,7 +257,7 @@ static inline bool userfaultfd_remove(struct vm_area_st=
ruct *vma,
 	return true;
 }
=20
-static inline int userfaultfd_unmap_prep(struct vm_area_struct *vma,
+static inline int userfaultfd_unmap_prep(struct mm_struct *mm,
 					 unsigned long start, unsigned long end,
 					 struct list_head *uf)
 {
diff --git a/mm/mmap.c b/mm/mmap.c
index 64d12dd9d234..6c450cb9c786 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2545,7 +2545,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		 * split, despite we could. This is unlikely enough
 		 * failure that it's not worth optimizing it for.
 		 */
-		error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+		error =3D userfaultfd_unmap_prep(mm, start, end, uf);
=20
 		if (error)
 			goto userfaultfd_error;
--=20
2.35.1
