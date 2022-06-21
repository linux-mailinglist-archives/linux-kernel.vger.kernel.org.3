Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B15C553BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354933AbiFUUwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354700AbiFUUs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3742CDE2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:09 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ5FQX011595;
        Tue, 21 Jun 2022 20:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Sz3Vuir2jAk/ZtYXNrO3ItrEp5fkU/zEEqDEPYhJB0M=;
 b=UM9Kvsk+8atTGt6NTfwkXLlkUG5uIr2cZpGclqSZaGRUQSoyLzw8oa/nWHAqJAVoEyE5
 mttNXVe4rYp5nb67fTnuRr2B7MDU+hA9W7dPeruw+gNFz8XcLjPWVQuIgS2+PSQsIID5
 xHbsbhw80OLVgrxdlM9P1Vn2aWn8il6DgEN7SrZ2x06WYaWPghT7qo37EdhkV39XN8Wt
 R5kMpl0kAU9u1MBu3qMQdm9BKf5JhfdXyvRnLGY3M+JOqjE6+p0ErlqcnibIQZErJgT7
 mPPb5fs0acy9AE+pTXGvN8H3RN5MFTg9W6/AhzlVBIDzgirmf9PgI4L/NaELPVPeQEn8 bQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5a0eqa6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeiYL001682;
        Tue, 21 Jun 2022 20:47:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5cutt1-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnJpwx1QC+9mVDAQ4Lts8Vjf8KEHD3FEtP8QeEdQbL3ZsyxiGwVZH3cBRrO6uPzZdnp42Se6NBrUjX8P6NIgBbur2M79+nayK2uAddJSZRtJLbzNucC4qW1iemPTTfJqTKZvDRew4wpZWBKQ0NP/+fHtVwLttIAal4IBQtJd6PFSsgBybqyx9qUQ9qwPD1zf8PkEE6c4E3u96J8WUrB9LW5PvpK3hOIqunnq4EyllQtPj95i2/b68MADUKHugoJj8vhktIa+TZq2I5oIkY67rVrMD0X1Y+8XcKZfwJlZMdOQ5Nn7g9hSn+L0mMmGk8xSIHYRLX74NLmmPlx2dimu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sz3Vuir2jAk/ZtYXNrO3ItrEp5fkU/zEEqDEPYhJB0M=;
 b=bRVfst77wzd0H8+Cew4t/1UmDnvN5NLPPexI1CF7SO4KksghBKK7V/88et+tj0lQpfn2wv+yG+RvH26ee3SDGlkgerOQ/138dbBRVJ8CFF0cf0fmbGYnDurxV7GD2CrUCbf2ZQl2RhmHwph9S9pogPPM1YXEL9W0Cced0HIqurtMEYykf0NyoN5FU2RvMoQ5qETwgoQ2f7YAPGX+LEW6cC88d6JSVfp0an/zfQzq/zp/SejYmH1FvAFIvjKHBzbWZ8mhfVPWlE5e3yFAPBKXGBm3tLsEboV0RsuAcRu4MZuxEfHJIqmshi4lVGVr7uTsHqEt5XsTrQm8zR+n8BvXgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sz3Vuir2jAk/ZtYXNrO3ItrEp5fkU/zEEqDEPYhJB0M=;
 b=KlCh7Ktyezu8Av/A9KoKNZhpjraqLhdEMWCclYPQHZF8ou3YZ2P5siAMB7vEh/fwUyawzs1rxeNgC8QPge4scvblnHuvhKuRLAIs864wqMTcDNy68am5EJE4sifuYAx520MkcBG1m1pkG++gJwzjTeJsEPgqFkWN0NrQVb8BIvQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5392.namprd10.prod.outlook.com (2603:10b6:5:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 20:47:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:52 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 49/69] fork: use VMA iterator
