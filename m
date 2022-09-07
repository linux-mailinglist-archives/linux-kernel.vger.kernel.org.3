Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7128E5AFAB3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 05:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiIGDg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 23:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIGDgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 23:36:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2643895D5;
        Tue,  6 Sep 2022 20:36:22 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2872x2tH030311;
        Wed, 7 Sep 2022 03:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=ulwUaFNwSuP9t5D5ta6/G+IItJ8t6oyxQ0/lnyTfKE0=;
 b=ggRfgf7Mc863rlGBfHJbPZuwVv3AJiGmnQq0Y3n0qdN5fu4oZqz2StzfWnzLj1ix/de5
 0hdl+kBeqnmpk86o7NK3wlZOT9rwtZhhdT2RZVSF2kXwdBn9wH+MNtfYY7vW/933zJMM
 pj/eZ95oVHlq/bi5Rc4jw5tGB7ZcwTbXjVW/goZt/fibkBXdJ7WBAxgS0z+yqdjv6X+z
 EyFx/9ijDputL2/ycJ9iWv+7nInLkl/153uueB5vubB2xsg+3v9uE7efeTUt6erKK+ai
 8TOs1rOQAHT3QLqvN8dENmW4439/5nF52PGcZ5Tl15Felrn4ea3DQ2zvuOSrwy3D4NXL Cw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxhsqmss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 03:31:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286NusdZ023626;
        Wed, 7 Sep 2022 03:31:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwca0h2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 03:31:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQWJuOaYzT8R991I8uVDCOLiK/jfjXsQnFyo79JI/iHP6xU+RJbKgpKJXM/J5hN5Ucil68RKbJVE9DK2ytKsSdaQju+V2x9qdAtyFa3EwmvadiZg4wgrBpPVGHQ3J++lPyk+RgU7z/3UtnHNQ9R8I06S+FJ/VN6jRT3hvfsMX9flE7eWLeGvlZvlxw1lM4DnBWxFeZ3Q9wGBGN0+471UlGYMvncozTtw5yeoAvanST6pGc+VRtjXk77sTwwUjKEyYrdIlcuaHxSU4vyPMIeuhYDMbIh1lXPCo4MJee5iV8RS4EBzqNs9jNlIWyOcKpzzdX62wAZhAOjRUZ5w/qxz8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulwUaFNwSuP9t5D5ta6/G+IItJ8t6oyxQ0/lnyTfKE0=;
 b=Zz0YIvl7K/0e9wlnfoksqWv0+wA+wLF7+x7fiVvuh0zV9K+CPYBJcJwwVvftd2oxArT0Z/vHc6XnLu19NCBubUq8RbTpkleycmHsgSMgfAiWVB+Qb9BYYMVEf3AT/7tX971ZWuEX5byLtrxxd5gII32PES3TxU5O48z5CviFPho2+FA5y+Co7O/CXQVJ2cRPAy5VVPcsp+OsfwdvuizzPTAW7wGrEQZv2HrluxI5yO3irUW8m7pD8qi683yiPToDE+58gw1koqjAa2IsPAfqaJktAgyAWbzwvM4p8wBNa3StVuA8P2h0OwvC9SP5JU/h1YQy4DLVXWWNNzt0CfFnWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulwUaFNwSuP9t5D5ta6/G+IItJ8t6oyxQ0/lnyTfKE0=;
 b=Jp/35D3AEAnhiFhadVDeMXO66yOJx9X6gLPOaM88QvToDGIP0NjIUBjcR1Mj5vlqZnIkA7MTVMrC1Sn3wc7dhd+rtIKBAXv25pQAhq3Y+r2qap2rnfdfWRq39WmbWz/u6mxM2/Z+Hu+p22ExoJr1Zp+nPLC20OuF/2YIZY5opU8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ1PR10MB5929.namprd10.prod.outlook.com (2603:10b6:a03:48c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 7 Sep
 2022 03:30:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 03:30:56 +0000
Date:   Tue, 6 Sep 2022 20:30:53 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sven Schnelle <svens@linux.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/8] hugetlb: handle truncate racing with page faults
Message-ID: <YxgQbSvDzQq7covC@monkey>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
 <20220824175757.20590-5-mike.kravetz@oracle.com>
 <yt9dr10ok3lm.fsf@linux.ibm.com>
 <Yxd5z0c8NlKVlVqk@monkey>
 <YxeL7ZMoyNmPAvY0@monkey>
 <YxfTA53/5pkpC7xZ@monkey>
 <367db2b5-5242-9be6-1d5f-d13e35f84167@huawei.com>
 <YxgD7qXPgkJ9VgJn@monkey>
 <25ffa1bf-0025-3421-53cb-79f986468cb6@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25ffa1bf-0025-3421-53cb-79f986468cb6@huawei.com>
