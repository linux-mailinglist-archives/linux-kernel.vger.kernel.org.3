Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F9A57ADF2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241264AbiGTCWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241131AbiGTCVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:21:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA646C136
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1WMOS016723;
        Wed, 20 Jul 2022 02:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=UnwojIyjlGOiqaAr6LG/+ckPWfBzL7RuclvHq/lcJDA=;
 b=Uw2iHu6oQyvPiCFEt0QbtgBAg3zneEh4qR7QcIk/Uowk184rDqJgk8HqVy+dMFGu8YHN
 qhBppBnihf1VzvP+Nj/xLFMOj73GejMhrqv1r2SQkCF1qvHZB8dcKQj7izmfQIruqqLA
 m5GpJC6XKkQwRTXoC5aAIC9dUclVkWjxOeG2Ag2UU0G6lKGo+AEQtHFfEH14TplQKyAX
 oVKuMLfy+HweDQTp9j74f2h6vVYd0Gh7gO/ZbQRNiS3d6/rOpgF3mNqxg40krCbmw9CQ
 IGGNHGKqynR19DD6kNQEY2oOtmOQbuDx19+VejDw6rsrxcrHMyT2BRZUSJG+JeTBBjvf 7w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42g54n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1UAln002689;
        Wed, 20 Jul 2022 02:18:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbnuv5-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfuKJnBAsdMV9Q9xkUHZPdnqRlVBGXln+YLBot1ckaXJ27SC6q/cvUJefqvlZ5YFe75gz4t4Cx09OjKD0k6xtnJK/IFDZFEjNcHMZnf/rfMqJ0X3VG5rglBAkQZVcpXUMjB+99EmDD1547sWxCEs3r6kZvmOlk0ahut7egrQDD2Wgxiwpfapm+omU7y5yVQRIk3/vcZIzsb+m/zHtPTMc/EvbGkFOST33DiEcBc+LDSzYroBnOkHWcsA4+jfMOc8O6YVkZWDSaKKGdXiw694uWbpmNqh0c7BDLlbc7s4zHPvGK9xwWRDFCzu6rt2gMMIALkKrwKpCMaBGVyvuSY65w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnwojIyjlGOiqaAr6LG/+ckPWfBzL7RuclvHq/lcJDA=;
 b=l8DD6yKGvqkvpOaGkE+sTomHAJCsXzIXSdlTHRM2fMYRDFxx47SFQYc+Zpbq3+B56fvTWQ/k4Pi9kbcDy6HEGjqGpvdkFwh/FPz5XRtByse9je++1dcXpx28JBFc0FAmO1KwkisSEmhKSTRgr2LWPXtQE84I7GejZsZd7dVn25RoBe7NCEiMpgIkrAt9FSs+g4Qlxv7fMrcFdQwA3UXsyYeJSH3YjTJxraqf98mnjgku6HIuU1SL+qef4/gImPcVmcRuBMvIsFpFwKLQENnOKW9cutah065V/slkDt8hjX8+Xlag4KUx/ZE+GfwCqIRm4O33tb+f7azlclsBO7AIkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnwojIyjlGOiqaAr6LG/+ckPWfBzL7RuclvHq/lcJDA=;
 b=YXa0yQGpOJDPimj86CmpjX8rarbZoFErcZOfvZuXIJ3XOmg7IE3M5xvtl0KKZySvWxePbFAqtz+Cc8QrS6R8J46zsm961ffkK/+gi04j0Q3nyZPWBdcWKrKfcHT0Dm0g+WHQi+DFeAQXBfu9yU7As4p9G5MYcD7mGvDAu0BhNJE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Wed, 20 Jul
 2022 02:18:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:34 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 42/69] fs/proc/base: use maple tree iterators in place of
 linked list
Thread-Topic: [PATCH v12 42/69] fs/proc/base: use maple tree iterators in
 place of linked list
