Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA8859C252
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbiHVPMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbiHVPKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:10:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934E23F32E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:07:48 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEpgmv016424;
        Mon, 22 Aug 2022 15:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=47yOljL6/6aYkZ3kT4JADxwdilgAuazCf0w688kEYr4=;
 b=naboY8NObTVkPBX5YcJKOETjA19rC7i1QKzQ1wXG6gLPCPG3R+j8hKQrNVVSSP90GkDo
 smITtombpqVUXUBbfRYlZmRhYRtD8VpzKLKGlM/v+7//u7sGnOnMOsh7YGNebMU3aMrt
 sigOORU7t3qH5yoScNauIdiziqh2RJn6SsnnpOsJSK0g8biwp1MM3UwwNV7mxYQI8DqD
 ARNEg/8TFiK2Vpi9QGlDZWAxiBcO0O7kQDvaCkxRogME51imW4YrkM2YEDI3Xzl6swHQ
 aLWVripJQR3ANHEUH95BrFvqaJ0tkEAaGk23KtcYFb2kfb148jAXQXnANZE17q2B3Ht3 Cw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bx681je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Nad031868;
        Mon, 22 Aug 2022 15:06:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjd3986-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bY+9W7bk45AQ1vULSyS55FJt56SgkK/IEWovlLnVcj7ir+xynYz0JB8vxX9J5HB8StyF7KCUHmlf6DOz8Sthb8i0rSnKspZ05nxiOiRrNuVi+AYGxUe3PuddesRgu/ZEP7U1KqQzMVi+6aOfongz+wRfOIi2CwsnpGlp83ObJCXwWQLoRGkHGqhhario9iAaMrSGj8MgafINK5n54fc/4FP08H5R+rBjIk0BdOYOLgr7R4xZoEo+ETn/ESGgyW4fWAnJbLX7NnsW/9gveheb/FyQ2tTTfQZYOqsW6JDolR5oUWuoJImRaibiKNaIxO2CmJA34emnCpCZu1p7Fc+ycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47yOljL6/6aYkZ3kT4JADxwdilgAuazCf0w688kEYr4=;
 b=ceIQ3TBUhjrAHd1uvzPFYttlyYm/PSS2HF2SwkCXSTstUc0GBt9hFue11t1E9CiGCiqTd2FE7EZMhEMoV3xAs86Lmk5vkr52pvOOI8E+6iggLu7Wi0HXauauEe1jtPPAY7A+rQVQ2OyXK2JJpnH5JZA4IbTFVn2s9l0qQew5i94FDGmIH8i9TU2NVLRwcqCf/4A1I9vqtYLROQ1TlYIXCzeyN7AH1kk68OmJJgf/Zeac1uqEn+ZfYKf4r7jZIXM1FH9BmNZwzIse33mDgHllnB3mDRH5oGhc/3fxTHDTdXcWqHtkY7FUbq00U0Fzdm1ZKDkNrQ594zs519QHUIJTKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47yOljL6/6aYkZ3kT4JADxwdilgAuazCf0w688kEYr4=;
 b=gFoHBgkcdRFbIga/ER94VW3h8SgLIfHo5hLzBUglBt/rBhLTQrtuEW+A9MXk3Bo4M4+CYP7uy3tbLKnjxQ2nC+fcjHvlzW/cT1OopgbYSwMSgBNMp8ndFFjAdRb1pcD7MmWKQCS6UWxGVOZbRS4ydog8jL3GMP6AUAXl4JXzQiw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1433.namprd10.prod.outlook.com (2603:10b6:3:e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Mon, 22 Aug 2022 15:06:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v13 45/70] ipc/shm: use VMA iterator instead of linked list
Thread-Topic: [PATCH v13 45/70] ipc/shm: use VMA iterator instead of linked
 list
