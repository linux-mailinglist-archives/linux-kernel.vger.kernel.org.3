Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC16251936E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245435AbiEDBVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245363AbiEDBTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:19:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD08443FD
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:56 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KbxhI013665;
        Wed, 4 May 2022 01:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1VEJx1x1wvX+4QycQPS42TVRkpKJcax7YexB0MSjzQA=;
 b=M5LAeKenCL0Yr9McpwIs/IRE6TUDj18U5yj3IHACZ+j+nVy4W40xIdhzCStvGF1ke7Vb
 nMOFfGKJm3PXb3zOg+vsdG6DLAzWe2E2zH8xGXALk0WByW/I5IJM4Cva/KF99G1T8sTI
 Zz2aHrnotbF2E71SZtu+CAYEsE9FHn0EeJWapc4ag+iHjH3frPmkvoX+S46HsFJ+aU7c
 naLdzpRywehD0Mh1lTfpzPNlfrgww8XzBpUVml1njT7Y7o5cc5mViaM8Dn9vbhYeyKeu
 J/c5wdm6OXw9QQyFmGV06HGBlKxjE6bIqjy5lfNqoLefPJU/tAD3XKuq+uAp62Fi+g5t Kg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsf6fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BXQx013207;
        Wed, 4 May 2022 01:14:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv41r-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTiEBUMolSVU/wW3yLjeJKM3oGqSC3FkNU+vZ5vpsiQ3kuSMlxMhETVv8/gAnLL1wjSjE0BuLsGBWY/eQK2QjURimrHhCkGhU8m8lmZyNB8qkRSfnR6BQMlYGjtOCOH/VPpF9QOtmol65IEqL9Qv8cC0KD+gABAW4xWVAmhwaUGxYREd+M6yghjj5XBhZhrd2VxfkWfJlwsp3WYJyNHdQVaJGLkdIZDcHt+AnmvA0mxWT4exwme/Zq20oNCtmK/DvJ/DEpWC23nMp9YtWbqVpui12kdCG+aaKGenFAQGjk2Dcg72rAlvHflvKqWEkovJkwTnk0gHHAONIgIX37X0ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VEJx1x1wvX+4QycQPS42TVRkpKJcax7YexB0MSjzQA=;
 b=QK37KqA5OKWDZbCJXxCAgr6qzokJuzpjBC0bk3+PrFubXlmmBvey+4hSxOe2uNLl7av38LjQJwialR4pEI71Q8C77TfSaNue83i3CV34b0MGdCIjETsKF1WsL0lSDVfb50+qjRTp7tUirakmFZ9LpxAWaMG5usKUDDAfyHVdML2A+bvwHHfWMr1MkWM5Z93iAxy3vHe8N17jkVeRzLFnS4Tro05XA+TfFqTFIJSl0QpdV0Ob9lQP0PRC8v3+OAFGuJFGf9bSiIR2xCMi8vYVivxKpBJTCDnp5ni7avdPEeDb+axSM00e7OCbixe+lusvMMKaIek1fi5cXB4vW3Pl1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VEJx1x1wvX+4QycQPS42TVRkpKJcax7YexB0MSjzQA=;
 b=wXN0J6umG6JO1S7nrLnH5bIOrPOdvkDtU5bsxQlYx5/p9fbTqdOFeLKQp/Wr+fQqL9Zu//Q/0C/5StLaeuEHASeEOcI2LmjRmLtP0pti2khVje01UXSiEWzsC9FdqYvcMZPk3fOzyDY2QckrOjjcqacNtddv1/29v2AnlD674l0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2688.namprd10.prod.outlook.com (2603:10b6:805:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 01:14:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 54/69] mm/madvise: use vma_find() instead of vma linked
 list
Thread-Topic: [PATCH v9 54/69] mm/madvise: use vma_find() instead of vma
 linked list
