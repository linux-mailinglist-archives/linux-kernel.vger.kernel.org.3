Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C915721F7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiGLRv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiGLRv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:51:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AA2B654F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:51:26 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CGcoD2027172;
        Tue, 12 Jul 2022 17:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=5QLbRv1dbvaYr6r7dJco5LFa0fKraGvu/PXktE1dGmY=;
 b=yq6EVJPA/lc2PttFYJT6Br1wGlkkEQ5JSWSwBvzf96l6vWeKurLOFs12N0HNxb4zVXYX
 wR/HBggxqdqrQiPBc2ZyISzYAbJcX5yJcJLUxWLWFvQgPQe6rzLJnnfUU2RyLYX4Dz6H
 Rw7pB1/R543Memn5lriRqagh+wFV2wyej1UuwVkrNmuIexVl7MpW6ytPtMURbUMiLFWQ
 6mrfGb5zQ8zIQAJbNpyFHE07DlW77+ueC3sObTA3vIksCeg+Yn3dPkY2ZEOUuq7JfG3V
 7KD7nkR8gWlFE1kGK7S8S6Wts72uqUMf9MCBySKFEOa6cc3+z+aWIal6mz6AW8FD7hNp yQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r17mc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 17:51:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CHjidw017617;
        Tue, 12 Jul 2022 17:51:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7043t1ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 17:51:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kl1KntCYO2KYUv2vp9fwlQ/NO9NLFf/6G/MeJdUUFeEBFyTFJ4SNLnd0ieWp+l/jZOKZ3Avv9MBYYACgVY7mmIueZ2XOfX4DATO3TnWCrV68E/kOebGLn2g4r4K211iPx9CbmiZfcy3f7cWb0DCFidVJTGTxOppDGWhLkzZY9gfGJCgo8CEJJPlR1a0PuwMIRlYwTKXWGVze0CRwCxKoaZVFHWOzSc4m2Q0JpyH5uxtzysKK6XmgkR0HXcJ9hRZbZXP9sO+PnIfJT6g5rf7BkmQV+JnTVv2mNEjJjRotswV1RowSpTMeJk4RhDAjZMkua/R2fcSFLy/wq4hjMXgURw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QLbRv1dbvaYr6r7dJco5LFa0fKraGvu/PXktE1dGmY=;
 b=Ot6Hf1U3GcI58A7xeLoUO6fNRtNKFwFJL7lxtTbDDDiJbCmYjYWErofo4bK6WEdU+d7diKdlv5ZMyEJMSg6wYbkPgSJKEQVjigASFkm2b+w+rQCW9pc86hAXmSYb9/UuLPJNlwh3AcRwN1A7HSrPfbpoPHIZdgjN7ITVIxVHGM62qK8kcGM3aYz6gc46xScgzDQAIyZmkFZ62Z/BAAMdHX8AZbcftlt2OyAOCR9NwtO2gHojwjhedpKKDKDX+yqHpNbrO/xszWubiWCYfD0ub0MjIkUi7JWV3nqyrFEPSaJzQsutj/7XrJU03Ocbnd5+5s/EEmdqfVQ3F9ONNCV7XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QLbRv1dbvaYr6r7dJco5LFa0fKraGvu/PXktE1dGmY=;
 b=yHaXRX/uVdaM4nF1S36SGiaZoVECSSrjZXu+TV7tPfGk8j6wYffArDT6TSQJG1DGw9t2/fnIQManXBx3MHNoYL7ASJgjOwsip25yDJshCvf9+A4ZcFBmgbNJ+sJBh0T2DG5bQ8luBIUEZdw4RZCOSvZANKA07D6sydUZmHU70C0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN6PR10MB2832.namprd10.prod.outlook.com (2603:10b6:805:d8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 17:51:08 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 17:51:08 +0000
Date:   Tue, 12 Jul 2022 10:51:06 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     James Houghton <jthoughton@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/26] hugetlb: add hugetlb_pte to track HugeTLB page
 table entries
Message-ID: <Ys20iusvF1An6BLs@monkey>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-8-jthoughton@google.com>
 <YsyzGMS+MS0kZoP8@monkey>
 <Ys1B+fXo2uSPd46B@work-vm>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys1B+fXo2uSPd46B@work-vm>
