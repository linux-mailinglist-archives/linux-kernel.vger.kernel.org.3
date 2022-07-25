Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BD158040E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 20:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbiGYSfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 14:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiGYSfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:35:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEE7BE35
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 11:35:18 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PHwkYL003181;
        Mon, 25 Jul 2022 18:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=y3u50ZhlF53N+uWd/lCFUTJHELHjDO1Z5bpWbxLnzgU=;
 b=mxGZhmY/v5XP+D8Nt6QlfBIa+VIzp4nxtl77IO/nVlsj1YyKzPjUy1a62JP31+z98sAB
 hwB1oUULjXoKbrbzBWOBkgKok17rp8zVpFSqvvmp0LoCwtH7W6beAtymhFQOL0AERle8
 7esp3bZnmq0a8tDNwbviybsxNCyFnj+9GXoP0yjMAnz429uCSs6YMUlVotkoNRh0tuOR
 vi75VgL/V1eFw6AgDXAEXu5TzUe+xuqNi1IAsHcRMPrQr5rqC6On3RadpYA5j6Qo5irp
 SlDSJxjU/53+Y9WbuQev7PLayL10dqtlIbXyIkJ65A2MpKtY8Et7i9Ke0I+zVcyTnMJi 8Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940m725-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 18:35:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26PHbjH8019846;
        Mon, 25 Jul 2022 18:35:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh636v4bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 18:35:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4Z4Nrsj/FsLMxnHP0xWfo57GkQ1NgxDE1erx50tzjhEPiw7HudVrpHFjQ6d1uTbkQwyhpLS6nTyeXz4hPfsC9rb2jzjUA+jAALxdTnGXnHJ2lJ4GwbI8IuC+CinXyTvm/wBly2QGVnQmaKNxapO44Gx1mEBX2tQVe/PRUcKC+UTbhm56fnowZrT4vHAOvscYQkwLuTkHsvhvIHItVg0tjs68dgODUvE16Ja1gU6ATVF1X3NbOYHCTXLjkZPU+k/nTRFCgnfUO6iWaTbhxeRSsVCYMd7HYsFsytlYnadk70HK90YU4cL3SHK/YL4z+h81qDYvUW/1v8EWYSEnrchIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3u50ZhlF53N+uWd/lCFUTJHELHjDO1Z5bpWbxLnzgU=;
 b=XioODZvM+ZQodyCVnI9qLvFf+DHAfBukCeTdlRO6P5hbVPxTabYpqHKqpl2MArRxsfKwJLdA2ZAXGCyO0uwTdAPkPFhA24oc7f2TVNYdU7H7+aMgylQboziGQs4macM8B8w2yTonqAAKIBZXtvZLXt7OtB9qoFTSoxv+hVhE7ox8hnBgzQ8HqMGpFxGiL2nGzxzZtVjvSQ0yDLYqtVAE3nVzncXLKxW3RFb0l/DrxwsUFDql+RF6VOWT8G4Y0nEbCXnEQ21EqUjwGiBFMmrkK2BYPUsymtZoood7MQCvgFA9Mlqcmxiy4C6vYZqzJzUkBcD2LEE7a0WBpTEwQyn4HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3u50ZhlF53N+uWd/lCFUTJHELHjDO1Z5bpWbxLnzgU=;
 b=T7VMxRENj1j93vxR0+q2rKgRJ2z26tSKZvaXmVAS0zpZ7bicNhC9allApXJDiEgqDosnIrBBb1i6dCEM/JC4H2x0DGH1GaUgWD0RPLTh+YywaX7yjGoTN5F+gvFeidKWooAklb49snlf+rVBuDjhMMMngGklq05l8uSpIwsgxfU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4648.namprd10.prod.outlook.com (2603:10b6:510:30::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 18:35:03 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 18:35:03 +0000
Date:   Mon, 25 Jul 2022 11:35:01 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [bug report] mm/hugetlb: possible data leak with huge pmd sharing
Message-ID: <Yt7iVRaDGuIx8LVE@monkey>
References: <025b3ea6-4b26-f091-5464-0eef5aac7719@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <025b3ea6-4b26-f091-5464-0eef5aac7719@huawei.com>
X-ClientProxiedBy: MW4PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:303:6a::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38b7f9f5-905c-4fe0-845c-08da6e6c63d3
X-MS-TrafficTypeDiagnostic: PH0PR10MB4648:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zj9kO3/zsvGiu2Hyb5mAUGHbhApenu8ZNEs4WRUeQzGNmc/EplCKXMpB1TQQdas/dbDTOBfInFF/Udg6X25RWF1OrrH8BS1C4sj6OT6MRIv8l5uu31dFi7+1cCVo4qg6uRHYCOfTrBxIECzlKlgoIZ0cJIjbaF2jjpsYZjgTvLwsqP7i+is/BnT7gKIaBmqV8aBvbPLGm3GHd6pJjUtj/uSPuBwYL5dor2zxlFfGPJOfZthtEvBKZSwgNpKcvmfIEcLwblHwoKbXr7Vwiacp+DhVDFaGxAYhnvjjtCWa0aqeM+7AFfVoZAOEQxKG/tv9FHOgWMR6VGXVhCy0RkmYNO9zvOurHIAiHjwPmTuYyD9o/Infp4qn4povmUKW7SAq3GZNSGmLhfOnDQzChN4igM5TfoLJ47A8HHP2SktCkA+0uoTzB/dmnP94+1ae0Wc1H+KcMpOvJA9xoCoPIqdzUse0rMPpLNYeaAwFlv0Dd3RinRBHyI3w9rf3qXVjOeNiUdC7muLFAL85mzYnQZB93hfm5lwluPtHpx+6X88sddQFhrSLqI9s9hNUGUpMaiGFJUNqrTXPB9lnH35z8IevHQeA7wZrwxU4VOozevWmm6duOG71f6zGvHgA/xMODRyApwrbXfwppmL/0myl95PsPtqCwwhaGp1z7TGuuQpA+0f5c3w9rHaHPaLrshuCa6NiTK36BZ4A3/ghSyGjBjOHSmxcoaCRGss/UIEEyOINhH2l4WoIdk4HvxwmUuA/V7y05GhlE8yTWA/MsfRwgh9lFPAnfX6Y9gnKdu9sLeWTWCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(366004)(136003)(376002)(396003)(346002)(41300700001)(54906003)(316002)(6512007)(9686003)(6506007)(26005)(53546011)(66556008)(478600001)(6486002)(33716001)(6916009)(2906002)(66946007)(44832011)(4326008)(8676002)(66476007)(5660300002)(38100700002)(86362001)(8936002)(186003)(83380400001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bhxFXxPWXLOmRlrL4ckvsFTqVEw94F0HS1SWgt2G/aaUWUUPh3J917NlaQkj?=
 =?us-ascii?Q?Fc1a90aWvOInpjdcG+1dtTdBG5U+TYs4TXY4rhoVOGTwbfy8+7WCduwPbXsf?=
 =?us-ascii?Q?VxFOFZhRnzQiiWSomw5EUKrL3C3LIi8OP/run7Y7+3MCUNiuL8arzed3nJAZ?=
 =?us-ascii?Q?pe4NCSIB2io9OwbXtqYWfaxovVWbAH1wdvwlaKRfm6d7Kch2CEFbVtCvovm7?=
 =?us-ascii?Q?DWMj0ixp4fMJffWKBqbuhVv9Tp87ao+bUwO1itkoYaKPVk0P8r0TjVn/jCJR?=
 =?us-ascii?Q?NK53jNzGrxznH7JWTMXysvolFi0sruXb1x1nt4rvTQaO7IKc4cDDTQ2SQqsk?=
 =?us-ascii?Q?CJef88YHISLLKluPYII3h1Cmv4/bV9V9Kr5EvdUSvBKnPcW0FDDy11lqhWC8?=
 =?us-ascii?Q?9ZIv+5cq6gdOgMdrABZELNKZNfcq6/zHKBaG/jzBoK3+CFEojhvUsd8TgqMy?=
 =?us-ascii?Q?w5Yfp0xEPwD0c22jTgRRrsj9nnSSM/NUFNCcufc21KTqAGPxh2c3l+TjU94e?=
 =?us-ascii?Q?crHIHtDAZl5MbxJWKqMcJqfNe33TM6iWYljzrnjd6xZXW2GSK+1LpXKxBAi6?=
 =?us-ascii?Q?h5aUwyMQxqOpF8nsQDl3plbmqZahhyLbeSfiGurQGg8xEl9bocqa80UJhkHT?=
 =?us-ascii?Q?B2V0HCEW+jgeoqHGrpMwAab+NN9rxV4TH1Fc/EX6kqwGL4vgzCVdiRVasWWl?=
 =?us-ascii?Q?TVVjFWyFyl/YlxSP8fcNELxcZw+jAFq+sYwln7CqSMuVTQmAJeNgj2TLlVZV?=
 =?us-ascii?Q?3MHQjjnMfvErf6XCf1LUKdObKzi7qY2yYHCBDsSNSuc1eZJTfz0L3456JRQp?=
 =?us-ascii?Q?OMvv7ttkdRVG+KqhgCV5vtLXAAGa4e61HeBEPXy5rLdRi4YoG4DLht2Qzq7f?=
 =?us-ascii?Q?IrLJOkiJJ3mhwARon+hGZQhKCI5k4ot4XSBbUcm4h8w/unPuwMiqK3zKeLdA?=
 =?us-ascii?Q?UIyONp9Uw+NmZ2E8bpg3Uo/AvUUb5ASWKUpS2U+Cght8Dnn8EYT/wBl0aWNo?=
 =?us-ascii?Q?QX+EWfL/KpOc31jFSkcuYb8jV+egou7X76nz5645u0OOkFQmujNuqpDri6fK?=
 =?us-ascii?Q?uWyuT3FStCWVhR0fpkyt1F+vAJ6XaOsjQN67urxz47O8YIMDbMg3SZnJMxWt?=
 =?us-ascii?Q?UHHmi1z2A6AcYtVgWU4NJwLkQpjwdSoEfND+vumB71/AAkoC/ZFnAipgbS1z?=
 =?us-ascii?Q?q9m0rY/ytU9jHrGl9D7FGR+WDZfu0cZJ1up7QAtOeMwfFquXWqPieeIYEJhG?=
 =?us-ascii?Q?OkqQFU4AMLKqZJglEMlg8N9JWqsqJaFZyUJFsY63JC9LklqE28nofC0x5Vs2?=
 =?us-ascii?Q?4/pTjL+ZQTvRVa8q4o/MgKPBirsy9r+W2Ea0yJrZnv0vqM1BqP1vRs8LQi4O?=
 =?us-ascii?Q?CEdZYORso69rhfJOl0ErMlU3RzdEVloP/+vI5DROmTIqMHRlEVTRcmwmkaj+?=
 =?us-ascii?Q?mWIJZ4oprnVqBi13uNrmQKEn/4FBjp97JgQy3RhOaCjTsiWIybDGYCRpyGlw?=
 =?us-ascii?Q?JiO6235RJlXGOE4s4Cnx/MKDWcLzn/ZaaogWIadAuPq2hmwZy6yp84Novgax?=
 =?us-ascii?Q?EJst0GB8+zSbCZg/hbpUbgEaq9NJ6wwYkAnmrLzKvomRcsM8O+KyYe6GyOz1?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b7f9f5-905c-4fe0-845c-08da6e6c63d3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 18:35:03.8238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIZ5+PeF8pEJmWLGcxTzTwkqTxdnWjPEc2FzwLq70+TtoDAcitee4/Oc393veu3F3gpxuLrBI0Egj6FlUD7pcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_12,2022-07-25_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=962 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207250076
X-Proofpoint-GUID: UjKW_VaBnE63ZwbZ-fOEANu1EZUjsSG-
X-Proofpoint-ORIG-GUID: UjKW_VaBnE63ZwbZ-fOEANu1EZUjsSG-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/25/22 17:07, Miaohe Lin wrote:
> Hi all:
>     When I investigate the mm/hugetlb code, I found there's a possible data leak issue
> with huge pmd sharing. Thank about the below scene:
> 
>     1. Process A and process B shares huge pmd page.(vm_flags: VM_MAYSHARE but !VM_SHARED)

Thanks,

I often get confused about the setting of VM_MAYSHARE and VM_SHARED.  When
you throw in the possibility of shared and anonymous, then I struggle a bit
more.  At one time did an audit to get the meaning clear in my mind, but still
struggle with the meanings.

Is it possible to have VM_MAYSHARE and !VM_SHARED on a hugetlb vma?  I only
took a quick look and could not find a way for this to happen.  But, I
could have easily missed something.

-- 
Mike Kravetz

>     2. Process A write fault a hugetlb page. As vm_flags is !VM_SHARED, a private copy of
> hugetlb page will be installed in the pagetable via hugetlb_wp.
>     3. Process A writes private data into hugetlb page.
>     4. Process B can read process A's private data since hugetlb page is shared through huge
> pmd sharing...
> 
> I think the above scene is possible. If so, huge pmd sharing for !VM_SHARED should be disabled
> to fix this issue? Or am I miss something about hugetlb huge pmd sharing?
> 
> Any response would be appreciated.
> 
> Thanks! :)
