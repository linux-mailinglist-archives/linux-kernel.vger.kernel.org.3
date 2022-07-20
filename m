Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186CE57ADC4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238003AbiGTCWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237839AbiGTCVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:21:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9981F6D2C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:42 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0Kfc5017922;
        Wed, 20 Jul 2022 02:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jEwSgLQTZcZTeoMs8f4vND+DNkMImNDsd8CCWIy917Q=;
 b=hW5gFXto84jx+riE7dLgOW09FkJ6GU4RIr7/c3DN649COjbMeILshy+gYi61xwrFeoGu
 eq9enGCDW4ArNhzqGdxLIZ8r4aGcDjeoPIySicTXd2jPMx/oPKFMTAJVDjDMsclzfgjK
 93SGwU2l7/4Et+biScHypfUFn6Zxguc+SityoUgvGV/unc0XtoR0rsOwx+W0hkRMqKhe
 bhpMUTkbbyXv+qPzPcIGmRYtmBRKykZttXRR+mcgZTQriX0VgypwlREs8zASlTIpxJqW
 vSiMQ+zNm/VQDOKI+uCIAWxcQ6D2RYamhHScXCQCmNUJZXuPBfWCbVfjBo9EeLQt1GfZ GQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx107u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1UAlj002689;
        Wed, 20 Jul 2022 02:18:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbnuv5-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwzzvqHCEpDaPxYjIQB6pop+kRpdwxl3LRPsqG69NcbEkfhkoYP3Ks07ZItQNElhSZvK/rJLqiPR6Dh4uJSxSqJxD34rYpWhgP+mWMpHjrIEwpEk2wTm5Ika/GPoFUPbFuSm4cT55goouZTmhUkIw//i6aygjyHT5CYBQ8/Ax+7bN81wI3ADFuC5UetKBsL47wY5sQNjdiWNUfH6pLCm8hKQeXXebpYR7myV0kYq/G0b9fi7L/kLc01nEAEt1lesQux04sfFIslO5ki3fRCUaPCBQ9YUYMsou1MFAyJJoz3FQcxCAVaGUECssvqUa1SAqLKsqbS8g+1Um7daHw+izA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEwSgLQTZcZTeoMs8f4vND+DNkMImNDsd8CCWIy917Q=;
 b=DQvIDX6wfT2+i37LkppUygYtHiT2q6UkHDhyEJUZTeqgMLGGP4CeuHRAMz0mQypI9Jgv0lbbLwnzdtAdXTmneUaAU06CzdZhXISc6nbXB5cvMR6jLButJ6DtJQsc6DHhwDaelsmnOd3fS5AzhiaW9ywxWSB9QOxfTsq+QMxOd5GOoIpuGKBxF+d15fSYv9DYNGALUwjIRih2cOB12KcDcKW5/ds4IacF/mYv1NDW9H81GiQQVK4CbZdSPa7hwRpt8vos6x5tztk6EjXc65BLsHfziiNy2Pxbbp+VsIo8IXRI/Hv7BUESzuh/d/2ahIRL7SiCorK08bFmQFVV+1ftOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEwSgLQTZcZTeoMs8f4vND+DNkMImNDsd8CCWIy917Q=;
 b=WqrrOoZUdNd9fEu35aPZXKdNQ4o11wOZRn3FBRgZMkopyz7z15tXKUMKN3V3rhSv3QPfbjHBrWezH/1Wn9k9eRe7lq5lxFICnIS7WOobO7jilAGwyOiro0nJtk3jROVNKyLWgYMBdA6fHXFd2BbJV82O3DvqgE8yIbVk2TorY3k=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Wed, 20 Jul
 2022 02:18:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:32 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 38/69] optee: remove vma linked list walk
