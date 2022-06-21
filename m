Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F74553C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354545AbiFUUuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354621AbiFUUs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF711E0BB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:02 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJEdKn012601;
        Tue, 21 Jun 2022 20:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ltEW08f8XTxhKMvTy5kGZB0O0hDlx4ImaR8aeySl8Qg=;
 b=QGDPDMHqRn5SauH+TS2a949Y0Oc9Gb1ejoaza7p3k0tF0MKvcJ7wO0KCEnfNAdTLtzMl
 VERIPdESM+ui8uG249Iyi/F6elwPakPaQH7hPIQHrY4JK6ijJBq+QZPurUDXBoAj559+
 5cVkuRUpwNhe1NO15Ul3Wdt3Raqy0mocm8WWIOUbPpVRYXpeR6+bwzBL38pqfZs7H46A
 age01ZpxGI5dEL3vFl5ozxJ0CBezntjcuAq+USN2b8dbHAvzY7vx74BYC1S/czxEgioc
 gU2UCdh7uav+t6d3FU91gGMlPBrpt7Wn7c9bJqXKt2FLV5JUoN5VAWt7px65ah4sO82Q Lg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kf6khg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeUhs027847;
        Tue, 21 Jun 2022 20:47:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wspfd-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7m/Mzo1DlwON+QmYY93JA+tfsCHMf2qn5xrwCNOb7crmGo4SZ4xO8e6jUGhfS8D3w5/ELbiUAUji6D3QZlKVdUpKUHHTJ0ElOzbliVrg5SjloMOAFdSL1to9t0STGr19uLDi++ioE6Eybh2WIoae+m5b7qT904Xr95XytV+gSFudRiysMNVS/xLZiYS5wyGc/6OWioUs3xz9Vgaw0qp+SWqG/SqmwovGnSVIYutxRNgdVPXXHsBADKOpnduIBPTdco7f2+vPt+LRG7guSZ4Kx4Dgnt+dlZidskgb7mlBJ0ZHGAtFxCcJIQub/io+lLJLP0xVan2btMQb0kArzPU8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltEW08f8XTxhKMvTy5kGZB0O0hDlx4ImaR8aeySl8Qg=;
 b=Mt0E7b1H87TEv/Q9zWmBl29dagkJL3mq+tIwukLvL855BvkJRvZEi/MTeKrxFqCJWbCcnC/maI5Nhgz99GPjgFGSYBW/eSFMhWM9byUHTabuA9HtKeowTVusRGijbB0TxBJWDBp7l7FfqxlvPoTuyDbRNsaTkaHm5wJUHoU5mPbuFswP5d95OGzN8BqsLTcn+9jtIJ1pOtFZwzXJL8Dj9eIBbUe0OyFUACDoy9SxYw9gQN583c0yBQmzQUWJcsKU8kdQuAzg9ofjsFkrp0qoOsD14gdFRK4fj2PuuDiqwG4on6r6eOeYR8cafxTbSW0JdWO7f7r+sJ3PVHfhITNSgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltEW08f8XTxhKMvTy5kGZB0O0hDlx4ImaR8aeySl8Qg=;
 b=c1F3rYE9f8WqmYbtJSm/uOBMV0ZUyaEQEHNEXT953/as9YRPD9oEmc9H4QlaWd61Uf7IuluNigCYG2iVFJCMz8qkcWfwxcWTwwVEH+kfGfv4Dht6LR6oF0s8DjMtlbpI0eLApbdhWvNID9+xrwaQKLaCKlk30uOQEwp/0e0qNFg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4025.namprd10.prod.outlook.com (2603:10b6:5:1fe::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:45 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:45 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 33/69] powerpc: remove mmap linked list walks
