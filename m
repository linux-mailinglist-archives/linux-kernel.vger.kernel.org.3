Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C3D508526
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377310AbiDTJpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243155AbiDTJpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:45:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC87D3465C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:42:46 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23K7tqKe009605;
        Wed, 20 Apr 2022 09:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=WLjW9Y+SwLC+vPiS+rMMjLgk0SIcFqTmAC2O1ddN91U=;
 b=BPyITIhqAsysyBbJdQXZrOeVMqhGiyOlAZiz1wrv4kOQ04bkILJU6lAe6nKB+pdm4LYr
 u2B8lj/3YL+B4m2PFkHoQBnS3ZDlJqxSwkl+w7lrrlCrYrwfModLWLAWkap0ArSKyXgs
 6FVLYmglX3LBNySsKxvl0ArtILS/sgcmU6QMPi7+6dPLLTmlmL1OvVJWVXos9ajY/BBO
 MsWYI8OJs01tSf2AUlNqkfze60vNV+yICMqzSs+P/oFL1nGNyyA66fWZB65gcN0w9809
 SlNBCoMIESppG3mnVjzFmtzcYF5tRMNydYSoeYQ+CZS3ib+ApEA9Y+RQ6qaEw70Zh3PH EQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffmk2rhcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 09:42:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23K9aXMv040699;
        Wed, 20 Apr 2022 09:42:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm88sgv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 09:42:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leWQmvtGzyGnEqRzEBsLeUDO/9zMupTTX3PJIqn43+6yTO4HKJ0ZTKMgiGDJ0qsHuBDFkzO19rc4KuzRkLdl0mQuEBe4d80U/pLQJEmaFnCuxGRCkhhzGoGJHZY8/ONN8Mkvam5h0nPaiJRbfDqd0h8UQXQ/KzQAcirrSloQUxL9JL0w8cbbB9AOLn3l0ksbex1egCLvB3DmaVQy8krfx3Ax6QMrxZlmyONdkdQ0Zc9yrPU4xp0QmZ6iY4RsBj5qOGXCRYpRGSzzqncQbddhgxoxDOvLMJZidUd+nS5cAXYdpZnFBzhylDAjBrAAZVj5WvercrL+IM1uSaY+WkzHfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLjW9Y+SwLC+vPiS+rMMjLgk0SIcFqTmAC2O1ddN91U=;
 b=BRpd8XwdPkhXsX0J6MLmpHQmGRHnSVX+RO3VL5H/qHeivPq0rSVHDjuf/dEM4SLMjsmfXTF8aA+2WcRO6puFjrtgv5hGMqBdGs0u8iStzYU4dRuVjRi3AFUVntv2/DmM+n7EwD54tVfnaL/9+anQXAX9D1W/CD5cXSEiv+stTwsaZWIqXzumvD9CCHGnZVtbyyg9MsjVaYI647qy3E5JcyEHXQ3uhstVHYvPBHDqS/TIxgv5kR/PTM8MN6LEHlmZDOgqtzNEZsDdoJvBB49zD1m3HHu9bj4IiYMQuA8lYuW9Q0htsRIFjHhKpGxfQr9gylUUmrTYFn5YtTtCQsUjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLjW9Y+SwLC+vPiS+rMMjLgk0SIcFqTmAC2O1ddN91U=;
 b=auJQh6WPCeycAC4gbARa5vwdgG/+O8Wq7TEQGeZmZLQ5aERhqXe+DWjskj2fH3i7jIhpeyNyzLONTc7yeR9SVHwjOgsb0NGY3TDsdOMiVoWDWVod+QSXA7q8q1s3PITHKo1zHkoibkXsvh3bMkXxFmH2qG2k8fh/VV5ty2qDHHo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3612.namprd10.prod.outlook.com
 (2603:10b6:5:157::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 09:42:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 09:42:40 +0000
Date:   Wed, 20 Apr 2022 12:42:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: compare strcmp result to zero
Message-ID: <20220420094220.GD2951@kadam>
References: <20220416102434.97567-1-remckee0@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416102434.97567-1-remckee0@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6686e760-ccf0-415d-8beb-08da22b21bf2
X-MS-TrafficTypeDiagnostic: DM6PR10MB3612:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB36124CCF42D28E07817D42BD8EF59@DM6PR10MB3612.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NR8e5gNz5MjYcHpp9q2hlkKCs6rtTflFvEzZw7QxhBAuvCTl2r9zPzb4shhZUI05QpminfLlYK83ARWUD8+xFPqZCxQZQqSKLEM7xuqhAEjGkWdck4khkupfIdzHw3lNFrrDh6Kh/DDqiR8CpgYErcuDmzso8oacFZoucGaX4aszHGgozV5ZTSLJqaiQ0jzLdDNrfoJQJz6UVjSSK00xAhS3bQFcMBYETMqKvPwD8xGUFFKhRr8hhL2GGAHQH9TN6FVvB6DXOGFBpdM24YG/OhM21pLJG+s2fIKfCmMdQQHmLTdJtObwnUx4mrO6SD45SgGwT+fSXRGOwxc0U2iRC5mMj6I5UOg6LrK43OUL5fHaTyPGcg0AHbH79kAT7y/fkLIq0GtaNJY+fJ4ouX2A/qdCIgK5DblXUEHzb2Lun0uXGSZX2X6ztl27DHzuLHxgm8TEirsr2mUe8BWAmpBqgoBUAqUY1QEmECk5NPQgbI25wr+rKETMvXCDUQN1dMtUQi0ITguaSS7/sKEb90SXoNZdgubIZBygDpM2NDfTMmAjGFDJAoydXUYP4MrYtHiTW+vf6qvthKtHaDrKZrK8zUNSF7fopzK1rIc0hIjN5u5085qJbSX5CZZ+9XLz+6RghsR5urfNXvCzUM1wk8LX7vPy21Nh4VGmTbcy9UMjP8Xswjrssa7FqBU86Ri0gIbpvXwI8Cl6E2thWGT3ZODlL0S994Wm8hyJLmUR4Yb/CfM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(83380400001)(66476007)(316002)(33656002)(66946007)(33716001)(6512007)(38350700002)(6486002)(52116002)(6506007)(508600001)(2906002)(6666004)(38100700002)(186003)(1076003)(26005)(4326008)(66556008)(8676002)(5660300002)(44832011)(86362001)(8936002)(6916009)(9686003)(40753002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cy8MUN7IM8JLIifc5jAJUc6iaYDaFrnc3Gyr1EZAJ78+AisJRabnSwKIbF4I?=
 =?us-ascii?Q?jX2sFu6rQVkFbaxdE+tZsshTEnpf++ibxmvphXzr8jQFUUUNHo6aKPBtIinJ?=
 =?us-ascii?Q?61GTgh21oWMR4DEcekHBSULUVIo/wiOeqo6BMG1Wm5qBK81LQP/rBy+odrTx?=
 =?us-ascii?Q?y8Y0zhl9hLapzZQgINI0YEQbljA8xZ/eLPfyDC4tsB1CbDLGN327K8WEpPda?=
 =?us-ascii?Q?x2YGm6OETZeRYl/RMxLtiKUmpr+oFEWcWg2vdMVHSlyF9jPbZlKr7cKvClvy?=
 =?us-ascii?Q?CMoxsg+iHFQE5F6emM2dWiR2OM3mKB/RFQTEatGHgLrwdbjDOwyzy3x+jxc2?=
 =?us-ascii?Q?sf4GCgYS6TZc9s8JvkyLANJgKJakeH2CfWYNZRo9NjG6dGqUmCty7N6YkmTc?=
 =?us-ascii?Q?sPXn4FBHiGJ+e2pwcCZvylfjsOuszIqanzXpghIzOw7FnwXqS27NBIFsr0Ty?=
 =?us-ascii?Q?R6zzAt2iqhGYZpPlj/FAAqM/L7i0h0/7pibxDY9QcbljjVBThFJcWqoGfTg7?=
 =?us-ascii?Q?yJJrfguklIsLC8H0z/6/G2HyVAYISUWQNghrqJZ0HgM0r2dooU0w/Hy55jLk?=
 =?us-ascii?Q?IAsp4UUOaZSvJ3IUe55cHCNl/P2Tl4RbT1XaXEs33+bzsSN5DJBq7L6uqHS9?=
 =?us-ascii?Q?+oH/il1RI+HLGA5MEAFp6c6xMsHUj/RNQLxznflnJJ9wA3Aw66Q9sERlszfT?=
 =?us-ascii?Q?jxUxb7zQXPxVd/94gS+kVQYhGG9p5BLfXv+4/RSH9Z2UQ4eTMEePQEH9v5n1?=
 =?us-ascii?Q?u9wwXsDsj0BartNKUGjkJovs+oHn1M8jgvOiYfM5UVeuduNjS3QhxMs4z+vt?=
 =?us-ascii?Q?v9yB5AR62o5aObLD05aKKa9HeXrwZQEb0PrLsQnBqNeHCaKF3wLohsELSvdE?=
 =?us-ascii?Q?moEoWb1GSVMh/KyGjV9KnJTHfWuyN3GHd6atu0lCUPIzfu2wW1bHRgmbFHFm?=
 =?us-ascii?Q?tfPfVHqxAiQNt++06OSGIysrxUTnCnaIiww6pkgzHA2Dc9bUO/3xF4fTjF2D?=
 =?us-ascii?Q?9790+wIWweRzqYuJnJtmy3g5ZYkv9AgXKYkyyZrzefpAQvVXPSYZJTuWxBR6?=
 =?us-ascii?Q?vTzf+D4WqTo/lNYOZ/ns1BUkE+lJWqGo1Td9oKXqGyAtdI6HstRmFnu2KQ6K?=
 =?us-ascii?Q?rWfFrlaJpgJHj6/ZPLcxa/fqgBRrAHsUmMJPbUYbNpARTlDXploq2bZaPZqy?=
 =?us-ascii?Q?nFY1cjdBtP3H4/ahS/neq86RBmU/+wAa4TTSB5ZkoPTjx3edcTdsk8D6TTIF?=
 =?us-ascii?Q?Nts63/DyrZVlPhX/fkhg/KAkMMhJtmWP8wzJsm9uLyxDQ5ZV9/G+PrYwkgM/?=
 =?us-ascii?Q?7jrpM12Ph8sKtfaOiZtNkSFDODaHCZ6tyk5snMVXkBdUwitUVoivrWRkFQMZ?=
 =?us-ascii?Q?YGb8giGnrhnzegf3pUfztEO4Sm7jkDJOC8hjab2PzFlhanZ4415z2PL4KMa9?=
 =?us-ascii?Q?jhghlZF2RF1JW5BziSjNrNfo+YVbw7gI6zCj7JkabNi8yYnEnH+HXsaJ/pLJ?=
 =?us-ascii?Q?q7xwywAqhaw8dZ67OActJkOKpQ/XujLdUaXUi3SnH4ejs243vQHayxBpU1Nm?=
 =?us-ascii?Q?JSf9Amh7djs7nbmVI8vg6FJeQTsJv50DqcGTEHGYjrBxwAWOhsDTu7JSwMBp?=
 =?us-ascii?Q?JxxwBSebdzRvCLsb/b1UUrecfaQ4kk2qxbVYkSxZzv+44rTfCh2tyTnvbGXh?=
 =?us-ascii?Q?cIL0XTMEX72rTnOnQkhzjIDpot9rc5xONNdeTfjXsZcaHPtaEPuTRtDuXUWT?=
 =?us-ascii?Q?k9jvIcgQLspkogKzhdAirmr/KokAXwU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6686e760-ccf0-415d-8beb-08da22b21bf2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 09:42:40.0686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pn1KJqG/qiuzm6MVfvDLwnZHdcgJrhlN3NygtyF1X+2RBqU7mhWq8kraRQ1RxOvW9Huz/LFzZDCtVXSJWo9GbKwtghha90NWr09q8ggt9pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3612
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_02:2022-04-15,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200060
X-Proofpoint-GUID: WBEpG7BrMMJvL2Mqo3Jm2ZmbR07NZ7yp
X-Proofpoint-ORIG-GUID: WBEpG7BrMMJvL2Mqo3Jm2ZmbR07NZ7yp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2022 at 05:24:34AM -0500, Rebecca Mckeever wrote:
> Add " == 0" to the condition in both else if branches to address a
> possible bug. strcmp returns 0 when its arguments are equal, which
> evaluates to false, often leading to errors when used in if statements.
> 
> Currently, the statement in the first else if branch does not execute
> when its arguments are equal, but it does execute when crypt->ops->name
> equals any string other than "WEP" or "TKIP".
> 
> Similarly, the second else if branch does not execute when its arguments
> are equal, and it only executes when crypt->ops->name equals "TKIP".
> The else branch never executes.
> 
> It is unlikely that this is working as intended.
> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---

Looks good.  How did you find this bug?

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

> There is a similiar issue in
> drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> but I'm not sure if it's incorrect. The strcmp on line 2847 isn't
> negated, but the ones on lines 2851, 2853, and 2855 are.
> 
> 2845         /* IPW HW cannot build TKIP MIC, host decryption still needed. */
> 2846         if (!(ieee->host_encrypt || ieee->host_decrypt) &&
> 2847             strcmp(param->u.crypt.alg, "TKIP"))
> 2848                 goto skip_host_crypt;

You're right, but also I suspect this whole if statement is wrong.

The if statement is only triggered if both ->host_encrypt and
->host_decrypt are disabled.  (Too many negatives).  I think both are
set in alloc_ieee80211() and rtl8192_init_priv_variable() so both are
always true and the if statement is dead code.

How does the code match with the comment?

Fixing this probably requires testing.  Maybe we could add this to the
TODO list or maybe add a comment?

regards,
dan carpenter

Ps:  When you have a !(foo || bar) then it's often more readable to
write it as !foo && !bar, but in this case it doesn't really answer any
of the core questions so don't bother.