Thread-Index: AQHYX1Q+17qOJt45a0uoSzKVeeG9aQ==
Date:   Wed, 4 May 2022 01:14:03 +0000
Message-ID: <20220504011345.662299-39-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93210605-d140-4fa9-98a3-08da2d6b758a
x-ms-traffictypediagnostic: SN6PR10MB2688:EE_
x-microsoft-antispam-prvs: <SN6PR10MB268816AEB5C5A666AB491678FDC39@SN6PR10MB2688.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WDkvBrSHUK8HoPi3XakGlpbkEg9sD9FuzQPtxxM1Ajm3zNoQfUvdwtmvaVWcCp7/o8J7s3gVW5W921WfFoigSV+QpaRKoXp7ErcX0zsK3N2I8N6bk7wMExtGyYIjLjncApU9Gllssc06wd9QwuCeVA/SAZdyjxCaeFoBRuCcNy9HM3S+pi3av/BVV3sNLK3dH7hltRrOMxG0trAllWOLQrHMKAvPiE01OblhciurIInakXvUw9106zwKDrWXxt8eNf2sP+dD5rAlezlBXujI/F9uT4QT2z61ddPHQ4GKAMypo5KkTQbxzKvrGb8JU7QtpTEeIauKPnfp6pnhbtE9rK5fDM5Mj67hdPAVZ5PTbxUgtkGOdbmWrDVcHRggAnztlt2q12MCpUFbFRgRmIp44ORkbuWJ20iTt956ANsiCnrpZnyPqD5Q6RH/4hDMNI9+LROKTKYkqhzEBFwcCjcRTBU/aLYAg59IIONaXR67Qrky0mX6v8IJ3EPz+RxKixRvWjUDd6ThDoca6AqbMIQ8m5oMtiaxQ/pWmNCTmGaSa3FVBF7lnKgjIB713kxhOkMY0cijCNLL76LpxcTnPnQTCdEWlLJva5PqZk9iu8587z3B2ktAanU8ZKQtP5bE8ZD0Gz6Mz+RjELmqPkPN5LYupZGKpzxOehw1SntVdc3mqlXl50BHwYndXpeliGotDlbjN9E3S6TJJrcNJVBUxiDopw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(122000001)(1076003)(2616005)(66476007)(8676002)(66446008)(64756008)(38070700005)(36756003)(316002)(38100700002)(66556008)(66946007)(76116006)(91956017)(110136005)(26005)(6512007)(71200400001)(8936002)(6666004)(6506007)(2906002)(4744005)(86362001)(5660300002)(6486002)(508600001)(83380400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AsJsmQ4wy6cj8P+umN0eRTA1Pj1cx2RmUjDty7GgdrrOZC/Ih/MVXCwXve?=
 =?iso-8859-1?Q?yM0lCj/R9jTdINISGgtdHmvprBeVs6AUq8URcZ/s6i5LEtMlkeCEYBZxVt?=
 =?iso-8859-1?Q?vfjUx+gnQzO/wF+fWvq0ccSFIFA3hod6QxQdYCx2JqoNo2nO83vNGd8RKY?=
 =?iso-8859-1?Q?MYEjljVO/1ltjRUqaxRpHpDqeH7D+cH27ZvAOAzV8R0DdhOzliIW3uBhGL?=
 =?iso-8859-1?Q?saieDkwfYP3Elzx62nHoSoAdLDty5mzYrElroabXm4QCm7T0sgKoXQxhyB?=
 =?iso-8859-1?Q?8LuqQDVsIq09x6xS2Yb5AOYlUBbawRSAWxYI8qccjoScIYiXT7aBxzCPwJ?=
 =?iso-8859-1?Q?gDyMwnXKi6WCuuREaXQZ84Bn1LjIWRRyHA0dOOvQIGwRi2Kimf4511m4zh?=
 =?iso-8859-1?Q?DBl8ZWmwWPtU3r7hXSdgEHbhEyCU0APPAtrYEKaB0tE6GyX5COvOpYnxOZ?=
 =?iso-8859-1?Q?s4Jlj74T1Y21/SAjb0BxcZRiqRzG+TSKjmQzbxFDNOeGFsvFX2lPfCajwB?=
 =?iso-8859-1?Q?ZqBP/g2gFtCpu7UIc5bgnd3NGoqGTcdUARAQyUbs/nP5+1u782vUMBIPoR?=
 =?iso-8859-1?Q?BZRQOeYNbQOFgGNeuHq9Qbfx93dmNa+mz/QgwqWTsH+fXHkttNcRL8P0VH?=
 =?iso-8859-1?Q?71ELV3nXw2ku8gsWcvMTNiY0A1FRDKC7vUvVwvLY/sstlNUdrRCrJsOo46?=
 =?iso-8859-1?Q?Kam9mXLEnc/fwiBYphL+hXzzFq10nfsZja7wOsiyoDExkxEsca8Lh3otbA?=
 =?iso-8859-1?Q?Th0EcbAmpBHLzkE7VUNhTzDrfdw9I0J+CalK9Oqm77ZhBgpZd+EPZFd9TS?=
 =?iso-8859-1?Q?HIwbwQQH1b/yt/7q8nzLH8GLm0DlRX3E0/bdOAjB7/77/LjRR2kX6WwU6Y?=
 =?iso-8859-1?Q?pNzeMVPYYoIhzfHDNwm8p/dd3cy1xk7kwcwg8FUm1MOT1QsWFCb4HNZkNj?=
 =?iso-8859-1?Q?eiB+RWg/dOtNs9GRP8S1DIEP4cJ9iImnrbyWjBJwyGmVzSpVS1r7k+0oG3?=
 =?iso-8859-1?Q?SjtR8ZdGqCk0tZ9G2BTvv8sZrmwV7wn+JcXeKI4+elcA/Rujko/KjhzZpT?=
 =?iso-8859-1?Q?AUAfhsTOlLseTajrSaVoDN36urMw0XVcCrdneey/dDWiElSQdKFUJgjoxt?=
 =?iso-8859-1?Q?WrbO38PL6nvzHuFxLSHNdmV/n1HyFiuynkyreMsOVs4HtVQY2hrn196nFV?=
 =?iso-8859-1?Q?TtiAz4aWKtk8gMRid0VikqnFyJIdjF7DxR8fTWaj1AJhblpdjwKAbxpDNV?=
 =?iso-8859-1?Q?zGAwLt0iEmpZI5C4pQAWqphcR6CGHiRZN3HQVFC+7l9gXA7PCbsDFJsl2H?=
 =?iso-8859-1?Q?sSFjsRNQYFc+3IiN+VRKk8ADhWReVvqC6v6SwP8P10+PR+YRfwkxMCaDcb?=
 =?iso-8859-1?Q?s1hGdEKh2o+nxzi/1GXwHr6a6/Uoxb1q09DJOT/5mIMIfSEkP049yvxqAx?=
 =?iso-8859-1?Q?wbxQrrGTbb6oKgtX3S4I3vEkT1GVN3l1gFLp7gfAzYAfq9R4v1yLq8VwDe?=
 =?iso-8859-1?Q?O8Ty5C3PBofTglTNaytthygUIn2boRELLohJrlwcqGW2xDtuuUPIABNyfe?=
 =?iso-8859-1?Q?L8JUQFDaC1+5UvqcgHE9yWmhpzUvLIWG6UC/+7OjXKBdh5T7DYZsIjLc63?=
 =?iso-8859-1?Q?gvo30zwex8nthlvSNDxQW+ZmDDlvLs6RFP/peNGHoDg9O5k9l9HZvqPa2V?=
 =?iso-8859-1?Q?P0ZH02y7zfryyUrg0wPhB1wt8kHUX4aktdTIL9ju3Uoo/Fr6tDEMUX05DJ?=
 =?iso-8859-1?Q?rXOJQS0B34h0LfmyxpRL2iL+Qui+PNizSGnPyxpRZTbkImIHEr5v4VutYy?=
 =?iso-8859-1?Q?wI+XGsvPQCZMfyG5Qesbda4m4Hv7sV8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93210605-d140-4fa9-98a3-08da2d6b758a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:03.1106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2jOLqiIQTXFUVWRVIDGU7emW4gxEZzR4XLi1JWRVDlxT/YVMR0OMZbFW3J7TJomr1BCt2+Y5+4TtiH6NHbNmWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2688
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: ywugVvR4HOIuRHuUCKo4RrR1nLLuC_BZ
X-Proofpoint-ORIG-GUID: ywugVvR4HOIuRHuUCKo4RrR1nLLuC_BZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

madvise_walk_vmas() no longer uses linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index c965fac7b13a..3d8413a27757 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1227,7 +1227,7 @@ int madvise_walk_vmas(struct mm_struct *mm, unsigned =
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
