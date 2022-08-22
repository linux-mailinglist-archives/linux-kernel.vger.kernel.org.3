Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9413E59C26C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbiHVPNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236529AbiHVPLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:11:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87A463B8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:08:18 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEirdd017906;
        Mon, 22 Aug 2022 15:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=yaUVIE13JYT44Xhcs+e2pViQLrRAEe0x173o7thAU/4=;
 b=J5EvqTKDjWmvYGEKjI/xMzCYT/imO6QHPD5zmGEZcnOfJp+256/FFSw9jcQF1gIzmO6a
 k1bAJ39dJyCLuu9ZcbORhg0dnfKEd/TJ76WEBUEanyMA0EHGNQI3/RWxFRK8YAhEBZ3E
 JmTz7JuXxpCmV1/M4qjQ5t3JpZtdTifHWrHNVSqO2sEkKuiS93pcBqsu2fhAQHsEnGxw
 t5FGRSVxJMqNhsbtFwVCtVIW4GXz8JZwZIr0PqrkrxjW2jOsHV152Dbv9uSl8Zkvjc4q
 To+16fLmtUlPApWijhRSSEphQIvCgWuCtmof10dS7gvZaEZD16OBqCmaL4vqBQ+bSKC1 CQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bkt049t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Na5026712;
        Mon, 22 Aug 2022 15:06:32 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mm8bef2-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TN3j7PR4PDya3+aQkjzwuhd29EtKRnFsJqcjZsyzjJNeFw5qaNKzojZofk6VlGuGu6GogCIqmJOp0t23YkpCLuBsrPMmUBXwIFhQJx4K7yqMjnCAxhietkmzF7eQpK5sXcKunuL3YU6ZXKzZfhW+s/DIAdHdLMIABF/h0WfacmDxCssW5n3M3eKqUGZ5bmCrN5DQHHN8qloKIvHMXLOT9CbMaKLgIbdPJO4lFjdbxKcrL+KOZ+bS0HwEX//yi2DDFDqyjGI3Ipytzyg/ZM2EvG8hwWG05/lnB3oVG52Zo0wqWAmErdftkZM7SXsYnLOJPMlk7n/lpqbsv6Ep/wnpKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaUVIE13JYT44Xhcs+e2pViQLrRAEe0x173o7thAU/4=;
 b=KkWD1OEhA2zEBwNDInfAE0amE8OPxMzUYJkehqtaB7AsyCdy49iKmU847+tRBPJoiOfUQulPZvE//xPb10fg0fZ6H0nzB1HBZt7vPQLYQaXxVbpCiF9GOrjO8LTuHy/2m3kKFVOu4M0K4sDqnUu5ZnMv10SkSZ/7eJ8V8Y84hWBtCuAjCQLcz6eVzQQDviH1Nj9I2gyF5uKyu09kYajdbIEGORfEwiRZ2ZScSCTTDwFI4DcpH6BfbxQhXT6DxqokR+y725TrSNEp7uVPszC+pyg75dNepWVlG+MwC6i1Rrbpd4FvGEv8iE4KBZCpGPja9SYkAYLjM9i6THkzR6FqSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaUVIE13JYT44Xhcs+e2pViQLrRAEe0x173o7thAU/4=;
 b=gOxi1iSgv2+K04Y27XKx10Fc3tc/vhoriZ7SJoQwnuaEVCWQKH2WTu40A+x+vXSGplmVCHXgkAynOMPYo97NJ+7J3CXL5M9HYrmjNm4vRoUyA4Gr4lHet255iX54lyErt+HoiQI59F8H6/5NWrK1otGNt1S+aLYG0xYfHS7uVdc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ1PR10MB5931.namprd10.prod.outlook.com (2603:10b6:a03:48a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Mon, 22 Aug
 2022 15:06:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 42/70] fs/proc/base: use maple tree iterators in place of
 linked list
Thread-Topic: [PATCH v13 42/70] fs/proc/base: use maple tree iterators in
 place of linked list
