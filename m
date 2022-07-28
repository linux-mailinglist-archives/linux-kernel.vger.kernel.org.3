Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE58584853
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 00:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiG1WgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 18:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiG1WgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 18:36:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C1027B29
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:36:14 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SKIkEe021664;
        Thu, 28 Jul 2022 22:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=sbHUAlBpYZgB/FMv4NzKSj/EVNLYWXjzVq/nuTQUkyo=;
 b=fCcNRjBqupPqLN8CygqGylYIGBxEMaRZD2YOSgX6AhYR+YbxPQjswVXtBhAY+xgM6img
 HoIQgWRt5aVkpQh114NN1dy52Nc25ALc/2SeiwCONdpIDzB5R0SBT0QsE3tP/+B1wL/m
 cnKDNhf8b3kBmghOM71rt/hOMuC3a1RX70ffMFqwm8atjJg8EUHFgZMVKZOmzfJEhk4h
 UBLpZe/1FKUBNklu3NNF56fwVSYUrhSUwhlWBjRt7Zh3vwQ01ap9NrVPS7unmTEB8eBt
 m3CA1jGXF7MrJ/oP521W4yM6FwRlO++NUOtB96AbI7Ktc17ctvmGNPR8kCw6lPgElQsM rA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9a9nyhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 22:36:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26SKpwi6023058;
        Thu, 28 Jul 2022 22:36:04 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh5yy0pj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 22:36:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nm5R9T0MeSQB0rKvSzvkSPnKyRbyz2WO1S3HW83Zfa4mojV8FNsDzQZT9CTbAWqBJnv6YajRRHBe4Ef0M3Q3MtRNaYyiEQlohCgzymTjO1EAUDevQdZ3WZO9JKPMEAcHuHaU1Kst2G3miSGXu9D0LNWj91+hfqJqIX8NstUeEXI9xZmG+cqjFLHYWUL9E7dvf8YnaNEQREPh9iVQX0KCTMZbxNEMBEYgDcOc6MTflSwVKxJZ20iRU4rrREUeUgl/SvUPGmBmpXR/0q8TH6e58Zd3tdMRb3pePD53I3CgCNdgZacX2//bqUrcziueSsmwJ7fUx7ua+WocykR1SxfwIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbHUAlBpYZgB/FMv4NzKSj/EVNLYWXjzVq/nuTQUkyo=;
 b=iXpvF0xeUfHOb5AUIVtRKnaUgGAdtwO3W9O0eo5EkSxtuYh+++kfjtm2vBXEw53pOt9XtGMBAcrR3tHZ7Q3o62AhOSCMlynFzl3AJPXrMzzuM2fdnrPLtGMFwJetBFzTdzJhH7HLh80s0nkMVIHpDEB8yQ42LV2VCeyMxbeldHc1M4VeihOU0qeasVnrYAzzLzi2pMpTAFpmQlpvuaAICaINwTehDW5r+HMoI+oruusLf9Slgk893h+rPGRCIfInHcnM6fb4mwzZ3Md+Zg3lufEUERiIjyIgpb5ztM/HnpvyO1KOP/QnxXt73OZK7CofhvZDdDFs5I4IykeNCeuQ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbHUAlBpYZgB/FMv4NzKSj/EVNLYWXjzVq/nuTQUkyo=;
 b=wZz7pe4+Fu0y808p4JeJ3k64Uidb6v/d3ImYD9d2B7n1oCrKU3FcTtAJSRL8xY0gkX+pO7VSh2+6uIfbwK9RKVs2Kgm04kkyvzMqIHvF3TuplFnGwJ1eKCC8laUobe4oW3cASYI8nMLypv9FAFT4SLF1z1sP3VIL2cRu1oWO8Mc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN6PR10MB1523.namprd10.prod.outlook.com (2603:10b6:404:46::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 22:36:02 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%6]) with mapi id 15.20.5482.006; Thu, 28 Jul 2022
 22:36:02 +0000
