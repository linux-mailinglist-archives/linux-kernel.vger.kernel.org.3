Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37B653AE5D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 22:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiFAUr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiFAUrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:47:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642F425E8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 13:40:05 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251GN4ke024213;
        Wed, 1 Jun 2022 19:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=XBuGxwZFnK4dR6biBlyO4dd4hI66bLZmdUDeq92pdTk=;
 b=j5ryCYu5WRk2ND3Ujd9APFhAhv0YJdBdtibzK+oN7nQWT7agyI9/OlaIubHHCkFZs5+n
 QU+CmHGUAqnoQGFLa321rbrj+F11IIjsSXGmVs/N+ee8PUcRDIHe7lSeAjDd0buNSydq
 8p7LVVnloccjZmEei5NUvURo4TR4+oF9TPRVH2RLJ6EGiiwEbUEeLIgw1EhDXVcr1ylO
 VEhrMTrGXXI8fQmj1+0XXbGldL9w8WrkSUm8AHkWrBZFfDNOvuJnCA2JT9pUcob3fvXD
 jSJoWEunuUlgKLnYQUkxagbYc9VAwVmVc8KhjCutAXBhFtSQM/A1du2I8QkvAuJY/ZWg CA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc6x8nya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 19:06:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 251IpVGN021371;
        Wed, 1 Jun 2022 19:06:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8k0qwxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 19:06:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jljy8qcyw2Pkxm92MhdE057rTHFOQ68qQECL7B3xwTzXiTjemMpVHhZ8WH64qaHceppeuQI6lHFzGdQbv7DkDs8Qp6Vw6R3b66JGlb55SYA5pxA+XaNvJCHV6Eve7cZ56qguEKqPSJ2CKyS22wSIhuKNeomob5kb1L4YHjm2UyJ3Epfil8rl0Y5k5Ms3eHAGLzuyAhEnw/lwlTuXElCWJs5hldgQ2GPmvCxZSOisfuhxyi47Ry1JNxzQc1Cronk3FOnpm4McJzfqFq83ObhxEVuLGduVOnO3gIBl3K49rpSlD8ps5dFJsy7ZLp7jT4N4mtoJj+85P7RNgiLFFNT5bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBuGxwZFnK4dR6biBlyO4dd4hI66bLZmdUDeq92pdTk=;
 b=NXzCZfUYoQIGUtYNeS2uLIQrJX0mfHhlYdaRrV5Vd4eScGfdQ4LGPaRKE06xyWvZkaM6bx56yvwrAt5wlhq4YWGFCBn1DhQISaPCtDdc6xV+U+1OkXewwRTMVV2wKzO6VU0rfaRy2Jra0fPBJNYvPgK5rXrD73fCy+/SHAS7AQZB+m4XLGGuwgUb6adB6ShMmbEXbrGzGByZqnHGKcTcWm1tvkRrgbekL+UBWv5mXVkExbWAiyAYN3HLrEsZbyCHTMb9aJerwJ2EPiKH5EfAseRUsTIXlwMrLoVwKAADcSNMh/gpJ1mPUqOrwt6gRLaqW01u22yfmbEfhvlFoNjPUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBuGxwZFnK4dR6biBlyO4dd4hI66bLZmdUDeq92pdTk=;
 b=E1Vu3ZSHuEEVqwHTU2hWDPfzjHtqHPwgOUa19XB0MwRjwHiiUBnFuh07BrPN7xwqyofapBvdakOznkET+uA0cVFPN2UIU0XHnzIVcPRXjPMvmjrJiI1ANMMZfIaxXSMzvcsPG4un8upPRdkyibzYmbezQ5jI9dTceBccgKCBLN4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB3875.namprd10.prod.outlook.com (2603:10b6:a03:1f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16; Wed, 1 Jun
 2022 19:06:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5293.015; Wed, 1 Jun 2022
 19:06:32 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH] mapletree-vs-khugepaged
Thread-Topic: [PATCH] mapletree-vs-khugepaged
Thread-Index: AQHYWyROtMkVxK19R0i3Z444SV9CtK0GzcYAgBYshMGAACVRAIAF84YAgAAsdgCAAyWOgIAAdxaAgBEFjQCAAagxAIABlR4A
Date:   Wed, 1 Jun 2022 19:06:31 +0000
Message-ID: <20220601190624.yd3xj2pyjyxtt634@revolver>
References: <20220428172040.GA3623323@roeck-us.net> <YmvVkKXJWBoGqWFx@osiris>
 <yt9dk0apbicu.fsf@linux.ibm.com> <20220513165955.mkg5wvfi4dwpzoer@revolver>
 <YoOMsmq24FWsWWyr@osiris> <b18d5338-0031-a813-2825-207bea1b84cb@roeck-us.net>
 <20220519143541.dfzgoubmkboc6kk4@revolver>
 <28f3958f-dd25-cb1a-0a4c-040e7706ffc7@roeck-us.net>
 <20220530173812.ehckwwrb5fk7mjfd@revolver>
 <20220531185626.yvlmymbxyoe5vags@revolver>
