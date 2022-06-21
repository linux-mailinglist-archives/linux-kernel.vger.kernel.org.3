Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476FB553C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354949AbiFUUwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354585AbiFUUt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:49:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC4110ED
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:38 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJEdKu012601;
        Tue, 21 Jun 2022 20:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QNITIRedm1iqxB0wu1sd48E1pn+idNraTb/EgYvyDsk=;
 b=jpx6e+6Swe7KKPfYHJ+uEtzD5hXnsDxd6XcJ8YotDKlVtFPqKHffM4pv8o/lNO3JLyoG
 gCFiowf8oHo5E+R0moggc/GYgZut43oBiVhB/fRLxAbaiM/qqLt0iaKjUYkuGibIoIWu
 4KC6m5CwJtl3fSH2JQAyy0wklk8BbIhQcMPeoeWraCjK5ADGd5XYS6Iux1sK7MjpkHgW
 nomzrKVgllH5nsLggnF3L/LVpyS1k6du41DpyEXBXQCXycwDdyOGjbDc6i5nnJpe5yxh
 9wJR5R1YDiqdZeTWohyMNgVbOMfv0XB3OR80zjpiKyDJEQLxvu4GUz2B6cJkvyg06ahV FA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kf6kk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:48:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKebPH010812;
        Tue, 21 Jun 2022 20:48:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtg3vkhrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:48:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXFT36QT92ZsPZ/bHA/VnqOT4b4CEfh5D8QOIWHn52DSvzjWGF/R8H+P7wxvwa2zJENAE9//ushxvoAUWHYed7QqkKcElXtBFjXTjZu1H01lnKanzC0hFK+7HkBaqdoSNwRc0TeG2FUy9ZY3ROGEGdxd0MVBndj3nTykaFfkGj99kCQrTvBlYYyYZ6yD6QQFDEZw+V+tyoVg+MzCYs64eiG2oFczTXS+4bVVAtlK+peOmKumC4UtqhJ4S7Tk5SjYKTBqddwVaEnn8NsS/WBBHvvFcWwCJ3OMiJnM1Qc72Z2/fLVvYzBUl+MwPeNovOLWXb5568MEoiS6bV79fJHjew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNITIRedm1iqxB0wu1sd48E1pn+idNraTb/EgYvyDsk=;
 b=ZBLqv9TdMCmwtjxwfB6aNtbP/X0yoTS+Lh5HzOv7cWQdZJvJcykgG/ED2gWV4UDuBTHNMRxg2ZtXifn0rbkCnafAi7qa+s6o245YqGytflKwxYehbJEnPdbEyniwFEd6UKaV5FZfiB2BiNm8845pMBi7GTzJatMye8GLBHm1kdkESCbUPZuwA6B63MvQ49af15ipKc7y0DEgOH5KjtgsW61C46WzNoTNhU6Qm2IZrNItsPweDoeJFDiNN+uGR+pCy2C2pdXqA8wpL2vRFb2abIvle/oaZI50MPrP30otCePjznpdnM9BWCw5p2Djofwu/oH/CagcmMyufGUMtSWCAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNITIRedm1iqxB0wu1sd48E1pn+idNraTb/EgYvyDsk=;
 b=C3MC0dlPQgAdHBOJLPHJiJ5Cx/aXQERn+UOB166erqqDyWt3oWRW4F3nIoPQL1gsPkLziKsH8Am01fjb5vlQvq7GVrJrGu7zKfJAux1FNyXZKDF3VHnIAkBDoh2DX44By7TM4xWc4QYG1bph4/Cq2f7nnpx1z8j7tq07o9BItr4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5392.namprd10.prod.outlook.com (2603:10b6:5:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 20:48:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:48:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 60/69] mm/msync: use vma_find() instead of vma linked list
Thread-Topic: [PATCH v10 60/69] mm/msync: use vma_find() instead of vma linked
 list
