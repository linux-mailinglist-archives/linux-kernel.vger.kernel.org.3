Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D9C4F8E50
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbiDHGWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiDHGWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:22:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1166B1342F1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 23:20:11 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2381LAjJ000752;
        Fri, 8 Apr 2022 06:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ZWWMJHUk/6thHxryeg01tp7Y539MSbbrD8vucUA/j6g=;
 b=IFCGS4r/PM86mAlG0tAFvwlPpac68lc9xlDsIxkhnYJNGd0z1nRkC5dfO3JDMTSQUruK
 vCAVhYWONofGN2S00cKKdHG6KAvpUa4ZG08RYhRYXw0qJGIwrlSdi5sKBVxJ6K5ksnp5
 C/837oGYQj4YN6jENzzsr8an1cTn6KxoCTR86r8YOQ1mvXP2llQpv887FR6cYcEUmxej
 LarslHQwkG/5OMZ6ydfHgFiwQ6cJPEiw5Zy8slVeLxIZVaOjCu5KCIZ36GOfjENPtluq
 2SaGN+h0oGEtgAdE+xdBi9L7Y7Kv3OfuzC/HZJ4yGJ75WwiUYVTSLJhBBXb65RuhQLMX UQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3swxgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 06:19:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2385UWMS009591;
        Fri, 8 Apr 2022 06:19:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f97ws5hb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 06:19:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpNGM95i600pw6G5zF22eYSG6E6z0BsMK8SdoZQMYmxzmT0elltGMeWU51Biwy0uHCPi4dVj4AED85wxw++/0f/QXJqweKfXN4v59GyWbjJ+ZvuJ4xDmeCAkoQScdfU9gGfnw3iXR+mAJm8x+AKbIi89rgFdV3lyoBjrRJaVlcbFMde+Uoad74pKgkxu8wsxvShhFsm64bsEuy2bV3aZXPCCu5OEvldlBsO0r1h6QsMyIW9AJVWneAe5pQ8uLF3scz0JU1ISuFTsUNVq+XflrrT1QjV4G/HU8EFv0kEOzTHwvr9Zqzb6qkzPbusbY8oc7PTvk0XvOxh28BIDnvRfZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWWMJHUk/6thHxryeg01tp7Y539MSbbrD8vucUA/j6g=;
 b=KgU5w0NBAUqu2R1tsnjT0E55uSQySz+tERKDUioV1UrQyQvFP5g9eoI1YQQap5F6ASErZUYsLNub+tsoso1Wt8plBSMH8m5SjvWNhYjUTYzbx/otiYX3vPgvoY4wbgVFV5aURW+hCKOiuynW6dI0xjRp2zq7xkgDbDsJtXaY2n/Bs+uYAWKd1ste/GgglgY7WJ1LPYy/z/WNGFuv2eotEkZqSZgCFpc1J7k1DPJrMchioEsx1S4CmVA20T1JpYIncDudNKCPOcnhu8X9lqdWCY0ewmz7JDyyf3aMv/yDrupXNyk6PGAM+iLe3HMg8M9shTSxm67ECuOl1aKMeec2hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWWMJHUk/6thHxryeg01tp7Y539MSbbrD8vucUA/j6g=;
 b=Pg4Tgs3y/KFqFqJMXWWsUXZJ6tnP27FepLqUks8lXdrbN67hKc+y4eFhsO9WqmELRujc8k4D39ZwjP9JqX0hxcIVZHEsq5WfARPzh86TIei4FUIZGmO2j+iQNcyeHIZPhqAN0QyiRKjS1yhZDjFoNbEH83yx/yuqFdQrGbBfskU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Fri, 8 Apr
 2022 06:19:53 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 06:19:53 +0000
