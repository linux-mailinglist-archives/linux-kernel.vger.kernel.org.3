Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491B351016F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352136AbiDZPLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352103AbiDZPKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908A3159787
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT2bQ015530;
        Tue, 26 Apr 2022 15:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0nFIXDnQBt1NV0JRBPoWWdNPKRiYZYX33deYqogRPIo=;
 b=fDi6lONnkyyBlmQRDrVQFJxdPrtodTJyrBVu0b2dV1ecoUsUWOf4BQc1yIFjhJA4vAUS
 F9MYny2eOVyL27e2YVrF/xYrYflGm53kT2uZopRlgOAPHin30eCSqAI7EKezIxTm5hEG
 4LOgZhugPj7RBO4Pe4yYlYtqrU4jq/093ZdGjjJXR6TIt8XfikCOY3dQzKQ8vVUy/qwD
 17LuKoScssMdQP+i7w4+ZZx5jRQOPGHjlUODaUkiTazNX52F7capZZjj65O7a/FmbKMk
 gMlyX7NgD8P8hoogGvYlQfksliy9ODGtr0I9MLP+ydy3Gh8aEOLWXx2lC8qgT8MUX4DW fA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9apbpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF64Wf012598;
        Tue, 26 Apr 2022 15:07:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3grd1-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKWWZx4uUdrOC1v9jxHSWNlzG+ruINIA/b7j70/MPfV9iigM6L+q5dXlgwdQmF/PoL9NVgQdp8m6pHRkIEtDFUmHM2Ozjcp914t5GMSzZ5ovLBFzSEnVOnLhKz6cmKXDoADRzsKPFk4bRNmh7kgdMFCP+uTiD96bVoZvb22rTgeJZrKvXag7uiGG3psR+w4oFxLzFPORz2qWqt1X4D8YAe9OVq4qqc+XmibaK30wv6/X7/jKc5Q2kLG7frM+P+JVVj6AhRJ1FAXNeRwqOTkqQvnW6lvX75F4lRzdfxTojQJLaSQiMYYUXBtkqf2nS1g1QoWSm0YqU18XKuUEygJSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nFIXDnQBt1NV0JRBPoWWdNPKRiYZYX33deYqogRPIo=;
 b=e408wzWkC4nZUgXp3cpc68mgPb/ZK0gAwCA88dlhs1yAe2dvzItcDkGbJi3N+TmpJx8uwIWXIVFe2kR6smZL9eRBDA1U4P5OMXqerLcmYoyOUEnOuAlT0iL3xNo3lj6pS8lm+XdYfCrE9prOdS2Z1nunSLFP4C8qCinz6cxMz9cTMlI26KLkURma20tXrzBYz8IlKG2+EOY4vsdKAEGoLKAtBCYxV669DKQZWYvVMfMu8mX2sjsFRFS0DDDLktYBLDbIUM3EtBho0ydo2HbB1VqodmPvDLE+EzdB373dzZJlM2V99LjZ1MmXlyZyLJBpUGPTwsMK9K3ZakaQGL9b4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nFIXDnQBt1NV0JRBPoWWdNPKRiYZYX33deYqogRPIo=;
 b=MtRVj01MIypSp1jxcEIRDWv4eeDhPDTNbGzZt587cjCX0iPBKPkV0GVquz9UJC+l5P3fRHVJnYjy713CYGYr2IN7QqIrmICbTJq0iUGP4GU3sCpvETiVAesCstXGEnAnoZKYFkkBBvDEmqpCKowOE9fFaH4McSmxMNGm+YQOdI0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB2929.namprd10.prod.outlook.com (2603:10b6:208:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:07:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:12 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 33/70] parisc: remove mmap linked list from cache handling
Thread-Topic: [PATCH v8 33/70] parisc: remove mmap linked list from cache
 handling
