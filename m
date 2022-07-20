Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD15657ADC6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbiGTC1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241018AbiGTCXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:23:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D052F48EB5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:19:28 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1VWv4002405;
        Wed, 20 Jul 2022 02:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nNIFuIHx9MnDYq3P5rOQ6f7ayKbFRlKrGhcItY+G7+s=;
 b=yXW4rVoTRBgtkPFc7tjbkrf089h4LFkPsq1bm2vG6C6Hm5VlldU07vfJib6wzS80YJRD
 cGf/eUWv7qPA+gJVO6hOC0RBMf7JkNX28hExad+ACjnfNYuhj5xkFifAGIFC/InM/5o/
 znQHCk7Cl5QRPZZLSlvrRsK7OC3/GNI2p9/JK3qoa4OZp8ovOCFSgVb4kLqrYELZzas/
 DLxlLo/60rcYNkTA8eC8s1kh4pOXr9Jj8YZKFQexBdld8ifvP8iOvg6Nj6LhSjrLEHtq
 +gyEGgUSnOR2wqCZatLGOMJ0hFuDmkd1VOvqBNlCvyUrOFgRApBRdICvUtP+BdtVpsWF fw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a81p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:19:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1x7ai007828;
        Wed, 20 Jul 2022 02:19:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k3w3uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:19:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7UK81XO4q/jcLtAnbGeyKUheQkgY5CAl7kbZmeKS0I8zvxltXUiI9yadGFTV2oYvcQutkaGXXJgWCppr0JeqUZ6uJqJuz9byJW839HC2c2Jurezkp/6GMLYL8qoRSbwCc7P5+8O/Rgz1islOKjVye/wH8w+EurgH82/v614i2+GJbY51RkVvRMJAUiyhIVdN+PXAJrUMj351VCJXrnkolkNbWbLPmwZ2Kad1VBZBUoXDQz8hbvAt1YO01XAClMXbhSu5lN4scn4jsYUphkhwBgZjPa62nfI3K0YyX5DfN/OcS8fKIEZrU2KIqpq1/OJ+PxJ8VeX4thpfMd7fPd5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNIFuIHx9MnDYq3P5rOQ6f7ayKbFRlKrGhcItY+G7+s=;
 b=M8VnrBiTy1EjZ+hCFf/RKbEB8Bl2ps6SMcZxrGiia9IKMswmZAD6DgHQO6tyBWfJzVEQY56y1ZrzzzKkZw5oviJR1uZIKDCM22qWJH99dZdcSQORf08VtrcEGqdoqobn0aOXDpFFjoDrpAc9LVY5NFJOwes/ZVOwAxQSqCdgJSTyKRR0IPXdsI9gLIa6iT5fxDao4p5/UPp+nNDFekvhCMzGDAOWFZuPO8Sw+rL2EDHbUkvHmL10a0MyyeNOvTz7iUh3gnc1J0tZZgLUmbSY9UFzlFKnHEVyjyzZXVgNLO1IcSFCZ2+G+m/QlDmAyxirg/ilsQ+R8XY213RaadVKRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNIFuIHx9MnDYq3P5rOQ6f7ayKbFRlKrGhcItY+G7+s=;
 b=edVQkQ2KAc5AQntzdt9ahhgM5G/YMSe+s3LiERTI6XnUGSyanhIGJmg0F+4TUMfmbhEvYJRa611aQacgS4EVum9wMbj5l23NgBrGugr1Ci+3yCdBxSnPpBbxLDSbuAtt5i/lxzXTeEzhjvl6qkAoPGkXCVC3nupNW4cITSLEPE4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB3797.namprd10.prod.outlook.com (2603:10b6:610:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Wed, 20 Jul
 2022 02:19:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:19:16 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 64/69] i915: use the VMA iterator
