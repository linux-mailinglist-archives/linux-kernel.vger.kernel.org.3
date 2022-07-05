Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1AD567A6C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 00:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiGEWyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 18:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiGEWyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 18:54:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1559BF44
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 15:54:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265KwmaN023549;
        Tue, 5 Jul 2022 22:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=/rLVt9fwpK6geHbReXrATuudAPBDq+5Qqfkk7ZXy1+M=;
 b=HrwlhrOSoVoeyfVffVE8cAy1xrJi1blhtG3YbeWBuoKsJjvYrH28gzL7faatnO5dWnTp
 Ks/H5hyQXC1x18jEnCg4vJti19WAgfHYw8xW/2QB77e6m9v/nw5XTbq60h2jbvdIJN0z
 QV4mQe/MPJpDzdfUAcwuHK/vfd1pMCZHMh5glRGmnT3i+/yC6oKdOaTta8EsRKZxE4x1
 aCvPOUUG3K2laH1r5NAQXim44cIWinOaEIzhlzuejNKemeyqGfpsHtQwU2gM3wXnXKW+
 8M/LO6ee8gl2GZ983tmnPEF6zPelOjU2E8V79Wl4yqcxrUpkNs9f0eTqY6H6B12+iC+q Kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4uby8d0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jul 2022 22:54:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 265MjQge020520;
        Tue, 5 Jul 2022 22:54:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud5kf6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jul 2022 22:54:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGQpMNH2fLxzo+rJZKEZ24gSxfeggiodY3BmYFeL+iulr1/DBjdBO6NGi3KYex6sw+Whdhx7KBzWGuhEiY7i8d7i9tcJnev6ZwcV4bd0UDRt1MhXwBTS37mGl0PRqE5yWd3EsIubgXPGZsjJ/qSi6NGr7StWUbWJg1lVCv2l5sNTsXXdi/yVr49azgwCUjcNu/yq50XADRzzyClD5PL2ek8qBct7vCslHWPhM3XcoHeT7dYqZhDxz1Q0wgTUXcxSAk4zs6VUVCXfckmL++guc5Kmc7CK2lAq4zZXNy/47+LTdcS3FYc+u37JtZYhvjY4LC9AtC/58UATayvxjpPqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rLVt9fwpK6geHbReXrATuudAPBDq+5Qqfkk7ZXy1+M=;
 b=gZrtBvLeoqOmoU0PMeSaVvbCS8OBMFFtGFyQIHCUG9hboW4fch6UIXpjIViXzcWnj+1u1ogO5zh0E+TMc4Goc15Nys0T9uPPCB4ojCXDdxeMlTxYlLjsWySMf0pTtkr0LyjQ8S9W+PBA2uMAJ82mZT/oblYap19a6F1YUAivYtshOF1LrhwH1xU64bYBmEZB3NM6JtVnlo4161elqwifOyno/ruz8sxTV50R4pRwZMPFXlgUjN948DBVk4qeMqNuwZnr37ejw+85CSlFZ3K4FeLKDILbfanTnOTalUGGcjXW+8oMfJYUK280868/85BAe9qYI1/Di6zaS9Zl1l66xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rLVt9fwpK6geHbReXrATuudAPBDq+5Qqfkk7ZXy1+M=;
 b=TAWLRpHVlAZY0+CmSgaN66xPdtiqB/wMbJuATRDM8V71tushcxU6SjGKxm+EMu1i4kbhRXsMbQoXbrtuBHH4Q9ZysPl5q83fbSqDaAPxyiFo2ssXGZuWkqIUhEX+e9hpo960ypd/u5NNgCcK92s55CiMC+7EM1npLAVcJUx8XcE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN0PR10MB4869.namprd10.prod.outlook.com (2603:10b6:408:121::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 22:54:27 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5395.022; Tue, 5 Jul 2022
 22:54:27 +0000
Date:   Tue, 5 Jul 2022 15:54:25 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm, hugetlb: skip irrelevant nodes in
 show_free_areas()
Message-ID: <YsTBIWFLiHuc6BRQ@monkey>
References: <20220705092120.2158-1-ligang.bdlg@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705092120.2158-1-ligang.bdlg@bytedance.com>
X-ClientProxiedBy: MW4PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:303:8f::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5a71403-63fa-4699-d036-08da5ed9505f
X-MS-TrafficTypeDiagnostic: BN0PR10MB4869:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mrbbOftkF37qEqUMyd8LTBIS/pULZnS77mNN/t04WaSlG5qBHXEU+4II8S4XMYr1+YvhGtJIplKtYAMK7x9cfghUc8cC5LOb3Q/KjuAMwJtMr/EL+M/8k1G4EQVtGx3wJafdS17sn6inzNEfDxnUkZiZUZtnAV8Ie/I3t67iJmFbQfhZUukzTivGsQMUQL41qZQ9gI4sI/BvfbcA0FRz43sQw8FrYFwrYIvPhC7da59qwqQumkypDll884wXgUAjDU4XndZ9Z0y2xd7Hk5Nb+ha1PsrJapdHVmEhPiAjJQxRy7GsNJU7RDE8nblclU8Xr2rxvBPC0xGDeLbxHK9tS/kiDVUqgT6K9/57Eq/BTC+6PoSZVjYAhIAz/z6C330HS8rzZuEtyQh2Rsaoa1nA/m/8mijpS22S341xc9KKuCBpivvGifupwlpFNETYgc6YjIt984zQMhzYFdxsDkCfyO0D9cXvKSN9ysw8eQBGfKXjoFpQnDx/oFDacA60oaKL1B7oKdWNXbVSEoOkfV3DLn+up42sMzuU3DuY1QBgeeBjbNEAvV4Q3Islhq4wyB/UBk2TgmoXmqIrRxfMPrrCRBhg2BZvBbyHf+ISKCHZPbTXyLmAyhd3L7g9ZZdmHwo12fnJmMPQPF2oveZINqz138vfQ/qL/Arh/oyWl/PQS3u1xKs1cxnRsjVhvUe1ytLWomYLkewlIXxknfdKDIICjqQJLxGDqYTvUjYZOwR4Ve4nbrKrx3Q2u3v3p9Hh6dcj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(39860400002)(136003)(366004)(376002)(33716001)(6486002)(86362001)(38100700002)(8936002)(41300700001)(2906002)(5660300002)(4744005)(316002)(44832011)(83380400001)(6916009)(478600001)(66476007)(66946007)(54906003)(4326008)(8676002)(66556008)(186003)(26005)(53546011)(6506007)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nWtHGVKXQoGe7iuhedARBySJpIXCA6KP0bNKFXZRIRikZnfCGNOaXD7QmP7w?=
 =?us-ascii?Q?O/j2KdmBEXhSC7l7B+U5gxL40MgDwxSWC3vheQacLh4Lgdh1enM6zs3HXSRK?=
 =?us-ascii?Q?aKHfmEm6l9lJ7hZ8+uL5KS+GWn1Yx70e0w2as3GzenuzklifiOPZaK9xbfpr?=
 =?us-ascii?Q?wINVVkyKUv2P4ZHyOqBcn0/Ii7EhQiq9OxCMLo7O/a24aQi+S8Bm+igz9g9s?=
 =?us-ascii?Q?ggtLUfGubL6jH1zmELyQ7j6bOOJgWoaM6BOQWDsWhCoru0WopHnFsGdXzgip?=
 =?us-ascii?Q?qV1yJ2ZpTQDekR7KoQaf7ZGcvVpj86rfjkLbJXVIt0ZNTZcrtfTav8Uf0JmP?=
 =?us-ascii?Q?Tw0YGNyAoYfl/fa6f9w37MB9uIINa+yJQviRLG2uJ0JqQfSU4X1a+xrcTTZe?=
 =?us-ascii?Q?aX1DNtGzG9nUlfzwjRLAphmbZGk9x7UOPME3urXwdkkJJ6Q7S2Eb1PHLHiQs?=
 =?us-ascii?Q?AYriJec7M84e0nRjfq7yOCaxAb/E3iSh+p4h3NL3Y9jXV/W0ck0TdohJAyjz?=
 =?us-ascii?Q?whGM1nTxKwLvXhbmO4+ErhIhrYXhbFU8f/p8X6xO4bKoGJOtCDofDKHgRW56?=
 =?us-ascii?Q?prLVXlazpxMe1QmMUl9lEvTHJro9xjT6TfrsWA80n7o/9bOjYLoC82woC2uJ?=
 =?us-ascii?Q?xu+ZDfMcFdG6Feb9tk1O7q8bJeGr5g5dfaGxdW5eqPer4CW09OiQXU2MwLCU?=
 =?us-ascii?Q?ILWzMcY+CXBvzo7T+vsewiX/bF1gAMbWYA53XoUBuEb721gpFfQ7l1VvWvr6?=
 =?us-ascii?Q?7bUer0XERIcDXx4jeGtXaDUQf0FUilJ4Ly56bP51Vxxk6YTikxCaaqJOtZfN?=
 =?us-ascii?Q?7JKF9C+uMq5J4n9NYFu8cf80oaU9+gv6kqaAZSSbtnudM/xgzb6G0IDvD7/C?=
 =?us-ascii?Q?Jo07IBzKG2KOh199+P6BINPsJSS1+BG5KclXoO7nVBPigxbHnBuQvgwIgY2A?=
 =?us-ascii?Q?FRIXu1xw3JcFjzx/tS+YpUKonanMjXGXnAarMU46vR+2sFp0keldBQ8xgEr7?=
 =?us-ascii?Q?5sQ9S8jriKcnuWqu3MeOwVN5O0bEUrc2sYSqaRfV/67wWmPwJI4aOre4LNii?=
 =?us-ascii?Q?PuMFlLW0x4KuEFKm7MlEruAOte9ZVgPTyAUQ2YC09DfzqR99QWBPlgsnDItS?=
 =?us-ascii?Q?V9lLTjbuEHmZDIYUdUEpOb/ONZCd5dLixkV07cr3nILLuhS2PmrMP470aG2r?=
 =?us-ascii?Q?j3tR5bPFA32hIRsPcy/u7XDu038WQm1eagk4xgXlUGOyW+MfWAdpNpF8PEFA?=
 =?us-ascii?Q?mLi9unVCIVy+AGzaF2dRLZRmvn2I6K7gCp+vDxmPo3eAOeXMgFQIQrngaa7T?=
 =?us-ascii?Q?5Rph8IOgSlGGCO4xJSvneEfXPjL+PIsJ2vdvC8S2Z0D/dsZsrJW5hUhVwgn2?=
 =?us-ascii?Q?aSTnPR+JC3Wh02ltHYuvtcPp6oNww2VnT1+7U7s8Q4CTQKjXmJHeHJdLy+lH?=
 =?us-ascii?Q?OgPF1FhoX6H3l/Kxu7Wh0RbKeveydMBrKLZ6nputjJenorIIHp73Q9XCWSCP?=
 =?us-ascii?Q?4aTx7b8kujzQuO4N65Dl/+htRomJbseP30yJ5JO+PItNKaZYistb73SvSvTc?=
 =?us-ascii?Q?Kh/q2Jncdgoa2oP6DP4Vm9guDDL/TfEGNGNwxOeTcjX31GGqTqTU+hMMhB8+?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a71403-63fa-4699-d036-08da5ed9505f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 22:54:27.6499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+Z8KJCLxhl1iWxSR099N4v5/vBxb/7C5H65KAjGpEJdWiiwD+kIwr5YoX6s0C1TLZaI+0oDyzxE4der7KkzkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4869
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-05_18:2022-06-28,2022-07-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207050098
X-Proofpoint-GUID: iwRc7p4mimcqiqXQUTx7U4zhudZulks0
X-Proofpoint-ORIG-GUID: iwRc7p4mimcqiqXQUTx7U4zhudZulks0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/22 17:21, Gang Li wrote:
> show_free_areas() allows to filter out node specific data which is
> irrelevant to the allocation request. But hugetlb_show_meminfo() still
> shows hugetlb on all nodes, which is redundant and unnecessary.
> 
> Use show_mem_node_skip() to skip irrelevant nodes. And replace
> hugetlb_show_meminfo() with hugetlb_show_meminfo_node(nid).
> 
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> ---
> v3: move for_each_hstate() into hugetlb_show_meminfo_node().
> v2: replace hugetlb_show_meminfo() with hugetlb_show_meminfo_node(nid) to avoid
>     exporting show_mem_node_skip.
> ---
>  include/linux/hugetlb.h |  4 ++--
>  mm/hugetlb.c            | 18 ++++++++----------
>  mm/page_alloc.c         |  8 ++++++--
>  3 files changed, 16 insertions(+), 14 deletions(-)

Thanks.  That should make hugetlb information produced by show_free_areas
consistent with other node specific information.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
