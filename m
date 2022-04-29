Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A476515551
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380284AbiD2UUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380275AbiD2UUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:20:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A5A9BAF4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:16:39 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TK1PgP025808;
        Fri, 29 Apr 2022 20:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4fY/HUtHwh82BReRCddo8utM3+0mi1ZW+hyOulDCRDc=;
 b=sylpo1dP3r7W+jhQ8RCuGdAa7AIqhJXaOQ3nhejvwZYbTvqWklSKl6iRHaILjVKVwjth
 uvQhNru7DkXrOT4YioROWTJcrz5P8fctPsnfEaU/IWljCdni7YcrrY01qna0H8cNKY1O
 L5N7t7/653P2ybo5VI6Fbk1pI9bSNzle6sY00+SCQ23MRxHDk/m/Iuda6hewPI/U0WtT
 hspfJCSLvfyYaIlzxwNzdI+MlpFoun7ED/eUS7A+VVsME+U7FkOa4Ed9blKLtEDFF9WQ
 J7GJlmi36blEvNcY5wRy+++WeEwEp1xD2DDksIz+PUCEMjY212UobXJAdF7iSYSXgxQa aA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1myuk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 20:16:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23TKB3mG003873;
        Fri, 29 Apr 2022 20:16:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yqk3ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 20:16:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzTTl6F7xaivUTWSftp+NhgGuvYz0PQSBvg0clMNrc9Mh719ea7gTFCZ1rczgO/avLpg06MdbDvooaPRFP9GET1ycpsCNBsheTGg5xrrDjwhqQisuUOdUBTcjDDRsjvV3kS845OJ6vd4NU49rwtTe+DsnryH4pvgTVbad7b922hcVEuksrTEUc2B+1R5i/uBOmY3n7lO7zTAkxxrk7kMjnR94QUw7ZcjLYjM01PvINJDjM+XTxQFyHQODj/7mwI9blop6tKAZ/wLBFoKE1eMic7S8UkfPHu0vpcnL297jw3fTcb3mSlxM+7tfXc0rkAyU5I8rnTeVlQ27kTVR7JEJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fY/HUtHwh82BReRCddo8utM3+0mi1ZW+hyOulDCRDc=;
 b=RbUKfJLC9DMmLvAPE7J8KViLWqAw21RSqAicnplmPgWMtWepqvwomqU1uGXZ/IpAVI/t9tqhp9dMEyAlowJ/EcOn/AoyhUdh/cnhOxG4UJfdEX07jAzmXPxHsA/FHAN44Hlp2TY456Gzuu4rWEE3Ewb8LzwrAuFSsV4XJ1m24a53tV+9x1TxtATEkdRsQcC2UYpLZL9xY7wOjIYD7jUAHzpXs2dDK8yl6dV33iUssW0lW+SVz3EHOo+8q7StQxxOdo8YyJLWU1ARLClbCwz3xQEE2rHwg7Nqb60eJvQXjgLJ4D2SAnrayQjizaCirD0bpD1iz1r/6WQe6OLxy5l1cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fY/HUtHwh82BReRCddo8utM3+0mi1ZW+hyOulDCRDc=;
 b=EKaHX7xBC9FSTPBjhm85ulGrF3NdMWeyWlVK1NpIliv5rJVtIRXabLDfQtd1hbqFdnaQ4s5tiyDXBh/Jmwp3laqimQ4Fn5xcPXNp8v6W/tx1Xj1Hm8YGXIua5jNYWCMLT8ydEruairyriOuO+vVCRQnIE7FZQbspNg7t6Y9NdTk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN0PR10MB5936.namprd10.prod.outlook.com (2603:10b6:208:3cc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Fri, 29 Apr
 2022 20:16:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.026; Fri, 29 Apr 2022
 20:16:13 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v8 66/70] nommu: remove uses of VMA linked list