Thread-Topic: [PATCH v12 38/69] optee: remove vma linked list walk
Thread-Index: AQHYm97sDs0BWfIrrkq8fxDJ3WE74A==
Date:   Wed, 20 Jul 2022 02:17:56 +0000
Message-ID: <20220720021727.17018-39-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd613f89-3403-471d-6f1b-08da69f624dd
x-ms-traffictypediagnostic: PH8PR10MB6316:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LsUokimotLh1eK2WrHfSYsfjTb2+z+zDL1a5EJuzHpINVdljTeNBFT18TzLzqL2aamiGRO7emEgpXQwaM8z5CfHSoVDoFujGLyNyaRGX5izSKlVVmcz0VXqmDBsf1hbWdd0LB852fBgiTKB1KnaaK4YWISv6aWnXL/8gTFYGO78ZB054yz4CdNShzJXG4wZLcrQ+FodJZO426eMkxGC5Gf3t777FBniniT5oNlG91VS1o4WFbYOrDvInf1CN9Nd4WbRk1w3CtQI2DPIG/QnAQNutbri/vLCDC3QhAr6sso/bf1rz5zc7FAFHJ8qKxS9v3JT2h4S4QeCb3z/ptoCEunD+VH0S6RyIXaLjK6UYKfKHvabCkuSNHOfN6C6OwN6CkRazmqKd/KVIi++lNUVAoPKNg9WvSNq4bp0jo9xh95bEZAaB6zy/Au5KYsSFsca3O0iIQohbSkMpmxi8JRU7CP3DOJQRJKOVqa3MKrbZEHX7M9g60joZx0ftsGFrHc+/YMRXRYX9ssT0OobCBpS8u0rOlDuSqRVnhg2yhyqd0tOYD6Bm9JxZEHoj6qEZzy4tvPtgEOMjJ8bCT6Yvz7L3Z6TFV0Qd/eejLImyEEqSAjGzzHxTZ+Wp+n9hD4HxTCkDfa9Kf/4XEWntocxdL5GWmzzS+wiQI8/hfrjoe602beRE1RYsFJ/l3fPD4F3zSb7uMVtXpPXizWmtrV5i3LUo6tb4Uu8C8qwW3aNXWMMG5ENZG4hhJ14xW5LxCAX2NGO0El+RNeSmAqU22PO9VI3SdoxagKv9QHL7MdSuIYpFROhgPZqjMDvK5fvL2czu26eCq5UbQYEg3jnjfD2Jn38lGHR5zDIw9Ktolrdw+y/QY8mOmnS+p2EQh/rvlPwBZUZq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(366004)(376002)(136003)(76116006)(122000001)(44832011)(8936002)(5660300002)(186003)(1076003)(83380400001)(2616005)(4326008)(66446008)(64756008)(36756003)(66946007)(2906002)(8676002)(91956017)(66556008)(316002)(26005)(41300700001)(966005)(66476007)(86362001)(38070700005)(478600001)(6506007)(6486002)(6666004)(71200400001)(110136005)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CyonYI1okYWcZCJnwQoObIBgFS2Rwp2VdJqyHn/XZmQ1MbH+ZWHD4f2BY9?=
 =?iso-8859-1?Q?PMpYK13eXhgbzBkY0o4miXRmbx1v4adhXqAqzvvi3G6m4MqwnPWcprR43d?=
 =?iso-8859-1?Q?ZFN+8QU2Q40VvAla71lwQnjwiMa2S6oQIzjHhKs39+mz3w3ZtdknQHcOz6?=
 =?iso-8859-1?Q?Lzs/KpOgxUXWbAFJnXaoKsqdTFw/lE9bCGTzwJGS6cpnWC+nnKzsWnyf4s?=
 =?iso-8859-1?Q?KmEt5V5GiTI8Wp72tvnZNNy5eZgX632IaMS4nwveQEWx8otxmz+a7LJDzQ?=
 =?iso-8859-1?Q?zmc1VHlUSQSII+d0BEuv+kZIrlWJWuYPpfH7XKB/sDCcMrdJvbQs3J+GCq?=
 =?iso-8859-1?Q?BGCPBkLwAjVLfn4XFnKIurOHOLNBDrbj4/bqX/6n7Jp1oiBIxVyVdduvA/?=
 =?iso-8859-1?Q?DDuaCYhMUKS4MUj+tHsGuBNFQTotvDZaYh/ytY7+/xAtUbCr8oL4m/jwn9?=
 =?iso-8859-1?Q?GtI1Ue/UfcRqY1YowyAkC7sDszft0H0OVbPY22zQPEbfEXGZxShcb+bpvF?=
 =?iso-8859-1?Q?JFK0MSRXdYyQGs3FSKtyV/aSeFzQx0YI742Tt7Xzgt4jP9DyJPdl5Qyk4+?=
 =?iso-8859-1?Q?+bFLGsber6aSnolqWnEuaeUG/WcE3DM/j0c0NLEBBA1VpsKOsqCTjCcef4?=
 =?iso-8859-1?Q?favJ6wlYP9rsxR+7kHZ8V/sUMQt3ZHRw5XdsBRo+WHDd/jrCFwQhD593ir?=
 =?iso-8859-1?Q?e30q8lDXkSt2OOD9P0f7hjoOCbRBxc3BsiDWxJfct/dnOg3UU2huSPlMcK?=
 =?iso-8859-1?Q?dNaF072hFMeOWKNeSnnbVGIExdyLaL5yxtEGjbJ4eDHboFAqiNvNy3Jmnu?=
 =?iso-8859-1?Q?QXrdkX3lwTa3F1hGQ5RLQM+TuVc4UrytuZegaiix+jaroML78G/hY0UkMo?=
 =?iso-8859-1?Q?W6X7r4+RIbwULwNbES95EC1AwPorTSdZeKStiWMUV+B/WWyE/vXqke+5Fv?=
 =?iso-8859-1?Q?LTm3HRR0t6Er8HQcKQfRi/ntjNkeovuy2JMfj89QZ+FHzeg50lQxKIuj+v?=
 =?iso-8859-1?Q?ndHI1mdNzZrQP0RhW9gK17eqRtf/GKnoVS28v7DnutWQY/e2XRrSeh0efZ?=
 =?iso-8859-1?Q?8IKy1eRhN3U7h/UePFVWLu0jSgAMJsg/zyU0s7CSl6UPHFcx5XW6KNQ/pS?=
 =?iso-8859-1?Q?VSdqd9HSg9kpfymvv8ZVvQYEMuM7IBhJzukR7zPH7Rky8jCQu+w2fpNopN?=
 =?iso-8859-1?Q?PdcY/MZCWLgzCFFvPHC2huzk5E844DaAt5X8JEYrJ2GNFnUGYq4iKIMmDU?=
 =?iso-8859-1?Q?5A2/ppq1VrjguRwb3OdJ0J37da8EuDs8864uuZbUqFmlawDv47pLMtn5kk?=
 =?iso-8859-1?Q?2EMw0gXVm6+7RVb3iIewirrqzJhbuoGChF9hhCDvXykvye9U7H2ZuPevyg?=
 =?iso-8859-1?Q?Eqpi+oU6laMecUJfkZFTHmz4VoGj6UXhzFdBGmA6II1DWESK3IJPSTe2n7?=
 =?iso-8859-1?Q?UyCwXTdBWosM5s3a97CGPJJWe9LlZ0PRdhSgFAdXLgoV6vG79FLs+3Lnkd?=
 =?iso-8859-1?Q?wpFrQPEic6RNe7lznuMPtm4249+zSLQvsZH6qAG+hrdenU4+mEmL2svOOI?=
 =?iso-8859-1?Q?k8pcD1gt/Lq85SxbSn+YIBkkuP8NazNR1rSQpKjrDeAqgeiIUUFKLowPI5?=
 =?iso-8859-1?Q?XZWVaCM56IKpFYTA9GN0s2SVT3Sg/PwC5rBXlBKr4GwrquFU2ELt6igA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd613f89-3403-471d-6f1b-08da69f624dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:56.3211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: COY+11em74wRgcSSjH0PmtYGSg1vqOPJXOIDPr9EMqbbPpbI/5f+YuIkxmv0fRmOZokaQ3DI73xD0/dV0WnsHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: 5pkvMCPSwbRXqMct5sPxbw4yt8nc2PrE
X-Proofpoint-ORIG-GUID: 5pkvMCPSwbRXqMct5sPxbw4yt8nc2PrE
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

Use the VMA iterator instead.  Change the calling convention of
__check_mem_type() to pass in the mm instead of the first vma in the
range.

Link: https://lkml.kernel.org/r/20220504011345.662299-23-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-39-Liam.Howlett@orac=
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
 drivers/tee/optee/call.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 28f87cd8b3ed..290b1bb0e9cd 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -492,15 +492,18 @@ static bool is_normal_memory(pgprot_t p)
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
@@ -516,8 +519,7 @@ int optee_check_mem_type(unsigned long start, size_t nu=
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
2.35.1