In-Reply-To: <20220531185626.yvlmymbxyoe5vags@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cf3fbed-9a0b-400e-7b42-08da4401d70a
x-ms-traffictypediagnostic: BY5PR10MB3875:EE_
x-microsoft-antispam-prvs: <BY5PR10MB3875C5595A156A35F5973066FDDF9@BY5PR10MB3875.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: edJ1EKLyrjwZBlZKdE2tcuU7IiaTVEcwS33YCF6O4vTZ4BWKywSg+Fsea3cRpEM6en38nMfTt8F79rEAhlwh12Xw1Dzmex9ExFTID7lbjhd/aE25kMTO5oDNNs4fUByBwgXAqyHUAUPfLWFN0tCFB/exKr7ErUobXow2zorNFEplkvYF7+1WBzhH0xdjiRgF/IdcaAUhVhFVtrGfqLEdi8v/ls8M/J+1zX/WT0F/7Hp3kbYcLwi7U1Gj45KdiCtxioPFs4Sia8W3GD1OEq22TM2gZpRgiDANUGfIDcPuZWmmKFeHRV0o2CBUuhrUvJWZphE2Gok1J7SxWPj1V9RAavLHWfoDtKwE7ulOjOwfX9YOyLLMPVOmiAn83F34RVlj5ZyvddcLQCWr0k6Hwg8AaAqsZErxrfZZTZRyz73AZYl7m2yaLErPhV9pbNKXC7A+3qcciP384r52cb1U5KSntAntgpoTDpHR7PqnI+hk8LtVfZ97JQVkhGPbpbZZr6pjaNygP2Xc6yP+d7bqJuUMS/7b2vkUAzADJAuJx3LkqTyonD9Mc1ovt67pjBCNaN4cWgNHa1hhq1uZPDqsrqWmJY7JUmdS/TsOg3w7WPSwwNnanfAGBmKD6pURbJEcl1UrX2sFpGFRiK0crtNHxCuOcAXE/jsj93pz191aHu2W3URZHCtyzeg0e1IPy6wALC6IvgSQH2Cw09PBU6OFnoZkJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66556008)(5660300002)(64756008)(66446008)(66476007)(71200400001)(316002)(91956017)(76116006)(186003)(66946007)(86362001)(508600001)(8676002)(8936002)(6486002)(1076003)(26005)(6512007)(9686003)(38100700002)(122000001)(38070700005)(99936003)(44832011)(6506007)(53546011)(33716001)(2906002)(110136005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YfxfN0fMuTGVvHRXoTQmTwFUMOJn3M6PbhsOfvI5XL8mshojLr2ZrmcpJfL7?=
 =?us-ascii?Q?BQxURCVI2AMt+kUpJXi09f+6439X5MxTpYmbXl49tevsFt7KR5X9P9h8TB0K?=
 =?us-ascii?Q?t5Pd0GN1sbQggRKzEzXTJmXuVR+nIyPtZugJ1o7hJmq4bWw/cjEenYXwNLFq?=
 =?us-ascii?Q?opVkKl5dAFm/7E+kSBV5t3GWH3/IPoHRWdK3W+9JjJIlPM9jHUX2GxwhB77y?=
 =?us-ascii?Q?jAuAlKC6VodrmX3bgH2ki7qp4jtggQLLHQUvFSC7+Ffh7HGz73zflEqQnKNs?=
 =?us-ascii?Q?88AueAVDCyy7iWLeZNp1kzY3OZuzT1ttP7bRPNlAaXFjgp8H6rQ5HErCUjuK?=
 =?us-ascii?Q?xLh22maJLPKo56sKHtScis69bZ5GwKICeN/xqVHOP9SU+W83NBhFV0aSMUOD?=
 =?us-ascii?Q?R6mtRcF4H0cstaqHDBgQoI4MQn2s7LjC8lKXrs8xwMKqp3WC5IJ4KRZYSX+8?=
 =?us-ascii?Q?BxiZ53AQk9lp23vpEhFWM5gzUudhMzyAneaikBXt3Xrq5mgrAhcXBrj+kGM0?=
 =?us-ascii?Q?We8UgOh9FvGw7QrJZweRWqaca80pCTVHkD4IFD460qpB11oeQreM1Oa+PVek?=
 =?us-ascii?Q?mmiEPovha1h5HxM2XLIzFFJZiHGf/vinHn9PGWzohLs7QVXODeZENhEs3ZGL?=
 =?us-ascii?Q?Qgn5FgG1oBu235lYjK1MdJWvfRj43zEwZsHt6ZL+3cO52tGsUFRty685QmSq?=
 =?us-ascii?Q?Am+mWyrBKS50duJNnwu4dl4AcjXk9CPfCUbZLbbywr/hoqy/UCoCgnU/c+Jk?=
 =?us-ascii?Q?F5NXMWmnrylZRXCRiiIhB2B09ZEnOS0U6iBqd+HHzDUDqwENYmqjE+5mvDxO?=
 =?us-ascii?Q?Xw/cPbvx0yUGCQpWykrW2U9Q0pyMn/FUmdB42QTbSK1/jbvawHg/uuBtwsiz?=
 =?us-ascii?Q?T7yRvUOl+bz8AQuzguiE8t4k4D4LMBUmVHtN9bCtM9HwLOVVnRqs0nj8Ez3o?=
 =?us-ascii?Q?Mo8fjF7Va6yKnNHkbyFDSnphW1LXOk89m7ac45GZNbnXF4YVg/BD5iPcRzYS?=
 =?us-ascii?Q?hhnSxfZIhz2KN6fRfzg3Nl1xhkyGmdW/aV/5J3naCFJt5NFxpkpPvsFzsxXU?=
 =?us-ascii?Q?pBOZ0W5f7lnGTzIuj4oIqgjqHH00nZ/t8JFTOIQs18z3hy1/wBd4BfFHhfQK?=
 =?us-ascii?Q?A2erP/Wn3f2qBTWSkYcoXNlygz44g+GSDnptJXvX6BAtpO0Emx65m3Al512H?=
 =?us-ascii?Q?fSnBPaEi1p0WCof6GNTXxF2guD6cwhcfOTB7uhVIso/zuqcGkXT/rRviA0GH?=
 =?us-ascii?Q?ajLkCJwfHRBbHnwmr21Fk3dd2zHPX7VEk7bwKZi5YM0ubmxMxTmH0rs3m0+e?=
 =?us-ascii?Q?sFm2BHVcxLhnflJP4RF8aUyY38w7hHnQLy2y6UfjUmbTpmk/bQSVkU4jf+eK?=
 =?us-ascii?Q?eiPB1tdDPx3zzqDCjJ3UREYfg3dk7j3VG6bMDB06kp8nDhtcHOhjw+QApUm/?=
 =?us-ascii?Q?2SCVkpwGKPSN5vr5MavuEQBanNCPPgTGkvMAumUhHH2AgSx81DEbCg5rGqmI?=
 =?us-ascii?Q?VhidkM41KB8BGwVlHOI6Cf4A1/S4CeDhOakY4RX9px4ibFmGRZzY7r+tdE5l?=
 =?us-ascii?Q?Uiu4fl/xAtXLB3FT3pxrpi4VCGaHihee/BAdVBTQp96/zp3MIfm0L5K1NdM9?=
 =?us-ascii?Q?0vRDaM2zenZxVdNu5RBmOlkonZ9ZWz9w19d3cJv0im1OnUxUknxoPIyG0j+x?=
 =?us-ascii?Q?CpQAGHeRygrjAMHRJhP/RNNIQcc5JPxlszrIVLPQspUWR+0XRjyWbxO7BYt4?=
 =?us-ascii?Q?UQ0duR5HbTUS2TbFX/RlOcfWIjxAJz0=3D?=
Content-Type: multipart/mixed;
        boundary="_002_20220601190624yd3xj2pyjyxtt634revolver_"
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf3fbed-9a0b-400e-7b42-08da4401d70a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 19:06:31.9165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XwK9OVlT8BdDwflk/ZhTg71M2+ZYSUWq3wQZ2TI/lCW27UnMKTMzLxRgK5SYBXTHFLwmrX8L+PxC6MW8RJpW/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3875
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-01_07:2022-06-01,2022-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206010079
X-Proofpoint-GUID: Au3cf2ysTMWG6L75YSExVabAeNKC1wKK
X-Proofpoint-ORIG-GUID: Au3cf2ysTMWG6L75YSExVabAeNKC1wKK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_20220601190624yd3xj2pyjyxtt634revolver_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2D62F75402F9F54DAA947489D10FF65E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

* Liam R. Howlett <Liam.Howlett@Oracle.com> [220531 14:56]:
> * Liam R. Howlett <Liam.Howlett@Oracle.com> [220530 13:38]:
> > * Guenter Roeck <linux@roeck-us.net> [220519 17:42]:
> > > On 5/19/22 07:35, Liam Howlett wrote:
> > > > * Guenter Roeck <linux@roeck-us.net> [220517 10:32]:
> > > >=20

...

> > I have qemu 7.0 which seems to change the default memory size from 32MB
> > to 128MB. This can be seen on your log here:
> >=20
> > Memory: 27928K/32768K available (2827K kernel code, 160K rwdata, 432K r=
odata, 1016K init, 66K bss, 4840K reserved, 0K cma-reserved)
> >=20
> > With 128MB the kernel boots.  With 64MB it also boots.  32MB fails with
> > an OOM. Looking into it more, I see that the OOM is caused by a
> > contiguous page allocation of 1MB (order 7 at 8K pages).

...

> > Does anyone have any idea why nommu would be getting this fragmented?
>=20
> Answer: Why, yes.  Matthew does.  Using alloc_pages_exact() means we
> allocate the huge chunk of memory then free the leftovers immediately.
> Those freed leftover pages are handed out on the next request - which
> happens to be the maple tree.
>=20
> It seems nommu is so close to OOMing already that this makes a
> difference.  Attached is a patch which _almost_ solves the issue by
> making it less likely to use those pages, but it's still a matter of
> timing on if this will OOM anyways.  It reduces the potential by a large
> margin, maybe 1/10 fail instead of 4/5 failing.  This patch is probably
> worth taking on its own as it reduces memory fragmentation on
> short-lived allocations that use alloc_pages_exact().
>=20
> I changed the nommu code a bit to reduce memory usage as well.  During a
> split even, I no longer delete then re-add the VMA and I only
> preallocate a single time for the two writes associated with a split. I
> also moved my pre-allocation ahead of the call path that does
> alloc_pages_exact().  This all but ensures we won't fragment the larger
> chunks of memory as we get enough nodes out of a single page to run at
> least through boot.  However, the failure rate remained at 1/10 with
> this change.
>=20
> I had accepted the scenario that this all just worked before, but my
> setup is different than that of Guenter.  I am using buildroot-2022.02.1
> and qemu 7.0 for my testing.  My configuration OOMs 12/13 times without
> maple tree, so I think we actually lowered the memory pressure on boot
> with these changes.  Obviously there is a element of timing that causes
> variation in the testing so exact numbers are not possible.

Andrew,

Please add the previous patch to the mm branch, it is not dependent on
the maple tree.

Please also include the attached patch as a fix for the maple tree nommu
OOM issue on top of "nommu: remove uses of VMA linked list".  It
triggers much less for me than a straight up buildroot-2022.02.1 build
with qemu 7.0.  I believe this will fix Guenter's issues with the maple
tree.

Thanks,
Liam

--_002_20220601190624yd3xj2pyjyxtt634revolver_
Content-Type: text/x-diff;
	name="0001-mm-nommu-Move-preallocations-and-limit-other-allocat.patch"
Content-Description: 
 0001-mm-nommu-Move-preallocations-and-limit-other-allocat.patch
Content-Disposition: attachment;
	filename="0001-mm-nommu-Move-preallocations-and-limit-other-allocat.patch";
	size=8620; creation-date="Wed, 01 Jun 2022 19:06:31 GMT";
	modification-date="Wed, 01 Jun 2022 19:06:31 GMT"
Content-ID: <5E024648E83A55418BCAF8073B6D6D5B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSBjOTJkZmNhMDI4Mzg3N2YwYzBkOWI0ZTYxOWUyNjFjMGRhNzhlYjc0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogIkxpYW0gUi4gSG93bGV0dCIgPExpYW0uSG93bGV0dEBvcmFj
bGUuY29tPg0KRGF0ZTogRnJpLCAyMCBNYXkgMjAyMiAyMTo1MTo1NyAtMDQwMA0KU3ViamVjdDog
W1BBVENIXSBtbS9ub21tdTogTW92ZSBwcmVhbGxvY2F0aW9ucyBhbmQgbGltaXQgb3RoZXIgYWxs
b2NhdGlvbnMNCg0KTW92ZSB0aGUgcHJlYWxsb2NhdGlvbnMgaW4gZG9fbW1hcCgpIGFoZWFkIG9m
IGFsbG9jYXRpb25zIHRoYXQgbWF5IHVzZQ0KYWxsb2NfcGFnZXNfZXhhY3QoKSBzbyB0aGF0IHJl
Y2xhaW1lZCBhcmVhcyBvZiBsYXJnZXIgcGFnZXMgZG9uJ3QgZ2V0DQpyZXVzZWQgZm9yIHRoZSBt
YXBsZSB0cmVlIG5vZGVzLiAgVGhpcyB3aWxsIGFsbG93IHRoZSBsYXJnZXIgYmxvY2tzIG9mDQpt
ZW1vcnkgdG8gcmVhc3NlbWJsZSBhZnRlciB1c2UuDQoNCkFsc28gYXZvaWQgb3RoZXIgdW5uZWNl
c3NhcnkgYWxsb2NhdGlvbnMgZm9yIG1hcGxlIHRyZWUgbm9kZXMgYnkNCm92ZXJ3cml0aW5nIHRo
ZSBWTUEgb24gc3BsaXQgaW5zdGVhZCBvZiBkZWxldGluZyBhbmQgcmUtYWRkaW5nLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBMaWFtIFIuIEhvd2xldHQgPExpYW0uSG93bGV0dEBvcmFjbGUuY29tPg0KLS0t
DQogbW0vbm9tbXUuYyB8IDExNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA4NiBpbnNlcnRpb25zKCspLCAyOCBk
ZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL21tL25vbW11LmMgYi9tbS9ub21tdS5jDQppbmRl
eCBiNWJiMTI3NzJjYmYuLmM4MDc5Nzk2MTA2NyAxMDA2NDQNCi0tLSBhL21tL25vbW11LmMNCisr
KyBiL21tL25vbW11LmMNCkBAIC01NTcsMjUgKzU1NywxNCBAQCB2b2lkIHZtYV9tYXNfcmVtb3Zl
KHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCBzdHJ1Y3QgbWFfc3RhdGUgKm1hcykNCiAJbWFz
X3N0b3JlX3ByZWFsbG9jKG1hcywgTlVMTCk7DQogfQ0KIA0KLS8qDQotICogYWRkIGEgVk1BIGlu
dG8gYSBwcm9jZXNzJ3MgbW1fc3RydWN0IGluIHRoZSBhcHByb3ByaWF0ZSBwbGFjZSBpbiB0aGUg
bGlzdA0KLSAqIGFuZCB0cmVlIGFuZCBhZGQgdG8gdGhlIGFkZHJlc3Mgc3BhY2UncyBwYWdlIHRy
ZWUgYWxzbyBpZiBub3QgYW4gYW5vbnltb3VzDQotICogcGFnZQ0KLSAqIC0gc2hvdWxkIGJlIGNh
bGxlZCB3aXRoIG1tLT5tbWFwX2xvY2sgaGVsZCB3cml0ZWxvY2tlZA0KLSAqLw0KLXN0YXRpYyB2
b2lkIGFkZF92bWFfdG9fbW0oc3RydWN0IG1tX3N0cnVjdCAqbW0sIHN0cnVjdCB2bV9hcmVhX3N0
cnVjdCAqdm1hKQ0KK3N0YXRpYyB2b2lkIHNldHVwX3ZtYV90b19tbShzdHJ1Y3Qgdm1fYXJlYV9z
dHJ1Y3QgKnZtYSwgc3RydWN0IG1tX3N0cnVjdCAqbW0pDQogew0KLQlzdHJ1Y3QgYWRkcmVzc19z
cGFjZSAqbWFwcGluZzsNCi0JTUFfU1RBVEUobWFzLCAmbW0tPm1tX210LCB2bWEtPnZtX3N0YXJ0
LCB2bWEtPnZtX2VuZCk7DQotDQotCUJVR19PTighdm1hLT52bV9yZWdpb24pOw0KLQ0KIAltbS0+
bWFwX2NvdW50Kys7DQogCXZtYS0+dm1fbW0gPSBtbTsNCiANCiAJLyogYWRkIHRoZSBWTUEgdG8g
dGhlIG1hcHBpbmcgKi8NCiAJaWYgKHZtYS0+dm1fZmlsZSkgew0KLQkJbWFwcGluZyA9IHZtYS0+
dm1fZmlsZS0+Zl9tYXBwaW5nOw0KKwkJc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcgPSB2
bWEtPnZtX2ZpbGUtPmZfbWFwcGluZzsNCiANCiAJCWlfbW1hcF9sb2NrX3dyaXRlKG1hcHBpbmcp
Ow0KIAkJZmx1c2hfZGNhY2hlX21tYXBfbG9jayhtYXBwaW5nKTsNCkBAIC01ODMsMTggKzU3Miw0
NiBAQCBzdGF0aWMgdm9pZCBhZGRfdm1hX3RvX21tKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCBzdHJ1
Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSkNCiAJCWZsdXNoX2RjYWNoZV9tbWFwX3VubG9jayhtYXBw
aW5nKTsNCiAJCWlfbW1hcF91bmxvY2tfd3JpdGUobWFwcGluZyk7DQogCX0NCit9DQogDQorLyoN
CisgKiBtYXNfYWRkX3ZtYV90b19tbSgpIC0gTWFwbGUgc3RhdGUgdmFyaWFudCBvZiBhZGRfbWFz
X3RvX21tKCkuDQorICogQG1hczogVGhlIG1hcGxlIHN0YXRlIHdpdGggcHJlYWxsb2NhdGlvbnMu
DQorICogQG1tOiBUaGUgbW1fc3RydWN0DQorICogQHZtYTogVGhlIHZtYSB0byBhZGQNCisgKg0K
KyAqLw0KK3N0YXRpYyB2b2lkIG1hc19hZGRfdm1hX3RvX21tKHN0cnVjdCBtYV9zdGF0ZSAqbWFz
LCBzdHJ1Y3QgbW1fc3RydWN0ICptbSwNCisJCQkgICAgICBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3Qg
KnZtYSkNCit7DQorCUJVR19PTighdm1hLT52bV9yZWdpb24pOw0KKw0KKwlzZXR1cF92bWFfdG9f
bW0odm1hLCBtbSk7DQogCS8qIGFkZCB0aGUgVk1BIHRvIHRoZSB0cmVlICovDQotCXZtYV9tYXNf
c3RvcmUodm1hLCAmbWFzKTsNCisJdm1hX21hc19zdG9yZSh2bWEsIG1hcyk7DQogfQ0KIA0KIC8q
DQotICogZGVsZXRlIGEgVk1BIGZyb20gaXRzIG93bmluZyBtbV9zdHJ1Y3QgYW5kIGFkZHJlc3Mg
c3BhY2UNCisgKiBhZGQgYSBWTUEgaW50byBhIHByb2Nlc3MncyBtbV9zdHJ1Y3QgaW4gdGhlIGFw
cHJvcHJpYXRlIHBsYWNlIGluIHRoZSBsaXN0DQorICogYW5kIHRyZWUgYW5kIGFkZCB0byB0aGUg
YWRkcmVzcyBzcGFjZSdzIHBhZ2UgdHJlZSBhbHNvIGlmIG5vdCBhbiBhbm9ueW1vdXMNCisgKiBw
YWdlDQorICogLSBzaG91bGQgYmUgY2FsbGVkIHdpdGggbW0tPm1tYXBfbG9jayBoZWxkIHdyaXRl
bG9ja2VkDQogICovDQotc3RhdGljIHZvaWQgZGVsZXRlX3ZtYV9mcm9tX21tKHN0cnVjdCB2bV9h
cmVhX3N0cnVjdCAqdm1hKQ0KK3N0YXRpYyBpbnQgYWRkX3ZtYV90b19tbShzdHJ1Y3QgbW1fc3Ry
dWN0ICptbSwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpDQogew0KLQlNQV9TVEFURShtYXMs
ICZ2bWEtPnZtX21tLT5tbV9tdCwgMCwgMCk7DQorCU1BX1NUQVRFKG1hcywgJm1tLT5tbV9tdCwg
dm1hLT52bV9zdGFydCwgdm1hLT52bV9lbmQpOw0KKw0KKwlpZiAobWFzX3ByZWFsbG9jYXRlKCZt
YXMsIHZtYSwgR0ZQX0tFUk5FTCkpIHsNCisJCXByX3dhcm4oIkFsbG9jYXRpb24gb2Ygdm1hIHRy
ZWUgZm9yIHByb2Nlc3MgJWQgZmFpbGVkXG4iLA0KKwkJICAgICAgIGN1cnJlbnQtPnBpZCk7DQor
CQlyZXR1cm4gLUVOT01FTTsNCisJfQ0KKwltYXNfYWRkX3ZtYV90b19tbSgmbWFzLCBtbSwgdm1h
KTsNCisJcmV0dXJuIDA7DQorfQ0KIA0KK3N0YXRpYyB2b2lkIGNsZWFudXBfdm1hX2Zyb21fbW0o
c3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpDQorew0KIAl2bWEtPnZtX21tLT5tYXBfY291bnQt
LTsNCiAJLyogcmVtb3ZlIHRoZSBWTUEgZnJvbSB0aGUgbWFwcGluZyAqLw0KIAlpZiAodm1hLT52
bV9maWxlKSB7DQpAQCAtNjA3LDkgKzYyNCwyNCBAQCBzdGF0aWMgdm9pZCBkZWxldGVfdm1hX2Zy
b21fbW0oc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpDQogCQlmbHVzaF9kY2FjaGVfbW1hcF91
bmxvY2sobWFwcGluZyk7DQogCQlpX21tYXBfdW5sb2NrX3dyaXRlKG1hcHBpbmcpOw0KIAl9DQor
fQ0KKy8qDQorICogZGVsZXRlIGEgVk1BIGZyb20gaXRzIG93bmluZyBtbV9zdHJ1Y3QgYW5kIGFk
ZHJlc3Mgc3BhY2UNCisgKi8NCitzdGF0aWMgaW50IGRlbGV0ZV92bWFfZnJvbV9tbShzdHJ1Y3Qg
dm1fYXJlYV9zdHJ1Y3QgKnZtYSkNCit7DQorCU1BX1NUQVRFKG1hcywgJnZtYS0+dm1fbW0tPm1t
X210LCAwLCAwKTsNCisNCisJaWYgKG1hc19wcmVhbGxvY2F0ZSgmbWFzLCB2bWEsIEdGUF9LRVJO
RUwpKSB7DQorCQlwcl93YXJuKCJBbGxvY2F0aW9uIG9mIHZtYSB0cmVlIGZvciBwcm9jZXNzICVk
IGZhaWxlZFxuIiwNCisJCSAgICAgICBjdXJyZW50LT5waWQpOw0KKwkJcmV0dXJuIC1FTk9NRU07
DQorCX0NCisJY2xlYW51cF92bWFfZnJvbV9tbSh2bWEpOw0KIA0KIAkvKiByZW1vdmUgZnJvbSB0
aGUgTU0ncyB0cmVlIGFuZCBsaXN0ICovDQogCXZtYV9tYXNfcmVtb3ZlKHZtYSwgJm1hcyk7DQor
CXJldHVybiAwOw0KIH0NCiANCiAvKg0KQEAgLTEwMTksNiArMTA1MSw3IEBAIHVuc2lnbmVkIGxv
bmcgZG9fbW1hcChzdHJ1Y3QgZmlsZSAqZmlsZSwNCiAJdm1fZmxhZ3NfdCB2bV9mbGFnczsNCiAJ
dW5zaWduZWQgbG9uZyBjYXBhYmlsaXRpZXMsIHJlc3VsdDsNCiAJaW50IHJldDsNCisJTUFfU1RB
VEUobWFzLCAmY3VycmVudC0+bW0tPm1tX210LCAwLCAwKTsNCiANCiAJKnBvcHVsYXRlID0gMDsN
CiANCkBAIC0xMDM3LDYgKzEwNzAsMTAgQEAgdW5zaWduZWQgbG9uZyBkb19tbWFwKHN0cnVjdCBm
aWxlICpmaWxlLA0KIAkgKiBub3cga25vdyBpbnRvIFZNQSBmbGFncyAqLw0KIAl2bV9mbGFncyA9
IGRldGVybWluZV92bV9mbGFncyhmaWxlLCBwcm90LCBmbGFncywgY2FwYWJpbGl0aWVzKTsNCiAN
CisNCisJaWYgKG1hc19wcmVhbGxvY2F0ZSgmbWFzLCB2bWEsIEdGUF9LRVJORUwpKQ0KKwkJZ290
byBlcnJvcl9tYXBsZV9wcmVhbGxvY2F0ZTsNCisNCiAJLyogd2UncmUgZ29pbmcgdG8gbmVlZCB0
byByZWNvcmQgdGhlIG1hcHBpbmcgKi8NCiAJcmVnaW9uID0ga21lbV9jYWNoZV96YWxsb2Modm1f
cmVnaW9uX2phciwgR0ZQX0tFUk5FTCk7DQogCWlmICghcmVnaW9uKQ0KQEAgLTExODYsNyArMTIy
Myw3IEBAIHVuc2lnbmVkIGxvbmcgZG9fbW1hcChzdHJ1Y3QgZmlsZSAqZmlsZSwNCiAJY3VycmVu
dC0+bW0tPnRvdGFsX3ZtICs9IGxlbiA+PiBQQUdFX1NISUZUOw0KIA0KIHNoYXJlOg0KLQlhZGRf
dm1hX3RvX21tKGN1cnJlbnQtPm1tLCB2bWEpOw0KKwltYXNfYWRkX3ZtYV90b19tbSgmbWFzLCBj
dXJyZW50LT5tbSwgdm1hKTsNCiANCiAJLyogd2UgZmx1c2ggdGhlIHJlZ2lvbiBmcm9tIHRoZSBp
Y2FjaGUgb25seSB3aGVuIHRoZSBmaXJzdCBleGVjdXRhYmxlDQogCSAqIG1hcHBpbmcgb2YgaXQg
aXMgbWFkZSAgKi8NCkBAIC0xMjEyLDExICsxMjQ5LDEzIEBAIHVuc2lnbmVkIGxvbmcgZG9fbW1h
cChzdHJ1Y3QgZmlsZSAqZmlsZSwNCiANCiBzaGFyaW5nX3Zpb2xhdGlvbjoNCiAJdXBfd3JpdGUo
Jm5vbW11X3JlZ2lvbl9zZW0pOw0KKwltYXNfZGVzdHJveSgmbWFzKTsNCiAJcHJfd2FybigiQXR0
ZW1wdCB0byBzaGFyZSBtaXNtYXRjaGVkIG1hcHBpbmdzXG4iKTsNCiAJcmV0ID0gLUVJTlZBTDsN
CiAJZ290byBlcnJvcjsNCiANCiBlcnJvcl9nZXR0aW5nX3ZtYToNCisJbWFzX2Rlc3Ryb3koJm1h
cyk7DQogCWttZW1fY2FjaGVfZnJlZSh2bV9yZWdpb25famFyLCByZWdpb24pOw0KIAlwcl93YXJu
KCJBbGxvY2F0aW9uIG9mIHZtYSBmb3IgJWx1IGJ5dGUgYWxsb2NhdGlvbiBmcm9tIHByb2Nlc3Mg
JWQgZmFpbGVkXG4iLA0KIAkJCWxlbiwgY3VycmVudC0+cGlkKTsNCkBAIC0xMjI0LDEwICsxMjYz
LDE3IEBAIHVuc2lnbmVkIGxvbmcgZG9fbW1hcChzdHJ1Y3QgZmlsZSAqZmlsZSwNCiAJcmV0dXJu
IC1FTk9NRU07DQogDQogZXJyb3JfZ2V0dGluZ19yZWdpb246DQorCW1hc19kZXN0cm95KCZtYXMp
Ow0KIAlwcl93YXJuKCJBbGxvY2F0aW9uIG9mIHZtIHJlZ2lvbiBmb3IgJWx1IGJ5dGUgYWxsb2Nh
dGlvbiBmcm9tIHByb2Nlc3MgJWQgZmFpbGVkXG4iLA0KIAkJCWxlbiwgY3VycmVudC0+cGlkKTsN
CiAJc2hvd19mcmVlX2FyZWFzKDAsIE5VTEwpOw0KIAlyZXR1cm4gLUVOT01FTTsNCisNCitlcnJv
cl9tYXBsZV9wcmVhbGxvY2F0ZToNCisJcHJfd2FybigiQWxsb2NhdGlvbiBvZiB2bWEgdHJlZSBm
b3IgcHJvY2VzcyAlZCBmYWlsZWRcbiIsIGN1cnJlbnQtPnBpZCk7DQorCXNob3dfZnJlZV9hcmVh
cygwLCBOVUxMKTsNCisJcmV0dXJuIC1FTk9NRU07DQorDQogfQ0KIA0KIHVuc2lnbmVkIGxvbmcg
a3N5c19tbWFwX3Bnb2ZmKHVuc2lnbmVkIGxvbmcgYWRkciwgdW5zaWduZWQgbG9uZyBsZW4sDQpA
QCAtMTI5Myw2ICsxMzM5LDcgQEAgaW50IHNwbGl0X3ZtYShzdHJ1Y3QgbW1fc3RydWN0ICptbSwg
c3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsDQogCXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqbmV3
Ow0KIAlzdHJ1Y3Qgdm1fcmVnaW9uICpyZWdpb247DQogCXVuc2lnbmVkIGxvbmcgbnBhZ2VzOw0K
KwlNQV9TVEFURShtYXMsICZtbS0+bW1fbXQsIHZtYS0+dm1fc3RhcnQsIHZtYS0+dm1fZW5kKTsN
CiANCiAJLyogd2UncmUgb25seSBwZXJtaXR0ZWQgdG8gc3BsaXQgYW5vbnltb3VzIHJlZ2lvbnMg
KHRoZXNlIHNob3VsZCBoYXZlDQogCSAqIG9ubHkgYSBzaW5nbGUgdXNhZ2Ugb24gdGhlIHJlZ2lv
bikgKi8NCkBAIC0xMzI4LDcgKzEzNzUsNiBAQCBpbnQgc3BsaXRfdm1hKHN0cnVjdCBtbV9zdHJ1
Y3QgKm1tLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwNCiAJaWYgKG5ldy0+dm1fb3BzICYm
IG5ldy0+dm1fb3BzLT5vcGVuKQ0KIAkJbmV3LT52bV9vcHMtPm9wZW4obmV3KTsNCiANCi0JZGVs
ZXRlX3ZtYV9mcm9tX21tKHZtYSk7DQogCWRvd25fd3JpdGUoJm5vbW11X3JlZ2lvbl9zZW0pOw0K
IAlkZWxldGVfbm9tbXVfcmVnaW9uKHZtYS0+dm1fcmVnaW9uKTsNCiAJaWYgKG5ld19iZWxvdykg
ew0KQEAgLTEzNDEsOCArMTM4NywxNyBAQCBpbnQgc3BsaXRfdm1hKHN0cnVjdCBtbV9zdHJ1Y3Qg
Km1tLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwNCiAJYWRkX25vbW11X3JlZ2lvbih2bWEt
PnZtX3JlZ2lvbik7DQogCWFkZF9ub21tdV9yZWdpb24obmV3LT52bV9yZWdpb24pOw0KIAl1cF93
cml0ZSgmbm9tbXVfcmVnaW9uX3NlbSk7DQotCWFkZF92bWFfdG9fbW0obW0sIHZtYSk7DQotCWFk
ZF92bWFfdG9fbW0obW0sIG5ldyk7DQorCWlmIChtYXNfcHJlYWxsb2NhdGUoJm1hcywgdm1hLCBH
RlBfS0VSTkVMKSkgew0KKwkJcHJfd2FybigiQWxsb2NhdGlvbiBvZiB2bWEgdHJlZSBmb3IgcHJv
Y2VzcyAlZCBmYWlsZWRcbiIsDQorCQkgICAgICAgY3VycmVudC0+cGlkKTsNCisJCXJldHVybiAt
RU5PTUVNOw0KKwl9DQorDQorCXNldHVwX3ZtYV90b19tbSh2bWEsIG1tKTsNCisJc2V0dXBfdm1h
X3RvX21tKG5ldywgbW0pOw0KKwltYXNfc2V0X3JhbmdlKCZtYXMsIHZtYS0+dm1fc3RhcnQsIHZt
YS0+dm1fZW5kIC0gMSk7DQorCW1hc19zdG9yZSgmbWFzLCB2bWEpOw0KKwl2bWFfbWFzX3N0b3Jl
KG5ldywgJm1hcyk7DQogCXJldHVybiAwOw0KIH0NCiANCkBAIC0xMzU4LDEyICsxNDEzLDE0IEBA
IHN0YXRpYyBpbnQgc2hyaW5rX3ZtYShzdHJ1Y3QgbW1fc3RydWN0ICptbSwNCiANCiAJLyogYWRq
dXN0IHRoZSBWTUEncyBwb2ludGVycywgd2hpY2ggbWF5IHJlcG9zaXRpb24gaXQgaW4gdGhlIE1N
J3MgdHJlZQ0KIAkgKiBhbmQgbGlzdCAqLw0KLQlkZWxldGVfdm1hX2Zyb21fbW0odm1hKTsNCisJ
aWYgKGRlbGV0ZV92bWFfZnJvbV9tbSh2bWEpKQ0KKwkJcmV0dXJuIC1FTk9NRU07DQogCWlmIChm
cm9tID4gdm1hLT52bV9zdGFydCkNCiAJCXZtYS0+dm1fZW5kID0gZnJvbTsNCiAJZWxzZQ0KIAkJ
dm1hLT52bV9zdGFydCA9IHRvOw0KLQlhZGRfdm1hX3RvX21tKG1tLCB2bWEpOw0KKwlpZiAoYWRk
X3ZtYV90b19tbShtbSwgdm1hKSkNCisJCXJldHVybiAtRU5PTUVNOw0KIA0KIAkvKiBjdXQgdGhl
IGJhY2tpbmcgcmVnaW9uIGRvd24gdG8gc2l6ZSAqLw0KIAlyZWdpb24gPSB2bWEtPnZtX3JlZ2lv
bjsNCkBAIC0xMzk0LDcgKzE0NTEsNyBAQCBpbnQgZG9fbXVubWFwKHN0cnVjdCBtbV9zdHJ1Y3Qg
Km1tLCB1bnNpZ25lZCBsb25nIHN0YXJ0LCBzaXplX3QgbGVuLCBzdHJ1Y3QgbGlzdA0KIAlNQV9T
VEFURShtYXMsICZtbS0+bW1fbXQsIHN0YXJ0LCBzdGFydCk7DQogCXN0cnVjdCB2bV9hcmVhX3N0
cnVjdCAqdm1hOw0KIAl1bnNpZ25lZCBsb25nIGVuZDsNCi0JaW50IHJldDsNCisJaW50IHJldCA9
IDA7DQogDQogCWxlbiA9IFBBR0VfQUxJR04obGVuKTsNCiAJaWYgKGxlbiA9PSAwKQ0KQEAgLTE0
NDQsOSArMTUwMSwxMCBAQCBpbnQgZG9fbXVubWFwKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCB1bnNp
Z25lZCBsb25nIHN0YXJ0LCBzaXplX3QgbGVuLCBzdHJ1Y3QgbGlzdA0KIAl9DQogDQogZXJhc2Vf
d2hvbGVfdm1hOg0KLQlkZWxldGVfdm1hX2Zyb21fbW0odm1hKTsNCisJaWYgKGRlbGV0ZV92bWFf
ZnJvbV9tbSh2bWEpKQ0KKwkJcmV0ID0gLUVOT01FTTsNCiAJZGVsZXRlX3ZtYShtbSwgdm1hKTsN
Ci0JcmV0dXJuIDA7DQorCXJldHVybiByZXQ7DQogfQ0KIA0KIGludCB2bV9tdW5tYXAodW5zaWdu
ZWQgbG9uZyBhZGRyLCBzaXplX3QgbGVuKQ0KQEAgLTE0ODUsMTIgKzE1NDMsMTIgQEAgdm9pZCBl
eGl0X21tYXAoc3RydWN0IG1tX3N0cnVjdCAqbW0pDQogCSAqLw0KIAltbWFwX3dyaXRlX2xvY2so
bW0pOw0KIAlmb3JfZWFjaF92bWEodm1pLCB2bWEpIHsNCi0JCWRlbGV0ZV92bWFfZnJvbV9tbSh2
bWEpOw0KKwkJY2xlYW51cF92bWFfZnJvbV9tbSh2bWEpOw0KIAkJZGVsZXRlX3ZtYShtbSwgdm1h
KTsNCiAJCWNvbmRfcmVzY2hlZCgpOw0KIAl9DQotCW1tYXBfd3JpdGVfdW5sb2NrKG1tKTsNCiAJ
X19tdF9kZXN0cm95KCZtbS0+bW1fbXQpOw0KKwltbWFwX3dyaXRlX3VubG9jayhtbSk7DQogfQ0K
IA0KIGludCB2bV9icmsodW5zaWduZWQgbG9uZyBhZGRyLCB1bnNpZ25lZCBsb25nIGxlbikNCi0t
IA0KMi4zNS4xDQoNCg==

--_002_20220601190624yd3xj2pyjyxtt634revolver_--
