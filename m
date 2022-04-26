Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15E3510180
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345405AbiDZPNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352133AbiDZPK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB4E15A436
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:44 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSxpM011286;
        Tue, 26 Apr 2022 15:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qN69qeTqC1joH7N8NvAt4BDmsNZgn2HP04WQlUPcQPM=;
 b=kBwNCqc/XhX0e2jHcFWbPW0dpswL0KkB7xoHGPc4l1BZbRPUn0ZDG4iDcFF0p8hzqqD+
 pyBXGXu13vGe0L82DL3veEt2Euau+Tl8E+XDldFpjNrB4vKYnaIL2XVMw5tWK6CQn51T
 lnwoh1Joym55mcfbCQdyuJLOKoenqNgK2so/SMsxIiU7XZ4TrkwbMGBwCKUIpzSYM0ZO
 BzJm1rLJi12ULdHP+ybmw4N3q9vswCobGEUbnd9iqiwxF3fT+fLe8Jxp2sToLC9ev4QZ
 I8oBvYvp/JRAo4TAq7nDuBQ5B2THrnno0XTKZey0MT77xaTb+wXrhQH1piUTOpsrlqzK gQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4ef8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6USa037884;
        Tue, 26 Apr 2022 15:07:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjkuq9-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jijzFRQFq2e05BkR4gCGyZebtdAsS9epEqFVHuNOf8PWSMgRfo+6UtybJ0ZZUilzgAK13DH0SuyOM4YngSwg8rodm6VjnyP12WalRGMMhlomBMVCOwdQ1FibmpWQcvIluuXRafYolA7e22Xia9Uujqu61fw28Wf5Xm1jpz48Dhknr2PvRZ1WpL50jb8JMij1qaZBN/F3E7b5R8rnGytxNQm2dMcCRRFPmgFupEULBzGJDvEgWPAYP7hVnAXD7t/zRfk+F2m7D6mRyPtRrnbbzntTJPaXm1R8dSB40OHpUVzpcR0uEvd7Ok7RRPISHq0NBs8EtgyPkTOlhXzMHA4neA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qN69qeTqC1joH7N8NvAt4BDmsNZgn2HP04WQlUPcQPM=;
 b=IHv8Scm9M4CYpcHAglTXb18u3+QJNMcy4ErKzQ2bHdrF1VOVC0usCpLKyzbNSBRPI/SLuqZBMk6XFD8bNQ7Dh/m3Jb3+UN3NDkS9Re9WtUFpbnCuQuxc6QcEh1mipCIbx/ui3KyIAP3sMXMj2/8d4TUWefGheM4aO+gmnEpTgpN/j298bznbR4bXi6bBMyXRJJUK8eElNc6XAwVl4L+1MoNox1pPXzGjzGpuC24WCxPFGyADCfPYwAzLIIReSVCYNWLv3+AbGgnqcNPcbxFU/7lSKJLjz6n9kdMb59Mg8QauJc7ix1q5ApTzcxsq7Bjg9DdmCOfhEWu35YI0HHvkTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qN69qeTqC1joH7N8NvAt4BDmsNZgn2HP04WQlUPcQPM=;
 b=CdVfseW5Xi1ry4dqxUbsSkLQzM/LMOmwG6l8p/0fl60EtJ451Z9XD/jxKSmY9a82KyxDge2aUJdExvOnq+f63zuwvUQf/t05HVGzBIiCvPP9Q9SVV77sMeyKPBMocsHpuCoc38c7wAbefNkoiMRvbb8XB853nsIAvS88732SzEc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR1001MB2377.namprd10.prod.outlook.com (2603:10b6:4:36::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Tue, 26 Apr
 2022 15:07:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 57/70] mm/mempolicy: use vma iterator & maple state instead
 of vma linked list
Thread-Topic: [PATCH v8 57/70] mm/mempolicy: use vma iterator & maple state
 instead of vma linked list