Thread-Topic: [PATCH v8 66/70] nommu: remove uses of VMA linked list
Thread-Index: AQHYWX9CVyzty2Dd7U2RBRimBz8bU60Fh9gAgAHREoA=
Date:   Fri, 29 Apr 2022 20:16:13 +0000
Message-ID: <20220429201605.3wd6mhdr6i3l5b4u@revolver>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220426150616.3937571-67-Liam.Howlett@oracle.com>
 <20220428163132.GA3124052@roeck-us.net>
In-Reply-To: <20220428163132.GA3124052@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f29d368-097e-4214-84d8-08da2a1d1bc6
x-ms-traffictypediagnostic: MN0PR10MB5936:EE_
x-microsoft-antispam-prvs: <MN0PR10MB5936C5AAD214CAC87576C733FDFC9@MN0PR10MB5936.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jBA6LgHtNc6okn5v597U+Ccw6ijMzSXmsZZnKNtF/3v3tjrDrLDEGT6PVPZX0R7XCPpkzH8D/4yh7WUl4HWJJUT/Q6w7h4C6xIjaiZ4yNPEBblOyusBqnGvdfwoCJaRFqZg83CwE9PZRzrgzQ2jA4+ImubFrff9WeI40qebBionOqJY33TsPm3p0sp1ceXkpYlmoYG0OY6Q1K/NONNMeNLwZWZdIA7rju8troN9Fl59UYtLNn4CZ+Zo6swXTwBvDUA3OQd9Lbe9KqQ3RWUvQm5SDJr7gJqCGEawq1+705HfWyuyou9x6xIGbkHemfWXw4Gk6K0CSC11Vj8YCtnYMCZyOaplQ0YTEIVlv15d/HMtBglqTZOcNsi+/KhW4ARrwi78ytuY3hNH6VGnEUFOKSQXDZ6A9FhW7xnLnZg3CET/vHYmNc/F8vXA5CxstxWZ/IDldoKL1nojepmRheLpjNPa7o+5oXJ+0wTaXBsNfhrHGnXvpVDTkkbhBy1YiyoEfjSWLlEaFTQQjijQnHaulaZSNKisHm7iM0vNi2Q0ZhXXKHo3m0nG+XNKjUut4qiY87cmkoZ8OiVIuQWtkSOFdnhWzMuvaf0fwS9wgz5FnbSQI5FnnuBh17Oo2rRcmf1yfV6ngB9xHVxTnFNQj4WX0aEGwvOK+P53qMPhQOWN++K64e3SUXsc9mJuEaKMR96KrwYZsQKog9CARCt0QgQ/47KJ8YlvYaDPOmO0GnSudzWNPb1rQCwOSBL2sK9qIDxHvCOkKrfRBLz1AECKgWzOwbohzbVSoYM3+a6lez638Z7E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(71200400001)(8936002)(5660300002)(54906003)(6486002)(966005)(508600001)(38070700005)(316002)(66946007)(44832011)(122000001)(38100700002)(6916009)(83380400001)(66476007)(4326008)(30864003)(8676002)(66446008)(64756008)(66556008)(2906002)(91956017)(76116006)(186003)(33716001)(1076003)(86362001)(6512007)(6506007)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1pJNufFRNU62xTuCoL+PUJjhLY8t7TfF5X9vxHUU7yZIb3p5xGg9IKzniGq8?=
 =?us-ascii?Q?oxbaHmgjHe+ExYUAMRUNVesnZ3ehPyUVV3hsaE2mF4wyyMj3G1XGBt6Js27i?=
 =?us-ascii?Q?cza11MFUiNU1AmYQBIbvlLeIGdbavA/rzHiNHNb4kFkcYvkIfoxytSPPg4pb?=
 =?us-ascii?Q?WTHBKdPencYmtVQ8FE3N/TZOJyr+WFGlib13sK7SI/M+8ZZ4ZHzbsw1YwMGJ?=
 =?us-ascii?Q?XaUGxKZ/0siuCUcfvtYCm2Ey9QM6bTXgOq52ROOqA/YiVO+lugdrdTFGOqRf?=
 =?us-ascii?Q?XlVS2F2NZQFrzJZedWDq3reoKkwMyvoA1c43dPBQ/1GbF4fXrgegiRiKtCLH?=
 =?us-ascii?Q?fpcPSW0FQcr7ZbzbQBYBmOB43+CUAgvNbljWzqIEzvjEFnOrEnUex755bRKU?=
 =?us-ascii?Q?aMNEgxQcWTTRNl63vnp7TU+SlCoULnabR+xz1dyqSpNGexnxfVFsjyiL3bqc?=
 =?us-ascii?Q?Pj46yuTgRMMcBIkQrevSJQemH79ZF6Bci5+2WZgUriqzrNSOwGyOq0oHAn4d?=
 =?us-ascii?Q?iW+u5OqWsjfzDers5om4FA9DI8B7x+0nZkhLVWh0zzYTY4on/4DiI492v23Z?=
 =?us-ascii?Q?O91d42mlUirrJb5nM+5AQxsgc5H0/rwjAgJMTt0aQLkQgD5X3o/hS+SQBDua?=
 =?us-ascii?Q?pT27G9zpNQelms36vQFmJn7kYNirpU7NrarIHB4eyZaZ7f6SRUW3C4V44NLU?=
 =?us-ascii?Q?CrEcE8wcAg/I+os5Vt/meEj3tEDQI0WqUQBkuDJsAZ7QW3YZAP1rhP3iX3e9?=
 =?us-ascii?Q?VBIAf7JeRZFvdTfBC/Jki9YKUB3oTnOLdowoFpjHMxIxwjZxwYOtMGGm7Pg6?=
 =?us-ascii?Q?QPekiE8qhzcab8dvD6T/0D9PorHKHXb/sMvIReKtq9ns1noJLT3UzvOY+i/o?=
 =?us-ascii?Q?sM96latV6vWK1Yaa3dnxJW5diFDroI+DtgC6TcDU+XpLBxXs+2GG8dSAWrWz?=
 =?us-ascii?Q?1AprdpiOW+CcfIYfmCb4FgN1GB59X6OfCuegTCQqEwd0bZY/AwOfLt5OIJJF?=
 =?us-ascii?Q?d7SpvAhoLB3e3z2WWKfz+396J4hmWqrek+wStsgtJ4dn0QtHYe7qYPRPKkMS?=
 =?us-ascii?Q?BC5isPhG3P4RvKIBFtg+u1UGOA01xSMaKU8+fCOc6uB+uhMobZVAKPuAtr8a?=
 =?us-ascii?Q?NX7fev+4GctJJerKPuNdeR9CCx2ch1jTmcFgdJk7dgPTfkCTQjAs3Dj4Ys0V?=
 =?us-ascii?Q?/99Okc4uodKpcPiMS8psv+XC5e1UIlV/b/9jwKKnaYpePtvhDGZKvTTTiYdX?=
 =?us-ascii?Q?tdlG/keRNic4Z0GH49XrFlDn4WiOWdtummZkIkDgRUgvZQqIkdNNExWUytHp?=
 =?us-ascii?Q?jSoEOUamy9mOVLMEwxD33+PZQ9avPN+ywqfoQNsrqUYwww4rUZTWh41Ue5jL?=
 =?us-ascii?Q?Lz44508V9qwVn232jOgxURusoWroK4Tz4HGbRhlyt1ox4xeRNj36r3aE+/lR?=
 =?us-ascii?Q?jP2TkjgFRCFW/XjBibae+XaVR8bsB4tXIg8sYIO+djF0ww1qNMmO1wOkiye8?=
 =?us-ascii?Q?wENYSsBKR/ngojO5PbDQXohzJ/OOV3CUrXQw4zkl7tzzq2xu8GeDLXG6lWW9?=
 =?us-ascii?Q?C/IZ2WCSzzPmvBcKxxFjRnuzoXpzD20LerODGcWIBAPW/TroaRYEy9lIX+43?=
 =?us-ascii?Q?EMbEOzvZkuAUvHAO3HTTWpOQIftxfdLIBBlzpuuyd/MIHtBZRvvSey16VK0X?=
 =?us-ascii?Q?h/vrFBK456TJsrslryNJIESSr86znj7oQWBT9LnY7CAjSli1kFCHTxiNV5zl?=
 =?us-ascii?Q?3szET9Gi+vWqub1WoN5yWvnUb3P9cNo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <55E82916543434418B64BF021B59C0CF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f29d368-097e-4214-84d8-08da2a1d1bc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 20:16:13.4447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7d73OnqsIT6ZRY+1JJbNBo5X7QYTzpXZyEI06T6Be4QYhJP6EYj48bpf/E8TMCegfkmOjuy1ONUoHkKscfTL3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5936
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-29_07:2022-04-28,2022-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204290108
X-Proofpoint-GUID: Zp_h6WNDCd1YnettGCoCUuRyBmfWBjtv
X-Proofpoint-ORIG-GUID: Zp_h6WNDCd1YnettGCoCUuRyBmfWBjtv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net> [220428 12:31]:
> On Tue, Apr 26, 2022 at 03:06:52PM +0000, Liam Howlett wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> >=20
> > Use the maple tree or VMA iterator instead.  This is faster and will al=
low
> > us to shrink the VMA.
> >=20
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
>=20
> This patch also results in boot failures for m68k:mcf5208evb qemu emulati=
ons.
> Backtrace and bisect log attached.

