Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACB7553C07
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354901AbiFUUv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354728AbiFUUsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443D82DABF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:12 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJEdKq012601;
        Tue, 21 Jun 2022 20:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YmnZFCerqLE2iKImQqpCnAfR8wuNqaHai9KN7+UIC5Q=;
 b=TaeFftG1RO+2Fo/M3miZKBunpPR8xg3micI9V0glRxDGUN5z2bOcx6Fs6ppDqvqtWGZq
 nisRPlBQkhONHbzKZtw1vW7RHxsqrx1nmZSccdXmZGw4pkLdwXo6XVpupEP0qEnL/Uoy
 5zHts/pAS2gO4t9AdAzSQ8QN6bIEMZBXiy+r8swURXpevWzkXadb5wT8sIfpMSWBtv54
 FHxH3f9SLcT/hzQAxgX6NlcIDxwfz2zf/Sku3B6NsZ0hgCQ1y48vC2wqF+MpDwSFT0Qj
 Di53/VDFlNenyyXdQHQlg4OD54eKa6M2tNq7MRFqbpXmpOpufWQwpOxWHv3vB79ObPv2 2A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kf6kj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:48:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKdvMH010099;
        Tue, 21 Jun 2022 20:47:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkfuvuke-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nP7LpUDktlIdeAdCgUOHl0WWErUvJXcX1XDa7+QB8+L3pEzPeuN/0ZY/SdqFTEPEtnuEc59DRheIPfZOQw8c7Nxj2R7GOqVtwE2ye0GxIi2AsTQRN4Xfv2YBZIkug7rUqw1wbKDftLZtA6VwyXYRHxj47n4DZ80u+c+BjoNazeIM0ha6dIZrV+GtRxot/rFAPD8B84hnPIL++CEWoyGJrbzmPHvL4SnwiLorpXMIvieOGvQtawtfPkUMR+Mbqu/PtwLy5tajKamz+hcYOyMo34JH76wPxmwVYJkI5Etcmkny6FotvnTUJTqr0QjCKQE4QcZdKLeg15JxJYyY2vJCrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmnZFCerqLE2iKImQqpCnAfR8wuNqaHai9KN7+UIC5Q=;
 b=As/1DrseBHCroL6TcmW+hTd+uyZDfGHgVRBbOPIzmwZMrTEtIH5sDfyAFIECTPsG+/spU4A5zmT4P7n1r8e6AUYceHMxVpM7tje8lbF07SgXows+zNFlKiAlpSkev5nUVV2ueQwQw7/q91fXLugp5bhHUX+yG59gK0P232a9qc9J7F93Z4p3brWaqWPqL2aJGiM6tGetGsoLNtG9PlUqOMO34bYkRasELio+VqLDfpKKUF8BxAq5GWlBdfRrdN6Eq/T2UzLh9HQIFSU+NSnqOykUVRMSWCzVzkO9utcd0nW8wdIgeQb2sAMxa64YdzmKbAB3XUOjBYowMayJvbDf/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmnZFCerqLE2iKImQqpCnAfR8wuNqaHai9KN7+UIC5Q=;
 b=gaScYlhDZk6vverGb8U5z3HOPOJIl49zr6xxMQRb/0k83Ez+F9mDRd6HeHY1Zxwk8YH3K63B7c705j4cAYnf7m+oDaoBZXgMGFQsEqq80ivTPSYoDRQftPiUUZq1Ckxs/g52ReUX6v0pyYu1Y8pUMgzfHwe0bZMQyxYMsjkDgxo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5392.namprd10.prod.outlook.com (2603:10b6:5:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 20:47:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 54/69] mm/madvise: use vma_find() instead of vma linked
 list
Thread-Topic: [PATCH v10 54/69] mm/madvise: use vma_find() instead of vma
 linked list
