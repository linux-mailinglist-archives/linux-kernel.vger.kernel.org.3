Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBB5553C25
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354796AbiFUUu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354556AbiFUUsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F3B2B5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:59 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ3wIC009733;
        Tue, 21 Jun 2022 20:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0b/lsYYUxSysAn3tBE38h37C9QUUY/e5s/pkGES0NFg=;
 b=Op3fqw3+I0DnmrCkRjSxd0MQqP5BvUGiTo+8/NkFOnmFCxeCHibYgRSm2cZFkWxNuVAq
 Z3H7e79sbf5tyMoJK7UP2HrtSi1AAqhKcmX41B25UJIeakcPeo+zbNAOUb6VlHfWafdz
 Y7TZ61zLMpVa74QileUgVxk4jPEeu1SmUhWo2AKGnE4X9yY076sQq8yqQztOyp4e023O
 Ywl4FI/fK8iaHjm3jRQWNW2Jx9cY3WTZ6kndwuo7wBoe6zhokWwjJFXpdAnRt+JAPhLe
 r/PIxUABmV7lNM/q7e67il61eeEfYIYXjYt15EBj6YBDUzgem6agVEPp98noRSB8XKgy gg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78txpdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeUhw027847;
        Tue, 21 Jun 2022 20:47:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wspfd-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KG8AX1cK4Y8IZ29W4L5eeQccnyy5z9VMn+8cs/lsERkjhv8EqekF5b94xrpt2TSZZqx4UnnQgUac9F8BfRPbIEuGE9uOda8H6gx/izcQ8kbyBoIkIgthXV7Y2RcuOovKq2FQPLyhOTgBUIWyz9BxER8FCBxux2Iiv2RAQUkNZZi1N2Fs6+LmpdRd9vE7o6NweM789tIGKFbLDy0RC6uj3iPTBN7ae2caAP5eIWC6St4vy5aX6INU5u45c8YRW88QVuHzjMpwgmNw2a5hI+8UYlZOirKJknsmaJEz9s4/tnaNd6eQ2biJMF1NwArndabr5vi65eTxzQGOLqIgPczeug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0b/lsYYUxSysAn3tBE38h37C9QUUY/e5s/pkGES0NFg=;
 b=WvpsUhla9Psv9DSjXoxaAbvi63FLi43aNrv5jCFw6p2WtfZ+7DnLqDHTvnKYiUcStAFLaxHbcA0v+qEpFBNsH/CPyK18fUe/hQ9cd5aLN09pRk5DEtJnDSkMN5V9L6RLWCCK4iduKqoi4XYkE3ZzYkbmdSq8XJGa06CFfEGtPA6mEJdd/7ptnGB8q8rSjbQdcIXM8IAZrPkUNtz+d6bPceHXino6Ncy4pdo9D9qvdWACQVxgfvEyZ6BKNXogvns6iCsSwwjKH16oacaCR6BKCHa6l4Qn7JjZjXTR494uwBZ21kUf6rRkUHalmprX0JfA12TAa2AWgLkWu4vVeJujkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0b/lsYYUxSysAn3tBE38h37C9QUUY/e5s/pkGES0NFg=;
 b=nB+aZDqghUVTP5XN3z+ksjoy25NWKTBAKvBL91wfnb5OP0OaTs3s3QjQ5I/FjKtU5KbX5bGYVrZpd7wUMpGrFmLZ1nImds4EpbReEED0wETnRNBpy7sQdiQYs/DkWAcJln1QPob+DdovpeQvaYCiMOLuqN/I5f8v0ozgRUYj5tY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4025.namprd10.prod.outlook.com (2603:10b6:5:1fe::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:46 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 37/69] cxl: remove vma linked list walk