Date:   Thu, 28 Jul 2022 15:35:59 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, almasrymina@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] hugetlb_cgroup: remove unneeded return value
Message-ID: <YuMPTxt2gFNR76xR@monkey>
References: <20220728121949.20985-1-linmiaohe@huawei.com>
 <20220728121949.20985-5-linmiaohe@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728121949.20985-5-linmiaohe@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0098.namprd03.prod.outlook.com
 (2603:10b6:a03:333::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5513ba14-ec9c-45f9-3fac-08da70e98cce
X-MS-TrafficTypeDiagnostic: BN6PR10MB1523:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rpt8fohrnFNQg1bBhlxpahMVXrBXHx1Cy+OSmuX9D3w7U7RW3RocVsIFuooqSYsbqa/2LosoqDmsKRL366JW8vv8Z5YG0nT6gm2Y+OgoVAAWzVPWyQEDlSx8LXYFN5bEcId0YhChdWNKMBazOu7qWr9OYNrGKsWYxIdclXKWmxqud9HX9Mt/qU4xyF7mDZOBLeySKXpEoR4npdCwB3jLphCd9jW0PPDPSeU+8iuBYNzwaUEFhVptneQLm98m7O+I0gJLyguOaff7YptlXlNwiitQ+HEYp6r8dYR4jP7d6wRnJrmbbWcsJY1ownwleAmvS7JXWNIXtUKv1PpsFQAoYobyvtYRmHLzRXB5fA4ZMTBrPRnP0tHe/nn5J3ueqKOUS26Xd12idI0HyKK5KnnOaK2cQtvK8sKywNydxlr/fLSgbRUB8jOGmHWFlYjLV4nBUDEusJgp1l8paszCaSGVOXs4o0CuRKN/nLDBAYf0KUu7G9TlpPV5O0bPjfEZLWmaaGJiYmU/w9A1gerTMQuTwXfWXaKFsGVU4x5sREA3o1IVcgzAr+WpRV9TvtHvlcoYwxwjSQ7v6HTfUumJN30DVuD+6Beo9nVELgHg2nHyh9EbzXW1blu4ktnVpDHV4Y/NGQKsDkPsY7+9n5Q0FGVy3zZeI4u3bhbHwAfcYxBA7mh3RS07ZdFoPyWVs3kYyr4xh78wv7C9/bG+LuwG3mDfDN0BUfkCXQWqWenQS/mZXx2Y08zpIBMCeBq+z0/bqhBO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(39860400002)(396003)(346002)(366004)(376002)(66476007)(66946007)(4326008)(66556008)(33716001)(53546011)(5660300002)(478600001)(8676002)(8936002)(6916009)(316002)(6486002)(6666004)(38100700002)(4744005)(2906002)(44832011)(41300700001)(6506007)(6512007)(9686003)(26005)(186003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X6Ae0N4yJsb5zpI0h4WWPwPi0II92hz/+FU1vUvD/df3EUTQQbKrjBkqRKWg?=
 =?us-ascii?Q?2v3JBnv/csPW87G/ZebMNcacPZbWef00jlfRh5ksfLma/HL9WMVajGcKcx2/?=
 =?us-ascii?Q?Hyp6g9jlCHTGvr0TRiNqSaipF+DAJXqkg/kaW4KGJ+RsuxUiKwGqsNAZvbWA?=
 =?us-ascii?Q?xOYHTbwAJxq7BoO/2pAuBYbpF0TC07SLgaV1N1WVa/NP2pPf5crHKZmW3BuH?=
 =?us-ascii?Q?YXjPpEy0Hqsc8lB3BiKcbCOLANlMbAbanh69iPxnSV7HdTXesfmPaDMfnyeb?=
 =?us-ascii?Q?XFhQ4r5mDI8yFJHF2ZrdClVBpWzM3kjqHgmblUYahXEN6jhxwTKqpsV2pLWf?=
 =?us-ascii?Q?VBCkFzz0Q3Ydx5jVJ+SMfF3E4xApGlnKJo1hHJ6EiwVQFScMopFuDKwSwtTR?=
 =?us-ascii?Q?Bsv366TTf18MO1eFEvsOidXivv/c5lix3fqCANofPeNUbAPeB8YbkXKvYF8Y?=
 =?us-ascii?Q?Je9w3pux1ta7EkY9DlY2OpMyiSRXRbKA1ajsBvg+jGt8+HXSIZNA4k8PrG+h?=
 =?us-ascii?Q?M9l92FEmEibHHmsU9qN2cHzUgz5UACVWYdldfuadrjAKiYzXRNgLjfXWjpom?=
 =?us-ascii?Q?m53zw6ZXsWZ6xRnmgbE8b8PC88qjiDquWitDlMHVrUEce7uI3GBzQcA4v5zS?=
 =?us-ascii?Q?9SGWzb0IgLqpKny6dszZ1zAByUf5999sGuRDE1TtUisxUagzrhgTVKY4VEir?=
 =?us-ascii?Q?836xDDpjRF8cPgkbiGXq1lLJpttX8cRfbZiiXifOHdyAGa+iSeYE4Z82jNrO?=
 =?us-ascii?Q?ijqQ9rNkgc2DcjHH65l2Irv1owM9dyCFMmx5JDQ4r73LnDo9KSXM9YEuban6?=
 =?us-ascii?Q?wbgNKMeZdpeckunFL0UAJaYrVIBaHwtWcW5ACgUuqnb/mlVGxT30Awr0hCzU?=
 =?us-ascii?Q?wrMp1qbqEnm6OslzRQsA147CBPUINi8yA7y7CXgofAtk2E+xE4Qpx0lnbxga?=
 =?us-ascii?Q?cePIL+uohrzpFU8JVItWzCAfSX/MAaRsoWpbThHzW2fgWbXM4hS+g2jKukxK?=
 =?us-ascii?Q?syCKM271j+uuIMM8oXWrsQrOmsTPkRwohGTCBS4394TNcjswbjUh1JBT86G8?=
 =?us-ascii?Q?wH0lLDGioGsMu3YlRpKI3KA21+KT5GPq8NK7SfROERsvWln9fBj9rtN4sCBn?=
 =?us-ascii?Q?ZhmSgBhyzjGUGj9QEUPn0jHkKxef6PbOFWgzpm7fUIlNdlc5WssswjFtKpZ+?=
 =?us-ascii?Q?52GK5MOoMp2YO90+DUGH1vyrOx3Ic2oCmwyCKIfzFu3s0Wl6/jKPT7G7H/tm?=
 =?us-ascii?Q?MscsJdqWYVz8IN4CeaBb4dmZFQghDGBr2thehl0/uSCCUFp9HxfuF1pQ8Kpg?=
 =?us-ascii?Q?KW89MIsae3Lr6u6u2zMauvitSGeBxrFZ9pOFATSp2yKFdiZ79lSoJ+E7ggl0?=
 =?us-ascii?Q?ep6YwUP0DUHFXkhGrjmb878VkzcncUoUTNSlO2WLt92pPD48PLd0cQw9eELK?=
 =?us-ascii?Q?DynxfpIuL+nLgf4/eqPxkPsdWE3HaBi7jgUHlzhwlrsTLq5Nx2a1h8ks5Ymh?=
 =?us-ascii?Q?Kx69dAAiIjtv6WWzu2QVgn1QZ0WuJfWprFxLAh56pr6b+cVrUWuP8E8Yg5bD?=
 =?us-ascii?Q?EaOcfznKx//I8hW8STfLjD6TbPSFvnEWQgTwSX7OGgWipFKZ0+hLNb3FiR2B?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5513ba14-ec9c-45f9-3fac-08da70e98cce
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 22:36:01.9770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySrqmRqqw7kzwjiOaXyqgqhFwVRWrfIocJeGp2flevvg8QaUtrVy9SJZQBjJdxjFKsUDGKu1TI8YoiJW+7/ouw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1523
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280100
X-Proofpoint-GUID: 45htpJWR0ApqD0tSZJoooBa8mgaYAkSV
X-Proofpoint-ORIG-GUID: 45htpJWR0ApqD0tSZJoooBa8mgaYAkSV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/28/22 20:19, Miaohe Lin wrote:
> The return value of set_hugetlb_cgroup and set_hugetlb_cgroup_rsvd are
> always ignored. Remove them to clean up the code.

Agree.  Thanks!

> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/hugetlb_cgroup.h | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
