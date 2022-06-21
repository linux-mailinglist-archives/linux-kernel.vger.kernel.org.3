Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE9A553C21
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354636AbiFUUvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354727AbiFUUsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E856354
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:11 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LIvLl1007514;
        Tue, 21 Jun 2022 20:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=haFE0qSwbj3YvTu29A+kbs0OWte3oJeYwKDrOvKqcg8=;
 b=0PsQbOA1bW9FwFU5JkQsr7+F694aBacnAiWJxC6tMe5csDcYiESBL7vI5gzLtawaQfI1
 SoLE+MYTFn3pyJP5xZs1RTjKztpYv960x9vpA86Q+kdM8nI1wuQXlXXgSthPCtCUgKxv
 usEW9VVtzpIuXEBJEcGo3bopi3DdLTixtH6eXcKLGiI1a4vO04uesVUbTVN41J0+6hN7
 nTauZcNQ4rYAATFJUr4lrv565GwOq536Qy9z8CuhCxzxKaVC6yu5i2fDlB1RIBAIbCJp
 mQrhWMyKq1tgrwN/NAtmYCYEKE3w1ii4iFblWqzETNbP3oKHacMukIc24EJXw7fEAZnH Dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g1xr97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKelee037913;
        Tue, 21 Jun 2022 20:47:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtg5us974-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIp2dQyLzOkgUA05krsB/JB5JmZwjlo/lUK0FYNF6LCx9+t3FUMpGNGnIKV8hxJhDNgffx25M0ZZMIecmrFRVi1oTAtgXi0Y06xxi0ydfaBuAqqGyNNQXuyIjo6jLPRgJmm65xKjCkqctcvR+JGyk6/qqmdsy9EQECYhOWjWPjdhKk2kqH8P4fPG9V6mdxE8g1iPNAExcFLqyTNi+f1qqHW+Upcfy/8UHofOfTv2CjiSfIjeN0Y1UUKFEcldSdBMMjYwH8CwOQIEu4YAFBno1MCSVLayCaIbIOBJz2Y2D4WIHgxvx8n1cXSH46IoTgzm0SByPy7YSQSOgBWmbfmI4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haFE0qSwbj3YvTu29A+kbs0OWte3oJeYwKDrOvKqcg8=;
 b=TpAv9EupfL6lewRoHlnGtn/I96ksFCx4joXarOnveI+OrxbFl7i3qhEIIrRW6zmVP4+3FAZc6SZluy5EEL3kn4LW/wfz9YbndKp95UI0bEL6XZYzYZ+4EhlnIpzySBMzE7E14VtxLhUT9sXUduq8iLEfBFASWU4kCYk/tTPsoOlPEkh5ufCnQCBA1m3E8vRiNgs2ZB2nApariIHLeZwKYWDNMThJ3uCw/0NQHGx+VnNhVpAYgnDpMH0+LQn5SWb+5vyHu/nuxsccfVVoTsUDbf8Dg7yZqhNj1rSiTjFDqzcOn/q2OULx6MEnezkQOre+vwm5wQVod3UzVYpDIjbs8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haFE0qSwbj3YvTu29A+kbs0OWte3oJeYwKDrOvKqcg8=;
 b=BqNNAlsXbR28WZKVCUY7Tn0kr4of0lsskNzIYdkZhYFiaFWvLk/B1rpLAldmSUV28shGnEVlc4Oyx6vHd9U78JDjFvTtUdnw9QxanVJNfHSfzrOQem+vVxe4PAPSpijYFCFqELCsNkXj4Vd5ipJbJA6rpqSWGUs07yJFJ3ESDXw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5392.namprd10.prod.outlook.com (2603:10b6:5:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 20:47:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 58/69] mm/mprotect: use maple tree navigation instead of
 vma linked list
Thread-Topic: [PATCH v10 58/69] mm/mprotect: use maple tree navigation instead
 of vma linked list
