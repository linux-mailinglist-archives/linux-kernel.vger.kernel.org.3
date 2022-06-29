Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A098F55F255
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 02:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiF2AXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 20:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiF2AXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 20:23:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235A0237CB;
        Tue, 28 Jun 2022 17:23:33 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SMXxks010882;
        Wed, 29 Jun 2022 00:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=D0fJ8KQlZo6JPz+F8UBPvDU+Z3eiBoVnLKXbvVzVu7c=;
 b=SZ2M4KF5tm7r93A583aKdp29X136haKf30yyse8aRXBzhBJ0WNwAsTA5UgURNlbRZ+nD
 okDAWh7IlnCBaLWpg8ShU94MSTu6H4ZP4zlnjK+AOagnRyrnei4+FXji4ez50Qx6icNX
 KZqLr8CorYFGIUndiFbO7jfAQzCOAn843DC6oVmtRwEQSNFntSR2aufnZOvVunmmHJh7
 uPZ4yJItiSSyX4IZPD2p124aTHOB21H0v0cHoc5YrllZQNQp5M/SvnJfEZWsR/ytP2Me
 QFRTzalMqfK/tw+q08rq3Yo4EmlgBXH3Uzev+jIjBAxz1Beumw0zLobZcsdzPLC9yCw1 cQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52fsc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 00:23:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25T0Bo2x037341;
        Wed, 29 Jun 2022 00:23:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt8d6bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 00:23:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WalzjCcF1xRpuhDhkIu9bQYmK6w4sv+rwM6uHJpmgssCsVmLKdU79LoRt7/jZNLk6sU47NDcxOQZ8HqmYp4xYF793HcO0BxJ8dfP8SA4mYOw7HdkmNJnJw3I3/vbK4HHnaRcerl1ftpVdgcRwkxbkTTzL+aD/XXsqrx7Oh052StnCPflsF/kMZHSgIguHlUL+m8JFXxBS85TBQFby2KOuswSyGpThsHppxBZ/1TaqUv2/9y33IhigxcQf6Det3zFm+rTjPNlZBdFWRRrvIRf5MD2WFpP0KkINBKBNuVKMJ3u+k/4VnMQtpWbPZYzJ2PgGs8dfDkQABzLhAZCSLP7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0fJ8KQlZo6JPz+F8UBPvDU+Z3eiBoVnLKXbvVzVu7c=;
 b=LGYOWi5opFZ1jDkGeQFUEcNUHRsLYuMNYu0RrUoJrvYagY7Xx9zObS+LtRaKHTMzLZwxNq9vZ1wUd6iCtE+PlNcLVmby0ytGVRYehAUe1jqS600rDSo0j8zTODDCaJIxnn8IvxUJtuh6lGCgB6Nt3g+lVuhx610g2rvUMtOQjjKBM8jayKeNh67XMg2dhQeqnCN1si77+x2sHqK1m9BhJkxOntmjN99Ofcy02umGpIf8j9lvrKe2wuSmAXhEvs0k8NNTQxbjlv/GkibWn2+jpUYO5psaACDhhQNrMAJdnNckJp61la701mCfkjEml6K/kqoUZtk+Sqxs5flYSKdmtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0fJ8KQlZo6JPz+F8UBPvDU+Z3eiBoVnLKXbvVzVu7c=;
 b=PXLGpYqVN2waNjH10rWnx1c6BR6gH+vEUH+FBcDw3cHLoF8PfBmCn1uNu0bEbwhUAjBQDvMmc1GAWW3UsPafkFQRBFUGMvC9erhzhU0CCDZUYypxpGbX1E13zUQbvyWxDD+ZELGPeXyyFfL6kXUGwSuVa8AYIDXjy4AdM72N4C0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB2602.namprd10.prod.outlook.com (2603:10b6:5:af::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 00:23:24 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5373.022; Wed, 29 Jun 2022
 00:23:24 +0000
Date:   Tue, 28 Jun 2022 17:23:21 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     david@redhat.com, akpm@linux-foundation.org, corbet@lwn.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, duanxiongchun@bytedance.com
Subject: Re: [PATCH v2 6/8] mm: hugetlb_vmemmap: improve hugetlb_vmemmap code
 readability
Message-ID: <YrubeXg8tSxJeGxj@monkey>
References: <20220628092235.91270-1-songmuchun@bytedance.com>
 <20220628092235.91270-7-songmuchun@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628092235.91270-7-songmuchun@bytedance.com>
X-ClientProxiedBy: CO1PR15CA0045.namprd15.prod.outlook.com
 (2603:10b6:101:1f::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10acd7ca-10ef-4655-cbd3-08da5965947a
X-MS-TrafficTypeDiagnostic: DM6PR10MB2602:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 04jl9ZkJhzaWbBvkPdQvzzYFuP8QfWERbXcTdmFozSOHCNzKuDezrJwaL41TrXJoiyD7k9KxvsapqHojFH7BP0h71pOGdMKhBuTJXM1ipmMOLWEqCQs2mt9Tvstu51SOfjZ4UWnYtmVAX8FQiXuorWqR0657IDn4K8rK5U29ghyyHb1P1edwILhhtdbZq0yP9wGnRXTed5YWnRTHt6qURtqZae5HK1iPekx2cz53rYNBrieAKU7jCjUaAMP/s14Jmjw2/wx1JzOBto9seUJ3Qjsdjw5clR8S0SepwtE/Ix8YtgisDKrbAMHpWeV+/daTQNUyv2Fl4/pwCLWzeH9FQhi2/rW9+zy8uMqzWNE3VeecgrFymrXm9tOjX94P6KCqtumVxnNyCIlA/Wyjluyabm8XU39r8YAfr8i2bvGAhO3uNB8PQIwV0PeOJtKq3mPHXEzbV7f8sLXhTauYHwGXfELPV9btysGOkktH1g60E+XCtOPhsE71dkAUkZfDbewnfh9QtpZPcpRcNUlJBzHZDY1mB/BVWv+4nj55CN66oOYkwQrkrk6TqXfpNo11Uavmr06KBNOiLfrA47qJIoSGDYYXH11Hduq7A736gvS8LbZWBuvpWifPApewZ3AUGiMQd0gjNAFim0OA6/+6+xcgWVBEeWjwidEXVr7XIiUbuqE+ojFU2sujJyitoLBqz0VOCzkSwrAo+Ap1/R4JAkUSwAKTz2bt7XB0CGCcl69E+r2ePGxzPMg2orlLe8LF4MHLWG6QzgcdSsHP1g7poDh4qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(136003)(366004)(376002)(396003)(39860400002)(33716001)(44832011)(66946007)(38100700002)(8936002)(966005)(66476007)(66556008)(316002)(478600001)(4326008)(2906002)(5660300002)(86362001)(6486002)(83380400001)(186003)(6666004)(6916009)(53546011)(6506007)(8676002)(6512007)(26005)(9686003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fi2BEkcvN9HR5bZqbcZ1BMYQMmrNDOJwXNgQa6FsVXjJCKbv6Dj2YkoYS4ma?=
 =?us-ascii?Q?0x/vm8YyN3isBm6c+h1+oxTgBrGR1AM7lUgxXug4ctx1405sC9uyO3GWCd6t?=
 =?us-ascii?Q?OoCKaaiCI8I4Xz1WW7rucgCj72dSJse6sH8DbzY4gB8ROLJ4rKOJelIRmTab?=
 =?us-ascii?Q?YrUN1jzrphREiQ+p3hfmVlnoObx6NABrYI4MwjrblgLUq5qGlLMJyYMkyXKh?=
 =?us-ascii?Q?Sdr8UHYdBLp16DZEfW9oRiU5v1Nmsg5aE33xuZJphDvgrLx5ed6QWkI1fg69?=
 =?us-ascii?Q?Y9/KRGw44jp7Q1l2Z0vJeGoHKgcH90d71xgGgDXWAwUOmrCQt09DedLWDRnh?=
 =?us-ascii?Q?CyfHQ+rSeqmvZqUgWKxZh4zlwYyvfZ/mM3nDGh158i9C974BTNF648ORhtDn?=
 =?us-ascii?Q?XlprcPe1RWcsT6m4s4KvNXlC/JZaqHU57GQTDSW7F+EG4XFn8OuVBILJhsCW?=
 =?us-ascii?Q?kpn52Z2VAZb1gnJUTkwBRbmX74dzRdIVHblU7idm53z0Is4eA6F/D2mo+Lih?=
 =?us-ascii?Q?4XmGuXAoj3kYYXLbNGdt8nNEfl1cwfYjCzE/SUH5q63d/zinwV49kGW4q7HK?=
 =?us-ascii?Q?uYmdKT9Cd2eBlXPy7PxI/YRnSumDykjsPO037oqkGP+kmnuemDKzPWH0+RXt?=
 =?us-ascii?Q?8Fh6ohrRleEufhreZjNs0qdelbQWqrVckE96D0ey4H+YuVa0ryOvAKFyytPk?=
 =?us-ascii?Q?LKHQOKAxM8e8tILJjRf/ZTWLN901E6iw2L4lILJ5yXt+8gD2OHjBB2vlUlqV?=
 =?us-ascii?Q?369kp8A5w8Y0FTa2yQYCEX2gkyL0gNIfa3ZH6tqdI4+7EauQR4AA4W599J2i?=
 =?us-ascii?Q?WCRfUwx+M7LVt3qx8YaN0Ky2UkPKpjrKfoOF+nzXQrIiovmNbEwN29crFQml?=
 =?us-ascii?Q?Ewv03M0D/0uWPEY6P3EzR+IT8c/pK8gWi7vzRIbarsVS9aeuQY5cEVUc+2QN?=
 =?us-ascii?Q?1kocy7oMe9YFqtrjhcE7MvUvwoobw7OeEVHdyhngCfghKtiy1+NKHn+7Rme3?=
 =?us-ascii?Q?meJG/UuQv8nyzgJmmggYbO8G4p0jpaqZMgiRVzydjz/bFvbep+hIiBVj+v6m?=
 =?us-ascii?Q?gOI3m1fbEJ2cKv2/5+Elju8mthBkeUBU3zMwLOts2qnBNnU9z/w4fIUImwes?=
 =?us-ascii?Q?UaBoxFhNEXUKN7Vbf9Yd7Vwa+FX7D2dBY9jZB0i0lN9tS2SQpDiz/D7Yc9Op?=
 =?us-ascii?Q?Md1h80hwCGuIzuRDmNZbnXvTZax8re0oz5Q0BdRZRb4UNcLDqFhvbN+NHPf5?=
 =?us-ascii?Q?5+JXydk9DVxl9rqEKHqxrw4Z2I6lP6x49+W41WVDWuFHt+Q+GoAM3F9Z4FwR?=
 =?us-ascii?Q?3DsIiOllnJtcUBtjI8QnL3I9sYzxA2b5IOOE8Z+XDOzrbEI/wX8I6Bj0ZpcC?=
 =?us-ascii?Q?zY61QIU8whYCp1LK+dufDdpmze9mss7PSg5UCuE1SlGV70Eb3Rwd4QfhjmPV?=
 =?us-ascii?Q?6JL/YWSYa5NWfn1lJie+GagvVBxbV7ClY6Mg35Eiaas69CiDjAYGVYwdkcg7?=
 =?us-ascii?Q?dq3LGX0nUg8CtgR108ambeWhK9opXZcKB5dAqA1lFK+HO8D/2xbbivIPl0ym?=
 =?us-ascii?Q?aQE1XJ+B0Eg3gbir7wvXVaoVhRdTEMY2drREhEkmVEtlSNY7RY2gc/Lyvbgn?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10acd7ca-10ef-4655-cbd3-08da5965947a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 00:23:24.5553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1d+kl1EjVQGxIQuwLCSRThXnYIK8FSQasrCVRyerCB5busj5MfTlWstFHC9C2AuQflqoyCiAY33LHp9+WJb6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2602
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-28_11:2022-06-28,2022-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206280095
X-Proofpoint-ORIG-GUID: KFBjRiFcK3jNDIkTWCZkhvYCgCK7c5OB
X-Proofpoint-GUID: KFBjRiFcK3jNDIkTWCZkhvYCgCK7c5OB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/28/22 17:22, Muchun Song wrote:
> There is a discussion about the name of hugetlb_vmemmap_alloc/free in
> thread [1].  The suggestion suggested by David is rename "alloc/free"
> to "optimize/restore" to make functionalities clearer to users,
> "optimize" means the function will optimize vmemmap pages, while
> "restore" means restoring its vmemmap pages discared before. This
> commit does this.
> 
> Another discussion is the confusion RESERVE_VMEMMAP_NR isn't used
> explicitly for vmemmap_addr but implicitly for vmemmap_end in
> hugetlb_vmemmap_alloc/free.  David suggested we can compute what
> hugetlb_vmemmap_init() does now at runtime.  We do not need to worry
> for the overhead of computing at runtime since the calculation is
> simple enough and those functions are not in a hot path.  This commit
> has the following improvements:
> 
>   1) The function suffixed name ("optimize/restore") is more expressive.
>   2) The logic becomes less weird in hugetlb_vmemmap_optimize/restore().
>   3) The hugetlb_vmemmap_init() does not need to be exported anymore.
>   4) A ->optimize_vmemmap_pages field in struct hstate is killed.
>   5) There is only one place where checks is_power_of_2(sizeof(struct
>      page)) instead of two places.
>   6) Add more comments for hugetlb_vmemmap_optimize/restore().
>   7) For external users, hugetlb_optimize_vmemmap_pages() is used for
>      detecting if the HugeTLB's vmemmap pages is optimizable originally.
>      In this commit, it is killed and we introduce a new helper
>      hugetlb_vmemmap_optimizable() to replace it.  The name is more
>      expressive.
> 
> Link: https://lore.kernel.org/all/20220404074652.68024-2-songmuchun@bytedance.com/ [1]
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/hugetlb.h |   7 +--
>  include/linux/sysctl.h  |   4 ++
>  mm/hugetlb.c            |  15 ++---
>  mm/hugetlb_vmemmap.c    | 143 ++++++++++++++++++++----------------------------
>  mm/hugetlb_vmemmap.h    |  41 +++++++++-----
>  5 files changed, 102 insertions(+), 108 deletions(-)

Thanks!  I like the removal of hugetlb_vmemmap_init and printing directly
from report_hugepages.  Still need to look at your your command parsing
patches.

> @@ -3191,8 +3191,10 @@ static void __init report_hugepages(void)
>  		char buf[32];
>  
>  		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
> -		pr_info("HugeTLB registered %s page size, pre-allocated %ld pages\n",
> +		pr_info("HugeTLB: registered %s page size, pre-allocated %ld pages\n",
>  			buf, h->free_huge_pages);
> +		pr_info("HugeTLB: %d KiB vmemmap can be freed for a %s page\n",
> +			hugetlb_vmemmap_optimizable_size(h) / SZ_1K, buf);
>  	}
>  }

My first thought was "Why report vmemmap freed pages if not enabled?".
However, since it can be enabled at runtime it is best always print.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
