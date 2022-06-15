Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20B554CB1E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347099AbiFOOUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347248AbiFOOT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:19:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333264A3E0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:19:55 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25FDbEJq015196;
        Wed, 15 Jun 2022 14:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lmhWxVhmnXmxvHLPOyPtk7GraaRj0TzIN4wkdhlEmF4=;
 b=nOFY7FrqqGDAGM7pL8n/PSVLFVbKsyidQ2EjwaQcqBczBtMzBJJL52KXs4beKDq3fp10
 fA41YH61Of757GuMgSIZFgw8uDS5n4TutKQUw6xB21weC2NrtvR01vU5+a8A44wGA1Tg
 RUjrOWEpRHpgttgheetYHjRCMKSTy70/Oha0BsL7+ky7MgtibYm1pDVKTQF1B0TLG6Yb
 UX5z0FHYsuZ5Cmf1yAP6rJ3O53D6JL25z8BhHKV8Mrwt873GtR13+6hze96BB7+GqIwU
 HU7bcms7B+d9KGcBp8QAqvvDGjP4GFxZMRPQ6B3QI5nQW9bcKqNHIiRJYYtS1N5071m4 hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhn0gsfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 14:19:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25FDtwuU008028;
        Wed, 15 Jun 2022 14:19:43 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr25uq1t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 14:19:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTe92FeI9StVJRQ9YIPwzTc1ZmBSoAX+KvvAjbKE7kwobrk+8ZOdbzLMa75Wb/jQ6Du5LVvmfgu2uPk/wPLC+2iSLQHe3Xc/tcns41+kfUi+nkbGOWgpc7We3rRjWT3UQ7CU3wrRB2/mxWimdhfaZXHkpmAGv1RQxOo/ZuJOre7VppnYYCyfx3vWNvBLGL8DM1ebPAufNcp5XYcXeYcRaT/wiPLVNY3B74g2UsATQgowXpsHI/Ai49fteLHUd6kJQRotWWKDNlDZR3YCk5TJzJrY+2Z+Paeam/NLN7t1TE0IW6i9OqZG/V2GmGC+PpLeUwV4yp0tJbk2Sf46n3etig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmhWxVhmnXmxvHLPOyPtk7GraaRj0TzIN4wkdhlEmF4=;
 b=ejy8XHmZ6uLTZIWHT6TTMfERAmG3IEad97PFh9rvMocXLQEt6dLAAJ4fQCgPmzO61bMU/f1BG7NRFpWPbM3hnsz7L1miGcLk6Apjf+dqXMxgFyMuCWZRFtqZqiPKBg4BElMR7MHY6plrVfPOggOF0z4ekssCPbJ4UNdBBx+ESgIKh+RgZWusczBx3DNnjSP46mYuyNS4fmcKI8Ewal64XzM72TIv2M+LszdxvcBCBKo/sqEvw4uQ8elufd4TMuykhLocrcxbQBEpauuE2PvmCEnPzz1RcLxGBzqL0PlOSy7i45DQAdrrkVpf5uvQlsIJQk4sj0KgSku9gd2babIyHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmhWxVhmnXmxvHLPOyPtk7GraaRj0TzIN4wkdhlEmF4=;
 b=wRkGeQxpAWCcE7XgEfhecJf+YIxwbToxtu6Tq+79J2Lv+vpkWryCARrtlzp0LTy6aEMPFZ/7pDEaLpbANy1R6Ww09OfAidN64xUb+A901CLqQCp+BOFh5hm+nsSVzGlBPwRxn2jbAdzgjxX/PF3adQC6+ggc1R503cTXcOTTVk8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3342.namprd10.prod.outlook.com (2603:10b6:208:12b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Wed, 15 Jun
 2022 14:19:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5332.013; Wed, 15 Jun 2022
 14:19:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <quic_qiancai@quicinc.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH Fix 3/3] test_maple_tree: Add tests for preallocations and
 large spanning writes
Thread-Topic: [PATCH Fix 3/3] test_maple_tree: Add tests for preallocations
 and large spanning writes
