Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEA551297A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 04:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241370AbiD1Cbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 22:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiD1Cbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 22:31:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5417E59D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:28:30 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RKScMR011396;
        Thu, 28 Apr 2022 02:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Pu/ZWWoT2Qw0yItS4J8QMC4NfliiE+SLGDI6AquSbbo=;
 b=00lVDhpoCoqrkdULwSqo9GSeKHAl2W3lBYj0oAgWXpwfokd7Y5g4KGs5bPwoZii4xRtd
 BfPrcflI2s0bhZ7foNdDB0pyYp80WJZumn5I34c4rlvcWOrRV0SHPx3RLMeygkUblVFc
 mxgw6d4v/StBqqQ0o6IIwKHccyQnrs0zx/JR48tfcH2XKhhGIGLlftovypBvE63qxw2U
 3lSWgR2JzjjlfPIeofxiEtMWeDa3OGmZFAAXdu/MYQgAwYBWwwsDR4JKVcBpNfIedjfm
 yK/vcm8NwVtj68hufmKPh5TuPeQDeDar+fmvI86OeVxVGROUPY0ysL62ekYKpb8Kaf9l pw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4js82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 02:28:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23S2AeLB028385;
        Thu, 28 Apr 2022 02:28:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5ymyd9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 02:28:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bW1qToiiF6feWWyYw+MSSwkOBlwX6DW6TLfTdKwWdov2qmwIe7iiq+0qg/guk4dsT45BTn7ZkoiV+Y+b5s+DstlKyXzUEzuj2ttXMfO71jkkKq2q3iq6rf0Nu7kOi3Bm2runMlTvXp+IyukFU4cHvrDnwcWiAqY9xuvnhQmRxljnWFkzPuRXBD82WOJHQz7eS3WmJYa82SlH7srqOFuZ5DmgA1i/DP3f61bJdUy7I8TX2Ib7OQ0AH3pJsJctj/rKSaiWw3yC445HLOlFvzsMF9gly99vL3DNWHR+c0bt+4Sg6b+BJ85i/aN8n3+BvQINlzXtKQDFzVeWItthPKj7wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pu/ZWWoT2Qw0yItS4J8QMC4NfliiE+SLGDI6AquSbbo=;
 b=Exovb+0rPxmkX+8qDawaoFu7UYhmwhZpuv5WkqP+WkfSbP6K7woXIkWXVjqE40+EdYyTI/1DlEwGkKld5+dH9QAURlIxfKPLh++OfeCoRbzwQZ5a0yiEYHmxYnodlIqKlV8lzrVwHSv9LHT8faAqlzHGZH/1+IZwkvzPZqDjs7S6Go+HTj5a9gi9iz/P9I+ik0ib4WzcM9Wvg8Y7P1Gc7dGXNhFYgQnDH0pwtnR3u7CNDcGhI2sejELICnucp571JBMyxVItjtbLMZ1zSZT4vkTp97fcs4HS5Z9LqvgnNXSywHi8REp9R3AxanWJc1/nQBwd/Pp8gg/7ZfS8tvf03g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pu/ZWWoT2Qw0yItS4J8QMC4NfliiE+SLGDI6AquSbbo=;
 b=Ubyx3Q1V0B5itQEGLPZRtTBrqcVbFAnTdGn0E4klJk5Uk7jyFX5Rv4VuxW+gQtq7/0IuULvxABFZ2EwEj0afxrWc9699rUIFYPOtcvTYocMp7dIShdfAdN5Z0+n1N3XWaK5ojOyzXA5AGiSVWz3UPRyOJd081jKUk/Du6iRF2LU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB4301.namprd10.prod.outlook.com (2603:10b6:208:1d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 02:28:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 02:28:18 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v8 00/70] Introducing the Maple Tree
