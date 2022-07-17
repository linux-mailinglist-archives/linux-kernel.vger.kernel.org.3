Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BB957733C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbiGQCtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbiGQCri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:47:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59B21C11A
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:12 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8l9g005050;
        Sun, 17 Jul 2022 02:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=yPWmZEKdxDE/97wYlhEf85fIi65b7X/pJDDRWoZ7d9o=;
 b=uNg8Hi5ffxqDEfglkbiuNxvVii1vsFAeCgeKdwpGnHuVtRTKe4KGOuupF+3erbPaLSsp
 bnGq+QSVCz+Nh7Q8hY0y4bhQKedf/9WF77EL+lE50trab26U49wAgVz+3Dq0tRmd53Ej
 24Xckqdo77DfcE6PLrjK0ShQKCI4JfXevyOm7v2y6f1fzXEMtguk258BuEiQmlNTePCf
 s3YOdUERZTBZ/LMD0HrdzKveroKXJSvYjL2awYKBqWI+kUC4jvCA7cCmscMe0Ub6+9cL
 Ja9yF6LKvewNPPLTm4PDxi1TuhiEVqzmQqkyJqIpZeEzjSzWSQpZOvgTl+a6HH4QnIyn jQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs0x1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYImc036151;
        Sun, 17 Jul 2022 02:46:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp63m-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIkvrE/p2MxEg73UvA/HlNNJuHW6w4ZAfwjQ9xu2TvyAlp5SY21N4RQXYLicxue+t5oyJ/QR6QlCN7xHjfJWqJnOMs5CuPJOZJD7X+BZvEyylKkY+WgzNLUHIQZPYjZB7EnycaZOVqkemvL8/JunoAbIr+BM3RM2cwnUpaEZKLiVJS0J6WborxnpgKHJc2YvHL3xkklrnxyvs1bk5+9MQTxHsKJer8vmmsimrFokvm+Ndbay8yZTHOj+cvlFRbYf6pVgQPUX3GKgW+SvXpE3+f5Gx2W6D7PGurpSfUU9K/a14iUPPEwhoxnnT6fgb5pgSikedm1t6G0NmoK2P22GsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPWmZEKdxDE/97wYlhEf85fIi65b7X/pJDDRWoZ7d9o=;
 b=I3Bc9eQf6OOD7E4CSogFQaLUpa3Ue+1dtEez9cB/CNQR/e2gclkbgJlCM6/cKHQhtLnwsQqr6E32MzGRshPpNDoeVcYGbS+E3p4u3GjlODZ7Bw4F23lWhuFuZO7bxAq0mNDyiIDEsp3Ky80T2bA1BmQRt7GkiP6gJpF6Emgqp0puAl+HkUgJZ1xNJjwk81Glip7K2ajriimcKVULoFxaUMW/ZQeD28qoVlKbVpE9Cjfq62QWF5B2r2i+ZSvxxCyuHbU6BLHn8U31KDxgTDPInBQ7s9si5xYALXm1OyopsruXB2BUJqFOUpfO8Oei3Oj+ormnJUEd3H4/WhbbJlCL6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPWmZEKdxDE/97wYlhEf85fIi65b7X/pJDDRWoZ7d9o=;
 b=ZKNvBZDlhHhrcmc1Soo9519DdeHlF3t6L6wGYhgUcTGmxTSFTA45C29DSzx/PBOUgdeI2zkORbDNhW1h0ZC9JoazgpOInY9f52lY1NRDWK4nmhqp0+FmYJTJFTyhnG5aWcWhRSxScNYYeVLI0oC27vjSAAtmWd4/eanTTOCJJlg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2908.namprd10.prod.outlook.com (2603:10b6:5:6e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Sun, 17 Jul
 2022 02:46:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:46 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 20/69] mm: optimize find_exact_vma() to use vma_lookup()
Thread-Topic: [PATCH v11 20/69] mm: optimize find_exact_vma() to use
 vma_lookup()