Thanks, I have tried my branch and was able to get buildroot to boot and
log in.  At least maple tree worked on this platform at one point.

>=20
> Guenter
>=20
> ---
> # bad: [bdc61aad77faf67187525028f1f355eff3849f22] Add linux-next specific=
 files for 20220428
> # good: [af2d861d4cd2a4da5137f795ee3509e6f944a25b] Linux 5.18-rc4
> git bisect start 'HEAD' 'v5.18-rc4'
> # good: [a6ffa4aa7e81a54632f3370f4c93fce603160192] Merge branch 'master' =
of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> git bisect good a6ffa4aa7e81a54632f3370f4c93fce603160192
> # good: [cd63f17e3bb63006f9f88bf7f5947b8e1601bcd9] Merge branch 'edac-for=
-next' of git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
> git bisect good cd63f17e3bb63006f9f88bf7f5947b8e1601bcd9
> # good: [cee7bbed3e5cc089b5c364ac8ad4a186c2a28bb6] Merge branch 'next' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
> git bisect good cee7bbed3e5cc089b5c364ac8ad4a186c2a28bb6
> # good: [d5a23156ea99f10b584221893a6a7d6f6554cde8] Merge branch 'for-next=
' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git
> git bisect good d5a23156ea99f10b584221893a6a7d6f6554cde8
> # good: [2f1fde90d983bc404503100c9c4bbbf1e191bcf4] selftests: cgroup: fix=
 alloc_anon_noexit() instantly freeing memory