X-ClientProxiedBy: BYAPR11CA0064.namprd11.prod.outlook.com
 (2603:10b6:a03:80::41) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 878481f4-ea63-4e8d-1fa5-08da9081601d
X-MS-TrafficTypeDiagnostic: SJ1PR10MB5929:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xqxchb4ae8Gf6qbg773zD876ohJmzHUo+XLBSB7kiAjL7AfqahOJWBYPwZkKJqkTMi37seHytLyzuBu2eK4Gv+nATU1qWrH9+g1DxVR0xvtWgRSDeMNcG46gwAWZoFTsyVv2WC4TdB0Tb1NDW8d3grSO/I45n6OoMVXc1mpQV1Km9gr2os+pCTVceSAXShY2Wi8jQbORe3MTKobvB9NthJe+qmxSFOwLXDgjWp+OqqMGKYz0kORXaKuJgthXVEsT9zq7krFML4z/PTthVmBi0gIULvlYaW/xa0VP2+U//Gvcj9ZyTf6Oz2kFjsZWl2t5I67j6AjhhpILScYzx6X89FALilVMZnpTJh0Li7RVjqPajNxd+dulNVWv9j3HRBxmhvqY+SYpAuvfIECzGEzvHBS3KYsEoS2fvqEDCaHT5Mvwj0GqRyoK5PxIltObS8i1B83kTsrXBwkJ7IUCPvzdGr7knXfEDS4pUPEN/MjEFLSmjlKDQM0EUM7dgkx9j+dOZn3RcbrtFMd1uNzLTPByJkkX8GLzjLE4ueMxd5ulhmWUTlaRf7hO8DZbQ5B+/SafBhqtDKzq40zogs0VTQ1K6vRwv2mTCRJ4QJZL0z1GAUdEtVKnhY51apNz+FcSVeN8gSzxW7mgiMX7HvyymROqU48X1xgS5RbPGMYsgq+YvBXFCXCv/4Y4aCelGHgh/AW47wkgSRY7y0GCxcL4vp4rqP4jnnYRkvc2G3Q+MtY8uVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(376002)(366004)(396003)(39860400002)(136003)(54906003)(186003)(66556008)(33716001)(8936002)(30864003)(41300700001)(83380400001)(6666004)(26005)(38100700002)(7416002)(4326008)(6506007)(5660300002)(66946007)(110136005)(8676002)(53546011)(86362001)(2906002)(478600001)(6512007)(9686003)(44832011)(966005)(316002)(6486002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RGHk+VpZkXfDl+EeazAmP9x1Zx88eQFofGk6jpY5I4rEy1H2Ib/vBvxIilnJ?=
 =?us-ascii?Q?3XaQ/Wou79MlX8oFQslz9CCdRNoArRXK2r2LiVWq4AAtcRF60g6M65OxeItl?=
 =?us-ascii?Q?C/5mSpFwrCjHvadff1x++XUcDN9IE3UrGIfMuVoM5Fa3Vmql9SJ9xLdBb7GL?=
 =?us-ascii?Q?3UHLtwSLZKWPaupYteBlGrqa9GhrU13OGwO0E8HNg7EiplXkWk9RReH10499?=
 =?us-ascii?Q?zh6BwRXmwrdwZcajG+hDEPv9avvo3bKxMqKmR+M9oT2xINiayTAp4Tk/t/nO?=
 =?us-ascii?Q?jbwb9JiCQIjo200wYB+iqaaGqK+hlQZOQZhWx0Rfno+RQp816+J5S3+TkPZZ?=
 =?us-ascii?Q?upAG9zvZmCSUARVECRcS+ptAMmpFGeVnL6G5zVRf86ger6jy0x6tH11HKhSz?=
 =?us-ascii?Q?5EAymbMwG4WDcORsfoqL98DfcHL+JQM+G8jZNIE3d6eJEOOfYmtTlJfbJP4t?=
 =?us-ascii?Q?RZdCZP0fQ4MXpPXklvj0pA9CPC+zOJFBjVkhOu34AgVLgbV+ODOdBZ79qPOz?=
 =?us-ascii?Q?WDB0eCvfu919jZzU9g55XlDZNcSdD66ZyYnn8TdhAT2d2Kn+/KRJp+EydvYJ?=
 =?us-ascii?Q?3SRReX0ZOIr7YJqgx2dBzSF66CDOH021wrwikDSxGY5TSMEoIHjrsFvS+py9?=
 =?us-ascii?Q?vCOA3cQr3EynR9CZ1AavneKkt0c+d79f85y8YleumJNBX8LfgxNbhGgsgbsc?=
 =?us-ascii?Q?lEkpNsAyq5Pnow6ySqHGJuqyK6+Ga8TTF+FGKKmlOQv6OcbIQFbJIChzBwtl?=
 =?us-ascii?Q?O7lCkkDupl03NsHjDL0K/zQWM8MGYYFANvX29mehWA4OjFE6GQXG8MROqUY7?=
 =?us-ascii?Q?NE+F6iAX93aWCVvXMSGMgX2GhwKEdRNc9q/q1hutOTI336eZ0l066bgfVT1+?=
 =?us-ascii?Q?CwFMu8LZgr5YqFBdmro1SfBx+BFVVL0iQwNpitZ0RqPTIVH44Wr32afXiA2b?=
 =?us-ascii?Q?EiGrJ10M5TH2N6Yi3+4/0Un44kQXv0rUdljG74VkH1SsOu1P0egK7xCnNSZS?=
 =?us-ascii?Q?qOQF4z2AB3yYNy2N+FdTZObsf2s3ggdZ0mTocbS1jJw2BGhU3poPMuIbRWKH?=
 =?us-ascii?Q?ycIKlha3xmAgFQ3Iind0Dfc+EmvhDUoRA0Wv2PSogd14RUq452kfGEFXfTcc?=
 =?us-ascii?Q?QfKmAZykDRuLyvlt2cmF5CntkokGTMwJ/un0UPIOHEWyxYrw5AT3OwLd/VBp?=
 =?us-ascii?Q?kSkNvSvrMPH+oJGiN2PYYDBlPN2bk/8e/2Rwc48UgAxTged0iFX7iqVieUVe?=
 =?us-ascii?Q?OBW2InEYoShxw3/aM/70pbYVYwi23lXsUDOHLyp6Z3sYD7YYkKSQJNdNlOvE?=
 =?us-ascii?Q?m4OHWsLzOyQpzLu0IEm4Qdz9no31X0KKKm+ZMqt3smEQfwOzdOBs5VHB2DBz?=
 =?us-ascii?Q?fx+Tdl4n+RCpSuRiwjGE1FHDXQk8gmNEVzzmU6cyKbM0SEPL23eXOjzhM/gm?=
 =?us-ascii?Q?6GDg7XwvtxeEp6kU9DjxWfQrnM02BKYtLTZZQS/ZNOt4/suxEj2W/tROhsZa?=
 =?us-ascii?Q?YNSff1H82v+OrYFxxiKWu08tJuz+eZ70dTBXSnX4YC/rqb1jDdrbnZvqMXfa?=
 =?us-ascii?Q?CyiY+XOvZD4T4Q6O3cAWzsLo+lZoFpI1/LURk9SUTg+vhhMGX76HHNqB+/jz?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 878481f4-ea63-4e8d-1fa5-08da9081601d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 03:30:56.6248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6IZo9I1nW1Dc5508eg61A+SHIdoEosG+cnRNyBGpqM4GQIw/YkseRnHBgPtt5b5vlFWrEen/TYF2hDNQGEmhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5929
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_02,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209070013
X-Proofpoint-GUID: LznpRRcp9CaApmpnG0I06PugA7YRZHaH
X-Proofpoint-ORIG-GUID: LznpRRcp9CaApmpnG0I06PugA7YRZHaH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/22 11:07, Miaohe Lin wrote:
> On 2022/9/7 10:37, Mike Kravetz wrote:
> > On 09/07/22 10:11, Miaohe Lin wrote:
> >> On 2022/9/7 7:08, Mike Kravetz wrote:
> >>> On 09/06/22 11:05, Mike Kravetz wrote:
> >>>> On 09/06/22 09:48, Mike Kravetz wrote:
> >>>>> On 09/06/22 15:57, Sven Schnelle wrote:
> >>>>>>
> >>>>>> With linux next starting from next-20220831 i see hangs with this
> >>>>>> patch applied while running the glibc test suite. The patch doesn't
> >>>>>> revert cleanly on top, so i checked out one commit before that one and
> >>>>>> with that revision everything works.
> >>>>>>
> >>>>>> It looks like the malloc test suite in glibc triggers this. I cannot
> >>>>>> identify a single test causing it, but instead the combination of
> >>>>>> multiple tests. Running the test suite on a single CPU works. Given the
> >>>>>> subject of the patch that's likely not a surprise.
> >>>>>>
> >>>>>> This is on s390, and the warning i get from RCU is:
> >>>>>>
> >>>>>> [ 1951.906997] rcu: INFO: rcu_sched self-detected stall on CPU
> >>>>>> [ 1951.907009] rcu:     60-....: (6000 ticks this GP) idle=968c/1/0x4000000000000000 softirq=43971/43972 fqs=2765
> >>>>>> [ 1951.907018]  (t=6000 jiffies g=116125 q=1008072 ncpus=64)
> >>>>>> [ 1951.907024] CPU: 60 PID: 1236661 Comm: ld64.so.1 Not tainted 6.0.0-rc3-next-20220901 #340
> >>>>>> [ 1951.907027] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
> >>>>>> [ 1951.907029] Krnl PSW : 0704e00180000000 00000000003d9042 (hugetlb_fault_mutex_hash+0x2a/0xd8)
> >>>>>> [ 1951.907044]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
> >>>>>> [ 1951.907095] Call Trace:
> >>>>>> [ 1951.907098]  [<00000000003d9042>] hugetlb_fault_mutex_hash+0x2a/0xd8
> >>>>>> [ 1951.907101] ([<00000000005845a6>] fault_lock_inode_indicies+0x8e/0x128)
> >>>>>> [ 1951.907107]  [<0000000000584876>] remove_inode_hugepages+0x236/0x280
> >>>>>> [ 1951.907109]  [<0000000000584a7c>] hugetlbfs_evict_inode+0x3c/0x60
> >>>>>> [ 1951.907111]  [<000000000044fe96>] evict+0xe6/0x1c0
> >>>>>> [ 1951.907116]  [<000000000044a608>] __dentry_kill+0x108/0x1e0
> >>>>>> [ 1951.907119]  [<000000000044ac64>] dentry_kill+0x6c/0x290
> >>>>>> [ 1951.907121]  [<000000000044afec>] dput+0x164/0x1c0
> >>>>>> [ 1951.907123]  [<000000000042a4d6>] __fput+0xee/0x290
> >>>>>> [ 1951.907127]  [<00000000001794a8>] task_work_run+0x88/0xe0
> >>>>>> [ 1951.907133]  [<00000000001f77a0>] exit_to_user_mode_prepare+0x1a0/0x1a8
> >>>>>> [ 1951.907137]  [<0000000000d0e42e>] __do_syscall+0x11e/0x200
> >>>>>> [ 1951.907142]  [<0000000000d1d392>] system_call+0x82/0xb0
> >>>>>> [ 1951.907145] Last Breaking-Event-Address:
> >>>>>> [ 1951.907146]  [<0000038001d839c0>] 0x38001d839c0
> >>>>>>
> >>>>>> One of the hanging test cases is usually malloc/tst-malloc-too-large-malloc-hugetlb2.
> >>>>>>
> >>>>>> Any thoughts?
> >>>>>
> >>>>> Thanks for the report, I will take a look.
> >>>>>
> >>>>> My first thought is that this fix may not be applied,
> >>>>> https://lore.kernel.org/linux-mm/Ywepr7C2X20ZvLdn@monkey/
> >>>>> However, I see that that is in next-20220831.
> >>>>>
> >>>>> Hopefully, this will recreate on x86.
> >>>>
> >>>> One additional thought ...
> >>>>
> >>>> With this patch, we will take the hugetlb fault mutex for EVERY index in the
> >>>> range being truncated or hole punched.  In the case of a very large file, that
> >>>> is no different than code today where we take the mutex when removing pages
> >>>> from the file.  What is different is taking the mutex for indices that are
> >>>> part of holes in the file.  Consider a very large file with only one page at
> >>>> the very large offset.  We would then take the mutex for each index in that
> >>>> very large hole.  Depending on the size of the hole, this could appear as a
> >>>> hang.
> >>>>
> >>>> For the above locking scheme to work, we need to take the mutex for indices
> >>>> in holes in case there would happen to be a racing page fault.  However, there
> >>>> are only a limited number of fault mutexes (it is a table).  So, we only really
> >>>> need to take at a maximum num_fault_mutexes mutexes.  We could keep track of
> >>>> these with a bitmap.
> >>>>
> >>>> I am not sure this is the issue you are seeing, but a test named
> >>>> tst-malloc-too-large-malloc-hugetlb2 may be doing this.
> >>>>
> >>>> In any case, I think this issue needs to be addressed before this series can
> >>>> move forward.
> >>>
> >>> Well, even if we address the issue of taking the same mutex multiple times,
> >>
> >> Can we change to take all the hugetlb fault mutex at the same time to ensure every possible
> >> future hugetlb page fault will see a truncated i_size? Then we could just drop all the hugetlb
> >> fault mutex before doing any heavy stuff? It seems hugetlb fault mutex could be dropped when
> >> new i_size is guaranteed to be visible for any future hugetlb page fault users?
> >> But I might miss something...
> > 
> > Yes, that is the general direction and would work well for truncation.  However,
> > the same routine remove_inode_hugepages is used for hole punch, and I am pretty
> > sure we want to take the fault mutex there as it can race with page faults.
> 
> Oh, sorry. I missed that case.
> 
> > 
> >>
> >>> this new synchronization scheme requires a folio lookup for EVERY index in
> >>> the truncated or hole punched range.  This can easily 'stall' a CPU if there
> >>
> >> If above thought holds, we could do batch folio lookup instead. Hopes my thought will help. ;)
> >>
> > 
> > Yes, I have some promising POC code with two batch lookups in case of holes.
> > Hope to send something soon.
> 
> That will be really nice. ;)
> 

