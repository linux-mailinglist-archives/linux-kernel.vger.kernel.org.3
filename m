Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3240259C24D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbiHVPMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236344AbiHVPKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:10:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5AC3C17D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:07:54 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkOd3022935;
        Mon, 22 Aug 2022 15:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=o0RRpAaYSUnyHm3br4XRUPl8y4wnndWVnqFIE4IRwaE=;
 b=rC4p8nbtZ+g2QkYn9aqYZ4tWDZAbaXbBc3hXy7n+T2G0ExoMsLf1nHpo7xSkwWuCqRUb
 6o8McXXgXhXZsbxOVnwFdbTbFCMKRe5un84Db4+rctrtQ77C7YINQhSPoyZgBxpiKx/G
 NwGqqTV6fXm+WzVFtrHsx2bEtSRDgOjefcQdhTjYzhmFmdP801V2VyBLXx53SVe26hU/
 HJfjl8+NYD0SXsKVHL29LWlgSiis4qOsIB2uhHDCUfazi5HoCWnpXFezWK3T7De8fZns
 q7oKvLEHNtK9fP1+Xf/bwSn7hpq7oWBINBzK/3EHjV98mCGczKpNv/LMFCOgZd5aQDwS cw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4ar8gbpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Naj031868;
        Mon, 22 Aug 2022 15:06:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjd3986-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsopDsQRzhsI7hlNqW/7llDXDTPKZxkvhO3t2l8MkHC5FDS8MFM0h8on19hNQ1EBnV2/x9wV2bSg32C4iX6dmnwShDlZj/8Z4f7d/c2Y5g4JyJ6pjxwxiRkaoVlBsszLYZU+cIxH9gr+JtKTSdGBA1mQODp4MiiF6QrpNATihPNzYlYmWIc/Z/OoiNM4wwoLi0zicDHon7omSWoP27CSidEwwxyUKjz7vyMl0Pxwfm5whYW5kpM5gw8RcInlFWYHI0IE4bskHGccFRDuC7MYImuC962Nm8CNYKrsK+ILTbIKacznY7dBTAnFbAtn1TQplexfPgGi3AhE/j10rdoKGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0RRpAaYSUnyHm3br4XRUPl8y4wnndWVnqFIE4IRwaE=;
 b=LJBkM0C2YsohRk7GZrXmk5ST2lMVLzZz+yR1X7hQpS7+iZKyePWa2h60w+poHu5y06EVp7DMMo4wc+hUkPyZvMRjf6kbT3/xTdP1J7Ul+dIpMzoeTojd6IOvKcQtUQmnR3eXj0DNEcWMldZHCcPD/UR8OEreoo/2oYNyb2zTAJkBc1qgYiXniwxVAX/UWinsW51LcOP08dGCMXMiVp3OMtHnUlhV5dgxt9ida9SN7qP0jxLd75nOM7JbKTPqlBVXRt2rEhsG3/Y2wm2wNYRWXW2QIrL3945hWp2UGMdcCqS5r//3XmHa107E77RWPnP228xqm1DCbw+vwUcSS0pfaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0RRpAaYSUnyHm3br4XRUPl8y4wnndWVnqFIE4IRwaE=;
 b=ro5/jOHlqnUzRITnKEP6PU0HB7U9aAiiIEG5kK8PUFVGCVA9RROdxBOCSTu9EB/ui50H0yE8ibimPuZNcqYo707BLOcwHBVtzWGJM7yj/XmNLXq1J8amTE5XFC3b0KHwiamvigTvgyYNu/gJz4htxO9Bkp5aGQ4efrOW6xZM8+0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1433.namprd10.prod.outlook.com (2603:10b6:3:e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Mon, 22 Aug 2022 15:06:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 50/70] bpf: remove VMA linked list
