Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6313951016C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346346AbiDZPLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352102AbiDZPKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4FF15A436
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:25 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT2bN015530;
        Tue, 26 Apr 2022 15:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=b56Z6rNYl+jTxxBz+9XdChUJVjcaDZsODTDrlXoyXMw=;
 b=wAMRo4kZmt5x5L8WfNx1D1wVOpgfCokzbUWYj0b0T5u5riLKXSt93Wp+aUlxTiQAmYWV
 0CVQnqN4U5E7rhHkUmzs0z3drEaMrMDjbl5KpzN0Ht8JQvAr/sMuebSL2YTicfYJQpp7
 rwZPDrOUKoMH9j1RCVby9b+RTmLCOWmMn7tGr2ubQ6aDX3b0dY8gWU/CFcWjmxWMWKxH
 ITmvH+oVSJlsINL69DOW+iZWE6U6VkvxjzONArLSTFpWlkGbHoHMAsFDuxdFEA/5zkEu
 kaAVlPzJ11MlESMsas+CDC7kyyC6LvQSZ1zj3+mULL6UMI5s+j9VZdpDIiojsfY7y7j9 Hw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9apbpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF64Wc012598;
        Tue, 26 Apr 2022 15:07:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3grd1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0Xsem0zYq2ubVbNfbV7vJum44bDpK36X+v6tY4MtSNH78Fq7A4NLEMzNhXS9fmyka6K7pwDExuF6EtYOE1L79or/w5w5F0xKMlUEyqgQAhBdflbXGqk23eMwWZBFjkmHfjZ4uzz5iV+nvaJs7+8qxPQ6+1sKYbbLO9WZptjOcxoWtzxL385t5UqJ90DOeFfo1W+1nXgqjcR1bsQo/4WRTIu4EdqGj598TmQqzE+HhLE/ST04XUbvbhQuk7SM8aAaIbxY5jpzsXqH15501l3xklctuDhAe1vwUn43ImuS3zuNi85T+NFh66APq13gfqxCtvMKYb9RrxhEyTibHqcVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b56Z6rNYl+jTxxBz+9XdChUJVjcaDZsODTDrlXoyXMw=;
 b=YMq47ctUcN5FYqCI1/cTr9DJGIlHhhMFCRSjAi68bmKI/viRQi31By6Vu51FiKWDwzqICTdDl8Y3IlioSSrroY97czZyRtil4nOfxhTay8BqQtb8zErLfsSxr5C5iSYWeYOSstMJSPbFGcMlDbxwjy6Tf1hEM6X6R5kCIAS3du17oMwnb+Bhbn4ugz3pyYQxRpBlebU/hI6E/b1K2u4E3vZfoAqi0vX6nW+iBD2OmHNMX83APPtTwsfZ4do2oNpW+n8MnuMsMfb5/pR8HEkTp/H5atAhBRFk7XKXEChOdG6kFkyJEevqHfPWY13H1FQIGIKdwb8NorCGILyXKh3mEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b56Z6rNYl+jTxxBz+9XdChUJVjcaDZsODTDrlXoyXMw=;
 b=bApx0dAUiss7B4AWV+BibAJNTbyowfmNUvWIDAxmztpzB8sdXnoKGwnPdRM2mJvwNpiP8SaSqnFkhqz1Bw6x43JH1E1vr0INkp8Ove8NbQ6AYloToqMId1pfuJgWOD6MIeZqIhFifhtnj2nesqJ7KWsKsULNVMbilqCDMxApgYY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB2929.namprd10.prod.outlook.com (2603:10b6:208:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:07:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:11 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 31/70] arm64: remove mmap linked list from vdso
