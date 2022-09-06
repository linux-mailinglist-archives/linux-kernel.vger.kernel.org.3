Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9665AF4FD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiIFTyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiIFTuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B5916582
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:08 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdAj0024665;
        Tue, 6 Sep 2022 19:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jg3jpUDWP7p+DfJZup33xItX8j5cXBltKfOlfDzCvvg=;
 b=DBNsdS/XZmm5vV6vFYh2Pr/LDu3rLAQO5Qxedtffbtp4zRbmCLl9BOUI0xfUKnVESsQ5
 RDxKkluoqBdsoMfcZMPJcv16HKPKDSLkc9LDiJnZHdwtXs9TvazBEvTOX1hxbYhktSlZ
 Sl0O9pU98VF6j3BgycMZfyc2biKWLFoU9vBHHiZ2AtyxOAiVzRtEXv1YqDbMwZjSkdpC
 QV9fPprQIxZgzxB6GnPLJscZnb2Nkab9+Vy/q35k0+b2aeyTFhR2/qh83IA5iRfrrstB
 BuS7V/RcsinLrB9HnFeySn4G0VjClem8Lh5c4mmYFGDB/KGIE0y6jukfMCS9ocZDr6t9 7w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxtaet86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286HF67V031251;
        Tue, 6 Sep 2022 19:49:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3ahkd-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRHRoqzobqVbqVH3XmX9ErxRu0SMy/+HYkh0T5tXcbZIBJ0amtIMmfrAGmXIc3iWJkIfd13yrx/8VqFQPusODOFpgBxebP9l8Rcb4q/tUZQMplQfR/xXELAZjXpWh/G/V1oMJZ62CB9c+HWON2vsoz6poRQaQsA5YLl7cLYIyvJHXEcRBhL7w6AvHXVBexMywGbPvO6uQlhQx8j6zY6tOIP2xB+HKgql3uH1AgbrElhLiipjqcHRC5zYVodNW+ALfJvL9dMhthaN1/JpU91oiionsaV7kadlOsMwr/Exh7Z7eumWc46SW+X3kazay12Z20ZEdRLGaIUv9pc/1fDQhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jg3jpUDWP7p+DfJZup33xItX8j5cXBltKfOlfDzCvvg=;
 b=QaLyBiznIzT1pYuBZAeXIYkF1UwfW+FcsDDtny7tdc16T6uSGwRejmQ1HaQSpFHR/5Cc1WJTO+G6GaOCZje+jRJOV8xjx1fVSOzzFdHz3WaPx0rxTDBeL9aMws12zi1206Iz8wvdG20PhPqSRGCazxE4nJspsyw4VcaHR5UcB6mpDRJA92T4yp0hIbFFch7tdd3ZdpLMsDZBTX4gdQ8qjbGeXujMGhEp6qMbMGCvgrLEh11i0r55IC0kBrZxPLsfu4B1mZgyEBsr6QzIQiacOGkgdykeLsk04sM7/Q95mEBgDVfujMvDzml3ANl2uBMQ/rYYjyhxjJbHNNMp5j3cjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg3jpUDWP7p+DfJZup33xItX8j5cXBltKfOlfDzCvvg=;
 b=v6ZTwXcWHMdIJ6TZwihUuJaBlgXhROceW606Of2COnPfL+G4fZi2807nKNVcNsvzCuoWLXR1BxNGATmFyGfWVwW8/iJwtDdbZXQSBLEzYft3M4n/zUVIDjdvQsob/X/RpyrxQC5NVCPRVmCtLJf6V7nhZg5yjSW/IcTiw+61sV0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4876.namprd10.prod.outlook.com (2603:10b6:610:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Tue, 6 Sep
 2022 19:49:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:48 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v14 56/70] mm/mempolicy: use vma iterator & maple state
 instead of vma linked list
Thread-Topic: [PATCH v14 56/70] mm/mempolicy: use vma iterator & maple state
 instead of vma linked list