Thread-Index: AQHYgMLzPlBKBPzE6UyrbBOdTKnb3Q==
Date:   Wed, 15 Jun 2022 14:19:40 +0000
Message-ID: <20220615141921.417598-4-Liam.Howlett@oracle.com>
References: <20220615141921.417598-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220615141921.417598-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65dc88f1-e0ca-4383-277f-08da4eda1608
x-ms-traffictypediagnostic: MN2PR10MB3342:EE_
x-microsoft-antispam-prvs: <MN2PR10MB334220115E5AD4714B2AFE01FDAD9@MN2PR10MB3342.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N5VK+SuB2O1vz92R4cJUKJz/Eht3W6JRH07f8FDzHePAz/KLaUn7hvAokKpwaGeibHFtmH5TGNDXCNfaRACu5MZ+Prgqdo2BoguBORe7Lt6WScrzGTo6ADBqhgOvKNuWs8ua7BUjl8VPtKRRY4huGFnp6qTlTamgoQrXiP3jpDAwYxpANPo/TcThpxjME8LqXEhHZxj0qrEovXrFrQ2lQh8uC2p11E7s/smyprhYa2MpFMkV7oowTHzk4aTq+ufyE1arLYc7Xxe/DZ9/7xp5Yk+leK8SH2mZ6euvjrfUSzbMEdHtBvXpqD/ehH7MSdne6qgr9s+d4tSFSYAx7Iu/+8TX8gpHycXCEXi8fWkNFdqE/hGRTPLhFtzD34TvF8aSVxgGpEBPQegRVVBMrbqPqH4aJkB1ZekCz0CiiJFxeldfk/pouLNDVDnucmnuqDseGHf+HoIB/zf4QCWf4EFKj4XoH9ey+uTS1uOtc0852gbktbV2Vpd4VV4dXdVGqw+B2lAtoRrbjRsJlVFUgeAdOh+Un/1tenaJN8V4iMfN3K34erKAFzRQUu3NLo+P402/3toi950LXxW4+1ELEJ91CVRglxt/VuvjgUXbc+P1PCoymtksLBtcWoUn+lAELAGOVwaocwnR1enNacvt+tl8XMw9Jzexe8sRO1sas7TqwMVmgm1LiZ9k7gkDlvlsQBiWlszPBq1/MnLM4mBtX/zArQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(86362001)(316002)(122000001)(110136005)(38100700002)(186003)(5660300002)(4326008)(8936002)(2906002)(71200400001)(38070700005)(66556008)(64756008)(66476007)(8676002)(66446008)(6506007)(76116006)(91956017)(26005)(6512007)(508600001)(83380400001)(6486002)(1076003)(36756003)(44832011)(2616005)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hcidxkiWufkod5PZJorYTBYQoQvX6dflMKTRauwxGSYaeL6D4o87MGPOqA?=
 =?iso-8859-1?Q?EorjqXogLSFC+XpfsBd1mYWoH8wjyuLbUK+YpkCS3Q8J5SHmGi17781SgJ?=
 =?iso-8859-1?Q?TY0WfRTW7Ai21IsfMqgWS6f1rrG3gqaz+AgUQaPGZsovfrUQGigTRs+Uca?=
 =?iso-8859-1?Q?UPAAIcU2bwuKBILtBJxr+j+PTjOwmtTJEEhtt5NvvrN1ygKRpyKp5NWdqJ?=
 =?iso-8859-1?Q?cQDs8xLxtp5eaNBOnXLCfzCjhh9XATajaheD9USyRj9BW/9x3jX7Lj2ppf?=
 =?iso-8859-1?Q?ZLVIQd7KnAUVFCSJZzDG+18ixv63cusxzdGTVPCJaYRzNI/wBKl/xg3b/p?=
 =?iso-8859-1?Q?kXjy0pBPxSA+7BeCD9KnafLNNAiEX6vG4/2Suq1vAEqkML70gSdGRR4yhg?=
 =?iso-8859-1?Q?mhgfw9fa3KhP6zeZ3cRIM9IpoKBoh+q7WVjQNKVV3EbpjobkzhQn3jqphn?=
 =?iso-8859-1?Q?axHJul5zZQjTj20tI/MqR63jDCg/fOVv0MxS/eZwWtyKuC1uhAZvJOT35L?=
 =?iso-8859-1?Q?3w6mOEAkyarHVFALUGjG/BVk2hh2wzQpgyKAQhwHy5PzD9uwHQZ4mT3PXq?=
 =?iso-8859-1?Q?teaN08pwmvIZpDJBiHssv30ysJGp9m2Jw5CqAFiHZP2U1V1MND/koHTIPp?=
 =?iso-8859-1?Q?DHa8vLy2iiYTiQ7TMwBuLwCQN9sNWNkTmVaVx3DacNXclwrl9iZzruqLeZ?=
 =?iso-8859-1?Q?KYPEibi8xEVzI5V4x0m03haN4yex9qNr1djDdZh49zItHuN4Y4I/eNbCLi?=
 =?iso-8859-1?Q?7VseZF5k0GATxcfzYtkoboc8VHuVMAAmNrArJBiodC8wQMH9mPxYZi+fU8?=
 =?iso-8859-1?Q?XJ5xVY4g9SqRFieguTEWv9LUslP9zo/kF/eKfc5IRVeSwwptEJylekk6yX?=
 =?iso-8859-1?Q?mTH9gzFhKdKQKvObmC6eQV5MSiTH6glF6/pVECWblE3a4Q7RT/ENTU7wGQ?=
 =?iso-8859-1?Q?hRP++Cif8BDMPJKugnZbF+eZXwbzQTb3MT+1cmSo1+Zpga6UPwYtRdJdG9?=
 =?iso-8859-1?Q?2NE1yPXfzOtgk/CJAdLZt9ZA2tlWpHYQ36b4NEq35drxC775QknWot/EQM?=
 =?iso-8859-1?Q?8WU6fGYa5KGhCtcCF35nl58B5m86FqvzIoKrjqyfJyH3kDy+8OqZeXPWoV?=
 =?iso-8859-1?Q?D/ID6NskdecmVQqsXw9kvJFxx3hO9qarrLTYBKU22fyIKiY2JbK+S8I02C?=
 =?iso-8859-1?Q?9RyAaywES731DmVRykHTMynCb7Rkq4SKHACY+f3sDlg3JtGKO2XfTwl31H?=
 =?iso-8859-1?Q?llNFml9+C+VpqjsiAIc5Zeol35slQw+j/QBmOKOCPYx4846RIQTsSv5VzQ?=
 =?iso-8859-1?Q?BbzvyOUA0738XyxHBXJABzTxbtwGlkwOgiWsmFE0SWXko6lRlBrBtsUU1M?=
 =?iso-8859-1?Q?2KLtfIuKzvA6+ZSMWVD40NTc+Hcf76fJoBKAyqEkLun/lweSh1CNieTGxl?=
 =?iso-8859-1?Q?k4iTCCUhwP7VtL1+f6y4Od+zBVH+pjuEZynaUmjZs0bnwGnvAhOOluJEne?=
 =?iso-8859-1?Q?fBrDtLFvJw2OaWCBcWmoyUiqbkbCuDnr6rFe2VfXC9eqL/Zw7hnIUS4oPo?=
 =?iso-8859-1?Q?J8bhHbNCqSh8rQLpSL1C1Vy0zkX231aU9vFU2l7CJwm2RbzsnNm0Ap1Q0h?=
 =?iso-8859-1?Q?7kOkmjx2ZTvxTCjc46RR2UMaAIgK7DBi5MSfBy/f/KoVgTMwVFoYyrypwE?=
 =?iso-8859-1?Q?EXK+ZNm7waiZgj9fHbfxQx5eznNycd9SPN6mIZ8V0cJjgJ0YY16cti2iqq?=
 =?iso-8859-1?Q?KL9vtnHPvXNauNBITyaAea2JFJuHFIsknAcC9+Qz2TKmXbJDaP6zhvUQge?=
 =?iso-8859-1?Q?kXKDa+2L5pNqmCnfyXUNvckBUvhwUJ0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dc88f1-e0ca-4383-277f-08da4eda1608
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 14:19:40.2066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yCWr5YEwKqJy3V5rroj8Mz42h3ZMMK+VGdZ3P6WVpYlNJlwwuhUaJF6ezravBGRNhbsft0k5w3l++kxKFmLsKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3342
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_04:2022-06-15,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=988 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206150056
X-Proofpoint-GUID: Ftfg1-lK1bshmzOmxZX8RIUQ1tpDuS6S
X-Proofpoint-ORIG-GUID: Ftfg1-lK1bshmzOmxZX8RIUQ1tpDuS6S
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add test cases to ensure preallocaion works.

