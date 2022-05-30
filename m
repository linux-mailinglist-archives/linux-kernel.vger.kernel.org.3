Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639F9537575
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbiE3HeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiE3HeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:34:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2F2712FA
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:34:06 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24U7DN0r019990;
        Mon, 30 May 2022 07:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=7J3mcwhrjHNqUx06bHTFDWovwZqsxOJMWauS/cJ3mlY=;
 b=NJWEN3gw318Q1frfN45JofBuecXV2UAJkneTbSSU2m+hcxPSj2K5rokxMn1NqWxrGy1i
 UWRM1Lfe4NOQyvr0+DVX/pBeZMEnBkLnAOpgyDl0W67MlHZL9EKGIxUSPXZARDE+lqe/
 3OloOQrd+wBUP3HgyUUpnJlygrnYzew7nlDKFAyrxW/xbzcMRpLSFVcL82UJ3r3GspIW
 vppUXpjGm83cGjdZyrv9TTjGhcXbOjfxUQ2orUw/aMeprxepx+8pWuvLog18zAI3LGLy
 51Q0M/IN6JNaa2qapNWrQM2x7xQ2+Aqf3q2tPgiWqLzv1Xrj2qdWKtYCw6a2vIkGbcS5 BA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc4xj8n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 07:33:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24U7Fnq4030657;
        Mon, 30 May 2022 07:33:55 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8hqfkpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 07:33:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4v5EXNdNk8p74u2rFI66eMWsVbWi5PjEAx34K3TBRzTjvqMYFOCiP9UigTPhQSl6FRungZrq9rCiCfyygt60UJDoBCHpqrXue6VVBjfXaLM2H/Xo76CbBs4JPM9dScMDi9ELMQrGzImUvnAkhj9DkIXmZQzF5HhYjVEk8Ebr4tyqRX2Wxgm/1dcgJNh8ILaNUByVLF7SqKq0kT8JcsIHnYrHxNbvqaUkBMwVnTw8fP9Ne10KMJy7bZxLDqqxor3/s73R7YvzbqrF9YdwY+aFQoSWmVrw0D9CexMmRhPKeQ20lY/r8+8cgiLueihHoBVj3EIWpCtXcA8IiJifYQQew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7J3mcwhrjHNqUx06bHTFDWovwZqsxOJMWauS/cJ3mlY=;
 b=A9MayCt0l82o3FB5CSHA43i6d+CZiA9O6ckMozMtmNwVoPzlUsPE4l0g4pMyPC+ju4LGd4OVIiqgK5trw8961n6ZejQgfm6ogvILue7b98oBCXlQroKJwiy5kaEDH8+sIok90u959OixL6e3ha6Y1RQEswzqXmY1z4Lhxdp+b4uco9NMpLKzJLi78t+AV6bbguKOsgrK1pSZYRtA7IW59GskTVo4DkLmkhQ92VCGHOFTHqafVC0OVtdakdnCwmIWPrNmNadGQ0MemoGDbGHGdQb/4+PlIJhT2O+kG4Sz6iiGUSGMoUnV1lT8DVdGtYmmgFgnlKwvzh3xYc2pHpezEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7J3mcwhrjHNqUx06bHTFDWovwZqsxOJMWauS/cJ3mlY=;
 b=ocso97f0npZNJAe0vdDNLJb6GMdN80q857FBip8TRIGgAsSAP+RwsTZgR0B3Rrx9FXQ4/RZ+YAb7oYZkt2M9tVkG7y44krfwwtppafhsf3bDAB7rx99WwwakLDaEIoLetiGUilGMvHhNbic4hgLP0yFEm1Z8UhhXIw/Z0oTDFac=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH7PR10MB6274.namprd10.prod.outlook.com
 (2603:10b6:510:212::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 07:33:52 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 07:33:52 +0000
Date:   Mon, 30 May 2022 10:33:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vt6655: remove unnecessary type cast
Message-ID: <20220530073341.GK2146@kadam>
References: <20220528202831.GA129473@nam-dell>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220528202831.GA129473@nam-dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0167.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::8) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7adb2f2a-d302-4827-1945-08da420ebe67
X-MS-TrafficTypeDiagnostic: PH7PR10MB6274:EE_
X-Microsoft-Antispam-PRVS: <PH7PR10MB62743F17313E63132F3FFF7A8EDD9@PH7PR10MB6274.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9jx1IAxv85JMlqmKzgLrcMGwphqJpTMSeO6dmrCi9QFiPbU7wTcm0WoLXtPl8jYzj3A14OKZ3HCuSgIvzV80Eu2GbyUmMUUowNvTHLziizgks/bcL+xodNoVbDALpiJlsiclIBMQDNZNr43B5nDrx9Y1VkDTSMxzATQHHDM6x0HhXr7KkjQzV3VPBQI8+YxOv7hdnluQK6siukm3/zV42PKRV1m7q7HGysiZftrQDoCKZZQse7iMdpvn2L0r85+q5XO5dbgznwzbomCtKNnrvJdKM1FpS9PIFMg4I16BJT0uylso+TeTgLQi6WzWndZFWBcHLRATEh2r148djmZ9KMUYD2gKhqPTAl+HS9U5AqRrqPgpNTNPE6xVfqc4p/Ujjsm0v21OrWzZPStInFH9ea+sWZFzq6h54stOU5bqJ39AvCpm/T/fItH98y/W1so+JfK9RvPvlozJ1uG02aghdxwOohUO07L8a1IpVgST6cdTnG8l1r4sfoHsylL68DPl3JJTToSrrI3r2z6noP9Qu1Ysf/ru6PY3QAtwPWgNzSZlKvb1y1YQ4ornE2LTk2c1kvZ4NXe38pYPkE8whHJK+VLfVHQQ+/rUl8cZOsDDd23Y9aJnQdBF/+mtOAShiXWa5f+SG1osV8SpWx3Xkh4VikN3EuWIVYMIaye6hLYo/O+a4qUbZvDASytG/XpE8fwIS1xg/7qZeOZLmkMr43uztQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(52116002)(6486002)(9686003)(6512007)(1076003)(6506007)(186003)(26005)(38100700002)(6916009)(8936002)(38350700002)(33716001)(316002)(66476007)(44832011)(66556008)(4326008)(8676002)(2906002)(66946007)(5660300002)(33656002)(83380400001)(6666004)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M4OdeMEgDe8S5/tojyuy58XeJlla59g0wgFUmd1gK+U6DdQuMZZoA9+laVfo?=
 =?us-ascii?Q?5j0Jvd9o+nUCeqceZvPAuXcB7qLwU/iQHzI4NtJZo5oAGxzFhoawuZyHYg9R?=
 =?us-ascii?Q?YiEffxfXnDqGPUEd25k1RGPQG2qZ7nDtRd/XkhzStvM4K3mseDYFIgq9RN2E?=
 =?us-ascii?Q?oeZru4QXmat4u0ndYe++AfkpXTjNPTvtG4GV0WNR+6Iw9qbTvLjtMjkAxfK3?=
 =?us-ascii?Q?teOmyBgSCXMoiJ9rU6ruejPpJ29JIsAZHQpJYt1eZz/3zdiQDRSislSZyvQN?=
 =?us-ascii?Q?ZTGhtQWjVltCJKbHJWDhtazb6QNT6xKj42WcCCVYgRLJ5/vkMzGiMHaqu2du?=
 =?us-ascii?Q?M87Yg4uJYsp9NwbTzh9+PrL98009UfMpC/fc4FUaU9UDsHobVK5qGhA2HS93?=
 =?us-ascii?Q?FyVsOPO/lHSmr4TnL174JnNLh320YpyyQRMBhJpvXgj/Bz+gb4fcvaOhBVjE?=
 =?us-ascii?Q?GghWfm8QVVcxSjc9sRgan5kxqY132Cc7tlQFwqr1O4r/mZjma9rethQvhUrH?=
 =?us-ascii?Q?FM5Mnr7B9hEPB+TPcoyIdTzlNj8o9k+g17RVcnh8M9hwnluLfqfsC7i0t2Xp?=
 =?us-ascii?Q?Wkqx5AjBWcL3qCqB6LzikKex1wAP9FaUHmPRvJ70VFvhVR8RWlWFIi9gsFi0?=
 =?us-ascii?Q?1/zazLA5QqagV63m3Cq6M3aCj8XjsAQwSpBERWZk7yP2ogogJYZTYmEv7mhW?=
 =?us-ascii?Q?ui+NsOdJIb+UiqvSBLreUwj0mrQ8aiMZ0UwIQ2/gwlKKO1oaNW7mvj+xbR6M?=
 =?us-ascii?Q?rjeFBIFPaSWmmdkZYIhnMyB1/kTPLnf7W33LjNqigzgbEeht08kVOrD5et5j?=
 =?us-ascii?Q?zZ7c9COzGmVCM3sAM6bH8g+PEPcN7N9N00OycPKNvVfWIJHbzAH94eoZtoeQ?=
 =?us-ascii?Q?Dx7+zRTu/hEsMkZv1nF46snYhNrBPmNgPqYgpjSj2fJQHl14Zz/Ni5e3HkDx?=
 =?us-ascii?Q?QOTrM3HVPttuhTEHBarikn0y/YmbNEm030gSk13UMRvXSjEFQlyqFksciFUe?=
 =?us-ascii?Q?v25sPUV4iJ8dGMOqraa2yxLng69JL4p2d1f9ezvcQsUS1gVVJrhTBPhV1Xrt?=
 =?us-ascii?Q?3tABzaBb8gyhvbWNVrV0R4QddBc5Ko80+hJW5DFAfryFEOFSNWTJhSVFQguX?=
 =?us-ascii?Q?42lU+FWTJkmug0Utm9h1H0uqfpihmnCDfS+dvzneBRHRLYGjhpHxNvyaF82i?=
 =?us-ascii?Q?6a9jzBEJRKbLGQ8bJim2NmTwoLFcPCerBDKJrNMogjT1W7eBmUA5KnnbEoZY?=
 =?us-ascii?Q?AoK2hiV5C6QI8NzT2nRD1yjLXcyKFTGKbn33HAU/0mDYxo0AxoETXX2m3az/?=
 =?us-ascii?Q?9jDRHCU+iwrA6gd52yQaI/gV3+6FMnh5GOn2VK2xYkoea6kEzggxyjGKhRz9?=
 =?us-ascii?Q?KjBsATaINyiT68nS97/F9X1oKcwKJg+UKVt9LpvFPxw2j2cgeDIpkQ+mSwtt?=
 =?us-ascii?Q?YrSq8V6E+RN/U+EYGKQTVvHQm4pmfoM8gJtz6agMsRfnIGRc8NCA8jlAcYJ1?=
 =?us-ascii?Q?+b9Yr2IQyIJgHO0vGD77jD3QJbJPfvYRWWQ1bGKKGWKeYLJ+RHONs5bBLUJ4?=
 =?us-ascii?Q?VBrwEQoXncuoQULq2bH6ti3mdKrC0zqLnvmAkG3mUPopB3pENF0rgz4GSCX4?=
 =?us-ascii?Q?kaj3QNb7IipyQwi8j/Evk5Zrcd0GxzLdmEluIsbzAD1zsc7av2SGP3iIPTuQ?=
 =?us-ascii?Q?zlqGEyihSctCqpEThRk84WQqfata38BOkDspCCzZkR+2uu40BlehP80ZKZZ9?=
 =?us-ascii?Q?hqwoo22v/q574Q5jrnl9qETfiggc1LE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adb2f2a-d302-4827-1945-08da420ebe67
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 07:33:52.1343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQeIqSWfkPmra3sbbTStwtRPQLr/rCLBT2c57v304kbKmbFg2MSxF9HAg5QXSRuM1O5Lpj9OyT04B1TLfbF2g2A7Qpa7VwF8pCi6KxTsKPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6274
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-30_02:2022-05-27,2022-05-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=924 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205300038
X-Proofpoint-GUID: O3-bGXFYKLZIDqXdznOzja-En_GdHpt-
X-Proofpoint-ORIG-GUID: O3-bGXFYKLZIDqXdznOzja-En_GdHpt-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not the correct subject.  The le64_to_cpu() is not a decorative
feature which can be added or removed without affecting functionality.
This patch either fixes a bug or it introduces a bug.

On Sat, May 28, 2022 at 10:28:31PM +0200, Nam Cao wrote:
> Remove le64_to_cpu(), as the type is already u64, as reported by sparse:
> drivers/staging/vt6655/card.c:758:16: warning: cast to restricted __le64
> 
> Signed-off-by: Nam Cao <namcaov@gmail.com>
> ---
>  drivers/staging/vt6655/card.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
> index 2cde0082fc03..852300c59980 100644
> --- a/drivers/staging/vt6655/card.c
> +++ b/drivers/staging/vt6655/card.c
> @@ -755,7 +755,7 @@ u64 vt6655_get_current_tsf(struct vnt_private *priv)
>  		return 0;
>  	low = ioread32(iobase + MAC_REG_TSFCNTR);
>  	high = ioread32(iobase + MAC_REG_TSFCNTR + 4);
> -	return le64_to_cpu(low + ((u64)high << 32));
> +	return low + ((u64)high << 32);

I fee like the original code would have been more readable if it were
written as:

	return le64_to_cpu(((u64)high << 32) | low);

This seems like a correct way to combine two halves of a le64 value.  So
the original code looks correct and the patch introduces a bug.

regards,
dan carpenter

