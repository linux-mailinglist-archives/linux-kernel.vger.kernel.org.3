Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0E65235EF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244948AbiEKOng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244936AbiEKOnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:43:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02D5A6E29
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:43:30 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BCEoKW010355;
        Wed, 11 May 2022 14:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=E51IFbAZ1SmfR0sD1lqh6P5av78kR7atr5Q+ksEJKyc=;
 b=XMj7kjMMRbKWBBwmitl1ejpRjxyCk18JW/NRhHaNw6zA5s2CD8Gzhf+osg9fp9TwoTyh
 s9qht4fE4jZsoRmVfrsOt+vvEUmh9Hdf5sXq0yTe2EYkcFtn95iMvt91fURrmuQo/ONj
 SDR7Gx8uAdTi1oB3Eba3PoMFhih7OEzKnDGLAGYlcfxPqNEcBcheA7Gnk0qTO1yFskYv
 pEqLv+7WrWMsn0t/GBGdLYPJmG7yd5Bidi6TDr3f21Anbm63oVqfi3gcoeckLU/itT9j
 yahCm521db1AdOhHPXknJHbqF1ilqeY8kP58J0pN35I09kN8/WqGDQvuKSRhv1RmXSVr aA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwf6c9ske-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 14:43:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BEg3c3019674;
        Wed, 11 May 2022 14:43:16 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf7appr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 14:43:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enDA/xeXbeRATFk01Okf1oBKHF38m9ZwgcVHWiYBADCUYh8TCR481xseDlH68H6ta/ke7YuToBlIvOTq2W7Vd6abu4ru1lEWf/VaDYHQnXZMde70qk16lH54Vn5jWWIoV2wFKUBu4nALMFiRzaYicvx74uQzXRsuhfGMXbZW4qJqmXv2EvlCjrjAF3OPsuX17KVsIrBLW6DUNwzi7kdW0vziXFYdNiatfLtzEMdgLDTF3EfBEAIE7tqumnQ8owrmLoCNm1MxuXnippWKgLueFw2wu9HRK7VGsr0uaqGmJGttx4sFv2X5xbr9yg6L7pcsIx85S8CmPE4VFbM6O6i2pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E51IFbAZ1SmfR0sD1lqh6P5av78kR7atr5Q+ksEJKyc=;
 b=KRxqJCc8ulVaZ4Y3hZ1k7uWw6w5jpP2PevCL9U52+ozCFuKjty6GgRO79a5WxlsJvJth3E5R7ttFEsDQEnEQlW6V+UhqAgyrgC3xDI9PNrhUD3i+/4yRXDDlkSf1NU0GpO+TfzJuc9ITZySr2TnNsX18b0vTXCpuzTZRSJefOOiV0IwiuA1vI0iEUth7mmWl7i/EYUDNaqOZANJsD9mXFgWH61+q3Ky+Po2iSh9yG0PUXPDR0iKCvA0bDKh/mp2aphxAg47i1A8bWl3BX3Y90J5pGf3rE8IzkDf+MaGkZJ0XH7Lzb+RM3oQsnDuRGB4AbB3SbnI0aF48O0nDLOOlVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E51IFbAZ1SmfR0sD1lqh6P5av78kR7atr5Q+ksEJKyc=;
 b=u8Z4mUQKoR+D4U3j0b10tGB+UEZOyAvjFr4W15g0qwUZUo5iCDJgMxnOCE+3JGROTcA+nnoPHSSe4qpsSNRVgRFq2fXjVudcCv6VB/RHeqc2VekZuZ2LalEafdfZV36rWixap/LnlrI8f8tnJ144cfQBDlnJp32rjjOihwoKnY4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BYAPR10MB3351.namprd10.prod.outlook.com (2603:10b6:a03:14d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 14:43:14 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 14:43:14 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH Fix 0/2] Null expansion bug
