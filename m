Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F0E50E3A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242584AbiDYOwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbiDYOwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:52:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC4725CB;
        Mon, 25 Apr 2022 07:48:59 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PEEHMh008853;
        Mon, 25 Apr 2022 14:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=c0k0y+n5yqTWRjW/akEt50Pdm4qjSwHcIt+Sbjk9yag=;
 b=Z5vM7auXK9awCKT22iLZhzLEq1JgGs4CsxM7+Hwzu3fs4LaSLa0OTeYfo1MBljCDoouE
 QvU9I/toQOR7uAHrHW1WYCd/CTfWpxiN7UgeRB/yg+aKSnyRv2PrZ5CIE1RKimp7ip7i
 J+UiQ6kq1zwfw3D/wukaD/GZ7x6Q/pBcYJyW4Z0aOT7oRwmWLwxdb3kpeTCST3pzwABR
 QKHsB6jm7DPsc3Rq+xSfjoV+SWaBOOfZ9yyW1vyUkaDUojTRXTDLaqUoAKEaKNWRSygs
 zH5MATIoCuBRDGe8erEB5xJuIVIrtec2kme+U2pZ42jy8qjDHERhz/z2yiPyikvULiwX QQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yuap6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 14:48:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23PEf5Cn024590;
        Mon, 25 Apr 2022 14:48:34 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w2e6tj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 14:48:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2gJBE0O1EJYeAa9iQazIlk8rDD/V8uUoffjkmL3ltQHp+cIii3+2QG2Bl+i8S1NApiOT5NIzCCdJYvDyl+ZvTtAs06eT+nEzNdTg/qBrrD6xjYZuU64/Hj5bYDuR8oVz66c9mMAZa4l6CtXPzGwTMvMAfSUF2G/tJz7I0/4nvieG1SLpupyNXhQqyyuZvbcZiXuOlmcuZsvXAG6QOZSA/Lud3x8Jfx27kH1IWFFo07I0JcXAqOn3l9rUg55A8qZ0cT4kYJKMwRn3QphntyXRUcMgCBg1YFvZzlCvbNP+Z93YHEl6pRzesTgkG75G+KR6gcNmFqdM2f5yZ7L1b3FfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0k0y+n5yqTWRjW/akEt50Pdm4qjSwHcIt+Sbjk9yag=;
 b=RY9Ug7DdQCr/jwthx7gFBol4maLoEMNYPXdFbXJl1JpcdIPuGzl+2pUbZ/1tPriEr0qd38lHk/vWfa7tr0W1IwYaO7WI7VMJqus7RDzWBuDmvH4llB+eGqohzZZjdeXMpxqk0SMUya/3CnaRvcVcw8446byoWf4MaUxPVbGcwQQ2mNoXQR/S6XSt1k+38Z0DaZRPzPTwJHUOdOUcrUdk0+/mGPTzmPy+nHUfL6VtDj8XOTvyyp3pwE1vfxZANOvNwFaiBZa+gNIUSn3fui4hV6aZVyjZpXv+oAAZ/BRGw+mIeYBcLQ12LwwSzfgEbYwKCQulTl33hSz6apQlqVo4oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0k0y+n5yqTWRjW/akEt50Pdm4qjSwHcIt+Sbjk9yag=;
 b=P5CD/xEz8zcI/cD9cxnFpONfPMYQHAbvK9RnEyZGTbj+02pjUinPiIsc0a5pl6IzLXArcm59fvHS5Z4hYCb9VBkx9s+p1Ld8CCUVke1tw17m/yctHh1HS16ac7M9Dg8xxPxIcFRjhXJTRmkMocWgZnKl6fx4woU+Ti346Dc6LFU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3464.namprd10.prod.outlook.com
 (2603:10b6:a03:126::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 14:48:32 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Mon, 25 Apr 2022
 14:48:32 +0000
Date:   Mon, 25 Apr 2022 17:48:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jfs: remove unused pointer tblk
Message-ID: <20220425144804.GP2462@kadam>
References: <20220424161330.1360068-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424161330.1360068-1-colin.i.king@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: CT2P275CA0005.ZAFP275.PROD.OUTLOOK.COM
 (2603:1086:100:b::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65bbaf97-262b-4824-4f2c-08da26caaac2
X-MS-TrafficTypeDiagnostic: BYAPR10MB3464:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB34642C834077DC040CE600158EF89@BYAPR10MB3464.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IZ4IbIrzQU20jHWhhxOQPS86+zzFyDPpcSC+ZYF4XbxEfJyIXbOAYkztNSp8JOn9T+5y/Y4a6UdiKRjperdDVQ/kTmdVd0oUnfKFiAPJTvbmd0j8PljbLgGEAJuQ176T0hG0A3Jw4ceXt2qqdSuZ2o+2LSdbDWdYN8LPHqs/p0Gw+32acXRFV3R2+G3Ul+ZmP9dbgDMhvE19JyZabaDv+j4Dz+3/heSEUTvY3pNCjKNjmZ6/qKIGxsXCLhR72ziDm5pQCz0/C5s1LigOKUo9pVhTu0kuAGsmCEwh2jjqvIAHgemHz35plBBVzTp+9/hOJgPopPdB7jm2o/pz/kgAsG9Y0XwLi+sGpUJnDRBU5Xz99aXF7pwbK6QCB7Wgp/CLfv+KWE9yHp8N9b7VHJBfjEqoK4SMIt+alicjUNUXOleC5bT9nID32btbIThYwTiuP56aFjfR33+nRt1GF400atPhoRnvLDmKdNbGIDVjFDNFtaoT+2qWmn6N1bma5mEUQamXGZa5O5+LmuBsLN+6Mu7hkf4N/5zNYdxERYOXAlMq51n65rhAOEMIX1Jk321i8Yf1YZgwEN3P4HuSTMBWjvRCDwAwcy/aIOSP6FyOQXCliHDX3w+y5oe943ciVD8Btf0aGYZYfEMtgGxeMZf0Q9cnLD0MTts4cz9LiJi+ZP2jLMe4pXbq0LEqvls1IbApqeIssbMVu7fJaQ2GmnECVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(6512007)(4326008)(33716001)(66476007)(66556008)(4744005)(8676002)(9686003)(38100700002)(38350700002)(26005)(44832011)(6666004)(6506007)(52116002)(2906002)(6486002)(83380400001)(5660300002)(1076003)(508600001)(66946007)(8936002)(33656002)(316002)(186003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4O7jbtkmJlhrqhnD7dItLQP2UmhFVFvVHxdro8G2uPJBwn58Jvu5vDmW/nyT?=
 =?us-ascii?Q?bAybDwheDM0erdkYpaLTXaswxgPCVLov2JkuXu2c3p1PJuSnosnxKeYE7R3J?=
 =?us-ascii?Q?YsdvtVutcDwl5Gxh95T91NU+xZ65Jjis9mG+148FGJwDm9F7lKVWOJokLItY?=
 =?us-ascii?Q?oxQfPt7rB9feKY04UlNkQkG3E2UTSjqTMfy4/R7ALA/FvSP8t9Dzt3aIhW9X?=
 =?us-ascii?Q?LVabVXLKybpb96Q59HP6+ogVY2Z6Swdsj0qomAOE7hfOZGFYOwMDwpHXZe5/?=
 =?us-ascii?Q?f4iQ5gFAIp9ZuPx8JqDEUc6/H487Mg5ap379qjApLO+cr4jRzEyWy57ssX42?=
 =?us-ascii?Q?17luzm7VMNungM0rh9L5Po8kEj6++B7k1G3NBdZgbZEdqfhfLrhWSG1PihEB?=
 =?us-ascii?Q?Li8Jk8+rra4Tw0WFAeek6cDvFv/D1WC+FU4PffqdsbR7fgBrYQFfPSRank9v?=
 =?us-ascii?Q?QmgSVIT6XkRnhWNKfxjVwRKUsLk2w9K0LMALPFJPy5HQcSll+kgO91cU3dzk?=
 =?us-ascii?Q?k4KK4oXAooY2qSuIGLRXJogWtBR0h3q4Fs8brf8TO0x2uVZZKe36Kt9EMbc/?=
 =?us-ascii?Q?pAVX3vk+4RYPuFDdaqmyx1fXOR7uhHI7g5AKL7j0Qwcl1h7Q3KrMNUWFqwwZ?=
 =?us-ascii?Q?ylCpwdQj3APVev88M3eSphQ//sfShCUdBLscZE52qLUx97vpoHHCCOMjAnra?=
 =?us-ascii?Q?5PSQyYtdH0Zebn1lW45Hz+Ku2Ittuyzm2QHcAGz/6tfnYoEwgAvxv9Lbl54a?=
 =?us-ascii?Q?Aa3USloCOAz29Q/osK16fWmO+ACtHR4IK67kqKA+uW2I1zb0eWF649MxFa1k?=
 =?us-ascii?Q?moBvfotnGuwLMaAJRvy1/U5kbsM3kzh0JvV5z54FdK3z0ltBkXgJf8nOvCu6?=
 =?us-ascii?Q?LmhaRe3LZgC0x+mS8hYPf/r90uD8DHXcDueHceJonorDA6mklTYwBnfoNRAF?=
 =?us-ascii?Q?JIWBSt38vIesi2dFdLLcgBwRAYm8GgLlVZJOrp0XEgig/T6Pup3S/uY7m4ea?=
 =?us-ascii?Q?veVVITTbSC9dpOAALBMPbCCn1jQBGKtalA88tjPHlrPEGXYxCciMoW78RBni?=
 =?us-ascii?Q?0cF/tOXhpoD59oPGko+XOvLWAwIKzVKL/oGr1vXLwixOZrlC32vLJim7Kdrb?=
 =?us-ascii?Q?GW4qJxfH7mSLhRRU0zEzy3eUbuzE27pGTbT4wn15qOee8dSvRieqLMPnpDZr?=
 =?us-ascii?Q?37KIVwFwdJ4khbGwWusMUpA92LzCBhzk9w09o3ONwu/2ch1FadDDALlpBAv+?=
 =?us-ascii?Q?S1Kj+nTq8kVxyoJNquas9qbzmoG/3WhU7RbkNw9iDM7cAv83Q7xqQH0tUFLk?=
 =?us-ascii?Q?WYlhQ33xq/SQS+lZwWwvo7Zoy6B+n6122U1pP452ERLLUAqtgaCLdTIIaSsL?=
 =?us-ascii?Q?bCw8uIDwVjLEixODJDyTMI64aT5bq4pq7a2bSTcLWxO47kS+/Ko1F24g0ZQ4?=
 =?us-ascii?Q?LqlhFCJYQ4cXhE5Ns8prIvucN8Q+kXZscO/fptlZkES+oUzGvrOR8RAQn9dH?=
 =?us-ascii?Q?6a6En2YKwTKacQrj0bbHmOR9WKzU6E33vTtznsYuWIDYenv20ntcIskahoxn?=
 =?us-ascii?Q?yF4b5r9Eouhgt+j0Ew1GbLb/unpcwAFy1UwrtaHHgmoiBMHJOrWEum/YFsBC?=
 =?us-ascii?Q?0EuKWmxn3us7nSVuyrzn0ie+KKpExkyf4TSCOS4qde2zdnKV1qnb3iQfb/xi?=
 =?us-ascii?Q?v39MWPesuQY9Ch617Vtr49mTBPh5NSPz7G3nWaDt/alWSOABuHALoQiEhrV8?=
 =?us-ascii?Q?xshYijQUuqjMBIoEgHBwHbO3gNNHZR0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bbaf97-262b-4824-4f2c-08da26caaac2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 14:48:32.3018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKTHkGnbfykO98q+e47rBdsbQOCSzSu+XPWsOX5HlZL/SK8JwDtLc2+1Khr0wr2hfmvo5bNHAGvSDtU70tEuNR38u10zj3aISqn0UKpAwAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3464
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_06:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=961
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204250064
X-Proofpoint-ORIG-GUID: 0atZGpmeQTD0s8T7LkaezRRyd7MUUjbi
X-Proofpoint-GUID: 0atZGpmeQTD0s8T7LkaezRRyd7MUUjbi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 05:13:30PM +0100, Colin Ian King wrote:
> The pointer tlbk is not used, it is redundant and can be removed.
> Cleans up cppcheck warning:
> 
> linux/fs/jfs/jfs_xtree.c:2551:17: style: Unused variable: tblk [unusedVariable]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  fs/jfs/jfs_xtree.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_xtree.c b/fs/jfs/jfs_xtree.c
> index 3148e9b35f3b..d29979d0a6aa 100644
> --- a/fs/jfs/jfs_xtree.c
> +++ b/fs/jfs/jfs_xtree.c
> @@ -2548,7 +2548,6 @@ xtRelocate(tid_t tid, struct inode * ip, xad_t * oxad,	/* old XAD */
>  	   int xtype)
>  {				/* extent type: XTPAGE or DATAEXT */
>  	int rc = 0;
> -	struct tblock *tblk;

This would have caused a build error if it weren't ifdeffed out.

#ifdef _STILL_TO_PORT

JFS is an IBM filesystem from OS/2.  Apparently, this stuff never got
ported?  Probably we could just delete the dead code.

regards,
dan carpenter

