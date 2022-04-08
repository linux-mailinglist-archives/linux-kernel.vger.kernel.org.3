Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D8A4F8F13
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbiDHGmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiDHGmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:42:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9C5C683A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 23:40:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2384Aklp024447;
        Fri, 8 Apr 2022 06:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=amyHCSZYtwnxdvJ9Rub6TXLt3NIZmvaGuWtI3kf4gxs=;
 b=ePU7rw5YwpF9tFkLPX1+olh0xPFTpcejL4L6KIQd3iVkL6CcwYr97uoz9MR11kZ0Hds/
 Hc+kpU/7+nAI2vkxvJHKCUfyLEz1HjN3eY+65N8E10/NlAmipQ2B3eiEhtGwpeWmQ4+5
 LaVu693IoWrBOPv5rxXswjG/HBKYc8hPdVrt0eGCJyDkO1X/bzZ4/h1C2R36H8dVU+Ct
 En3ycpV8vDwcmnbAr60Gw1jRMnfvgcme5aU0g4ciE0QYIjyLu/kxLODtVxdj7Ht2yFMy
 5CIfBrK7e7GSu/wU6NhqV46P8+w2DBn+6e6CzKjyGPq4xVlkrN6cYSanL66IDWqgTUgo fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1teajx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 06:39:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2385qd6g009665;
        Fri, 8 Apr 2022 06:39:56 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f97ws5vk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 06:39:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXO5Rz4hSbjiu74K1tROVZr8O62tOSwq4DErouNtwdYBcGWUh0+W7NkKlJZHu7X5R4y1VMPCeBB5bysju3P8Aq5H0L/2nmIvae1Q/ytkQ/CkjgWFlYOe56Mpcdn9wObQLSctRT4v4dDeRu7UuPzR3tRUIedvNHT6oazFD18TWSi8ndmyrNaKnYrU8cdt0OOfyZhLSyoGttErkAzhrU7YSErOShPNK1+uqaUjb6/mhYVk6FGqDFvAhBWIJfKaa9/k3ESxyC1NmTL1D3jJwsz+zoGMuAPzt3f3hTSV8NgoCPWbjVJwmTjdClGjqAqPBJB0bMy6uaMpbnPf2ObeH6yJvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amyHCSZYtwnxdvJ9Rub6TXLt3NIZmvaGuWtI3kf4gxs=;
 b=GczRlhAxLgqcaaYvbQNfCWrMfsMsqBXhaNQWLiJSwEo9wUIOzX0Se0jgngI323mKIVskb4r+KTHcTzeEMET2Y4zQXgT8ON42ms0P9YwuuFu7qPj+rUmk6kkvSRnERhJionNV1ybnRaDtOK63TU5jMVMIIygUNHcD+zdh9shswx+Y30/LytWP5l2TP9EQlos9SK5tZavsksDvI+3AioykPy1JyULhLvCPgCb7gJYxKY1hrcgGl9ylnQGrZVw7cvGHfgTpVBahzKzjHaVAFKskRaushkL75MK5dXbfPF0kxMFUSvPt+f3W54Ll4nk8ecT0+1EXhU6m58An72Rztt1zFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amyHCSZYtwnxdvJ9Rub6TXLt3NIZmvaGuWtI3kf4gxs=;
 b=dgUbYhqzLJwlAUds2D9QfFtaAhCjkZXVfwTZeIZxkui32TD0VGuckQxIbQCR78leFwoug8aUH7JhpgnLfIVee1Yre+2BppneRL12WVLutIlv1L0Z8vob3R+KzrCG+/TamgQvGEZ/gPaJZ8mhsLaN1TvMMBNUIgpX0I5DR8pU9ms=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB4956.namprd10.prod.outlook.com
 (2603:10b6:610:c9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 06:39:54 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 06:39:54 +0000
Date:   Fri, 8 Apr 2022 09:39:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] staging: rtl8192u: cleanup of ternary and if else
 statements
