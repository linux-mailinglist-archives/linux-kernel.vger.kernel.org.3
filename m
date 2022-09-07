Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B129A5B0782
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiIGOv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiIGOvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:51:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066D2A8316;
        Wed,  7 Sep 2022 07:51:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287EnD5p020994;
        Wed, 7 Sep 2022 14:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=06IYX+s6J0ifjnF0wVX8PbLQ1Pe/utWRZi+cnRZUtrI=;
 b=PuxjXWw+6JecWrRXCseD3B8pPmI1HSOkPN+neeaw0Bpmdg4q5I+gHN8mMWYXp9Ni2xE5
 8jZUhSK1rWntkIU8PMS1v8UeBGFhUAl4gE3C8zoM7iV+aVhHXXvJ1XvbALDEPfdbRSD1
 owL4vuRo15wRavfI+apzUBLKMTJwXCg8gRhp61fxLiDQYMf7PqzO8jJf+3k1OFOjb9SB
 2kOPdd9S4NLUGxmQdAAO+vB///nSl7q7XlzTdGAMew0XrsoPL9SonRDvC2qVqylHuTs9
 VvSaJDwr/aBqUWJIEAeLtoOK4GGTEV4se4IIH00+Xd9H/rKE1Ga6jGtJbJZKoXfdj4Ui Tg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyfts330-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 14:51:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 287E2Fal033174;
        Wed, 7 Sep 2022 14:51:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc41spn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 14:51:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4Tlnca8aBbtmT1Ko5UuRJl1RHokeS6y5vXkdNoPH6mfTWqlp7A0p+kzP8ONUQbgO1aX3dIDsfejYiLoSUjRAUM/EJdRZqbNfIHytlAIguO76+qri9r4Hv2vjBAJP4hwH18JGbGSQNCMCDvys93L0p5R7U+ZZZZAJY1uGzjGomNC+iEO+eGF+NY6NVfp3Xz1Ng15nfPwRIWHXuCkMWrR1yANJ68sxqdiZQvwpF7swToXd33p8VCTb0Ob/rGz7J3NmrhKTT/DiFutkleQZ7DnQDYnQ5SjNTeP24cW0zlDwYHmKeKauPDUuu4AEeN1ISYnVk7C0On8wcwcUA9ugSNSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06IYX+s6J0ifjnF0wVX8PbLQ1Pe/utWRZi+cnRZUtrI=;
 b=a6zJ7weMQo/0HxqvPYBTF+5YeKcj+xC3//LNvSmxqiKU6vyZjpZOLw+ggJjGc5YLybx7Bh8h3CMF0qTdnaacCmLrMFSW6Xs/pxwXIlvvAJfn9/ZBJQ4VN10FrNtSLABaAYSOpLPWZyIWTmxwLtcLlAdX/wEc7AjuKcdhSza6UquhnStnb3zH8cC08cU3N8CrtPb2xkLHc+9ED3VQDgDq+0hl3FDWFoka3n3zc4pdGOqUdDcO+lZFkb06bYRJwopQlFJ7bc7bes6n6EqSpNjNO5tmEpwOvAWbvnBVPOEiEP52x/S/PaGTpXKitpS4Lmo753cKR4/GKyvpyNJ9Bmkc1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06IYX+s6J0ifjnF0wVX8PbLQ1Pe/utWRZi+cnRZUtrI=;
 b=czEReb033Zxd+Kz4+AFWV8xDz4XoQMsgPrmoEs/3VycL+DORTKrDYiBLXky6rmUjZSbKlD4md26HGCndGPAiJ4em7e+QJ/t9jj2pwdotOO4hX9ABtBDqOIR7d9RbWMxhZVPNF4CyL+R4JZrNLQNOg9/63OkYZbJQaJ+Ykb1TCr0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY5PR10MB6023.namprd10.prod.outlook.com (2603:10b6:930:3d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Wed, 7 Sep
 2022 14:51:01 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5612.014; Wed, 7 Sep 2022
 14:51:01 +0000
Date:   Wed, 7 Sep 2022 07:50:57 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
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
Message-ID: <Yxiv0SkMkZ0JWGGp@monkey>
References: <20220824175757.20590-5-mike.kravetz@oracle.com>
 <yt9dr10ok3lm.fsf@linux.ibm.com>
 <Yxd5z0c8NlKVlVqk@monkey>
 <YxeL7ZMoyNmPAvY0@monkey>
 <YxfTA53/5pkpC7xZ@monkey>
 <367db2b5-5242-9be6-1d5f-d13e35f84167@huawei.com>
 <YxgD7qXPgkJ9VgJn@monkey>
 <25ffa1bf-0025-3421-53cb-79f986468cb6@huawei.com>
 <YxgQbSvDzQq7covC@monkey>
 <yt9d5yhzk30d.fsf@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9d5yhzk30d.fsf@linux.ibm.com>
X-ClientProxiedBy: MW4PR03CA0046.namprd03.prod.outlook.com
 (2603:10b6:303:8e::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY5PR10MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 414444bd-4037-46bb-69d7-08da90e0615c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gm3mb97CKMtmrSuWP57mA2GPuTDalTuD3AJee7iimEe0Lff3H0sevTj9kbO25GLgQH9w3zz/DEC3XZAGK1g9Zkv0XVeOaSbinoP2ObF/AfOMyFOjwzVKJhxvmCYm1gsI1PIk0y6oIFY0wBSMXj+Rg1p0E9K32R9YdpViOTu2ydMwLOI33IpJ2Goi+R4AKxD3O6611u2tSzitkJwcjZKtgPHvagRy/f7PJ9liFXhc3PnUUxs9pkxGWxVE/RhTz9t7ksIk97EIEmvUfyoA7KTwh61lqEbzOMFxM6TXMvrMNFBti/vIDyQTiGoQovMnnEchXfiVdNZEKa0Etmck3tpn8W+VJN8t9cZ+AuWcmCN3DHEqA3SFmE86ynS93W53oaNfgGPxotZJWwXVvCnVOiAtn0HljnDF+Scb7e91+6AG4MtCHs3hMqniHjmqtDV3QKdt5WorG5fV1B66emiHepFcTAxabU0AYOvC4vDIMiseCdhYgn5mPI2PLDE388lwCXmqJ3VDYxPVGfApV4H+FYKH7gALZQwtSZ1o4MF8oWbgG2YohF5iKTfRJ5W9h249faM2Lcnwh8jnJ5ecfI1V9GxdX3FKo7C62aylQpZNGFwINM+qqekaMFKPgtr/wF5ihSGKuNr1xZdTgbHtZz7xCL+dzqPy4i9r2RlbqnNb6HJGhcMz1UIJ6m6mu19I90a0oAI63U7Exq5geFUyzeLwB0nvaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(376002)(366004)(136003)(39860400002)(346002)(66556008)(66946007)(478600001)(316002)(6916009)(66476007)(6486002)(54906003)(38100700002)(86362001)(2906002)(9686003)(5660300002)(6512007)(186003)(6666004)(6506007)(41300700001)(53546011)(26005)(8676002)(44832011)(33716001)(4326008)(8936002)(83380400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ZrXt7ZOwotb7ZjRlLQc1PBYYZiTKG0julH1B1jBcUxLgCplYk0WeK7JwyHC?=
 =?us-ascii?Q?YT+PMO6Z1LncgizckWNQLdAKq0jvfn4pgJer0MlUvzC34ECY1pfw3HFYgq4Y?=
 =?us-ascii?Q?lH2rc/yz/IrIgJxUV1tvu92F8ZMLX75CDHzwsRxlwodkVmtAbGJNKu8Om3lh?=
 =?us-ascii?Q?LU6E0CeVVEDwtpk3HCbn9s9lT6JSJ9hbra8umeXrdzyQP5j8JZuxyiAheYCB?=
 =?us-ascii?Q?OETcG567cDqPUAj9wj12RM0zuYXLosfvCzU++Yx7GNMpUrREDDwcN5sqiJLV?=
 =?us-ascii?Q?EeGkyH4PntLUIVtZZrwctCfPHCiEZE5lX0GQuO254QZ8R9pBDDD/A3YW3PAe?=
 =?us-ascii?Q?evdEvCojYel4ENr4ta7ButcJ+xefqr3Kb2kEXLdEpmxf+spU8K3mO8oggr76?=
 =?us-ascii?Q?FPW5Yft1NHo7k6WbuJ4pvp6/TqOXEUYGtM8BKbKbyVjz0ppifR8+XCrUWgod?=
 =?us-ascii?Q?Gf6zXxcEEwTfnz7R28E0x+PAEtz7PJ4iSjS1L2ionaJf49CZx1hBgi0/5qGP?=
 =?us-ascii?Q?AIY3otdDM0+ESP6ivXFdX9uNo3YfyBffS21hkxfVrUNnJlmUZsYRprOtv7Bx?=
 =?us-ascii?Q?ZNTunqG5DQPVqTG0cNA4C+XMLE3Dq9WlISAEbKEUQzGeIbIRotTGMuGfwU9z?=
 =?us-ascii?Q?nsueF4AvY1AfiaC0/sSx+0Bv2fNWsAiNlXJy4WxxL5A6j2GrVEwvbQlTP8u/?=
 =?us-ascii?Q?I3VRGuu3bw1QMtUHTCxq+Zcq/wQOn5z2fcV+WPynRdQWmkviKOgycsd0xmDt?=
 =?us-ascii?Q?LaB2sV+x2PCd/1AhSjHYtcJfJuBONcSkiQm+s7bAzI0W/LQ4sLOtSDK9dlTG?=
 =?us-ascii?Q?5OFGZnTk7uJIHS/SNwS35LoA7KhshffPdqKZRKUrjTtGIOOMr5XCONvEar00?=
 =?us-ascii?Q?8Cz5qzBH3nPByGcW2jMvA0KoFfe1ZAsix4SeUVCYM+AziW5q6dQNqH91fVjE?=
 =?us-ascii?Q?5nUZgpuS+fJxeqi58XgtTuvw6siGpcTIqfpQLVqOg8q857ZB7qJxiRcLmOqk?=
 =?us-ascii?Q?FFZ2oYmBIlu5HtC2ysXrISbzNixB5oZffd8oLZErGuj/HHF3wXM85vw8JtJu?=
 =?us-ascii?Q?31KEytD6jK60PU0s7K1gqb51K0BubEvsGR9RsG1cx5dhFIgPdRnB+85ToqLi?=
 =?us-ascii?Q?Zq9qcsJo4NUT9BPBpJ8TLkT8unI5oVWDRGdz97026UoDekO+LVQjCWNw9rbu?=
 =?us-ascii?Q?BS+aNNifJ3Huzba7SDJkBhw3iBlN0ATq0Ye6MsmXb/ngPrG1o17c5Zgbclbq?=
 =?us-ascii?Q?FPHs9PXEsd/BSSEdAo21oWqAquYA0QlWr5agPJ9O0zeS4mLZmj79y2Hcrl0E?=
 =?us-ascii?Q?N1PMlGCjlm2XlkmPWw1d+USeEH2Nc9Qy4cc4wqSh3kWmqga2EKKm1aOTeO8s?=
 =?us-ascii?Q?OOfA4s7jqbmAtfVZHh7VTQ5z8Dzeuq21xhqd8qnwxKsfSqVy76PeHcEYpe0n?=
 =?us-ascii?Q?wprCmlkYGFgijp5BlHVMVdbFp7KGkpLCiVZx4mZY0xYH+FmwdjFvWt3R6v/p?=
 =?us-ascii?Q?QXbmawdF5UfW9ziuH26jC5ksQITY6PKzcmWOjDKGfJIwu3e7MO/xjRanHakz?=
 =?us-ascii?Q?hp/v96tlLe063osSHENsUhn8hq48Yz72o5wo99ZypVi9Qwz9seeVNNcXMktx?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414444bd-4037-46bb-69d7-08da90e0615c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 14:51:01.1397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqLfaW3K4DCOzXzjYN3dihSKMjQ9SaCRjBOuFlfWe/9zcDHMjgV+xDWhtIgMW35ct5H2zve9UMuU0A2OalCuoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6023
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_08,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209070058
X-Proofpoint-ORIG-GUID: 9W-rLXVrZD-OjkjCfWBDdD3fjxf1xeIA
X-Proofpoint-GUID: 9W-rLXVrZD-OjkjCfWBDdD3fjxf1xeIA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/22 10:22, Sven Schnelle wrote:
> Mike Kravetz <mike.kravetz@oracle.com> writes:
> 
> > Would you be willing to try the patch below in your environment?
> > It addresses the stall I can create with a file that has a VERY large hole.
> > In addition, it passes libhugetlbfs tests and has run for a while in my
> > truncate/page fault race stress test.  However, it is very early code.
> > It would be nice to see if it addresses the issue in your environment.
> 
> Yes, that fixes the issue for me. I added some debugging yesterday
> evening after sending the initial report, and the end value in the loop
> was indeed quite large - i didn't record the exact number, but it was
> something like 0xffffffffff800001. Feel free to add my Tested-by.
> 

Thank you!

When thinking about this some more, the new vma_lock introduced by this series
may address truncation/fault races without the need of involving the fault
mutex.

How?

Before truncating or hole punching, we need to unmap all users of that range.
To unmap, we need to acquire the vma_lock for each vma mapping the file.  This
same lock is acquired in the page fault path.  As such, it provides the same
type of synchronization around i_size as provided by the fault mutex in this
patch.  So, I think we can make the code much simpler (and faster) by removing
the code taking the fault mutex for holes in files.  Of course, this can not
happen until the vma_lock is actually put into use which is done in the last
patch of this series.
-- 
Mike Kravetz
