Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F024F176D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378058AbiDDOpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378173AbiDDOmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:42:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB6AD54
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:37:12 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Dr7fa012451;
        Mon, 4 Apr 2022 14:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2g34oeaEstuR6k1KnVWoqEnaAj9qxbo8IU7t0rZ31aw=;
 b=09X3PHNPSKqCTgGi3LufImwxuRh5zVffa0L74zvTXjR4T0L1vSGw6AsQLNsvchuMlnfR
 MaK1P2vzWuChX/IRjglwY3nVnqkPa/Iaxp1fuqzDM7YKDyEmeRJKfxPFQFbqGNeuq+rO
 PLNx0k0FiChgYF7St7QfCDy+34kTAzzI2h6wp0YwHw9oW3SE9+UI9jQOeAotbJVwe3yN
 dQEZ6ACn9x08gVQ7xOFv6SCSLNlqSQlHCBxN6kEZix2p7EC2rs3upSf98IFCQ9TYGEci
 cCwFRMyTg1ZZALLXAi1xZQC2MyZLazt5BgXCoKAC1ultUxmfPcIsiAJolTeLPt6GrDEJ zA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcbbrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:37:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EajoV011889;
        Mon, 4 Apr 2022 14:37:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gw9p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:37:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqgsHxVqsWCs6qF/jwQCu6gTeSZxNLTgDLwDfk9GBwgJft/G5snppkkpk6kBhoXw4fgwk7kUuanvOeL7FfBT7mPWeO2jobSWl+2DRNxIQtXGDYWIrjpma4E0jdksp4hbssKS5pvpxZuTPg+LTC4tYrnHzf2JYHlQPqsDDx/Mt7ah8poxMyXuHuxCqiapnQSV4nfI1w8im2Fk2odEIPHYumU8JJZc0Hgz+oRtEPEm2PdfBUuVp4a1BtfKGfwb3cxMTPv73sJGM8NrobWkVzeqmAMu/weOzK/Ghn7ouw4TWLTb9aSfC66vDU8IOqRseDH9CfY5vXIA8l+rKBgNTxsULA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2g34oeaEstuR6k1KnVWoqEnaAj9qxbo8IU7t0rZ31aw=;
 b=BAPrrs+9UyF3LrCRThqMVtEMOwx8zIVx+K473fIkdOHQFbZgFpCTuQV8/XkJP2xQ+86j05FZjBdntpUBIEuh4vilmjzCeqfrEI9ZhWxC1GP3i2c2lJoxKym1ZyCB9eQUgkw1xkBWyymVcZ1moGM5J/6gMGxqvfPGw56R31EF/F4Fj43XBk29l5gyazWXOY16aaf3LUUt6xCPXQAbTVjR6tRhns0HpC1V0jp5ejAm3PQf/s4sW4qLxYVDqTm/SXmxPSYT1Llp3hF9ujpJMbfF2jbExlrrjOrZbPU7TdUSCDZsw31M7BSdGva41AJS9oxHZJYCKs13niVVTwkBpuO4gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2g34oeaEstuR6k1KnVWoqEnaAj9qxbo8IU7t0rZ31aw=;
 b=jO0XwG+7n5gCW9qS9D/ZoP2pI6BIMq/4jhZu9itRGwh06jBd6MhVqEmlsAV+3NMYsSvOl+SjOKIVZX6GcwzQamh21ivVfUZ/032bClZBuSc5EBRhmhDoGh0in2nROvtphlV8a8EKbjs4hASbS4gCPpNucsT0h9qsOKkTjqNAYt0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5742.namprd10.prod.outlook.com (2603:10b6:a03:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:37:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:37:04 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 61/70] mm/msync: Use vma_find() instead of vma linked list
Thread-Topic: [PATCH v7 61/70] mm/msync: Use vma_find() instead of vma linked
 list