Thread-Topic: [PATCH v12 64/69] i915: use the VMA iterator
Thread-Index: AQHYm97wpreMuMDJwk6gxAl42FrBKA==
Date:   Wed, 20 Jul 2022 02:18:03 +0000
Message-ID: <20220720021727.17018-65-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cdc009ee-5ced-4b1c-c820-08da69f63f29
x-ms-traffictypediagnostic: CH2PR10MB3797:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v9MIvEBl5eBzQ0raMhkj9WdGnd7zqhb/Fk6M2dyShNWq1pSdiTIt8Ct9AnisygUmdeMcClICjW7PvTC5jDgH5cM3tx0hPC8s6Z3dKgOQdQ0uR1J7Qylp+ASWABEOlQrETLCJwpik/lOkGI/fDLgYsEohOHHVEq9n4mYjHI0QGlL2heEv0ndB6PxO8rz+4lvFdJM2+51zeNLvUVQDFT+4M11BoFOF40SQYTLVa+fJY9GrNn3Var/ab5njFEF2gKii6zvRK3YNMsHgte1kDW8lSoQufdMAm8nbdFkS65kNP6pU8GlgdlNNBN6KBKz1zusXh8zhJbCXPx+nzYyzkvmvO/ghCKYutJ18BeytNplFj9Vs+PP3pCE8IqsSBah1lIne/76WKptDQBuEgn3JdnLpqr5Wh+0121sL6sysn5vMsEpisKKX1bjeFY/WpG04/9M112EM/JOHTdCM+58vi8kePgqtzxSMqG/cVinWaj898HthOKmcEMzy54LXKrnzZL7DR/k7q0L9tXe0FvxVUgA0a3vrtj75K9Zr8shiGpEYNaqaiUUe5yb1r4/jU6yahiGPzNUmOptDnt3YiQxcSPMWojxNsnsHxcwo0LHsOPihm2+GxXaBEqcv7P4FGcpziKqRue/z81qWcvbIOT04w31seVDlUdqYv2BpBXm/HwXdtS9C1HhnLEWklxHQkRdfMkWlFgfUyPjHkezkoIgEK91Pd5V7KTqIspHKjb2LpLo23zJdEaPjQPoNjkBbbeUS2AEXr2vQbko+9aDuig1318AOxZchOuwkGebFiLmtqdiw/0u3tUM34W/I3qD6wPwcZFXJAt4klmkoxc33jToHmNfmL5C/KQRULOawxX4WuhTWtZVSt1LLMFqkiKF8CViM4Up+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(346002)(39860400002)(91956017)(38070700005)(316002)(122000001)(83380400001)(64756008)(66476007)(71200400001)(66556008)(66946007)(76116006)(38100700002)(36756003)(110136005)(8676002)(66446008)(4326008)(6666004)(5660300002)(26005)(6512007)(8936002)(966005)(478600001)(6486002)(44832011)(2906002)(6506007)(41300700001)(2616005)(86362001)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jRTVB782x09PWz+KTXScJIII75BS5VaUVoR53RtjuweAMRvkxwakLiUlyF?=
 =?iso-8859-1?Q?PBQn5I+sJM9zt1DhlscAzkVzEgzPTHtN4AqxkUIZuD1RRO+n8iMy9iah0+?=
 =?iso-8859-1?Q?RGEXc/MFN3Xegmpeatn2UqIKb5fkNX6DuRTOT9FhE4cfz6brxR1pA775Wa?=
 =?iso-8859-1?Q?68pek6MKUcUmguE+BydWUbtHH89rjMo4cWZhlwE2wrliYJFuvlA5ealWVn?=
 =?iso-8859-1?Q?7lOQ5aPWWssfjx2SsNzmdghNvlxVzTGM/ANQEOS+gJtREKCO2+iMw9Yscd?=
 =?iso-8859-1?Q?XCSTPbiJ2ukyF62MWbuAqdk0ed5xCdhroDzo1JGy/8ZWqPhT8qg0DweNfm?=
 =?iso-8859-1?Q?GVcRdR+MN3s0e1WCHm1L10n+u/XoxsR8+eK9Ti8v0NJnXO7MtighCtDwXB?=
 =?iso-8859-1?Q?Ce+V1cMHZrRnJ/Fo/aQ4b/4JpZIsjpNPNzyoKBtNWViUI8JDNyc+J+ZlMs?=
 =?iso-8859-1?Q?4V2sGB+AmxdPfdrYaeEfRFzn+zIggkunvfPICztyjNgeA4Y2j7TKgcmcAr?=
 =?iso-8859-1?Q?tUa5Svm/lO2mU8N5PGOG4rOpYaAXleMkselpOaIog7SMqrofyXOVNxcw9R?=
 =?iso-8859-1?Q?doV+w8KBQfNlD8v4/hLtnl4Rbfnt0mB5HDVQvHLSfQlAb/BbanCsO3AYBQ?=
 =?iso-8859-1?Q?yFEgwbRTjoo7kX3QiPAQ4bAA2VpJ7FYHLQETp1pgR/WO5JFAQMQAIHbyX2?=
 =?iso-8859-1?Q?iY3riPgMJLWv1yD30cqSx9Y1p3dThTsnJrA+tchebp4KdiaEQR1lzGluDC?=
 =?iso-8859-1?Q?7dMNmBvOzK6Fe0/eO82mEgM6b4mDOra5ImrYqAnleQokPlqRD3LiUiBo72?=
 =?iso-8859-1?Q?47ETt30M9aSV6+6j5kqFmcV7IhSeB+N4mFQ+cnGnUKDnv2E3mChbP+rSQB?=
 =?iso-8859-1?Q?364JUbLN3kyvlQCgbiM8wSs2SfxtBiHKNYv0zkamzVl5wS6TjqM8UG8OgB?=
 =?iso-8859-1?Q?6LsZ7wTSp0FplqvZHN36cwr7/XNz4lICy0cqfzMNxcngJmcHY5BQMUTf18?=
 =?iso-8859-1?Q?87OBJ53onGWaR4hjwkEnLFrQ9lffcL/eVenH4GeYE21it+HMcFkTt65Mey?=
 =?iso-8859-1?Q?6EEpvfshafUiVGJQqfzxZeFFANUs8wbAcZ2/U4XQxD45zHV59dhr6ToaeH?=
 =?iso-8859-1?Q?fXfCfpSNluUzTYGjPjjgcJ3ftcZFdjhsnc3Zr/SUlYTgFjbhHma6hPH0hj?=
 =?iso-8859-1?Q?nrhZ33Dz32gRmfM3KrWoHIpDv+DVWsmPzRj/vO90MdTmgqzc62jpWmryaW?=
 =?iso-8859-1?Q?6N58EeKROS3pxa4neYExDAxTVQZkVwcyGa+yij4g+HixbIiLhSUSCnHqBn?=
 =?iso-8859-1?Q?93F8pC4emiGSb/0I4rKRDXgQIhJB3kRUQBuvrj+DZtZlyJvBfN2oRqHzUF?=
 =?iso-8859-1?Q?uDWMdvxeBt5XxcMjcHWFN4o+zd1fqCL4WICydnj85ehLifC1pn9xLfwrqJ?=
 =?iso-8859-1?Q?fJxciLhip9VJbAQ7MESyujMdgfcV7PzSarw61/Qhp3ghwTtHPn6sBvn9do?=
 =?iso-8859-1?Q?OdpN3v3goUlh/7weflQ6JOD6yW1+5CJ4ojw2o4tW7XpCFvtp58Cs3yC8qB?=
 =?iso-8859-1?Q?4hH+htHxDGmEExnafOHr8gZeEBrnoG+i0LnE5fyI2iasKljCar/+viZatX?=
 =?iso-8859-1?Q?rVqnrVHCTGSP7MY5htdETp52JoXhrhvLa19EkI97kONXobWlbO6bLGAA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc009ee-5ced-4b1c-c820-08da69f63f29
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:18:03.4611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nssSWXhzIenwd7Ijq0OWmnZQ+F+X3gOenqJaJLLjQXJa/jvol6UsO7J6gCX6SYufqADBfBi0Z4rOucjjPeWnaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-ORIG-GUID: 2eteuPRmzkTe-rXmc1jUy3g2yNRpCPkG
X-Proofpoint-GUID: 2eteuPRmzkTe-rXmc1jUy3g2yNRpCPkG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Replace the linked list in probe_range() with the VMA iterator.