Thread-Index: AQHYhbAUsMMqyIkkOkKpjDbJU6C4Bw==
Date:   Tue, 21 Jun 2022 20:47:10 +0000
Message-ID: <20220621204632.3370049-55-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05187687-7523-42a1-326d-08da53c750a3
x-ms-traffictypediagnostic: DS7PR10MB5392:EE_
x-microsoft-antispam-prvs: <DS7PR10MB53922CC628D49815B7071390FDB39@DS7PR10MB5392.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fjn7ZHTPpWCvsazAIFrCLESww6mZ/qvE/LRXDwfOJtqcwUqiiFjgt/3og/TKTaIz0FDBG6oyyR8+HVvSESc2pRxNcgG258WmLgn6kWZJkI2xOXy3sM7G9h6bSF9g5UC7zdui5oVkYfqfEgN3A59nBQX2AfkSTurBufQKeMgsqWcsReHstWEnpGftlpDCcz+V/OGjqSwee0nW9rxIUDHGe/3sSb6W6VXNRFn3wgjcxW3RIRfW8/guttMcf4m9ZBSO5pGwSXOP+SF7oiseyvrOOjDqE5yehSBe00ZsrGW8/6dVyMlnarI3LfAA4LwdSmfBzPg3a5//z9oLMSWvEcBYQ/IKvaDd87D/tMgZV1xWNylbOKxMnOjLydFYDQQIuk0eaXrmRGivmBf6xxEVEMnYZAGqR+C3CSdWYMsa9WfDh9Y1vzwr7vycyw1JbSPkHvRGzkE0Sc9KaxnK1EteizykwoVh1LN4TnrAXCvqcwHHq+iwxX3wGoCEYgqqTEQEZMtabRHmehScfa7Nh7ULznk9G1gDWAK/XjwIL55wnvm9o2bILyBD72y6cDAxPRzdBJBMXz0Nhs4pXl5K7FrB3ds4HzOuWkdsXHyI1x5DOGJR5mIJRZC1LB5lVZbPbpwyYTjGDh5rtZuXAwfi3qcGU/IXBknjU6fTPaHHpK65yZ9bIjxztGFl8kFUErmAgHBMlcEJhe28nLqDpijQId1oLPfUN9TX+nqKnsX5xj0n/bkvjanq203Cx9kZAuYUHGi+uzy/IsDupYIYnyPzFIzf0QcaWpznQrO/Q8VAajt0NXgkaoU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(41300700001)(6486002)(38070700005)(2616005)(186003)(86362001)(26005)(6512007)(38100700002)(122000001)(36756003)(1076003)(83380400001)(316002)(66446008)(66946007)(2906002)(64756008)(44832011)(6666004)(4744005)(6506007)(8936002)(66556008)(76116006)(66476007)(966005)(478600001)(8676002)(91956017)(71200400001)(110136005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MuIvJvIoDFKghT81qs05VcE40CIe+3upNpwnChCumX2tqCii7B+7vcqR5P?=
 =?iso-8859-1?Q?FpusDjxdues8xVgnzwCWxCTklEFusYg5lpDq5fCC3e8XRYLS4NTOBj7P20?=
 =?iso-8859-1?Q?phGjDwUwFzI1BWuqUhNc0mFlo1o/872ECnIjIki4048I8yh8RQ2plmuaSC?=
 =?iso-8859-1?Q?tnP17sK2tOQS7pYau0NmfCd7U4U37K/a1kQQRZr148dYvOVyGwAhOCX/p8?=
 =?iso-8859-1?Q?EL21m81upRsawcLn3hG4qTLSI1eIpTdZa4guRcyoReps4iwU4W9T7tVN+B?=
 =?iso-8859-1?Q?8bfdd21dfKYL9q3gZLywJXkFfw5BOQwfv8TBD9im/Q0iM1P+K9tMC/GVY3?=
 =?iso-8859-1?Q?mNhCjgUQcEbJf8pdE1rleajqzwcY3/VUsF/WLrCy/ozUR8FngVpswLtA+9?=
 =?iso-8859-1?Q?lu1y1xpTGCTnwmeot/vtgBUd+/gqw9SVBLDgy4I4bgQHzXS6tSneccXI9+?=
 =?iso-8859-1?Q?TygFlIPeKYnRJxNDQCQKe/3/AMTpCqCekJjDdhdwJk4DKOZmhQYXZuRokA?=
 =?iso-8859-1?Q?heb4cYtDV9bmtVSl06MR85tGVsSw4t9CeLrlgj8WtxR7U0qTZtB0LmVDim?=
 =?iso-8859-1?Q?KOGR5pQ/Wz2obpmW0wRacsC3BIcZnD3Bnw+uU0awpb8Sx0q0Fu4LsrpOel?=
 =?iso-8859-1?Q?vV8uKiPeTgxg6m/d6JF0AqB4CmdqyEjSD0HBTMiVdZ1Ny69Gd+RIceYMWq?=
 =?iso-8859-1?Q?Nq8n45anZFFczQzWEMLK6jQzSdv0q5klXA6txkaxeOATL9xlndnXwv85B0?=
 =?iso-8859-1?Q?eb5P57qMP1z4rJ8zNLlrsRf3oDlz5HPJjK8117qCk9CjoT1wFgU2G01iHy?=
 =?iso-8859-1?Q?/t9RZsouJTf4S1JFVh7C9zugvBrLZr6z9WiBG+byr2WijONg9Kjviiiwyq?=
 =?iso-8859-1?Q?A/XYOplByN34fRSgWqOZ2DE9KWKLFxeZHbU+patBTBtVLu1M6a+qffb6oV?=
 =?iso-8859-1?Q?8rbJNbWWeFA1GMtrG9ZoAQvFoZB1NdrJR9DyPH8ofyZwTJ3zQEmn1R3fh2?=
 =?iso-8859-1?Q?BCDC0UZMJvxGbYXuNL9g/9fcWpQTnTDelPKHTLsE3j+zcJyZnqL1Mp1e4l?=
 =?iso-8859-1?Q?zyL4r4LdNe/L+ZxhroAxLEj5iLGs0+pRfQHuYYLrccAXzZudDj9KuX8582?=
 =?iso-8859-1?Q?Fd2kZLawdmaqYhmVkcm1Hw49RBJzFmFHDAQbXTW7s7TRGqtLZd/fpEyQci?=
 =?iso-8859-1?Q?hhLcFdR+D7NJj3u4vmTCl16et8VqzJQTwauIyBqHFUph85vyapx66zcXee?=
 =?iso-8859-1?Q?hcM6XbtjCRnrsYmd5Ir0MxTS3dqXlIu7aUSLZsLZXlx3odKfRhqjg3Kw0O?=
 =?iso-8859-1?Q?v9yumsqaCfaYLrw/9wLCTcJR7i+tlPG4eojw7JpxrhEm7zxuugfcEb4Hdw?=
 =?iso-8859-1?Q?kSCmKmT72z3cUU9ps9zBoQs2t7OxeWCH5tZHH70s1x4BH9jlqy46wu3nWd?=
 =?iso-8859-1?Q?Dk5mnUzpRzzuEEInT5bFwcv8HxL2SWhLj/iygcYMnA6u5ll+EXcy9riybK?=
 =?iso-8859-1?Q?nur3CNhl+XGmDfQah40C/Y1cWIAphdDsV+gr4fLLBtwJRaLTTLPyWd52U5?=
 =?iso-8859-1?Q?BOAZQ0sYC34eTG7erLFRNe5CWFpTNkEJA2/3IRlPL2PYQMrbNwMkzUVfI1?=
 =?iso-8859-1?Q?e7ki4bs1tF1kWr3lOuHJjwzc8G2fmOIf46ETJ1+lfQBHkaRtvqqANQgJ7A?=
 =?iso-8859-1?Q?9arjikKfJiD7NU3/k/shK8574KKE7eHgwpxdKMlPBrrkZW8wfqe/TtXgw0?=
 =?iso-8859-1?Q?WfU/8hH130Zvo/+Nuc5ZUb/Si3WvSJfS0T3QtuyI27cEh9Ktw/MudcmS+J?=
 =?iso-8859-1?Q?Pbe0woWY1+7G8mf2Kc+xB7vTFIetEP0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05187687-7523-42a1-326d-08da53c750a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:10.5345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mBek1vnCuMDzK36s9xR2981chdvJCe+hoG8Bt4IWg7KrhPt4X3axKAt3zgjhVofRBfHa2eZ5afJhYvJmdJKJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5392
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: XHk6JWNmKa75PaNoaNgY7Vem7OA62xnd
X-Proofpoint-GUID: XHk6JWNmKa75PaNoaNgY7Vem7OA62xnd
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

madvise_walk_vmas() no longer uses linked list.

Link: https://lkml.kernel.org/r/20220504011345.662299-39-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index d7b4f2602949..31582b6ff551 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1238,7 +1238,7 @@ int madvise_walk_vmas(struct mm_struct *mm, unsigned =
long start,
 		if (start >=3D end)
 			break;
 		if (prev)
-			vma =3D prev->vm_next;
+			vma =3D find_vma(mm, prev->vm_end);
 		else	/* madvise_remove dropped mmap_lock */
 			vma =3D find_vma(mm, start);
 	}
--=20
2.35.1