Hi Sven,

Would you be willing to try the patch below in your environment?
It addresses the stall I can create with a file that has a VERY large hole.
In addition, it passes libhugetlbfs tests and has run for a while in my
truncate/page fault race stress test.  However, it is very early code.
It would be nice to see if it addresses the issue in your environment.


From 10c58195db9ed8aeff84c63ea2baf6c007651e42 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Tue, 6 Sep 2022 19:59:47 -0700
Subject: [PATCH] hugetlb: redo remove_inode_hugepages algorithm for racing
 page faults

Previously, remove_inode_hugepages would take the fault mutes for EVERY
index in a file and look for a folio.  This included holes in the file.
For very large sparse files, this could result in minutes(or more) or
kernel time.  Taking the fault mutex for every index is a requirement if
we want to use it for synchronization with page faults.

This patch adjusts the algorithm slightly to take large holes into
account.  It tracks which fault mutexes have been taken so that it will
not needlessly take the same mutex more than once.  Also, we skip
looking for folios in holes.  Instead, we make a second scan of the file
with a bulk lookup.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c    | 70 ++++++++++++++++++++++-------------------
 include/linux/hugetlb.h | 16 ++++++++++
 mm/hugetlb.c            | 48 ++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 32 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 2f1d6da1bafb..ce1eb6202179 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -578,37 +578,27 @@ static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
 
 /*
  * Take hugetlb fault mutex for a set of inode indicies.
- * Check for and remove any found folios.  Return the number of
- * any removed folios.
- *
  */
