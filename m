Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B82576604
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiGOR36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiGOR34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:29:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6001A3BD
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:29:55 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FG50PZ024289;
        Fri, 15 Jul 2022 17:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=NQkfmeHUl0T1cP42QyftOMrUlCdb26bZQpbPah74oME=;
 b=Vhs5A0LuoXZ6rfKkYwz4by1jzX/+kWpc2pViIgmLmFqD6eplwHmZSQ+yNu2VaU5JxEbJ
 UMrfQ4YdpJ/YUvvnaA7bQ2scu9vAykR/Vkh2gh0HIWLS96qKPgEVmeGUOLP7rt7Y/Ie+
 SUq6nx6twJpFUkj8z4QUeoO1TyWHV5uw9G60ivzyfmUJetENwWnwlAC0w8hcgF+JLK/J
 oMgV1ArWlIxSKe9vbsnORZ/XkX23tasioXuDYC5KQRVRvz39FoApHLIRs/QTyb7RyQFO
 AkYquHjpJ9sWkADHc3AJ0otMJEgdIeIDUjPEdtTSP66mGm5KN9b9FZkxs5llP9CDO+gN ZA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h727ss4ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 17:29:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26FHBj6D024702;
        Fri, 15 Jul 2022 17:29:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7047m183-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 17:29:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNf4/2wGc7nHvs/m6FqsJGyrhEw+Qx1/UgixHZbYtB+EMON7qt0XfFqPcjMMi56i/AB6cRjzt4eyCFAPqV+Qlq4OtJMaoe868LxjlInEhFcEFFDmrEl+zJIpWYBWN1TugH/6qjaxD5m2Nkh9RpJVVQtdxjMuYkd1RIs4xAdCKdfjkq3jrs8L6/2nd2XSkF0CAg70F8i071oFUZ77ob4iKsMBOw9Hyquqsjhu4CnQ5P/6ATPu3JtRh2lCdG0qkpCqKSsM7zn0KSJZhUtwAot/QiL9cxOYh7oCZtOW4E3VPXy5DkQuSMW5CHwqvzymIA2eJDZbAaHK+4+i5BU9nmM8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQkfmeHUl0T1cP42QyftOMrUlCdb26bZQpbPah74oME=;
 b=K/adhz53ARTo4Aie1orLv6HgxbpbxunVf/0bWxMgB6c2hUNUCIO/CPJV8bJLObfnonhktY9RsmNxtxLXmcjjY04ak7oVAJ4/SyS7bexvFby3R8onwkAbvECEXwm142lxOCuRrSrZ9MKh2J6sSNJMRg3v0/wAuHEZQ7eusJLsbPITyW2s5TUu2P6PSzDoMgt6eNXxdIcG1nI67b+sESlJLwh3m+S9FbvXOLIp+8TjKkrbsX7lhyqJgRNLlDnri7apQr+2QGJRVLwSPHRZJdFA0i7H57ROI1aVZ19xWZIBa1YCtGVpqRNfycXYHYZDaCKMcOKqFDTIb1tmzBDA00HuJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQkfmeHUl0T1cP42QyftOMrUlCdb26bZQpbPah74oME=;
 b=XHlS5+S6BUh5W4aVBMRsiZucH7DmTqKKAY0Fw9yyLQqoBSgDtR3sQwrAd8BtQk7sEx5iT+3S5eyQeU6DsgwPSYsn5MRvxmGbIxHSZzArH0qLKNzm7WHhCoLlw5p3H4iBQxwwHbUrbd1PRasXDeNMxRz2ia8HeuGBLG89EdR4Q2E=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB4300.namprd10.prod.outlook.com (2603:10b6:5:221::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 17:29:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%5]) with mapi id 15.20.5438.019; Fri, 15 Jul 2022
 17:29:35 +0000
Date:   Fri, 15 Jul 2022 10:29:33 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in
 hugetlb_mcopy_atomic_pte
Message-ID: <YtGj/YYixDT0npgL@monkey>
References: <20220712130542.18836-1-linmiaohe@huawei.com>
 <20220713102357.8328614813db01b569650ffd@linux-foundation.org>
 <a47922cf-eb30-1ad9-fc96-1896254564ef@huawei.com>
 <YtA7svbn4MtuT7qJ@xz-m1.local>
 <402ae708-4c86-8feb-75c4-9339e1deac3b@huawei.com>
 <YtFfHU3fb/ncCG6O@xz-m1.local>
 <CAJHvVcgFY2uXM=CkxYmHc32Vqb5qmr8vFv0dpFk-2=Ef+Kssqw@mail.gmail.com>
 <YtGe2qIO038e627p@xz-m1.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtGe2qIO038e627p@xz-m1.local>