Thread-Index: AQHYtjjA/tt5j7d2IUKwzPQs/ek0ag==
Date:   Mon, 22 Aug 2022 15:06:26 +0000
Message-ID: <20220822150128.1562046-46-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15b1797f-0774-4f5e-4ac7-08da844fe3a2
x-ms-traffictypediagnostic: DM5PR10MB1433:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KThAbyLvt8ZKIzyYqqoHKiz2CpqqQtyaA7H22++YcdU41BEQhW1PrkjqJa4EWN/q4fzaUZ2VCQDGusyvfwm2as/mtU2LAu2HvWlz8UtzIVClT+9pEAxQkjL72LgrleycO39yYJXSjNBjh0sPW0P1dd6fOIuwxNVNJhzdNVLab8TEtgXMECc618DEi4mQqZ07OPdghgZz01D0lPXJ3/SMd5udWb/b4+wFV3TBPagh+S1rPhQmBcAM00q964v1t6C0Gx3qFqDEGtcaj8lPk2XgbuBMr6lBeXPylk0YX5C5ObvarimLVGzS1cZhl0VIvyWmaDC3x8BHDg2m8UStA0IH0Mf7rdNKFDeLsUcPgdDNPxIqYxKUAxh1zMqnG5J1qCkiE/pzV2Ce2VC58weWzDzwr8fHhLtHeWzZtI5KYb8oEuZuvJrO3CYyL9tTvjVB3G8EVYd5hRUX5lYQA4Wtf4FBxDFgCMf8xE9V1dK1ESlMayMpQwVAWuGWrKnc/u6IP5sRvBvMoYHJ95bvsjOPdANT5OvDFAxfiKnZIhnxI5EB7IIZlTYsOlkGBK/wa8i9tYPGjOn1rwpbNKkNgzCByAFnmEWap31gVkQHK/MREQ75bwjJozCLP/MzY3IqE3BL1C86NBqc4RRhbVXsTyuMAnNLarGj6qTq2KDdzi5yUrjmsJtmrCTUl6+0vEvBrxsWhAipz/LaLWD8BzFgfeq2TTULhfolvfTiF7ZRMHYiWEsusik6XxeF6zwI1S1aIFQTdGKiYhiknVtL9qMLnp69n4+yRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(5660300002)(8936002)(38100700002)(122000001)(36756003)(41300700001)(44832011)(6486002)(316002)(71200400001)(76116006)(91956017)(110136005)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(478600001)(186003)(1076003)(6512007)(26005)(83380400001)(2616005)(6506007)(2906002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OaUEqxdU0QqZt8Uz82cLvNhNneUeMh/mDsyUxsVwLce2mwTPCT8vcBmKdW?=
 =?iso-8859-1?Q?z8NFJS10LY0X//m5Uxc97Z8JJ0qb3N+o+hq5Rk83cnXmWKsdldH2s5FYDa?=
 =?iso-8859-1?Q?qBw/6bWe6upoh0njb/YbnTA2pg/dJ2kFYBsN+IfmyB9OX5HRHhF+EIFe1A?=
 =?iso-8859-1?Q?dkzZbYBcnFC3A72I2kUeWG1h5ZfpUfH+/nSGv4yPSfy/Yl34KBT8h5stP/?=
 =?iso-8859-1?Q?hLdy/mmS2HiJ02le5Ik/YqdwBfuDWdLQ/8XRZsIM8X1gF5ucCwq0/uwyUp?=
 =?iso-8859-1?Q?mdK0+HpQBqwVDWB2RfJqYX4UKqQaTbY7UqI+m7xzqIvIdK5NLGbh0ZTq8K?=
 =?iso-8859-1?Q?UwKahBk/Wcmcd7u01EsI+zGOwGMZef29jK+Nce3kF2whtjCe/WXBHa+Xjw?=
 =?iso-8859-1?Q?weeP5ihJsPzqyHKzTYSs1j00Xv9nFrDJs1Z698iYvmAhi/b9HC72cP/PAZ?=
 =?iso-8859-1?Q?nK8ydCRghUefWFYX+bRoLf8172152U8c00pkn9dd7noc1Rt3TPs93pA+6/?=
 =?iso-8859-1?Q?PZhLPFdhZX85Ymp8dzKjUAa1TJL7HXa0P1FlLu8rire3pccCStCBTmKm+8?=
 =?iso-8859-1?Q?lJycPZLUrXg1d+QSRJPgRODikeHMUhZu/6/YPtEJ3l7CzxGBkeWS4wB+Hm?=
 =?iso-8859-1?Q?S7Lh0Cg7s1oUBh4qb83RNjVlr9B7A63V6CwGWDU9KUr4p903oI32MqXUn2?=
 =?iso-8859-1?Q?kKVvmaY+YGpwUYpOCU5W4+Nz4/OFIpw5Bdes/l83S1CtCpqy1J8ePoHYDi?=
 =?iso-8859-1?Q?YsHVEJV6L2ZZAnBLN92TJMopjW3f8emhpeAy21QJC/gfu2CH005rajjm+e?=
 =?iso-8859-1?Q?4hWeNJZ0Mc1IQ6AL4aB+/7nWb9EGMBdtdgAWho17QpJ6k2eFfssYHUVr6w?=
 =?iso-8859-1?Q?Wqf/DE9gLeUN6d3hgzgopaB04f+qSy9E2wfzH6NayuZ7UCUs6fStHyiQcR?=
 =?iso-8859-1?Q?0OVxYNkU2pl6tAagczqhIpvlKt4vYNjPFh1+FXnVU7vq9dLi5mBX3okJ20?=
 =?iso-8859-1?Q?tFjQda3JBeZmXTWm5YLWYOGJQkcwbBi7XOkS6qCeijGJhjCQaZC3sZGzrb?=
 =?iso-8859-1?Q?RiTq6xnC2cdwuVj+ZLIxdnP5uLe1Oa/b8XDtDI2gBrFk1uh04Wvpk4zwzr?=
 =?iso-8859-1?Q?DRnuvX49X0eZMn+H+zucqN49OVCwi3tTmy4hSWbR0n2GaL9VF/OneXOjpE?=
 =?iso-8859-1?Q?z4XEyY6/3KDS7WnTbbrujwhuAh24iGeaaSc2EQ4kPafZOcHPQmwrnuLCJj?=
 =?iso-8859-1?Q?KOQkrlTB9GcrWVmCXGkNa+s9bRtgiSebhfvtNXJIWnv8fzGAZf5W4pWs4y?=
 =?iso-8859-1?Q?voK+GxaAAxunL6YW/FWt93gNc2e9xamQoY+P/6VRSVMYP1G6Yw6XcwNGD6?=
 =?iso-8859-1?Q?g5H3iF8WEtRT+pFb3Yfzqh+A2ssokF1cyL+mIHZESgdfe2yUUb7WxuFUH4?=
 =?iso-8859-1?Q?o3IS4aItS2cw4JLZCm6KY39OIhHKtGe0b77S+gIp9/iIpKjF/bMki0ii53?=
 =?iso-8859-1?Q?lTJO2aEpjANJQTbFEg8q+jvjYfVLXMsdB2ccNeUkiQ5oqE9W1Ssoj5zIsP?=
 =?iso-8859-1?Q?RbkjKWmuO3mj1tE3SLl4AtKPyWrOquxpwqdCXc4dEYn9HnURpi84sHJgVi?=
 =?iso-8859-1?Q?0apiBMTEZIGHXYVv7lrmUWtS6KEQCRvZYfaomUNdz1kxlmkyGgiv/iXw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b1797f-0774-4f5e-4ac7-08da844fe3a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:26.6600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p+MKN46jr03GGhnuWgLTZ/HwS0+aOV6J0bVGjZCAzHqNNSVmTygrZXjWDdEaEuR053VINtir7dCWb/xcfi1zjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: pKjrp-tNk48Kg5Xe3Z3J9Cb_xLwotcmT
X-Proofpoint-GUID: pKjrp-tNk48Kg5Xe3Z3J9Cb_xLwotcmT
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