Thread-Topic: [PATCH v10 33/69] powerpc: remove mmap linked list walks
Thread-Index: AQHYhbAP2ST+TlTtHkWFHhHvtWzWKQ==
Date:   Tue, 21 Jun 2022 20:47:03 +0000
Message-ID: <20220621204632.3370049-34-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21df4d13-891a-4af7-5142-08da53c74b16
x-ms-traffictypediagnostic: DM6PR10MB4025:EE_
x-microsoft-antispam-prvs: <DM6PR10MB4025EC4603C8705F2BD0BC85FDB39@DM6PR10MB4025.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LKFRO7xqbqlQewJoFzm1H8J5npqj+Mw/H0dTuF1zBfSxpExhL1cSLCAkREDmX3n2bghJ5zCvspSFUsTsF8hWRB45f0uYD/Zx/q84vpN+65JHNvdDqCOHuhw5XUjb6qYdnf1tR7IjJeB+8oWTAwoxwdpj5JBG0GQxslvO3R1HRZFqhqcR4InShMwiPEMtDJG/A0SPFLtQMS9cIpXn3gxvujSLEQNMh0IR8DEUYdK3jQ1hq5RLCOxzZD9bNtw2yS/zYyB8RqzTH3U4Wq99RWY2NQAFdOleiORZXSz6Ow5mXrynV3YBah98NEJ9oZkgm3Y/+dZo3lhL3p54p5Ae8b11gpFWlKww8nyGw4Eio8Pmc+TMyGPR7FOzdxducNMpwcmfsV30S0R7MS9yfKbE89mQGo7o66qayaO+IWV9VfNOx8Y6GpNQkXY2uNmuSR1yVBsIIMIlLIX/BOZ2TVkv5GtiDkcjxsk9W8+IZC1iWOP+Oh3w/54hjbHcPcEHB6FXR8XcWWIKcJnpdaa0r1aQg6iwuUUJvptC0wQxuHubnLC8p55Y2j2PhayBaK3VkXeXwRQpe3rY6Gc5F3JaN52itdrtEOjXma578zN8vSIrk1VZ8Ymjy6GWg3Xi2TjeghinIGIgd8Qeuj0i4Yb+zny5qGKLS+glNyLltSn+/wcf+uHiUSxLmd47raN3wWO4JoOtalWwIq0/Zztd+I7T3N1Am0abgsAymqApdLwIfSw+Q6B6A7AU8qos2hx/6MBiw0rWf5Nl4jZvBn8+L57EYks99ZSLDXlPDni9JYTdxOJuyuqoiT8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(366004)(376002)(396003)(6512007)(41300700001)(478600001)(122000001)(6486002)(966005)(110136005)(36756003)(8936002)(71200400001)(8676002)(26005)(6666004)(6506007)(83380400001)(2906002)(66446008)(316002)(86362001)(2616005)(91956017)(1076003)(66476007)(66556008)(5660300002)(38070700005)(64756008)(66946007)(44832011)(76116006)(186003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?R3/sU9By5RbS2FMesVyZy3OCjHalaCFyjhXz1Wy02RFaSo/lZxWNlyQJPB?=
 =?iso-8859-1?Q?95MhXlivsQUFVkVUp9Ge7LUFCIBLlCkbvdpDaqayY8ZG3t5UhYcG3epXJo?=
 =?iso-8859-1?Q?mAwLB+pWy+QCO8ji/hhJ/kIejoRE01XVfSMucjRQhL3OxdmixkfzEeP02a?=
 =?iso-8859-1?Q?3Lr7w1ddrTtqmoSNTsfGXNiI43VK8vy+2yYK2ewRqy/DJQMQ27w0ov6lez?=
 =?iso-8859-1?Q?AYeqkgw2W7kBwGBGBo/oRPMzuqHuG4vfwe4Kk8GAxMMUSng4Bfcon3kBeR?=
 =?iso-8859-1?Q?hZ1ZpwN7xrVOLI7XveATule1USu//QQ92sdbwH/Rc11ws2MzkmZDS+8qy2?=
 =?iso-8859-1?Q?pU1EkwvOLzwuZrrHT36dGKG2cgpkAX9+LFNuJR1TYE052P1C1DUR31fBgM?=
 =?iso-8859-1?Q?5AzMOm1UuhkS+k3ubu1lnBph8Z7gyR5hnvrwHH9iovNRxBGYOXcGPimQHF?=
 =?iso-8859-1?Q?OKEKyNnT7zkR0yY1VZFVT2ccQmeNf7A+u6CfJWfYLvEQ1XmR6dBV7R84mY?=
 =?iso-8859-1?Q?MmFO+K+t1+8ukv0lZBazpp8x2D1AllChaBlp1dIY54YidUvNX5dJQ+kADg?=
 =?iso-8859-1?Q?dt+OMsBCxH2zlZZLd8u7Kx26EH8uxWhFNWhklwAXMJ/C1a6QdU4czVHluB?=
 =?iso-8859-1?Q?03q5ZBmnNkki461AedYn/5w6IdDKwYA/lipST8nBgMfdrkzodhXEknWUc+?=
 =?iso-8859-1?Q?0Exfs4ecCQxpjvANrJJcPaJtrLbAaDsjFifip+TPSKRyjVrr3lAcMhtBB5?=
 =?iso-8859-1?Q?H/OrmRi8lLnvGZzFe/ZId9lklgQgz4TEiNZ0yw6QK77PqdZJSALF8szGoW?=
 =?iso-8859-1?Q?lUwC+e2nPyhL+cfQZMQZlgL3CRD1UeLph62hRyitKSrBLVcuH3bUsjSw9V?=
 =?iso-8859-1?Q?M8JWybpUTokjap359wkDRs5gEb388ZvJYbcXh07103pvZKqd80MMNKX1r4?=
 =?iso-8859-1?Q?W5qJ1Uh7q3ts+CoB5ggQiaSKskQcwCs4h7Nr6Ki8ys5LlvGgN132P1ZQT3?=
 =?iso-8859-1?Q?soQtau7e4VDA1kHI1p1UfDSfxxDG9fGvKQzBWuc5ucRjWhLFXR3phvCnc5?=
 =?iso-8859-1?Q?TqKXdU9DoKTfY+hkEsf8hf09btT6XttwO1WPJmAL7mmTy8Tk3QIEbw2eNF?=
 =?iso-8859-1?Q?kvbddMVXxhMUUSbParksHBo8KPd6rQO6EtEzmwDLX1tOHZMLO50CMqQ7V0?=
 =?iso-8859-1?Q?Wo6p1+im0nqm/3HcKVEbKVC5ZEJ5GHSEFVDi5XjkFoHCskXVtN+EumQDfl?=
 =?iso-8859-1?Q?qAosXKniUoyrvzhjgvEjIlR3L8By9Ehaks1uykMiwOGN9sbiAGX1VFZokb?=
 =?iso-8859-1?Q?XkYt9AysSBcvAysU8fSwCWu6gMalgFPtL4mA/PFvKIHAUG1Y8CnagELIMc?=
 =?iso-8859-1?Q?T10zshYWXHeg15lKxOVrymLLVcDECdGBcAN5XiltvMYpNZVdRqacDF6m0W?=
 =?iso-8859-1?Q?bMJVBHjh8LiPPKWTnExVRGDcjvMP8FPceCcOpdjyroT3g7t1ORrOK0Vk9t?=
 =?iso-8859-1?Q?ekdb+B+7ny0+//to+1qobT6EzC9ThTa+ndq6GZI/uq4h0kc9k8VbcXYf4F?=
 =?iso-8859-1?Q?QWL1Z72t7Ykom+HbppRJJ0Qzm2Y/r4SsFt8zXko9rje1LAmlld5kBsqMBv?=
 =?iso-8859-1?Q?X4fqjaMRMrN4nWpZorpYmKxH0Tpe/1lwmWbPvuMfahQNx7ctDgyusoCaA0?=
 =?iso-8859-1?Q?dJFjK2BZM05067OEpTUSygKa/cgUgUrLRSWNoUtWTZwQcx/uBP97xjFcV0?=
 =?iso-8859-1?Q?Eigr74zubRWF3aDqeXe/nmWyt8Kuj9CAY8tIl5Rw0qPojG5zm8Ipbi1+jC?=
 =?iso-8859-1?Q?KQppLVqDh8s1xChQPzUUApOJ2BmoKVQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21df4d13-891a-4af7-5142-08da53c74b16
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:03.3787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6bQ4SuvHAC1/pVRs4qFKTSDm8z2GbObaT1UHB8z6iDWZDjaa7EkEN3GE0VM7EgGo3fLSAoI5RGoZ2+HUo+RynQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4025
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: LUQjmAgtrvR1-i_dIol6CtgiP78yK2PB
X-Proofpoint-GUID: LUQjmAgtrvR1-i_dIol6CtgiP78yK2PB
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

Use the VMA iterator instead.

Link: https://lkml.kernel.org/r/20220504011345.662299-18-Liam.Howlett@oracl=
e.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/powerpc/kernel/vdso.c              |  6 +++---
 arch/powerpc/mm/book3s32/tlb.c          | 11 ++++++-----
 arch/powerpc/mm/book3s64/subpage_prot.c | 13 ++-----------
 3 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 0da287544054..94a8fa5017c3 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -113,18 +113,18 @@ struct vdso_data *arch_get_vdso_data(void *vvar_page)
 int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, &vvar_spec))
 			zap_page_range(vma, vma->vm_start, size);
 	}
