Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DAD5AF50B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiIFTzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiIFTwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:52:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A96654675
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Icrab007596;
        Tue, 6 Sep 2022 19:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=KIJZOSLvZFnAHVkHTOMjcAPZ+OXLaDolbEcaV5P3BzM=;
 b=V0/qdJl2I1AH2vfrMRV6jf+OPimtpaQh2VA4x9GY8qJ7wbYTWJj65ZMxQDB+sAS3pxQK
 JSXvUig1VhW0jcXoyOsVROYy7/mSYtjzj3ke3s6bvVMJJhG9Ck3jamMi9lLRY1qJN4Yk
 pu3qNE141HWogmqp+EiGzSRFiJecx9kbE+5ixi5d8ATPIWFB2q1dE8nIjw2S1vl/IGzE
 mqAVLddRwZj/fWeAzR4UdtmSckpD/MBOXiLESTQoTxixsMVPndenCA3G3Gi1Nf4OVI7M
 a5anv1YjTZL800h9czAI4sYLHN4HVzarcSgTiRRHVj4L4q1lZkxOnKTV8CFujr1yNFxp NA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwbc6uqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:50:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286H8hVW027546;
        Tue, 6 Sep 2022 19:50:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9kxfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:50:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DE1vlkfztbWfHA6STb7sHcaBMGbDu/A9Y5i+EnKR+J5G809GLXJl3WHBZid+chOtsc1H/f7KZL5qNTT7nT7FIxqcV8K0y8Ct1sIQ3rgoExY9hLv/wWLEa2iZBJZy7+xB1Gff28XRcmPvdF/583EoP6OE9CNh7t2CJWvjoZPTdSrTgUHRATF4tdtUrR95o8inbmqVtl78pvnGImYwa4DANuRrxWZLYGqLBsEEruqIzs64SqOIGe7MQEGtVuL5yHEDX2vPBUvH+qP1nlBXvAWEipFE26L2SjSRoHQHiGRla20d1kSY6eQYgrbAzLRWgqWwriyR36a8m1GiF2Txrm+9Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIJZOSLvZFnAHVkHTOMjcAPZ+OXLaDolbEcaV5P3BzM=;
 b=UVLg4FLzS1KcVvJ//hL+sPhW5qIOnTcIMdpSv8MbSCySFkje94JaNugq5gBKKqV+IfDH+A6b5yudTx+TAa9vfn5Pd4Q0z2zC5JNhsGr5rvEswBcB+6qswODMri9+H5FMCCadvPi/CLnb7awnyKAUUg9slrBaRRM0pS/PLChgu9g6j1vJVPK3qN0s3tx4WC0KNa4/DDIf4608x9b4IjxXmQ09Erqpq2hOpWb+D0NnJqvGN9YCjC8D+BTeP+9L+4cr5OX+wAWthSXTrErC5B4dvOTYjJOunin9r/xMG6pQ900O7oTfNlv/TQLSswo4r84hN8ipLdgoKIkag+Ou8CHTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIJZOSLvZFnAHVkHTOMjcAPZ+OXLaDolbEcaV5P3BzM=;
 b=VFi3O7m1pXqIYHEnT1ENaBQWWp38BFNxLQG6QAjqdcpF7pvCJTEiQJm0ACQ1zJItnCdxAI4ea2tRDW6JPtLxLHEe+XJuc+JbqLFo2XabQQDSEAJoGsyr6ENL7/wuwa7twabT5mm2NiQ95wSrIQOH4TCK9J80UwewT2cs0YUNGGQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:50:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:50:21 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 63/70] mm/swapfile: use vma iterator instead of vma linked
 list
Thread-Topic: [PATCH v14 63/70] mm/swapfile: use vma iterator instead of vma
 linked list