Thread-Topic: [PATCH v10 37/69] cxl: remove vma linked list walk
Thread-Index: AQHYhbAQoiFKJNqNYUyVPL64lAEIvw==
Date:   Tue, 21 Jun 2022 20:47:05 +0000
Message-ID: <20220621204632.3370049-38-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25eeba59-bf5f-4e15-8d78-08da53c74c3b
x-ms-traffictypediagnostic: DM6PR10MB4025:EE_
x-microsoft-antispam-prvs: <DM6PR10MB4025A92411E1F44799CEA12AFDB39@DM6PR10MB4025.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BoIiCqsMC7BwmmCJ5oy8M9VAy0Ie5hWBcPlNAA3ZjewN46wxo7GCZ2Gg1hQ8iIsr7115ZHFYZOtjFeQecJ5zuiiSiBPmk8xUijxxWgNtwJObFJZtlvD8QSF25ODgYrSfpgHen2lXal1+22tfGppGtbr/iyoFzR1HsNep1cJBZa/JkpNdF7AVZ+vfThmz0roTPSw61FqWmEANpPdDnSTK3PHPkPJXwKqnuygZcQLdujMygnnN0UcMw9Lh/q6JGNR47XkhmKicggzIkfmYjZPwdWk2UUXoWZHrqXH5I1tOse9yeS8eZ0VNnkZFXXlgLtSd0QN80cJcfPRZnTLBynoPvh70+27IVrkDOEXAFFCT7vDwlTAoSUxqcnqUdVR7HzZ5hVnnFtPsTGFP89RgVvtyAl+M738hWTRzMwv273bXnrKI5jkFfkYdj9Uq5fSVLDiCAviUV67E6xjeUK93JL3qGfuEp8sC81Ao6D5znmRt1IhgQ4OfqzG3FNYqjwR8xMKTFUmjDcY1tYhsHHpJ7lp3qfynpp3GryLtZ4FzgXKNXqktGtdcmTrm+Y4OeC/ROOPfEtojvLLEK64D3naDUkeJuuSs+KGD8FztK47kRA//yDSKyilVJ5p4ZrcPtzdUg9UGgsdxxeohjQ8OrY+RxuByQHpXdoly6g0IfSCQsTCNsSR6VDCOBbwpQVe4eK93Ag+yjIVm0mPbOdLe0LtkncZdjqk1PICN6ewuel2V07HSbGLRwr5YopdPkQWmI2hoCG7r0EpZ9ScDixez+zhv8wCnSeQCZsNUO5AZsWa5rVNl9Aw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(366004)(376002)(396003)(6512007)(41300700001)(478600001)(122000001)(6486002)(966005)(110136005)(36756003)(8936002)(71200400001)(8676002)(26005)(6666004)(6506007)(83380400001)(2906002)(66446008)(316002)(86362001)(2616005)(91956017)(1076003)(66476007)(66556008)(5660300002)(38070700005)(64756008)(66946007)(44832011)(76116006)(186003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?t/JXAsZR6WAwoiDv6MqxFK+vc8NEwOFLUBl6+VUO/X6b5p4xh84XLDlQQ5?=
 =?iso-8859-1?Q?Bg0HDDd0urLOlLYvpj5uJwUd2oy8wEG85mgPocdQkV53yGH3x/IJM1IEsR?=
 =?iso-8859-1?Q?v/rQCH9+tLrsaV9tELZRGeDY/IkITZrxz/eS/B44sLMrc1pOIvoJ6vPh32?=
 =?iso-8859-1?Q?6hIKeoQhXamuMTq2AUfFKp/CGlc+qPStbtk5B4IzJzVSv+spo4rRIoiYmd?=
 =?iso-8859-1?Q?wGmLDgAoJFRJjzy1FWBt77W/yL0g6B6l0AWEdgHVGhWzbLz9FL1F4GS9Xb?=
 =?iso-8859-1?Q?UtUT/IGKcIRZlydqkwuVTxHAatGY3VSlZ4Wwmzb7ARTpcU/dCNioFiL8uu?=
 =?iso-8859-1?Q?ol+8MiIJr5rFjTdG6dpiyLIhVqZGsdGKtfi5j5ocPH100VOUlWqTEQO5AX?=
 =?iso-8859-1?Q?K35Q36/rEwsUooTtqVsLi55zTBXUmJr6mnaLjbzqbcBrt5B8Hij+5UJYnm?=
 =?iso-8859-1?Q?SXrVw3BW292RWtQD7X99mMfbcveeTjlsFg0HR5VMpXmmJR8wmNDGcKKATZ?=
 =?iso-8859-1?Q?NU2IPShMDl0jNp4LldzrpZj8h1LuHbF0TsxaoTIOCvMjbgL2r9xw9tft6v?=
 =?iso-8859-1?Q?EfEMSHQKq+O4pAgUPxK857v576shkrd26PAcT1aTJm8Z4+/3PR+DNSAwYs?=
 =?iso-8859-1?Q?epwNRYm2pTlnHpdX+Cz5ObE+SOa3SqxGUDlCP9sKvk3xBGikbERNpyChJG?=
 =?iso-8859-1?Q?kPz7svQx6bfTpax0punoe1Eb8Qua1ZrRgRqFzMhIqyWyDt+CppoaLHXdKs?=
 =?iso-8859-1?Q?bXomGD014R/97RFnTQAt+6Pz47o04cYE6RcEV8Tq5ncoV1avHG8/VKN+Y5?=
 =?iso-8859-1?Q?GRtJxDjBc9RfeJ7S/4m+XmBnUh6zH5iWWO+hn41iXZ1XTeIu9U43YEh+Ib?=
 =?iso-8859-1?Q?Pz5tXeR1JRHP5G/MFoGveXFRu1Y2z1G5e7w9dTkMgULbpw3j+z2BurdYuT?=
 =?iso-8859-1?Q?8ZeVyn1Vuj98+oD1sO5YWV81ai21q+l6UdbPR7Ggo4KxFhrAy8SBgz+y9b?=
 =?iso-8859-1?Q?4TfwKEQxzTbh92NQirXLBojEGjOzrTdbH2wG3lRLWKGsFdzvKQLrTyZV/c?=
 =?iso-8859-1?Q?VYTLbk5+MNZSx9N3QfM8lHjWL73UsxMlmuojQY78A5aIlR6IZC/skxqZDM?=
 =?iso-8859-1?Q?YUnHV2Kv5CKw80qpRAY2RlEOSI55WhIXDh7Ha1TiEkqtpg6nhzBXnUPwcm?=
 =?iso-8859-1?Q?x/dQYtiKkFBG3iFkkaczu8aNCAyyKit/vSSemEnN2ryShqkaxYLkPgvUlt?=
 =?iso-8859-1?Q?GBRIJwE/T8vgYda55XnMkewS9qwdNof19dlyDOaOEfjy9V0DPc7E3UjKdj?=
 =?iso-8859-1?Q?O9xR7617N4spvkxqBsvSgWc/Ih75IIf10OCO75B2fdNDVm5WDYoL3KHePO?=
 =?iso-8859-1?Q?9PZXkEQyWbeBKJuJh86y0GpSNEAJOoh4c3UOMz/F2dnINak9lUllUp6/uo?=
 =?iso-8859-1?Q?FOiXxQ2eb/V+jOH2Q9mna1FRbJEfwH7SnundHiLFM2Wk8VOH91q9mVL+eS?=
 =?iso-8859-1?Q?qeMJ+HiHtcGr+sQKzOn415chzTRd3UPzKdC0nUvSW/J/1jQzgDorv0/RqT?=
 =?iso-8859-1?Q?eRJIPd/tV1Fa8OJ4q7ZXLyqEnVAHbTu7bIEooOJFSN3yL/YP/kH+wjPJ8r?=
 =?iso-8859-1?Q?1WBAT1a3L4OmfrKjMThF5TUFSdLxsEOSRyMn+vNvrAHUVw7Ghz3Cr6TEb1?=
 =?iso-8859-1?Q?RNQ+BcY9qOhkucVHOzi1Mhr2gRGYVEpi4pT+uHU3ej5aJg/mxpiloUJyXY?=
 =?iso-8859-1?Q?RsDhldzEFLkWtxoyPmuhE2LyFcAEw7vidLbN4zWgEx8xmBlPXuQwJRUz97?=
 =?iso-8859-1?Q?r+9vK5aa9qRl0Lu4wBYkojaGL6Vr2R4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25eeba59-bf5f-4e15-8d78-08da53c74c3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:05.3630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: laYdZMSxuzhklsehBjj6qF8djSMyf070G0PnaXbI7QsqwyQ4X/Il8f7r+NugM0yMnROjRGpR20JSAvr6rhu30g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4025
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-GUID: GpKkseLiPuDjaBdPAG7gIDdSRDYfNL_i
X-Proofpoint-ORIG-GUID: GpKkseLiPuDjaBdPAG7gIDdSRDYfNL_i
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