> git bisect good 2f1fde90d983bc404503100c9c4bbbf1e191bcf4
> # good: [fca1db6ff251278c532231552e840c7dc36dfa76] Merge branch 'bitmap-f=
or-next' of https://github.com/norov/linux.git
> git bisect good fca1db6ff251278c532231552e840c7dc36dfa76
> # good: [40b39116fe8e6fb66e3166ea40138eec506dfd91] perf: use VMA iterator
> git bisect good 40b39116fe8e6fb66e3166ea40138eec506dfd91
> # bad: [33ef257872566922df2b6bcfdb5330b2388aef53] Docs/{ABI,admin-guide}/=
damon: update for fixed virtual address ranges monitoring
> git bisect bad 33ef257872566922df2b6bcfdb5330b2388aef53
> # good: [2d8640f244c1ea6c40acde911d339dabc2ac765d] mm/oom_kill: use maple=
 tree iterators instead of vma linked list
> git bisect good 2d8640f244c1ea6c40acde911d339dabc2ac765d
> # bad: [49d281fa016f2906346f1707e5059b6f7674a948] mm/mmap.c: pass in mapp=
ing to __vma_link_file()
> git bisect bad 49d281fa016f2906346f1707e5059b6f7674a948
> # bad: [487c2c6d922605aebe6f470e1a458eb1425548db] nommu: remove uses of V=
MA linked list
> git bisect bad 487c2c6d922605aebe6f470e1a458eb1425548db
> # good: [dc4a1ab575a32e454be953f7b1b0222dcd3d47fa] mm/swapfile: use vma i=
terator instead of vma linked list
> git bisect good dc4a1ab575a32e454be953f7b1b0222dcd3d47fa
> # good: [7fffbdd08665ddeeb38768309269fa5b32388c3d] i915: use the VMA iter=
ator
> git bisect good 7fffbdd08665ddeeb38768309269fa5b32388c3d
> # first bad commit: [487c2c6d922605aebe6f470e1a458eb1425548db] nommu: rem=
ove uses of VMA linked list
>=20
> ---
>=20
> ...
> page allocation failure: order:7, mode:0xcc0(GFP_KERNEL), nodemask=3D(nul=
l)
> CPU: 0 PID: 62 Comm: echo Not tainted 5.18.0-rc4-next-20220428 #1
> Stack from 405d9d14:
>         405d9d14 40335f43 40335f43 00000000 00000000 402da566 40335f43 40=
0926f6
>         00000cc0 00000000 00000000 00000000 405d8000 40906ee0 405d9d6c 40=
335402
>         405d9d4c 405d9df8 40093158 00000cc0 00000000 40335402 00000007 00=
000007
>         000d8000 00000cc0 00000001 00000077 0000006c 00000000 40906ee0 40=
9049a0
>         00000000 00000000 00000001 00000000 00000400 41cdad88 00000000 00=
1008c0
>         00000000 409830d2 405d4037 283a0000 00004037 283a0000 00000000 00=
010000
> Call Trace: [<402da566>] dump_stack+0xc/0x10
>  [<400926f6>] warn_alloc+0xd0/0x1ce
>  [<40093158>] __alloc_pages+0x8c6/0xb7e
>  [<40046f82>] check_preempt_wakeup+0xce/0x178
>  [<400965da>] kmem_cache_alloc+0x22/0x17e
>  [<40093ca2>] alloc_pages_exact+0x86/0x14e
>  [<4008ddca>] do_mmap+0x3d8/0xa8a
>  [<40085ece>] vm_mmap_pgoff+0x5c/0x84
>  [<400a486c>] begin_new_exec+0x45e/0x852
>  [<400f1ea0>] load_flat_binary+0x5e8/0x878
>  [<4009bf94>] kernel_read+0x0/0x98
>  [<402d4308>] memset+0x0/0x70
>  [<4009e842>] fput+0x0/0x18
>  [<400a3638>] bprm_execve+0x188/0x3bc
>  [<400a3ab6>] copy_string_kernel+0x0/0x146
>  [<400a30ca>] copy_strings+0x0/0x1b4
>  [<400a3dce>] do_execveat_common+0x14c/0x220
>  [<403768f4>] do_name+0x27a/0x296
>  [<403765ec>] do_header+0x1c6/0x21c
>  [<403768f4>] do_name+0x27a/0x296
>  [<400a4c86>] sys_execve+0x26/0x30
>  [<403768f4>] do_name+0x27a/0x296
>  [<403765ec>] do_header+0x1c6/0x21c
>  [<400a4c60>] sys_execve+0x0/0x30
>  [<40022154>] system_call+0x48/0x94
>  [<403768f4>] do_name+0x27a/0x296
>  [<403765ec>] do_header+0x1c6/0x21c
> Mem-Info:
> active_anon:0 inactive_anon:0 isolated_anon:0
>  active_file:0 inactive_file:0 isolated_file:0
>  unevictable:606 dirty:0 writeback:0
>  slab_reclaimable:62 slab_unreclaimable:152
>  mapped:0 shmem:0 pagetables:0 bounce:0
>  kernel_misc_reclaimable:0
>  free:1071 free_pcp:0 free_cma:0
> Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0k=
B unevictable:4848kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty=
:0kB writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:216kB pagetable=
s:0kB all_unreclaimable? no
> DMA free:8568kB boost:0kB min:664kB low:824kB high:984kB reserved_highato=
mic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB=
 unevictable:4848kB writepending:0kB present:32768kB managed:28960kB mlocke=
d:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> lowmem_reserve[]: 0 0 0
> DMA: 1*8kB (U) 1*16kB (U) 9*32kB (U) 7*64kB (U) 21*128kB (U) 8*256kB (U) =
6*512kB (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB =3D 8568kB
> 613 total pagecache pages
> 4096 pages RAM
> 0 pages HighMem/MovableOnly
> 476 pages reserved
> nommu: Allocation of length 884736 from process 62 (echo) failed
> active_anon:0 inactive_anon:0 isolated_anon:0
>  active_file:0 inactive_file:0 isolated_file:0
>  unevictable:606 dirty:0 writeback:0
>  slab_reclaimable:62 slab_unreclaimable:152
>  mapped:0 shmem:0 pagetables:0 bounce:0
>  kernel_misc_reclaimable:0
>  free:1071 free_pcp:0 free_cma:0
> Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0k=
B unevictable:4848kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty=
:0kB writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:216kB pagetable=
s:0kB all_unreclaimable? no
> DMA free:8568kB boost:0kB min:664kB low:824kB high:984kB reserved_highato=
mic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB=
 unevictable:4848kB writepending:0kB present:32768kB managed:28960kB mlocke=
d:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> lowmem_reserve[]: 0 0 0
> DMA: 1*8kB (U) 1*16kB (U) 9*32kB (U) 7*64kB (U) 21*128kB (U) 8*256kB (U) =
6*512kB (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB =3D 8568kB
> 613 total pagecache pages
> binfmt_flat: Unable to allocate RAM for process text/data, errno -12
> nommu: Allocation of length 884736 from process 63 (echo) failed
> active_anon:0 inactive_anon:0 isolated_anon:0
>  active_file:0 inactive_file:0 isolated_file:0
>  unevictable:606 dirty:0 writeback:0
>  slab_reclaimable:62 slab_unreclaimable:153
>  mapped:0 shmem:0 pagetables:0 bounce:0
>  kernel_misc_reclaimable:0
>  free:1409 free_pcp:0 free_cma:0
> Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0k=
B unevictable:4848kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty=
:0kB writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:176kB pagetable=
s:0kB all_unreclaimable? no
> DMA free:11272kB boost:0kB min:664kB low:824kB high:984kB reserved_highat=
omic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0k=
B unevictable:4848kB writepending:0kB present:32768kB managed:28960kB mlock=
ed:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> lowmem_reserve[]: 0 0 0
> DMA: 5*8kB (U) 6*16kB (U) 12*32kB (U) 10*64kB (U) 21*128kB (U) 11*256kB (=
U) 9*512kB (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB =3D 11272kB
> 614 total pagecache pages
> binfmt_flat: Unable to allocate RAM for process text/data, errno -12
> nommu: Allocation of length 884736 from process 64 ([) failed
> active_anon:0 inactive_anon:0 isolated_anon:0
>  active_file:0 inactive_file:0 isolated_file:0
>  unevictable:606 dirty:0 writeback:0
>  slab_reclaimable:62 slab_unreclaimable:153
>  mapped:0 shmem:0 pagetables:0 bounce:0
>  kernel_misc_reclaimable:0
>  free:1409 free_pcp:0 free_cma:0
> Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0k=
B unevictable:4848kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty=
:0kB writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:176kB pagetable=
s:0kB all_unreclaimable? no
> DMA free:11272kB boost:0kB min:664kB low:824kB high:984kB reserved_highat=
omic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0k=
B unevictable:4848kB writepending:0kB present:32768kB managed:28960kB mlock=
ed:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> lowmem_reserve[]: 0 0 0
> DMA: 5*8kB (U) 6*16kB (U) 12*32kB (U) 10*64kB (U) 21*128kB (U) 11*256kB (=
U) 9*512kB (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB =3D 11272kB
> 614 total pagecache pages
> binfmt_flat: Unable to allocate RAM for process text/data, errno -12
> nommu: Allocation of length 884736 from process 65 ([) failed
> active_anon:0 inactive_anon:0 isolated_anon:0
>  active_file:0 inactive_file:0 isolated_file:0
>  unevictable:606 dirty:0 writeback:0
>  slab_reclaimable:62 slab_unreclaimable:153
>  mapped:0 shmem:0 pagetables:0 bounce:0
>  kernel_misc_reclaimable:0
>  free:1415 free_pcp:0 free_cma:0
> Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0k=
B unevictable:4848kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty=
:0kB writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:168kB pagetable=
s:0kB all_unreclaimable? no
> DMA free:11320kB boost:0kB min:664kB low:824kB high:984kB reserved_highat=
omic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0k=
B unevictable:4848kB writepending:0kB present:32768kB managed:28960kB mlock=
ed:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> lowmem_reserve[]: 0 0 0
> DMA: 11*8kB (U) 6*16kB (U) 12*32kB (U) 10*64kB (U) 21*128kB (U) 11*256kB =
(U) 9*512kB (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB =3D 11320kB
> 614 total pagecache pages
> binfmt_flat: Unable to allocate RAM for process text/data, errno -12
> nommu: Allocation of length 884736 from process 66 (S20urandom) failed
> active_anon:0 inactive_anon:0 isolated_anon:0
>  active_file:0 inactive_file:0 isolated_file:0
>  unevictable:606 dirty:0 writeback:0
>  slab_reclaimable:62 slab_unreclaimable:153
>  mapped:0 shmem:0 pagetables:0 bounce:0
>  kernel_misc_reclaimable:0
>  free:1415 free_pcp:0 free_cma:0
> Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0k=
B unevictable:4848kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty=
:0kB writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:168kB pagetable=
s:0kB all_unreclaimable? no
> DMA free:11320kB boost:0kB min:664kB low:824kB high:984kB reserved_highat=
omic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0k=
B unevictable:4848kB writepending:0kB present:32768kB managed:28960kB mlock=
ed:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> lowmem_reserve[]: 0 0 0
> DMA: 11*8kB (U) 6*16kB (U) 12*32kB (U) 10*64kB (U) 21*128kB (U) 11*256kB =
(U) 9*512kB (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB =3D 11320kB
> 614 total pagecache pages
> binfmt_flat: Unable to allocate RAM for process text/data, errno -12
> nommu: Allocation of length 884736 from process 67 ([) failed
> active_anon:0 inactive_anon:0 isolated_anon:0
>  active_file:0 inactive_file:0 isolated_file:0
>  unevictable:606 dirty:0 writeback:0
>  slab_reclaimable:62 slab_unreclaimable:153
>  mapped:0 shmem:0 pagetables:0 bounce:0
>  kernel_misc_reclaimable:0
>  free:1415 free_pcp:0 free_cma:0
> Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0k=
B unevictable:4848kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty=
:0kB writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:168kB pagetable=
s:0kB all_unreclaimable? no
> DMA free:11320kB boost:0kB min:664kB low:824kB high:984kB reserved_highat=
omic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0k=
B unevictable:4848kB writepending:0kB present:32768kB managed:28960kB mlock=
ed:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> lowmem_reserve[]: 0 0 0
> DMA: 11*8kB (U) 6*16kB (U) 12*32kB (U) 10*64kB (U) 21*128kB (U) 11*256kB =
(U) 9*512kB (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB =3D 11320kB
> 614 total pagecache pages
> binfmt_flat: Unable to allocate RAM for process text/data, errno -12
> nommu: Allocation of length 884736 from process 68 (S40network) failed
> active_anon:0 inactive_anon:0 isolated_anon:0
>  active_file:0 inactive_file:0 isolated_file:0
>  unevictable:606 dirty:0 writeback:0
>  slab_reclaimable:62 slab_unreclaimable:153
>  mapped:0 shmem:0 pagetables:0 bounce:0
>  kernel_misc_reclaimable:0
>  free:1415 free_pcp:0 free_cma:0
> Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0k=
B unevictable:4848kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty=
:0kB writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:168kB pagetable=
s:0kB all_unreclaimable? no
> DMA free:11320kB boost:0kB min:664kB low:824kB high:984kB reserved_highat=
omic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0k=
B unevictable:4848kB writepending:0kB present:32768kB managed:28960kB mlock=
ed:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> lowmem_reserve[]: 0 0 0
> DMA: 11*8kB (U) 6*16kB (U) 12*32kB (U) 10*64kB (U) 21*128kB (U) 11*256kB =
(U) 9*512kB (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB =3D 11320kB
> 614 total pagecache pages
> binfmt_flat: Unable to allocate RAM for process text/data, errno -12
> nommu: Allocation of length 884736 from process 69 ([) failed
> active_anon:0 inactive_anon:0 isolated_anon:0
>  active_file:0 inactive_file:0 isolated_file:0
>  unevictable:606 dirty:0 writeback:0
>  slab_reclaimable:62 slab_unreclaimable:153
>  mapped:0 shmem:0 pagetables:0 bounce:0
>  kernel_misc_reclaimable:0
>  free:1415 free_pcp:0 free_cma:0
> Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0k=
B unevictable:4848kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty=
:0kB writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:168kB pagetable=
s:0kB all_unreclaimable? no
> DMA free:11320kB boost:0kB min:664kB low:824kB high:984kB reserved_highat=
omic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0k=
B unevictable:4848kB writepending:0kB present:32768kB managed:28960kB mlock=
ed:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> lowmem_reserve[]: 0 0 0
> DMA: 11*8kB (U) 6*16kB (U) 12*32kB (U) 10*64kB (U) 21*128kB (U) 11*256kB =
(U) 9*512kB (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB =3D 11320kB
> 614 total pagecache pages
> binfmt_flat: Unable to allocate RAM for process text/data, errno -12
> nommu: Allocation of length 884736 from process 70 (S55runtest) failed
> active_anon:0 inactive_anon:0 isolated_anon:0
>  active_file:0 inactive_file:0 isolated_file:0
>  unevictable:606 dirty:0 writeback:0
>  slab_reclaimable:62 slab_unreclaimable:153
>  mapped:0 shmem:0 pagetables:0 bounce:0
>  kernel_misc_reclaimable:0
>  free:1415 free_pcp:0 free_cma:0
> Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0k=
B unevictable:4848kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty=
:0kB writeback:0kB shmem:0kB writeback_tmp:0kB kernel_stack:168kB pagetable=
s:0kB all_unreclaimable? no
> DMA free:11320kB boost:0kB min:664kB low:824kB high:984kB reserved_highat=
omic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0k=
B unevictable:4848kB writepending:0kB present:32768kB managed:28960kB mlock=
ed:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> lowmem_reserve[]: 0 0 0
> DMA: 11*8kB (U) 6*16kB (U) 12*32kB (U) 10*64kB (U) 21*128kB (U) 11*256kB =
(U) 9*512kB (U) 0*1024kB 0*2048kB 0*4096kB 0*8192kB =3D 11320kB
> 614 total pagecache pages
> binfmt_flat: Unable to allocate RAM for process text/data, errno -12=