-static long fault_lock_inode_indicies(struct hstate *h,
+static void fault_lock_inode_indicies(struct hstate *h,
 					struct inode *inode,
 					struct address_space *mapping,
 					pgoff_t start, pgoff_t end,
-					bool truncate_op)
+					bool truncate_op,
+					struct hugetlb_fault_mutex_track *hfmt)
 {
-	struct folio *folio;
-	long freed = 0;
+	long holes = 0;
 	pgoff_t index;
 	u32 hash;
 
-	for (index = start; index < end; index++) {
+	for (index = start; index < end &&
+			    !hugetlb_fault_mutex_track_all_set(hfmt);
+			    index++) {
 		hash = hugetlb_fault_mutex_hash(mapping, index);
-		mutex_lock(&hugetlb_fault_mutex_table[hash]);
-
-		folio = filemap_get_folio(mapping, index);
-		if (folio) {
-			if (remove_inode_single_folio(h, inode, mapping, folio,
-							index, truncate_op))
-				freed++;
-			folio_put(folio);
-		}
-
-		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+		hugetlb_fault_mutex_track_lock(hfmt, hash, false);
+		hugetlb_fault_mutex_track_unlock(hfmt, hash, false);
+		holes++;
+		cond_resched();
 	}
-
-	return freed;
 }
 
 /*
@@ -656,7 +646,14 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 	long freed = 0;
 	u32 hash;
 	bool truncate_op = (lend == LLONG_MAX);
+	struct hugetlb_fault_mutex_track *hfmt;
+	bool rescan = true;
+	unsigned long holes;
 
+	hfmt = hugetlb_fault_mutex_track_alloc();
+
+rescan:
+	holes = 0;
 	folio_batch_init(&fbatch);
 	next = m_start = start;
 	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
@@ -665,36 +662,45 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 
 			index = folio->index;
 			/*
-			 * Take fault mutex for missing folios before index,
-			 * while checking folios that might have been added
-			 * due to a race with fault code.
+			 * Take fault mutex for missing folios before index
 			 */
-			freed += fault_lock_inode_indicies(h, inode, mapping,
-						m_start, index, truncate_op);
+			holes += (index - m_start);
+			if (rescan)	/* no need on second pass */
+				fault_lock_inode_indicies(h, inode, mapping,
+					m_start, index, truncate_op, hfmt);
 
 			/*
 			 * Remove folio that was part of folio_batch.
+			 * Force taking fault mutex.
 			 */
 			hash = hugetlb_fault_mutex_hash(mapping, index);
-			mutex_lock(&hugetlb_fault_mutex_table[hash]);
+			hugetlb_fault_mutex_track_lock(hfmt, hash, true);
 			if (remove_inode_single_folio(h, inode, mapping, folio,
 							index, truncate_op))
 				freed++;
-			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			hugetlb_fault_mutex_track_unlock(hfmt, hash, true);
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 
 	/*
-	 * Take fault mutex for missing folios at end of range while checking
-	 * for folios that might have been added due to a race with fault code.
+	 * Take fault mutex for missing folios at end of range
 	 */
-	freed += fault_lock_inode_indicies(h, inode, mapping, m_start, m_end,
-						truncate_op);
+	holes += (m_end - m_start);
+	if (rescan)
+		fault_lock_inode_indicies(h, inode, mapping, m_start, m_end,
+						truncate_op, hfmt);
+
+	if (holes && rescan) {
+		rescan = false;
+		goto rescan;	/* can happen at most once */
+	}
 
 	if (truncate_op)
 		(void)hugetlb_unreserve_pages(inode, start, LONG_MAX, freed);
+
+	hugetlb_fault_mutex_track_free(hfmt);
 }
 
 static void hugetlbfs_evict_inode(struct inode *inode)
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 852f911d676e..dc532d2e42d0 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -180,8 +180,24 @@ void putback_active_hugepage(struct page *page);
 void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason);
 void free_huge_page(struct page *page);
 void hugetlb_fix_reserve_counts(struct inode *inode);
