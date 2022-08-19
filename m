Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C89C59A809
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 00:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiHSWDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 18:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbiHSWD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:03:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F92C9591;
        Fri, 19 Aug 2022 15:03:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JLwx36000707;
        Fri, 19 Aug 2022 22:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=l27srgXX3N965QAv9Rn22kBk37VqQJdUP1ARue+PzkQ=;
 b=Gk5/zbOiSX007Q6N9w/hsYy2CwsCLXLKfFt+Wvk1xt262FXY7fiRnzWeWv4UJifRMOzz
 kyU7nm7Fd4x8VLBKI7MPMuYy3YXa4Xpck1/g09Z2D+qGvmIL0ZwfQ2CNu2KkkFnUUIgW
 xtgGxzlkBscAHPGgwQaHcPkPzHWg8zh3ncS00opooiEwirdT6MHnYIw37ESo80QCiSf0
 qZdUvkj5CLgMWr05dS9lI32ubeCayvxpWuf/ZoCbVCD3DIV8JPCSvaupiooTqRw4m05m
 OKKgmQUWYls3MghlfbwXwQUkGvX30mG5vhOfBiwyj3fS0ncC48GM7cZiCUsqv1valHQk LA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j2htu85d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 22:02:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27JLXGTK032726;
        Fri, 19 Aug 2022 22:02:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j0c2dd11w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 22:02:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/v5N0JePgo7as7A3fjfIC65i0P7/NTPnue2yveWcaKV8chYkKmGDCXIushUxBx7IE9Xfjq3fJHXhCdRaRD69XyeEtrecGiYuelYljz5abPwWpi3wyx3y5hYEgbOg3GjcjOdaK+LrNwBqeucb+BvDTGMkeRPT5WF0VGr3/DNdB3gn5/f6Xz/KpxDKPl6BWxNdQ6dWFaO7tfA9DyiGJ41nfV0RugboDxX19BsRV6XBe2v3xzHiccU3/74auNblvn/2tbK7AocC49fh+gBYFU3v8icRLFDSRKyp9/iu4qdlusqQjP2EpCJ2nAP/CfFZtbOTmq5i0Ul+GLYn0n4Qam/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l27srgXX3N965QAv9Rn22kBk37VqQJdUP1ARue+PzkQ=;
 b=H0MTucNeVRYkOCC3wE06ldQdSrrtM8KpmM3MOk8GzT4Fg+95BYZDtdmrVV+tKGhOK70m56Z7FYbTkeLpNTkALNakf7XbgBZra2tI18iTF64wk+uaJmF6JSf7YFJ5g77B52UhxOLqXCOIvjXEzuxu+YTi2Wm3owz9rR3fjjB/1dYdnmkUB19tV4EyKogWx5iW8wvDGBjaa/H8/W9hjWNjwb29YBv2ozWeOyGVhAiNPkhcs+Hs0kuPyn6DGW3nn9MviU+U4P9qkhxtu7wkTwgRO2E4DFPHiAmdok8AaCB+RGQuppnLRxZTQN7Tg6nVOVES6qijyOcMuJKybOOs1IeG+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l27srgXX3N965QAv9Rn22kBk37VqQJdUP1ARue+PzkQ=;
 b=bBEgHY1+2mJHLxQPDdTw8QBnuQbipX0fjXZMJE50CmCv4ZUZ1lvsdm7zu24+86imL8f9fekIrdlkrTa0JPrL2vadi2refCT1Mf7tsqNnPTC2a2Y9SOOMT3l7wxDmxi2J4MEfEOb5hMfSV/IvPpZuX3gYLsd1UBapFGySSOt0Sw8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1333.namprd10.prod.outlook.com (2603:10b6:903:2a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Fri, 19 Aug
 2022 22:02:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5525.019; Fri, 19 Aug 2022
 22:02:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the char-misc.current tree with the
 mm-hotfixes tree
Thread-Topic: linux-next: manual merge of the char-misc.current tree with the
 mm-hotfixes tree
Thread-Index: AQHYs1HbDhYfYQ0XCUKcG+3NKBkWE621xVmAgAAirICAAAQ1AIAAThUAgAB1iYCAABhUgA==
Date:   Fri, 19 Aug 2022 22:02:53 +0000
Message-ID: <20220819220243.ieq3drqvg3lcmark@revolver>
References: <20220819082714.5313827d@canb.auug.org.au>
 <Yv8vZQB25NE0r/uN@kroah.com> <20220819184027.7b3fda3e@canb.auug.org.au>
 <Yv9QArukYhIgg3R7@kroah.com> <20220819133458.eqshbr5xp4yr3xws@revolver>
 <20220819133539.f8eb934e29e8f4f72c62752b@linux-foundation.org>
In-Reply-To: <20220819133539.f8eb934e29e8f4f72c62752b@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8427d305-3e2d-4e4d-e217-08da822e9085
x-ms-traffictypediagnostic: CY4PR10MB1333:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9jYhYRhoVHXqXtlQvWyWLqEoAjNEAgqmTZ93EVchwjwvTs48UYM8FRSCP33i/WUKjR/LsS7oajK0BO7j0XtsI4WBdgb6u80033zj1qlFgApKcnVehMof/nI/K9vZ8WUHnll1X6z1hi/T1oNxSb6lGGsHGDZyhfiAuO+KBSDWRYn0w5AqV0vJkSJTEwdIKvrGMBk+xhSZTsxf3bOGU7z0osOwY6wKAsyA6LkfFIipgXX6yigXMbeEe08P048zDBbCgdaL3FIbqOa3GACQk3RuPKaIG9uubjVaLoIl7LtAnN0OS9t9LAT2tCNIz+r6aXCNGwJYiQENXLb+Mj/MWApsS9+kNXG8fF51c35TVDMKKNJ0I1/nBErviw6cLYKpHd9Bg8DjU/TPHloo8SLjMuBf6yl2qp8EkGGurNpj2GxKHO7XSMbQjn1h5HBKv+wWtn25i8drYg2IpUE8Z8obVxGWbwHRviMlWgUME3ksYC1jtxP2k2OihkJ3p7gnAsPk1zYG7Vl30kSOsC7EqgBHZrph99PV5AkO4Wg9gHhjumb/6uNLxnw6BAaz5usmI7pl3WonECG4Yj/OLiHpUQh/SBCUioOAaEiV5a6CKrhJf8LzBkRQ1WX1glREI3lSVaewHcakUsmwGEW9YOZlhBZ5cnAQO17hY1hb6W88i9jd2gvmKnbESd3vnvg5syWgWjr9XHFpFkXARidaoRhZjlkuOwDm31zz/cO+zvHzzO+QLwzLI5L8/II4EIt8hWNjBxWX/SOa9qPMzl0cHHy5kqowhotGLbwCRVfpZWEkryKkM39Hj82D2s4bspHpXgTXJHbr9yemGLigoSL+IxRzKp8AqwW3YA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(396003)(366004)(136003)(39860400002)(376002)(86362001)(44832011)(2906002)(5660300002)(4744005)(6512007)(9686003)(1076003)(8936002)(186003)(966005)(41300700001)(66556008)(66946007)(6486002)(64756008)(66446008)(66476007)(8676002)(6506007)(4326008)(83380400001)(478600001)(76116006)(91956017)(33716001)(122000001)(38100700002)(71200400001)(26005)(38070700005)(54906003)(6916009)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h62VnxxxKqS9v064GJLte7d8UqwDOcYOfaodfJY6k9qWMSntwFw6wEwIqLpd?=
 =?us-ascii?Q?pyAf0Ew+zfMtKahWVlBz2LBy6PuGuX8dE+UDV7IwsWM5/d4uWFR3LwKJnxnX?=
 =?us-ascii?Q?GliYVojwO3+HJtCzK3irneRtz4GV6tOWACfOsgkql2N+Gzb+48G0l7FEooWl?=
 =?us-ascii?Q?QkDSEODL+8XFHAh/K9wvnRvosnkb+DQEX1So/2cROkU2sjoyV9bK7uLSz4Cq?=
 =?us-ascii?Q?GziJYbMD42mjLIEbtQ/FId/vVxN8wn23/ZJJ9ayBcZc18AaL9ZDmzqELpRCv?=
 =?us-ascii?Q?f9C5GEqPmnFQjgQf0zhalc2FEi0pjyxp+tsUtsB7X/Ry+8bgMwnGKHJN0PvC?=
 =?us-ascii?Q?Mg/+Nx1fAR2KgS9ItgnQhIOqQzrHcVTFIrGcItwJy+Y7xzzRl1kACiAK+2mA?=
 =?us-ascii?Q?o+d2536sKoSovYrMPyBHZWAt0b60CPJNwef9zbjyeBixmZ7ZphUwygLehmYw?=
 =?us-ascii?Q?9XXWrEEsMgXGoCBoVwRx9ZESQhYhbXlWs03biBfPpbm/5LHOYN13RZUZ8SHH?=
 =?us-ascii?Q?CLP15PQ3HFuW1WLdA/y7yX4dnfh37MWpGPouK3n6rC4ogqS9bpJr4aaivoJg?=
 =?us-ascii?Q?SvaZihabsJTVvCg5bh+WgiQBSwIROj5bZZQJ2fhJ2PMRcVhZV/AXwyY72To4?=
 =?us-ascii?Q?mHfEbtKr21hOcvJ4HZe65EUAboecSBl2vhOGi0WU0gbiHC4RGwDaSUcwEMWO?=
 =?us-ascii?Q?oqwJTSWUS/gJ5OAFuMstDppDXUAfFkOyxwGI7vzjJ3WX55drDTiAZRbiTwAp?=
 =?us-ascii?Q?0IBxcDCDml1mbzd1pjgj6KCMC+5mPBto2BWKDyaGsf2awoVCypxfScMe+HGq?=
 =?us-ascii?Q?iSUoAOZlKMgO5ZZTVu3Ju1LvnohvihWKFnOrrZ0QJfjtzi6Zy7kM3p52w/ro?=
 =?us-ascii?Q?Xi5CtavKObpIjcJiI71gGsLstr/P+Lkjruvz9X5gR0RBsi2uvyumPJI2ZzYG?=
 =?us-ascii?Q?YlGSF7YFudxbd1dfSrpJ2iG3DGHct33/j8ulThTkzSwVH3kwKRBeWlujiFCe?=
 =?us-ascii?Q?Vqj56nPS1dG2Jp4B6KjuRwot+n1i0OGCZ0rjs5uBF3iK9Ur/I15w6IKgA8gm?=
 =?us-ascii?Q?pzOwLVCeRieplZPqgPknfDMI6iz85H3zORAtojVfOx9ZqVkf31hYyOFqVIEl?=
 =?us-ascii?Q?VyaCoXCDXquLfX4cOwQS9xh7rNLZ9pgj/Uq+0VOOm3VzJprzroW9b6Dc+aSW?=
 =?us-ascii?Q?igd8Pka/GLaQ1MM30ua3c791ohNybk+DIu0s4SyzQSj3waY+mMULibkIgM/k?=
 =?us-ascii?Q?riMkEFnwe00qZgg+kk5/SqdojOOSDzh0DrA1n6bL2qWipK7Z4scKnr/XD+qz?=
 =?us-ascii?Q?1e+AN+mTM8H80PoGneIFUge4FHx0oP2iX7wqLhhXFfKocoo9oTKimJlMiJhz?=
 =?us-ascii?Q?7IhQkNRZwsitmyDPBNzyqwRmpxAizWWemZEEOyQSEDn5HVAVCsqtoFJ7WYLb?=
 =?us-ascii?Q?uOHEBnJnTUddgjN32CCDdXvCVzsY/5x3YehaInJv5yCr9b1kpceduCmW+1nl?=
 =?us-ascii?Q?Us5cPiKij/KbDDl61Hyt/xDapOIcYTALTxvYMpfhxrPHIHrSVok2vKnOpurO?=
 =?us-ascii?Q?bA8FlcRf2RZj/iPh0ALbZC3DuJKE7Ho+U4DTgWhccl/xtSbQL42rOHuruEjq?=
 =?us-ascii?Q?Cw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5C15872527A99247B54AE268F4D014FA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8427d305-3e2d-4e4d-e217-08da822e9085
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 22:02:53.0521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Hjr3i3vOoWV1TV0uaMCN1RIBbdmVYnqZs2Wv5uN75VoNFhtfbvyHOxKb2T91QNNZ242h8SmKkwkKiTORAyB+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208190082
X-Proofpoint-ORIG-GUID: yBwzRItZ4xKHnoqGymF2ScsYqJdM10kH
X-Proofpoint-GUID: yBwzRItZ4xKHnoqGymF2ScsYqJdM10kH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [220819 16:35]:
> On Fri, 19 Aug 2022 13:35:04 +0000 Liam Howlett <liam.howlett@oracle.com>=
 wrote:
>=20
> > b3bb668f3dc6 is the older v1 of the patch [1]. d6f35446d076 from
> > mm-hotfixes is the correct v2 version [2], although I don't think that'=
s
> > currently in mm-hotfixes-unstable.  It looks like version 1 is now in
> > mm-hotfixes-unstable as well.
> >=20
> > 1: https://lore.kernel.org/linux-mm/20220809160618.1052539-1-Liam.Howle=
tt@oracle.com/
> > 2: https://lore.kernel.org/linux-mm/20220810160209.1630707-1-Liam.Howle=
tt@oracle.com/
>=20
> I moved "binder_alloc: add missing mmap_lock calls when using the VMA"
> into mm-hotfixes-stable this week.
>=20
> It's the v2.  I intend to send this Linuswards today or tomorrow.  Below.
>=20
> So I think we're all good.
>=20
>=20
> commit b3bb668f3dc6a97a91c47a4cebb0e3f33554c08c

...

Sounds good, as long as it isn't the above commit which is v1, but
d6f35446d076 which is v2 :)

Thanks,
Liam
