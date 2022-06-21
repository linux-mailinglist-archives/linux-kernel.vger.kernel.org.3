Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A67553BD1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354417AbiFUUrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354344AbiFUUrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:47:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022C62A26F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:21 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ29px004726;
        Tue, 21 Jun 2022 20:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=o+CctwbyCGpfTmEFQjut0n4nUZGxYGzSYN8y9HsINe8=;
 b=Q9uzXuj8IOhg4/gIY5weC50VxtMPucCfB45cZyR3RR3V+2Lipn3z+G0bJ2mdUM8dFAJ8
 UFnFgGd897tAEMS7CocYKg/Yvfb1DF6nPBDsISY2HjGx1qdYasiwSgA25sK+DsfxwMnv
 SkIOi2MuJQtgYFSoA/L4N5LkFUawQpmf0pAjENw5cGgrUQYA50qCRt1OfUEdOwG/7dCe
 1YQ+8aS08nowNA0Pj0jByVsvFTxjoBKrpaaErb7npuwipQiLYmbia3GlSxKRr47eQIx/
 xPC4NBK2ZOuU0eSBbNBRayzWUXaSVVTmk9m2atJHv/04wFjDqwKYLky+dHg9T4zhCZHu cw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54cpnvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKembk037937;
        Tue, 21 Jun 2022 20:47:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtg5us8n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Of0eq/DYL6v0FHlBMZbUBv7OLJTC9DgWsIrcWMBJCp4T+aXRz0KJRj0sggK5aXA2TqmLlEPIrQ3rwK8Xy1mFw+ZMRM1p2OzK14UXw1WKuqwDD5HqhwtZE7tFCZ1WnzMJBBD+Q1yUt87itJL+ypIjkjUexgEH1t1dE8qUbibDnymnqRZSzB4xvMKLtj4h0l1gvQpr7Zk1eBuuqjVTEILHEhE/pPgiZyutZ8Gs2ZmTPwLWVBFpcmtdRvzFYRCzsyajQQ63mOEGC1AVKDaOkvsq4xOk0AqLnOj2/YIDuXoptcO7uK+vbxFwRVOpewiqYTw5SDaHZkmIS4nsoOzFdNHK7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+CctwbyCGpfTmEFQjut0n4nUZGxYGzSYN8y9HsINe8=;
 b=HrunNmiL4lmTpNy07D8RJBE688gZp7jhMjDa4IvzSwthnlm49t2na7R5pFoq4joT5gA+YYY/8qKYvZpuQKDL530JBj/tRpc07QTEEJLkzbuTQkO2cCFEFk8oYIMJtHqhM7VJdeJmFgh28TnU03y0oUboLeXU7Er/Obm8cjPnm75wiumT+xNq0ku+7fhD2F1cjezSaX+HxEpPUlUL6U190uHAi12/8oqTcd8Le0UdBAAEE0sD3BoCEWA7klWkSW9BjOwYe4yFmdFBr6dTTSLhAwSnxa0y5E3kovw6EscVDv0b1zTKVeCGLwCc0GiSADP2t+UGoiXcBjxmZ/172QrYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+CctwbyCGpfTmEFQjut0n4nUZGxYGzSYN8y9HsINe8=;
 b=YgBzoMN0mkfJ32x+FvhcGfqjn2jAwAVizjobjqatYHRyJMHKxraj29KO0P/IAHFvLRQ3SUfOpBtf2lARro0nUo8a+QToEgsYGCMkq4jjhdIXyez4hv90PsxJ505kSZjSO2Xv8eCxqPDd/f7PuOXgwPHu8rtzDzUavdxalFa10IA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3085.namprd10.prod.outlook.com (2603:10b6:805:da::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:00 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:00 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 09/69] mm: add VMA iterator
