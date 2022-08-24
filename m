Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6502A5A04C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 01:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiHXXf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 19:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiHXXe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 19:34:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D717E30E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 16:34:56 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OLLD2P027731;
        Wed, 24 Aug 2022 23:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=AVT29LI/JwU5tQQortDf++U3BmrS5pA6xhWck1VX/P4=;
 b=HY2lxY1yCsfkBcM7RvCCVYXLy/yYZI3P3PZCNIK11TpGePh+ATGq+nmKbML38CdmGkmQ
 bv6D9U8UscgcAOkls3LJjzNfit3bbvccsHSme3yOIuHCVQ7tlJ3X92zO4aiaT7Hqiskl
 RG9QTvKcluhpZ9VEhVjuIOE8QrkVeOYMU+qJ4/Q+Ywv14OgtKzTSd4G7Ux9Cjydd6aF0
 PR9MaKuvLHGnt2D6o0ji/SXE7EHrIzN6g8Lz8tiZHYb+WksIy0RIMJM32paspNLg6RnL
 uE9vbi3C1I2BXw4K47+aTKr377b26RAUvJny0BFb9mW+CQg4b3/zEQyOMJT3UU0UjOCc 9g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55p23a9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 23:34:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ON6qhX009058;
        Wed, 24 Aug 2022 23:34:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6nng06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 23:34:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3y9f55RK46lc5dNbPqpGkwGNhG7e5Az8ZoutSuPYUzrj49NtaLAwHe69NCJt/nfzzx9WwnoIuhZMeLRdDZUAriX+jHgm+LcnpKOe17e+NhWJd+3LSK2CLzLdd+P54s0ss4+t451beAu7AZIO/lTzIaJahwhu0y9wXB0BLKr7qmDWBSa+06XAqTJ+zOioec/CAA0mrutYhjNUM/RVKSo4wUPViKGMRaJqXOOLDw1cFkywdULkJUT13AMKrhafr4n/7YUsZEuMwHizfh2rJApAAZLBXe4GSzfb3TzqgecEjlk4TzlDgfliAZYhNQjUX42acinvqv3qgVObr7r0Ynb4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVT29LI/JwU5tQQortDf++U3BmrS5pA6xhWck1VX/P4=;
 b=LShGAvM+ij4Z1qcAvJ6foyaTmoD+pz9Px9aiOCCzPYKa6IdHUN4J5/blImJF7wetvsZLQ1vinzqio4xw59exqL4RT5yd/tlxTAS0sJ0hZWLTC163Dgs1PjhrrXA70Qz6By86UL/RwuFQRIfRWKcZzJdJUNu/eMmoHOprOS3+tjKv3SJ7DaX3i0dj4KCXiOpLLGpz/HSjQ3eju45Iy6SDOdt0OCaE0F1u2cv7yv2rDG30lSPKKxRvb3duUS5TlhcPpEcIcE9CtIYwxtwn/JHoPD7votVBWPZmqrwtoHboMYqLy0IffhvRIHGS+V/eBRDQChXxsFvFeUVWOakIwNolfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVT29LI/JwU5tQQortDf++U3BmrS5pA6xhWck1VX/P4=;
 b=UxlgPMUqeniML7lOm50ZOMIbfzood8TrLD5Hsy9ZuBamsHPKfrm7iTxRJyRjrFm7AWcqbsFkbLciSFwiv/JaMwtTbqbMO/2AWVuhKiCQt9IDVlcRqPoXdHGgVmwZgOpopVxaMc9RgfRd82U4f60CzVjv7zlIi/t07BvwUbc0fz0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR10MB1357.namprd10.prod.outlook.com (2603:10b6:300:21::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Wed, 24 Aug
 2022 23:34:42 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%5]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 23:34:41 +0000
Date:   Wed, 24 Aug 2022 16:34:38 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mm/hugetlb: fix races when looking up a CONT-PTE
 size hugetlb page