Thread-Index: AQHYSDFLpnm0vaD+3EGpgwhUWxMpPQ==
Date:   Mon, 4 Apr 2022 14:35:56 +0000
Message-ID: <20220404143501.2016403-62-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88e51bc4-55fa-4765-5d81-08da164896b0
x-ms-traffictypediagnostic: SJ0PR10MB5742:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB574219E1FC5F6D4B01D788A0FDE59@SJ0PR10MB5742.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lyMeVTztvvdTG5w2wMmBWDz34KFF6mhso6J+CgFcJHw6StM9OoK0ObIn3bf8WH171EqJ4ju85Yto90nGxGL4RIuhgfZYX29ea8IT0ghLaVwLIE4JT7JE0ajX9g2Nb3tNpFFRaEgy3qq4SKf5eTTI9s7v4nHIG7JvDa20Zmsu4+MLIGYHWOGrALpuVXHKZyTWjDnshPkbX/KDzo+kg5W7jHl1W/VGMYTsQdo/6YUGvmWg62rtSfl2G32cNr9+hTyAfGUbZW+Q2wxI4XTrmJ5jAzpzi9NkSUhlnPv2ly+VSCnmsJIFcqcsTTysAG42f5mtC1nfWdwqSuegpv6ogLiuQ8LhoSNKi527OtYmifBL5DQKAiBfaKZPCRu0a2MUfCBEDCNnuDOBUVcwiLFrVPQASM+N+oVpYQDJVHW37hcKovroRuLdNma6BpGncK83uORSZTVk33yHszlDM+2a/eyrIbdxGbvN1rRjFHGAPrfr1YsIMI2aeMuE6D+LngCs8EXHEQ50s5JcmjAWPXSxMG1cgRUNDMQO9qxPvm2sJ/vPJZqmPMtewyCf1H6GeJiKg6ydw7ylN2QJZdd9Ykzp61Yh/ybs7kARrWYt3HeEInFI+LWnJKfOFGlCKf4VGqx5uhDUCWllBg3AFd6/nJjQoZWKVsfKMCoxklYFIHL/sZxJlvH9o1DNlaFTc+Tm6JfCQ7+8UYn1myXw/YUkyNCKTvFjug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(122000001)(2906002)(44832011)(71200400001)(83380400001)(5660300002)(64756008)(66476007)(186003)(38070700005)(4744005)(8936002)(316002)(1076003)(38100700002)(36756003)(2616005)(110136005)(66556008)(66446008)(86362001)(6506007)(91956017)(6512007)(508600001)(6486002)(8676002)(66946007)(76116006)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?teHo0frH3VeEntfFSkWCW3k61kHdUdRV+Y1Zu+zOftDB6VcwA47Ykaf2sV?=
 =?iso-8859-1?Q?7EAPU0s7OG9KWQaFWA4zIBEb9KpXUL83/D/My4PdbCGIcjFILrdsaKbeoc?=
 =?iso-8859-1?Q?hMOOvt5gQqQqnTjF3NQMxcupoO1w4RmCkzye/iGAZULg8rDhfpTw/ejvnn?=
 =?iso-8859-1?Q?Yv9ocbPqTm0payVqGgVGewhdlkjzcK+NUQtbTZEw7tMJ2AD8tZhWXOj7wk?=
 =?iso-8859-1?Q?kE6O3bI7ceUDYPzEi2YxVjHvyGQcjrDblrwM/JN4NZM8tknQDgVxV3HR65?=
 =?iso-8859-1?Q?zPbHvbj3ry7+QfztXNezHng6NiRy4KrhAD1xXE4ky5IGFzHcMAErEhl1mF?=
 =?iso-8859-1?Q?TNl5kj6k5NihYGzGCmfqnq++4YeGXN4hwzhvqPIDcKWMcetFtBsPMfr95U?=
 =?iso-8859-1?Q?J4WNOKLOCC4hawGx3kQVslwosCLchcQfzlg8oOcjyvVZxP6FQyJfDJq0rJ?=
 =?iso-8859-1?Q?91iDYxCXSFgE8t6acTqvfV1Gkp8IUPcP3XesGCGOrxbL3EgzyVzG2iPqoe?=
 =?iso-8859-1?Q?OwOD32F4y8SSvEswL38WMRbfCyRJ1evCb/D8SdIoFLGQNl0BF7+kRPFBKP?=
 =?iso-8859-1?Q?8okdg6wXLbDp7ATiKyWFCel7HCWyiRYJ+ZENNzrVwtY7XvxqzfX7ef1fTu?=
 =?iso-8859-1?Q?8+whPqAvWtW3xtf/tVfvtUxMBXwlAY+A0FVYiTopFp/VFwRklSd03GKkw8?=
 =?iso-8859-1?Q?HBptJ82zgMD4LYvOoKvIM2uksaDckblTWQjYjXCnj5+J21RAAJJZvy/Krx?=
 =?iso-8859-1?Q?tRXzEiyRBU4GqMitUQRX9MlJCHRBb0pthIojgPJKUQ/io5KoAnDXxovtFc?=
 =?iso-8859-1?Q?J3xj+j1HKE9bllqwPgYm2kLvP4liue6zIYy0FZIQSRXqUzO+P6RIa9lnky?=
 =?iso-8859-1?Q?zOidypJepsBeZbgKOqUuqsK/qPaPtjX1FuE9DJnFTDAhD3+UdhaYUFKZx9?=
 =?iso-8859-1?Q?9jJsQdSqheyQns0zafLG+varFtolEkjqXz/WrMBHCpRdFukzXNLgSjOGuU?=
 =?iso-8859-1?Q?Z+H1+ye9mk2GYom89niD2R6G5ROa7DVU1RjqBtgqsS5G2pTnSICbPUET8V?=
 =?iso-8859-1?Q?7RqlUMKavbC+FsgiDaEqvyAMEvSo2Vc4BeN+8pmGBAWc4jVhll2Il5JX24?=
 =?iso-8859-1?Q?aumbu27JHaEsPunMy1QxjuKGGXqhVf6dGa+ryQ02mE4bvPOPY5UWcHbsx4?=
 =?iso-8859-1?Q?7Xdd49E1HMhL9TuwJ3uC/gZL5eD4fwhT6crpXCCqgbPsFy6KOFFxhrVQlo?=
 =?iso-8859-1?Q?lgdGS9FZ8/z4wIetWWhlD0jWy1BOV9h3RP6x6RCquT2OJGb2xJBFLRU5Cc?=
 =?iso-8859-1?Q?ROG7gdJgLWrQ7V+vTEBrf5plLObgkuAkj3yC9WXowPFHDdKSiratrD7udk?=
 =?iso-8859-1?Q?rN6FYoVV6Yee8Tjf9sRecOYA5EUTUmgiyBaIhuCmTLnJCrlx3AI6yB15JT?=
 =?iso-8859-1?Q?/Hf17wqs597kyamOxisKtS+nDObdBTXgb+Hbf2DIQJYALsBpeZiYrqnDNR?=
 =?iso-8859-1?Q?rkWiFKJ8fUgEO3rgg6hWVGCJJrmeKB8UobVJV2gLIE7ufQycFX9LVY3Fsb?=
 =?iso-8859-1?Q?7SzJjCtya2FFtuKTwGC49Nttj627duPSSgHVvF0I+Xs3+IP6khWFkxzT2w?=
 =?iso-8859-1?Q?tXhpmXfBpjw7JXwGjBfQGRE8luaWDp/unP3rmaAHu/MTGp3SA02cn6SL8D?=
 =?iso-8859-1?Q?gyicko4DX59NU78ufaKDby0fdF2ZawRtgp6i+Nt9LD8pgWEq7uAaXJ7qAb?=
 =?iso-8859-1?Q?ihmRaeR5c86Ut51YP2ZaAJUXRIi9ALh7Vq6yEBsBOgNZH2Gvd93l8Z8MGv?=
 =?iso-8859-1?Q?QvYIrJsll3DO9EfqGtKsbZ44bxlop/E=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e51bc4-55fa-4765-5d81-08da164896b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:56.4239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chHZstWkm6ryxpyhRlvL5Tj9Ls5ig2G7/V/O+cUPfPFHp0K+L2tM658rYUCCOyrOpYXd/bLkK5an+f8kzj0IuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5742
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=926 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040083
X-Proofpoint-ORIG-GUID: b67euopZ7VyNlQsVc7_nzN5ysklftAef
X-Proofpoint-GUID: b67euopZ7VyNlQsVc7_nzN5ysklftAef
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/msync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/msync.c b/mm/msync.c
index 137d1c104f3e..ac4c9bfea2e7 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -104,7 +104,7 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, le=
n, int, flags)
 				error =3D 0;
 				goto out_unlock;
 			}
-			vma =3D vma->vm_next;
+			vma =3D find_vma(mm, vma->vm_end);
 		}
 	}
 out_unlock:
--=20
2.34.1
