Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F80A59C262
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbiHVPNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbiHVPJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:09:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E6F3ECE9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:07:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkUt8022008;
        Mon, 22 Aug 2022 15:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jg3jpUDWP7p+DfJZup33xItX8j5cXBltKfOlfDzCvvg=;
 b=Qay+0erx4aOSK4KM1dG56qoTR/n8mqRw+Qf4UBZ+D3vb6LGttHDgb+gckpvelHiV6FsS
 8VSa+bvwfA20uuAo2uUgtTuKB4HhCZls1XQI4KII+IPxKBButho36Osqc6JL8RRur3mR
 zkeysYo/hjL1GKvtc4UQQ8zOeLDVIJvmi+XirUaxIPkr9K4FPVILK6vfqtky+3p3vlW7
 7/jkoiOs33KpIqJA04rYG2CbTbj+e/zrEL0x8DlCMi7Is64Os0elpKw6XiltSmqVwA7o
 64g9+sOq/9hc6YqEndYqey0EeGYmnRdlhOf4Akn+G6HelM/tZo86NotXKeCfwIxUMP73 Tw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4btmg2xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4NdS035436;
        Mon, 22 Aug 2022 15:06:37 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq1u1em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/bnToG9cfxQDW4lgVHrxTbuKTQPGs46cNGt990zdfp+rXIznriI5+t/GLDQHV7q6x/02MugM/y4brA7NvM1Qk4LfJrViryGpKHj6WqYMX/8fqk52RAgDy+nfhg5FH1jLfLbxRIPScFHd+fmBhC2aIFoquumchWMMSc79x6Le4gg1g9wz7rZVamkaqQfM9K45Q3mewr067O7wRPLdlv4Nb9FjhyWMHAnkTQFXhjJsCm2EPmewRQwJDUZZfI7DMc+M5mQCM2PM0ba2bsHOTbXyR2DQajDJxLS512no715Zb2YM6EsIJLqgaZr4eoT0ufHtMiEjv/3wED9T42tBN2p9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jg3jpUDWP7p+DfJZup33xItX8j5cXBltKfOlfDzCvvg=;
 b=TswG6WAGtJJVxq4xF7COOpJ8I+FMaKxeY78GUo0THEOkJGAkDpNXluWe+Deld0QNuQCrVGNpf0yA8V8Y6fP8S47lRUHCr7KR5/hfFoI3Gl+JaRmJneFY1rdCIRUqu9UvRPYUG9VKFjrhBbqwN56PEdypzYS1vCpmFLtsvOkOXxvEEAJo0qi1V/1mMnf9My7eO/mLBuOBGjohTZw3i6pj4S/qbjpexvLMcjRkngyr0Z7Srmq3p6mrg2aUWUmPvjaj7skkylM2L9I8u5xYXhWzGhBIsbZKOLCiszykp/eoC8HHK35RJYhHs2SmE0Qw8CdsdoHIeK4NfRy/eBVfqvHLFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg3jpUDWP7p+DfJZup33xItX8j5cXBltKfOlfDzCvvg=;
 b=xbxX/HB97diadTsdKM/i+1ewKKa/ELjzTvZRe8e/k2pP3nu+KY5SxhCUkdT4Oe/MQ+HRDx6T7V2lgTppgQU7nT/zQSjVBI92gI3N7eVK1Pfkp+DiHcr0hX4/suxr6doNVZO3vRmBTrSseFGmkSVIeUyB1sPrnnpxA+EkJ43Jgho=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1433.namprd10.prod.outlook.com (2603:10b6:3:e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Mon, 22 Aug 2022 15:06:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v13 56/70] mm/mempolicy: use vma iterator & maple state
 instead of vma linked list
Thread-Topic: [PATCH v13 56/70] mm/mempolicy: use vma iterator & maple state
 instead of vma linked list