Message-ID: <Ywa1jp/6naTmUh42@monkey>
References: <cover.1661240170.git.baolin.wang@linux.alibaba.com>
 <0e5d92da043d147a867f634b17acbcc97a7f0e64.1661240170.git.baolin.wang@linux.alibaba.com>
 <4c24b891-04ce-2608-79d2-a75dc236533f@redhat.com>
 <376d2e0a-d28a-984b-903c-1f6451b04a15@linux.alibaba.com>
 <7d4e7f47-30a5-3cc6-dc9f-aa89120847d8@redhat.com>
 <YwVo7xSO+VebkIfQ@monkey>
 <64669c0a-4a6e-f034-a15b-c4a8deea9e5d@linux.alibaba.com>
 <7ee73879-e402-9175-eae8-41471d80d59e@redhat.com>
 <f7544713-d856-0875-41dd-52a5c27ba015@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7544713-d856-0875-41dd-52a5c27ba015@linux.alibaba.com>
X-ClientProxiedBy: MW4PR04CA0370.namprd04.prod.outlook.com
 (2603:10b6:303:81::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ead195ed-3776-4b38-8910-08da86293768
X-MS-TrafficTypeDiagnostic: MWHPR10MB1357:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wsw1dfCo3qgoOgkqTNPtE6A7/bUaxJxO/aOs8dIUe4bJzOv1roOSSGD9JRJ/eerbGDyMsmKV3/v6yWtzG8ZLxIoY/tCLnrQI5k8l9Pvn7ecKe5XPG925LNyl+udyv17BugOLRvG+x+zggIF3WhI8wIGMeO5UB156Zl5WVA04t0hViuX/LvVwejsHR1iX+ZCFXSKptkg2SF6Y8j3tD5vQBq4gV0aTR53HGIVUwWh4gQDIFtcsjXChqS7VPdGkSPYTEG07aFnvOFTlEu2jl0EUcLMP4fmh1lfuSOJhxLFR/uhOR2D6tFCYSSzfR6ckcljgRE5LiFGC1/m0s66Y+K5+iyvE43RsQ52sdEWagFA2zLgH4DiTUViN7yWqaWNgSmCGrN/WGX3sz55EOhuuHUkvHjtTzNkyXcCuI7jQeK5y9SIUYzgSjtHCxsmFDsvL0rqMr5sM92VcEsbtNsFuKlJiflyVR/vRM3j7adu//+gF6byZ0B4rlld2zo0BzQMoeD9WnOxReZHKmLJS7GkCDYGajERPiw+ahNQe+ars73w9YKjpXV+saI/un/j2CB/jcjBvivIW8NuohmJHNo88dtKXCOwYDSJjaQy/K2DMbyXEgAgIYOMmlomMraZxhrlJZ6m8qyP3DKPILnPiG44+T13LTh0k8fHlKXj8E0+a87Fx1dOPZXnc9VqVGxF2FXc3zOYQibMg+gLcevyEKpn6ai2tWEBlxwc8ay+Kd+C02JbzRgSB07hpaMFycswuts5mCsZEEBKxx2rO35TbWJqTs9sLjPijew6SjKwRb/9KTPB9xyxVsQNE4JBQJpfnoRyw8KxsxRcNP8rMxLgh8lKoOkGopg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(39860400002)(346002)(136003)(376002)(366004)(2906002)(66476007)(186003)(33716001)(316002)(66946007)(8676002)(66556008)(5660300002)(30864003)(8936002)(44832011)(4326008)(110136005)(86362001)(6506007)(6512007)(9686003)(6666004)(26005)(53546011)(83380400001)(6486002)(966005)(41300700001)(38100700002)(478600001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU9pVUx4dUVROHlEMVJyVGVDQUt0TGZla2dxMFhkSlZZTCtZQnRiRGpiMkha?=
 =?utf-8?B?aVBiYUFTY3NsY2lhUTR4UHdjenMrK01aazRNT3pYYlBpMXQybGxOMjZycmxJ?=
 =?utf-8?B?eEpFNEp6NlRBTldsUmdXb0VaQ3BSQ2RlbXRibkZmWFhjY0RvcUhEMklETVNB?=
 =?utf-8?B?VWlWcGJDMlY4NU53b3pBQjk3aFhWVUxqY3Q0S21hdnVNQno5aXd4U3puaXBY?=
 =?utf-8?B?a1MxL3k5TjUwbk9RMWxPU2xsTG03cjJMZG5kWU16bkdIcUFjY1hOVWtBL04w?=
 =?utf-8?B?NFFSQUFxc3hqMGhib1hVRVZwYmx3MTZwaDkrcVByNGtmL3pKLzBuT0pPU1Vy?=
 =?utf-8?B?VDFIdGxxcnYyYjJQNnJFQlEwdnpPTWJSUjJEcG1MQTJUeUErNnEyQ1M4Z2pM?=
 =?utf-8?B?czBvREJhMUtyOExZemQ1OExEQjhvb1pMSFB1UDc4ZmRrM0JlQWxtYkxjSkN4?=
 =?utf-8?B?dGpPaFB1cGNGM0N1SVBNWVd5Tlp3aUZ0Q3dNbndhWTlTbDBoaDdGL2VHQWRv?=
 =?utf-8?B?bzBiUVp6RndEbUFtYWpWUDlSaHNSZVhWTzZ4b2gyUXA3Q3VyQzdSekk5L0N1?=
 =?utf-8?B?d2kvV0NGK3JGL2RkNXJZbHNiUE5veUVtTUVmbGJYamRlR1MzRzBCdzE3VlB3?=
 =?utf-8?B?QWQ1by85ZUdUSkh5RjBjMkpBMGJOWG1UUlQ1cFlkRG5obE9qc0Y4NTJnMlJ1?=
 =?utf-8?B?OEhES0VIZ1dSSFVSQmdiUzZSQ3duRDVoOWlnbUhxdUJzM2ZPOE9aSExDYjNS?=
 =?utf-8?B?VCszemZ3ampnU1FRZTNqTE1ER1dPS3BINGFUdjU2SFA4VVRiSzZtYU5OOVk1?=
 =?utf-8?B?elFxT2NrYjM0WC81REtvSVI0NUt1U2xKL1JpRDBQaCtJSVZvUk1UUXhObVBG?=
 =?utf-8?B?NHByaGp0NzU3am0yVFNWQmw2eXAyR0V3VzRaS3N3ZldFaDNlUmJBMksrZEp5?=
 =?utf-8?B?cTJaNG1Ia20yeXByenBZQlVoV2VoWktRTG93Y0tUeXVrM25mVUliRnRmOTNx?=
 =?utf-8?B?bEFqNWlzcmcwZnFwUUVNcy9BcHp0Z0dDR0hkVlNwb3p4NlA0dS90UzFKQjRy?=
 =?utf-8?B?VEEyaUVpZDZWM2lXU0thVEdOdUJUenJxL2Z6amZZSHFEZTdFaDVHR3poS0tX?=
 =?utf-8?B?ZEpUSDlGUDFxblRyVjltNVpWU09IR00zRG0xVkV4UXNJaTNxWUNEdGNiaXRi?=
 =?utf-8?B?ZC9ybDVyNjRmVHUwMTB4WGFmd1VmdllHNERJaDgrcTJGZ2ZpTW1VdFhqYnc3?=
 =?utf-8?B?bWlUd1RQcjBRblEzQTRIaUgzd1A0dmtySzZwK201MWFhSktQNE9wWW5mTWJx?=
 =?utf-8?B?SjBEZWxsdTg2QkRZR2VrWXRPUGp1dHpvWnFSMENZZkMvWmFQeGZ5SE5TQjdL?=
 =?utf-8?B?bUM5dzBDUHNScjdZNjJ3eDRyQ3JNRTg4MUlOWk9ZOHBTTnV6QXVDVDcvMmND?=
 =?utf-8?B?Z1RjeGFIaHpaMlJpbzZFY2lXUmJvQ2VubWQwV1ZOL3ZiemU4NmUrQTR3dmU4?=
 =?utf-8?B?NEJ1eGtKbU1pcmlHb0FCNy9Nd2ZXSTY1K0Vqdm1EUDZCUUo1RW5VTTU2VUt2?=
 =?utf-8?B?R1lsTENXMGIrNVloU0dMb2hjd1lrUm84WG9xSzFrTWtzZEorbnMybFZ1Tldh?=
 =?utf-8?B?QkdnN2txT29oMTY3R3dYbk4vQTdlSkUvLzhLaDBOMEJJYjBXQ0VmWC8rUERP?=
 =?utf-8?B?bSs1UWhiTXZSUHAyOGxNdngxRnpJdHFDWlQ1bjlHRFM3eE93R1ZyMmZsaEFh?=
 =?utf-8?B?RHl6R01uNjNBaUQ2WXphM293NlVSdWlrOWk3MjkrZzA2Qi9vYkRZNFpBVDdh?=
 =?utf-8?B?ekFRMDVEeGFxS3pob3MvdndBQlltSWJXZWtaVkg3YjUzVE5teXcvbjFMNmJa?=
 =?utf-8?B?WEFNNXlibm1XVVRvd1Jtd2JSSVFOcno0NkZrQXFaOVNoU0puTllQL2xld01K?=
 =?utf-8?B?dWNEUGxuSnlvamlVeGJyQzh6c1VpRXBwQ2lYZ1YyYitxa2YyYnl5QmZrT3Yw?=
 =?utf-8?B?emJFY1dHTWdvRUFYVFZBUEw5WnVxUytkR3pOYXBaMmcrNFpoVFVTWEdkZSti?=
 =?utf-8?B?S2g1VW9lSWhqdk54Yms3QjB5L1pmZ2dsc3ljNUVWL29TaEhlUnloeGdUSjd0?=
 =?utf-8?B?WjA5ZGpSdnJ4RG5sbDFjeVZYNzEzOURrZWdxWXA5Nk5KUTlPWVYzbjd2REVw?=
 =?utf-8?B?YlE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead195ed-3776-4b38-8910-08da86293768
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 23:34:41.9612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2cUMsYxtBRHqzVAzOoDJxexD1T+jolC0NbNJq0zSdai72pNWf9DaaxqXaBASID+pCHJhGafIJKMZmlK1nOfjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1357
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_15,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208240090
X-Proofpoint-ORIG-GUID: 1HDJycpswebXp4R078qgejlj4ZSS0mes
X-Proofpoint-GUID: 1HDJycpswebXp4R078qgejlj4ZSS0mes
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/24/22 17:41, Baolin Wang wrote:
> 
> 
> On 8/24/2022 3:31 PM, David Hildenbrand wrote:
> > > > > > 
> > > > > > IMHO, these follow_huge_xxx() functions are arch-specified at first and
> > > > > > were moved into the common hugetlb.c by commit 9e5fc74c3025 ("mm:
> > > > > > hugetlb: Copy general hugetlb code from x86 to mm"), and now there are
> > > > > > still some arch-specified follow_huge_xxx() definition, for example:
> > > > > > ia64: follow_huge_addr
> > > > > > powerpc: follow_huge_pd
> > > > > > s390: follow_huge_pud
> > > > > > 
> > > > > > What I mean is that follow_hugetlb_page() is a common and
> > > > > > not-arch-specified function, is it suitable to change it to be
> > > > > > arch-specified?
> > > > > > And thinking more, can we rename follow_hugetlb_page() as
> > > > > > hugetlb_page_faultin() and simplify it to only handle the page faults of
> > > > > > hugetlb like the faultin_page() for normal page? That means we can make
> > > > > > sure only follow_page_mask() can handle hugetlb.
> > > > > > 
> > > > 
> > > > Something like that might work, but you still have two page table walkers
> > > > for hugetlb.  I like David's idea (if I understand it correctly) of
> > > 
> > > What I mean is we may change the hugetlb handling like normal page:
> > > 1) use follow_page_mask() to look up a hugetlb firstly.
> > > 2) if can not get the hugetlb, then try to page fault by
> > > hugetlb_page_faultin().
> > > 3) if page fault successed, then retry to find hugetlb by
> > > follow_page_mask().
> > 
> > That implies putting more hugetlbfs special code into generic GUP,
> > turning it even more complicated. But of course, it depends on how the
> > end result looks like. My gut feeling was that hugetlb is better handled
> > in follow_hugetlb_page() separately (just like we do with a lot of other
> > page table walkers).
> 
> OK, fair enough.
> 
> > > 
> > > Just a rough thought, and I need more investigation for my idea and
> > > David's idea.
> > > 
> > > > using follow_hugetlb_page for both cases.  As noted, it will need to be
> > > > taught how to not trigger faults in the follow_page_mask case.
> > > 
> > > Anyway, I also agree we need some cleanup, and firstly I think we should
> > > cleanup these arch-specified follow_huge_xxx() on some architectures
> > > which are similar with the common ones. I will look into these.
> > 
> > There was a recent discussion on that, e.g.:
> > 
> > https://lkml.kernel.org/r/20220818135717.609eef8a@thinkpad
> 
> Thanks.
> 
> > 
> > > 
> > > However, considering cleanup may need more investigation and
> > > refactoring, now I prefer to make these bug-fix patches of this patchset
> > > into mainline firstly, which are suitable to backport to old version to
> > > fix potential race issues. Mike and David, how do you think? Could you
> > > help to review these patches? Thanks.
> > 
> > Patch #1 certainly add more special code just to handle another hugetlb
> > corner case (CONT pages), and maybe just making it all use
> > follow_hugetlb_page() would be even cleaner and less error prone.
> > 
> > I agree that locking is shaky, but I'm not sure if we really want to
> > backport this to stable trees:
> > 
> > https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > 
> > "It must fix a real bug that bothers people (not a, “This could be a
> > problem...” type thing)."
> > 
> > 
> > Do we actually have any instance of this being a real (and not a
> > theoretical) problem? If not, I'd rather clean it all up right away.
> 
> I think this is a real problem (not theoretical), and easy to write some
> code to show the issue. For example, suppose thread A is trying to look up a
> CONT-PTE size hugetlb page under the lock, however antoher thread B can
> migrate the CONT-PTE hugetlb page at the same time, which will cause thread
> A to get an incorrect page, if thread A want to do something for this
> incorrect page, error occurs.