Thread-Index: AQHYWX87+dS17TrDLEyINHqtswMWmw==
Date:   Tue, 26 Apr 2022 15:06:39 +0000
Message-ID: <20220426150616.3937571-34-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6921ac4-3c8c-4606-6b38-08da27967173
x-ms-traffictypediagnostic: BL0PR10MB2929:EE_
x-microsoft-antispam-prvs: <BL0PR10MB292926B8ACAC681208CB6E3AFDFB9@BL0PR10MB2929.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o3PkqVN0m46rZ9fZA2g/eF2SNc783yOyTfPwADDs3nroD2dxdyotTqRKLP4MKwkUFg2SnrNZOe5DYHrDZ1uLCSokaSBwhJjnk7anjv8uxpV1MjSKMCKOggdFaTj6DV+geFmn4Yils0fc/a04XXjb3f5IdnqFTI5sM1DTBwnCr36ko/1LZuqgPF3a7R1NPBXfrPpDJi7FI+lnCASGHrpGcWjRv50MF2KVoklQO2q2+e2fOdZ0kM3YB7BgIvOtRn7gWw3RIShNmHp/WmSkAGfScHqRlnVV7eH+UjE7QoFlL7RiZ09QeVeFhR1X5oWSsb1zCr95vqRoXmMvW4H7RnwO/pYEt5KXgmgUQwBCj0a2GbJxt/Q0mj4H9cvLelgTUtuYVdB5FxU871cYFcxm8S3Zaarw7yABoPC11SubLp09HAl3nHoLGoV3RIx++/ooe/i9/FqyZ9pfWLax26pZwY1EC8Oh0gyAEom8j78OidwMS+wuagyU6B0OMg5pwug+U1HogBv/4HXYccAi89QSJcktjUiV0nf+Dnj1yxZt8GrEw1UeH2eAnoKhWlaSLbw5KHWKHUfnZwuSNgxShaM30yyd7MHvnetlkMHmkkkPIXlI5Cw65FmFMSXso8S4G3r1vXEzfjM9MYtG+byX0QBvTCUgY8bpaE+gY5jfLJdFP7i8gQqBOikl+14umNSjOAFOCvib/YkRKsjkghy2rWXyWQFrpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(86362001)(44832011)(6666004)(6512007)(2616005)(5660300002)(38070700005)(2906002)(122000001)(38100700002)(83380400001)(76116006)(91956017)(1076003)(110136005)(316002)(26005)(186003)(8936002)(64756008)(66556008)(66446008)(8676002)(66946007)(66476007)(6486002)(508600001)(36756003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dsgOc9LAfcWzCwafWu5PBMBkOLR80B8kvOcMd5Bzh9Q9QA2wRUUZsc5aDR?=
 =?iso-8859-1?Q?TzM4GTKdCqK4AwqwmUz6KnMQYwD6wgpFXAqaV5hNx07s/DGzt2sz2V7lei?=
 =?iso-8859-1?Q?pvnwGRuMnB1Ct3YnxHOHNdGHBWpDCuu+sl3UJPG4CBxV09F9ME7VlTSRYX?=
 =?iso-8859-1?Q?hcHDca2lLLfrZqCLFwpQBeuyIbWBKAGUuHCtXuLg6Um+72VwszTpkbr/rp?=
 =?iso-8859-1?Q?cpvZCpEeSTRf1jLrhkYXhI9CSNTbf71aCdkRnC8gBJPy23vFoe4LoutYYJ?=
 =?iso-8859-1?Q?u3UWnuPF90AA2hTH9sXVRteq3bE+cTk73rOckEVDzigUeREEC8P5a6dC/y?=
 =?iso-8859-1?Q?ETROmm3h8V1UQaCUjqxaFCUJF6hNzNcK2XnhTp4IwoizqVYMunITQ+CLGz?=
 =?iso-8859-1?Q?s8xcnJkwHYDwhKwyfDUYZsVvMmSEaDHYnwfR3np6gg8BwOaDbxnVl5PSsU?=
 =?iso-8859-1?Q?Rn2hitDdKDqMzMVQhsTZ2dfYaN3RfoGhiYjkR48FCrV6+0VPHi3fxr1ibF?=
 =?iso-8859-1?Q?UEmEsWwSu8ImR2goHoi+BrzG6CTwVsJjtqrOWFfMnutll1N1HNkVmVb1Q2?=
 =?iso-8859-1?Q?nKRqgWt1DkxVafywFGySLlBmFB4q9AQAgLgwKkg3cEKsrihTOxdml47tY0?=
 =?iso-8859-1?Q?vPQYWXnP4EQBcyD41RQNhXybHEsAhUFnEEmDBH+3cK/MT6QTpbJDHSHLaZ?=
 =?iso-8859-1?Q?m6JPvab+JG6b05sA9tJ/RfXTjWd/85q03ewoQYmOLORfo2ry3D39o2zGi5?=
 =?iso-8859-1?Q?HCdfzXRoEb6mtmm+cXOHfn8mrwpMEL0IxoHcSqbpMr2owPVTZc8ioknZAs?=
 =?iso-8859-1?Q?xm9QvX5WpTxfMXlV5hpUjlYhk2r3zyIXs2yFal6Y/m+tjMpbovGTFPlRj6?=
 =?iso-8859-1?Q?3jnPqDDde7UZ865TdqR/giQCY3PcDMeUj7onSLxUkboLpGRu8OunFQSRTZ?=
 =?iso-8859-1?Q?Yknbj9M8iqCmb3r4dl6kLa9jFx88tp0UDeytZOMSDy6yxMADzWVRBnJ32y?=
 =?iso-8859-1?Q?DqLMGEOa8fYk8+iKViRDOT62KkxGu1mejxvGMcfrePQUyQyNHGVih+q1VR?=
 =?iso-8859-1?Q?hCKdEBNzGLe62Gu78QmgD1flotjYJnyiku/ig5J0QouVg0idZzTsANbzNc?=
 =?iso-8859-1?Q?vDKfq5AaPunrcpCrVWO0zadzyboLUX56okR+OOt4OwuCr3N5RJ+hSuWTbj?=
 =?iso-8859-1?Q?PFBOxAT3vYd6BOMBtnGb2WdKTFIRxdQKDJCsvA/dsi2xO1tJz2nnVVmWNy?=
 =?iso-8859-1?Q?Lm62QlAdh2eh+6cphVZFbhgYPtVcoEMJ1RgA/zgO5JE56TnxPNtWLLD8o6?=
 =?iso-8859-1?Q?NTYr+/A8RJSNf1X6l6QvCud09vPVztGF/XGRi0PjOwPsKSXarnZMeD9tgd?=
 =?iso-8859-1?Q?5nxjT2ZXzKYV6cRPOR1MJKwL9tpu6MTRi6X448C7tazbgyR2ylQ9o8ZUr6?=
 =?iso-8859-1?Q?4FwPlE1JEf61ZaaHW+7yWKwJ88f/+Q1Mp+7KpRx9VktuRkCw2f1dxSaeYR?=
 =?iso-8859-1?Q?A8EEoJrMl1JfZ+fLME4IJ8BCDCCIizx+hnzeEQ9wrKz4qQVMni0YNsTJUt?=
 =?iso-8859-1?Q?9jdJMekfsAqqIprflbx7/7t6gX9EKVhDVxsPe+cEz7wIzXpDsycIvXU+LO?=
 =?iso-8859-1?Q?e8CUWmtXEPTjp9muvUIdzUc2Lb4kv5cNLa2MOxfXUaQqVRPgHuqG1NwPFD?=
 =?iso-8859-1?Q?EJf0d+5V9RjhYjvugaklTSGZW1kOgXzX+QnkA4a1uIBhPQTB/+PBD7dbQ7?=
 =?iso-8859-1?Q?vkPeoKUHF6lMxn56PVaIlMYoicgYdD72ChGfyTeHWzxhtCIxDcr91yC6J9?=
 =?iso-8859-1?Q?G7SFYQPLQbP11Fpl43lNpDtuW8bsrfY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6921ac4-3c8c-4606-6b38-08da27967173
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:39.6304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l89AlBEt1MEnQr0mTmhZoAmUn2U6zJYUok2cLEW5dqlFdZqUCzHTANo+S0x+jnlSvDdsQeKBAdduyySmQ+2J4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2929
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: XlpV_gc2ZkjqyGXQJcxPKzymbXjnmLbh
X-Proofpoint-GUID: XlpV_gc2ZkjqyGXQJcxPKzymbXjnmLbh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/parisc/kernel/cache.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 23348199f3f8..ab7c789541bf 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -536,9 +536,11 @@ static inline unsigned long mm_total_size(struct mm_st=
ruct *mm)
 {
 	struct vm_area_struct *vma;
 	unsigned long usize =3D 0;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		usize +=3D vma->vm_end - vma->vm_start;
+
 	return usize;
 }
=20
@@ -578,6 +580,7 @@ static void flush_cache_pages(struct vm_area_struct *vm=
a, struct mm_struct *mm,
 void flush_cache_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/* Flushing the whole cache on each cpu takes forever on
 	   rp3440, etc.  So, avoid it if the mm isn't too big.  */
@@ -589,7 +592,7 @@ void flush_cache_mm(struct mm_struct *mm)
 		return;
 	}
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		flush_cache_pages(vma, mm, vma->vm_start, vma->vm_end);
 }
=20
--=20
2.35.1