-
 	mmap_read_unlock(mm);
+
 	return 0;
 }
=20
diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.=
c
index 19f0ef950d77..9ad6b56bfec9 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -81,14 +81,15 @@ EXPORT_SYMBOL(hash__flush_range);
 void hash__flush_tlb_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *mp;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
-	 * It is safe to go down the mm's list of vmas when called
-	 * from dup_mmap, holding mmap_lock.  It would also be safe from
-	 * unmap_region or exit_mmap, but not from vmtruncate on SMP -
-	 * but it seems dup_mmap is the only SMP case which gets here.
+	 * It is safe to iterate the vmas when called from dup_mmap,
+	 * holding mmap_lock.  It would also be safe from unmap_region
+	 * or exit_mmap, but not from vmtruncate on SMP - but it seems
+	 * dup_mmap is the only SMP case which gets here.
 	 */
-	for (mp =3D mm->mmap; mp !=3D NULL; mp =3D mp->vm_next)
+	for_each_vma(vmi, mp)
 		hash__flush_range(mp->vm_mm, mp->vm_start, mp->vm_end);
 }
 EXPORT_SYMBOL(hash__flush_tlb_mm);
diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book=
3s64/subpage_prot.c
index 60c6ea16a972..d73b3b4176e8 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -149,24 +149,15 @@ static void subpage_mark_vma_nohuge(struct mm_struct =
*mm, unsigned long addr,
 				    unsigned long len)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, addr);
=20
 	/*
 	 * We don't try too hard, we just mark all the vma in that range
 	 * VM_NOHUGEPAGE and split them.
 	 */
-	vma =3D find_vma(mm, addr);
-	/*
-	 * If the range is in unmapped range, just return
-	 */
-	if (vma && ((addr + len) <=3D vma->vm_start))
-		return;
-
-	while (vma) {
-		if (vma->vm_start >=3D (addr + len))
-			break;
+	for_each_vma_range(vmi, vma, addr + len) {
 		vma->vm_flags |=3D VM_NOHUGEPAGE;
 		walk_page_vma(vma, &subpage_walk_ops, NULL);
-		vma =3D vma->vm_next;
 	}
 }
 #else
--=20
2.35.1