Is the primary concern the locking?  If so, I am not sure we have an issue.
As mentioned in your commit message, current code will use
pte_offset_map_lock().  pte_offset_map_lock uses pte_lockptr, and pte_lockptr
will either be the mm wide lock or pmd_page lock.  To me, it seems that
either would provide correct synchronization for CONT-PTE entries.  Am I
missing something or misreading the code?

I started looking at code cleanup suggested by David.  Here is a quick
patch (not tested and likely containing errors) to see if this is a step
in the right direction.

I like it because we get rid of/combine all those follow_huge_p*d
routines.

From 35d117a707c1567ddf350554298697d40eace0d7 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Wed, 24 Aug 2022 15:59:15 -0700
Subject: [PATCH] hugetlb: call hugetlb_follow_page_mask for hugetlb pages in
 follow_page_mask

At the beginning of follow_page_mask, there currently is a call to
follow_huge_addr which 'may' handle hugetlb pages.  ia64 is the only
architecture which (incorrectly) provides a follow_huge_addr routine
that does not return error.  Instead, at each level of the page table a
check is made for a hugetlb entry.  If a hugetlb entry is found, a call
to a routine associated with that page table level such as
follow_huge_pmd is made.

All the follow_huge_p*d routines are basically the same.  In addition
huge page size can be derived from the vma, so we know where in the page
table a huge page would reside.  So, replace follow_huge_addr with a
new architecture independent routine which will provide the same
functionality as the follow_huge_p*d routines.  We can then eliminate
the p*d_huge checks in follow_page_mask page table walking as well as
the follow_huge_p*d routines themselves.