Message-ID: <20220408063942.GQ3293@kadam>
References: <cover.1649378587.git.remckee0@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1649378587.git.remckee0@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0085.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fb73a77-7b6e-4446-6d95-08da192a9764
X-MS-TrafficTypeDiagnostic: CH0PR10MB4956:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB4956BFE3D785ED30CDD46C718EE99@CH0PR10MB4956.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kq6B6JGRaTE+pJkM8W58E37QcISGocTu4jBjH/Pxv3oqvZuGSqagkHx2+IRG1xGGWShcvPSCpeqp8tLvhLQ/y20eEwysKW+RPAB+Yu+WKF+B+tWKs3qS+erHBNEq1TSqr3i/qd2T9jlii3PYDC5dSc8lpcTJs9PVhAoa0PoRbnXWtzIOylokIFS1TQUGQD7RmE7K4SP2mq2FRDia3R7Fox8KUXk3jR5Tr/6aDh+oxWZDlofC0/O5h5vrY99X3fLlXwX6j8v16SwrTSgmlcuyVdKLCbt8su3E/7y7OXWLyQMM/FVp/nFYYQzolhEHfkx3oIFbqHPOo0XvjPJ1u9QXxqqsV3HGjjANEsyiWQA6pO+CtJR/bfReGdiS81djHxvf8mCa2bSFYl9t+tic8+AJ62EjSKvhHFYAZ3ahwnHtFL30KoU64p2N0e4pysYW/0xD0hSAHYnsWvUxKr2y/m7sS6WOW9dpdeCnoIB4vIWa9bvnlTWaW1mprZFddXfOvxeAq5zFFxKacF1wNSVTXye+h097D6afWxStdJlPagyYAZMmTj83BVcsRcdtRHX6cZX75Bn0u4wHP1dyXhEw+2mUPoSAZmWoqspPR+lnEIHVk3jLZkM6RqhkOW9puzDLq3CeUid3oTSRnvktUl0na6KDICq5ucLBjdqmzmQjE4FOw1kXUIJBYr86+tZlW+dm5ZVjejGPH0bEMJdSAWuAJVzDUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(26005)(186003)(2906002)(38100700002)(316002)(86362001)(6512007)(6666004)(38350700002)(33716001)(52116002)(9686003)(6506007)(508600001)(8676002)(66946007)(66556008)(66476007)(6486002)(4326008)(5660300002)(1076003)(8936002)(33656002)(44832011)(4744005)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?avg//C0NNXZU+PfWj3zgeyfztSPx0i+9dBMj5RydIAuD7QR78tmptts2TWVj?=
 =?us-ascii?Q?kAZfnU+ycfuLkQbd601wqXnqpkG4z7MSA8XqI7Oh1YpXrHVTH8Et4rQJlaQ0?=
 =?us-ascii?Q?0NgDP4eZuhpJVsx+5Z2AG5qwDzAccoDLn7fA9oeHo3tMsVq/f+K5oyA58TYD?=
 =?us-ascii?Q?kRTvkCH/qKDzrFsk6pfrJl0+LDBWgoI4Fy4gnnH6nA5dsOMf0iTi1q4aXx42?=
 =?us-ascii?Q?LE/WuH2CVej4dukCAgU2rSsG1SwodA/VlqDInesI1DHRambphmMqPmQWXSIW?=
 =?us-ascii?Q?qgzBCVGPDTMY0yaYG5IFvBeqzlvAlN6FUA7UvTJzK7mC4fyUE4kH5iotB+s+?=
 =?us-ascii?Q?DRtbci/TBmhSXaNu7g1DXHgU7Q51rzheIfvb0Fu4ynwMveIVYkJj7Aig8Ex4?=
 =?us-ascii?Q?OJ4NfnX/xIYl5OBKA0iNhLOWzJ3V5yNNfvb22WSCOPH7Kdbm3zEhwC7NsNIi?=
 =?us-ascii?Q?2Q83Wp8MLmk66606ZaFLk0HOQKKOA/lmi6dDogPOGmNx62GqekD4jnPcydnU?=
 =?us-ascii?Q?eAH8G11OxVJKpMO5hjhAXHdG2DDFlUAksBStxAGoJ6sd+yLM631+PcAqx3vS?=
 =?us-ascii?Q?A0PB6XB+Ps/30dRqV4pxeiV6YxdfSDhOg+uAcOcwlJXV5VheeAFkJFZBWdxw?=
 =?us-ascii?Q?HyhKZnAkd6xpMGOkg6eIE69cRUb4KtL2zA4DoP+CuOX+gJS4348iuF93L4Mo?=
 =?us-ascii?Q?JrT4z0WqNT2Qnka7phQ6W0ZFFmlhHOzR90znwA73Rv9K2fkbFh11R/kCC+km?=
 =?us-ascii?Q?upT5yWS1DpppK5Fl4ikDZ0ocVsbyKaAc73NqpSHVCJwnhYOI4K5zw6er+167?=
 =?us-ascii?Q?wASmnTpfQiY5fGSsGv/SFnrDZj3KCtnpLTB5gS5cbNlp3BXYpSPG+tdigrex?=
 =?us-ascii?Q?Fh+3E2UMhF0Nmnmz8lPiD+lW82wmPb0udqbI+2H/Uwek4W5OLaN0IGpNYalh?=
 =?us-ascii?Q?8zy9uU0cW2dztebh77Kz6fJvQYnbjijauANQGW+tdbc6jatwt/mr8IaE31ZI?=
 =?us-ascii?Q?BkKl5MmFwdkAv/Os67RVPh9/+U9HFaGFirXCoSVHyLTovjBTLhZmkkl+zESv?=
 =?us-ascii?Q?vYWL3Te7k0O0UzBX7B5Kr9NLqdsyBsue/SWPW6nPWDqvjV1ZMzVLc6Rq79Xi?=
 =?us-ascii?Q?pZUaqhKUbt0HV+qJ5GXbv0MB4mWzzYQnhqSBPdaVhZEnUWLB6n3SMRXeQxE2?=
 =?us-ascii?Q?qIpopttGJ9ryCTSzunE3M0r7M5jFiIpXTZY31YwK3VaQDj8eDOUhqeL4Iakw?=
 =?us-ascii?Q?WLzmVvlmxWAJC/cMLnjuq0NgQNakNlMkwyY7Fqg23fcs/m1eFSYUBtms+So/?=
 =?us-ascii?Q?XKdYcJbc49VhJGY6Ib2LGNuZi5u5+HQfQy8NDG0OSrEzBsR2+6Oth4SYebLY?=
 =?us-ascii?Q?NaLFUz7Vo0sRhWAr+zYG+y608n2UxbgubdAMaw12j1sITwtqYIfE1fOwKjWS?=
 =?us-ascii?Q?puwccP3UjWoyriYWRkQWNPxGc4czK8c5MixVIJQ1f4LP/jNU3yx34RHJk0jh?=
 =?us-ascii?Q?fPSGMrmVeaLRwEYzCYni+LLqMPIbejtHS0SDRrKxBtKECbuCakfbqcgLzCrl?=
 =?us-ascii?Q?02HnNVnto7di9aXhLNOM2RiTI+Jg8XBAuJOUB6TGrGhFuCxCHE18mHG/YEl3?=
 =?us-ascii?Q?8W/xHrA65CWO+aXoVBsRHjBqpIrcge77KkqsP77n6TBMjQa9x4/9kJzIeXiC?=
 =?us-ascii?Q?HRindc6aX+MVfdvJkb0oMlwqlJPTbkByFo8/6Q+dCK2yvMeAWWk5Bet1awLJ?=
 =?us-ascii?Q?eBO0zK3ft+VoBNtNLvDMhNJEX7FNLVg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb73a77-7b6e-4446-6d95-08da192a9764
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 06:39:54.6858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +a73N6bhs0UHZXIC+0Yy4taj7VZChFmZAwAujIVM7eCn2IGR9xOq0G+LnXZkgZORvV0Lk6emFE+SX1e7syRxLz2lLekoVGke62SDiThlQdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4956
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-07_01:2022-04-07,2022-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070064
X-Proofpoint-ORIG-GUID: b-2odTNODYfZS7L6-5ftJ-8ON3BeAlFJ
X-Proofpoint-GUID: b-2odTNODYfZS7L6-5ftJ-8ON3BeAlFJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 08:12:49PM -0500, Rebecca Mckeever wrote:
> These patches replace ternary and if else statements with
> more readable statements. Found with minmax coccinelle script.
> 
> ---
> v1 -> v2:
> * Patch 1: "staging: rtl8192u: replace ternary statement with if and
> * assignment"
>   * replaced max macro with an if statement followed by an assignment
> 
> * Patch 2: "staging: rtl8192u: use min_t/max_t macros instead of if
> * else"
>   * changed the type argument in min_t and max_t from u8 to u32
> ---

Looks great.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