+
 extern struct mutex *hugetlb_fault_mutex_table;
 u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx);
+struct hugetlb_fault_mutex_track {
+	bool all_set;
+	unsigned long *track_bits;
+};
+struct hugetlb_fault_mutex_track *hugetlb_fault_mutex_track_alloc(void);
+void hugetlb_fault_mutex_track_lock(struct hugetlb_fault_mutex_track *hfmt,
+				u32 hash, bool force);
+void hugetlb_fault_mutex_track_unlock(struct hugetlb_fault_mutex_track *hfmt,
+				u32 hash, bool force);
+static inline bool hugetlb_fault_mutex_track_all_set(
+				struct hugetlb_fault_mutex_track *hfmt)
+{
+	return hfmt->all_set;
+}
+void hugetlb_fault_mutex_track_free(struct hugetlb_fault_mutex_track *hfmt);
 
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pud_t *pud);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d0617d64d718..d9dfc4736928 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5788,6 +5788,54 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx)
 }
 #endif
 
+struct hugetlb_fault_mutex_track *hugetlb_fault_mutex_track_alloc(void)
+{
+	struct hugetlb_fault_mutex_track *hfmt;
+
+	hfmt = kmalloc(ALIGN(sizeof(struct hugetlb_fault_mutex_track),
+					sizeof(unsigned long)) +
+			sizeof(unsigned long) *
+					BITS_TO_LONGS(num_fault_mutexes),
+			GFP_KERNEL);
+	if (hfmt) {
+		hfmt->track_bits = (void *)hfmt +
+			ALIGN(sizeof(struct hugetlb_fault_mutex_track),
+					sizeof(unsigned long));
+
+		hfmt->all_set = false;
+		bitmap_zero(hfmt->track_bits, num_fault_mutexes);
+	}
+
+	return hfmt;
+}
+
+void hugetlb_fault_mutex_track_lock(struct hugetlb_fault_mutex_track *hfmt,
+				u32 hash, bool force)
+{
+	if (!hfmt || !test_bit((int)hash, hfmt->track_bits) || force) {
+		mutex_lock(&hugetlb_fault_mutex_table[hash]);
+		/* set bit when unlocking */
+	}
+}
+
+void hugetlb_fault_mutex_track_unlock(struct hugetlb_fault_mutex_track *hfmt,
+				u32 hash, bool force)
+{
+	if (!hfmt || !test_bit((int)hash, hfmt->track_bits) || force) {
+		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+		if (hfmt && !hfmt->all_set) {
+			set_bit((int)hash, hfmt->track_bits);
+			if (bitmap_full(hfmt->track_bits, num_fault_mutexes))
+				hfmt->all_set = true;
+		}
+	}
+}
+
+void hugetlb_fault_mutex_track_free(struct hugetlb_fault_mutex_track *hfmt)
+{
+	kfree(hfmt);
+}
+
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags)
 {
-- 
2.37.2