Thread-Topic: [PATCH v10 09/69] mm: add VMA iterator
Thread-Index: AQHYhbAKusyJX2O8zEyolQwi+YlQ8g==
Date:   Tue, 21 Jun 2022 20:46:54 +0000
Message-ID: <20220621204632.3370049-10-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf3610c4-c116-428f-dbc7-08da53c7304d
x-ms-traffictypediagnostic: SN6PR10MB3085:EE_
x-microsoft-antispam-prvs: <SN6PR10MB30854E84DD80DEF7237FF68BFDB39@SN6PR10MB3085.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jf88bHv/BfCrhbk5zyVhG4CwMDp47UQrULp82BYOapRokGouEpKx+dc/ly/e30iRqjo8f13ZQW1MzqRQfpy9B6UU+mQuaM6g3Lma/iP1QZvW0l0Osvx/0xhMWWoyw6tsvyqoKMBWYl/i43JjG8M2gp8b/yZLYSgeEGaK12wpL1vPfQlVIuOsCeHfoyO1iaFzDL9sKEpJPbVT5/PSMCz7vWccWOy8QI8bzE0TNuRDS5gBWf084tN4YcgSUWVOWYCX0fDI5AQLmiovCLEVQ/cjO2Q0iV0eI5gdToPuhl8+DZnjBXc4huHfqHCa/Ym4wU86LJEqtc/zzXMvtNizxXNQBmdsxcAj6NF26011y6rsJV6pMLWcqgA718DBv5HHYyvAtOF/7TJIt+wq7HP28PfCIhYCkMZw6hdSjSbJxin3TV5FUsdT7uN2KE1Yn1M1lJa2KCEuH/XFnf6iAoCaMrfceQwx6EOa8qjp3BxbS0X0gg7ApmrcU2myDmho8ZwxUoSV4mGYn0IJyQxtbAL+k/Xw/gDIeE/9RDyAxtVo2UoWpqweiDSqz0DUF8WvY+g6HWCY6slsKu9QkHE1WPGPHtbWhuriXOXZr+Oxm/Qt7V+Y8x/x0rcZ8cQWaiTKoz455ihPTY3xblZGE/ozjlBsNOOIqgTIoRBN0UmPM+pAdOsmKtnEScvfmrLgioLPN4k/lDrb1beSfUsspbHFSXWAOBQmzFODlpskvxdbXlPuv5+Y+f3M1g37RNRZGBiEYUZUtR6i7a/iCCAn2vjW8FkW5nCYgDoG+d+HRPViIOTgB2ot3w4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(346002)(136003)(2616005)(66446008)(6486002)(76116006)(66556008)(966005)(36756003)(64756008)(83380400001)(478600001)(66476007)(1076003)(71200400001)(316002)(186003)(44832011)(5660300002)(8676002)(66946007)(6506007)(2906002)(41300700001)(26005)(6666004)(86362001)(91956017)(6512007)(38070700005)(38100700002)(122000001)(110136005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZJN/hkKyn8buhQUi3yqxjmpyD7vHrZbKPjnwba5ATCKFuei8Uy3x6y4MA7?=
 =?iso-8859-1?Q?+j8Ag2uDlff3VexstD4ScOqokRQMynLwtHS7VEmyklpq5AMj+GtwA4XBWr?=
 =?iso-8859-1?Q?gcsfQgKWt/8LCeRDCC8QoyLhSNkCMJpPiG9Yz9VCCNQ210AxL5ypf6agUj?=
 =?iso-8859-1?Q?kzDAkqSO6NXihiV/WF+B34CWqBqJ3Ptp1eN9VMZa7lkDkJwYmnR/20HheM?=
 =?iso-8859-1?Q?u8ChwBeH3O3peQXJNq8zKkLHSphfN/s/TYLZyWQT2YKNfaVlm4Y4XzF98n?=
 =?iso-8859-1?Q?fqq4NeKkz3r+79NCVKObbXrifJesqJvN9zwZD0VwTALgFj6FOLzGg3g4Yr?=
 =?iso-8859-1?Q?H7za5d9VX7eiaUWepAU7razZICIk4t7re5Uv9L7OLADjaSiH3wWsgnDDIe?=
 =?iso-8859-1?Q?hA1wZpQ1ok6amzl5iAY3YgOX+XbZ+BHgZirQ4wSrhFuNKxeGGsc+e0Fhxu?=
 =?iso-8859-1?Q?cWQ/4iwkjxtaL0SOmVJDR5uDYiJHgJIaQVzOlKyd2CdXuDmfE9Zy5e8mX+?=
 =?iso-8859-1?Q?qAaWJS+rpol57vZW+TxSZvT5oCf5u1DbP6n3CkD6bEmksCGmuDc4mwo6BN?=
 =?iso-8859-1?Q?2l1IILMuUQ03hSuW2q8MqMRg5EOe+ZJm23GHcpB8YPe84YeKZfHGOL8Bzo?=
 =?iso-8859-1?Q?xPygdqpGAzX6aSnBA4n5fvW5geNb60BaoQyiZ3d19Ky7A7tYAUIXOgdwaf?=
 =?iso-8859-1?Q?PW+3BR/HVr/ovvS6cvITLIoAQGr8h+ridRsOVtD/IMiO6TWqXTje1Hbw9b?=
 =?iso-8859-1?Q?fNM8Is/QZD4ulwrMQrcW+aa2nZacGuZDyksdX5T9O/vX/r2nT+mYLy7Kvx?=
 =?iso-8859-1?Q?xMbAWYetEdxLGpqFlEu7hFM7XUVP+mEP7wG3hBLuaZiDphz8RxOoE9Uw5g?=
 =?iso-8859-1?Q?PKSN9h0kPtqVQfnSFJn2goBU9rOLkodh7+7A35dGpvBt4AEQkD1qtBh0OC?=
 =?iso-8859-1?Q?fLCamCoT2XbfwpMC5MOiR5PISuZ08C+NBlghDxfhtOQp3f3eIF3+C3fadJ?=
 =?iso-8859-1?Q?Bdh/+gmBQRBQn1Pbqwkyd3zywSByvbnhIVv02MmFSKG57Jux45KKrHG+zy?=
 =?iso-8859-1?Q?nv5lDnHaJgxuGtt1MQH5aUUJ5jTrVHSX9Pl1PL6eLOOh73SLjO2K6SUUF7?=
 =?iso-8859-1?Q?09/oa6iKjDTVFY3ix2UXFFhV3bZ9QD45+DvG2m7hzsyiFPOCik+ZmSTT+N?=
 =?iso-8859-1?Q?1Cffoh3pP3x84AV1xN0YJjvM67Wg06afVF5F1paIxpO8Ddlm1fxB0W/Hj/?=
 =?iso-8859-1?Q?yXFkXJ0TeptKvXlyu/KgdaoBSA/lKL3ShgLSPusj08u++lalxpdw8Idbuv?=
 =?iso-8859-1?Q?iyNgORPEdToQRBBJUDQALV1P2CFSFGa3IU2cpbUHLDDOJlzBBgUw2wZk2n?=
 =?iso-8859-1?Q?WnBHxB01F/AKw1F+mgJ1ar1+wDrrQjwrtapTprcqgwI+O6xz9w3eBOBOZX?=
 =?iso-8859-1?Q?yA7IjdNt2Ner6A5ZGPLGZ1yHM8+iBexSaDSuk3YPqbGzxCrYNvp6vs6NDx?=
 =?iso-8859-1?Q?Z3I9NcSV20n3eTtOJlAVdAomPGZT24dMrtV6d/Lrx8ykTxH5ZTU0+gc0XA?=
 =?iso-8859-1?Q?jPMXbO8Va4Apyv8AgExm2+/WyeGjgf1yN/E0eQ4mjXY/RW/mpSV5hrbDXw?=
 =?iso-8859-1?Q?rg3YEloUxpYuvuWbSNuWUSGFnphNpjgb6YpA4nmCHpy+IpQsAu6jE5BsTm?=
 =?iso-8859-1?Q?1gbMfLHW9uRRN+vSEEGC6nT+uitwlwYdfD0UJhD+fZwu3kxQKVCcm6NEvd?=
 =?iso-8859-1?Q?XvuZrs+dZ0Muq2GCuEZv4v42Be+fIMtYrIK8In1W9jBiiRwOWAHZfo+HNF?=
 =?iso-8859-1?Q?JYE6p+Xyr/8iBfTsQSx6/r3DeUff84Y=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3610c4-c116-428f-dbc7-08da53c7304d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:54.3169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ogunUePoGMxQppUsX5OL7JWy93KtH+pK25Wdr8f7X4KPA0cx4Vv9rxjfloWUliqIhDALlD1tUumSrBArEA/lAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-GUID: LD90blpn6X9jrVc03FhseGK0FP5hbuM9
X-Proofpoint-ORIG-GUID: LD90blpn6X9jrVc03FhseGK0FP5hbuM9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This thin layer of abstraction over the maple tree state is for iterating
over VMAs.  You can go forwards, go backwards or ask where the iterator
is.  Rename the existing vma_next() to __vma_next() -- it will be removed
by the end of this series.

Link: https://lkml.kernel.org/r/20220504010716.661115-11-Liam.Howlett@oracl=
e.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mm.h       | 31 +++++++++++++++++++++++++++++++
 include/linux/mm_types.h | 21 +++++++++++++++++++++
 mm/mmap.c                | 10 +++++-----
 3 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 810b3dd929e4..f22c6f71a18c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -658,6 +658,37 @@ static inline bool vma_is_accessible(struct vm_area_st=
ruct *vma)
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }
=20
+static inline
+struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long ma=
x)
+{
+	return mas_find(&vmi->mas, max);
+}
+
+static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
+{
+	/*
+	 * Uses vma_find() to get the first VMA when the iterator starts.
+	 * Calling mas_next() could skip the first entry.
+	 */
+	return vma_find(vmi, ULONG_MAX);
+}
+
+static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
+{
+	return mas_prev(&vmi->mas, 0);
+}
+
+static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
+{
+	return vmi->mas.index;
+}
+
+#define for_each_vma(vmi, vma)		while ((vma =3D vma_next(&(vmi))) !=3D NUL=
L)
+
+/* The MM code likes to work with exclusive end addresses */
+#define for_each_vma_range(vmi, vma, end)				\
+	while ((vma =3D vma_find(&(vmi), (end) - 1)) !=3D NULL)
+
 #ifdef CONFIG_SHMEM
 /*
  * The vma_is_shmem is not inline because it is used only by slow
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 254c30def2b2..1485a24796be 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -696,6 +696,27 @@ static inline cpumask_t *mm_cpumask(struct mm_struct *=
mm)
 	return (struct cpumask *)&mm->cpu_bitmap;
 }
=20
+struct vma_iterator {
+	struct ma_state mas;
+};
+
+#define VMA_ITERATOR(name, mm, addr) 					\
+	struct vma_iterator name =3D {					\
+		.mas =3D {						\
+			.tree =3D &mm->mm_mt,				\
+			.index =3D addr,					\
+			.node =3D MAS_START,				\
+		},							\
+	}
+
+static inline void vma_iter_init(struct vma_iterator *vmi,
+		struct mm_struct *mm, unsigned long addr)
+{
+	vmi->mas.tree =3D &mm->mm_mt;
+	vmi->mas.index =3D addr;
+	vmi->mas.node =3D MAS_START;
+}
+
 struct mmu_gather;
 extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct=
 *mm);
diff --git a/mm/mmap.c b/mm/mmap.c
index 9c75bd3b78ba..6be7833c781b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -632,7 +632,7 @@ static int find_vma_links(struct mm_struct *mm, unsigne=
d long addr,
 }
=20
 /*
- * vma_next() - Get the next VMA.
+ * __vma_next() - Get the next VMA.
  * @mm: The mm_struct.
  * @vma: The current vma.
  *
@@ -640,7 +640,7 @@ static int find_vma_links(struct mm_struct *mm, unsigne=
d long addr,
  *
  * Returns: The next VMA after @vma.
  */
-static inline struct vm_area_struct *vma_next(struct mm_struct *mm,
+static inline struct vm_area_struct *__vma_next(struct mm_struct *mm,
 					 struct vm_area_struct *vma)
 {
 	if (!vma)
@@ -1333,7 +1333,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
=20
-	next =3D vma_next(mm, prev);
+	next =3D __vma_next(mm, prev);
 	area =3D next;
 	if (area && area->vm_end =3D=3D end)		/* cases 6, 7, 8 */
 		next =3D next->vm_next;
@@ -2881,7 +2881,7 @@ static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long start, unsigned long end)
 {
-	struct vm_area_struct *next =3D vma_next(mm, prev);
+	struct vm_area_struct *next =3D __vma_next(mm, prev);
 	struct mmu_gather tlb;
=20
 	lru_add_drain();
@@ -3086,7 +3086,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 		if (error)
 			goto split_failed;
 	}
-	vma =3D vma_next(mm, prev);
+	vma =3D __vma_next(mm, prev);
=20
 	if (unlikely(uf)) {
 		/*
--=20
2.35.1