Thread-Topic: [PATCH v13 50/70] bpf: remove VMA linked list
Thread-Index: AQHYtjjBvTkceBIovE+v7ydn4QyKuQ==
Date:   Mon, 22 Aug 2022 15:06:28 +0000
Message-ID: <20220822150128.1562046-51-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c593bdae-5a1b-4d5d-1d30-08da844fe541
x-ms-traffictypediagnostic: DM5PR10MB1433:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H9TZ42KdILl2DMwKdHGLJcv0kAVXX5A5DHq9hr68Fg1mSiCaT4CfshncSx6frc5diJEG6NiNPPOAs61hHZUu0AGvwfagg8LssAUPbZTl1o5aJsKNnnNrqVrGKDoYgQg2wpOLrAGalh1eXf2Le6GulMxdSxzQI2giVUmiBqh6amQfZzqQ9SozxQPHEkE+jJ0F7dr0r9yAMIwP4zKtYyS9tYu1IaqEMH2RtDacgXGYrfUIC9JMsak1ZkcPBGqHmPSDqDnNYBRIizcqxnOPUGnv2gFZQm25cEmwGllI59XkHgOyxYksG5CXcwlHydyd5HrkJHMlcEPaAPhWfS41cL3gcz1Yx6yO7stmKOqpsRmT/RjVYNLu22OdJNZamakDq3cd7jnxUAUi5Vp9/iHpVrgoFZE36Zv0FkTbRq7Jtch84Ih0wrJXSE2v+iwo1IcBhKCuDNQs08/umlIzbV3H/O7xOk50oQ04l1w1LFu8h9+E2AcwXnML9wGTszlsosbMtY2rpyFSzHm3DD5WRqCtvdRipDgkx//37hS/AhIjon1qB1ZJZ4gsg5pThDseVA/DEQsZZhNW3lOCfCveGKW5VSIqKci60VvU2+wh6eNWEKHHEmKz6gJ/Ie/3/ELS1gZcyj7I7tWEjdKGppek27Gl0tVdJ9VtH1KWdaYucEZulylE+8ycmQ0YpFpGPIBtryHBKqU7ccoOc/YULeEOxAWNeHgDap0MSCs9iD+/Wi/bOvmTx5HB7kcjwQ54is/pbRZod/kFZ1J0u9TQzgBMPeqippl4VQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(5660300002)(8936002)(38100700002)(122000001)(36756003)(41300700001)(44832011)(6486002)(6666004)(316002)(71200400001)(76116006)(91956017)(110136005)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(478600001)(186003)(1076003)(107886003)(6512007)(26005)(83380400001)(2616005)(6506007)(2906002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AGCz6QQRHu67xQdoNJjW9s7g3PE7KqrESjrCrA5rCnaP/zB9rbUuVeRdBu?=
 =?iso-8859-1?Q?lEKshPLtqQGhXRyx92tkmvQxradFTWgW34L84tYOZ3KRS7gHuYZ3v+4ajc?=
 =?iso-8859-1?Q?QtU3cWR7X1ezXYVfJWhRzXm7qcXgNa1epvvt9yjtkAbIlGDS+wkDDazQ1A?=
 =?iso-8859-1?Q?mQS9SeemjeMaTE4eNAWTb9FP2bgutxuQy6MrOtdTIIYwLIjDSI5Ek8Wxpu?=
 =?iso-8859-1?Q?ENOsJvvIbK1bjanemgXBxJSArakhrXQ6zRx0V77+3/iep96CuBZMjGq4cl?=
 =?iso-8859-1?Q?vp/f5pejMtrDOjHOtGVmB6PzpoOc1Pvjeb9gUbrvj0Uauau0PcngT6KUyE?=
 =?iso-8859-1?Q?kcdDhSJhkOO2Cjx0/ixkMQ3TFcc7SLmRsiV5BQ8WZglDxSwgej4gpdlNv1?=
 =?iso-8859-1?Q?6S4i5tlUYdYlsCLn+9BebFegGyB4ELi7mpteyKRK/RIh2grk7Je45tbAZS?=
 =?iso-8859-1?Q?AKkmdHnaoeOXfxsKOK5RSNXuEd3ElmsOn/ja6Yy6R5LkzhLIJ+7OJG8kSx?=
 =?iso-8859-1?Q?Zx/IXTLEUdaqzJwFdSXhctPMhS9y7HLr3E8LH5zcg18fHklmJzBtAXXld/?=
 =?iso-8859-1?Q?aKOD7nzzueuL+iA+xXrIqLUJJ7cqYTnisByJ0PbUMeLwv4+ZE+C+XOeXaa?=
 =?iso-8859-1?Q?Pv2gxc6+0Db1jVaJ/EjoGLXiojZH3lfrpnT2SFTMbIEo2lROmYj+DdkWMN?=
 =?iso-8859-1?Q?Lx9yYhpTy9XmAn+830/vzVt67ZKmO9ajnnPlcK3V0knU/VHzdyAIAkEi4w?=
 =?iso-8859-1?Q?jkd7GgH6loSNvzLfmXwWH1TkW6j7qyGIKyUNBLrFIDA7lu/GPD6l7MX3oN?=
 =?iso-8859-1?Q?FBraGu8WhaWUcPCWKTzbvbk8GAbgzCBxq/yRTtANCFtRK49gbizD29UyTj?=
 =?iso-8859-1?Q?0GaFQUx1dRU3THvsbU7jV46hbK2SR5mF/OIaZo/3A/HC4OHmN3UnV5Rc5r?=
 =?iso-8859-1?Q?zviohJ0IRNnH0mpeo4Ko8kUjrUFDRW6h0Dw7XUDV7dKiNkoDcs4FsZOXFI?=
 =?iso-8859-1?Q?qaul6J5DGl+cfrikhWHH3EqwaZUk3iSD/+M0o6xi3OugPn7fZFuqZtCR9Y?=
 =?iso-8859-1?Q?x/xsKee2FyvavSw0J7XVVeO6I6M2Js3DXdWpx/1beyr9k2zoPIhkcAq/jP?=
 =?iso-8859-1?Q?7nPMT5pwzoSOsaXaijDF/SpGHmzG9uy3JW81Oam9YJqhhpogvUJLXGcYUP?=
 =?iso-8859-1?Q?t3qPl5VUelyEh7sqlUoP9sGdSsbe8RzInHyHJL9WqgkbzVWsvitQ3prKVl?=
 =?iso-8859-1?Q?wZB44njjDQ+4VGmhMJBevrHZTLAQJotE/W0MgTb/S4bdrIHmffBI795nBl?=
 =?iso-8859-1?Q?A39MDA1yArA7Cfg72y7buR6L8nk9VrYgNTohfN67kb4ixnIfbON+g01uV7?=
 =?iso-8859-1?Q?uQgcvByh3KHpxea8Bok7TYUfIk6G9cT/7T1EZdvtin/X5mQIVhKMHgfhUb?=
 =?iso-8859-1?Q?gkmC1cPYukZxSTOHYVRbGfJ7N39/1+j+nOTb1Xw80dGc3NUN82gWo2Qjrc?=
 =?iso-8859-1?Q?cqVCvcl2xr1RjYjo+DDa6ZAmp116a3iH+VawQ7hP8ROoEPJATc/2VYzVjZ?=
 =?iso-8859-1?Q?9TZqAbI/Rn4VEjanY6mIrwavDn73OBJ+3atiRbKzLeJ3DDbUwSyfk1vm+Y?=
 =?iso-8859-1?Q?zQK54h0+Fv+J3rr082VS8al6+og9vx/pJOuvsEqXXLEq7zoGdcFaaVlg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c593bdae-5a1b-4d5d-1d30-08da844fe541
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:28.1755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1UTO7QnMx/tA5kWqe1oC5j+dHW78fH1AY0GO8Zghb1lzgFKJ4OqfdOwvCBUh95ukkOxA5i9a8AMHGRUAYoR8Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: x9gkscPr00HmuXAOEmhqkp-q1v99vrRA
X-Proofpoint-GUID: x9gkscPr00HmuXAOEmhqkp-q1v99vrRA
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