Link: https://lkml.kernel.org/r/20220504011345.662299-49-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-65-Liam.Howlett@orac=
le.com
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
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/=
i915/gem/i915_gem_userptr.c
index 094f06b4ce33..a509f7da104b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -426,12 +426,11 @@ static const struct drm_i915_gem_object_ops i915_gem_=
userptr_ops =3D {
 static int
 probe_range(struct mm_struct *mm, unsigned long addr, unsigned long len)
 {
-	const unsigned long end =3D addr + len;
+	VMA_ITERATOR(vmi, mm, addr);
 	struct vm_area_struct *vma;
-	int ret =3D -EFAULT;
=20
 	mmap_read_lock(mm);
-	for (vma =3D find_vma(mm, addr); vma; vma =3D vma->vm_next) {
+	for_each_vma_range(vmi, vma, addr + len) {
 		/* Check for holes, note that we also update the addr below */
 		if (vma->vm_start > addr)
 			break;
@@ -439,16 +438,13 @@ probe_range(struct mm_struct *mm, unsigned long addr,=
 unsigned long len)
 		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
 			break;
=20
-		if (vma->vm_end >=3D end) {
-			ret =3D 0;
-			break;
-		}
-
 		addr =3D vma->vm_end;
 	}
 	mmap_read_unlock(mm);
=20
-	return ret;
+	if (vma)
+		return -EFAULT;
+	return 0;
 }
=20
 /*
--=20
2.35.1