X-ClientProxiedBy: MW4PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:303:16d::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d6f3035-d0b2-409b-f1ad-08da642f19e5
X-MS-TrafficTypeDiagnostic: SN6PR10MB2832:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E0FX9Vhfqq/nYx7ZSKFsgjPPXGEursn6oh1u5xCtss6WFsTH3BjzyjtUzB2In4d08pZVJNE7bNqCbtGY6rOfd+tluTSgH8uFGOdeElACqjnrwBW6bh8BEWQI7unb6jgziDBV+tgk/ciur8h6+nAUFeClU8fptI6YqzB09nQKt+oQz9D5UDVlApBpabNKLUmZcPkZi6kAynd0slis0Lu/LFOD6JFpWA6PAvSCOurrWZ0iYghr93OlbDlAnU996zECQ0ze6Ub1+I27g3EtFB4ay//Evkevl++fwhyWcCQYo2JIXTsvwnWuPq6CuZUHFXfQCZENwhyQuIimCe0tcaCTjyVon1Pp1+GuEbKm3cwnricueJo2OjWzRm35Pq8jjW0o9ne6nt0Xu9oV/a+oHYO2Ht8ylm3uctNYk+cLY0gnWz1FH+t1EAPR4nu7e9zphoqTjoW/TpJwJ7jTksZzqqHuppZLUybzPoqGZgACQY9b+bdvaqtIDP9kE3XHvOntL4vEyCyiP40tzq0bVGc3Tl0Ztc5o/Wk52W99V1tByUPj3mNe47K8LtOnPSidNQGjGWfGGfZyFKEO2tgdP6Bqe05kcbXP8WwA8QCcUr2u9ZtJWwdetY0ov8QFxSji4MISIE1Wz+VWiLw3Ub+1wvXlThwBaCgPLvNaG+AMp6ynKbF0KjrzBQP/ng51zpS0DQC6pc0d4RjXfaz0Vx9G38i+s8CY/9cAZ5YOC9UMqYaL9AXwT23Q0OOnoB24Gy5IhznSjrvq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(366004)(376002)(346002)(136003)(39860400002)(186003)(33716001)(478600001)(66556008)(38100700002)(66476007)(66946007)(8936002)(6506007)(2906002)(53546011)(6486002)(54906003)(6512007)(41300700001)(7416002)(8676002)(5660300002)(9686003)(26005)(86362001)(6916009)(44832011)(316002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dSuBmNDnZ39BWD+eScz+af7af5dZV0uZbVFODL+BsTdIedaRt9ki69k2/xBD?=
 =?us-ascii?Q?SevlqEsn5DdrOU5+cNUp4n7AbyBMzarwQnVWxZ3qw4IHWYzuHTKNrsBNBgRr?=
 =?us-ascii?Q?rCY8v49uXs11FP3qp8Um6Jy2zzZmEgnxMmJpYVuTqkqbmglrRxzAgys0jkBF?=
 =?us-ascii?Q?9vrJDuH9/NM5g1k2NZdD4sWwUw/XcxZQg+XlHzW+8KoOtyr0Xn/YFzXuCcvJ?=
 =?us-ascii?Q?g5TPPxvpxgf8OgD5iBznO9xQyxU0Aahz9MvgXfdckfHMwqIeYVkodf0XVZLC?=
 =?us-ascii?Q?wVteCxe6XiTkwV4LVTvrjsFLwjG/sAfqnw2tRPhqsaurL4FjaZbPCYs8+R72?=
 =?us-ascii?Q?z381OsbKvI3vCXLWrL3wGxlotFMF3zvLEx4LxlcU3lXVKbKcfiBtAO5UllR6?=
 =?us-ascii?Q?0knZw7+ocx8ElD+hd7rscJA4tEt+gLUNqkEgN97R4E0mSdYxxoiy2pU4hr8e?=
 =?us-ascii?Q?prm785YoyhzsRucl/TIxmnQBTQAKiuwIEzuF4wNLHXC3FRUOWBDkITw2GLRg?=
 =?us-ascii?Q?YCDRFBeVyCzpS4TDcPRE81dj4b7/hxDBsPS/vVE88tZXhndMW8o/OZjNIXGC?=
 =?us-ascii?Q?L41lMz9OFI0+oyAQ2AbwrlM/xFMp3vhKGEkbmqyySHmCkQ9wX2QjuSPvS8bg?=
 =?us-ascii?Q?V8k1ee9Kw0zSBFh1j3OTPiIibVMPNDvq0ihmHIW2SYq5kIAwxlbtSaZtdQk+?=
 =?us-ascii?Q?Jyh3n2ERUWXn+tFuPasP4wTzhOj9SImuNjkTbIF69Mv6aLfAht2YlasGJApY?=
 =?us-ascii?Q?7Zswy3XcXFlmdq3fkgNNIlE/GMC+pLPB+PqCuYN5yE0dB6T5m+zxj+Y7QGpm?=
 =?us-ascii?Q?TDb3okFq9oaproewELGYhKD42OaZhS+GMPd5hbkFLn7jgGmAlPoe70WIV4vH?=
 =?us-ascii?Q?G9DISIbmNZhfO71oNZHo1CL/I8EjzmTJXEL1sVxnRtSF31tvbxiUvZ+nLcxc?=
 =?us-ascii?Q?DeR/5g5lKNiQZbFEp5hHZ1Y6McLsKT5O+rkv01Rxs0ZNJKxBnP6lmCqMNd4E?=
 =?us-ascii?Q?uBom+uh9MsdViJoCaG8xhUWiml5QCVoF+oQe/UahWlpf1/QChNrtnOhFXoy8?=
 =?us-ascii?Q?pg5/9lJiUSsc1mHkjz1KffOulOwuBtVg9BLfZSTV+3XhweP1EMiSIdK4zVzZ?=
 =?us-ascii?Q?3cEMKF8pwxpcH+eg2I18+1F79zFb5AJ4nwPoWXZXc/+Nww2NNP/v0ZL11fBa?=
 =?us-ascii?Q?eY5Kc+LNwgnPO5sPMXsJTEtBgp3Q7uB903yypeIvZcJoA5DjXc9RSt/LXDeN?=
 =?us-ascii?Q?VdXV9+VkgnIUyUA7wNIjaXL/MDc8xXV3ciWZScSDnL2iYQPxXdIxi1m++zQ3?=
 =?us-ascii?Q?P5qLDUOW2CgTNqB6Wn1IfhYPq5h63GxaSmRidSZYlhrDoUoo3L5Ebl1LO+L/?=
 =?us-ascii?Q?NC1L+aWSmqOWl5Q2YoylRn+XnSK0HVAH3KKKvGa2pjT3IvTGl1sksaHuCI8j?=
 =?us-ascii?Q?vyKLu1k2YVUMkVuc4X2oZH5BRL++cO9nReZ9WSAL0DS32dM6tltMoZin5Tt6?=
 =?us-ascii?Q?4bVAq9LKC9fIzOFocBvYQujkVNlruFQc6eL2dgNKz3/DmENcBPGYWQaTUBGO?=
 =?us-ascii?Q?Yd35gWPWkLXaH1ieKaZCkgw1WH3LVEtsXZoWgK0c8bDWJoris7lbQtJm1yYI?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6f3035-d0b2-409b-f1ad-08da642f19e5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 17:51:08.8649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+HtlVt8Ma+560z1guLma8HXpoHW9gv0NmbgY33kythX86QeNVnYssn2w9lwkIU9XIXlvWA5AjIxXy0bkloYYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2832
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_12:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120071
X-Proofpoint-ORIG-GUID: zQf2yuDN7MUI2GCTtbeHlW7aLIU2Q_vi
X-Proofpoint-GUID: zQf2yuDN7MUI2GCTtbeHlW7aLIU2Q_vi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/22 10:42, Dr. David Alan Gilbert wrote:
> * Mike Kravetz (mike.kravetz@oracle.com) wrote:
> > On 06/24/22 17:36, James Houghton wrote:
> > > After high-granularity mapping, page table entries for HugeTLB pages can
> > > be of any size/type. (For example, we can have a 1G page mapped with a
> > > mix of PMDs and PTEs.) This struct is to help keep track of a HugeTLB
> > > PTE after we have done a page table walk.
> > 
> > This has been rolling around in my head.
> > 
> > Will this first use case (live migration) actually make use of this
> > 'mixed mapping' model where hugetlb pages could be mapped at the PUD,
> > PMD and PTE level all within the same vma?  I only understand the use
> > case from a high level.  But, it seems that we would want to only want
> > to migrate PTE (or PMD) sized pages and not necessarily a mix.
> 
> I suspect we would pick one size and use that size for all transfers
> when in postcopy; not sure if there are any side cases though.
> 
> > The only reason I ask is because the code might be much simpler if all
> > mappings within a vma were of the same size.  Of course, the
> > performance/latency of converting a large mapping may be prohibitively
> > expensive.
> 
> Imagine we're migrating a few TB VM, backed by 1GB hugepages, I'm guessing it
> would be nice to clean up the PTE/PMDs for split 1GB pages as they're
> completed rather than having thousands of them for the whole VM.
> (I'm not sure if that is already doable)

Seems that would be doable by calling MADV_COLLAPSE for 1GB pages as
they are completed.

Thanks for information on post copy.
-- 
Mike Kravetz