follow_page_mask still has is_hugepd hugetlb checks during page table
walking.  This is due to these checks and follow_huge_pd being
architecture specific.  These can be eliminated if
hugetlb_follow_page_mask can be overwritten by architectures (powerpc)
that need to do follow_huge_pd processing.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 arch/ia64/mm/hugetlbpage.c |  15 ----
 arch/s390/mm/hugetlbpage.c |  10 ---
 include/linux/hugetlb.h    |  41 +++-------
 mm/gup.c                   |  27 +------
 mm/hugetlb.c               | 159 ++++++++++++-------------------------
 5 files changed, 62 insertions(+), 190 deletions(-)

diff --git a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
index f993cb36c062..380d2f3966c9 100644
--- a/arch/ia64/mm/hugetlbpage.c
+++ b/arch/ia64/mm/hugetlbpage.c
@@ -91,21 +91,6 @@ int prepare_hugepage_range(struct file *file,
 	return 0;
 }
 
-struct page *follow_huge_addr(struct mm_struct *mm, unsigned long addr, int write)
-{
-	struct page *page;
-	pte_t *ptep;
-
-	if (REGION_NUMBER(addr) != RGN_HPAGE)
-		return ERR_PTR(-EINVAL);
-
-	ptep = huge_pte_offset(mm, addr, HPAGE_SIZE);
-	if (!ptep || pte_none(*ptep))
-		return NULL;
-	page = pte_page(*ptep);
-	page += ((addr & ~HPAGE_MASK) >> PAGE_SHIFT);
-	return page;
-}
 int pmd_huge(pmd_t pmd)
 {
 	return 0;
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index 10e51ef9c79a..c299a18273ff 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -237,16 +237,6 @@ int pud_huge(pud_t pud)
 	return pud_large(pud);
 }
 