Thread-Index: AQHYhbAUJ6UYnoi7wkKJLv6YWuKK6A==
Date:   Tue, 21 Jun 2022 20:47:11 +0000
Message-ID: <20220621204632.3370049-59-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23c83c3f-7dd6-4421-9978-08da53c75191
x-ms-traffictypediagnostic: DS7PR10MB5392:EE_
x-microsoft-antispam-prvs: <DS7PR10MB5392277BCB06E08DBE454088FDB39@DS7PR10MB5392.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pj6PQcjfN8tEwv+gF+zDpixWpn84kw47/dcatbzc7au6pFYnPUjwk4dnXjwPyYveL2FrcYN1ixk9WQsKLu0PAzQL9UmXhwR0lpqYrk6337H54NUj8vfm2cl5zWVeH+IlQQ4b5Oa+vL0S9AD4DP11ajp5/B1KAttlr+w4rlmwAuhcK3IxcjqTVlNFjjtoyOxwKxFAXRbe0dH6LXzVXCod7QbJ6tVGmkie7HalGU1STTmYxw8D+P4Azu3QODEF1t1jZ7RfYiA3tEUNPGdnsKStR+szq4EOaOBC365yhKqUxbk5cqsVps1UvC4CbNYdVKD9pH+X825eVI0/BTTn8p9Ya7Ys3yCwdcpeGfisqgVAW3ApFtLd4hlxcY2URVb4YdZOdN32rlXoxFgcepDEaQz6rXLkjjOHykVeT85t58jGwz6VHz09FV6jQUysolAXIr+MCW2pt/rF7jd/s7I1zcJxrNVg+jD7b3XenV/9kZmuE02pB3BhtRhTSqemBRzGr6i74euB21DYhdByg8V19qIicGfqfgwvJEa3HsTE1KMs1MopBibKnexc3Z2aa2lp7V9YUOHhT1hxV9JtG4HbbmcBhzezjrL0oZC3u/VTWABpMcgHiDXjTsi1L9rUl8z9XD/F6/6CbpVM+qCdKbg6dCa79eoV9iyqUx92qiJm+YDmDWbvGJQMMw12eJnD170HuNqK+w2cLbY05TiwD2QvqysYj/Au2HJp6nHaGul9ROkvIoEgfpEColVCzk1mEHCM7yiY9vCLf3VZBsm0659UVIlJc8GSMnZoUuVbG9Fv6YmVBNI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(41300700001)(6486002)(38070700005)(2616005)(186003)(86362001)(26005)(6512007)(38100700002)(122000001)(36756003)(1076003)(83380400001)(316002)(66446008)(66946007)(2906002)(64756008)(44832011)(6666004)(6506007)(8936002)(66556008)(76116006)(66476007)(966005)(478600001)(8676002)(91956017)(71200400001)(110136005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aGfnBF8gfinFpfdi16GPRZ47iF9Xd8Qcf4KCyJp5H8bdYD6+IV538t4Pc/?=
 =?iso-8859-1?Q?ZmN9uV7xpOinBpLV1krU/eZrM2Mc9RbIFwLw7zSp3L0sjuIQRqq0HHuRyx?=
 =?iso-8859-1?Q?3g2V3MZLQeI5fHKDLatf2zb9OllWha7jK5Q+C8RXO6TVAv7yFRJPKi9Hfv?=
 =?iso-8859-1?Q?KvsLV2OVKh1uk+n/UXUMMwZ8P4EHX1sCO/oA+UsD6+n9d6Et16d+v10UTo?=
 =?iso-8859-1?Q?KAB+P32zQkbXl9KzybGJYqRmrGTDsg81zwQS2bYyrvwyc4WEj92vFT21na?=
 =?iso-8859-1?Q?CkouFUH0JFLdSZzbIU6cA/estCO/AYazJtO73hLZYq1xCjcPTlPILsBhR5?=
 =?iso-8859-1?Q?lwnvdJoStQ4mb2I/+sqFXZrUnKDHZ5wrv8bEXaWOcZSudk0Pf90pARINn6?=
 =?iso-8859-1?Q?vbuknowO3i9lIWue6j4e1KaedhSFUf5w+fwYyduMEODaWYEiGZwc8+m+NT?=
 =?iso-8859-1?Q?nrv0wIvC6/16zvVOQyqvhyUNUJq8LK4Khw5N++8x8Xw+QeHwMgHsNl1FXa?=
 =?iso-8859-1?Q?LY+3Jz8cw2j5ULMykJiVYmz/1h4deGt1FL0K9otb4UKNvknTnBT2XJDCf7?=
 =?iso-8859-1?Q?2Zf2fMJczkV0AjpbzHBnbCmf7t0MW5z7tAe71XC3Ydhsp6/QFK80pLfuEu?=
 =?iso-8859-1?Q?CK229z6IJBkFLmNArG+DMoF5g9rNY2jpFsI+QgBIIQzGXu2XDwtXTsfRYA?=
 =?iso-8859-1?Q?kOVRbTPYbXsNcCXqpmE3BJC9tHSPbHyIx3jnkn187pFsf9NQ8kpPtBkZSQ?=
 =?iso-8859-1?Q?7CKXAxNWP4xxCg61ijPw+96n22PtB1qzOdTn9Ka8JvJNgcc6qP2MqkGFzY?=
 =?iso-8859-1?Q?OEX6a4MNqO0yFu9eHpKyvICGFeVJGaTc+9P5PNgCbSy5Jq+HqwtGaXoTDM?=
 =?iso-8859-1?Q?4saFpaFmjx0O5C7dTzRsqkX83xN1ZJDXJ+t2OB4md/sIyu/mo7TYW3eJMG?=
 =?iso-8859-1?Q?zWarxmVHFPQ2YVYuIR18GReHl1Mq2vOKxal89tNFaG2stfVT+pAO76y81K?=
 =?iso-8859-1?Q?SeTZUmeqDrqDGFo6ksRY7fCR5ooek2Bjugg7YRLL/r7Zl0KBcrh+kvVQgk?=
 =?iso-8859-1?Q?XH8wHhamhmbMy2HT0GLDNLnuZAf1sGvYIRgeskoc0D6vXPfeC3MavuFfgt?=
 =?iso-8859-1?Q?ObNc159iMh3f/X+nC27Qros9jV+K33dYrKH5QjwTD9ZqAyTM1uDnMLA2sa?=
 =?iso-8859-1?Q?rPC4+Lt3VjydYDMev6abDe+86EkvUTJaHUFKNMLiU2xs0TvtzTjbsEncIA?=
 =?iso-8859-1?Q?KivpWQlqZsmB7rj0r18AB1YMhU39oit68ARYReIgRca54WzT4czSb6Ztfj?=
 =?iso-8859-1?Q?UOFQFgW/vl+R7w7qu99mZPDH1oaO/cU091DwSAvbcP7jefOJ4u7DDk4D6o?=
 =?iso-8859-1?Q?Cd7acbDPBZL3K5MQkI2tzAThXMUHyXMK1hmZHvzYpjqYDDfbf/uVv2pT6c?=
 =?iso-8859-1?Q?6G22Cb2S+CWSgH4IZyM0qpng6wusR0TWhslp+b1imjMPtpkL7yt0zfJoo3?=
 =?iso-8859-1?Q?vLgx/wkK93tNMI28paTt9tTH/tqTOX8OGuRXKCKRDpfA3kKUR8xPm2owWe?=
 =?iso-8859-1?Q?7YSoNd8zWnCSDinT8Iqm/IpmsC3QsRFjvUUYj4GSZprzyOWyRLQ1WFOWFX?=
 =?iso-8859-1?Q?t33/16CLM8nMaM6nEo3m/eQa2gfiMPY3z3FDeGQ8xXYlQ3EbGwCMq9+Aey?=
 =?iso-8859-1?Q?NVj84FVmv6EPF/upDKPLJx0JhNEVCx3jNd4c1k2hO7pmZ+rS4Sz+df9ijP?=
 =?iso-8859-1?Q?m9dNRws0ZqzyrVi9DPr9rkDMQAKAPnvIKGiv2rkT9Mgd8KqoXeD1bp7f7i?=
 =?iso-8859-1?Q?KSy8V9g84Csw4oLTYrmH91mX19UKmY4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c83c3f-7dd6-4421-9978-08da53c75191
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:11.6438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lToZgTnD/eijN3xNpat8MZr2km/n8F/vqcBWpiIHZGpy+5Lof9zZWEwFjdGLCdIqq58jXPTHsRtRUo0oLO6w/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5392
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-GUID: AGxlK1906hcmBz1dTo0vrjFrPM-xllhz
X-Proofpoint-ORIG-GUID: AGxlK1906hcmBz1dTo0vrjFrPM-xllhz
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

Link: https://lkml.kernel.org/r/20220504011345.662299-43-Liam.Howlett@oracl=
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
 mm/mprotect.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index ba5592655ee3..27fb652151e4 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -621,6 +621,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	const bool rier =3D (current->personality & READ_IMPLIES_EXEC) &&
 				(prot & PROT_READ);
 	struct mmu_gather tlb;
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	start =3D untagged_addr(start);
=20
@@ -652,7 +653,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if ((pkey !=3D -1) && !mm_pkey_is_allocated(current->mm, pkey))
 		goto out;
=20
-	vma =3D find_vma(current->mm, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	error =3D -ENOMEM;
 	if (!vma)
 		goto out;
@@ -678,7 +679,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if (start > vma->vm_start)
 		prev =3D vma;
 	else
-		prev =3D vma->vm_prev;
+		prev =3D mas_prev(&mas, 0);
=20
 	tlb_gather_mmu(&tlb, current->mm);
 	for (nstart =3D start ; ; ) {
@@ -741,7 +742,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 		if (nstart >=3D end)
 			break;
=20
-		vma =3D prev->vm_next;
+		vma =3D find_vma(current->mm, prev->vm_end);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			break;
--=20
2.35.1
