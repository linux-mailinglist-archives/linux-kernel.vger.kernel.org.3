Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041BE4F1746
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355020AbiDDOla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378011AbiDDOjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:39:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72C13FBCF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:32 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DqE3D014702;
        Mon, 4 Apr 2022 14:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sJh7638FhwpfWoUdfE/AW/r18gpg8ccEf9QFvWJBX3c=;
 b=apCfkM+FThzw/alArSNIseCZ/V1xEGTpm8fO4DPI/syM+0wL+Zp6g9YMWGJzWbEPNjf9
 EcqAt5zNAOhqdXzqA+GiHWyRy6cOeMrnxB64lWXJV8c7JaMip2Pgd2FkZZWt9YfvbTET
 9FQ6X8Z47KAFhKvlECdzuXT+pliXUKPdNwY9WwLSt2MkDkktGZOq9NjhA1ZwFm6bvdsa
 BryNlPd8XsbaK6WLznRpx/8DVKq80lY6xfyX9PX9QbkNTQ/fUN5EHNUrUZZ32Izc+2e2
 2/x1BKDuFh/xi8oNrR4M8VyZfuNijF8gFMlSpkQ1yNev79+eLpsTcbuwVab6g/0vRPjY OA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9kbxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGcGG027665;
        Mon, 4 Apr 2022 14:36:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gn5h-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGRBhsyt+ZIJDXk4ucSjtw7IMKhP27cxS1Kw1jQrmuZ/puUkoGUUDs3Y9N6mMuuFvz6nI+Sx+1vgmpiaNIodHLAxgS9FJsRwq9S5pmI7MtTbLtGeAxk5ShmxyqdFF9V0Cqjq/4rqdRb769G3ylAB8Ds7alr9cf83nyQMibi3JnO+HFjCN3WqSl9r/IehJgvVRZ/5rV39x4Do7n+q18duLuGqqXIm33InilffyG9RwwcpvqoZiARwwOt9CbkxO7nly4a4P4sjD49Xwq4aKS8pNGXDypXDut2Ip+cgGOVtOGXKIkwKIWSOA1PtTy42eSgSK0OxrjENnM4ISClqw1q+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJh7638FhwpfWoUdfE/AW/r18gpg8ccEf9QFvWJBX3c=;
 b=Sw982MJnhfvdPBUtynZti+LvMZILIRoqR3KxNKA+PwZHG/LRkHY3UGmHcyuR7ePdFM0hvzQVKEYnOKUT0U6dofA1ywvE5V8vxDZoA8CW+xBIgkrXAkq97dZHoNl+7aW+vgbLxlL9WvealHmbR9Jh7iFPvSngq/rFz02V2KA1pqQUH27FfOxQYFs0HWPmNDVRG61hejZR762eazPynfS94spfJAUZ5DzMaCzdMRgQ/fDc8mT6EP8C0FL0fYHKO+KClWmTK66bHLtnf5PLlLRaErdPeJEp4J0MSq9Uhrn28PSlY0EPcEBlEoP/l+lbiAXym3uV1jNh8MfKr34zESse0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJh7638FhwpfWoUdfE/AW/r18gpg8ccEf9QFvWJBX3c=;
 b=gyGBaGeYq4mligpCcpu9Ic0zb8WHdGNEvFRNrPUbqzixQoQutKxVjS3PM1bGv+gt11r1P2eLLkCdb7SqWar8e3r7dOL/CEsKzXskgv4ep3eQ3sif4MZ0MN9IGENKBFsw/Ut7hPLN86LzDGesOrHjxEGsoUKrGJMOUzC6btBKxSw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1381.namprd10.prod.outlook.com (2603:10b6:903:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:23 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 39/70] optee: Remove vma linked list walk