-struct page *
-follow_huge_pud(struct mm_struct *mm, unsigned long address,
-		pud_t *pud, int flags)
-{
-	if (flags & FOLL_GET)
-		return NULL;
-
-	return pud_page(*pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
-}
-
 bool __init arch_hugetlb_valid_size(unsigned long size)
 {
 	if (MACHINE_HAS_EDAT1 && size == PMD_SIZE)
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3ec981a0d8b3..0c19d200c851 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -142,6 +142,8 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 			     unsigned long len);
 int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *,
 			    struct vm_area_struct *, struct vm_area_struct *);
+struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
+                              unsigned long address, unsigned int flags);
 long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
 			 struct page **, struct vm_area_struct **,
 			 unsigned long *, unsigned long *, long, unsigned int,
@@ -202,17 +204,9 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 				unsigned long addr, pte_t *ptep);
 void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 				unsigned long *start, unsigned long *end);
-struct page *follow_huge_addr(struct mm_struct *mm, unsigned long address,
-			      int write);
 struct page *follow_huge_pd(struct vm_area_struct *vma,
 			    unsigned long address, hugepd_t hpd,
 			    int flags, int pdshift);
-struct page *follow_huge_pmd(struct mm_struct *mm, unsigned long address,
-				pmd_t *pmd, int flags);
-struct page *follow_huge_pud(struct mm_struct *mm, unsigned long address,
-				pud_t *pud, int flags);
-struct page *follow_huge_pgd(struct mm_struct *mm, unsigned long address,
-			     pgd_t *pgd, int flags);
 
 int pmd_huge(pmd_t pmd);
 int pud_huge(pud_t pud);
