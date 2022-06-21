Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD158553C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354790AbiFUUuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354637AbiFUUs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4051CF15
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:05 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJG25p012609;
        Tue, 21 Jun 2022 20:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=l7HGPT9aG5Wh9HpvMul7ZqgrkgcgJYi1tcxfzgkJym4=;
 b=Vme1sEnNJJtRBUDAzeYwsYfEXI2pEGqZdlG8vHw63KwQbuAQrdaYcbC0vB2t5bDV2Uqu
 D7rNXpLBmVirkoFZV93nwio82hF45UGhPVokAJQwUQUHX3DdJ1MaTVhwGEdR5upZBPFc
 EXjwUBdiDYarvTD6VZnT0F/UQXD0qEZggKjRC3toQj2c3ydRn+f7VZdTBOLKE7EfiDlQ
 5LoDV37pyT2D1pz52tHUc3htnCy6Wph+GEmnYTvASN8Ml0cYBxqil0PQEbgg659Zmqng
 AL8Tn6ONB1WklJSiAXFLFtRoBcQThIg7igqxtBBBebA/S8bUHVLd67HiDHgneRys0nF6 vA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kf6khu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:53 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKehRH001620;
        Tue, 21 Jun 2022 20:47:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5cutsv-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Us9EjweG3oiEexu4vGsfWRA9NiV7yQZtZd63lIxMaqelKZjbXvU/pqz/zfA7jjazxJ9ucIdfnLwIxtQuT6tot3acYEXYPmwdYEprWGMET6m/HBD4s0YXfAlZ0W+klAjE2JOz46stJTpHeO8d0jVpjhXmKWrdvoJtYRkqrU3/vovb2aAWy3lq2bhwX+QEiDJ4QsRICWkp3IC40Uephw5XTjv4NVmT1JjfcMEH1djYCAZYEcW4xDLEZr6jdyi8MyBtvsG2XNdDn358V3uM9lX3dcQ6EpJn+Cs4bnw6WH3FjNnEOH3lNxXBfNESnvjI/8cKvwK/JtaEYptr2O3ZP8fydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7HGPT9aG5Wh9HpvMul7ZqgrkgcgJYi1tcxfzgkJym4=;
 b=VNJVtQVg00Ny1WsGQHcgw1UOPp6fy4YnhDC4xcNb6LUD75ov3hmFf2RnqXTbZHw6nbgKa/gpYll29u9+JZSgvlqn9i+5dh5feun3GqLaZGaeZXrNaRu4Kb2rI1UeeZOOLpCvlHbkLbueNGcKKt8/o5A0lo43sig2wMCuPvqHJx+abmg7ZFc5vD7WrWpevwMVYKuoJ0q1aFVBvvoAp3RGjJABNcjptgRnAnrGr0XwZ8+2r1hF6lZni18yYpP8Xu/glZZf2bkvOs9hPNRJSewxC4UXyb23zwT1TFMT5vgmgrSsX167VigmxGvAROKj7MrnA3gTJItENWdkjpxKI+4oRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7HGPT9aG5Wh9HpvMul7ZqgrkgcgJYi1tcxfzgkJym4=;
 b=WN23V1lO5ZF5PDfkESk8YtGc2er8U6s9hE9B1RV7kFbHIXW1mFx3FaALTKkahwHyQGMsupZ/YbHO/ut7WFdvbWq6WB7+gsY95/ziPtzhQBPdGbQy1rn3G08O5uP1ncAiiEOd9G99sRyM37atVOgqwUKk9GcEh3KLSnK/IUW+PlY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4025.namprd10.prod.outlook.com (2603:10b6:5:1fe::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:48 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 40/69] coredump: remove vma linked list walk