Thread-Index: AQHYwim2pgnyERntuUivGTGg8vqDrw==
Date:   Tue, 6 Sep 2022 19:49:02 +0000
Message-ID: <20220906194824.2110408-57-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0a00139-7cf7-4786-2837-08da9040f49c
x-ms-traffictypediagnostic: CH0PR10MB4876:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aUUHLm2Wm5jjjVuD2XNtDz3Stioomr1+a4ozNGRmtQRpF+cwBPbG8Bu0uQtrJbelTasmg5ef9x/OTFZzdyyGeek7CDrxpC3fejoYY3n3eoIBpsBZC68IWt7m5XqmxZ5fd9zWwTRQSijWexRQFITjx3Nz/VE149kSq6MiTg6CPxq2tKByWBz68GV5t/BpfgLFUx+FcCmKz1bgV6HNjrX362j7SRpkZlqLvum7DKjU4EEiCLD6SIC5SmO7dT+PMYtz48i5A4l8XVJe4MyFq0a3EYgGh+yM/ci2B0lEXicn5IshA8gIIZ+DK1IbxP+/rbuXT0vWKOC93Km0/xLCDy768CR/jfvQN/EqT7mi8JMJO+rJMeYfoq03rHbHe+8ZgGYS5WZZ/8zFKStONtBTcOJ9w1UWvPNCBp9HIwn5vs0MzznIkOv7uC024+HMGBsKjF9YQ7/FBwq9eHPcTFxKCIl/mJr0BWGaeYjxNYlpOo3ccyEl+yQ1QkGHU3KtirKVGDn369Uk/br61xvU0ir0vzwSepuCxYt4ok2w4+TSrOt0VBOlTS4rzfXTPdO+fdiGVWlI3f/o4wq436W2Zw4QFhErG0pqyHNIIJuyxNT+gPmHFZHTDiaEH2uwBlyF0wYCzC7WieDw8w3LxHTSzbaY3KYrQyH4/BsTiN7pq2KrcNTFe8SKWxuieNB6hmbyTREmO8TB5l5EVamYQ2Ms91et6tjMIhiyhZCe4hW6y7P8ALaSqkYzXYf450bCMj9VIqNwX3u/hcELKYxRQwKKgk+yKExmmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(376002)(396003)(346002)(8936002)(6486002)(8676002)(4326008)(91956017)(122000001)(66946007)(66446008)(186003)(66476007)(76116006)(64756008)(66556008)(2616005)(38100700002)(38070700005)(478600001)(83380400001)(36756003)(1076003)(5660300002)(41300700001)(71200400001)(6666004)(44832011)(26005)(6506007)(54906003)(316002)(86362001)(2906002)(110136005)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?beKnQqaaIWRDksaTGixwkhMGXNDDTQ/E1kfPR31z0FwZji+4B6Com1TfhG?=
 =?iso-8859-1?Q?hYxfHVQcQLMYtFmV/fACkMSp5RiB6UL4L0xO+sDad2FPJXdcCV7XkZA6L6?=
 =?iso-8859-1?Q?/FiyNOOX4a5l+FFxKM6uQYDi3HbPmmt5Oy1/LVazc4w5bBeV9Wf3hk0aae?=
 =?iso-8859-1?Q?w481CdCpz+mclSm0ORch1aH604jvqSlnk+F/3+gQ75NamMcokoSduHhu+K?=
 =?iso-8859-1?Q?ubkFkxputWLZ5SSC8Xl3Qmpvomk0ZQNfrXSJ0HL6PN9VWAGGpE1EJ8eWLZ?=
 =?iso-8859-1?Q?Y/gyqhKjCuHdv1a/LERUQZU5M4G5fvAistVFBBZrjiqGbtKuTsjDvVPH5w?=
 =?iso-8859-1?Q?qMx/2TX3g0Q1KJY5Af4wnLITsPsvvfC1kxkRP18MbMUzmpGgKugWKU5kKj?=
 =?iso-8859-1?Q?wTpjUoP3qOPH38zLiobHVsmdwAx3t9eSIOIGh7bLEIwJuR9DUw1Vf9+pwB?=
 =?iso-8859-1?Q?1BioWKJHHDoIgyJ7FVbzT6iiTi7PTUtKh5kC1NIYad2IjaY4q2g6sSgIWA?=
 =?iso-8859-1?Q?Nr2YNyleCTHkZtvw3cbh1XEnpAw3FDicGgvlnXZUh6Te20hnPB5GxMe0+p?=
 =?iso-8859-1?Q?UTDxYA7ENo8Eh5s+haT83X4bY2HMu34K37koEtlJX4ET2UEcOhV2/jukJo?=
 =?iso-8859-1?Q?kfENC124/eMSKpZ1UZA8UjZ4SSE8J7mhkYPiPlKVQz2z920O3wNxLxIu6/?=
 =?iso-8859-1?Q?H9WoVH4rO/2vodHzKsMo+X9Tm9ls1XmsXUTJDXT+RuG3o855pY2pWFwjIO?=
 =?iso-8859-1?Q?L3IUJI0RaVwPxnNrAY32A4skk3qx6Wvafh8ZXqF6rrE6+RdSGWvhorkPzj?=
 =?iso-8859-1?Q?ODB4/41kul2SS46FOMfhk06hDnPqnSfXOnefHsp0GCKPwQzYSt6318Mlr7?=
 =?iso-8859-1?Q?UlST4F0u0ik27SenEhLRirKZcJ64e+KGXmezQWx/83xO4PVWDyqpoRYOwz?=
 =?iso-8859-1?Q?mXbrhWWQnYrNP8vHC9nb+31U7oEwIyjx+nL1og3w0P6Go+ykUUYFXORY/m?=
 =?iso-8859-1?Q?g3eD8sHrmIDGSFrWUeNMuEOASq+6W2LcxwumbqjmgMYNNhBC9ZAWyfqY3W?=
 =?iso-8859-1?Q?u7kyP3MsRrEN0AHY9vU9OmZHdYUfin8ymWH0wrSP6wDbQLXmgA/vpHTv3F?=
 =?iso-8859-1?Q?WUbNBYueQxYWy5E2qKbarhUiMjimGzDJrjc1EH6PurqoJJLrnCZVoCqaMU?=
 =?iso-8859-1?Q?27BklxMn8sqR7qvzK4lvgUJYBohbevXt9QlKgA4+R7gIuL8EqOTFd3S+lu?=
 =?iso-8859-1?Q?5oVr0hsBSAU3wTg6tQE7BUCRu32nKfJ6gAF6jC8AP6tUJot+kHOoj6QtjX?=
 =?iso-8859-1?Q?YvIsDMTkFw1kE1+wjERQSOPA724+dbQwKwSDEjO83TJo0/6H+3cjmX0WjD?=
 =?iso-8859-1?Q?49sJY8KDuYflheIP4iyomGqfa698p/rEvdf97zHI56YQJtmIy/FGO+RRm2?=
 =?iso-8859-1?Q?/CLyt6nfdq2+YKe19PF5VE3Hz69rznRF8gMQ3pRdNArbkAqHA7VCJFF7Jq?=
 =?iso-8859-1?Q?10FqvdF7Qck+u7Be38pgX3eAHmJP7as/lTb2Zap7/vgTCRyXijWvuMwIvg?=
 =?iso-8859-1?Q?L/G6i9QQlQdlKQQ/c8Xuga7t4XIQvlEBykp8AElr0h+gFFhemtt5DBMi0K?=
 =?iso-8859-1?Q?hi82xf64fZoEsk7Naoq2yIS3TQceqCqRsnBcMU4I7ambr3H4uHErPyJg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a00139-7cf7-4786-2837-08da9040f49c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:49:02.0996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N327zZCp+EyWOyH2zi6cORqCKlJ/ijUCMCtHep2+Q6W2oM3f+hubBpHuML09xf0K1SVYK+XYFBjzN4e6BZK0tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: uukhuLO4ExLJERieYxiw3fB6ZEwBUyfN