Thread-Topic: [PATCH v8 00/70] Introducing the Maple Tree
Thread-Index: AQHYWX8vSnmCSFccn0+psIQVsVvpYa0Cn+2AgAEtogCAADlFgIAAlV8A
Date:   Thu, 28 Apr 2022 02:28:18 +0000
Message-ID: <20220428022808.dqsvccr4ogezo5yb@revolver>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220426130857.09f40743b42b5f0bf4f19a59@linux-foundation.org>
 <20220427140832.mpvnnkkhrbupk46i@revolver>
 <20220427103331.9876ad87626af0f50e9ced0d@linux-foundation.org>
In-Reply-To: <20220427103331.9876ad87626af0f50e9ced0d@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb05c921-84d1-4597-ff51-08da28bec194
x-ms-traffictypediagnostic: MN2PR10MB4301:EE_
x-microsoft-antispam-prvs: <MN2PR10MB4301A29BCE54E6A28CB08856FDFD9@MN2PR10MB4301.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eMWJRLi+n7yOb8Q/7lCFC1uhJSHDzql7lGR0oEZofZNJbrseBiVbVc3v0+u2u8TeHb5Y89zZTYa1YjGKyU0MN3OEPdQW8LAnNxFZ8LBEdmk3nGzCfbRaMK8yVzUWV3jB2fkVIX1Fafa4Zmi8KwBaMFz0m6sN25+CdsVxIh69UE2I91R8Ws00TrTmci/LXECW4GXV1gG6BburpbQRF1k1CKAh1slBM/dPvgLoijV8ef7b+DHOvzJh/ePloBuKeINxNmGb8vwx9t+dFF3zy8+9JvMWOdOxdqYgfcK4aBhMDDog/S3XNjQ9up1Mc/U5azvYZ4DZDeWNmd9oRxBGNgGvyfLn0ifGv9bCJY1ILuj1suTVScE0CElyQFLCgEIHUwnDziZXxtmL1Pi+xyNoOcq6ccVbEjzO/+RHAaNSMITzVXOnz9afBKldRnJJbSevQNn1jfr4AtPmiqfR+uA+e/5QhRzzpPiqjRaC/0Hy+cZN4GLFUl0o5lZ7a1XIemXNX6vuuEYM+peSwCVImZSUt7/0nEJU+fuDRWtf9po3DpEAd7C1XEmv32I7jqOKGgXZcvmvgCG902lwnFrm4t43n5j24PT9IcBz/Q95UVKcgfIjImk57udjQq5lbwMWYiTq9MFdvtumUTc1RZdL2PIgY0d+PsqgngjcLjziLGTNUdwqjGSnLMvCiVyx5toxR6Q5z23/71tRSfgZ3GsJKc/s8Aw3MQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(6486002)(38070700005)(38100700002)(6916009)(508600001)(122000001)(4326008)(33716001)(8676002)(66946007)(66476007)(64756008)(91956017)(54906003)(66556008)(76116006)(71200400001)(8936002)(86362001)(316002)(5660300002)(44832011)(26005)(9686003)(83380400001)(6512007)(186003)(6506007)(1076003)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?seSm2VLA418gTquBMG9COb0UDUmDnqMYKGRh9IDXLOMoKeLSQcbON2+R+6C1?=
 =?us-ascii?Q?XBfFoUilIftNkL+yBjzp+Kbj8dPHjLRFCJLs5B4mZbICBxdbPVdJhVRvOgjF?=
 =?us-ascii?Q?k1L6lR9M7xSGh+kngofSEuMhSunDYLLtJ0x40+Ss4cv907qoiPHknJ6q1Spz?=
 =?us-ascii?Q?VK+7m0AUJ3iplhASxzGw2JcktGj+QlgunMwEDGCvm3SKZ3DmAWltPfCeZM55?=
 =?us-ascii?Q?mPFNJJ/P4tx0MtcxfMGvv4JVhdFAwDpHqksvG7QvPTiisSENmfLDZuOjFlxD?=
 =?us-ascii?Q?/OIVEqzIW9aA4MIlfTM4Nf6Z/NNXf22xBU1vPpBb+icZRu/y5lnxRTRDZiYi?=
 =?us-ascii?Q?q5DEz3NnjJiUNeVEWhORLqmDEe5FMX8Sz65H0a0uHVXVigqpBy2Y5l4boESG?=
 =?us-ascii?Q?ejUABB4mZ2ibtyAEyElWF3wBVOAVX87lOAlCd4u3i0lvYTd0IvJG93CsX9vg?=
 =?us-ascii?Q?/SbnF1kEGT1ezPkYyzevh7AYL72SsgoD+6ye3L5NGqU3bqhTD49J513iaY8j?=
 =?us-ascii?Q?K8EY1e7n8Ki/GS3ACoqxdPimyIgfOeyS68mOH293/PPn+EsBr0mAEvoUWnKQ?=
 =?us-ascii?Q?X+w2IRLmqt698XdS/xVEPFbrm253EDeVw+VhNKUe90doqEUheBR7kymmPOuo?=
 =?us-ascii?Q?qosQBy7LkfOM0FW9ivXSPujf/OqR/7jLh3jgWA2o+AKidU4HBYTV2L3mt87m?=
 =?us-ascii?Q?T23+5CxF+fD26vHBLQk3ysgFwhfYPdF12w3tP2gEevkcHX9upGuIV8l1od02?=
 =?us-ascii?Q?Se6R4fqu5HBEbj2BpRwN1hzRwboihSA7w47jzIycexY5KDmJrQ54pm2UkIEM?=
 =?us-ascii?Q?lb1HWTKPWAI9jfWwE5Wyho4fRasaog8ZEvAj2j15ocn09X3zNKfGSfpcJ4Ep?=
 =?us-ascii?Q?SuqCP/bNwzTTBm+FOKVbaLoAD9vvL5v9G8gOcuX57j87Zy+hV85D4R6DCHV9?=
 =?us-ascii?Q?CVOvKkmylrTGJIvlQ4VKAnbcFbyigYvV5EGcn1vIHbAzNcyxw1izSnfDake2?=
 =?us-ascii?Q?GQtZ5Y1/BGMvPKoJih0Z3PmlJCGW+eSx7Ad3LgP8T/6wDp0U080qveEerisq?=
 =?us-ascii?Q?gEgjm5GnpYia+JwSrTJw6rKTNnjmY7kQjDIWbPUszdqtfNw15ExQXuxOcY3T?=
 =?us-ascii?Q?XE93ue1lxPnA34aMOZTe167XpOFUdJ9pc0crzxnrsxHEII6D8RHGisIgsquO?=
 =?us-ascii?Q?xv7JS2IlMARKNc6+pOMf2D/xBTZ0NZxvQ6B5zKK/6EJ+vtERjFXFuhkItRTn?=
 =?us-ascii?Q?sMQiANg59BXAjK9uRlOx7KU5AeyoiDsLIsjRsTv2hEBGkMphMBrQPjqm3Xa5?=
 =?us-ascii?Q?qNVvUGiANYeL7HvRxud/kopl0G6mYiwCeofb/Mi3VUpdPkjZMCMNYt9zLr2y?=
 =?us-ascii?Q?rtOshpr50qL5PTCB45NChjns/DtviU6YDobjs5xgs3NN/BygQUbGqJmOG5cY?=
 =?us-ascii?Q?vOVGaZ7yotmEido93IAJ9fCUQaV4FE5uIWhmbLsBRhDhy9l1Vs9s/lhub0YC?=
 =?us-ascii?Q?EGkOh149EVSfeH7wksRpipw9Jas6bqVt+B/trB2putW0RYpQ/2IclcTf80o9?=
 =?us-ascii?Q?LLchObNqs8n6lpCsJuS4TuxLFENs24fb1Eec4cwN9uTwGAYC2SM5Tji7hBrT?=
 =?us-ascii?Q?FHfcKzYm52jYVRGlbhCnJ+W3xiSENqX7clxuws36yNnwHBVvEUdEbZsSresj?=
 =?us-ascii?Q?C0kj/tHQRJAfHfP3bQpHjBShU5MrFh8GGfpPoToJ5UTgYrRP2KiYn6JW0FYf?=
 =?us-ascii?Q?pFiDYGabZxNWaWH+YxRFtd+OfGzehGk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B8B9FCBF8A66DB498EDEC2B110F28999@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb05c921-84d1-4597-ff51-08da28bec194
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 02:28:18.2698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EVDBk3ZYcO/esfA8l9op8djqEhI1BzaZ+MN9G+c9BV1mRFCnB0iB4ycJhHbdfDlj6uviAQctzZHCLUx8RR5xVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4301
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280011
X-Proofpoint-GUID: RLsWAWf4M4StdK5rFOy90SbNRfNPxnAV
X-Proofpoint-ORIG-GUID: RLsWAWf4M4StdK5rFOy90SbNRfNPxnAV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [220427 13:33]:
> On Wed, 27 Apr 2022 14:08:39 +0000 Liam Howlett <liam.howlett@oracle.com>=
 wrote:
