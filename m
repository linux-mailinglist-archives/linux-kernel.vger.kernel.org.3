Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BAC57842A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbiGRNqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbiGRNqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:46:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3430627CD4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:46:12 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IDZjNS002739;
        Mon, 18 Jul 2022 13:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8kFzJD6b/EKGKnwKFeca6PhNJEptThFn/PLWFl4kh74=;
 b=YvkSvDfbXXL7ch/XEE90273u263nt9yca/X36LhxV68ZBsytY3niHFUD2Z8EtLORSuom
 RY8JQNd1t+cfOGeZeJyDM0286OZfcpDYom3JpPXt8yTC53s7jIsgMKEviqdhsynnoEaK
 pafDXEPFeUSjCf9k/vsfZEBDTaNCNEe13pOzpPzbLmtoG7vJfdn0DmDnIG4Jo5GjfSol
 c6vjyER10HtxcJQ7hjgjeyXMi1e+3JWMaEKufXi1oSOKU1ZANokNaroOIVSz9yJx9oHf
 0oy5ZSFKWL2iBHkq+nObikVWuQn72MBGcKh8ldiOVFXoQZfOUoJk3v69Zbbu/T9g2wyu mQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs39n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 13:45:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26IB7sFU002209;
        Mon, 18 Jul 2022 13:45:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hr0qy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 13:45:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeTTBXAjOi1pdsRxFje8md7wnt+mETAt57xMjxzcBdfbUQcGBPBiVeGRtRkCf11oE7A8jejyo4YTAQaTphMSCAESZYRdZ3QjJ40KMfOCt9qjW029WynBDNxstFQm87zohy9ExSYrFkNa9pRDA8R3r3q+oXHrZZ6Co7n2B1PhM8JHpS/ttboVIAoMEGRXGu4pRDayA0h+kkfPlRqgOMm1br/pwhIxwRdcX+zpUglPSoU9duaJvetkMjb7Fa7noVTinmO/RN0CotqfDH9OwvZ1dFjKdRT2MIOeDuxNhT6lRyjzuWphvIJxcYZ6jR3DDsbJ5au2VM0uyTtnZiTsgxbnvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kFzJD6b/EKGKnwKFeca6PhNJEptThFn/PLWFl4kh74=;
 b=nSuRKjO9YpWEyKrq+CtMkQW8x+bCgRfjS2w6+6c2uztw4EMoPw4OZcJhXUKmI5zt9uHROrRhrocXOApJgTYlsLtOSlcjDaLZ6aGDbqnM9FwB1ZonbcjhdXMZF4dEXXfC0bE68EC/oNz68jgSxCnfwdq3MwbO0eiTrcuPlvORMFmyPpZFffhWLOJr2I+cIBS14/Nem6VhRdWorwR5bKm26WNL+lPNQ1i2W+RNu8dLFYyycnkV8hXaR3Jet9ZQGIB+iDt7HZnqc2lBcCLIw7Wc7AHuORl/7OLrsNXxyyhPUrAUyvc1wA0/GEPTdb3QHDI6bTJzu9qPUU/0GxBRhsVeYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kFzJD6b/EKGKnwKFeca6PhNJEptThFn/PLWFl4kh74=;
 b=c6ZyUhEVL/Ez3zBl0bGTpOwgn6lOf6ERET9BlPv3EQrSHPzWNy51L/hNXAX1JKq5ln+aifeGQMwyRl1Q4ahhXAS/QD3LsKsGP8ul4lRrASG7ZF0EP9+GePgYHC/OCyahZtKH4iymG9VQvRc0C8x3woCZq9msUUacPpj00ImUDVs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4527.namprd10.prod.outlook.com (2603:10b6:a03:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Mon, 18 Jul
 2022 13:45:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 13:45:48 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] maple_tree: Fix sparse reported issues
