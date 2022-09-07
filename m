Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C355AF9FF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 04:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiIGCi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 22:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiIGCiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 22:38:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2583495E55;
        Tue,  6 Sep 2022 19:38:19 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286LdtUQ016332;
        Wed, 7 Sep 2022 02:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=4GyS7WOAdAdfoPZhETd1uGmHWB7eGu+eJtnzcHmyzQw=;
 b=ACmXfsLmXj/GRPA0gPeyc+ffp0g6XDPE/yjb8QP9/SM97/o39/2i/AQP+3HswkfiJI3F
 oXvjaZLx3v3b/rb4Kv57zF+32xHxVNcH6yc0xrCVx89vpfhtaXCcpqYci3hvnre/SiCF
 zH1HjQPI6N60o6RS7yGYYD2EkwPl2R3AjerxxG9OnrgPMVCv+e7Yyvreb99KiyFLRW3i
 IzWob2vDzPePOf1YuqsDJ7pp/CNbDPVZjaEalnMusRwQOExWevgE4RJi7h0eD5feVtEm
 nw3uhxpYIH2pStPXOGnQB0yGo7VMCtaJuUUHQ0yTKlF7G5b00l6MVwCaQr/DD1rkKbIm PQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1fknx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 02:37:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28715kq4030614;
        Wed, 7 Sep 2022 02:37:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3qex4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 02:37:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/zK8IzKEe0LajaTr9MLY/EhLqvg/+Bk82su/cTK7cVvAR5pMLueg6Z+Bvrq8AYIhSgbbBnLt7yoHx3XUE0sFiGawsvz6u2ILbhhVYmDlB+OV2SJu7ZonBE6WhlMa3E0ocyiuI9kmNE6mw3NBvo9er+jgAzcqRkibjZAwJyN8pIVqPyhyRJgPUIpFrTr8WvzugGUyU/Vn06lDZerfr2Eutj6mdwFpAkmfmBQ+jS4RAcTdYmgIaW1U4Qxtnl5WFVOp1Zf8YffxYwUUDMiU58sOzLBS7obQQ1pVLJtkHMETHx05P5Rbo7i30FtfovvAB+1ytQzSCE9jTHnFiDOdzI+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GyS7WOAdAdfoPZhETd1uGmHWB7eGu+eJtnzcHmyzQw=;
 b=k0hhjylK2Rb49Cir7gAM1RzlanaD3MNADBQy4gLUGq5BpinQGdoOKDqSezMf9YRL2+Zl69Zu9aYaJHSrHgUjK8NyKdZzCB5qheBjfgKZvjqsJSSuAZpA4GSmfMP2/q/yB9DLR34Ag5TNRzKuBtcqcyEI5zDN3s3a2gqxTIjtkdPj8gDuNDKVCL0mXrCmbZlr8P0ynznMRzLV0UdirHdaUN3fKhj4qFkT6oRYDcSg0JTcwaIR+s/361gwKJEySMLVzholhgNGusJgWsTmKCsiiLDQOKm+q8z/SukY+P2WhdzaDzHQZLeIRgSWNujJYRz2NpCBvaW1ZC+JdfKnUg6JlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GyS7WOAdAdfoPZhETd1uGmHWB7eGu+eJtnzcHmyzQw=;
 b=coizIl2UGg5m7vYx89ZH4VyCn+SdVNbBb+k0brHi7Ln+l++fdtqZtuukAGYIDv2uRNB79EvAWyYUN05VfKCQRXzdvvqTEzfyoO0yYvXmmuiVAhTSXY8Mg2poYXcp/kmQnWVA3I6dnrbyHfwt+N1tueo9dRSdcyd2XrKByDxUPic=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB4187.namprd10.prod.outlook.com (2603:10b6:5:210::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Wed, 7 Sep
 2022 02:37:38 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 02:37:38 +0000
Date:   Tue, 6 Sep 2022 19:37:34 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
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
        Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/8] hugetlb: handle truncate racing with page faults