Thread-Index: AQHYm97tqx9fIib1ikazlIGozSPUDQ==
Date:   Wed, 20 Jul 2022 02:17:57 +0000
Message-ID: <20220720021727.17018-43-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e09c13d6-0b9d-40bf-e72d-08da69f625de
x-ms-traffictypediagnostic: PH8PR10MB6316:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JU8K1QNaDWcC4xe2BmSAc9tOwz3qmEP3eUjO6F+XGUkG97mqn2wESKm6qJrBdzYDEJqlht7Ti7t5bN203BIXlOIo/v7Wjy+yut+O7bNgsSF9NT2jg7f+HmPCVH9GseuiGb7MCTf01yBgAD5BFnr2AFhX2W9MmN6cOdHEOzOtbg7v1Wclw1XhNVntubgiXjxIm5qzq4ejh7vuF9zJUnmq6mZRt0tVyDXDCMhoxFyaz5zGhGZHRp/VD8KTl6cbsMusfpdMChzI722bRba7fnFGHz5a+5lJR/JO3i04SYa4HBE7+lSIZ8HwKQtg9qFMWip9AFGEQWF7YBOXwyUoEg5bA3eeZkyHTWRL4h1RKy5oln88tiIVoZ8d1qhnzybp+E2t9PW8SbtCrWe1MQ7QatxqoelGoBquvO5DYCVfiS720FwVlew19pc1ysDG5rvYWJWivRG2xRdktE3zHcJ14DiXaqmFt5iMMZr2Lz1nPBscAXk+YfseZj6inRUlE5DME5SHSXH0vMcLAP+R4irKUdgrZZtmFLQNDafIuBVFbSqSUOmpu0jutOscUjtO1p51tTIz4T5TKBV6HBIzYC7i9kvOVVE5AzTSyaMplmnhf4nhayzP912m6p80go2xovcEsT9xPrxBV14A2f8raIIm/4OUWYLh0mniQTK/jDIEquE644MtPdgmPAdoqeWLegdGiROjSlV9Jf5mfJGL1Xt4N9bJR+sab7E9BsTB9gr0duGs7LT5rYyESglDW9s9Xpg7YWlJMGCJ/1icWCENMzCm49AKu2EzkY8rBQvxPu/ymCs0PdNf8ljK2HmNNMCOG9zfY7FjKgeJeTVufQQveS7XcHN9YSdClXNfUEVCnhqCWdO4MGDSnLqVzJhKEgAEFr71LibA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(366004)(376002)(136003)(76116006)(122000001)(44832011)(8936002)(5660300002)(186003)(1076003)(83380400001)(2616005)(4326008)(66446008)(64756008)(36756003)(66946007)(2906002)(8676002)(91956017)(66556008)(316002)(26005)(41300700001)(966005)(66476007)(86362001)(38070700005)(478600001)(6506007)(6486002)(6666004)(71200400001)(110136005)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UxT3T+0oMCvC3LiVBaYx+i++EKObdoyB/XMi3mRpgyAopjJuU1DhwDkwBU?=
 =?iso-8859-1?Q?Y+GHB7FiMcvaB84n1Gp8STDjhP3m2mrKdnw+p4BW1jbq8B3xQs4mlOhb3p?=
 =?iso-8859-1?Q?SyNzdZ4cLQhMqPHs98fG4vnHlF3ryCZzcbgJsHAg9FC+j2QyFhQE7uez4b?=
 =?iso-8859-1?Q?KLwk49wttg3J+7JuhUmaMPOlH0mlcVivAxKHMm3GjI2FjpND52Hu0WYOd6?=
 =?iso-8859-1?Q?OHvXWVcNo7Eb48es5xFmRVObJ6tmSZ+fkPdkEvM3JmhNLr839G5S8Rcxcg?=
 =?iso-8859-1?Q?Nb2JUhjpv79n97ngRbkSEo+1PLHHeLbLNaRHE14UY6chh4lP/jqbPisS6N?=
 =?iso-8859-1?Q?2VLoG1TbPmCDGGUeyA4A0ZmQzinqr5hdz3eVPMpMOsuD9N5PN9xUgO/xHQ?=
 =?iso-8859-1?Q?etMAXVb863l0EwwjYO3D7UFRvK/Hh+lSxL2KBmB7cviLgQ+3drag++fK3S?=
 =?iso-8859-1?Q?ZHjx/ARmnQl49tdqupb06b3F1dtTZxP4o4mytf4T9Br05Nfi63xsgzEc8/?=
 =?iso-8859-1?Q?6kclVDj4o9WYlx5AdaOd4dATVGTqv6KJHg71hprUq2T+E88WCYJKmzFWeI?=
 =?iso-8859-1?Q?fib5G2RyEW97yj0fuO8+rookbvyFBFuSA6BONsn68FdHJtdU5bAaMfN/So?=
 =?iso-8859-1?Q?PNUy6JPsrBo0BICIReXjxN8cg0WCcfJENdUhZD8FfYmfGGmHFK8loVwQD2?=
 =?iso-8859-1?Q?xK6vc961XcNPm7oJdYSGtqvNbhISlfhlU9xE38+bszu5t2KUtzAQSuxqmU?=
 =?iso-8859-1?Q?buglCXaDhTbN/atfNG2+NJ/D+RKlFHD6NUu/M+qQYvWMmJbj1IINg7thY7?=
 =?iso-8859-1?Q?E85ZBjxq7PHtjVk7ECTBUxf1V409uNGujaMvQMQYRanQO764bjpQMyW9xm?=
 =?iso-8859-1?Q?ofqt9YKV6ld9c5dVRycYFTX18Mj154B3rFj2x1L80h9XMAC+TXA+TAbJXW?=
 =?iso-8859-1?Q?FO873S95Y0VnE1q2BqCcF55XwfSiYqW7VzORRe5Aionr4N9m8mJGOHK77b?=
 =?iso-8859-1?Q?UfXIiuR8R9wVJGKZQDwP2w65NqE5NQPqMIf5Wo3westyxhGOhvhQUMchHs?=
 =?iso-8859-1?Q?pe2tUC2F4uGBLbyzLXSHzwlU1o0WvcJE9+XCOYP/JTwqNuhsaHCkTGClpA?=
 =?iso-8859-1?Q?GZVrv70R/0LWPFNhKTX9J2/Db27Hyu2gYPU5Fjnvgs7sM1CbNnMuRwhILZ?=
 =?iso-8859-1?Q?yCXW6pDhgvfijD9o1E121ohjC0pd0JYQZPEqEj1/3VdxPIFAeSZmVMxEnC?=
 =?iso-8859-1?Q?3TmCObhBAf5ROGx1bbKcKl+JI9UvGNMwDGLA8VOR3ax9A58wnxBO4ifZC/?=
 =?iso-8859-1?Q?nQ521XSKDkUbH6vBhsKxalQUc1mcsYowdxxqlL1sestvAarZf7PnF8AXtA?=
 =?iso-8859-1?Q?jH0X0OSbyyarqCMA8y/TrSzcMB4HRqudWAMcOgaJ0FN2nX8xhHRTlPcYbw?=
 =?iso-8859-1?Q?AuDgsmI2i+bqYAbHgg05OFs3gh0BksxP5PFGrv31CAGbEIFp1Qg+5nrVRg?=
 =?iso-8859-1?Q?XQIgT5tJzHZJ8ORIluZnSS9jBwblmWDmq0HEd9npHA9GCJ3twCXCEi8JLK?=
 =?iso-8859-1?Q?nHfvaCXb5GQCAVEpLE1fIm37ShCztNtLBL/rtBwAwSgdMwNR2GZCllTd83?=
 =?iso-8859-1?Q?wVbARAhjTc25tZwmmQmFSLheHpFPiO7cjebAsilyFIE9rmL/Ln4oJitA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e09c13d6-0b9d-40bf-e72d-08da69f625de
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:57.4463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YUvnukFxa8tG51g9BYkRJD9SXd+3jA84328Ljw7B4P05HKfVZTCtxDgsAzthz+hKdFhw42s6g/vEWpLoCHxAgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-ORIG-GUID: LfzYJHDIQp0t7ef9boFwzcwN3n1vHUeY
X-Proofpoint-GUID: LfzYJHDIQp0t7ef9boFwzcwN3n1vHUeY
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

Link: https://lkml.kernel.org/r/20220504011345.662299-27-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-43-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 fs/proc/base.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 8dfa36a99c74..617816168748 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2322,6 +2322,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	GENRADIX(struct map_files_info) fa;
 	struct map_files_info *p;
 	int ret;
+	MA_STATE(mas, NULL, 0, 0);
=20
 	genradix_init(&fa);
=20
@@ -2349,6 +2350,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	}
=20
 	nr_files =3D 0;
+	mas.tree =3D &mm->mm_mt;
=20
 	/*
 	 * We need two passes here:
@@ -2360,7 +2362,8 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	 * routine might require mmap_lock taken in might_fault().
 	 */
=20
-	for (vma =3D mm->mmap, pos =3D 2; vma; vma =3D vma->vm_next) {
+	pos =3D 2;
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!vma->vm_file)
 			continue;
 		if (++pos <=3D ctx->pos)
--=20
2.35.1