Thread-Index: AQHYhbAVl7Uc/hEiSEa0KfRjvzZbcg==
Date:   Tue, 21 Jun 2022 20:47:12 +0000
Message-ID: <20220621204632.3370049-61-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9adc92e2-aed2-47ec-6f63-08da53c763f8
x-ms-traffictypediagnostic: DS7PR10MB5392:EE_
x-microsoft-antispam-prvs: <DS7PR10MB5392F7E74708D1A7B680CD01FDB39@DS7PR10MB5392.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7urWlJnqxJ7/zjTAYCf5a+Wt+fB6C9rxEGyQIBFNVC9csO+ubzSBwZbP/PLqFsQfgLfynOZrqwU04BF6fnmj9QKWQllrFG7iMaJtZhoGXC9nXmaPpMRpEkK/9MtvpilvFLKrAgwf7pZV40sW0zVlayfVlcpWrd1Ean7kLJ21/UF5pToyIbfVBLfW9sG3WDzjlkPPM/5PWvZBHxrHGugxwNbSV8jhYCCLaw1Ny5a6t22C1N3aRkFPkOr5cuOH4zjkmIHwoDmRdBnJiaDU1KgPUXR7AV/KFYCD8WM56b2u/Aj9iQxZ/M9ShiLc2NsyKFlwHaqP9HRUT/s8sFvPQiOFj7VxirR+cLwz7ZCyMFgPSqxV9SitODFKlxuw5MF5dRKqHLMGPA0s/RbAzXfqd+HX0qLDjWKEZQVBAmC2Xy+0ofj67Gb6oyKH9PwKp1diRf3EJ/leKSO19W4aPzHOdk0KYAQ+IwKqs1Bbzv7YK+6BkCc5UQxwQyYkL55+QFf9ac7ZFlHRQjIk6/mpJc0NBoyOZkXcV5KqWRvprXASYFoLnCsRwqvyc/XmG6ymttnYosJahvd70/gwvscYgg/3ZgbX2Ac3HMi4UjnRXJFGOQaD8mPDP2hQEqXrgsBUEu5aG6aJxt/etU8qSRdmEFpYYIK3mSsCq5+Mq/NrZE2+vpEeJAQTLkCD2pRvo8I0E0lumdo1UWktlXZCSUNdLKR0uSdthUvzj/iN4ZF1GU9HNuuvwX1+Cg29Inp870yj6WMbJDAtK+dM4X6EFM5FSq+RUR4tMJpSJjFQMF9zU2p1EafQ1rY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(41300700001)(6486002)(38070700005)(2616005)(186003)(86362001)(26005)(6512007)(38100700002)(122000001)(36756003)(1076003)(83380400001)(316002)(66446008)(66946007)(2906002)(64756008)(44832011)(6666004)(4744005)(6506007)(8936002)(66556008)(76116006)(66476007)(966005)(478600001)(8676002)(91956017)(71200400001)(110136005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LLdL/ja9LlRzSJCatkDGcNdD17mPHF3o28H9S9GGhBgvT4TgacV7b8Jlva?=
 =?iso-8859-1?Q?U5bW1CpD3LnYNl5Mp3k9grzgVhfUbUQpFojB2EL3QVDJ4lXhL9csgTciun?=
 =?iso-8859-1?Q?rrt+hdxLsuqj77X+kOzyYqq0GeE3YQndMFnR5zC1uogPnj2OvKk0C3mVB6?=
 =?iso-8859-1?Q?OhL7PRvh8CGhu66jV9IjlX/DlTpmpQAS534W91MUpQwZBZda318FSW+Gpx?=
 =?iso-8859-1?Q?TEh9z5x0HrVgic0pOMm8+pREZGQ2ES7f4kgfN67ZfUfWiIK4Ve2fPHtek7?=
 =?iso-8859-1?Q?ZZGRtW9fiC1Bp3PBTzAq7/rF2IYSeaH0DTN72nOtPeTBMSdB4aZoA6Ywx/?=
 =?iso-8859-1?Q?cY7pn+pPjOJtHDuEqnhiwb9Sg9MriiGLurZkUTWQ4tT8o12n9LHq2b/qNv?=
 =?iso-8859-1?Q?C9sQQ3UagNiIv+uNSN1Fqw2ar2szYGfSTIuxHOpt3/1iVtuE4gfw8fFfAV?=
 =?iso-8859-1?Q?iNDXKkh46QPNMxQ4afxl/f/Hi7gD+K8ysEpj3dTRpAZ68enqTH775quTv4?=
 =?iso-8859-1?Q?Wvul3Mhofg2AlkFH/8SySPz0iwT/BX0nJg11ynaNVJOKQz7F418dWloHeo?=
 =?iso-8859-1?Q?nEmNopV0P9p5vnCs6bTXjX28UY576w8+1zSVg0FJxtv6phX7Lx/LH7HxtX?=
 =?iso-8859-1?Q?Lu5t2B+bJD7vl4Acvb8QtrlGMgAuYjGmc7wsCZr7ICP2yx9Vw0mdBpULlD?=
 =?iso-8859-1?Q?+OOD9iTj7FLahsmxBjX0giOS8ykL57tLPzpYYsy6Fi0GGVUcJvpD3C0cU0?=
 =?iso-8859-1?Q?IrdfzumCb24cT6nFF0120sGRVyYLiIZEjDmUzlPn5Z9I57jYXnjouBWwCd?=
 =?iso-8859-1?Q?KyBw+F5NiZdSfcORNaCQCJr5nT7oJ1VhqpeC3vCYCPTLVEsJDRc6AX0ZGM?=
 =?iso-8859-1?Q?zGV8exYPkzjNaY365CkjFgFL0iuikWxUVIW6s0hAET341yNjxSzBK6l6MS?=
 =?iso-8859-1?Q?rPjUngc1lt1Lw/MbzYynpLNZQfWeLiG1q6CMMGxTNBqBH3av0LvL7LlBFz?=
 =?iso-8859-1?Q?VTROvvJbWvoG6TBExUs407WxF9PSm9TPOEAEInK+F6J125woUWN6cn67dR?=
 =?iso-8859-1?Q?MIwTDrZbXYWaktqMmrXUovf3Xj/Dqe8/5vhG+9Vk36OdTdxa0cnfUUDI/L?=
 =?iso-8859-1?Q?6dC4CidhmBoI9YXQ83Wt4RVUtylkHO0VqexNzY/jnsh7Ip9/H3x+4Ug5aQ?=
 =?iso-8859-1?Q?6F0dLU0g3TMA2kM4h1fqnvOwR45kaSa5TfsI/t0Fc7Yudc1aoz0/M6+xRl?=
 =?iso-8859-1?Q?OS1q+Uf0kbgW6AAgVV+azXG7ddKYKswAi0bFwD+BfOm4/UiAHgEsBPMumM?=
 =?iso-8859-1?Q?Z8k8FaG3UR9vEIggOZ+s0GnEuOl7GtYhRrkTYrZLtu6B4rIUbtqAmUYH9Z?=
 =?iso-8859-1?Q?uI0NCep1EELmoktQqESgH4Mog2FfA1iuo/FO3bveIzKmRGdIVhNPlm8OYH?=
 =?iso-8859-1?Q?mBEf47Ku4CjeOlg4iqGojCnw2oLhX8b7GYhTKadkQ27ZgABN3xdbf8r3Zv?=
 =?iso-8859-1?Q?wN6QwdFpENBzJaOXqEgQ3T0ytsVSQo20HQRwb8lV+MdHw0322EAZW5QeVi?=
 =?iso-8859-1?Q?oIKwgpv9HN3vhlaSX/8kOKl2V8aCg0xHhFQCj2swrPl+ZQLHhJjfsmcyWj?=
 =?iso-8859-1?Q?G85w3pSIDg8fRCZ5zz93btg8ngb5p1E1PL8id1nY6UATez7NlNLzlq8DW6?=
 =?iso-8859-1?Q?LZ1TRR8fBOR3enbIwDvs3aNsYC+UBkQgTAgK4znSMyBUYSVjIa7ytSxSwE?=
 =?iso-8859-1?Q?E3clz21xPLwy7+ya8AlNj+146F2gBU+DOS+Ru1xsC74zYbkUkH1Rih0LKd?=
 =?iso-8859-1?Q?xOSHbalfz9BTjrbY44W+SXJ+9XeGLoU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9adc92e2-aed2-47ec-6f63-08da53c763f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:12.1907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XKdifgtfpgz4qlOfmq4OqNzeY2WWUNt1X8/k7Sex0LpHltoexYPjqFuYUROoy2S3whm+PNgif2rTDICrVSuTBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5392
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=904
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: JP8IaKtrigS2iClM4VgxJasu_TshT5x8
X-Proofpoint-GUID: JP8IaKtrigS2iClM4VgxJasu_TshT5x8
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

Link: https://lkml.kernel.org/r/20220504011345.662299-45-Liam.Howlett@oracl=
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
 mm/msync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/msync.c b/mm/msync.c
index 137d1c104f3e..ac4c9bfea2e7 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -104,7 +104,7 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, le=
n, int, flags)
 				error =3D 0;
 				goto out_unlock;
 			}
-			vma =3D vma->vm_next;
+			vma =3D find_vma(mm, vma->vm_end);
 		}
 	}
 out_unlock:
--=20
2.35.1