Add more tests for spanning writes which alter tress with many levels
and covers more corner cases.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 277 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 277 insertions(+)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 8277464e182c..9fc0618f4ae7 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -35537,6 +35537,275 @@ static noinline void check_root_expand(struct map=
le_tree *mt)
 	mas_unlock(&mas);
 }
=20
+static noinline void check_prealloc(struct maple_tree *mt)
+{
+	unsigned long i, max =3D 100;
+	unsigned long allocated;
+	unsigned char height;
+	struct maple_node *mn;
+	void *ptr=3D check_prealloc;
+	MA_STATE(mas, mt, 10, 20);
+
+	mt_set_non_kernel(1000);
+	for (i =3D 0; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated =3D=3D 0);
+	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
+	mas_destroy(&mas);
+	allocated =3D mas_allocated(&mas);
+	MT_BUG_ON(mt, allocated !=3D 0);
+
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated =3D=3D 0);
+	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	mas_destroy(&mas);
+	allocated =3D mas_allocated(&mas);
+	MT_BUG_ON(mt, allocated !=3D 0);
+
+
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated =3D=3D 0);
+	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
+	mn =3D mas_pop_node(&mas);
+	MT_BUG_ON(mt, mas_allocated(&mas) !=3D allocated - 1);
+	ma_free_rcu(mn);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	mas_destroy(&mas);
+	allocated =3D mas_allocated(&mas);
+	MT_BUG_ON(mt, allocated !=3D 0);
+
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated =3D=3D 0);
+	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
+	mn =3D mas_pop_node(&mas);
+	MT_BUG_ON(mt, mas_allocated(&mas) !=3D allocated - 1);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	mas_destroy(&mas);
+	allocated =3D mas_allocated(&mas);
+	MT_BUG_ON(mt, allocated !=3D 0);
+	ma_free_rcu(mn);
+
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated =3D=3D 0);
+	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
+	mn =3D mas_pop_node(&mas);
+	MT_BUG_ON(mt, mas_allocated(&mas) !=3D allocated - 1);
+	mas_push_node(&mas, mn);
+	MT_BUG_ON(mt, mas_allocated(&mas) !=3D allocated);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	mas_destroy(&mas);
+	allocated =3D mas_allocated(&mas);
+	MT_BUG_ON(mt, allocated !=3D 0);
+
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated =3D=3D 0);
+	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
+	mas_store_prealloc(&mas, ptr);
+	MT_BUG_ON(mt, mas_allocated(&mas) !=3D 0);
+
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated =3D=3D 0);
+	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
+	mas_store_prealloc(&mas, ptr);
+	MT_BUG_ON(mt, mas_allocated(&mas) !=3D 0);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated =3D=3D 0);
+	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
+	mas_store_prealloc(&mas, ptr);
+
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated =3D=3D 0);
+	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
+	mas_store_prealloc(&mas, ptr);
+	MT_BUG_ON(mt, mas_allocated(&mas) !=3D 0);
+	mt_set_non_kernel(1);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) =3D=3D =
0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated !=3D 0);
+	mas_destroy(&mas);
+
+
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) !=3D 0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated =3D=3D 0);
+	MT_BUG_ON(mt, allocated !=3D 1 + height * 3);
+	mas_store_prealloc(&mas, ptr);
+	MT_BUG_ON(mt, mas_allocated(&mas) !=3D 0);
+	mt_set_non_kernel(1);
+	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL & GFP_NOWAIT) =3D=3D =
0);
+	allocated =3D mas_allocated(&mas);
+	height =3D mas_mt_height(&mas);
+	MT_BUG_ON(mt, allocated !=3D 0);
+}
+
+static noinline void check_spanning_write(struct maple_tree *mt)
+{
+	unsigned long i, max =3D 5000;
+	MA_STATE(mas, mt, 1200, 2380);
+
+	for (i =3D 0; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+
+	mtree_lock(mt);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mas_set(&mas, 1205);
+	MT_BUG_ON(mt, mas_walk(&mas) !=3D NULL);
+	mtree_unlock(mt);
+	mtree_destroy(mt);
+
+	/* Test spanning store that requires a right cousin rebalance */
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	for (i =3D 0; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+
+	mas_set_range(&mas, 0, 12900); /* Spans more than 2 levels */
+	mtree_lock(mt);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mas_set(&mas, 1205);
+	MT_BUG_ON(mt, mas_walk(&mas) !=3D NULL);
+	mtree_unlock(mt);
+	mtree_destroy(mt);
+
+	/* Test non-alloc tree spanning store */
+	mt_init_flags(mt, 0);
+	for (i =3D 0; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+
+	mas_set_range(&mas, 0, 300);
+	mtree_lock(mt);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mas_set(&mas, 15);
+	MT_BUG_ON(mt, mas_walk(&mas) !=3D NULL);
+	mtree_unlock(mt);
+	mtree_destroy(mt);
+
+	/* Test spanning store that requires a right sibling rebalance */
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	for (i =3D 0; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+
+	mas_set_range(&mas, 0, 12865);
+	mtree_lock(mt);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mas_set(&mas, 15);
+	MT_BUG_ON(mt, mas_walk(&mas) !=3D NULL);
+	mtree_unlock(mt);
+	mtree_destroy(mt);
+
+	/* Test spanning store that requires a left sibling rebalance */
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	for (i =3D 0; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+
+	mas_set_range(&mas, 90, 13665);
+	mtree_lock(mt);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mas_set(&mas, 95);
+	MT_BUG_ON(mt, mas_walk(&mas) !=3D NULL);
+	mtree_unlock(mt);
+	mtree_destroy(mt);
+
+	/* Test spanning store that requires a left cousin rebalance */
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	for (i =3D 0; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+
+	mas_set_range(&mas, 46805, 49995);
+	mtree_lock(mt);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mas_set(&mas, 46815);
+	MT_BUG_ON(mt, mas_walk(&mas) !=3D NULL);
+	mtree_unlock(mt);
+	mtree_destroy(mt);
+
+	/*
+	 * Test spanning store that requires a left cousin rebalance all the way
+	 * to root
+	 */
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	for (i =3D 0; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+
+	mas_set_range(&mas, 32395, 49995);
+	mtree_lock(mt);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mas_set(&mas, 46815);
+	MT_BUG_ON(mt, mas_walk(&mas) !=3D NULL);
+	mtree_unlock(mt);
+	mtree_destroy(mt);
+
+	/*
+	 * Test spanning store that requires a right cousin rebalance all the
+	 * way to root
+	 */
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	for (i =3D 0; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+	mas_set_range(&mas, 38875, 43190);
+	mtree_lock(mt);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mas_set(&mas, 38900);
+	MT_BUG_ON(mt, mas_walk(&mas) !=3D NULL);
+	mtree_unlock(mt);
+	mtree_destroy(mt);
+
+	/* Test spanning store ending at full node (depth 2)*/
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	for (i =3D 0; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+	mtree_lock(mt);
+	mas_set(&mas, 47606);
+	mas_store_gfp(&mas, check_spanning_write, GFP_KERNEL);
+	mas_set(&mas, 47607);
+	mas_store_gfp(&mas, check_spanning_write, GFP_KERNEL);
+	mas_set(&mas, 47608);
+	mas_store_gfp(&mas, check_spanning_write, GFP_KERNEL);
+	mas_set(&mas, 47609);
+	mas_store_gfp(&mas, check_spanning_write, GFP_KERNEL);
+	/* Ensure the parent node is full */
+	mas_ascend(&mas);
+	MT_BUG_ON(mt, (mas_data_end(&mas)) !=3D mt_slot_count(mas.node) - 1);
+	mas_set_range(&mas, 11516,48940);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mtree_unlock(mt);
+	mtree_destroy(mt);
+
+	/* Test spanning write with many many levels of no siblings */
+	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
+	for (i =3D 0; i <=3D max; i++)
+		mtree_test_store_range(mt, i * 10, i * 10 + 5, &i);
+	mas_set_range(&mas, 43200, 49999);
+	mtree_lock(mt);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mas_set(&mas, 43200);
+	MT_BUG_ON(mt, mas_walk(&mas) !=3D NULL);
+	mtree_unlock(mt);
+	mtree_destroy(mt);
+}
+
 static noinline void check_null_expand(struct maple_tree *mt)
 {
 	unsigned long i, max =3D 100;
@@ -37678,6 +37947,14 @@ static int maple_tree_seed(void)
 	check_new_node(&tree);
 	mtree_destroy(&tree);
=20
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	check_prealloc(&tree);
+	mtree_destroy(&tree);
+
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	check_spanning_write(&tree);
+	mtree_destroy(&tree);
+
 	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
 	check_null_expand(&tree);
 	mtree_destroy(&tree);
--=20
2.35.1