Thread-Index: AQHYtji/MaQfHUxa4Ea/rqE8CDo+LA==
Date:   Mon, 22 Aug 2022 15:06:25 +0000
Message-ID: <20220822150128.1562046-43-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb74edaa-331d-4855-f600-08da844fe2c6
x-ms-traffictypediagnostic: SJ1PR10MB5931:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s3Ei1kskKGSx73+UBVMoYWetD2lKX0oZBgjcBkuk0ruIl4Q3m8e/mHoZFYRVinfDccelSiot1Jw9kwELqHncSbUg81uKh/FMhHcJ4UEjS8ESTf2M8WWGs91NlMTrKiqOEDuBgMc0DV9mDEq58WIK+5GA/mW9JjXx63X3j+oe2p2F3ARIHygKr4bPDmol7gezIsGtwNOOwtoKtLtgYwlUw/fb20MoksnZGuI/IDBsL6xBRb500wmnsrSNR1zDX5lkuToth+qCa3kb/SsxIvqaaZGKCuU1lFZSlVWmcphmQ5WFqjUx8ibkdhbEw93oGWWbGoXfQgdE53+Mbj3VVcu9xGDTX9/l7SdkIdW+sTwkcR+Wsf0eMBU2qybBBQmGPDwkeMVyTlLsEFDNRRi96cw4gAeLI2ur5D9QcmK0MzL3G4wxLYdf3GHvbwYWe/1b1jjO67B7pyCJOYUX4qw9yiOoOtHJAVpICY1PlM5/rxr4yRHtYhPR56MPCfjZhcroPC7Q5YxjcltHoQb48gQE+YZhzQ79BGncIQGOOxtk6c44//ewh4Lv3Z6zxwYTCzxdstBJ48GjsPQEPuGQ6j2XL8Jfa2OnpbER+HGR1kKSXqmWqlnZfwo80hhsmb1KbfcBSqQ9fMiKpT1Zi4t3pMGI07pMTUPeolEuK0l8G1OsdDF39LZtBpY99bNlXA1JPXOwMHSxMjPDanT+yjnfgJDNv0VDwQkMAeaYFw2nIEsieMnWA5L5QOQpsi594FLBjdLOxZi9JLXutdFXkX2kZWhtlTvavg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(39860400002)(136003)(346002)(110136005)(83380400001)(6506007)(6512007)(36756003)(6486002)(26005)(5660300002)(478600001)(41300700001)(107886003)(1076003)(186003)(66946007)(66556008)(66446008)(4744005)(44832011)(4326008)(64756008)(86362001)(2906002)(8676002)(71200400001)(66476007)(38070700005)(2616005)(76116006)(122000001)(316002)(8936002)(91956017)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BEydqXUESKHVAh8X5rp4gWmccLwHZc9Ns64NGHl262Df7YPSEiUJw+EeCu?=
 =?iso-8859-1?Q?iB0puM4yDfCAtnrZMWNJc5hxaCKSdIfSd+KPzdPA3489ynX34R1WbF/tpC?=
 =?iso-8859-1?Q?eTiIPAQYsmSu4l6dXqVsTgE5WEVfP9nWhp1BP+Quwy3PwjSVmYfRaAlXWj?=
 =?iso-8859-1?Q?V8ZtOwa/9LkNTEasZA7PZCLOTtPn7x69fcnXXAYkQuUezNf4iUOPnLkiws?=
 =?iso-8859-1?Q?6MuXu7bAQhZHCQSFPcCjX/EFegsNLAi4wWnh4DJHymgWleWwMbKVuLDhl6?=
 =?iso-8859-1?Q?elqtaJAOs7H+u7l43q9TH+JVEK6Nn/8jrV17dWmMQBkM7NDzFlZaXapZPI?=
 =?iso-8859-1?Q?psvRgegwlz/yXlipDSlSkJemgyVXj6URo4MK8A2Rtsqw3/oqHUFTyX9L7O?=
 =?iso-8859-1?Q?2f5Lek2shrbm3bH8NKaLeltYw3ODPrA/zz5MpERfwx0MbU1YA2NI6RZTYZ?=
 =?iso-8859-1?Q?CxXEZvgzmmLyKZOVQRlDyPjvj8X6Opzmln0qVCXFjjY4r+aNsPIF3X44nj?=
 =?iso-8859-1?Q?SuMisx/UbrdwLAsAlvZlP2OHaco/P4KBPTZkO4sPC9lPzcg8I7wPntv5/S?=
 =?iso-8859-1?Q?ITz9BEXfTljRiBoGbn6CFiXyEEbIN+RI96dEi1RH8R+OZlvn1D6Qi2s9rV?=
 =?iso-8859-1?Q?lPPU0B31S59rhDuhTc4KYaLxOdzvsG92wFftfHg01B4e1v6ExYocrpyB+g?=
 =?iso-8859-1?Q?IAkHOY8YrN4KDmUslio9ELtiIKD/tTx3CGcGpUSQPDc8o/RCFXBuy4cNEr?=
 =?iso-8859-1?Q?AyXC8uYbtll2gudcRJZWBuFzuVmiq9PirDnG3/OHNRD3eiB8zBm381W9H7?=
 =?iso-8859-1?Q?dOCVTDhO0qk0LTTuLL+eIpPg5Zz1AG4RtP/9N1xqZ4KOECi4RLCcdsuj8Y?=
 =?iso-8859-1?Q?ZwQKHqinXiVWjHhKP3VtBOaTJcWj84v+Ob3/BbDbPtWZ1xGZpQ0socJloX?=
 =?iso-8859-1?Q?3+LLx1TeO1Tarmdfb9aMiLw1EOGVux8ZN6T3EoroqZLVk8kueVbJQD1anx?=
 =?iso-8859-1?Q?3TACwmEZdhm6UfEnfq7U0hnM24Dp9SxAeHcJhXvan7bhMrE+bCmnqTT6/O?=
 =?iso-8859-1?Q?I5Y4QjGpdYhrTjMtYeaL8FxhPGmPyBzHjnw5NvPZ0kLNOoDpQ31IRY98fC?=
 =?iso-8859-1?Q?2Ord8vqmV7gLmgcmOK6XrO628U/JbyxjZAQXJpxys/1e4jggom/0IKlBk6?=
 =?iso-8859-1?Q?emT/rCzQUYfP7Dtgq5oLjG6Jsc1uIRuisZiA5Fn95F9H4qj3BGZtASgGjf?=
 =?iso-8859-1?Q?/zRwj7PpDSL8MhwLv0IyVnZ/Rvyafi08EV9toG5+Yd8ReaRsN/j7md0FpE?=
 =?iso-8859-1?Q?Jb8fXFp9zTofwzc3fem3123AHZVAE1nMZd3JddMfiL2Fbaq14krcfdKb0I?=
 =?iso-8859-1?Q?ao3OVRCAJMTe9KY9p3ui5byWlz5qDaWYgR/N401QmBWlseCAlDeN1aj1dT?=
 =?iso-8859-1?Q?TMPM3bJ7BWvFlrB8hjyA+v2hP7WIOR7d8OKzzVjtiiVHG4/hYESAfnD6YN?=
 =?iso-8859-1?Q?OFIya6Cw70Lte3rS9YiyCVQQ+O+dLzV6WXBhQi/2nVs1JZ9KH5aX256rzC?=
 =?iso-8859-1?Q?ht3MuPPZMlnusmO+5euBqbBTZ5RiZKkbHbB9ZUY0ilzO2Jq1JS2MZNTVoy?=
 =?iso-8859-1?Q?PiuDBCOT03udMlaV80kEQ8GknTUBlepbco6JLlOpwEs1SOhJw63upL0w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb74edaa-331d-4855-f600-08da844fe2c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:25.7538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lry7OWwNtRT/jtGLvVT0Z4LFIfPBEzOLWOrE/aDeZzPLodxXiX575wpppIiOM+t+IHmqmGPG3UqPaqjTJd6b9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5931
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: jViO2sJzd7GgClUUS6DVtJY781MTrS0q
X-Proofpoint-GUID: jViO2sJzd7GgClUUS6DVtJY781MTrS0q
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

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/proc/base.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 93f7e3d971e4..0b72a6d8aac3 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2350,6 +2350,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	GENRADIX(struct map_files_info) fa;
 	struct map_files_info *p;
 	int ret;
+	MA_STATE(mas, NULL, 0, 0);
=20
 	genradix_init(&fa);
=20
@@ -2377,6 +2378,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	}
=20
 	nr_files =3D 0;
+	mas.tree =3D &mm->mm_mt;
=20
 	/*
 	 * We need two passes here:
@@ -2388,7 +2390,8 @@ proc_map_files_readdir(struct file *file, struct dir_=
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