>=20
> > > >=20
> > > > The tree has a branching factor of 10 for non-leaf nodes and 16 for=
 leaf
> > > > nodes.  With the increased branching factor, it is significantly sh=
orter than
> > > > the rbtree so it has fewer cache misses.  The removal of the linked=
 list
> > > > between subsequent entries also reduces the cache misses and the ne=
ed to pull
> > > > in the previous and next VMA during many tree alterations.
> > >=20
> > > Do we have any quantitative testing results?
> >=20
> > I was waiting for the mmtests sweep to complete before sending them but
> > I didn't want to hold up Yu Zhao's testing of the combined tree as it
> > has proved useful already. Please don't include the results in the firs=
t
> > commit as it wouldn't make much sense.  If you intend to put them in a
> > commit message, please put them in the patch introducing the maple tree=
.
>=20
> I did that.
>=20
> > The benchmarks are around the same as they have always been.
>=20
> So it's presently a wash.
>=20
> That makes "the plan" (below) really critical, otherwise there seems
> little point in merging this code at this time?

There are a number of reasons to merge at this time.  First, as Matthew
said, we have more than one user so having the tree upstream would
obviously help them out.  Second, we can make sure this much (maple tree
+ vma tracking) works for everyone before we enable VMA RCU and play
even more with the locking scenarios.  The third reason is to get more
community input into "the plan" to ensure the maple tree is beneficial
in the most common execution paths and capture corner cases.