Thread-Topic: [PATCH v10 49/69] fork: use VMA iterator
Thread-Index: AQHYhbATOefcF1kaekSasSOaZFoAjw==
Date:   Tue, 21 Jun 2022 20:47:08 +0000
Message-ID: <20220621204632.3370049-50-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 650d4f94-fa10-43dc-f636-08da53c74f7d
x-ms-traffictypediagnostic: DS7PR10MB5392:EE_
x-microsoft-antispam-prvs: <DS7PR10MB5392AAA059AB50A229998879FDB39@DS7PR10MB5392.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gn1toqPpGzmTtwkHYq89Wx0sR+HyIo/E8VGg9zLSXAlNE9Swvu9nS/7yM9Z/51olBrtX1E7HujM+ov4tq992nRQzkaawD9b+NWclMVIB1p616zYXnOQbuse1+0QVa3Uq1cM88BOdW7kpQVm7Bna91xaMfmzA03dMBtVNKJ/EzDS5ESDIem+a6YxSWuvipvZlq8q/0WJqtns2wFrZJRCqPPZTX/ln5WDzvWSAoU0ijKI6sfemUmvLFOtBTFrNP2oL2FOSjHj2G6AQPo+X1uEotoYsS3wLGcSSZLJ6gVJdqitZ29loqkAffXZzpRhTgApsndJwpwzKqcyV2ewlrvqAVobr5TExpsh2hvoSpSedsbAUxG2Nfg8uiWVHACiXKGq3a39m04FUurqlnqKKH/R/t5yAzDcpvimfeMgmiwMqsA1CxK7doHsSMRj15veZ9qH1fWd6cubA2vQ6F6u+e0qaq3AypP9dsVNoE23fSlFJ57vIVaPATXRaxRypqSO1jgpbirg5j4bj/vxM0nTBAU9mkRFK8Lv7pTmSx+iJDMi65bA+NJycJVjSd1867eRpCw5YGiv8Wk4W6Bf+BLBbj0CTYmD0m6lX+2kufkpKCVcVcx8+nN15i59U7UxMQ1BYqdZxLTqm00M5k1xw5/QgK1K1Su7GMBlJHJYS2kCJpB+DIUhmSkyvkVqYGzCJAru/NotAw7IWOswS1DAZMUpZm0OLOJPjOunrtTtRz5FeZzEx+/r8no6zhzWoT1RZAYs383bZgEngcmotbAonkMxuJOvsrgRSAT0hjgUIni2N2p49wDA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(41300700001)(6486002)(38070700005)(2616005)(186003)(86362001)(26005)(6512007)(38100700002)(122000001)(36756003)(1076003)(83380400001)(316002)(66446008)(66946007)(2906002)(64756008)(44832011)(6666004)(6506007)(8936002)(66556008)(76116006)(66476007)(966005)(478600001)(8676002)(91956017)(71200400001)(110136005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kYjCSqfYC4FhrBMavY8Hla2aiba1B7HnGMwUKlSo2XH9EZXmAqxQOHhIas?=
 =?iso-8859-1?Q?XakPs7JCMBiSkqltlsIfavzPBGqb3ebrnJpAOOrBvdHsEaZW66OGH+at1a?=
 =?iso-8859-1?Q?i9WOe5JWOaWM5z9QOx8J4jlJUQiho1+3DzJ/hXBJpC5LMjk/QF7ub+Mtay?=
 =?iso-8859-1?Q?EDCLw2xnPXJB9ItWo+43Fh2YzKgq9Q6PAj4gVln7vCD+Xwepx1ybXn64zn?=
 =?iso-8859-1?Q?vCINur4pyLo5WY4QTx1nBe1ufy3hQZp7DFFDCe9UX3KAzFU5lXau2HKIPC?=
 =?iso-8859-1?Q?OkIEc/Dm2X+4p70iktYOJyJQBPO8FwP5Z5gdG8kFElxcWsiXRhQoIzwcnS?=
 =?iso-8859-1?Q?TqNvOBScdSOx5oPUMjjLE5p4IyX9lVwfQLWvvcBkG3NX51embgnqnLhrkZ?=
 =?iso-8859-1?Q?Wughd8h48fzXxpv+zYK3Y+7CrHNehoMXxheBDt2DeMZ2G9t2GFBORGNjB3?=
 =?iso-8859-1?Q?bOyJi+w3MfCt6L/nqDL+FKp9Dg38j36pHyanNvYzKekDrC73G7x/F5kppm?=
 =?iso-8859-1?Q?NpTlFsYInRINoV/f+k3hHwa57zGOJpjmlngJfmmbvebszf3SY1mtq6KNxe?=
 =?iso-8859-1?Q?REyoqZNve1RSXNnJ7CuzVjcEMUOtmRc0GyAHstd/OhtNJsJ9JQMTuL9PXV?=
 =?iso-8859-1?Q?Z2JDFZZunDK6ZLtnn7FV/P+DyHVCebCpSXOKKBOSnexmOphukSq+RBpwvb?=
 =?iso-8859-1?Q?I9Hhq/UwhocEG7C1MFSqYdi1yRDTHQ3cu1jz2HQCGFGXxzCql19w4PnKnl?=
 =?iso-8859-1?Q?J2kw5T9U9Plqjg2CgrnFpnCDhwTdvPjAK+bsr8dTuIqYcaVjw/ESS1zQMo?=
 =?iso-8859-1?Q?FXmq4aRlDqYRFjeUtqHP83fJsReaINIlbdz80MwGkNTqcL1tNvPGugZpC4?=
 =?iso-8859-1?Q?IDsyPbYtrjTkPqwLOwa3LuCrYETCV4tAg4qoznlMZZLOJVHQgYoC23bOzG?=
 =?iso-8859-1?Q?772lq1qTXLmpOeADGYdFxrz0TX4UgFoY1HH+eOBoQpAWg1NBkZWnZ/vMMO?=
 =?iso-8859-1?Q?/RvkQIfcXfqjvmYfrTBQjjiD6CssyqbZTfYjz+ODNQ5P6OHxcBezXFK1Gy?=
 =?iso-8859-1?Q?qc7oGC88+FVsW/yt+UGw8PjJLvGGdQYjCVPg6/z27TT3SO+D4zxQvOXcFE?=
 =?iso-8859-1?Q?tGQYl2L8jmGpgzD0n+wv56emZ6Ccwkft+DcKtsofe19Ccg09ef85IBu2VF?=
 =?iso-8859-1?Q?ICokLmtCrs2ipnvLNSETfvoO7M0UIezYaPrt6he0ZUgS3lMuGiH61Gz91f?=
 =?iso-8859-1?Q?/HZaW+TmEeDL4DbOqL8iuFpTF8pPVWksB3gSUqA0CKEyyLnfjqgWPicrQY?=
 =?iso-8859-1?Q?24dKUUg0xyobX5s3dKxioWOAqzfCnURSiZV6gw/YZAla4yWgS56UTRlwmG?=
 =?iso-8859-1?Q?zm+hIJYQJbSTfZImYeTBSVHzV6lW0aGq2cDZO9OHsxt3ocw51YWtPJ0FYF?=
 =?iso-8859-1?Q?mH3YE+maMhuaJ3CXS0yobW08DlvKnsFTjd7Ufnz6xvtGrWDm12i/WHt4sn?=
 =?iso-8859-1?Q?PRrdv2xtNxrG6+N/uC0NHurO0yrlvT2+m1RjRQV7AGBquRvjvOPa+Ds2zF?=
 =?iso-8859-1?Q?Cjl5JiIo4li9sM7W8WqQz1ZEdA4WQEqZB9Ee7sVo5Ltu5MGj9qpfpSRhi3?=
 =?iso-8859-1?Q?ZZLvxPLkbY84cOaJpypPOzuTHAdVBhpd7PyP5hH8Q/Qhxf9CI0cDRyt76G?=
 =?iso-8859-1?Q?ZKycra0MdJjZ+7QSVllwGYULM2iRCICf7RcS09dCY3H26zSioDKnnYCevl?=
 =?iso-8859-1?Q?shUDotgB6TijEDd92S95wy3S2NJumDz61dV1a6cWs/NppBrSFlCzSBcN28?=
 =?iso-8859-1?Q?WC6YhQZiC1l8/ZQ5fIGjbmRqYWka+6w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650d4f94-fa10-43dc-f636-08da53c74f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:09.0034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VieHLCpPRJuzG5p2QAEXgmrNgEUpSah8iRvxH72sMrVbq3FUaBMMdnZQ7BOWtv7LqkewAo03vH9coRSO1qUB/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5392
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: GQtKQ-_DG7KKYF7e_M-coP8krLXI21gh
X-Proofpoint-GUID: GQtKQ-_DG7KKYF7e_M-coP8krLXI21gh
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

The VMA iterator is faster than the linked list and removing the linked
list will shrink the vm_area_struct.

Link: https://lkml.kernel.org/r/20220504011345.662299-34-Liam.Howlett@oracl=
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
 kernel/fork.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index a653b259c321..7fcefef4c84d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1294,13 +1294,16 @@ int replace_mm_exe_file(struct mm_struct *mm, struc=
t file *new_exe_file)
 	/* Forbid mm->exe_file change if old file still mapped. */
 	old_exe_file =3D get_mm_exe_file(mm);
 	if (old_exe_file) {
+		VMA_ITERATOR(vmi, mm, 0);
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma && !ret; vma =3D vma->vm_next) {
+		for_each_vma(vmi, vma) {
 			if (!vma->vm_file)
 				continue;
 			if (path_equal(&vma->vm_file->f_path,
-				       &old_exe_file->f_path))
+				       &old_exe_file->f_path)) {
 				ret =3D -EBUSY;
+				break;
+			}
 		}
 		mmap_read_unlock(mm);
 		fput(old_exe_file);
--=20
2.35.1
