Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338E158183B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238982AbiGZRSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiGZRSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:18:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7041A051
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:18:29 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QH9HqR027962;
        Tue, 26 Jul 2022 17:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=Ivyn5Lk8ACE6xmH/vuDCjgtlm5IMMUXcMW+z2BFDovw=;
 b=oGF4ATMD/PVN5fJElGsK19IKchbGVROQibehfw2HKqA9aEAPipsC3JP6Xmx6HhtM8thr
 wo9/UIgM42x7S1mHbB3HILDKYqbWiHyZQl1hYkoFLzwCP7YRq/HM04MKgP7sfC2rmH1S
 rs50XPRcTLVfEcvx/rxPKlyIDKBfCsABdzvKpX3M0lQMbOIYxnianI5m5uVFZw6GL4we
 vJO77NWHed+nkJAah9G11kcEQbj1jmoaeQVsE/P1aMTptmsAK5TqHe/W4adMwxziKQ9o
 GJ8b1JkZt1YlWS+G8tigsnokwFTHP/D5uOXQcfslppEQtOLFyrjuZQrchBfNxIOcV3Bp 3A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg94gf36c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 17:18:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26QGf66M020657;
        Tue, 26 Jul 2022 17:18:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hh63833er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 17:18:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIjPi+22Okcjwpyn3oO2zly+XNqMIfXHYkDFHRkpwU9SQy4NR4SNV+npcdCj7+E9v+93lvR4lDjmIPN+dzCEF9ikBeK/oUipOMRk4Knn1480y0x4zNYmaEsQh/EZc2GYBwC4BET1Yf/pLkdJP7q8rXQy8WAIZYR1lJo27IksEXupcun7zm68QOlysxW4jc38YOrRrTxLuwPLXFeLERGsMoa8ieLPCIEe6ipNuYz0SIgP36WaK2BfQ/FeStlWh8TgsLxDmjY0mie75/dp4eBUSpmuhpNjtjpU7ANGJ1HetVOBZYJQgrQxtxczJXQ5aKykZvSOB1fOwKZHw2ePJiiXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ivyn5Lk8ACE6xmH/vuDCjgtlm5IMMUXcMW+z2BFDovw=;
 b=Q/+ZUUByo9baLoHoIuMs2WnscWVZLGCJE5u+RGg1beCuP2SctybGOBl4QWtEetcm8NTUL78OBmxYkO9J0hHonUsDBaVVro1+s0Hf5BjzA3H+HO+p5SZbBxOdDch1vqfmHfAMdgzo/KBaut9EEAr0wn8iOyev2/wS8eBg/6OMH9jucrmc6aJ9WkDxsNum0ZTh176Hj0YuxNy/SE0yNc55+2ipTmxm/p9bIsa2MFnhlPrrblBe9sIxSgQmdW2bb98hokoJ95m23E5WRU2KvAcq1LwwNpUHLJg13TiDB1BpI9iJ8ELV/GICeXB5qJrpvSG1fHKM7oS6RyH9Xaf+qeeHZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ivyn5Lk8ACE6xmH/vuDCjgtlm5IMMUXcMW+z2BFDovw=;
 b=Kf9w69f68ctLO0Oj62b0TkI7sn0xM1iXqZ1sCXI/bWDmDyXoRETFNdf2ooAk+tMqBJKgKkXhvNssMRq2b535P68EBXm4oJM2G3YhUnsM859QJ3/5BVQM466lmiqVOh3la1k4esXQSBXgjYNkJwGEoVNSPUOU4ywJU+rMla+aiAE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MWHPR1001MB2398.namprd10.prod.outlook.com (2603:10b6:301:2f::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 17:18:11 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 17:18:11 +0000
Date:   Tue, 26 Jul 2022 10:18:08 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [bug report] mm/hugetlb: possible data leak with huge pmd sharing
Message-ID: <YuAh0JQL9zQwfZkg@monkey>
References: <025b3ea6-4b26-f091-5464-0eef5aac7719@huawei.com>
 <Yt7iVRaDGuIx8LVE@monkey>
 <2ec4cd05-5b3a-cd5c-7785-5a7236804bef@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ec4cd05-5b3a-cd5c-7785-5a7236804bef@huawei.com>
X-ClientProxiedBy: SJ0PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::9) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dad07b08-0cdd-478f-1c82-08da6f2ad0dd
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2398:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lpvFA/REoVXbaYIEz0mjmmf/YfrIQafmy9r08C5+ulcfRBOoUPWSTYd2xUOuELlMeG6tRzecHTGPcSyqp0HivvfrlxLKU7bx8vPnEaR/6CjUwpLfVXrisxgXEEw06pjf4h87iGzNvWFiMEa2nwOPOxi3CSrY1S7jWyPSMY+xYPABume2xK+t1tl08MDIwXUv0saz9ICTSSZBJhHLgKKJWqZ1xQZEH+z/b9zB5GTczn+XfOxeu9EE/CntuLqlojI5q0mKpV4+ntyx7pE2GoqMBoGJ1S2EFtm4cBCMbHa03sqBvBj+zIQNcEZZmOt1NFi6KwRMnxHoWeGS0vN4w20f7fPL5D/PSpSyuezFCaQUoFsU2hMTVsEPY79Rr8IajlFzThKxIEgb8uWPTISWsDoM/7DgBw12lnPx7L0qfRMJEs2QakA12laaglAkXbUHf/T5mI/PdO1p2p8wnDCpn6gGUw7I8hZ4EYtMge1t4pBDZQ92koYLgdAeAoVERNa+9irRYpdUPe9xC/iTwjJbuZCvjDJqbx9c7Pxm8TVHdGDtqrGzI2Z0abn32zCSwAZ/SYzkRMCFxmQZqwUlU03cg4gAR6k8RrqCFCQfrHHFam2jB941v9rm+aG4iGi125S4Ks9+ZHScabd64M7m1lWijsFbJOyl+0E3rWpryRm3Swn9qVmwjoV+k6uDl78I1SZ/bbJ4Lc+8Zv8BVXAs/J3gP21XLXX5Q6+ivihUaGbODWbwbpKsj/hLXFY4TFa6nKHiNLDwEXNPJubiaiJ7zRoYje4VEDG0YlFgTdYsM0tDxlQJatLBMEWtAyIx0kGqKE0oNopl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(136003)(39860400002)(376002)(366004)(966005)(8676002)(38100700002)(478600001)(6486002)(66476007)(5660300002)(66556008)(66946007)(8936002)(4326008)(9686003)(53546011)(6512007)(26005)(6506007)(186003)(41300700001)(44832011)(54906003)(6916009)(6666004)(2906002)(86362001)(316002)(33716001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jAM/9If84YpYeulfVL4YFgRj9YuNNXOZjIfk/B4nwSrEOrbSWDsi9BnHORM2?=
 =?us-ascii?Q?lOMf97nEI2QJ8egKixxV8mwKOGJ0hyY7I6+FxDUNxReguu+6MZzSE70s1MjK?=
 =?us-ascii?Q?vseK37fCXhkSbTHNbn1q4BXkSOc12XZQPvA3DVYfEXuih5gIdljOaEAEPijd?=
 =?us-ascii?Q?Yfvuk7k4CmsXshMEOW47cau4kc6+QWDyTNogVe6k2zN97FBXSiUZou9t6Ucn?=
 =?us-ascii?Q?IWzXAsPBsARC24m3RxFj2n1scVUE6ulEKnvKbT3XHdrknPyRahmbHjxoSLKS?=
 =?us-ascii?Q?S5x9GgnQr+KpdomtKjuC7AeGggIX95ZgAyAes/BqlznMNgKJRPeoFL/O5Ial?=
 =?us-ascii?Q?wQ5dVAaxDMAr6j6CNxfh0r7gNHbTRLjKWI8C6D5iUkqRVhR2nb8P2b13n/Ak?=
 =?us-ascii?Q?GAaNcWtb1xN3UuZJlQMtVeb4+NwPEGAdvf6JK7eg2FYAKyTNkpAv21dGrL8i?=
 =?us-ascii?Q?8faYKAWX3UPzgw6Xoq/3CK7ecfoOQU6Xu/NMaB++lL9P6Upkeb8fWM9IUKox?=
 =?us-ascii?Q?wrDxGcmGiscHJg8z5X4Hfz2rjTllBUCAjbyuP/9SqxdYXMoWzqZwzd7H7gbg?=
 =?us-ascii?Q?1M+eGDC4326130aVSzWtYNBeD9GpWzi5ThbxVdE9zvZ73wpmLkK8qsWmrchj?=
 =?us-ascii?Q?PdgLmQy+AVYbritXnPP96Yp9EAyNVjsVxRBzwQ0iZeNpCs/kLUUSy0k8gA/O?=
 =?us-ascii?Q?BfCmjhBkEXH1Q0t37QwXzN2eFUqGTCzMwQ6EWcbctL3f/DQLeGhEmahPCdCv?=
 =?us-ascii?Q?EKvOM1FKB2oIGDx3hArhUVP3yO+EtdMBNq+wvtg1INeC07V+xeHNg7oZ4YPf?=
 =?us-ascii?Q?YTqtuaSbIU5MaRlAtvcHq1G0w2leCiXDV5gMOPHwaFZO2AhJ65eiB9YA24N8?=
 =?us-ascii?Q?c3b3kImZtvkEwukcd55op9L5369RCB7VTwPy/D8qw4v2OSPUg1dPBfQriILy?=
 =?us-ascii?Q?dUGo8qo5Kz//sYBdV/vNhfkXl5MtChs16Or7hF26062B7ZUP6uokb0P7Fb7k?=
 =?us-ascii?Q?kBG9eOT9ZxcNeqw7NmQgMWTTzsNOFe9HuXxBR6SbrLoU+p0TQH/zjnwsHiEC?=
 =?us-ascii?Q?5HBOnGdfZ2RYQAVeFzYbXIfEvSInqEuJs6+/zrArNdifHj4DHo9SMaK5WhTc?=
 =?us-ascii?Q?RAcr1RWTwaNjl3FF7OTY29ivkBeAKkw4QtRFcfREcHNX6X3qj8U6Jtny/3r4?=
 =?us-ascii?Q?2G2S5MYH3LLt7SmEHrBv0LD8PrdsM+NgcEb9Et4g/FLo8+etoS6jizwQnazj?=
 =?us-ascii?Q?jNanU2GHEdtqgoPRUD54/Ra9201hTQVcQK2VoySz36jqryno2lWmmtU2wjNP?=
 =?us-ascii?Q?oNBN7cnimxuG5L55eL7oBKrPER3M/8d5fUMDlrVrfL3O8VGKgqVFW5+hy7yP?=
 =?us-ascii?Q?DQAqUwPWi2FQeMbmiYrdTzrzgF6KxG3iQ7U1xgQZCnTYt7UhTU8x/RWpi4Qc?=
 =?us-ascii?Q?yNdPzZLKsXfKFxsIrtre2ojmOX7CQKGGOpTnvlMZOhGr1wCakQbYbGKfR323?=
 =?us-ascii?Q?1XQfYnV+PtJGOu9P+JJjqeQhryVzjHAWQBMgmqnnlRKnxo/GKtK25US2YrCe?=
 =?us-ascii?Q?Dc1FpC2J3eQHthLr2aKzSVUAOMxGLTtkCeWMUfS0qde6qhbBS6gK730XLhlF?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad07b08-0cdd-478f-1c82-08da6f2ad0dd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 17:18:11.2151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KKYZwxKqcYb1eC2VtTqO5HckJWxJAsH1Eo+XEznNL4n1uBfae8Nx1+Tm2nKl4vHG4jXQF0gqWotinCwrNxyyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_05,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=908 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207260067
X-Proofpoint-GUID: k7fsEW91wD1CnP4wArpkvu0vFwQbkEiz
X-Proofpoint-ORIG-GUID: k7fsEW91wD1CnP4wArpkvu0vFwQbkEiz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26/22 15:14, Miaohe Lin wrote:
> On 2022/7/26 2:35, Mike Kravetz wrote:
> > On 07/25/22 17:07, Miaohe Lin wrote:
> >> Hi all:
> >>     When I investigate the mm/hugetlb code, I found there's a possible data leak issue
> >> with huge pmd sharing. Thank about the below scene:
> >>
> >>     1. Process A and process B shares huge pmd page.(vm_flags: VM_MAYSHARE but !VM_SHARED)
> > 
> > Thanks,
> > 
> > I often get confused about the setting of VM_MAYSHARE and VM_SHARED.  When
> > you throw in the possibility of shared and anonymous, then I struggle a bit
> > more.  At one time did an audit to get the meaning clear in my mind, but still
> > struggle with the meanings.
> > 
> > Is it possible to have VM_MAYSHARE and !VM_SHARED on a hugetlb vma?  I only
> > took a quick look and could not find a way for this to happen.  But, I> could have easily missed something.
> 
> Thanks for your reply. It's possible to have VM_MAYSHARE and !VM_SHARED on a hugetlb vma
> with below code snippet:
> 
> ...
>     fd = open("/root/huge/hugepagefile", O_CREAT | O_RDONLY, 0755);
>     if (fd < 0) {
>             perror("Open failed");
>             exit(1);
>     }
> 
>     addr = mmap(0, 32UL*1024*1024, PROT_READ, MAP_SHARED, fd, 0);
> ...
> 
> cat /proc/<pid>/smaps:
> 
> 400000000000-400002000000 r--s 00000000 00:2f 153780886                  /root/huge/hugepagefile
> Size:              32768 kB
> KernelPageSize:     2048 kB
> MMUPageSize:        2048 kB
> ...
> VmFlags: rd mr me ms de ht
> 
> /* sh: VM_SHARED, mw: VM_MAYWRITE, ms:VM_MAYSHARE */
> 
> So vm_flags is VM_MAYSHARE but !VM_SHARED.
> 
> But in this case, it's readonly. So the above scene won't happen. Sorry for make noise.
> 

No worries!  And, thank you for looking at the pmd sharing code.  In concept
the functionality is simple.  However, details and edge cases make things
complicated.

If you are interested in the pmd sharing code, more eyes on this proposal
would be appreciated.

https://lore.kernel.org/linux-mm/20220706202347.95150-1-mike.kravetz@oracle.com/

-- 
Mike Kravetz