>=20
> Please send me many very soothing words about how confident we should
> be that the plan will be implemented and that it shall be good?

Tea, warmth, fresh bread.

As we know, VMAs are rarely written and mostly read.  This plan removes
the majority of the slow down on readers.  The only slow down is when a
reader conflicts with a writer.  We are actually slower on writes - we
allocate nodes for the tree vs having it embedded in the VMA itself and
we do more work in calculating the gaps, but we are actually fast enough
to hide that on the read side.  Once the writers stop blocking the
readers it shall be good.  We need this step to get to using the maple
tree in RCU mode to make this happen.

>=20
> > >=20
> > > What's the plan on utilizing this to further reduce mmap_lock content=
ion?
> >=20
> > The plan is to get to the point where we use the maple tree in RCU mode=
.
> > Readers will not block for writers.  A single write operation will be
> > allowed at a time.  A reader re-walks if stale data is encountered. VMA=
s
> > would be RCU enabled and this mode would be entered once multiple tasks
> > are using the mm_struct.  I can go into more details if you want.
>=20
> Uh, that's very important information.  It's really the whole point
> of the patchset!   I added this to the [0/n] changelog.

Yes, but that's not what the patch set does today.  I didn't want to
include The Plan until it exists.  I'd like to think that what we have
here is worth while on its own and a good start - but a start to
something big.  It's hard enough to get people to look at 70 patches,
doubly so for an RFC of 70.  The interest from others in using a tree
with an easy interface seems like a win as well.

I also have some side goals such as the removal of __vma_adjust() for
code readability.


Thanks,
Liam=