Date:   Fri, 8 Apr 2022 09:19:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jaehee Park <jhpark1013@gmail.com>
Cc:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, Stefano Brivio <sbrivio@redhat.com>
Subject: Re: [PATCH v2] staging: wfx: use container_of() to get vif
Message-ID: <20220408061936.GP3293@kadam>
References: <20220408032349.GA2132476@jaehee-ThinkPad-X1-Extreme>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408032349.GA2132476@jaehee-ThinkPad-X1-Extreme>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0023.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::10) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9628645-5293-459c-64fb-08da1927cb88
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2358:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB2358DA84E784A5CD708E4A828EE99@CY4PR1001MB2358.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rRLxrQJXm4DIMiy7iQBbuKkMogqUsbe8//sAmiqFchUVNgNnW8iUIeR2C9YeY+0yao+/flpxptdSy+ay9b0hNKzXHn0dwk0B2BxNAMIXogVYWK4IX9NktspK+avQLim9Hfwn+g1JrtWxo2az/FtHtI8qNgXUej3M61yVYd9K/IwRvKupamjsIociTQsi1IojWdB6BNeImqlIIaWg4qAKUxS3Fp2KzQzgodOw5lKoqnyr7E7rgH/MtCwKmtXyccuUe+fQcI8DKguuW24uA+VFICjKBMXK/i3j4jKnbwp5YPowwqLlx6lXSItf+za/SyUJ5aT/TFKw8ftV2DVvQCB2PTS87SDsNt9+2o5n9ruFdyyTqYpMxeG4njZJyZZcUwleCtXupgZcM04lB4aIOuZI6jQSEBvDOxyzSZLlwSNFY78d+OZdCDZI3eJ5GpA1flNKB3mE5efj35auEvH2KZ4bcc+KpcSWY9QshXfLx13bOQI4yAHYnjbaLni7wx6gg7Z6S1mZduieJSfp5qLD7hEWVWmKVnmsJ4UWdgVUcE9VxB3CvuG+uUx0guJCvPTQ8kvdJilczP+W+HcaxgedRXoYeE13i4UO8vbDQKvV9OAXA3buZnJ+VdxI4GCQwfy6jyLsJNK6ZAWJPGi7t0T69Ycek0Obvt2n9T9ra8E/PW/SbjOrrSrh2v+/3u1TWX1n+av9p0y0NWuAYh7L+kD5+xjdyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(8676002)(4326008)(66946007)(66476007)(38350700002)(66556008)(38100700002)(33716001)(83380400001)(54906003)(8936002)(6916009)(33656002)(1076003)(44832011)(6486002)(5660300002)(508600001)(2906002)(316002)(9686003)(6512007)(52116002)(6506007)(6666004)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LYGDZ5rvXpdJboMuMWzmwKQTgRHJVZ7t2FkWZ+/WshxFVjcTi3xWvQqiY5Kj?=
 =?us-ascii?Q?2Njj590SzIbc5EIkHutGwCtY3kUtWRucmNgcSk5f5IVUBqn3Lwc8U1Y8raxB?=
 =?us-ascii?Q?OMaAmphC45bDLSMdnB4UbmtC/IXcgAhLlNRr+bcLsMt7IQ3EbQOqut9H5snE?=
 =?us-ascii?Q?rImE/7oYCgL4v4qm69gVdiY5CgYCNmtpxl6Qf8AouK5fGdMbqr8oBjcQcq96?=
 =?us-ascii?Q?HRv2W9gIUSOfnMYrCj15X2TbT/lvSKXNKtKZ7kUuNCE0BOsCnMNcAAgPEOvX?=
 =?us-ascii?Q?W49f0vl7BNwQEmgQ27x6SDAo2bCq0hZlfa6D2GD+8lKQadHs0A6ErSD6HKy9?=
 =?us-ascii?Q?N1LwQKUW7KnLvRieNNyL6ywOxTjjVYD9s1BnkXU9OE7pcch5nWEJJJkuhKOM?=
 =?us-ascii?Q?Lehe2uQLlhD+4oqOlloIaKBDFQeGytgkQIA4mPAc7CQgBYUFPI0EQT5pI1iK?=
 =?us-ascii?Q?YFclHYYuf8ghQ9P/ml9QhxA9i8CpMy7uMzh3UKJhU8QvrmGZVgoDvefiAUfj?=
 =?us-ascii?Q?xd7QueYQB59atjuNsug8HHA9Z1RQ9rADTQUGbzUo4o+AVhK+Tez9aIjx0j1+?=
 =?us-ascii?Q?u0BNXRUg2ahT4EeSC8+Kb31zD7iRoJNtewMbtl/aJ4v/UX5ZKlw7N5SIkraN?=
 =?us-ascii?Q?JTiIYmmHKRRwRjzdG9mRMwa4cPTMNaKKjlQJv3DgrKz0hmwTNgJymuBxd3t1?=
 =?us-ascii?Q?bD08Y957k91cqMGCMUvUdZiRMM6iBjlKbS8x+fL3BE7DqNxBQQmVgNlmE5GZ?=
 =?us-ascii?Q?q24sMdwxoua74prQHecNWrLCFDw1jWCPQi/Wwt0t4HspaNqgB09tNAYI/Cjb?=
 =?us-ascii?Q?nUew4RpzyjHc9gat9sU9kfT4MFHSPqqqSea4wnVOBsRpxcBx/qEVVJ5xxv6S?=
 =?us-ascii?Q?B6NrCzbxFwo3fQKQLXpGmq0BS/1iOJbaJGIlkrJVHvcNlGBQBrKeBGT9FhNW?=
 =?us-ascii?Q?/W62xisXRC1d4DGOw2hV/Ub/5pxtUSR1DsnSO44VkmMAYdHS8nKx2jypU6nK?=
 =?us-ascii?Q?6RQYQyujx0dAfo7meZyaQW6WI5PEhSkx3HslqYPPn5uZkA7XqHra/VjFwNcu?=
 =?us-ascii?Q?Mq62vly7EyrnDzY695H5CvMn82Gh5Ft+u1BL0aashNeKvxsohMbawuKwY50C?=
 =?us-ascii?Q?V9nMJABg5qU8AHEqxneaXs88Il/4apf6bUll5ACBU9xjCGrG1aSrZJ+CFnAy?=
 =?us-ascii?Q?WF4TuIW9N72ELPasmDmB7CrHynDb9FpDVrlY/b3QCtwlvtatBXe88VNrxUZl?=
 =?us-ascii?Q?rzX+TEFX0n37Iw0ZeZ5sXU5iJ5RcuW1XZntULdR88H+e+JoHTYiUohj63RCf?=
 =?us-ascii?Q?xtJXnxDM1shSxDmGlD0L1atRbMxiyFTnclJRqI731meJf1pI8JAqymoHm+XX?=
 =?us-ascii?Q?KQawdT7BHbOC27jGoSvgw1CliUnQgziVoK4t1O/R0gteUGcpNiCmaLUzXNLX?=
 =?us-ascii?Q?vVAUvA2/CsKbhmnsAsx/fO5wfXLzq3ZonAE0dP16e/A6jXifFaWvos7k9u0m?=
 =?us-ascii?Q?aKu7ygrRxp1xuEIWLQYLSWk7b7ry+vdYCj1EmLfpohDRYBqcHlXMy2PVrCDF?=
 =?us-ascii?Q?wZG8s/yF8E63iEQxNcB6srHnVLp4wDp/6XXzm9o1gH5MUrTFtvT3gwZ5H1cY?=
 =?us-ascii?Q?zxpkBZ+o/k2zJaiooX7wE1U5jKeaIockA+sgNZYnj4TAdUhxVlO99AJxC4Lj?=
 =?us-ascii?Q?9U5x67wSEMAzgywIaJifG1Azy04s0j71uEu0c+fU9eaUM/wxwDzKDBjNum74?=
 =?us-ascii?Q?FFRD0634Q/Qa2sMLc4f5x1sz7bhGkd0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9628645-5293-459c-64fb-08da1927cb88
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 06:19:53.7822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWJ+/tRa0bVLHOmIO0ly5txLFJOmPN977oY53/oHpKqoF7uSveaMMe3JvlpFZoSB8V3ZFb96zpWArMAtwCeXf2+mP5nIb0Wq+x09sVUlV+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2358
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-07_01:2022-04-07,2022-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070064
X-Proofpoint-ORIG-GUID: vK95fLofZ441aEdlqu-H3GKsy_b85FRx
X-Proofpoint-GUID: vK95fLofZ441aEdlqu-H3GKsy_b85FRx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 11:23:49PM -0400, Jaehee Park wrote:
> diff --git a/drivers/staging/wfx/wfx.h b/drivers/staging/wfx/wfx.h
> index 6594cc647c2f..78f2a416fe4f 100644
> --- a/drivers/staging/wfx/wfx.h
> +++ b/drivers/staging/wfx/wfx.h
> @@ -25,6 +25,8 @@
>  #define USEC_PER_TXOP 32 /* see struct ieee80211_tx_queue_params */
>  #define USEC_PER_TU 1024
>  
> +#define wvif_to_vif(ptr)(container_of((void *)ptr, struct ieee80211_vif, drv_priv))
> +

Better to make this a function.

Stefano's comments are correct.  It would have saved space with the 80
limit to do a "struct ieee80211_vif *vif = wvif_to_vif();" at the start
of the function.  Also dereferencing the results of a function call
like this, "frob(foo)->bar", without checking makes me itch.  If it's
at the top of the function then that's kind of different.  I normally
assume that the functions in the declaration block cannot fail.  From
analysing static checker warnings, putting functions which can fail in
that the declaration block is risky.

It's always better to test things but this patch looks correct to me:

The add interface does:

	struct wfx_vif *wvif = (struct wfx_vif *)vif->drv_priv
        ...
	wvif->vif = vif;

The remove interface does:
	wvif->vif = NULL;

Those are the only places where ->vif is set container_of() will always
work.

regards,
dan carpenter