Thread-Index: AQHYmYdyddGwEYpaFkmk1SJXVQ0Y+g==
Date:   Sun, 17 Jul 2022 02:46:43 +0000
Message-ID: <20220717024615.2106835-21-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a686cf74-5543-42a0-6656-08da679e974f
x-ms-traffictypediagnostic: DM6PR10MB2908:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z1BEZHJc+fxy//mW+hZnPdTH+ec6EkPPW0Mp9sUGx2vAXQichwstzJbJvDo9+KNdUU2+B2qRCmrOuS1CgAs5kMPRWbtzWixgswyXdOqhlPdrWMvdKcN2URDZhkQM2ytcHun1SSsUXHf+PDdu1B3QBfJGQMCeFT0L81Uf2bcVD6LmyAJ8qOwM3i1KPZNsQxWQJynGVOteOhnKmuCflQ/RFS8fT/QfkwTATKZwm0o8hj+vceLRgPXB5NpDQ7/m7p317hQkZHMHIHLg4tHp3rPj30cEFB716Jnual3URnLZ04m19K+XBsrbp/TI4AhapM3J/AfEtLm6X3xzsrThihMWXsoz70ViD5D/Ufl47sG/0eAZNkyg7ByFfcVsd47Xn30McJAKTXixyh5iKPqRdgPDvu7iwS1R+rn58cYy2FlFe2U2bjAOHwtgg3uLA+WKDKGTOpZm43Kf6GIUDrPpGgx8qJN6HujI+yckN/1b+BibtDTFJYupGd4YxEGpxTSWy3RsVuaDgcOXbVDlXjsWtgizEY1X9x9BhdRF7Gx+skQASubOgPBPaiRARJ7buIROl0m9cxEIZV1sUo8WvkreMHO3bRpq5xbEk/Z13Abk0GS0ld5QIHN69gqJYX6ijEAL47gewpka0u60hBJ/gdlMRWTq0BZbghHok+6x8CT+uEOBp3fX5yKfi2pmRZtdlkNKx0tmESlTKIL3myYky5hKACoW1icUl6W02FVrX4Xpq6gcSGQUQc1QNQIPTg5kcdVE/XcatFypHSUZIYvc5CVFj9QgsTK92Nqdh1HL/HpzNXg+DwHqkz1++n2fhMuQHi2Z0QO3cP7BVkxGKu6S5x5o9DVFvNtV/5lz1vvxO0nc8MXnKMDcNRE5MhDhBM2/Vsg9wiHnsAYYuMUGQcos52eE07xq0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(136003)(366004)(5660300002)(122000001)(86362001)(38100700002)(38070700005)(6512007)(83380400001)(186003)(36756003)(1076003)(2616005)(6506007)(71200400001)(8676002)(110136005)(316002)(41300700001)(966005)(478600001)(26005)(6666004)(91956017)(6486002)(66446008)(64756008)(66556008)(76116006)(66946007)(2906002)(44832011)(8936002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tBgND6vEMxZAJVGwgZRMtrzZAbE1e48cTFvSJmHsFkjyaLkkRWaWOjQ7f5?=
 =?iso-8859-1?Q?0y+uAmth3kOswjL102Yu8h9nZz+3K07WjwUhthA2QL4mGJhsd11tgjCtqB?=
 =?iso-8859-1?Q?QfpX0LgSX8sW5niy23wvsPr7cfkvibwxnjH9EpIGH8dRNL8upUSw82Hz+S?=
 =?iso-8859-1?Q?Q8KC0eT5li44p3NBOD94Zo9hzrUHIqldTD9u41tYpn62KXYMVvMFZtpuB1?=
 =?iso-8859-1?Q?EWnwf96URTpjPa7FDVh4LyeD/9QA+nZo7gqENVT2OD2Bm2IGHi+c9uzh73?=
 =?iso-8859-1?Q?534sGljsCJOa+fyfjcVhupUyzui5S4HZsmeXwujDM5UkMw/eWm3pJ/ZxyU?=
 =?iso-8859-1?Q?IU/bYQcK+fEQ1erBK7GV+m/u6ddqX6MoXFiFxADv78sHVP3LFIVa5AAyPM?=
 =?iso-8859-1?Q?AdGfZPbKJjfBc6VoU+r9/ucigRddDLj/mBgs8m8Ui748YySnlxFsLU2Yx0?=
 =?iso-8859-1?Q?RmakPYyZIBKBmB7JQvQyK9zpG9I1d1M8UCfJeYBHA/XzqhqLAudqU6NmC9?=
 =?iso-8859-1?Q?F0pXzk74hGi1CTjHfXfT6jgHVZRl5xMhId3wnuRR3erFzlbchWS106Wv9h?=
 =?iso-8859-1?Q?gd5hrlPLrznoWXVwx4V+LQLgyg4rGf7+c5jxruWcQWpljFQJz5eoyvSWlB?=
 =?iso-8859-1?Q?Fr6Lw5RSwtB1RT9oxkcKTJXZ0QL5UH2Kc3qI1XezUynJZWGh1+3xcK31vz?=
 =?iso-8859-1?Q?TqLmG5j3f42WCw106/Q55NLiBVV3hkC2NhLSoaBV+qNQVKuD3Ywf9SM3a0?=
 =?iso-8859-1?Q?NsQNmIVvEnwkpICRtUsFcr2iF8jMVTpoL1MELpeaxQ4vJDbq65R7X791/v?=
 =?iso-8859-1?Q?+tzRxsuBU/MzrYozdlSmU0pzanCyvhbf4tMZ0l8EPqAlAIL30dw8NY+1xL?=
 =?iso-8859-1?Q?6qXRMlUJEFRmx/4zg5+ij/Yj8owkNk2g89tTqpeANgz52xDsoEh/nT+x/k?=
 =?iso-8859-1?Q?A4w6zWA980diaXSTiZfh4qGBz6srqLitTRf0dFqUL/q+G3e7pMFicA6ZVS?=
 =?iso-8859-1?Q?TIwDpb7LpcrVX1OijUhuGjU648v4O3stv90kbNhK/ZO9SuyPnsb36FyfHL?=
 =?iso-8859-1?Q?CrVgzr2xUZGgfPMnAnm6HqRYQNeB2SLTwJmEwfmEby908vJMpTJaetVKST?=
 =?iso-8859-1?Q?lWtJGYFBjWMrWTZPWRKflNmE1zUSpWijf6JxhURdanHBh9t3iAD1lVHky9?=
 =?iso-8859-1?Q?EwMrib9NGP+vbRGPCMQ1o4Ysm+/sFK3KX7wXLNRod6FC741IqcgTr22JbS?=
 =?iso-8859-1?Q?JtdtqOJ70tMI3m2bcECi7F5Va+SFsOr9gyS+yMEUHmnFr73ePkRPC0fxJD?=
 =?iso-8859-1?Q?0LzzzYMX7zToc77Akd69wylVUMSrgJgozh8dN8RkO3XWSk/FrpLlsXVXZp?=
 =?iso-8859-1?Q?llj0fQMVnllSU8pjdCKvEX675Xwyxlo/i0heV1jmGsw1MJ6IKmQ7rPaUOj?=
 =?iso-8859-1?Q?Uif/pLhL8zHizp8pmgxXx+ZWiiApsuNRKYnDphkmmLLLScLT4eczqWh+30?=
 =?iso-8859-1?Q?TpVUsILijqbBZLsGDFBDb3QQJvghzVS9+iAoEPOIWRcgZuRJDcOROQR70Q?=
 =?iso-8859-1?Q?QnxQBX+MzHcsUUIi6REXBwE1LGtjTHPt5RO4+sOUCexXSLQv3q9gS9G/D3?=
 =?iso-8859-1?Q?JY0qF0jp0cD4TvexC6DKzZLzMN/ueCaK1asQBbH2b9lvy03vd/f/rA2w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a686cf74-5543-42a0-6656-08da679e974f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:43.2718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fT/FnjvHMSYTQP5+RV75j4aMaAsYgEaI/0FHUHEcxlDbm+9O9o/fYcwi+kHT3kcmN7H8Hc7vAmckIYLb3hHFKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=604
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: pB2X8XrLQscguyp1EXiADgDGU3kwIstc
X-Proofpoint-ORIG-GUID: pB2X8XrLQscguyp1EXiADgDGU3kwIstc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use vma_lookup() to walk the tree to the start value requested.  If the
vma at the start does not match, then the answer is NULL and there is no
need to look at the next vma the way that find_vma() would.

Link: https://lkml.kernel.org/r/20220504011345.662299-5-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-21-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 051b503c3fdb..8207fbc6ed87 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2864,7 +2864,7 @@ static inline unsigned long vma_pages(struct vm_area_=
struct *vma)
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 				unsigned long vm_start, unsigned long vm_end)
 {
-	struct vm_area_struct *vma =3D find_vma(mm, vm_start);
+	struct vm_area_struct *vma =3D vma_lookup(mm, vm_start);
=20
 	if (vma && (vma->vm_start !=3D vm_start || vma->vm_end !=3D vm_end))
 		vma =3D NULL;
--=20
2.35.1