Thread-Topic: [PATCH] maple_tree: Fix sparse reported issues
Thread-Index: AQHYlfsoLhkzbf9CQkS2b2OLBBRjJa17+qSAgABSigCAACjrgIAAH/GAgANG+YCAAzbDgIAAXBAAgAAh5oCAAI39gIAADaeA
Date:   Mon, 18 Jul 2022 13:45:47 +0000
Message-ID: <20220718134541.ucbpuqdfcnfxravx@revolver>
References: <20220712142441.4184969-1-Liam.Howlett@oracle.com>
 <653cc1da-e45a-9a93-7158-cee3e710ba35@redhat.com>
 <20220713132926.3sl7gs67dyjj7kit@revolver>
 <44a478e8-2ccc-e82-bd5a-172778c01529@google.com>
 <20220713175013.aoemaelds45aavc4@revolver>
 <20220715195301.r7ozt6ph2scti7vz@revolver>
 <fc9c2193-f5d7-d494-8e4e-c9f340ae8625@google.com>
 <20220718022718.wtlw7grwp6dv5fcp@revolver>
 <1098dd4d-8f12-4493-5aff-1ee489d8e7@google.com>
 <20220718125649.cpatlh7ublgf7bvg@revolver>
In-Reply-To: <20220718125649.cpatlh7ublgf7bvg@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5144e8d5-b2d8-43fb-35a6-08da68c3d221
x-ms-traffictypediagnostic: SJ0PR10MB4527:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6DoD7q6Or6EsOpkI7JDfciofHvsSEByUcH56eQ7g2XE0qHIFOD4OhAApgogyeiJ1xhlmSUJ5d6sKY0g5r+YW33Lpx8liFBw3hkjVdj2kfXsp0IQcsKqnGMgpLbWlRTR0owZ+YzAIe2qPeWzDGihxrawFOQ6FxKUTaSFJOfcVXOKKJCWoiYo2VOovVqIFTe4RDaIPSVjuMJ2/1RsvZYxl6WcKLTNY9mZ5Z02Uvu3T3hVANNCz+zNDkS3LBiMfpKjGD3Esa0xG4BxHb/0K/Yef2DL+DCl24rKZ+NPxlDedI8S/bTkh9sW6N7yaoR0xCOJJq38fh95zp1qJi0s6Ybergw8jZDt8zm3GOsicWxaVJV5LEiaLy2ZuodX7q6ByjpgFs2vDyPgCLvsgEb9gMM+59yyzcEIB2ad7+Q5tUWBWWEJdVwOsOGznCDi46xlQCOdaCl7VfhId/kLKxuwlyN7yDXCdtEmyxNHkxzZIps5nB5GAuW00rspTB4vYFMMXAFO00Np1baQSR+SLRN+vfTBCKP8CmI7ZJIpNZC6dwa+fLIIeL6+BJvYbIMyzVhWZsu67rCdxcoPph5J8BuCkMsuPC/Ww7NvucLrTGRumQphLizxCBDTrNiszYIfTRa/VYeN6mEHS3yf17bogVevOs5ssuN5fdYGgnqzAwDeTI+nuraw2EH51dc7Gy3RW4LnvKObqyZmQfgGISCX2/70agrZabLp2oFvlf/my3C1X9D2qeZG7NbKqbI2ogTGk1qw8o2vB4T8j5Hk9JLuq5jT6Lrol1xclPKKpFFd+C+tCkZBqss+DLBHEBR2q8wIcviCpBLCr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(346002)(366004)(396003)(136003)(376002)(9686003)(86362001)(6512007)(5660300002)(8936002)(6486002)(1076003)(41300700001)(6506007)(2906002)(26005)(478600001)(122000001)(71200400001)(38070700005)(3716004)(30864003)(44832011)(83380400001)(186003)(33716001)(66556008)(66446008)(76116006)(66476007)(64756008)(45080400002)(66946007)(8676002)(316002)(91956017)(38100700002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vakdzfXm4ZzH2Dp7AzcpouAxFsec5l0WkPKRLACSbouGo5hyXammwNBMuT7j?=
 =?us-ascii?Q?Jd6euMZeoY88PL76OjFgwaDsh6oA0n2kIHM9Rf5/4zAvoHFa67iU3KOqa13K?=
 =?us-ascii?Q?qwSZ58xLG0MgSMdcxSP3StFSern/d45bIh+RYex35P9utnvwhcrzfJCivHj+?=
 =?us-ascii?Q?/ntjyOP+T36psnEthvoTdMNbhON3Cq+tPrhSjMQxLYBgrGNTQiauZ9eofMAq?=
 =?us-ascii?Q?UBph3agS1oAH8aGEiVSF+ZZQv4iYroPMMpqgyF49QtVUTuHQbU2kVwm1fBGv?=
 =?us-ascii?Q?f9HMO1mHGVPEbmFFvALFr6e0NHpEQ6U2Ur2PI6kwq1pOEfB9wemB6JOY713P?=
 =?us-ascii?Q?1ReRpKnCFjeQAzhTJ+zSaTLwEfAlq0FbxLw7aZ6zmuDa+CeynEuOXDSe2AKM?=
 =?us-ascii?Q?YEeC8mZ+uB7sqFp6T540obOsa1QbUFsekblwIvx3bzUlhdw+sL1iHxyvhtI+?=
 =?us-ascii?Q?oi/xJSiqsVhfFY4EBfUFEQZ++c/qiYntFpJt8qfBXrDTn5BodM0xvWuOlDz7?=
 =?us-ascii?Q?yE8oQk43y8vtUHJFWxEzV8adiF0yq8ICnSr+4LbuRcMbqEWJTTF+S6AZk0IO?=
 =?us-ascii?Q?Hq6gLmWTQypUe26tTb4XsDpz1Wl2jDfK+kOxdHuJ9hWsLFR+Oma1krX8x5aW?=
 =?us-ascii?Q?yn4qXVHsXasP7hw+2E2XXVO179uaWW8WO08oKz6Qqgu1gxLGIxjSzCtEPi5f?=
 =?us-ascii?Q?IYBxC/8qqE+wNcg/jxLU5zCV8vNNT/xyD7wriEozI6/NUGMb1XxCiSTF1Gsl?=
 =?us-ascii?Q?9Wq1xBYv2Ez7jqgDtbrrvB2mwuRkaxmPj5bCqnqGVDL3BtHBAzzBTavNQ1Ab?=
 =?us-ascii?Q?wdD5Q09g2OsnqYBPlflTxtiAQTaQxxth8Rw290RUe0sKxlBCIZg8maCwyWZi?=
 =?us-ascii?Q?KxVUnCf0jZzJBuGsxM3nGEd3g/QIf8IVV2YiRPm0hPrfu5cKg7IRUvuaz1sK?=
 =?us-ascii?Q?D/Cd3FKrVt3hfmqAfagZavotV3p6nvjZWXQ6hLuAkSTP6lYp4EBBiztkosHM?=
 =?us-ascii?Q?rP4zc3Jrvwo/WOaQoKtELo6GWQSg/GZ53oakOmuaWCMTpdeBSmhz3JXgD5po?=
 =?us-ascii?Q?q1RMQOQvNzwmobEwsir0d0ttGMgBUm/5R/Ynq9rsmwhasqrXGTFxYlbOIwPM?=
 =?us-ascii?Q?+hEsSlztZkmtoDG0Sf0Ck0a4Jc1KyAr/Ks0Y9tn2iqI85uT2nOijlYDUvcSk?=
 =?us-ascii?Q?53VLtLY+p+nq9oK9omVqdvHRNjaaYoZI4a7flYCO4fG0amnMr5M5yv0FELT7?=
 =?us-ascii?Q?ZPlGQ1pecc8CDiVP+KRxjxjYJn8GCX0JpCWbDsLVxlbJXiQdw705//XW2u/U?=
 =?us-ascii?Q?AXavc0br9VnkiXuVCZbmqtbvEWPYuzeXUdegly2BU8t8ZUIY/5Q7GsWFVARd?=
 =?us-ascii?Q?Ztj85qJfhB9BclMOzpXPw0xvJ/j6fVuE0mNBkt2e16nbhsbX3Ee3U7yeItiQ?=
 =?us-ascii?Q?t7rT23Sg0EbVaKh5+POzAzcf3cwvvCzY4QDElvQ2q7786xiGr5+MQ1F725Im?=
 =?us-ascii?Q?PxUOt/8nBYw3Gau+yA6wv0RYz7JWPiogEajf36M5XXU8Ldy8JlJlFZaR2w87?=
 =?us-ascii?Q?hCP/iUIqgOuoRPUqt+SZZlKzvyG+jNUKktB37lB0NXQsnZZOS/ByXRNUJ+ND?=
 =?us-ascii?Q?tQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E6A00F5281D24E4B9DB013573B5434B6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5144e8d5-b2d8-43fb-35a6-08da68c3d221
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 13:45:47.9493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWuqm5zJ6gvFpij20mHZ6kpL8IpRakrhdZppVjfCIMJTy++CfVYb2p8ZtP2ThBFrSLFubklxWg+07p+axCpH7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4527
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_12,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207180059
X-Proofpoint-GUID: xzKJpYb3CKQ9PaPbTT0uvg85Rl5HsK8y
X-Proofpoint-ORIG-GUID: xzKJpYb3CKQ9PaPbTT0uvg85Rl5HsK8y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [220718 08:56]:
> * Hugh Dickins <hughd@google.com> [220718 00:28]:
> > On Mon, 18 Jul 2022, Liam Howlett wrote:
> > > * Hugh Dickins <hughd@google.com> [220717 16:58]:
> > > > On Fri, 15 Jul 2022, Liam Howlett wrote:
> > > > >=20
> > > > > Please find attached the last outstanding fix for this series.  I=
t
> > > > > covers a rare failure scenario that one of the build bots reporte=
d.
> > > > > Ironically, it changes __vma_adjust() more than the rest of the s=
eries,
> > > > > but leaves the locking in the existing order.
> > > >=20
> > > > Thanks, I folded that in to my testing on next-20220715, along with
> > > > other you posted on Friday (mas_dead_leaves() walk fix);
> > >=20
> > >   Please drop that patch, it needs more testing.
> >=20
> > Drop the mas_dead_leaves() walk fix, or the __vma_adjust() changes
> > which you attached in that mail to me? please let me know a.s.a.p,
> > since I cannot proceed without knowing which.
>=20
> Drop the mas_dead_leaves() walk fix please.  I responded to the patch
> that it's not tested enough.  I'll respond to the rest of this email
> soon.

So the mas_dead_leaves() patch will most likely produce memory leaks on
big-endian systems.

>=20
> >=20
> > >=20
> > > > but have not
> > > > even glanced at the v11 you posted Saturday, though I see from resp=
onses
> > > > that v11 has some other changes, including __vma_adjust() again, bu=
t I
> > > > just have not looked.  (I've had my own experiments in __vma_adjust=
()).
> > > >=20
> > > > You'll be wanting my report, I'll give it here rather than in the v=
11
> > > > thread.  In short, some progress, but still frustratingly none on t=
he
> > > > main crashes.
> > > >=20
> > > > 1. swapops.h BUG on !PageLocked migration entry.  This is *not* the
> > > > most urgent to fix, I'm just listing it first to get it out of the =
way
> > > > here.  This is the BUG that terminates every tmpfs swapping load te=
st
> > > > on the laptop: only progress was that, just one time, the workstati=
on
> > > > hit it before hitting its usual problems: nice to see it there too.
> > > > I'll worry about this bug when the rest is running stably.  I've on=
ly
> > > > ever noticed it when it's brk being unmapped, I expect that's a clu=
e.
> > >=20
> > > Thanks for pointing me towards a usable reproducer.  I should be able=
 to
> > > narrow it down from there, especially with the brk hint.
> >=20
> > I'm afraid I cannot point you to a good reproducer; but anyway, the BUG
> > necessarily appears some time after whatever code is at fault has been
> > exercised, so it needs thought rather than any reproducer.  It was not
> > obvious to me, but I'll think it through again, once the other issues
> > are resolved.
> >=20
> > >=20
> > > >=20
> > > > 2. Silly in do_mas_mumap():
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -2513,7 +2513,7 @@ int do_mas_munmap(struct ma_state *mas, struc=
t mm_struct *mm,
> > > >  	arch_unmap(mm, start, end);
> > > > =20
> > > >  	/* Find the first overlapping VMA */
> > > > -	vma =3D mas_find(mas, end - 1);
> > > > +	vma =3D mas_find(mas, start);
> > > >  	if (!vma)
> > > >  		return 0;
> > > > =20
> > > > Fixing that does fix some bad behaviors seen - I'd been having cras=
hes in
> > > > unmap_vmas() and unlink_anon_vmas(), and put "if (WARN_ON(!vma)) re=
turn;"
> > > > in unmap_region(); but that no longer seems necessary now do_mas_mu=
nmap()
> > > > is fixed thus.  I had high hopes that it would fix all the rest, bu=
t no.
> > >=20
> > > This is actually correct.  mas_find() is not the same as vma_find().
> > > mas_find() uses the maple state index and searches until a limit (end
> > > -1 in this case).  I haven't seen these crashes, but I think you are
> > > hitting the same issue you are discussing in #6 below.  I also hadn't
> > > realised the potential confusion of those APIs.
> >=20
> > You're right, I'm wrong, sorry about that.  But then I'm left with the
> > conundrum of how a class of crashes went away when I changed that.  Did
> > I break it all so badly that it couldn't reach the anon_vma bugs I was
> > hitting before?  Or did making that change coincide with my moving from=
=20
> > DEBUG_MAPLE off to on, so different crashes came sooner?  Or did I fold
> > in another fix from you around that time?  I don't know (and I don't
> > expect you to answer this!), but I've got some backtracking to do.

I expect it is because your search skipped the badness inserted by the
bug from #6.  I would think the workload that this was crashing on would
split the nodes in a certain way that bad VMAs ended up ahead of the
correct data?

> >=20
> > >=20
> > > >=20
> > > > 3. vma_adjust_trans_huge().  Skip this paragraph, I think there
> > > > is actually no problem here, but for safety I have rearranged the
> > > > vma_adjust_trans_huge()s inside the rmap locks, because when things
> > > > aren't working right, best to rule out some possibilities.  Why am
> > > > I even mentioning it here?  In case I send any code snippets and
> > > > you're puzzled by vma_adjust_trans_huge() having moved.
> > >=20
> > > Thanks, I will keep this in mind.
> > >=20
> > > >=20
> > > > 4. unlink_anon_vmas() in __vma_adjust().  Not urgent to fix (can on=
ly
> > > > be an issue when GFP_KERNEL preallocation fails, which I think mean=
s
> > > > when current is being OOM-killed), but whereas vma_expand() has car=
eful
> > > > anon_cloned flag, __vma_adjust() does not, and I think could be
> > > > unlinking a pre-existing anon_vma.  Aside from that, I am nervous a=
bout
> > > > using unlink_anon_vmas() there like that (and in vma_expand()): IIU=
C it's
> > > > an unnecessary "optimization" for a very unlikely case, that's in d=
anger
> > > > of doing more harm than good; and should be removed from them both =
(then
> > > > they can both simply return -ENOMEM when mas_preallocate() fails).
> > >=20
> > > I will add a flag to __vma_adjust, but I don't see how it could happe=
n.
> > > I guess if importer has an anon_vma already?  I added these as an unw=
ind
> > > since I don't want to leak - even on the rare preallocation failure. =
 If
> > > you don't want to unroll, what would you suggest in these cases?  Wou=
ld
> > > a flag be acceptable?
> >=20
> > I cannot see what purpose adding a flag to __vma_adjust() would serve.
> > If importer had anon_vma already, yes, without checking the code again,
> > that was I think what I had in mind.  But (correct me if you've observe=
d
> > that I'm wrong) there's no question of a leak there: a vma which wasn't
> > given an anon_vma before gets linked in to one, and it will all get tor=
n
> > down correctly when the process exits (indeed, when OOM kill completes)=
.
> >=20
> > It's "nice" to delay setting anon_vma until it's needed, but not worth
> > any effort to rewind it (especially on such an unlikely path): and
> > normally, once anon_vma has been set, it stays set - I'm not sure of
> > the consequence of unsetting it again (racing with rmap lookups: may
> > be okay because of how anon_vma is not trusted when page is not mapped;
> > but it's easier just to omit the rewind than think all that through).

So the only time I've even seen __vma_adjust() fail is with a fault
injector failing mas_preallocate() allocations.  If it's safe to not
unwind, I'm happy to drop both unwinds but I was concerned in the path
of a vma_merge() calling __vma_adjust() and failing out on allocations
then OOM recovering, leaving a VMA with a 1/2 merged vma with anon
incorrectly set.. which is an even more unlikely scenario.

> >=20
> > >=20
> > > >=20
> > > > 5. I was horrified/thrilled to notice last night that mas_store_pre=
alloc()
> > > > does a mas_destroy() at the end.  So only the first vma_mas_store()=
 in
> > > > __vma_adjust() gets to use the carefully preallocated nodes.  I tho=
ught
> > > > that might be responsible for lots of nastiness, but again sadly no=
.
> > > > Maybe it just falls back to GFP_ATOMIC when the preallocateds are g=
one
> > > > (I didn't look) and that often works okay.  Whether the carefully
> > > > chosen prealloc count allows for __vma_adjust() use would be anothe=
r
> > > > question.  (Earlier on I did try doubling its calculation, in case =
it
> > > > was preallocating too few, but that made no difference either.)
> > >=20
> > > mas_store_prealloc will allocate for the worst case scenario.  Since =
I
> > > cannot guarantee the second store isn't the worst case, and could fai=
l,
> > > I cannot allow for more than one allocation per preallocate.  I thoug=
ht
> > > I was fine in __vma_adjust since I preallocate after the goto label f=
or
> > > a second removal but it turns out I wasn't since the second prealloca=
te
> > > could fail, so I've removed the requirement for a second store for 'c=
ase
> > > 6' by updating the tree once and removing both VMAs in a single pass.
> > > There could, potentially be an issue if the caller to __vma_merge()
> > > wanted to reduce one limit of the VMA (I guess just the start..) and
> > > also remove one or more VMAs, and also be in a situation where
> > > allocations could cause issues (fs_reclaim).. and since __vma_adjust(=
)
> > > is so complicated, I looked at the callers.  Most use vma_merge(), an=
d
> > > those seem fine.  fs/exec only adjusts one at a time.  when splitting=
,
> > > only a single insert happens.  Did I miss some situation(s)?
> >=20
> > I don't think the fs/exec stack moving will be any worry for this.
> > Did you miss any case?  Yes, the "insert" cases from __split_vma().
> > I have no appreciation of when maple tree actually needs to make an
> > allocation, so I don't know whether the adjust_next case ever needs
> > to make an allocation, but I'd have thought the insert case might
> > need to sometimes.

Right, the __split_vma() never adjusts anything but one side of the
'vma' VMA by inserting the 'insert' VMA.  This will result in two writes
to the tree - but one will exactly fit in an existing range which will
be placed without an allocation via the mas_wr_slot_store() function in
the maple tree.  Exact fits are nice - they are fast.

> >=20
> > But I'll admit to skimming your paragraph there, I'm more concerned
> > to go on to the following issue than fully grasp your argument above.
> >=20
> > >=20
> > > >=20
> > > > 6. The main problem, crashes on the workstation (never seen on the
> > > > laptop).  I keep hacking around with the debug info (and, please,
> > > > %px not %p, %lx not %lu in the debug info: I've changed them all,
> > >=20
> > > Okay, so I tried to remove all %px in the debug code so I'll revert
> > > those.  I use %lu for historic reasons from mt_dump(), I can change
> > > those too,  The tree uses ranges to store pointers so I print the
> > > pointers in %lx and the ranges in %lu.
> > >=20
> > >=20
> > > > and a couple of %lds, in my copy of lib/maple_tree.c).  I forget
> > > > how the typical crashes appeared with the MAPLE_DEBUGs turned off
> > > > (the BUG_ON(count !=3D mm->map_count) in exit_mmap() perhaps); I've
> > > > turned them on, but usually comment out the mt_validate() and
> > > > mt_dump(), which generate far too much noise for non-specialists,
> > > > and delay the onset of crash tenfold (but re-enabled to give you
> > > > the attached messages.xz).
> > > >=20
> > > > Every time, it's the cc1 (9.3.1) doing some munmapping (cc1 is
> > > > mostly what's running in this load test, so that's not surprising;
> > > > but surprising that even when I switched the laptop to using same
> > > > gcc-9, couldn't reproduce the problem there). Typically, that
> > > > munmapping has involved splitting a small, say three page, vma
> > > > into two pages below and one page above (the "insert", and I've
> > > > hacked the debug to dump that too, see "mmap: insert" - ah,
> > > > looking at the messages now, the insert is bigger this time).
> > > >=20
> > > > And what has happened each time I've studied it (I don't know
> > > > if this is evident from the mt dumps in the messages, I hope so)
> > > > is that the vma and the insert have been correctly placed in the
> > > > tree, except that the vma has *also* been placed several pages
> > > > earlier, and a linear search of the tree finds that misplaced
> > > > instance first, vm_start not matching mt index.
> > > >=20
> > > > The map_count in these cases has always been around 59, 60, 61:
> > > > maybe just typical for cc1, or maybe significant for maple tree?
> > > >=20
> > > > I won't give up quite yet, but I'm hoping you'll have an idea for
> > > > the misplaced tree entry.  Something going wrong in rebalancing?
> > > >=20
> > > > For a long time I assumed the problem would be at the mm/mmap.c end=
,
> > > > and I've repeatedly tried different things with the vma_mas stuff
> > > > in __vma_adjust() (for example, using vma_mas_remove() to remove
> > > > vmas before re-adding them, and/or doing mas_reset() in more places=
);
> > > > but none of those attempts actually fixed the issue.  So now I'm
> > > > thinking the problem is really at the lib/maple_tree.c end.
> > > >=20
> > >=20
> > > Do you have the patch
> > > "maple_tree-Fix-stale-data-copy-in-mas_wr_node_store.patch"? It sound=
s
> > > like your issue fits this fix exactly. I was seeing the same issue wi=
th
> > > gcc 9.3.1 20200408 and this bug doesn't happen for me now.  The logs
> > > you sent also fit the situation. I went through the same exercise
> > > (exorcism?) of debugging the various additions and removals of the VM=
A
> > > only to find the issue in the tree itself.  The fix also modified the
> > > test code to detect the issue - which was actually hit but not detect=
ed
> > > in the existing test cases from a live capture of VMA activities.  It=
 is
> > > difficult to spot in the tree dump as well.  I am sure I sent this to
> > > Andrew as it is included in v11 and did not show up in his diff, but =
I
> > > cannot find it on lore, perhaps I forgot to CC you?  I've attached it
> > > here for you in case you missed it.
> >=20
> > Thanks!  No, I never received that patch, nor can I see it on lore
> > or marc.info; but I (still) haven't looked at v11, and don't know
> > about Andrew's diff.  Anyway, sounds exciting, I'm eager to stop
> > writing this mail and get to testing with that in - but please
> > let me know whether it's the mas_dead_leaves() or the __vma_adjust()
> > mods you attached previously, which you want me to leave out.

Sorry, I wandered off after the previous email.  It was the
mas_dead_leaves() patch I was referencing to drop.  I sent it out before
ensuring it was safe on all architectures and one - arm64 or s390
probably, wasn't happy with that change.

> >=20
> > >=20
> > > You are actually hitting the issue several iterations beyond when it
> > > first occurred.  It was introduced earlier in the tree and exposed wi=
th
> > > your other operations by means of a node split or merge.
> > >=20
> > > > 7. If you get to do cleanups later, please shrink those double blan=
k
> > > > lines to single blank lines.  And find a better name for the strang=
e
> > > > vma_mas_szero() - vma_mas_erase(), or is erase something different?
> > > > I'm not even sure that it's needed: that's a special case for exec'=
s
> > > > shift_arg_pages() VM_STACK_INCOMPLETE_SETUP, which uses __vma_adjus=
t()
> > > > in a non-standard way.  And trace_vma_mas_szero() in vma_mas_remove=
()
> > > > looks wrong.
> > >=20
> > > Okay, I'll be sure to only have one blank line.  Where do you see thi=
s?
> > > I would have thought that checkpatch would complain?  I did try to,
> >=20
> > No, I'm not going to search for those double blank lines now:
> > please do your own diff and look through for them.  And I don't know
> > whether checkpatch objects to them or not, but they're bad for patch
> > application, since they increase the likelihood that a patch applies
> > in the wrong place.
> >=20
> > As to whether this is or is not a good time for such cleanups,
> > I just don't know: I see Andrew on the one hand intending to drop
> > maple tree for the moment, but Linus on the other hand promising
> > an extra week for 5.19.  I'll just let others decide what they want.
> >=20
> > Hugh
> >=20
> > > regretfully, address more checkpatch issues on v11.  It added more no=
ise
> > > to the differences of v10 + patches to v11 than anything else.
> > >=20
> > >=20
> > > Thanks again,
> > > Liam=
