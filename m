Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D85158F500
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 01:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbiHJXzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 19:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbiHJXzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 19:55:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6A22613B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 16:55:38 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27ANsXXb019942;
        Wed, 10 Aug 2022 23:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=0JV4x+CvunV+Itn7xCp0m+J3nxds3i8L0QyN8fdJMKk=;
 b=fu0ORfqUk52Ixr2nvjtyavQPVjIavalBztoNTGviiVrybOQFX+yjkYLjHQ2/bGkS4tce
 XHXRRwzbNZx/Cres+JBvqYfSBzklywpxZglW0sYnPoCFVJcbDNVwqH7IaVVXM701lX8C
 WrjkXA1eQHYXhflA7Tr5wWfVCxX+Chir2mzH6RaQ4NqZHTblP20A6HSpAB9EMF7Rh7lN
 tGU3Jer9uVOn4n/FI0P5q4Vk+jResqcwSEyjY36D1Qo3P+c3H+hLU0+HwUcof4hDjLFB
 bIIDeeohyI92msXfxOKO169NhENe6TGPeqnFcAvM4Lr+UnKOHnEbFWmshbHV30E8HH3m Tw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqj3bga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 23:55:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27AMgLPI037065;
        Wed, 10 Aug 2022 23:55:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqj4r83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 23:55:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YB3MMJ64zdSbPdSumwGtykmZQ3/SEF3kmW+cRlJkBtrXhknZsdH8xP02RXQS4zewjWxm0szoVNjc8t+p/FmuPo86pEWRIk0uJSc6mGgGGpy/pPgcAFd97CaW4MIFuxBfpm5OCe/2RQaL+bisnz8lPAWGHLICR8gWlmokMs0vF1acZboAL6lsUtT7CJrj1LhJ69M7zN4TxlaYyoG8q39ZJE3HzrxF8/Rzo9QFrYoZHS1wdep1mGF/PeqiOI1W9E83A8BjcA5c46+UVAHbV0gMDOT6hokBc+xKg+VjeRjlQmLjXbbLvryK9IIAuGnVmJ5uHlScDCR/H2buIyfS9/TR4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JV4x+CvunV+Itn7xCp0m+J3nxds3i8L0QyN8fdJMKk=;
 b=j6lNlIaozsenVUCkB9HsPRg6Ff4ELeCjykJfrTQV/O+P8brnKSleVQmu5VXMG2gDND3WQE+J+sb/d2DOaAJum5phgXawLeFOKI5BMUzTT4+FFU66iXa+/tEcmxLl40lWLKuK/lrHDJmhrVoZDSWZ5iWKUMqShP5D2UIJwF4Y9Z3Nut+nbQMef87/7Fq4RFbKwWJkK4XuuZFJpst07MKOwzv7SCTt+EqixH67pu6ZGAV/T0M/fittfzQiEmPukQRYyfX5pFxGYInen9gQp3xfNJ/yB1+j8ZEA0XiXkMBT4qx/OUo4Bnx4Tzgyd3GSDoMYg6zJqSj0KhnDBMdzCn9LXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JV4x+CvunV+Itn7xCp0m+J3nxds3i8L0QyN8fdJMKk=;
 b=KKFlp1sXBR/+yXn6Yc8N0nuH4nGK2Fb8s1g7IrE1E08HZaMcm0XY/qfCN3ICOaLOJQpvQK4+krMLJPA3m286nzoQkGC1888xiFbH/7nGVSoNCHFNs//ubfMVbOSYJpS3r49CWv4gbU5ypd5crUuZrr4icmY2iJowUKhy4+evUiI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB3501.namprd10.prod.outlook.com (2603:10b6:208:11a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Wed, 10 Aug
 2022 23:55:26 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%5]) with mapi id 15.20.5504.020; Wed, 10 Aug 2022
 23:55:26 +0000
Date:   Wed, 10 Aug 2022 16:55:23 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Feiner <pfeiner@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v1 2/2] mm/hugetlb: support write-faults in shared
 mappings