X-ClientProxiedBy: MW4PR03CA0205.namprd03.prod.outlook.com
 (2603:10b6:303:b8::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d436c34-74ba-4b55-a853-08da66879666
X-MS-TrafficTypeDiagnostic: DM6PR10MB4300:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: deVpAic2ZD5BilmKaxOvzNFaGtP+b3mSlmGfY0H++yNNaJDEen751YmGVIv3Ru30lrG34Hwe2inZLrW54lvJ4G9ZJwY/7wjQSwhwwKsUHxMKms4OGA0jLajtumvSbX88+f7Hgkema23+ESdx7S0KzZhND2G7Wbr/ruVBEM1O3xd5m4a+hCpT++6CxHe3dD+TeBVCqkkBB/o4Eglms5c9m4cPEhwf2nsqjQ1TzkxSpqwVlP7YjsOn12TvCZMX1xlW3G5FMS6hhjy3PECy823ij27xnEGo6iSu1aposYU9wArT+Q4IQJwiEoPU/nKBf5ouQYYtqdzDoE+pPbgfA2OcoJEkYncVezV+0OOKK2IU3chr6BtOH17CatBqYlAdMOwpUye6dBZbTNAX6sNt6KmjFBmHShhet88eJOzUPoINoqAKgmM9K459tuKZjf1vhcnI2n38O6PsrCzFvxmatYhmlmi0lHmg3Sbyrzgs7/bKwtAQkyvndgnHwNA0aBvA6eL0ZDjwrz6KTT6sMyQEnJH2Z9u0UNqZ/7nvMs41Z0mm0ySklVSxYwaErxj2D+hEKKaI0X+pB7qYQjUTaMLt0yoB9KJVY42rgGkxo6AoIMVurMOewV6aphpOySAPOpyemZzS8MObu12mE7iyEAWBBlM4mr1WAfrWzOgu6cXEKUQbM37oVMV1+CAWmnZnqYkby/FvTzbnSNje4k2ed7MMwmEgdnl7DH86waY9FxVIVFXZbQzzjW/vYNNvlGvgvdLet+1H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(376002)(39860400002)(396003)(136003)(346002)(26005)(6916009)(66476007)(6512007)(53546011)(66946007)(6486002)(41300700001)(6506007)(8676002)(66556008)(316002)(478600001)(86362001)(4326008)(9686003)(54906003)(186003)(33716001)(44832011)(4744005)(8936002)(38100700002)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ySlkIF8fH+mOuKoQ8Cf5hfJVztdiCyO7/+qcPGhDp3XEIfwaZaCB05zStv5e?=
 =?us-ascii?Q?oxvGoL97M3+K78QKCLGIxDuHoG+G9sWgrd33UoCrBkwn8IFdRO/9on9ivcNr?=
 =?us-ascii?Q?ZuAksAwJ26q5uPJiQ0jbsnAHXm9j0VPkjE1l3qWeG9uAj0rWOS5ihMVWqfWR?=
 =?us-ascii?Q?eqvVQ3VTeYEL0nIlM32TGDi1WZJGAK87ecnNW9D1lPVq+s51Zl0PG9GfBRpo?=
 =?us-ascii?Q?jBOqmmxZj7P1BaU+lf1lEHJRRkteUQqqeBpynugkkPnnLskifC7FJmoNJIgp?=
 =?us-ascii?Q?7ApVkKqoBA6PbaYDdxn7AbfniLuCt7DQ29fyo7XDJfIVjLvFVdI+EHVqjb6X?=
 =?us-ascii?Q?5h1P7KXeHKxQMUel3va4jkLNKslK+JeC0cg/ipBRskjdNRek9LvdJ+8lBuRN?=
 =?us-ascii?Q?28XKGpQjOCD3hQXr9emWUD3090pjMc6RLUldsfaY+nm42of3plQeTZ8bycIc?=
 =?us-ascii?Q?a1W0rqVWxc0lgiytWwWzjJLuq+2Pk1Q0nLpIFetC/0VAe8DbH042wLeiDund?=
 =?us-ascii?Q?B3cQVES/ToY9OVOTJQ9L8MbzzpqXg1Wcyf2jGazo8TlCfLKmG9g1ZbNYPJng?=
 =?us-ascii?Q?Vlutvc4YpgOuATKL2cLSTT5AL8jLRMol74e3977NBdhKAUlg3L+jaVb/tCCz?=
 =?us-ascii?Q?Q5UgSMTQ7Hsd3FepZSPK98gJ88jnOrf5i/uu7e4W8Q7k0m/yyUY4z/Itkd4h?=
 =?us-ascii?Q?eja6Qid5Q2mtLRvPoQvNHM5mTgT0IGchV3tevwPIyZwYCPuQUiCSvsDdN+47?=
 =?us-ascii?Q?24ZqyqQZW2zoorb0oUSvsGL9Yt1xwsgkl8g5kpmZVxHleaor2Gvmuaq5n+rk?=
 =?us-ascii?Q?TdsT+XaVsXn4m6WhNl6rXfZfmaM8c/h+75ufCBXFp8jTBHCTaQ41sXD0psC4?=
 =?us-ascii?Q?MWVDvrhgQqNtCyM1EhkXZUsuXePUDiMB0jTVKDbUbmSMD2rp3y4AmlVDXABS?=
 =?us-ascii?Q?al26fz9cw1oY7PUdW8d9CeoR4oqAVLVYkdCAa5dOKMnpl55bsfmPYgbYwpBK?=
 =?us-ascii?Q?KXJxBn+IrchX/LZIRUGPiY4y5xlVov9V/ZFxU9nU/GlLwxzkmjEWqoFaY7U7?=
 =?us-ascii?Q?ExSXdXAEAZzJzFWgyKg02q/EjZ/74dJiEpQrXV1lPEw8hoNCYYika8WzMQX3?=
 =?us-ascii?Q?Qsm/wQuDsSnhOIgYFHqCDLO9OPqzjJ10jOjUlOha7V2fx4UqybmnVyaAHbsT?=
 =?us-ascii?Q?gQzr0I42BR7LtpgMdyOcp6wl83ERyeuVHk/oY0bmq02uUDNeKAdhMEkI5UTr?=
 =?us-ascii?Q?xgnL0diL3f5o3yeiXdbeaK+H06ExdXaUx4QgIbybRvrf+k36tkQEupeXjXA4?=
 =?us-ascii?Q?8k7d33Xk+IwdvUJ0YRbe8yG8embv3TO31CA5OKjZok8qTZbk76SJspC8oC1w?=
 =?us-ascii?Q?0zu3gWIIfhDrlGeqZuToFfuk9umYfiYJxCwaBEqe+Hy2uASiYE5Z6SKa3/gE?=
 =?us-ascii?Q?+uZkC7Zfuqkk7I68k3/+JaHRza03DNqlRN7ZonBhNceUBucKHmyuRkmVT4HI?=
 =?us-ascii?Q?LnYOvwjd/asefhOzj0iwdJNk/J18wursevnfBztW6ftXvogi8vR4c+pv/TVr?=
 =?us-ascii?Q?5fOUBVP4IWdFXQs4idnZQomKq/P3GA97627ijeAIp6b4qRtlqNJoQF5JuVgo?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d436c34-74ba-4b55-a853-08da66879666
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 17:29:35.7836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXiV0eT0YRopZuy9P4oe8CYttM8eA6d4PSJ9381lN/6pF1KO49s+rxnL9ZTs7SbaEYoeNPlg6uohGCA7eTD0ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4300
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-15_09:2022-07-14,2022-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=985 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207150077
X-Proofpoint-ORIG-GUID: O3XFNg5GV7h3Tnx3OkdSViQNyFJjILIo
X-Proofpoint-GUID: O3XFNg5GV7h3Tnx3OkdSViQNyFJjILIo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/15/22 13:07, Peter Xu wrote:
> On Fri, Jul 15, 2022 at 09:45:37AM -0700, Axel Rasmussen wrote:
> > I don't really have a strong preference between the two. The second option
> > is what I originally proposed in the first version of the minor fault
> > series, so going back to that isn't a problem at least from my perspective.
> > If in the future we find a real use case for this, we could always easily
> > re-enable it and add selftests for it at that point.
> 
> I'd go for fixing the test case if possible.  Mike, would it be fine if we
> go back to /dev/hugepages path based approach in the test case?
> 

No problem going back to using a file for private mapping testing.  Removing
that was more of a simplification, because of new MADV_DONTNEED support.
Just want to make sure we also keep remap and remove event testing.
-- 
Mike Kravetz