X-Proofpoint-GUID: uukhuLO4ExLJERieYxiw3fB6ZEwBUyfN
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

Reworked the way mbind_range() finds the first VMA to reuse the maple
state and limit the number of tree walks needed.

Note, this drops the VM_BUG_ON(!vma) call, which would catch a start
address higher than the last VMA.  The code was written in a way that
allowed no VMA updates to occur and still return success.  There should be
no functional change to this scenario with the new code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/mempolicy.c | 56 ++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a88fd94e18d6..143e2eaaa6ec 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -381,9 +381,10 @@ void mpol_rebind_task(struct task_struct *tsk, const n=
odemask_t *new)
 void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_write_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		mpol_rebind_policy(vma->vm_policy, new);
 	mmap_write_unlock(mm);
 }
@@ -654,7 +655,7 @@ static unsigned long change_prot_numa(struct vm_area_st=
ruct *vma,
 static int queue_pages_test_walk(unsigned long start, unsigned long end,
 				struct mm_walk *walk)
 {
-	struct vm_area_struct *vma =3D walk->vma;
+	struct vm_area_struct *next, *vma =3D walk->vma;
 	struct queue_pages *qp =3D walk->private;
 	unsigned long endvma =3D vma->vm_end;
 	unsigned long flags =3D qp->flags;
@@ -669,9 +670,10 @@ static int queue_pages_test_walk(unsigned long start, =
unsigned long end,
 			/* hole at head side of range */
 			return -EFAULT;
 	}
+	next =3D find_vma(vma->vm_mm, vma->vm_end);
 	if (!(flags & MPOL_MF_DISCONTIG_OK) &&
 		((vma->vm_end < qp->end) &&
-		(!vma->vm_next || vma->vm_end < vma->vm_next->vm_start)))
+		(!next || vma->vm_end < next->vm_start)))
 		/* hole at middle or tail of range */
 		return -EFAULT;