Thread-Topic: [PATCH v8 31/70] arm64: remove mmap linked list from vdso
Thread-Index: AQHYWX86mfm9J7B0+UaSeamWE3iObA==
Date:   Tue, 26 Apr 2022 15:06:38 +0000
Message-ID: <20220426150616.3937571-32-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64be28c0-4f3d-4a33-16ac-08da27967098
x-ms-traffictypediagnostic: BL0PR10MB2929:EE_
x-microsoft-antispam-prvs: <BL0PR10MB29291A4821888659352F90A8FDFB9@BL0PR10MB2929.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ro5s5/2fPKxu+qed+aCFoWkOVMIaqnS3EhAgItNVeZ59gqr7OuZhmOE9AUdPxTdS7uGGe5DzAENPQcehNxWj6YsUxZvnUWUfy4vqvsjEFLOWFGOPEannMGih7NKaNIIQxeaQKCp8mZa+0n38PjCmnQcvw/kwZXySStTFHDCjWR/2OLbayZnWmnioeBQcBazdn3dwsaho4QUhQ5Jb3nqw+HX3iNOYTEa2wCZOhDFm+Q85yworizATHBZFVd9DddVvi9aU7Bxzx1CsKtlf+dnHn1ajMzfiBywRVpyqRF/xjCFp4J5ZdoDIpIInPlVyY8nLuupvdZa9NmRYH/SPg6k3r1qT6voDLXcY/Yu1Zvj40vL7eFwP2p0CeaBeLd8qm7+yymoj/6uWVTEvDMxzVGyuqlviXvhDZdCjErDT7T0rCr1qdf90kZx6VmcvIWIWjbEMr+VJ2lxH8lGyj+P+YdEOko9HphSTUtYgMJy2HqW4Yti39wt7V2bLfTq/99HJUgGtBrP6IbuO6xA7AxQmpZub+UZ42TRvHHjCLgKWLhwZAgt5uJ470VXbXVXiNtUnN8Yvr8AA6xhRanEKkr2ffzMkW9I6fTq7zXYJJUYrNkWosFYGc+/RYGHtZm9WHBKZwbMKXehQMPIIyA1tap+IdXcu04ySDA4m4mqei4o2JfsA9wW5gUqWuCiD0Q/k0XE+R7N4K2yaTNwGTReUDWiGCjaduQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(6506007)(86362001)(44832011)(6666004)(6512007)(2616005)(5660300002)(38070700005)(2906002)(122000001)(38100700002)(83380400001)(76116006)(91956017)(1076003)(110136005)(316002)(26005)(186003)(8936002)(64756008)(66556008)(66446008)(8676002)(66946007)(66476007)(6486002)(508600001)(36756003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QoWrYFWNH19UprQdvhz93ypXfRxCh8lJHBvcWsVMcBh5hmPSYR3MVwQbts?=
 =?iso-8859-1?Q?ptq4eEB3KcOvrvnMOMzYTJeTtinxqy2EJaSadu+Yzz+l1nhQxvBVSmlFjO?=
 =?iso-8859-1?Q?VCd6SqiI8ZIZkfxEcw01Pob1q0iK0t//AmH2Pu4DfY8CX1B/7aJSRMwL/e?=
 =?iso-8859-1?Q?y2NCQggubu7Xgj74cFYPwwx5bGPpcHPU0kJgIPVF1iU0N47Q+bWUQN7vvO?=
 =?iso-8859-1?Q?wKhfGvT0t94TgBbf0LRZ9qagJKk69jSOuKjQlLe5VAvVhoUw0IVOFe/cCs?=
 =?iso-8859-1?Q?ycIp7gZDjZJeqYU0V1OtldH7UlvoV10W+81SWHtNG51ID4SeVeDtLZQ+5n?=
 =?iso-8859-1?Q?tXgCudLCqWHuhhoFY9595HtVG5esXOMiWtOcaIrhQjKVIHpq2oK94FlkC6?=
 =?iso-8859-1?Q?Em5JBB/OWZf0Gm2J2uoEOOXQXRjWk0RppFEXuOc3OVV9efUDj5T4JkRlTh?=
 =?iso-8859-1?Q?7hbB06WBkLMqTLdel3W52lzUuCbuCQAUE73iOekx7d3IIxjKaLebBi+PG5?=
 =?iso-8859-1?Q?g5fvUrMAtJ4552/VOKyTXW32IZmtC/mzq5RKQai7P9CjfKEldtkafEXJ1E?=
 =?iso-8859-1?Q?5KMXNqVOJZrZ1I9E6PKBh6+fInm0Gzr8uzf08dRNV0zcn9lZawNQw4WH5u?=
 =?iso-8859-1?Q?xcrxYuGnz3JY8oKraCr328ARzA8SpfNY0aqXW/DB0vARy/y8IjJJXKwq9r?=
 =?iso-8859-1?Q?h4QKOHL9JTyi68l2vLdWDhLw3iwxUeNaceSxnr3WRfRo2G2AdSZoFgu8kQ?=
 =?iso-8859-1?Q?fgCNiaWy192Nh8WVDcdlBVesE9S/fKluvdtMOEExZFzVV20DKwJe6X24kZ?=
 =?iso-8859-1?Q?WCZyK15UMJ9llM/fp4uniSZY2CA0JSTQ30c46LZ+/AWYINT6Sol/jElvLK?=
 =?iso-8859-1?Q?ANyBa8c3vMhTaZ52YVdmCwGKwngL2iMwxLSSORPZAlroV/I215iUQJmWA9?=
 =?iso-8859-1?Q?1neRF8/OUfL/wKq+VJa2AYBvGaZ2iU06vXE3goH4+Xv8oRC0L6S1U/lzxV?=
 =?iso-8859-1?Q?bTFPT86geN9Qgd8NhO9i8jHhI7glv+qKPajlKmxoIrIU0RNU7V+eldunh3?=
 =?iso-8859-1?Q?CXu0SdYCjGVh0slePCwf0OkpfUApc984gPVEFtiTHspzcyFsHZONw4ZTdo?=
 =?iso-8859-1?Q?U7CNmdi9JXPrm9NKUqE4s1Lr05q3Hj/pUt77xLVdrJ0qGYWMzFsasg3QVV?=
 =?iso-8859-1?Q?ZuqF7fCWk839XosNvWbXFIWekzta2eV5RUAkdlv455L/Hd9iHTu3QiODTT?=
 =?iso-8859-1?Q?PCND+zaB7MnlwOngBEA1IhZ6skf2EWGOCMRDPRA01sGyKNukdn/ZnNHV8P?=
 =?iso-8859-1?Q?mNd83hs9MhFbfdwonch4qY9AfELh9QeFBSdCROEXsobb/WReGlcVbsZagF?=
 =?iso-8859-1?Q?ozx1s0CN+4G9Ks+U4l1Qoj8ZnJFQI8aOBnFmJtrE9ANI6KeveqJQa9jlBQ?=
 =?iso-8859-1?Q?TdpEMI3UZmjTi73ILEjI4u8T/qSD+dp1cxm4YMJZOH8269jYTc21fdNTtO?=
 =?iso-8859-1?Q?VVUW8NVTGOPwRMrU4eXw1OgOyA9riRq25dA6qo6IhnRhrmTArg5lnKpkPa?=
 =?iso-8859-1?Q?oSzBVPuf1Svc3wZRYPhIwJ9EUvr5wcOjbKvzthBhMnOeCMxtaQgRtlX0ZE?=
 =?iso-8859-1?Q?cxl+N/NOZY7ldgOx6XjoE0laJqhZ8HjVTKOqbo+FDfKAvscpaqhme87U7H?=
 =?iso-8859-1?Q?OCWmEt34ytfCbvCCg0KraFgPS358nYEBKdb/6uI3a/sIHWHqtmkoxtt/dp?=
 =?iso-8859-1?Q?P4i3EXDf2DJWOGbJppDMRYFYamUZY6VzK8CJl92Wl+aaz3U2RVk5aJtiYN?=
 =?iso-8859-1?Q?bW4vs6w8e4npTIM2LGOMCSFbZF6pRWA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64be28c0-4f3d-4a33-16ac-08da27967098
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:38.8180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KrfGIxZ5keWLQsflG9ZJKk4W6gBnbUde56/RahTwzxylgMS1Y6Zszl86+Dim5QaoKo772oSXIwYNQXAVySPsHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2929
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: IJuKWd_jrOblepiE5TkGoqxOpzBW1KIO
X-Proofpoint-GUID: IJuKWd_jrOblepiE5TkGoqxOpzBW1KIO
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
 arch/arm64/kernel/vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index a61fc4f989b3..a8388af62b99 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -136,10 +136,11 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_AA64].dm))
--=20
2.35.1