@@ -257,6 +251,13 @@ static inline void adjust_range_if_pmd_sharing_possible(
 {
 }
 
+static inline struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
+                              unsigned long address, unsigned int flags)
+{
+	/* should never happen, but do not want to BUG */
+	return ERR_PTR(-EINVAL);
+}
+
 static inline long follow_hugetlb_page(struct mm_struct *mm,
 			struct vm_area_struct *vma, struct page **pages,
 			struct vm_area_struct **vmas, unsigned long *position,
@@ -267,12 +268,6 @@ static inline long follow_hugetlb_page(struct mm_struct *mm,
 	return 0;
 }
 
-static inline struct page *follow_huge_addr(struct mm_struct *mm,
-					unsigned long address, int write)
-{
-	return ERR_PTR(-EINVAL);
-}
-
 static inline int copy_hugetlb_page_range(struct mm_struct *dst,
 					  struct mm_struct *src,
 					  struct vm_area_struct *dst_vma,
@@ -312,24 +307,6 @@ static inline struct page *follow_huge_pd(struct vm_area_struct *vma,
 	return NULL;
 }
 
-static inline struct page *follow_huge_pmd(struct mm_struct *mm,
-				unsigned long address, pmd_t *pmd, int flags)
-{
-	return NULL;
-}
-
-static inline struct page *follow_huge_pud(struct mm_struct *mm,
-				unsigned long address, pud_t *pud, int flags)
-{
-	return NULL;
-}
-
-static inline struct page *follow_huge_pgd(struct mm_struct *mm,
-				unsigned long address, pgd_t *pgd, int flags)
-{
-	return NULL;
-}
-
 static inline int prepare_hugepage_range(struct file *file,
 				unsigned long addr, unsigned long len)
 {
diff --git a/mm/gup.c b/mm/gup.c
index 3b656b7e8a3c..a93c04437faa 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -661,12 +661,6 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 	pmdval = READ_ONCE(*pmd);
 	if (pmd_none(pmdval))
 		return no_page_table(vma, flags);
-	if (pmd_huge(pmdval) && is_vm_hugetlb_page(vma)) {
-		page = follow_huge_pmd(mm, address, pmd, flags);
-		if (page)
-			return page;
-		return no_page_table(vma, flags);
-	}
 	if (is_hugepd(__hugepd(pmd_val(pmdval)))) {
 		page = follow_huge_pd(vma, address,
 				      __hugepd(pmd_val(pmdval)), flags,
@@ -764,12 +758,6 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	pud = pud_offset(p4dp, address);
 	if (pud_none(*pud))
 		return no_page_table(vma, flags);
-	if (pud_huge(*pud) && is_vm_hugetlb_page(vma)) {
-		page = follow_huge_pud(mm, address, pud, flags);
-		if (page)
-			return page;
-		return no_page_table(vma, flags);
-	}
 	if (is_hugepd(__hugepd(pud_val(*pud)))) {
 		page = follow_huge_pd(vma, address,
 				      __hugepd(pud_val(*pud)), flags,
@@ -851,24 +839,15 @@ static struct page *follow_page_mask(struct vm_area_struct *vma,
 
 	ctx->page_mask = 0;
 
-	/* make this handle hugepd */
-	page = follow_huge_addr(mm, address, flags & FOLL_WRITE);
-	if (!IS_ERR(page)) {
-		WARN_ON_ONCE(flags & (FOLL_GET | FOLL_PIN));
-		return page;
-	}
+	/* hugetlb is special */
+	if (is_vm_hugetlb_page(vma))
+		return hugetlb_follow_page_mask(vma, address, flags);
 
 	pgd = pgd_offset(mm, address);
 
 	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
 		return no_page_table(vma, flags);
 
-	if (pgd_huge(*pgd)) {
-		page = follow_huge_pgd(mm, address, pgd, flags);
-		if (page)
-			return page;
-		return no_page_table(vma, flags);
-	}
 	if (is_hugepd(__hugepd(pgd_val(*pgd)))) {
 		page = follow_huge_pd(vma, address,
 				      __hugepd(pgd_val(*pgd)), flags,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6c00ba1dde32..947401df8190 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6168,6 +6168,56 @@ static inline bool __follow_hugetlb_must_fault(unsigned int flags, pte_t *pte,
 	return false;
 }
 
+struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
+				unsigned long address, unsigned int flags)
+{
+	struct hstate *h = hstate_vma(vma);
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long haddr = address & huge_page_mask(h);
+	struct page *page = NULL;
+	spinlock_t *ptl;
+	pte_t *pte, entry;
+
+	/*
+	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
+	 * follow_hugetlb_page().
+	 */
+	if (WARN_ON_ONCE(flags & FOLL_PIN))
+		return NULL;
+
+	pte = huge_pte_offset(mm, haddr, huge_page_size(h));
+	if (!pte)
+		return NULL;
+
+retry:
+	ptl = huge_pte_lock(h, mm, pte);
+	entry = huge_ptep_get(pte);
+	if (pte_present(entry)) {
+		page = pte_page(entry);
+		/*
+		 * try_grab_page() should always succeed here, because we hold
+		 * the ptl lock and have verified pte_present().
+		 */
+		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
+			page = NULL;
+			goto out;
+		}
+	} else {
+		if (is_hugetlb_entry_migration(entry)) {
+			spin_unlock(ptl);
+			__migration_entry_wait_huge(pte, ptl);
+			goto retry;
+		}
+		/*
+		 * hwpoisoned entry is treated as no_page_table in
+		 * follow_page_mask().
+		 */
+	}
+out:
+	spin_unlock(ptl);
+	return page;
+}
+
 long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			 struct page **pages, struct vm_area_struct **vmas,
 			 unsigned long *position, unsigned long *nr_pages,
@@ -6966,13 +7016,6 @@ __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
  * These functions are overwritable if your architecture needs its own
  * behavior.
  */
-struct page * __weak
-follow_huge_addr(struct mm_struct *mm, unsigned long address,
-			      int write)
-{
-	return ERR_PTR(-EINVAL);
-}
-
 struct page * __weak
 follow_huge_pd(struct vm_area_struct *vma,
 	       unsigned long address, hugepd_t hpd, int flags, int pdshift)
@@ -6981,108 +7024,6 @@ follow_huge_pd(struct vm_area_struct *vma,
 	return NULL;
 }
 
-struct page * __weak
-follow_huge_pmd(struct mm_struct *mm, unsigned long address,
-		pmd_t *pmd, int flags)
-{
-	struct page *page = NULL;
-	spinlock_t *ptl;
-	pte_t pte;
-
-	/*
-	 * FOLL_PIN is not supported for follow_page(). Ordinary GUP goes via
-	 * follow_hugetlb_page().
-	 */
-	if (WARN_ON_ONCE(flags & FOLL_PIN))
-		return NULL;
-
-retry:
-	ptl = pmd_lockptr(mm, pmd);
-	spin_lock(ptl);
-	/*
-	 * make sure that the address range covered by this pmd is not
-	 * unmapped from other threads.
-	 */
-	if (!pmd_huge(*pmd))
-		goto out;
-	pte = huge_ptep_get((pte_t *)pmd);
-	if (pte_present(pte)) {
-		page = pmd_page(*pmd) + ((address & ~PMD_MASK) >> PAGE_SHIFT);
-		/*
-		 * try_grab_page() should always succeed here, because: a) we
-		 * hold the pmd (ptl) lock, and b) we've just checked that the
-		 * huge pmd (head) page is present in the page tables. The ptl
-		 * prevents the head page and tail pages from being rearranged
-		 * in any way. So this page must be available at this point,
-		 * unless the page refcount overflowed:
-		 */
-		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
-			page = NULL;
-			goto out;
-		}
-	} else {
-		if (is_hugetlb_entry_migration(pte)) {
-			spin_unlock(ptl);
-			__migration_entry_wait_huge((pte_t *)pmd, ptl);
-			goto retry;
-		}
-		/*
-		 * hwpoisoned entry is treated as no_page_table in
-		 * follow_page_mask().
-		 */
-	}
-out:
-	spin_unlock(ptl);
-	return page;
-}
-
-struct page * __weak
-follow_huge_pud(struct mm_struct *mm, unsigned long address,
-		pud_t *pud, int flags)
-{
-	struct page *page = NULL;
-	spinlock_t *ptl;
-	pte_t pte;
-
-	if (WARN_ON_ONCE(flags & FOLL_PIN))
-		return NULL;
-
-retry:
-	ptl = huge_pte_lock(hstate_sizelog(PUD_SHIFT), mm, (pte_t *)pud);
-	if (!pud_huge(*pud))
-		goto out;
-	pte = huge_ptep_get((pte_t *)pud);
-	if (pte_present(pte)) {
-		page = pud_page(*pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
-		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
-			page = NULL;
-			goto out;
-		}
-	} else {
-		if (is_hugetlb_entry_migration(pte)) {
-			spin_unlock(ptl);
-			__migration_entry_wait(mm, (pte_t *)pud, ptl);
-			goto retry;
-		}
-		/*
-		 * hwpoisoned entry is treated as no_page_table in
-		 * follow_page_mask().
-		 */
-	}
-out:
-	spin_unlock(ptl);
-	return page;
-}
-
-struct page * __weak
-follow_huge_pgd(struct mm_struct *mm, unsigned long address, pgd_t *pgd, int flags)
-{
-	if (flags & (FOLL_GET | FOLL_PIN))
-		return NULL;
-
-	return pte_page(*(pte_t *)pgd) + ((address & ~PGDIR_MASK) >> PAGE_SHIFT);
-}
-
 int isolate_hugetlb(struct page *page, struct list_head *list)
 {
 	int ret = 0;
-- 
2.37.1