Message-ID: <YxgD7qXPgkJ9VgJn@monkey>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
 <20220824175757.20590-5-mike.kravetz@oracle.com>
 <yt9dr10ok3lm.fsf@linux.ibm.com>
 <Yxd5z0c8NlKVlVqk@monkey>
 <YxeL7ZMoyNmPAvY0@monkey>
 <YxfTA53/5pkpC7xZ@monkey>
 <367db2b5-5242-9be6-1d5f-d13e35f84167@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367db2b5-5242-9be6-1d5f-d13e35f84167@huawei.com>
X-ClientProxiedBy: MW4PR04CA0139.namprd04.prod.outlook.com
 (2603:10b6:303:84::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3795d24-edc2-47fd-0c40-08da9079edbf
X-MS-TrafficTypeDiagnostic: DM6PR10MB4187:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wtbpUV0OuI2Bry+N0tCQG+igjr+vp0itQ1NRHmcerXq6AW+7QRCoddUM0rnlfyClxrTSjLzlHyUz3xiFE/olt1PTWmyPZ3VddDj6ODyaSkdmsgskIEtUg9qCOZXdR/BiM8lHJmt/lLGCkELksYcRG9rLx8il+gx7Re5MJ+Y6Pr4oCiSHWchd66tw/y5FK0pR22R74rl/ja08UQDfsl10ckFllSohhCaP06n19W+qLn26JNLGJyKrUuEp4IIIdEhnd3bjyUDVQzMjBIzgoqKY8MSsY112hNDqwng/UA5X6LVk9P6PWo4+RPwWrYOzuPPu8ktaoNxgAcyplfjD9ETgtnNxSkLIAbqCZcRo1TL1kX47/FplvG8xCqNC4kaWteztNlcvy+OxtLJAVNC0c1pdM1Sr2C7/CvkeGlLV+RfN2dpQWB400nZSVLtGLI5j4E5FIP/YaDTedlcEQk5p6XDVqctq3GRCxvGvUtEP090zFVdeGIvtQkDL09LHfUssaOAAIZDGwXoAldizXehiI9rcYr0R2Ce8ISUUWAXcr60a127LxvqtSlI69bdgu9Demz9LwXyApGYTBnUMLyzMP6t9pe7T54OAFE/QwtLQRq1vMHEpDwoBFbqBJ7TiWFNVZAZDsvBwYCA9W/AyGvj3yE7LojQOzWMT3zCXySCHqiXcqnaek/X2PxtQnwLj8GVGTT7Aflm9TlKfxI/KoaY95JNOJblsHSm1pVvWwI50qUQwr40=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(136003)(346002)(39860400002)(376002)(9686003)(38100700002)(316002)(6506007)(6666004)(66556008)(6916009)(26005)(33716001)(66476007)(53546011)(4326008)(66946007)(86362001)(41300700001)(8676002)(54906003)(6512007)(8936002)(966005)(478600001)(83380400001)(7416002)(44832011)(6486002)(5660300002)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mjrqQ8qqc23kYki813pNfes33mRqHZWDEEh1KgaipvtpTEs2B3CToX/SjUPq?=
 =?us-ascii?Q?c3/8NZwyneWrCn0HZcMsYXMvzdPsxH9wIHNre4S14ha+LMYqjxiKyNeD35a6?=
 =?us-ascii?Q?V2oJAzZm1ym8XodNRrR6wE3oRlM1CSaJbU8Hdy0YtEgWnL4T6X5viFbBjgjn?=
 =?us-ascii?Q?SfoHBrcukgy+zYhC3LQlSijKNHu/TCokZLk9bXVJs8KIHU3orQQ47fBbpmKZ?=
 =?us-ascii?Q?AmEsxJtM6lYwLPoyCA25zKiuTh+28qhXW/+80Dt1+KTiZS95kJXRgSGibrFF?=
 =?us-ascii?Q?V0XHrD1PicV1Iu2jWTf7wWHLF5lsiu+3SpW1dPzykvV3lz/cpKaRNUacZc2Z?=
 =?us-ascii?Q?ux5mw96w9eyGWxnu+lMRdc868eW2P/SjTLOneX8d1MsvRnhg1qDmIUBBqqfE?=
 =?us-ascii?Q?8BYk8T83Z0F8VCVIHsmXF7tQkccoTfdLm26sbg4CeGJmRYmS6dcnlwJ8JJzy?=
 =?us-ascii?Q?o2aBXKRGMMDFdf4v324FW49239dgJ/OZq0kpR7Zc2RmA7SRx2iBgC3O0o2hN?=
 =?us-ascii?Q?/i6N8uN5xMPrLI/x8NuQJDvD5WvqyTUrdsx2E/1Ooy+GSVIEzYFU6/cXb9G8?=
 =?us-ascii?Q?HW0YwOHqEbtmxvmZTNuuaYBHMpQvsmiK+DNqXqidq+0jk3fspgl0f+YXILhc?=
 =?us-ascii?Q?SRHJmWcffjLwyv98RQzdi2qxqTok4WkxSXegyniiwaXRxLfbCIFeezriNP5D?=
 =?us-ascii?Q?MOwVPZqVZv+xB3fwdoLvP/zcodZeo2zXW5oK/0CqttEQ0Bj3Lcbkr50TEcL8?=
 =?us-ascii?Q?o/VuV486DkslLb3xTDd84tU6ENBUD0owtMeGPLFKLJv1JmS2BhTBccF17oG4?=
 =?us-ascii?Q?mrX3iAqyPwL0NPPokxMVxNeZeqAxCmPkCObzsFnvS0DLF8MTLRm7s1iSALU/?=
 =?us-ascii?Q?vW2gn0cvMuuaIIBM0Mkh5X1vI5utWvVzMHKa6muwuaaNWnlRGQjNOWsEKipQ?=
 =?us-ascii?Q?tMJYhcAfpLlrADe2KCCqlj2TdpjlEonIeorT578qY04KLY+pzQ6oG+6Fa/1+?=
 =?us-ascii?Q?B2ztpLMp43Dun8D7Qqv8pPLSNOVH8Kv/uGd3B7LecAblAiTIB20Ik6UBwhQm?=
 =?us-ascii?Q?3JaX+sG00pe3dnfx4XBteoS9szY4haBMA9ciE4CwP5dXmMAl8VLeKvB9x2qx?=
 =?us-ascii?Q?F7709ThcO15UJxtnNOr+FECdd9H0PD8m7VEGFTpgao/VwdYg9u6VIcq8/XRf?=
 =?us-ascii?Q?fTT5wYWRhuItKUsNJXkO3+McutZImJTgXN+KuMKZuNHIEs4oRVwfvgj6QIKx?=
 =?us-ascii?Q?xsXptXIQrE/ilCbp5qVZ9a7u3HU25lTywLl4PHxHxANLiipGUHAbvghDFFgi?=
 =?us-ascii?Q?iGBJUCcjWndzh3SIaAk3jL+Sw9ZhAD+kHxTB+3AwWFqa9ZBKSP+/CHr8EqH0?=
 =?us-ascii?Q?Ndq33SBO70xMmWtjH3ApiKISOKQbs+L4x6JkWTHeS0Wv9LcDGZScp6afujHr?=
 =?us-ascii?Q?E0PqbT45HoI4+uuKvMqt70VX3zqlaUxYv3njd1DAGQhbKT26pWFTWuKqoCNd?=
 =?us-ascii?Q?NEzwLerdDpyDoMLAS07qnKnqqfBkT8xuzhuCufJlIcSyd+vxIvrU/bICBTPx?=
 =?us-ascii?Q?bWxm0imHOH0JdaI2WHhkv5UnSGA2XNKKmEqnuDlz4J4t5fGdkMg+hYWQ9TQL?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3795d24-edc2-47fd-0c40-08da9079edbf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 02:37:38.3321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/FkBw0zEE7eoXs9NU5+McLwpqCLAvxizbvKDVmj4EOBIWTAhXsq7oA0AEsgr/Um1O2OLOD9g+/ElWub0rJnTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_11,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209070010
X-Proofpoint-GUID: q6Narz4ADe21C3e5WDN9KGhbHNl4cBsV
X-Proofpoint-ORIG-GUID: q6Narz4ADe21C3e5WDN9KGhbHNl4cBsV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/22 10:11, Miaohe Lin wrote:
> On 2022/9/7 7:08, Mike Kravetz wrote:
> > On 09/06/22 11:05, Mike Kravetz wrote:
> >> On 09/06/22 09:48, Mike Kravetz wrote:
> >>> On 09/06/22 15:57, Sven Schnelle wrote:
> >>>> Hi Mike,
> >>>>
> >>>> Mike Kravetz <mike.kravetz@oracle.com> writes:
> >>>>
> >>>>> When page fault code needs to allocate and instantiate a new hugetlb
> >>>>> page (huegtlb_no_page), it checks early to determine if the fault is
> >>>>> beyond i_size.  When discovered early, it is easy to abort the fault and
> >>>>> return an error.  However, it becomes much more difficult to handle when
> >>>>> discovered later after allocating the page and consuming reservations
> >>>>> and adding to the page cache.  Backing out changes in such instances
> >>>>> becomes difficult and error prone.
> >>>>>
> >>>>> Instead of trying to catch and backout all such races, use the hugetlb
> >>>>> fault mutex to handle truncate racing with page faults.  The most
> >>>>> significant change is modification of the routine remove_inode_hugepages
> >>>>> such that it will take the fault mutex for EVERY index in the truncated
> >>>>> range (or hole in the case of hole punch).  Since remove_inode_hugepages
> >>>>> is called in the truncate path after updating i_size, we can experience
> >>>>> races as follows.
> >>>>> - truncate code updates i_size and takes fault mutex before a racing
> >>>>>   fault.  After fault code takes mutex, it will notice fault beyond
> >>>>>   i_size and abort early.
> >>>>> - fault code obtains mutex, and truncate updates i_size after early
> >>>>>   checks in fault code.  fault code will add page beyond i_size.
> >>>>>   When truncate code takes mutex for page/index, it will remove the
> >>>>>   page.
> >>>>> - truncate updates i_size, but fault code obtains mutex first.  If
> >>>>>   fault code sees updated i_size it will abort early.  If fault code
> >>>>>   does not see updated i_size, it will add page beyond i_size and
> >>>>>   truncate code will remove page when it obtains fault mutex.
> >>>>>
> >>>>> Note, for performance reasons remove_inode_hugepages will still use
> >>>>> filemap_get_folios for bulk folio lookups.  For indicies not returned in
> >>>>> the bulk lookup, it will need to lookup individual folios to check for
> >>>>> races with page fault.
> >>>>>
> >>>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> >>>>> ---
> >>>>>  fs/hugetlbfs/inode.c | 184 +++++++++++++++++++++++++++++++------------
> >>>>>  mm/hugetlb.c         |  41 +++++-----
> >>>>>  2 files changed, 152 insertions(+), 73 deletions(-)
> >>>>
> >>>> With linux next starting from next-20220831 i see hangs with this
> >>>> patch applied while running the glibc test suite. The patch doesn't
> >>>> revert cleanly on top, so i checked out one commit before that one and
> >>>> with that revision everything works.
> >>>>
> >>>> It looks like the malloc test suite in glibc triggers this. I cannot
> >>>> identify a single test causing it, but instead the combination of
> >>>> multiple tests. Running the test suite on a single CPU works. Given the
> >>>> subject of the patch that's likely not a surprise.
> >>>>
> >>>> This is on s390, and the warning i get from RCU is:
> >>>>
> >>>> [ 1951.906997] rcu: INFO: rcu_sched self-detected stall on CPU
> >>>> [ 1951.907009] rcu:     60-....: (6000 ticks this GP) idle=968c/1/0x4000000000000000 softirq=43971/43972 fqs=2765
> >>>> [ 1951.907018]  (t=6000 jiffies g=116125 q=1008072 ncpus=64)
> >>>> [ 1951.907024] CPU: 60 PID: 1236661 Comm: ld64.so.1 Not tainted 6.0.0-rc3-next-20220901 #340
> >>>> [ 1951.907027] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
> >>>> [ 1951.907029] Krnl PSW : 0704e00180000000 00000000003d9042 (hugetlb_fault_mutex_hash+0x2a/0xd8)
> >>>> [ 1951.907044]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
> >>>> [ 1951.907095] Call Trace:
> >>>> [ 1951.907098]  [<00000000003d9042>] hugetlb_fault_mutex_hash+0x2a/0xd8
> >>>> [ 1951.907101] ([<00000000005845a6>] fault_lock_inode_indicies+0x8e/0x128)
> >>>> [ 1951.907107]  [<0000000000584876>] remove_inode_hugepages+0x236/0x280
> >>>> [ 1951.907109]  [<0000000000584a7c>] hugetlbfs_evict_inode+0x3c/0x60
> >>>> [ 1951.907111]  [<000000000044fe96>] evict+0xe6/0x1c0
> >>>> [ 1951.907116]  [<000000000044a608>] __dentry_kill+0x108/0x1e0
> >>>> [ 1951.907119]  [<000000000044ac64>] dentry_kill+0x6c/0x290
> >>>> [ 1951.907121]  [<000000000044afec>] dput+0x164/0x1c0
> >>>> [ 1951.907123]  [<000000000042a4d6>] __fput+0xee/0x290
> >>>> [ 1951.907127]  [<00000000001794a8>] task_work_run+0x88/0xe0
> >>>> [ 1951.907133]  [<00000000001f77a0>] exit_to_user_mode_prepare+0x1a0/0x1a8
> >>>> [ 1951.907137]  [<0000000000d0e42e>] __do_syscall+0x11e/0x200
> >>>> [ 1951.907142]  [<0000000000d1d392>] system_call+0x82/0xb0
> >>>> [ 1951.907145] Last Breaking-Event-Address:
> >>>> [ 1951.907146]  [<0000038001d839c0>] 0x38001d839c0
> >>>>
> >>>> One of the hanging test cases is usually malloc/tst-malloc-too-large-malloc-hugetlb2.
> >>>>
> >>>> Any thoughts?
> >>>
> >>> Thanks for the report, I will take a look.
> >>>
> >>> My first thought is that this fix may not be applied,
> >>> https://lore.kernel.org/linux-mm/Ywepr7C2X20ZvLdn@monkey/
> >>> However, I see that that is in next-20220831.
> >>>
> >>> Hopefully, this will recreate on x86.
> >>
> >> One additional thought ...
> >>
> >> With this patch, we will take the hugetlb fault mutex for EVERY index in the
> >> range being truncated or hole punched.  In the case of a very large file, that
> >> is no different than code today where we take the mutex when removing pages
> >> from the file.  What is different is taking the mutex for indices that are
> >> part of holes in the file.  Consider a very large file with only one page at
> >> the very large offset.  We would then take the mutex for each index in that
> >> very large hole.  Depending on the size of the hole, this could appear as a
> >> hang.
> >>
> >> For the above locking scheme to work, we need to take the mutex for indices
> >> in holes in case there would happen to be a racing page fault.  However, there
> >> are only a limited number of fault mutexes (it is a table).  So, we only really
> >> need to take at a maximum num_fault_mutexes mutexes.  We could keep track of
> >> these with a bitmap.
> >>
> >> I am not sure this is the issue you are seeing, but a test named
> >> tst-malloc-too-large-malloc-hugetlb2 may be doing this.
> >>
> >> In any case, I think this issue needs to be addressed before this series can
> >> move forward.
> > 
> > Well, even if we address the issue of taking the same mutex multiple times,
> 
> Can we change to take all the hugetlb fault mutex at the same time to ensure every possible
> future hugetlb page fault will see a truncated i_size? Then we could just drop all the hugetlb
> fault mutex before doing any heavy stuff? It seems hugetlb fault mutex could be dropped when
> new i_size is guaranteed to be visible for any future hugetlb page fault users?
> But I might miss something...

Yes, that is the general direction and would work well for truncation.  However,
the same routine remove_inode_hugepages is used for hole punch, and I am pretty
sure we want to take the fault mutex there as it can race with page faults.

> 
> > this new synchronization scheme requires a folio lookup for EVERY index in
> > the truncated or hole punched range.  This can easily 'stall' a CPU if there
> 
> If above thought holds, we could do batch folio lookup instead. Hopes my thought will help. ;)
> 

Yes, I have some promising POC code with two batch lookups in case of holes.
Hope to send something soon.
-- 
Mike Kravetz