Thread-Topic: [PATCH v10 40/69] coredump: remove vma linked list walk
Thread-Index: AQHYhbARWKKN1LPUVUu6eiJ7rw0jdA==
Date:   Tue, 21 Jun 2022 20:47:06 +0000
Message-ID: <20220621204632.3370049-41-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 818a5d23-75e0-47eb-f678-08da53c74d0a
x-ms-traffictypediagnostic: DM6PR10MB4025:EE_
x-microsoft-antispam-prvs: <DM6PR10MB4025F60491B77F478132FC15FDB39@DM6PR10MB4025.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yTwuzvVAHEeAFVEKGkskPYNPGErYnwS2gHPvthAI+lHWk6m96hUbrmr7YalncrC8H2GnWaLBKUKYO8+2s+l2g1fqvnVtyaWNyEPgy2IhG5CQugEiMfpwxeGpwRrB9MDih0nPrxpFpKzWBH+oo7xxitKYbhgFpDO2xRmcukdvgxRgezYRBtrZY7GUhGrOmq0bDyPz8JDAW0T9/6O8im16mkC9QHUce9W8stfOnahQhtx0dqoE1TPVAkozY7Js+KH/8buWtjif3lOykkwH6BBtdMC69ZczPEsk39744at+1it9X3WClOq34oxLBab3SAYr2bECIRmaAZAveugBVbKUCdJeyiHeLZKAEARyNh7qiVARYPBXNW92N59W0rCvVRdh9NdvTPq17TepHPztGZHew9n1cKgpee6aNUty9LqKG3uA8jUj/NBWrdxQ5fY8tQxbMR2NzNNM+D0nznTLv0xFpmk9z8P367I2Fpi+xUMmhJI0rZq2akX0ufw3R/hZaz91IWww8ZYX01zcpexZaoxEsEqwS8LwSISZJ08WXdK9jRzzas6RfWlsa+yoWJy1Wn5aMNMT7cNVgiCuD7AS6R5PKMPyV8ANfyV3xsD+UGpYhTcigvnKjsL/u4EkC2aXwYP/iKQjgVDA8v72lv8trPJ7d623sI4jeUhbQA3g40jl/2dnKk1ZPtmwcVehxrBqX2CLuH2fHOHZu8FEqWxtvDgFplbOD5lAPvZzd1Y8lc3LwAgf0Uz2FaLI7zIypj5dFZFU4ZdTOVFsC7CazgPXIVGdoW2yaeYzb28dIWsB5S6+49Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(366004)(376002)(396003)(6512007)(41300700001)(478600001)(122000001)(6486002)(966005)(110136005)(36756003)(8936002)(71200400001)(8676002)(26005)(6666004)(6506007)(83380400001)(2906002)(66446008)(316002)(86362001)(2616005)(91956017)(1076003)(66476007)(66556008)(5660300002)(38070700005)(64756008)(66946007)(44832011)(76116006)(186003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MI/E7sXboP3NcuYuWGXFZvkI75JikygdMdvhBczWvfn5FLonr7F00yKNb1?=
 =?iso-8859-1?Q?V/v5VwB1NISvZjsgwGS6rIlfQaZBf8nNTlzBvRk24RrNO69FjvnzgpkO23?=
 =?iso-8859-1?Q?DjM17V9QDjaIRyayXux3Yd9nVI7N31hI8WAo60v8wcj0xSdUYGTELZpnVY?=
 =?iso-8859-1?Q?gjWhBwsOXh5pODwCb0aG8RG/2uIWS2ZV5PlI678EV565GWLNE3nRgna5WD?=
 =?iso-8859-1?Q?/RNd+vmELK48yxAwbGqjLEClrgVp2D6zuqoxdwlNHmwb+0AOMOKNyG/ztg?=
 =?iso-8859-1?Q?8X0ocgTGvDg3Dl/kv9SvCA2wp3rp2PHLcJKwXm3Uk7HtIUi4DgvPr132DA?=
 =?iso-8859-1?Q?5w5joUJfcRkqvaj8gj7HxgnOfTvbABUYqKzvPm26Ppej3uTFz9y5zklu00?=
 =?iso-8859-1?Q?V0FtX/Uf16E+M16/V5rPkzx8BroNGQsPNWi3CsEfQiIoAp0uOwBl0zVZ/D?=
 =?iso-8859-1?Q?nQ5yLtn/qXUyxGFPS9iR/ZBicXb7qg5ti0EQk/m7GNG1bNmg9mEHg1X+95?=
 =?iso-8859-1?Q?oWmU7akP2T1Ms2H7C0VDDTeXG2eE6pMuCziNEU2W/ErqYxKmCUUfwReY5d?=
 =?iso-8859-1?Q?AhGX1NpZVqYOO4OJqqDX1fH1/gH9Tze2d8cD/8E0en9C/fyqwCF3NUIEyB?=
 =?iso-8859-1?Q?pPAaG96bU4ENXUP+IP2v/Cvn9wcri7NHrYVyYojOMdeihioMo8LNdtgd18?=
 =?iso-8859-1?Q?3Fydr/zho7YKog3ViBf14FOdaZV/Sv2jvMugTx2JVX362ICt66f/+Zloys?=
 =?iso-8859-1?Q?i2hOlf/OAmW/npqBKNPvQcjb2oGZHLhd8cLVCMCNUxyeT8oOnhDBk6jZxs?=
 =?iso-8859-1?Q?ww79NJFA2RZBtA9e8nadFjLZjnye9p5vlmovWiv8rFshgbA5MJEX6a1Kzs?=
 =?iso-8859-1?Q?5D2Ke8umt4S+VQetez0fp7Z3AZR1qqDHjVluh1bGBiIiMBsmHD7kL512oE?=
 =?iso-8859-1?Q?aE2bx482ogStqlTMKguiQXktd/hRWO0L5YkmmyUYSgd3Z8nCUmrcTvSXwN?=
 =?iso-8859-1?Q?ngcu+zRG21f80GycULM+0cRh5EN5h07NTUriWZvqeE0T0Yql9gl2wdF+ah?=
 =?iso-8859-1?Q?bCVU5HWednYySKqdn5EUmMEIjG2d0YFRYKOCG5GR1rJtIvy6HPP89EzxbN?=
 =?iso-8859-1?Q?Fw8TG/APFKB8C/G7TAeE0lGLlfOKRo0QAbS4qXEi/Dp2pDobcuEbU7c+xB?=
 =?iso-8859-1?Q?C1tF7HO4qPVh/RtnDl3xsrQhICLRO2qMByh2Kb0BvtK4oDTubPmpoPbJnT?=
 =?iso-8859-1?Q?Kdk/JmCKgl8NXrA9aVq/f2MBGmOzofQc9JPj/2NA8D8Po52+DX8Mviqe8F?=
 =?iso-8859-1?Q?aKDryGna0Bc6zv9r9EM8bjY/2gjJpog9gXT4Npi52qFGEOfu8PSp47Ffkz?=
 =?iso-8859-1?Q?fbrvRtj+TIaG7qH3OTTpzfFtuWtCKoY49MoA33P5e7edSYBu6obAbzQQoA?=
 =?iso-8859-1?Q?zHkcKEISKjjd6Y/grkz5CcZNNsFxgpYxJ8szjLSTFiPwaCXN3ufFS9owri?=
 =?iso-8859-1?Q?QMRbY0lgo8s1Hz7gkdvZcjwRS7s2rbjUp0cY0IT7MdqDNoKTkQVHa0spAX?=
 =?iso-8859-1?Q?GX7aSCwsfGSrRATGOG6Q3Cp76BNBIv5CM6fUazBoK7Esl4rwChUCKrfZlj?=
 =?iso-8859-1?Q?/n5z1F0YHk8xYL4olwv5K5wNwl9Dosxg8Z5mfulhSPqL3DyMLlLZZl6SKy?=
 =?iso-8859-1?Q?hPHLMctAxmamvCROr8Jfz3h186yZdKnwnRSwl4N2HypA5LseFjWC3L4JF3?=
 =?iso-8859-1?Q?w3ETw1sewl86JG2h1+1Qd1H7OmYqhzlrF6yV79vcnmtZFzgSrNEMZgYP0e?=
 =?iso-8859-1?Q?uusi6sPP6qOofEGIY7RlnHNtZYUKoNg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818a5d23-75e0-47eb-f678-08da53c74d0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:06.5504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2aLis3Kk1bRHRznPB+D9LhR2OPbm76XBcEGM/DqFbAEZrh+k8YnQkxJePOUCocA2QH/CXaHHtDbsesMXlQT56g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4025
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: BXjO6C4r3hY4FHJySAfkJMRDw52FvVXs
X-Proofpoint-GUID: BXjO6C4r3hY4FHJySAfkJMRDw52FvVXs
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

Use the Maple Tree iterator instead.  This is too complicated for the VMA
iterator to handle, so let's open-code it for now.  If this turns out to
be a common pattern, we can migrate it to common code.

Link: https://lkml.kernel.org/r/20220504011345.662299-25-Liam.Howlett@oracl=
e.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 fs/coredump.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index ebc43f960b64..3a0022c1ca36 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1072,30 +1072,20 @@ static unsigned long vma_dump_size(struct vm_area_s=
truct *vma,
 	return vma->vm_end - vma->vm_start;
 }
=20
-static struct vm_area_struct *first_vma(struct task_struct *tsk,
-					struct vm_area_struct *gate_vma)
-{
-	struct vm_area_struct *ret =3D tsk->mm->mmap;
-
-	if (ret)
-		return ret;
-	return gate_vma;
-}
-
 /*
  * Helper function for iterating across a vma list.  It ensures that the c=
aller
  * will visit `gate_vma' prior to terminating the search.
  */
-static struct vm_area_struct *next_vma(struct vm_area_struct *this_vma,
+static struct vm_area_struct *coredump_next_vma(struct ma_state *mas,
+				       struct vm_area_struct *vma,
 				       struct vm_area_struct *gate_vma)
 {
-	struct vm_area_struct *ret;
-
-	ret =3D this_vma->vm_next;
-	if (ret)
-		return ret;
-	if (this_vma =3D=3D gate_vma)
+	if (gate_vma && (vma =3D=3D gate_vma))
 		return NULL;
+
+	vma =3D mas_next(mas, ULONG_MAX);
+	if (vma)
+		return vma;
 	return gate_vma;
 }
=20
@@ -1119,9 +1109,10 @@ static void free_vma_snapshot(struct coredump_params=
 *cprm)
  */
 static bool dump_vma_snapshot(struct coredump_params *cprm)
 {
-	struct vm_area_struct *vma, *gate_vma;
+	struct vm_area_struct *gate_vma, *vma =3D NULL;
 	struct mm_struct *mm =3D current->mm;
-	int i;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	int i =3D 0;
=20
 	/*
 	 * Once the stack expansion code is fixed to not change VMA bounds
@@ -1141,8 +1132,7 @@ static bool dump_vma_snapshot(struct coredump_params =
*cprm)
 		return false;
 	}
=20
-	for (i =3D 0, vma =3D first_vma(current, gate_vma); vma !=3D NULL;
-			vma =3D next_vma(vma, gate_vma), i++) {
+	while ((vma =3D coredump_next_vma(&mas, vma, gate_vma)) !=3D NULL) {
 		struct core_vma_metadata *m =3D cprm->vma_meta + i;
=20
 		m->start =3D vma->vm_start;
@@ -1150,10 +1140,10 @@ static bool dump_vma_snapshot(struct coredump_param=
s *cprm)
 		m->flags =3D vma->vm_flags;
 		m->dump_size =3D vma_dump_size(vma, cprm->mm_flags);
 		m->pgoff =3D vma->vm_pgoff;
-
 		m->file =3D vma->vm_file;
 		if (m->file)
 			get_file(m->file);
+		i++;
 	}
=20
 	mmap_write_unlock(mm);
--=20
2.35.1