=20
@@ -785,26 +787,24 @@ static int vma_replace_policy(struct vm_area_struct *=
vma,
 static int mbind_range(struct mm_struct *mm, unsigned long start,
 		       unsigned long end, struct mempolicy *new_pol)
 {
+	MA_STATE(mas, &mm->mm_mt, start - 1, start - 1);
 	struct vm_area_struct *prev;
 	struct vm_area_struct *vma;
 	int err =3D 0;
 	pgoff_t pgoff;
-	unsigned long vmstart;
-	unsigned long vmend;
-
-	vma =3D find_vma(mm, start);
-	VM_BUG_ON(!vma);
=20
-	prev =3D vma->vm_prev;
-	if (start > vma->vm_start)
-		prev =3D vma;
+	prev =3D mas_find_rev(&mas, 0);
+	if (prev && (start < prev->vm_end))
+		vma =3D prev;
+	else
+		vma =3D mas_next(&mas, end - 1);
=20
-	for (; vma && vma->vm_start < end; prev =3D vma, vma =3D vma->vm_next) {
-		vmstart =3D max(start, vma->vm_start);
-		vmend   =3D min(end, vma->vm_end);
+	for (; vma; vma =3D mas_next(&mas, end - 1)) {
+		unsigned long vmstart =3D max(start, vma->vm_start);
+		unsigned long vmend =3D min(end, vma->vm_end);
=20
 		if (mpol_equal(vma_policy(vma), new_pol))
-			continue;
+			goto next;
=20
 		pgoff =3D vma->vm_pgoff +
 			((vmstart - vma->vm_start) >> PAGE_SHIFT);
@@ -813,6 +813,8 @@ static int mbind_range(struct mm_struct *mm, unsigned l=
ong start,
 				 new_pol, vma->vm_userfaultfd_ctx,
 				 anon_vma_name(vma));
 		if (prev) {
+			/* vma_merge() invalidated the mas */
+			mas_pause(&mas);
 			vma =3D prev;
 			goto replace;
 		}
@@ -820,19 +822,25 @@ static int mbind_range(struct mm_struct *mm, unsigned=
 long start,
 			err =3D split_vma(vma->vm_mm, vma, vmstart, 1);
 			if (err)
 				goto out;
+			/* split_vma() invalidated the mas */
+			mas_pause(&mas);
 		}
 		if (vma->vm_end !=3D vmend) {
 			err =3D split_vma(vma->vm_mm, vma, vmend, 0);
 			if (err)
 				goto out;
+			/* split_vma() invalidated the mas */
+			mas_pause(&mas);
 		}
- replace:
+replace:
 		err =3D vma_replace_policy(vma, new_pol);
 		if (err)
 			goto out;
+next:
+		prev =3D vma;
 	}
=20
- out:
+out:
 	return err;
 }
=20
@@ -1049,6 +1057,7 @@ static int migrate_to_node(struct mm_struct *mm, int =
source, int dest,
 			   int flags)
 {
 	nodemask_t nmask;
+	struct vm_area_struct *vma;
 	LIST_HEAD(pagelist);
 	int err =3D 0;
 	struct migration_target_control mtc =3D {
@@ -1064,8 +1073,9 @@ static int migrate_to_node(struct mm_struct *mm, int =
source, int dest,
 	 * need migration.  Between passing in the full user address
 	 * space range and MPOL_MF_DISCONTIG_OK, this call can not fail.
 	 */
+	vma =3D find_vma(mm, 0);
 	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
-	queue_pages_range(mm, mm->mmap->vm_start, mm->task_size, &nmask,
+	queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
 			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
=20
 	if (!list_empty(&pagelist)) {
@@ -1195,14 +1205,13 @@ static struct page *new_page(struct page *page, uns=
igned long start)
 	struct folio *dst, *src =3D page_folio(page);
 	struct vm_area_struct *vma;
 	unsigned long address;
+	VMA_ITERATOR(vmi, current->mm, start);
 	gfp_t gfp =3D GFP_HIGHUSER_MOVABLE | __GFP_RETRY_MAYFAIL;
=20
-	vma =3D find_vma(current->mm, start);
-	while (vma) {
+	for_each_vma(vmi, vma) {
 		address =3D page_address_in_vma(page, vma);
 		if (address !=3D -EFAULT)
 			break;
-		vma =3D vma->vm_next;
 	}
=20
 	if (folio_test_hugetlb(src))
@@ -1480,6 +1489,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned lon=
g, start, unsigned long, le
 	unsigned long vmend;
 	unsigned long end;
 	int err =3D -ENOENT;
+	VMA_ITERATOR(vmi, mm, start);
=20
 	start =3D untagged_addr(start);
 	if (start & ~PAGE_MASK)
@@ -1505,9 +1515,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned lon=
g, start, unsigned long, le
 	if (end =3D=3D start)
 		return 0;
 	mmap_write_lock(mm);
-	vma =3D find_vma(mm, start);
-	for (; vma && vma->vm_start < end;  vma =3D vma->vm_next) {
-
+	for_each_vma_range(vmi, vma, end) {
 		vmstart =3D max(start, vma->vm_start);
 		vmend   =3D min(end, vma->vm_end);
 		new =3D mpol_dup(vma_policy(vma));
--=20
2.35.1