Thread-Index: AQHYWX9ANEOhv+LFuEmxCagqPybjZw==
Date:   Tue, 26 Apr 2022 15:06:49 +0000
Message-ID: <20220426150616.3937571-58-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4617fa29-e44d-4aef-920f-08da27967d9a
x-ms-traffictypediagnostic: DM5PR1001MB2377:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB237782D8542B602B8EDD99D4FDFB9@DM5PR1001MB2377.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8kmF0C9JIZ0NWhjT7afEGFuRvkVLTJiZ37zLdOb8I8Hpl/ivrHFD2DJ1yIBnVdHKLD9EtlWqnLlMc0QNHvtifPOGyQUEoTCj/SoyY2IAVbp7NWEq/sBSDEcgTJJCPeWCtjFyC9oFaIHLrM5jhYfN76g10ANECZHRD3RNHg+9igD/gApzgqkkNfelHfHL6DtyNn9TwH09yisunUxiZiYULSU/otfdLMk/TWAX2XlzHKKLHsRsFQDFChtuXN/y/CuGFCb5Gb8XzskJfv7Re3T8XuKLn8iVwZDQJfGN0/T81L65hdCNmIbRjK9t/NC8xXENgAdsSTtJpCqVN5EqfZCSZKODKxS83N4gioa+uotPecuy8tdYy7suslbeusNvfR00C1f8HVmeHnK1hE/MgBBDy2Y52d+PysdKw0EkIh8+yHu6YiRHp+PpTJTzooJuZAam0jIFmAZr6NBshrOFoHvc6/AzGkMkORaS9GHoLTVrX5wLBBRVwuI1pYEwvEMuyzXl3H9DYPGoZOI1ZBnsNB6seQI5XQNmjI0SPRqLiU+eVm4OM+UD8g9wA97PwDFvs8oXM8FeDCpVns1BLwXjE/U8frwG/nZXsqSGscbdvoztDlStDwJ5jDYRnqTkrkNs2pcw3gQqzHliyrqKvAZRuTQLx7PJhuoqbbIaNRVx4Ivnj5vdt9q487Mq0w+MA9pI4kZos8B4vJDBNlBVNocLqsI3TQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(2616005)(83380400001)(1076003)(8936002)(6506007)(26005)(6666004)(71200400001)(76116006)(6486002)(86362001)(508600001)(186003)(44832011)(6512007)(5660300002)(316002)(122000001)(38070700005)(38100700002)(110136005)(8676002)(36756003)(66446008)(66476007)(66556008)(66946007)(91956017)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XRCOYC3Fr52VrQrn3AaeEXQtOs5hsTV/Aqaj5QC/3/NAqe+z+Q+C3OfZ49?=
 =?iso-8859-1?Q?RoaUEuvH2SJWiEbDzinlUk0iXmOWq2EEKbiat2WabflY4rSBaMo6e85DHi?=
 =?iso-8859-1?Q?DAG8UN16YRL69Ron+vBUFqTdBxrLjGd0yHJ5nTHqXScGmSEg5xa3VDmgqS?=
 =?iso-8859-1?Q?SS61JSulH8pARsc0oZt3mCKD82VzGjd41djCtiYrSXCMLSXcyge137ZywL?=
 =?iso-8859-1?Q?esoQXekg93GVt+uskszlIBAp9/3WePcytdgid5o0sAmeH1crokx6yXzLTC?=
 =?iso-8859-1?Q?QbVJWkuP2oU6ocFMzPje4fNIgoM4NPXczm0Zo4JVookZr+WPGotPl14CBw?=
 =?iso-8859-1?Q?vvMj/yuz5Z2wv+AEVXU69xcC4Qb6U1KIlNvsUfrCkGO7EG5LgTgbM51dxs?=
 =?iso-8859-1?Q?SnialgBUIwfCscUh1AOguEnnQmlYHg6Qgqjf8ClPfnUVrfWZZgINGk6SOr?=
 =?iso-8859-1?Q?lct0rZojRpEWgx1CJ7vJNsSm5ff42bYN96wG1Nqc3eLu6bE2xq3eShAxdt?=
 =?iso-8859-1?Q?S4mlHJtD9zFYuJ8YAV558vzf32HbZTMkN95L781QzwUytSoPJf0jv5nq9B?=
 =?iso-8859-1?Q?b35fHG/nq/cfggPPIWSpl8Jr+cap30bH7AgwyHFZ0UHiq2pBiwx33N5aPa?=
 =?iso-8859-1?Q?Le0CCTx1jqe6M74LUZdueqKixC9erYOszHW6kF8h/Qf1qxnmeDT94fIDHJ?=
 =?iso-8859-1?Q?jRWRLiKa+gppkDEd9Xd71QjBiUjRLQd/QWWNNy2FJuoCmU7EZKq6kRIlER?=
 =?iso-8859-1?Q?ngJwUJYCuPQbn6dlvAthqJZn58pWaX65ZreuTdwUYqW0SMVxsTlBarzFDv?=
 =?iso-8859-1?Q?3h7mSAd/EA8EaDm4/aZ3XD2urbsLl3pD7R0k6QUYiIekwt7mI8jYDXs6qn?=
 =?iso-8859-1?Q?TuwV03+6lwhEBYEVPQ9rKUfwBWIkjjdhwZWGR4OSWu8Vrv/kIHIGIpMgti?=
 =?iso-8859-1?Q?Y/Ir1XRSD3mnnT6FSvY/7pBJlQhD1Ia5aiLbjmqZQfqPCFnhywaGiuWL9i?=
 =?iso-8859-1?Q?6falDdUSM2XQhVcJ7hC0sjXKlEcFyo7VKASrRDAHSIxrnO8AKvtnrLD78g?=
 =?iso-8859-1?Q?iWmuwGRLvfx/O1PIHQVXKzKMHTdphG6JLvD51ZKL7lg5QfS5VPn7jYq8hi?=
 =?iso-8859-1?Q?K/YN9iDTavBnqiVN3xolFHKu5sOMoZ9F+ubbDcnFeaCrcAd1tPlYx1ToYA?=
 =?iso-8859-1?Q?wOIAPoC0ed7dw8Bs/pIkBNFUUJ5b+G9UInRG6CLWVvkxswYdF3JVvbIS/1?=
 =?iso-8859-1?Q?R7DADRO07rFb1nJm9jmA4sOSF0j3rRdh+q1tlTktZqoQXYHmtLjiiTvSiY?=
 =?iso-8859-1?Q?/GUx4/Ra0IWYc3n1bU4BieyX7OGkEoZUub67USbsJnoon8pai7DZOAijqD?=
 =?iso-8859-1?Q?FA2cvipPWHXbwtABtwTc8XXwnfN4EXBk/VnVpDKRYnhIU/WXjod0WYiYvH?=
 =?iso-8859-1?Q?aXoUr4gernvYELL26ea9NtWiURbcEZmyE/4793SeNCWinq8jhvB5tjqc1a?=
 =?iso-8859-1?Q?iXT519VGGNOG4w9NKtwSKefz12gxEicUY0ohN73kAC7DxRib9uxs8QZwrh?=
 =?iso-8859-1?Q?imbMCtKGZYk/G7oRMeKivTnzdkI70i8AFOBbmq1Sv49vyl6su0gb3jHje4?=
 =?iso-8859-1?Q?jw/njNkGY1Ku+z9zho3F6G+rnIK3e1L0LF0ZNlv1Rs4Wtdksdb5zGiq3Js?=
 =?iso-8859-1?Q?0it5WzdZlLncQFuFeCy2CP3J8bk3HvKViSJQo9yry5tOETCV2T5pwkQvAx?=
 =?iso-8859-1?Q?kaf2J8t2fCcCEoIKQq1AGGBBLHZJC/nYU2q1z56sbmNh3n/PjRmcqYjiRl?=
 =?iso-8859-1?Q?lfvgxZRHRCuJAwPUhNeCJ8GxhBPf0yU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4617fa29-e44d-4aef-920f-08da27967d9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:49.2548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gnQFHQzE2NiIY0d+2SFgbBza5g5g57Cza439kRVogc39n4xFL6G7WRfW8Ng2Myul1U/8CBbheQSw1RYbjXGLtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2377
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-GUID: TtO2SeCRz6h5Q-3f8_DeLVBYrTy0vqdf
X-Proofpoint-ORIG-GUID: TtO2SeCRz6h5Q-3f8_DeLVBYrTy0vqdf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 75a8b247f631..78d706196d4a 100644
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
@@ -662,7 +663,7 @@ static unsigned long change_prot_numa(struct vm_area_st=
ruct *vma,
 static int queue_pages_test_walk(unsigned long start, unsigned long end,
 				struct mm_walk *walk)
 {
-	struct vm_area_struct *vma =3D walk->vma;
+	struct vm_area_struct *next, *vma =3D walk->vma;
 	struct queue_pages *qp =3D walk->private;
 	unsigned long endvma =3D vma->vm_end;
 	unsigned long flags =3D qp->flags;
@@ -677,9 +678,10 @@ static int queue_pages_test_walk(unsigned long start, =
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
@@ -793,26 +795,24 @@ static int vma_replace_policy(struct vm_area_struct *=
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
@@ -821,6 +821,8 @@ static int mbind_range(struct mm_struct *mm, unsigned l=
ong start,
 				 new_pol, vma->vm_userfaultfd_ctx,
 				 anon_vma_name(vma));
 		if (prev) {
+			/* vma_merge() invalidated the mas */
+			mas_pause(&mas);
 			vma =3D prev;
 			goto replace;
 		}
@@ -828,19 +830,25 @@ static int mbind_range(struct mm_struct *mm, unsigned=
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
@@ -1055,6 +1063,7 @@ static int migrate_to_node(struct mm_struct *mm, int =
source, int dest,
 			   int flags)
 {
 	nodemask_t nmask;
+	struct vm_area_struct *vma;
 	LIST_HEAD(pagelist);
 	int err =3D 0;
 	struct migration_target_control mtc =3D {
@@ -1070,8 +1079,9 @@ static int migrate_to_node(struct mm_struct *mm, int =
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
@@ -1201,14 +1211,13 @@ static struct page *new_page(struct page *page, uns=
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
@@ -1486,6 +1495,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned lon=
g, start, unsigned long, le
 	unsigned long vmend;
 	unsigned long end;
 	int err =3D -ENOENT;
+	VMA_ITERATOR(vmi, mm, start);
=20
 	start =3D untagged_addr(start);
 	if (start & ~PAGE_MASK)
@@ -1511,9 +1521,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned lon=
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