Thread-Topic: [PATCH v7 39/70] optee: Remove vma linked list walk
Thread-Index: AQHYSDFGjBYy3WA860iunMxtMCXN9w==
Date:   Mon, 4 Apr 2022 14:35:48 +0000
Message-ID: <20220404143501.2016403-40-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3449f8ba-7f6c-45f6-04b7-08da16487dd3
x-ms-traffictypediagnostic: CY4PR10MB1381:EE_
x-microsoft-antispam-prvs: <CY4PR10MB13818A5431AE0CBE52D0C80DFDE59@CY4PR10MB1381.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e4OBkZYKmQPvbooFQmKJE1QFksoHlDDmCMuvVtNXbs5eYlpgSPpr4HpHp+Ym0i4r4HSMqSHG0jUZFNDixw059//+iVg9UYClWA2B6AiWaQ5xGZsMBtosB4CiVS7jIGwfBrbrcvTxpGcsQSjjKFStSbWcQF3SahmgS83YUAC1VexqBTi73OZl9J9VyQkl6MT4kkRoe5L9r/p6PXiB9fBm65j2wkB8fHVUaXqoVxOz8Mvvxy44Gv3Riw6xO0/Er5gB2mb0UxCRZIwWpTB0HwQfdNwmnYOHSgsRUsejkbJo1A1x8z71CJ//80vF65VhqHrBzba87NBrwVyeLnnjF3SGoOgUi/bGQwb9BpmzU2gqCIoH6eHkNsilShKrcAGD3TZvbYLbdDLqQtb5TTLu9xnD3HeL9o8hLzsrDkZzbQCXU6s9mFQNbZ+IUZBPGV/V5kVL6NVZ/MePznMreV95tfWcQ8CqSRs/WNlcOCbpBsb5yIltwDibXmZup0swbu5rQ1Cgkw6XSnMb+P/5lhFMBt4SZZ+qCe7HJPPROCRUN0Ep5XoX77NvQWXcCANpdCfqEStKDxVedYZy69RREn2gJvkpd82l7aOytrAFdBSAHj0592DyRrA8TVkEwT94tmgK0ug4nZB3fc0BeLAKhQnjOW5nv97k0BxM8fGWGsF1tR81xTOSxcWmGNC1Js/EiNDDR5/yxGiBez1Ehr4VSmDL48vJeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(6506007)(6666004)(2906002)(66446008)(66946007)(110136005)(66556008)(66476007)(36756003)(8676002)(76116006)(91956017)(64756008)(6512007)(316002)(71200400001)(5660300002)(2616005)(38070700005)(38100700002)(1076003)(83380400001)(186003)(508600001)(26005)(8936002)(86362001)(6486002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?voq9AVulUh9GqjWC5PKktPrq9OAls368V9MngOjlIbJsXnSfCnnMQbOeN9?=
 =?iso-8859-1?Q?ilusITHSoE3sgeX/7oxTV46vzgJzO6R4Rp8hg+QiHYHmaCUnI0xMAAgBTP?=
 =?iso-8859-1?Q?gStdrtl1pebCxLM1oRHqcJL7PG5T33lRf/psB18BWhYbcMlhpK1iosVrJ+?=
 =?iso-8859-1?Q?EZqNs2xFvg0qlhwkr+gzZTjAGqhROy/gAOPpORf6GXMRN+2C2JHtQj9QyC?=
 =?iso-8859-1?Q?b7EObVPN0Ww0Yro5NonncfZsQtKJ2hXfi00sg907YgGdX7bz0AuGCiGhNw?=
 =?iso-8859-1?Q?Pyf8ND63BmkEQRJvI766Sa7z4XoGxqAaKk2ECi5+JmJRDEbxVujzwJbk3p?=
 =?iso-8859-1?Q?PaOIgYjMLk9y1+DyuqbciNc2B6mPJ1JzofrKbJEb96EXSdxv/97NPDC3VZ?=
 =?iso-8859-1?Q?QGbjNeF+gMis0RkmFcQnfQYa+zuBIV2cILzXXtnXCKU6uFpl5bEV3rrUMb?=
 =?iso-8859-1?Q?Hm4JThfM4d8TxuwOfo8XPoP0nSXpAJyZXPleQy17qSbuLOVUuuHi7l8kM9?=
 =?iso-8859-1?Q?6vVpd/EMlSfs0ExlfoYXpcontg0CHLkOwp2hN9Vd3yCYYVbv4rR79YuZnM?=
 =?iso-8859-1?Q?GexQCPWz8L7zGZeiBgH09IQnkgV9vX+U4Mc2mdPXOkKOw9/5HyJXHzyfRc?=
 =?iso-8859-1?Q?crVLiOZ6LCNOXIra8RN8LTzeuRU5N/LPuImsvY1WA2MNRcTL9+Sh0terki?=
 =?iso-8859-1?Q?DZj7S1vqI7sAfrA4hDtGYKcFTqI05oJBzLps1LK6qdLzLHYli1lY2evWu0?=
 =?iso-8859-1?Q?GXaVXs5wN65ZLBZefLKyGraf59p3sFx9xyoAQ0IwI0UxpsZNjg18O2nRY3?=
 =?iso-8859-1?Q?LV0J04plXpL79PhV//nN1YFfFr1nKr+9v/R+5OSDlpp2zFJnXUtC+DayEm?=
 =?iso-8859-1?Q?+20jE62+W8XhRWILr7R7ZVu9Nw8sjuIuYLKZXu0lNQpFLsUOmPN8lfi4cg?=
 =?iso-8859-1?Q?CfaVJk6IrIxM8hiNV045qgNmcemUmDAmbRtQxpM8ExZSPk1lDhLIAbDuWt?=
 =?iso-8859-1?Q?YfGMdiaQA8ZhmKv+coebmno400LinXT+OKupdKmqfGI2lPeoEv7XWd4b8J?=
 =?iso-8859-1?Q?0jcP0aE/8B4pMPXyuZ0flHY7gXK4+BTdHEXnb3ZTp6u3K0YvovGdoZKXTr?=
 =?iso-8859-1?Q?BTy4Ft11iH2GTV9Jn8E972LvN0Qua57XnRlgaPaUbJfqoM7Obpmt0cmk5Q?=
 =?iso-8859-1?Q?9BnysC7y1ZM9CPDUzWZzcSLkcUQEhk8LBgmTiY480N9xCCt2tZhCRVO/Kp?=
 =?iso-8859-1?Q?gmP7WBsae0p1T2Q+UBK8KKGsx5jH/Puv/TpC6CWmDJCn2u2puWE54fnW4V?=
 =?iso-8859-1?Q?4B2ES1N/6Edq7uzdTfs/LlzuKzrpCgf0QqEYVK0Kjpw23YPNPRnvTknKCQ?=
 =?iso-8859-1?Q?JvBONLSB/nfEAyJOCWdfdv1mg5nL8KsCIWO3Uoib1pg1s0J5GeGVP01dq5?=
 =?iso-8859-1?Q?FNNlrnp3xbolx1n+5XVjTEpGu+3s6/uGOl75Z5NhsXzPmrYobmwkGn0GhM?=
 =?iso-8859-1?Q?Irl0i8ZnxOZtzqueoNND8XYBpZPaRmVhPvCBYK+aEdwM2y1dhpQo/AasEx?=
 =?iso-8859-1?Q?dDlI8LJ6xnbUlKkyg0ABI/yFdvBWDwUg4ITnmemOJ/Pk0MQJo/rnFWLAPk?=
 =?iso-8859-1?Q?IWNV52Rj7uAN5/8Tocol1hxo3sWCpssgv5DOHWp6U9Wu2vxazpglEy10JU?=
 =?iso-8859-1?Q?3BeEHuPqBqVedB7HHRf0XuVuyYi3E2FQ5g+VN12yHMY8qKGNMqJBHA+JGL?=
 =?iso-8859-1?Q?eRPONuCfE+hL+M5F+lv6hjp9K4QT0ZayATJwMR+awbnliEF5MDI5grm0LA?=
 =?iso-8859-1?Q?fljc7qUu0cuOGnnKcOGAL8yIXbSoKlM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3449f8ba-7f6c-45f6-04b7-08da16487dd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:48.5026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CI0wu490NGiEV275BNsZeqhzWgbN9vVygRXuU1mQ570nNycyeCoRELWY46ah9HuWjZIByZljv1HSw6aQ2trLCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1381
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-GUID: a0p_sVOoU2Z1sSungpMlekaINSRLCZpp
X-Proofpoint-ORIG-GUID: a0p_sVOoU2Z1sSungpMlekaINSRLCZpp
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