Use the VMA iterator instead.  This requires a little restructuring of the
surrounding code to hoist the mm to the caller.  That turns
cxl_prefault_one() into a trivial function, so call cxl_fault_segment()
directly.

Link: https://lkml.kernel.org/r/20220504011345.662299-22-Liam.Howlett@oracl=
e.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/misc/cxl/fault.c | 45 ++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 60c829113299..2c64f55cf01f 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -280,22 +280,6 @@ void cxl_handle_fault(struct work_struct *fault_work)
 		mmput(mm);
 }
=20
-static void cxl_prefault_one(struct cxl_context *ctx, u64 ea)
-{
-	struct mm_struct *mm;
-
-	mm =3D get_mem_context(ctx);
-	if (mm =3D=3D NULL) {
-		pr_devel("cxl_prefault_one unable to get mm %i\n",
-			 pid_nr(ctx->pid));
-		return;
-	}
-
-	cxl_fault_segment(ctx, mm, ea);
-
-	mmput(mm);
-}
-
 static u64 next_segment(u64 ea, u64 vsid)
 {
 	if (vsid & SLB_VSID_B_1T)
@@ -306,23 +290,16 @@ static u64 next_segment(u64 ea, u64 vsid)
 	return ea + 1;
 }
=20
-static void cxl_prefault_vma(struct cxl_context *ctx)
+static void cxl_prefault_vma(struct cxl_context *ctx, struct mm_struct *mm=
)
 {
 	u64 ea, last_esid =3D 0;
 	struct copro_slb slb;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	int rc;
-	struct mm_struct *mm;
-
-	mm =3D get_mem_context(ctx);
-	if (mm =3D=3D NULL) {
-		pr_devel("cxl_prefault_vm unable to get mm %i\n",
-			 pid_nr(ctx->pid));
-		return;
-	}
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		for (ea =3D vma->vm_start; ea < vma->vm_end;
 				ea =3D next_segment(ea, slb.vsid)) {
 			rc =3D copro_calculate_slb(mm, ea, &slb);
@@ -337,20 +314,28 @@ static void cxl_prefault_vma(struct cxl_context *ctx)
 		}
 	}
 	mmap_read_unlock(mm);
-
-	mmput(mm);
 }
=20
 void cxl_prefault(struct cxl_context *ctx, u64 wed)
 {
+	struct mm_struct *mm =3D get_mem_context(ctx);
+
+	if (mm =3D=3D NULL) {
+		pr_devel("cxl_prefault unable to get mm %i\n",
+			 pid_nr(ctx->pid));
+		return;
+	}
+
 	switch (ctx->afu->prefault_mode) {
 	case CXL_PREFAULT_WED:
-		cxl_prefault_one(ctx, wed);
+		cxl_fault_segment(ctx, mm, wed);
 		break;
 	case CXL_PREFAULT_ALL:
-		cxl_prefault_vma(ctx);
+		cxl_prefault_vma(ctx, mm);
 		break;
 	default:
 		break;
 	}
+
+	mmput(mm);
 }
--=20
2.35.1