Thread-Index: AQHYwim4mQV0z9dWukyX631ptD23pw==
Date:   Tue, 6 Sep 2022 19:49:04 +0000
Message-ID: <20220906194824.2110408-64-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 415d0bd6-7762-4677-70be-08da90410861
x-ms-traffictypediagnostic: SJ0PR10MB5598:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 48nQkRUjw70e/Unpx+j70M/pVnefAHTJFrD0yL6UcApNoSvFoe8xCgq5NngIyRygc4V87K7TYnY8tIgyZ7Qr/jKpLNkRX4VqdXbwRcaWbbC2Ll1nATvWhOKqFV9hMmROZT+Q9IlpabsZ3rZ5uW0D854ywXAC1r0n7g0uuU2Lnia8oRCflSeQmCRW07q15wGlWGCAkoj/8au5pl5tG1IxHkzo4rjqMbeOmrQLBPZkBJqy/xFJtVfWImiFtpTTsp73h8g8PKmwNnzgTNYtyDyfh8M/vqB5G/lMxbGx8GlVXwNErNijbLQvswGSAmzCj0yvKO0cEP3GvaYcWVEVvuYJ5uTzw85iRD6zcrH+k9WTLLvCKLDUDxfslMGKktuG7FQjLIeKLpcq2RHy+NuHHnCmQvHA+uH72Oc/fG+4gaGjolQuDT0FEZPOfg09CmK47r83guStX9AqGzeoIeD6+2wuOekxapj/nM3cnDEc1/33Iiq8i6Pz6mSUbv8h5F+m4Eq5ASCPX+G+3QQJnLXM4otW5xEZQHcCAlXIaX+1hryKZPCZBonyH8tt+p4mUZSOOypeVfp467w4zGVjJy6lACSRcyyCofCEixMU4rWLd0QYdYOQuIQFMcBcRfIrLT9pWUW6xsXJu5sBqf+DU3BfJPzC719Fx11+ds3ugv2YwAx0CJtrfDXyOOA/S7tJjJM7+h24GiKmis4/kPsBxADgE1hWKnvYt1KbLhPAS2z3sMojaWQqqYA8NeWDdOQq6tl0QRovpHlJ8gl77vRjISEm6ya7qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(376002)(366004)(64756008)(66556008)(41300700001)(91956017)(76116006)(66476007)(66446008)(66946007)(71200400001)(54906003)(110136005)(36756003)(316002)(6512007)(44832011)(8676002)(122000001)(2906002)(6486002)(4744005)(4326008)(186003)(8936002)(5660300002)(478600001)(38070700005)(38100700002)(2616005)(86362001)(26005)(1076003)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yej1TkAuj4wJBp4Lqth/s8XQ5N+gvpyyf/krMXujKHL5gtAjPTO8REtSmx?=
 =?iso-8859-1?Q?IbKIfLP5h2MDhFxzWRLVAYCV7i+n3Fc07xvcneJIBAZCsg2Z4ISSKxKg/W?=
 =?iso-8859-1?Q?ATduRJkrIIMt/eGuV9wtFYlPo9mY4qq8uIN/1eBlyZXeZ6lGGjre+0RdPs?=
 =?iso-8859-1?Q?Isjjkqgk73aKGcMI81e4JUFa8+KOZxOQGnxgJpBCRz01hPxbfDCd6xibyq?=
 =?iso-8859-1?Q?Lw0Hmme9Ji8xUWvGUY8+1GOSHsQUlHMuN53GrChQX+M9WUJvwB5xdzx6LT?=
 =?iso-8859-1?Q?PMhoQegDVFeInohGBOkjF0AJZE4niL2kUD1NSW88DPar/3kEDfruOz8hGB?=
 =?iso-8859-1?Q?y+xeRatqPTBK1ghygVwbdz4fAwMw0jeS02Hnf0A7SOADlHtlGUywHMYBgx?=
 =?iso-8859-1?Q?NXPbRN8dZkbuT1Z1WbL4uUKZ68kcBVFFa9J1Vyht23Bi0O58oYnq4krkM3?=
 =?iso-8859-1?Q?mTAEPyH/89pg8oQ19f0UAx6PZl77PA/328lJS9/7AhrfXDRZEfD0rRL58z?=
 =?iso-8859-1?Q?jCRpYq5GmJ7/c+mBjU10WfKdNyyTuqeDMZ6D77/j0SjH96srjUdw+MzfpN?=
 =?iso-8859-1?Q?2zLq7/afRSGq7k2u+/ZMChtaolu6gT8H+flnGA8VvjxD4Ec3sUhQ+SYnLM?=
 =?iso-8859-1?Q?V9dgl/D3r1z+a7BPHng14qQgpasAiwMKapJuQFi4h75vsY7cHpftrHzZw+?=
 =?iso-8859-1?Q?n7r8k2oJ5f1n58KFRZ9kW5nJtOd9pEpfSny41pYrZpTHTI8zSvuZELiDOq?=
 =?iso-8859-1?Q?bs1YBUphb6DeteveUEOh6rTEksaFhsaPjATJVEfVAcyC68AwDEiJrQnomr?=
 =?iso-8859-1?Q?581tLQEF/s+3VKp0ZV1OIU9NLC97glHwSLXB6hpWv3xE/voCTKL1AvShol?=
 =?iso-8859-1?Q?+fAFcx/gg8o3EYPwgHc3+VkiPmW0Pu7KboRcrHtYu7rDvG80KmUvEnzlb4?=
 =?iso-8859-1?Q?oD8n0C+KEUjcaesBqYk5y0+5bo3dJLWth9KCJBK3NDzCdSWfl9CbflzA52?=
 =?iso-8859-1?Q?lSFznqGnPipi81/OHrlbyvDwzU9xjGN//VGZx37JWOXQRp3O+5aopVth0d?=
 =?iso-8859-1?Q?bVJTd9ca3Mxgvxz954Fj2dut1AGOyCSvCD+c+BD+e4wrPBMmx4uu70GuyB?=
 =?iso-8859-1?Q?YynSHaHRpgqpwTXKkWswYgsHSBIre8HvK6hcRY49yrRMlX9jzkWdfu1RqE?=
 =?iso-8859-1?Q?Jjqo8AY54IwaQ4UQSzdlr8ThRi2WHQC+TwcFrvaH2TLKUKp5Bi2qkdGRrK?=
 =?iso-8859-1?Q?JC5SU/43jI+5ako9Ll19SQOYkQZXI48BJFNGKqvvK1xAct+qNTYXuEEJfy?=
 =?iso-8859-1?Q?krHkGExw8lgIVsfoarm5bJfX5rVtlxHssOzMZP2pJKKhmDz8Z+Yke3gSua?=
 =?iso-8859-1?Q?X87JU22geEjcIE3ZefbJsr9r3wBrl5C5OLocTUdvqbC+hDYWSkroXlqbLV?=
 =?iso-8859-1?Q?82/20Ts4ZQqXcfQrTCO9HBqm3KMZAeT6dAOQcvtnjkXeO0Dlo2DsxwktXW?=
 =?iso-8859-1?Q?N/XnInvPJXQIOv7e2qSnpGykxfU6TMrsEKQItKh1vrZw5OB1XlBmnic028?=
 =?iso-8859-1?Q?9orcQwfscS8HxnvH+7VWzWEknZniF4F2yFuIe6DNm6pU7RVyYJqusfa2Rm?=
 =?iso-8859-1?Q?hmOUnot6dDx1ZzMkNuleKO5z5DVh44+k0xRnWvNQ1T/17HV/F5OjqZ4A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415d0bd6-7762-4677-70be-08da90410861
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:49:04.5057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Htki4zzxZYUAPRDEnUIdtc1VSSokqmTKH9W713MP1fgzaWAH81MetFfjrBRaNEsFwwM0UIkrjNK6bybvdg/67w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: yUdmyJOK5m62jJ4swg0GMpZc9OhVwcoU
X-Proofpoint-GUID: yUdmyJOK5m62jJ4swg0GMpZc9OhVwcoU
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

unuse_mm() no longer needs to reference the linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 mm/swapfile.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 263b19e693cf..469d9af86be2 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1994,14 +1994,16 @@ static int unuse_mm(struct mm_struct *mm, unsigned =
int type)
 {
 	struct vm_area_struct *vma;
 	int ret =3D 0;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma->anon_vma) {
 			ret =3D unuse_vma(vma, type);
 			if (ret)
 				break;
 		}
+
 		cond_resched();
 	}
 	mmap_read_unlock(mm);
--=20
2.35.1