Thread-Topic: [PATCH Fix 0/2] Null expansion bug
Thread-Index: AQHYZUVx5XdsmZaTnESLj36mCYC/Sw==
Date:   Wed, 11 May 2022 14:43:14 +0000
Message-ID: <20220511144304.1430851-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aada42c3-e583-4bcf-635f-08da335c9417
x-ms-traffictypediagnostic: BYAPR10MB3351:EE_
x-microsoft-antispam-prvs: <BYAPR10MB335196C96B6E05D7FC0B6CE4FDC89@BYAPR10MB3351.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: npXuvJce209J2+2c7hszbsHgHwxM7JLQLHj6u1Hyj6ptqylWU/cK77X+yHtiz9k/8DX43NFdNt+V6w9VhYKcw6rcqU3NpMGYLD2eLz+NoP8fVhgL5LVVpjk5NWdfX0tlTRSS9wDGjNEe3JSR5PRV7/P+bRnU4O1GhSinsrWbur2HXU8ptoTAVSAH/Vp/uk29XNm7MXEo0a2TfIwMKmnSfeUBl+sF/j95XLZAsLaf/MIiEhHWa/jmtt0HclMPeCGklbT5x+N173swsfrW97H0ED5oUywm+Cqzg43/8v55nv6yYG7DRsQBFcTUzhEzO19qcRJ8erVmwWcXUtUxf9xoO0Uh1U8q4vKiDWJII9Qm//UsuudaCA98yRokDsOl2Ns/tGCM+gX6oi49cvc1K9XCMMNp+wto2rtbWbLterL89i9B+yXxyc6egOG5AuckjQ8/AJamIRmB78+IHeyCj3F9YX5uWojOWwHBIbUuSEz0pA1ju0DcVbCKLtg6eblXU7cg8QrIEPXs6orL2OKef86yCO4k5btiFPKVv8QDzjDi0xpYGoRnq2MuJi1V/jjXJ1aitSkx7gBFh+nQgFs8mwXBjHIhQt0U7L8Tkjj9awCJAHv5XPpEA+P9m9nSJhRue19WeVQzx+pIM3CElUz+OcN8f8fLCbj2GryJbJ8ZxBMSGjC0jIVzzzwyTo3b5WW34yYbNGuWFGHx7lT5QfpM/B1F2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(1076003)(26005)(122000001)(6506007)(6512007)(38100700002)(4744005)(86362001)(316002)(186003)(44832011)(5660300002)(38070700005)(6486002)(8936002)(71200400001)(91956017)(36756003)(76116006)(66476007)(66446008)(66556008)(64756008)(2906002)(66946007)(83380400001)(110136005)(508600001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DJVcQzoYaZG0CafxFmxQZXVZxqpi61lYbBUlSjXOYC8ZyPBuHv+aOtBI5q?=
 =?iso-8859-1?Q?5ZqUekkWFbOKm+qqVfZhzoK/GIzymceAASf2vhsfJ1TKNradBVtwY0hrXJ?=
 =?iso-8859-1?Q?aj0ewCnL/weAttOlQYF3t6MnoMqFGbHpLpG4iBBmTqH/D6K1HOg0PLg9BW?=
 =?iso-8859-1?Q?XfFDycuW5dHtgzQDY6RMOgVISrrPWmNQsOn1ixw0bx7r3qlSLMT7SFYBGm?=
 =?iso-8859-1?Q?e2i3TLt8UnWjgihlKFOF7vdBiLSWLYM7Z6+KC81wMHNg5CqudySY7nkXE2?=
 =?iso-8859-1?Q?iyY5I4yA3XCGr4WrYJqat/2HZssc9mL28WWTC9FPCrzQoNXx3q+DC9ZsI9?=
 =?iso-8859-1?Q?nt08hwnUGWhsZR1lp5p93AdT0WhdbsVkwVC1FhFUmbxduX+PCRVnlU9/VZ?=
 =?iso-8859-1?Q?PLpKC/2Z0MrVEkxp9gnEGB1RuFeItnj2kH8nljdmpMLe+ts6kr/4IJVlxr?=
 =?iso-8859-1?Q?BS3r13ELpAatqO18MfldHF7mTOwim6QdXZkghOqygWepjijoYoB35E09YS?=
 =?iso-8859-1?Q?RjNKXvKMIC/7P7gop5wYwBM/A19rPuIuNr9W3xxowiLAlEC5ICV7p/E8FQ?=
 =?iso-8859-1?Q?pxlGw7lv1wwkaRm5SCiHRf1Rh2PcREOsMFDaa6+q0vXDb5UFKi5a8eA5rm?=
 =?iso-8859-1?Q?DLehgyzIvlhTS2P0cnlisCO1gWhuLbrH/ZKqEu4yphVsXtsKnT05Bt4Ykk?=
 =?iso-8859-1?Q?zqhzWQwQD9qv/3TB9Uj/WqVsumtsoZBKIzpjcAbzcMMLOayt3ROi2+7D4b?=
 =?iso-8859-1?Q?7S60fT4C8NSI7zQL4pBIWesMcZ9q/6ADSYjrf9kpLhaxcF+9fjwsxEGvDs?=
 =?iso-8859-1?Q?z42pWREvH8lXpzg02kJaHsPbvlZKET9K63vBrNG1Vu+2zFmVg3CFOCuElb?=
 =?iso-8859-1?Q?Z4OyMKULaDVgLfSzvAPfAGsG/hUubEKSSitbCDi1GAiW3XwhR7wTNXzl8A?=
 =?iso-8859-1?Q?cWroKnr0hT1tGWIqhJNdP91PWKCwl4yLeabrWrBVnvoJoZRoSkQAwQ2pB9?=
 =?iso-8859-1?Q?z0zU35I4ZH7HJwc0X78OSNpb1YGEuR6c2Y/jaDvXIpLia1Nxc+Uatw3aYw?=
 =?iso-8859-1?Q?Pbp4YDBbLg/Q62lTpMnupoHOCowZm/hKJiN7w6On2QCPrJATqEWy97kcTh?=
 =?iso-8859-1?Q?b+SilWOj1adk0NDs3b0uQr1ex9WBPaKVHy85x2cAftKAmD05hzWB1jRaMD?=
 =?iso-8859-1?Q?kfSWL+34iIfDVb4zwo4kVPKvEcL2XDvgPj/gxlcCEzUqEURCVZMTHS6e3G?=
 =?iso-8859-1?Q?QLH+3hgSJMntLuThlQgKD+qr0jFAJAsEoKV0dcE2ER9BXBk6VSa5+FHxkd?=
 =?iso-8859-1?Q?TlG4cTqKN9xGPWL7vlfkkGk6iIHy3NMygUs9i0HpwNFhxXDOPY/T8UQFQ6?=
 =?iso-8859-1?Q?D5Y2Sg/4A7YRIPmmrM9//LfQgNvwvH+lfU4FQPQzv9Lczywf4OOT3s679q?=
 =?iso-8859-1?Q?aQiKHCrkVBS7N3TyXUJIbFnOOZaDa2NZ3WPYk1RgK0lTPainCoxHHBAHHX?=
 =?iso-8859-1?Q?Fd02IDkM6jiv2M+huCZXJHFt/Kc9CkY6x+uI9V3P6DzUD1PSPgJvUvqjpx?=
 =?iso-8859-1?Q?KYmB26RGXFLWT3AAjI4jluW4kUIcg9ATUJaZWbE/n4GRiEM9/w99wQ7cqy?=
 =?iso-8859-1?Q?ETJ31MilTkMnyey3BGpGiGUaItVi06ATHW09OoBjmFKkMr8ZQgo0Ir/79O?=
 =?iso-8859-1?Q?0CJXEEXxpcEnz9Ay+zQWImZEik0ktIvQA2Mbc8GHabt9ZVl4CNso0TMhUr?=
 =?iso-8859-1?Q?VkuqegKgZl8XQY1xsX8ke5Jq5vtaL+UiJ4CGUDHxNrIBa6dt52ar6lIKBq?=
 =?iso-8859-1?Q?ppyjATQT+8LtAVRUirNFMBQ4TZrM/cs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aada42c3-e583-4bcf-635f-08da335c9417
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 14:43:14.0758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1eutz9jwGOXRDtt8Fmhz9y7QUUlLpzZcpWuCK27VT0pGW6ACV1BZx8BAg7q72l32DmEX+cie4+zq+2VWHQacxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3351
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_07:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=914
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110069
X-Proofpoint-ORIG-GUID: alakC-29UETj7i8he0TprTXj1xarAWGW
X-Proofpoint-GUID: alakC-29UETj7i8he0TprTXj1xarAWGW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Please apply these two fixes to v9 of the maple tree.

The first should be applied to [01/69] "Maple Tree: add new data
structure" to fix the bug.

The second should be applied to [07/69] "lib/test_maple_tree: add
testing for maple tree" to test for the bug in the future.

Thanks,
Liam

*** BLURB HERE ***

Liam R. Howlett (2):
  maple_tree: Fix expanding null off the end of the data.
  test_maple_tree: Add null expansion tests

 lib/maple_tree.c      |  8 ++-----
 lib/test_maple_tree.c | 55 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 6 deletions(-)

--=20
2.35.1
