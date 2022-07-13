Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E617E573765
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbiGMN36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbiGMN3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:29:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236D3252B6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:29:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DDEFpb001619;
        Wed, 13 Jul 2022 13:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MLj/z3Mg59jlrgGV6jyyXSgzQe5Lygq9hrpNPB1yrL0=;
 b=C21gWDi3eP0ywkvOkUe/e2ONvOhwe2JbmhqWSSvcECvhlHtBiO0S0ZAsJr2aDCAB9y4h
 9EG0hFuuTlotcyHWxEf5sGrakMGDH1e/WWp6pVNgl/Qg77oPyPNAwTO7GjCxQbET7oW1
 wNiKBrhtaGQXTvPTmj+FFTE9HsJyZWRJ0nNreAzWY8d8WcylIQJmf8Mhhe/tm6y6g1s9
 nyzDxTA7dX7FoG2HYXj3sSLF9CwJDQmkHSSsTjVD2BBkj8/ExOtlkWq4QfCjaCyDl1Tr
 Ze5eqPbruI5tvvkXx7VYpUdcjmY6nHq+2pe72h3Yz300vmrfpDylLx/5SQSOCmQASYYh Jw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h727sjhme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 13:29:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26DDGoeT030340;
        Wed, 13 Jul 2022 13:29:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7044jth5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 13:29:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPgkYIgmi/EMmctxJDSPlo0XHcNCf8UTls4k9BNkbYwn9cwibKeaQOsyTm2KjynakvYFHMuHzYA6GJfi94OZwyxFQC3k1CotQUXpAaQi8YHlJK0eq9v0d3rIAU4YtxktTg6FT2WhrEneaWm9qHVfUjCDvIdU3aiDWP28ibHf3aN7qt6ueYubNXs47Q7cvad9jPgVhgF/XvNIrSnnGr5psbxTzDCH4F8kH6JYGt/HYxsmE4ipU531YUvVfE9llI4bC8I4FGhEzOtgRM9E9ivjnXw3iLgxuJWTGZdveEKGXUKrM28pCOrIPSwTLAEUV5QHiuvw7zxbxu6og6DI/lPSXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLj/z3Mg59jlrgGV6jyyXSgzQe5Lygq9hrpNPB1yrL0=;
 b=FJOBKuqx8wWj9JpzFXq1U4avPcYz79f3UZlRcGL7nbB6iuzMt4F2UmLjrtzxodhZqt0KVpgW1ftXmPjX8fXFD0cbZYtdDevl2sesKbonmqcxMnffiLN3DjLztCUrDSDCZrQIUAkfnZN2aFgFCEj92kVLUwHSwVmwpkePrPvC1oUsUphBI5Tux/O38/vP2KFy77Ld4lWg7loQpWZVOFTQvCPI6yxMAfNgvCatiXdVYvDPx0DnapgLwBINaBEAaguW4G22GMmIqjt9mU9slnCZUtebUKf2Xo09LlD6uMLZ+62TMjjVmHI3uWQDPOX7GkB9I8sVskiX2Cru8rHo+JkJYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLj/z3Mg59jlrgGV6jyyXSgzQe5Lygq9hrpNPB1yrL0=;
 b=NdgHuWbNweH8xxl6RQazum/kYumAh28yGsbVM8wUGnHUkFTLFyhg4AlaHPDwll/GupM1GGnIwk+UolmL6Vynh5gLJB+E/Vo99sRoQBNDVcxnvW4vuKPpRUIXeSxEaL7OxXa/OJuCYEnthez6iP0tUBzdE8fAM6hHRumtC5eVWS8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6188.namprd10.prod.outlook.com (2603:10b6:208:3bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 13:29:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 13:29:39 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     David Hildenbrand <david@redhat.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] maple_tree: Fix sparse reported issues
Thread-Topic: [PATCH] maple_tree: Fix sparse reported issues
Thread-Index: AQHYlfsoLhkzbf9CQkS2b2OLBBRjJa17+qSAgABSigA=
Date:   Wed, 13 Jul 2022 13:29:39 +0000
Message-ID: <20220713132926.3sl7gs67dyjj7kit@revolver>
References: <20220712142441.4184969-1-Liam.Howlett@oracle.com>
 <653cc1da-e45a-9a93-7158-cee3e710ba35@redhat.com>