Use the VMA iterator instead.  Change the calling convention of
__check_mem_type() to pass in the mm instead of the first vma in the
range.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/tee/optee/call.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index bd49ec934060..d8115dcae6e7 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -342,15 +342,18 @@ static bool is_normal_memory(pgprot_t p)
 #endif
 }
=20
-static int __check_mem_type(struct vm_area_struct *vma, unsigned long end)
+static int __check_mem_type(struct mm_struct *mm, unsigned long start,
+				unsigned long end)
 {
-	while (vma && is_normal_memory(vma->vm_page_prot)) {
-		if (vma->vm_end >=3D end)
-			return 0;
-		vma =3D vma->vm_next;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, start);
+
+	for_each_vma_range(vmi, vma, end) {
+		if (!is_normal_memory(vma->vm_page_prot))
+			return -EINVAL;
 	}
=20
-	return -EINVAL;
+	return 0;
 }
=20
 int optee_check_mem_type(unsigned long start, size_t num_pages)
@@ -366,8 +369,7 @@ int optee_check_mem_type(unsigned long start, size_t nu=
m_pages)
 		return 0;
=20
 	mmap_read_lock(mm);
-	rc =3D __check_mem_type(find_vma(mm, start),
-			      start + num_pages * PAGE_SIZE);
+	rc =3D __check_mem_type(mm, start, start + num_pages * PAGE_SIZE);
 	mmap_read_unlock(mm);
=20
 	return rc;
--=20
2.34.1