Thread-Index: AQHYtjjCgZGDKFlEekyylTc060tlVg==
Date:   Mon, 22 Aug 2022 15:06:30 +0000
Message-ID: <20220822150128.1562046-57-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 858f242a-c3f7-4ab3-185c-08da844fe6c8
x-ms-traffictypediagnostic: DM5PR10MB1433:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nKXP3X8kFmJYr5VCFQ2vVSYNgNK2ksfQskPZKj4WnM3hG+RqkZPOriGJ9xU3SzqEP9mCs5Ln2a5phjDgVEBiiswj6O2/jYzTWndP2ZzrrmlvSUShw3VL9Sw775oD8tXx2g5eOAqEndzlIxVaEynYRnWAK3hogW+gzAAPhNWjS3561qkzTdsqrRh5XPO96PufDpNF8GVXaGM0P+6kO7pjrG9ZWYa43bu/I4Ht2Kk0FlBhUMuHShw1vzsLiwOZd6VnY86eUE/BKaoUkW57myBAFU4f/kACUZkG3kH5ybWlTOs+Ot2d4b+dtIIbQYXxOSjFOm9RAu1YM5jHjedfDbWFeYKQ3T+WEhvO85ZuVJDek+F02b0iRShR1jdMthJDfXl1Ue9T9IZQPMWjtfWeHOxqbkZutAuRKRJZzqdKI7g+ONv+ivN0pvrzFfXbX/dJJPI1oSumfgKiK6Sn4m/cuM5QYNUfv5O/Rfcun1/bO9kyCfvLC2UNVUfCyjQKudcvj5E+9bhk5BP4W1O3Mt2gqdF3SpIhSIbakrJcu8DPw3JX7I+IRhOVbvwxbwbwr2U1skNa+9yL4hNLSSm+T8WhPxrTGJJDXMkhQLYTkB8c+XoghnZjmqMeCMW6Qqm+GFAKhAJdK5F7z+e6G5BmD6/zSuSf17NxCVqsPQUtlnoSQM/Pi2DCVhhMy1zW2XsXvivT4uGvf45xvgJ4lfkE02N+BSk8Bl/9hptf8TkT34JRGT5VaJiOgS9Ty1jAsNEJPKeryfyWk5DVEzH3lsH9kBkLuC1QpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(5660300002)(8936002)(38100700002)(122000001)(36756003)(41300700001)(44832011)(6486002)(316002)(71200400001)(76116006)(91956017)(110136005)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(478600001)(186003)(1076003)(6512007)(26005)(83380400001)(2616005)(6506007)(2906002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LnB/LaDWYGsmSKV+rSq7H0PBmy7WFSvP5/zcfF/VrXXsA2W9AU+8JPTMwx?=
 =?iso-8859-1?Q?dGMcqKLUzEpMIZoka50Y/wjIIWmTWa654dwML0T3xNEgYhkLlDJdsSdPhy?=
 =?iso-8859-1?Q?byE38mviJfUJQTXaGS8rTcEQDIgMSa5V5nxXVsoVLYX3z0DhZ385efdieZ?=
 =?iso-8859-1?Q?XMP5cVqFmv5xKv3GUOW7XNDmZ43W0i1M2pERMLqmK7pQb5wqXtEuOlA3Yy?=
 =?iso-8859-1?Q?gzpyXX680MDqgjz/LjGQvfpJNne6VDOprhC3/SCecYXbsa+xMB1PHyquU2?=
 =?iso-8859-1?Q?t452j6+oNYaQZBmvwEsupyiZM/IKM467FUOMPvqyhExGECcox9xYdd6c5I?=
 =?iso-8859-1?Q?qNgPBkmOG86W2v1a/1oCCBZ1Lkzy0P2GXhiDKMRrSNs7ImnMx0Mk1kObLO?=
 =?iso-8859-1?Q?F4gXgfHBbOOu9VfArdDOFyImVMDfiIVaQczcM0cvKaCHJOusYW2avTtdR1?=
 =?iso-8859-1?Q?x+TEp993XOUME/srU0RKwcHsgHM+VihvwEX9tXxThaaAZmaVMLbsCOR+bU?=
 =?iso-8859-1?Q?xNqbdjPJTr7SVnVIYN+WAjo9NvdWMihSw+iG+jh955bmLyo8RXcEQlbMUR?=
 =?iso-8859-1?Q?yBuMy2ptpi9861EaFfCs/rJeaqQYZvwMYi7YSUaO4d+pvcuJliag5uXUv0?=
 =?iso-8859-1?Q?ThKT9xKupBFS622HmbWsgjZkETi8qfNgFJIPzqOO86C0ghAxlCcHUbBZUO?=
 =?iso-8859-1?Q?ktVz2h+0jzu3UQ3xEoPJfjBTzubA9dWTiqBA6c3bDn5uEwiIe8b6atX2rK?=
 =?iso-8859-1?Q?hiySoNtpuFnnWcXbR/Cyhd/GjoyZ3rfH7M8HMkuJlOtEL8GmRInRQz9tFh?=
 =?iso-8859-1?Q?SzUT3IycdXg0zulrWnA0KL4WTqeTajWhyjWWQqEGp0OUb7CjC5g9uzrcbg?=
 =?iso-8859-1?Q?bZ/vmvXylXYOGg+tAQa70F2dJSL0HRPXLUM7E7BoeChSvjyoLN48Dzk8uF?=
 =?iso-8859-1?Q?NA51RIcKykCMReY/TaCsrtIIZK8ESfP0tLSto1Yw22O8WHZgVhif+nTpPS?=
 =?iso-8859-1?Q?68gkBjiUEWefWO9a7gEX1pHfHcI3kea21KdaybUn5BL5ckfxZqEqKYO6X1?=
 =?iso-8859-1?Q?XY5NhZv1GVtUFjxAWTU0luy+eRJ3he5RDRcdzuJGtBrxNnWQrM0JcLWYcK?=
 =?iso-8859-1?Q?8svmDJA1qI5tUfWGHUk8IihTyUT+FUA8aZ37+o2FGIMxDjhnTrLnv1ZWd2?=
 =?iso-8859-1?Q?Vy1NLwo9yFjEnGS8txrog8K6aThYIx0tnjXqim9dw5jpNXHxA/XtlVH8hb?=
 =?iso-8859-1?Q?//4OV2dP5gImKmo6Gw7RjkkBytBbaRE/xgdfw51PmA8YmhUZh0FSo2INV2?=
 =?iso-8859-1?Q?ffkAvEq80Zx0VafAZmOZ8A+J52Fkshuhg6a63AG8iJBR7Re2Om0Z5oulBd?=
 =?iso-8859-1?Q?mF5gxjm/1Q8aWBNX/aQb86Fgfml/BVfuIyEuKfbkiQdiJksryxQ/kXx6CK?=
 =?iso-8859-1?Q?xcPZHwcGGmCAj2LHuBchgc1iUSu4/2yhtEw6Rh9ReScUWR8EofgkMpSP8/?=
 =?iso-8859-1?Q?zJqvtMiuWtSNsy3Sqj1jHJRX0Ys6ACbRsF8Zqof2kbVf08gcnUFLvOpF0r?=
 =?iso-8859-1?Q?L0ikgMl/Vy9j0FaJuIZT3nPfys0e0k8BrYv4Tyv2UlNquXIZNLE3Gw1HLK?=
 =?iso-8859-1?Q?LKk506/mm3RQV8mPpii82XMEBFpfI9EG1JbI2gH8WkN4WRcqenCJ2p/Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858f242a-c3f7-4ab3-185c-08da844fe6c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:30.2067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GK571Ur4QysinJwi3tjz5Uecy+SiaGBkofEXrtsIfAUUogyFBB66WDo4sZ6hu0wxHDaUcFZen5IJUiYn2N1F2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-GUID: SBEIw3UIBqxngy_7OkzpXpMxps4hPWTQ
X-Proofpoint-ORIG-GUID: SBEIw3UIBqxngy_7OkzpXpMxps4hPWTQ
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