In-Reply-To: <653cc1da-e45a-9a93-7158-cee3e710ba35@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adcbd810-2c00-4f6a-76fe-08da64d3bcc4
x-ms-traffictypediagnostic: BL3PR10MB6188:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3KKGq9EelMygVGJMYZc9WQ3hteKwYUfvKmea+IGRngvLOcy8J7tNoyIyG4kPfmQ/DHfsiqvFPi4TIXZ7GMKllCNAtIzK0pzejymvFNQRWk9Oo0wb/efdq5ZDbAMhqKyAMQIT4oQ3oYDNgCjIQQML/C8VCeacWXfZGxPHGAafUor7mcC7SBsyMLUiwKgEMxQVdsGE8C8jnxZ2gRse8kMP34JMekxQwZiGlV9qGIVvSrisIInXzIfA0yp59LJ8ZeSKMHlTg8ok7nMOKcfNbFUYy4zbXxuh/U+9sHfbNVlVFRhekrNgw6204Yd8kDoxgHeIxnTW5k+hHZZwh+catB7JrTbZrBgGv8RHc9GCPQb3sqLHUhqg97Ig6bYBKWcSrdEYwzsi1H+qPdRQz8SKWfpLcovo1Mm2MzvjxoVTyhbAtyh4dkASVYr/2lELao6bHe9Rw58wTv/FvOYoCNSLrLt6kTFAPqYkWYzqczmqxTBekl0+X0/nh2GeK20AM11POa5AepvEL5hzZ/hU27koWYtCNrzcRq0XxLoud/Kyrtoq+EnZwwcGDfWcwng4VQaFkbrEKg+HAohKzBHTtbOVZOQWE3FHMNsOjYG1f6zWh1bxcYcYWJPKcN4zrN9BDLM/abwKNux1RkZ5IEJ9xqs7/8casQ1jsqf1hUf/XlcCYetJlCKFrBM3Fu1gEGyX40vv2k7OTGDERN2oVkx/VV+M/f9SPOovfXxEU1hSdlTA88WvEKjCA+JJ/CqNt64xpuq6jvPGfzt+zZmwlxICnxJx/27rIE9ncLGSx+Sy/ZuMJjFfTDz2jZ0C+L/09n1dSabMy73n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(396003)(136003)(366004)(376002)(8936002)(83380400001)(66556008)(5660300002)(54906003)(6512007)(6506007)(9686003)(6916009)(4744005)(41300700001)(53546011)(26005)(1076003)(186003)(33716001)(316002)(478600001)(86362001)(2906002)(38070700005)(6486002)(38100700002)(4326008)(44832011)(71200400001)(122000001)(64756008)(66476007)(66946007)(66446008)(8676002)(76116006)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fzHmJ0XDu/xHaQmzne1yj87Y8vaiFUd7QhNRJvcfdCm4kgBgUzRfa1torx/W?=
 =?us-ascii?Q?595Y2xqVsqe1KAvccRxiEfAIxDX5dcrOxCNdqfD5dNqPl0a9PXaEUsek00hN?=
 =?us-ascii?Q?tpn0RUe3bMNa90svEUt2Vn/HlY0XoS+AlEIRfblOL2RPhMDe5MA/8bAvYTET?=
 =?us-ascii?Q?PYLAsQ95ifbaddJF9bRlDXbaKR4i7x2jFaprmWURkEwRS1qCF2DAHNjSPibB?=
 =?us-ascii?Q?IdtNO5F23Vk+88LdlDS5q0p58euKY771ddjwjnEu+YNZRMFH12THoEHXOu7L?=
 =?us-ascii?Q?rR9X1k0ScjYiyb1bv7vv6sSBaMK1R63ibibMEm9fImeyyjaVvZ8DLekYsjjH?=
 =?us-ascii?Q?roD5i8ILPMyLeyXKg8L7CSFHgGAW1gXXn/FyH9sbGxAYvVdPfQDu/rphn/1g?=
 =?us-ascii?Q?Xds6YTC4B5b+E9h8UhK1U7sKq5Whe8vRMVtz/5MnVVOLF0MLvtYqg7vJ0+BY?=
 =?us-ascii?Q?AnRiemG3ocrByPlKQBwpEVsfkwauIsvwFhaXI/TD0kRQ4lmQPnEcVgBuQuYa?=
 =?us-ascii?Q?5dGKVwBtbwG2FFp6I1ygDv3UqKtb7bJ0acZp3I0yhjdcYQ7akTS99gJ3qIoI?=
 =?us-ascii?Q?jQ0Y/qvor2UoxoGOJRhvsWXqOpek9o4LX3PGgMjtVkNMg9+l+rZCHC4bGSKc?=
 =?us-ascii?Q?+OTKm9lrmss1/hxJRzF4sbOTkV48KsIaRGMEzQwPU2g1G1bYbf7TIET69UGZ?=
 =?us-ascii?Q?EF6pTmDOzlfBx44x2S5XV6otnlu4g1KqV2Y628kysheyzWsyIgP3xwsKIEg/?=
 =?us-ascii?Q?us/hBUQugBcf/0WomZOdRyhCYaWFvDWbQDT9FOQaMpnxyBFt/49lS+tqtDqR?=
 =?us-ascii?Q?koz4burMFovfqxxQqphwH481WmrIJp1/N27HN1l9B4w68+EmaanD5/RN6pwr?=
 =?us-ascii?Q?7UIcpVKIozwv2jDQ4/MdgZx30lt9FHnunOrrkcrLX9nR4P36f+OZz/SBBusz?=
 =?us-ascii?Q?+UVvM373my6uJ22ix+73NquxpcRkQAVRkSR/YlWNdomBAqSFSemzwvFhPPDf?=
 =?us-ascii?Q?5paQDc/GnjXpTCh0d+4HFjeVKnFex3KnZpMCp1hKZhYd8wnLuwIZInADoJgw?=
 =?us-ascii?Q?i8qZQ1qLUTcImi9mwcqPSI28KEbWkXdAOu0j/PW8/g2LnXEqu0/4EY0bxUJ3?=
 =?us-ascii?Q?Os6JOyodf2RLrxGqPHQKs5fMf1ELpf/2M6AZbeX08/7/hmKa1uY139XxFqBD?=
 =?us-ascii?Q?3WSZRiBIvgQX+P/9XOkk8mAHz4lQy3d1/WWv4koNY8pSwwpZULvtjQrwgaCE?=
 =?us-ascii?Q?NzjBmZNd1chkx23/6D6twHeLob1O6u4ScGyKiYCMYGKSIInkqQsRarbTGD5x?=
 =?us-ascii?Q?qwlAJncopw2CTbZwtAyejGEZMZL+KJ8qv2FTlbX7Phcfpu41ZiBERfnDIIVg?=
 =?us-ascii?Q?/MjQKfCJBqqLKEGty+1c3Y5NAAz5m7rltUGbdOQ5TgNP5so4fizoXteJF/Ea?=
 =?us-ascii?Q?ZM+xMIe6b5bTkFOQORDs5epkH6fTVCYNXoMKy6Ki1O+a28U2QUH1Rmapd/Fo?=
 =?us-ascii?Q?9fd+AbYmaNb4ik+qpcVsSuRJZsFZjgdBKEqPlWo9Ybjt3hQyWZMFpaNjz71j?=
 =?us-ascii?Q?bnTvpXrHYRN8gUE+C+GYSf2b72JObWpQqVxXZCshIevgsXE30CbN519TK9wb?=
 =?us-ascii?Q?Eg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <65AD77BFFB314D46934873B540953430@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adcbd810-2c00-4f6a-76fe-08da64d3bcc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 13:29:39.3903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mya3dJPatw3vy3MGD07RgBzYrmdX8DCowv5vxgqAE8+lVrr0C3C/z6z8luK9KbgmnFv6n6eCX6iY+PZYv+QEEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6188
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_02:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207130054
X-Proofpoint-ORIG-GUID: _k6KrifjAqDY_S3dwQhs9MRuhBFcSAcI
X-Proofpoint-GUID: _k6KrifjAqDY_S3dwQhs9MRuhBFcSAcI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* David Hildenbrand <david@redhat.com> [220713 04:34]:
> On 12.07.22 16:24, Liam Howlett wrote:
> > When building with C=3D1, the maple tree had some rcu type mismatch &
> > locking mismatches in the destroy functions.  There were cosmetic only
> > since this happens after the nodes are removed from the tree.
> >=20
> > Fixes: f8acc5e9581e (Maple Tree: add new data structure)
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>=20
> Sorry to say, but the fixes become hard to follow (what/where/why). :)
>=20
> I guess it's time for a new series soon. Eventually it makes sense to
> send the fixes as reply to the individual problematic patches. (instead
> of fixes to commit ids that are not upstream)
>=20
> [yes, I'll do more review soon :) ]

I appreciate the feedback, it's much better than yelling into the void.
I have one more fix in the works - for __vma_adjust() of all functions
so that'll be impossible to follow anyways :)  I'll work on a v11 to
include that last one.

Thanks,
Liam=