Message-ID: <YvRFa5YF3BQNb0ME@monkey>
References: <Yu1dkZeBwv0SUQMq@xz-m1.local>
 <4f644ac5-c40b-32d4-3234-c1dac3d09f83@redhat.com>
 <YvE0OwsyQEL3K5Hm@xz-m1.local>
 <8b317ac7-f80e-4aab-4ad1-4e19a1a0740f@redhat.com>
 <YvFwU4e3WOSRseh6@xz-m1.local>
 <YvGJQaYeT9Y8PlDX@xz-m1.local>
 <12c65d91-5fc0-cb2e-c415-2b3447960b43@redhat.com>
 <YvQHKCylnFjgkFtw@xz-m1.local>
 <b3efd062-1548-cf80-dd1c-21f144887b9b@redhat.com>
 <YvQMhonK5cC4MXiQ@xz-m1.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvQMhonK5cC4MXiQ@xz-m1.local>
X-ClientProxiedBy: MW4PR04CA0265.namprd04.prod.outlook.com
 (2603:10b6:303:88::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c398306d-0c8c-4dd0-5bc0-08da7b2bcbf1
X-MS-TrafficTypeDiagnostic: MN2PR10MB3501:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yzyLB6f30X95VHdJ2DdiNWnlmyee8QWoTn4CftneSXfK6UlppYfT1WFOei5s0HB5bYUMCokoMX7p4QzxQa1Ck6OT4v8qIWouf3rm+yrJZseBYap+2huUgt6qiTMZ7NQ8dKj7yvY227AsbjIohvfAmplLf1SrS/dePozzvGGngxUVzV98p9bhBm7yyPsX6IJGvryIl+URMQOSyu6JTdbN2ZdcmbKk2pgWadOhBia2dfm6OxNqbg2C95fObT0ZE8ZQa/g1itXiqwu0HWPjsPOW4bvXmPCBECpHGrNQGVSARfz9ggWyFUTNotjb5CO+VCjpXzn5jYiG/i+DpIkmpkjbkE4JUR5Ct4lAfZNZKf4IOhwbjhCZll11+Vc3+Bz3vvSIZzVxoNp4FhizfxYvB6fB4ZCKKvF53FADFXMhV/prPmA5ZCHIIUNtt72YD8EOp/vXWQa4rYrUiJfMbHxu+mTZOelLgmx2PExMnZvZqoc4Cu7rXQ8Aj2SaZJZ4fwtBUt4fA90jmgP6+8yA1sev8eFvG7qFVtfYNDZXNXfjbO2++HeN3RWAiWKvILDmIdte3lKssSleBk6BfbkqsJsfDnhwfJF+ABpJTVylXXZCiAZXYreO1kkuIUsA0BgsWNbhEcaolpOzd6EdHwWiYBzeZ0SA7ZgQt5S9CLzCCMpHm3x+oQ5MWwXmHnfuBjimPo0vYBUfDXJZC2KFk8VBoFM1gGdue3wvG5UOlQKhQPEg3VCG6JRRF9Cj6aC1KvYkQV7mBm6q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(136003)(396003)(39860400002)(366004)(376002)(6512007)(26005)(53546011)(41300700001)(9686003)(6666004)(6506007)(38100700002)(2906002)(478600001)(5660300002)(6486002)(4326008)(8676002)(44832011)(8936002)(66476007)(66556008)(66946007)(86362001)(83380400001)(54906003)(6916009)(316002)(33716001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3HVppYCvuwPG1OIHSLy+GT/JUVx1bHP/IlwmaS0h04CjgmGwsidQzgC3ORYn?=
 =?us-ascii?Q?RuuA1qLb+B8FHDVaj+gdR2M+TxXPR6ol3Pu3Q4mOLsxL799NFGHKv1ULlfUo?=
 =?us-ascii?Q?+PlJDDr/8i4CP8PEZxqyEZV6WYR7P5+eep5pEWatfzw7zqgpyLJe9+cTU0ve?=
 =?us-ascii?Q?+hcSnpTph/aNURknxdwLW1pHALYnFKgyVw48cqkMFePqdurEMq1PFB9/C/nP?=
 =?us-ascii?Q?cSpqdSPuT5Fvm52jjNsq9kWxFsg6W9p6J/XkZplx4jceoySW81tiXk+lf+sK?=
 =?us-ascii?Q?ebhDfc1PhEb0NW8x05ZieBpiYBajpE8R5x39SNsWsYw372obdaqv4AwFGD5c?=
 =?us-ascii?Q?waUoRGSOvd2HbAgbcBdE88h9z+6ZKddbdj22rVC0S2eqVGBt57hz5z21MbpX?=
 =?us-ascii?Q?baDSfNeXlVww8SBgw7ZSRmwAvkCIBE1WhNhQjYlLjUck5E9oyo85jOWVkWg5?=
 =?us-ascii?Q?fbiDWAs3+NEMnvA1Saon2jF+GysqveqTmaxmazWRgO1X578G41vhmEY6aEio?=
 =?us-ascii?Q?PbUZSIVL9zzKlCJ2GDlu2cfJRc03FoiGPNCOKnbR96qBSi03FTNpY8FXb/98?=
 =?us-ascii?Q?pkggCXASOBPgUaumLvmqMUeLZANsIeeEcjWnuFllTEN19M/joiUhon7+83GN?=
 =?us-ascii?Q?aFAxO0DsuFpJECubrTXKZ3F+p5YOpN5PmtJrbevDzh+rnV0Km/EeeKPUj25R?=
 =?us-ascii?Q?uShlMMCSRoB72yy4HuYsYD927IJZnUxrZRs5IoUBXmKZ7E9ZRCYsemtvKZty?=
 =?us-ascii?Q?Mt6YbWAriDOyk/wssQ+PMjLVnajCwE95Z7jvLk6bxxA7qMsIIQr9I6L8lWU/?=
 =?us-ascii?Q?unCb5stVMwW3aHSVkVN+lGkYo0hr+xmJYigZm0+YTV0ixGZ+BAxNvRF0kbBm?=
 =?us-ascii?Q?gI5nF4o5kZWXiyodVH5jzx7qNa9ER9w7te3hOCNGZXHL1ISDoG4As3r5z/zh?=
 =?us-ascii?Q?tGWO3svMWUWezov4s2pARIORvXAXcYad4CdbP0Wjy3uImy5jarsluvpmPomI?=
 =?us-ascii?Q?S0oY7+nwRilnv7aS6XnoC5qlRSk/GH0iZprVJaZCcgE4bxyOfTTgsRn37ItJ?=
 =?us-ascii?Q?cumyhQ2/nE95am0hMHN3HMuZIYPRuffgEec8KrD5fWERdz6BdFtwfj7POtsR?=
 =?us-ascii?Q?6rh0Ry0miZ3r17VSKf9kYdOZIYjRmP8X4sKo080vzSGccWujnj1M1rzjXQkJ?=
 =?us-ascii?Q?khGtmKgblnXVTY74ovnNJ2+k++tAwZy1tGdv+uEAvjSxgYntrOAWeACNb7aK?=
 =?us-ascii?Q?sAFWagg5UlNMR+ty4IYCN901Q5gOq3Pcph1/pFJbtOwK8EoXY7UQ8q4CGR4f?=
 =?us-ascii?Q?AlxIIg67ska+MQOukVhIgbASHtBiT9vbXOdcVPrMrq4A4melloyB6fAxt3rg?=
 =?us-ascii?Q?8bUUqoYMDynbI8fKRAVqmDs97LbDcFlnETuR4oJNlZo+jGANQWMxR2f2dB3r?=
 =?us-ascii?Q?CzAuh70fURN8snjl3Qt3rkRLgbEVw9UVrQpWkyitwVg+7H7uen0Eg/XOgQj2?=
 =?us-ascii?Q?ELAmWUEdtUDQRm9DwopP7gF+Ldb6gpE0qUfzRclX+zeSEpoQl0nQI8Xoz2lB?=
 =?us-ascii?Q?SeekUTCKcHOu9pgU0CkNBhwDWrmV0pBSPdcLQGR1MvYKV0u0mT7AM4Jil/YI?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c398306d-0c8c-4dd0-5bc0-08da7b2bcbf1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 23:55:26.3311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFtf2YT+KZlQoUsqjSlB3xBxEZUsnhol/XnDVvKDjXFFNNfdX2hbOEVgQesU6pkxXo10pHjLaYxHzP4MVcV/hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3501
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_16,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100072
X-Proofpoint-ORIG-GUID: fF_nRGNGEDC8JAxhDnP6gGOl5k9jpQQj
X-Proofpoint-GUID: fF_nRGNGEDC8JAxhDnP6gGOl5k9jpQQj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/22 15:52, Peter Xu wrote:
> On Wed, Aug 10, 2022 at 09:40:11PM +0200, David Hildenbrand wrote:
> > On 10.08.22 21:29, Peter Xu wrote:
> > > On Wed, Aug 10, 2022 at 11:37:13AM +0200, David Hildenbrand wrote:
> > >> On 09.08.22 00:08, Peter Xu wrote:
> > >>> On Mon, Aug 08, 2022 at 04:21:39PM -0400, Peter Xu wrote:
> > >>>> On Mon, Aug 08, 2022 at 06:25:21PM +0200, David Hildenbrand wrote:
> > >>>>>>> Relying on VM_SHARED to detect MAP_PRIVATE vs. MAP_SHARED is
> > >>>>>>> unfortunately wrong.
> > >>>>>>>
> > >>>>>>> If you're curious, take a look at f83a275dbc5c ("mm: account for
> > >>>>>>> MAP_SHARED mappings using VM_MAYSHARE and not VM_SHARED in hugetlbfs")
> > >>>>>>> and mmap() code.
> > >>>>>>>
> > >>>>>>> Long story short: if the file is read-only, we only have VM_MAYSHARE but
> > >>>>>>> not VM_SHARED (and consequently also not VM_MAYWRITE).
> > >>>>>>
> > >>>>>> To ask in another way: if file is RO but mapped RW (mmap() will have
> > >>>>>> VM_SHARED cleared but VM_MAYSHARE set), then if we check VM_MAYSHARE here
> > >>>>>> won't we grant write bit errornously while we shouldn't? As the user
> > >>>>>> doesn't really have write permission to the file.
> > >>>>>
> > >>>>> Thus the VM_WRITE check. :)
> > >>>>>
> > >>>>> I wonder if we should just do it cleanly and introduce the maybe_mkwrite
> > >>>>> semantics here as well. Then there is no need for additional VM_WRITE
> > >>>>> checks and hugetlb will work just like !hugetlb.
> > >>>>
> > >>>> Hmm yeah I think the VM_MAYSHARE check is correct, since we'll need to fail
> > >>>> the cases where MAYSHARE && !SHARE - we used to silently let it pass.
> > >>>
> > >>> Sorry I think this is a wrong statement I made..  IIUC we'll fail correctly
> > >>> with/without the patch on any write to hugetlb RO regions.
> > >>>
> > >>> Then I just don't see a difference on checking VM_SHARED or VM_MAYSHARE
> > >>> here, it's just that VM_MAYSHARE check should work too like VM_SHARED so I
> > >>> don't see a problem.
> > >>>
> > >>> It also means I can't think of any valid case of having VM_WRITE when
> > >>> reaching here, then the WARN_ON_ONCE() is okay but maybe also redundant.
> > >>> Using maybe_mkwrite() seems misleading to me if FOLL_FORCE not ready for
> > >>> hugetlbfs after all.
> > >>>
> > >>
> > >> The main reason we'd have it would be to scream out lout and fail
> > >> gracefully if someone would -- for example -- use it for something like
> > >> FOLL_FORCE.
> > > 
> > > Having that WARN_ON_ONCE() is okay to me, but just to double check we're on
> > > the same page: why there's concern on using FOLL_FORCE? IIUC we're talking
> > > about shared mappings here, then no FOLL_FORCE possible at all?  IOW,
> > > "!is_cow_mapping()" should fail in check_vma_flags() already.
> > 
> > This code path also covers the anon case.
> 
> But this specific warning is under the VM_MAYSHARE if clause just added in
> this patch?
> 
> My understanding is any FOLL_FORCE will always constantly fail before this
> patch, and it should keep failing as usual and I don't see any case it'll
> be failing at the warn_on_once here.
> 
> So again, I'm fine with having the warning, but I just want to make sure
> what you want to capture is what you expected..
> 
> > > 
> > > The other thing is I'm wondering whether patch 2 should be postponed anyway
> > > so that we can wait for a full resolution of the problem from Mike.
> > 
> > To make the code more robust and avoid any other such surprises I prefer
> > to have this in rather earlier than later.
> > 
> > As the commit says "Let's add a safety net ..."
> 
> Sure, no strong opinion.  I'll leave that to Mike.  Thanks,
> 

Sorry that I am not contributing to this thread more.  Need to spend
some time educating myself on the relatively new semantics here.

As mentioned, softdirty is on my todo list but has been there for over a
year.  So, better to add a safety net until that code moves forward.

However, just for clarification.  The only way we KNOW of to encounter
these situations today via softdirty.  Patch 1 takes care of that.  This
patch catches any unknown ways we may get here.  Correct?  i.e. We don't
really expect to exercise these code paths.
-- 
Mike Kravetz