Use vma_next() and remove reference to the start of the linked list

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/bpf/task_iter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 8c921799def4..1c8debd42dc9 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -299,8 +299,8 @@ struct bpf_iter_seq_task_vma_info {
 };
=20
 enum bpf_task_vma_iter_find_op {
-	task_vma_iter_first_vma,   /* use mm->mmap */
-	task_vma_iter_next_vma,    /* use curr_vma->vm_next */
+	task_vma_iter_first_vma,   /* use find_vma() with addr 0 */
+	task_vma_iter_next_vma,    /* use vma_next() with curr_vma */
 	task_vma_iter_find_vma,    /* use find_vma() to find next vma */
 };
=20
@@ -400,10 +400,10 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_in=
fo *info)
=20
 	switch (op) {
 	case task_vma_iter_first_vma:
-		curr_vma =3D curr_task->mm->mmap;
+		curr_vma =3D find_vma(curr_task->mm, 0);
 		break;
 	case task_vma_iter_next_vma:
-		curr_vma =3D curr_vma->vm_next;
+		curr_vma =3D find_vma(curr_task->mm, curr_vma->vm_end);
 		break;
 	case task_vma_iter_find_vma:
 		/* We dropped mmap_lock so it is necessary to use find_vma
@@ -417,7 +417,7 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_info=
 *info)
 		if (curr_vma &&
 		    curr_vma->vm_start =3D=3D info->prev_vm_start &&
 		    curr_vma->vm_end =3D=3D info->prev_vm_end)
-			curr_vma =3D curr_vma->vm_next;
+			curr_vma =3D find_vma(curr_task->mm, curr_vma->vm_end);
 		break;
 	}
 	if (!curr_vma) {
--=20
2.35.1
