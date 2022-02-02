Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1433E4A69A8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 02:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243677AbiBBBjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 20:39:46 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1840 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243588AbiBBBjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 20:39:44 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120L0vg026575;
        Wed, 2 Feb 2022 01:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=b3olD9kOrSRJJsPtwM75wHUKhaIFNPYxR5g9HsASZ/Q=;
 b=nla9cSSi57XVikPc6fpTeNUOtf6+USPiMnjbbgeqhAfs1JUEvILAOByatW9Gl1C2b9zx
 lqFeckS+BF9vHQ9zmhSQlX7Z6JaJSo3Amks9byGEO5HSwrob6Lp7HmVaYDvOIV1xEFck
 rHPgNlH2uu3PDmctpaNYpHHvbHMB3T3gq4AfJuiQpLqpWmG/7Y1+O7K64vie0P6bzp/h
 kJ4/dXyK9d166DjB4X8X+nHjBDnSfPvh0DDDbT4LD2DFk/m96fnDXbk5mkHZouN5I005
 r+bB4ZX8MwlIjvoy/EUecIv2UFNfXCf0M+hjDhvlBX8rc9JjonccIhyiBge2VNI24Thx mQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9vcqe9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 01:39:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2121VbSw024121;
        Wed, 2 Feb 2022 01:39:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3020.oracle.com with ESMTP id 3dvy1r61vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 01:39:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGorMR/7iDdl1pT5u/z6g/MMO/x5B1uyxpRHzAbCajutlyo5wuTOGrOzgdBK0f14xETaRJFWziir1PuXcGZI8PZN9Tx7lkDkksr5kJE556F84y25/n4y6Cb0G6pP7KsW5+utpHoj/6DMtkXsZSgepvTRkf/HYu+vQI9BsG5Xn4MKvz5g+LhupkMZI/2JXuMyz9KhtdKhjJmSVNZ7FyyGWKiSW6xyCnwKA0mbMaqmZJ681aBJTfjbVse0VGZDhlsm4zgf+FHzDU5l2aghqDetVpzufY/V8eork7slkIXX7ZbOZ5J2wuIIx4wYGLmZBSRl+Fgny16lHwDsqAGAqAwp2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3olD9kOrSRJJsPtwM75wHUKhaIFNPYxR5g9HsASZ/Q=;
 b=jm3QcMEuFK0cQ2cFeT+yr1fjWVSoKzYmzV8k3DNQlIHb4bUol5oLbKktwInw1dJTh+9FK2sA2jUo85O1fVY8TuYYC7I9/bXOl55HWSONSaYUaj9DDMBD4icbdp0n6W49SuhyEnrblL19OxhCjdTetOPzIzDNtW9icckQmuNeGOYLmGel8aWqFSq6jEprgdOs23ZS38Xr1RpCeLBcvqLDunuwiXb/oqJtGGeCgJYvaOz619XO7Cv83DR+OpXyt680KP1VACtLwkxrMfe+cQJrBugauobxX1OQfXiH4pw5OaISbADxegJH6xyd28eF4gnTNsCoTM9HC2y0icDm6bG+Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3olD9kOrSRJJsPtwM75wHUKhaIFNPYxR5g9HsASZ/Q=;
 b=Yw37rR1+qw4aX1OrNW8YIyH4sheyRhCUKYQdleWSeVTyzG2VioAkbOMEMJHx6ulLaEi/iosYe85IzstFykob4G0JSHHQfjr4Hfs37N1ZjGPAMKEUf0sSGdQ9PAQ8HiiyCo65xxGGMBmLK7OCELGA4ObqRmvmOXbn3E830sXsNWo=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB5355.namprd10.prod.outlook.com (2603:10b6:610:c8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Wed, 2 Feb
 2022 01:39:18 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::f4d7:8817:4bf5:8f2a%4]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 01:39:18 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v3 1/4] printk: Add panic_in_progress helper
In-Reply-To: <20220201185802.98345-2-stephen.s.brennan@oracle.com>
References: <20220201185802.98345-1-stephen.s.brennan@oracle.com>
 <20220201185802.98345-2-stephen.s.brennan@oracle.com>
Date:   Tue, 01 Feb 2022 17:39:15 -0800
Message-ID: <87y22udp30.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR18CA0009.namprd18.prod.outlook.com
 (2603:10b6:806:f3::17) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2970e6f-aa2a-4b25-6739-08d9e5ecd3dc
X-MS-TrafficTypeDiagnostic: CH0PR10MB5355:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5355515CB1F5666852FD1C77DB279@CH0PR10MB5355.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNZnuMsm1czDczDk1yvLT97/EzYJ0hDPDFgYWmfF6L+tM/tICkiMfXLBod4fmbuw41VW6HO7OCbdwgEL8MV4GLtKSkMUED3CtNuD6ckogr1BqfJlfQKqmZcWFLIVXfVk32UYs/KJi1/5nKyhnLmWa6bYWxubThFKQEzbzcQ0uQmRxzTu7PlZWA95+Bg0rciPP6hrHIZO68tPzUXShkJMndbDEe8VkuB7uqL/uCzCOiHV3GiO7rJeGhgZkDiObPMswisHpbz204elF3veaveo+g7Gai0C+ArQzpQk9u7RPO+j1uxIqkzaAvubA5fJPo0Teiw3Ma310zQK/2xDrVD2YJaUFSwrN+/EcVRmLO8Bu2ei5R3dkzOZ2j9DM+LjF/wfX6xS9OkJkpMAotxFltRjottHuf4NssSrnxdlBDmELFDLYX81de7ccyN0fQDzLgJgSlyfJjZhvwF8XcECyTVckH4RtqVka3W36JRa3dzwutxiPsC8Mw89XB3VMreRdO9GhO0QuZZNZjJRYmJIW16cLyf7LaPYgPFtJZe+tyksgkwsQ0NBAex9tlbuxTcgAZKRrAloeRQzlYa/Nfpt4oE9uhE5/fpfLeFCfbKXdFRcAsJqB2ldgyzFyOAqiozN0PGnq6kaahxep5XkZnnEIIzrGYhkzV8ZHAVT8oJyJ3hqziqefi8nDDWI9UjI8u6WXVw6LxVarnjIg132ijUtZ2/j5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(86362001)(38100700002)(6486002)(52116002)(54906003)(38350700002)(316002)(508600001)(110136005)(66556008)(5660300002)(66946007)(6506007)(8676002)(6512007)(8936002)(6666004)(66476007)(2906002)(83380400001)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hjapExYrazrSQbr7ycJadW5bUOxkC2mmGjmk/fB3TUOdDqh9IFJguD5XTFUl?=
 =?us-ascii?Q?8Q6FxJSzeFc0/zzBe7wZ+TNxXIkZhXvIS9mNwZAOIKjiQD06obml2rxhmeZB?=
 =?us-ascii?Q?Kw2xaNXUXuPVIGls81ruuQutuMJdWkqcBsFY6ALWpw1Ico/biNCBHcxZcldO?=
 =?us-ascii?Q?z5kxLzLybvFu4DAlUSUIkVeSETC9Q30OEMU4g1AvZo0NxUPUjrLiqB2sabgx?=
 =?us-ascii?Q?UFAaHKpbNQIHLQz9Jub9GHFRPTdBfj+W1HPcmz57jnp+3JPai8Ms32DTwHgh?=
 =?us-ascii?Q?ptiaCMscRhbOjk6dp7iwpktrx4O5b8awRm7BjJAJtNnLTgHN4IjXwgfzyoJG?=
 =?us-ascii?Q?hj/V7ySfvqixQi/Kg+5tEmE1J+HWDKO9cWmIhL6XIIawDg/7CICFUfHl+8ia?=
 =?us-ascii?Q?bYYkvv8zkGnOeEmrzmwi6ZPFlXPnOw2WjhY/RY8ppfLGo6p52QcHn0EX5aEq?=
 =?us-ascii?Q?Vu1ixeft+r6y1xJgoFBePGkah34Hqeb21YfduIDzqi6b1qPUrtwxG7X9Z0Nw?=
 =?us-ascii?Q?MvyJkvj6vMkGRrBxy0mxcybqFlP5K3yHqGaGJsOKT4YJk8PCuEihAEPA2lm3?=
 =?us-ascii?Q?ZMTHKaTcCgoy1uQ1sJSVRlCzR1FoUpKODOCZLwi/E+NPJ58Ph7D07FOLOU/z?=
 =?us-ascii?Q?L81Bz2HTYQGth8XotpFGuYEByTYwDnAcMLSbC3w2b1L5A/qHMje42Tz9AlPg?=
 =?us-ascii?Q?+l8jxo+nFwx/C/8KiaXTKBEBPwfn87IoLK1qgegmk9FutaXwwv9pzTVaztJA?=
 =?us-ascii?Q?bKq1tCJPwrwxxf1CVnRV6OJRUv1qGc1/kXzJ8vV8aezhF9uJI7b7KW1qdjKV?=
 =?us-ascii?Q?bKWl1FTRnTDojfs6S/h1U8vgaH+3TRxQCrdGuLfvhnhdmJhdOhqa+59zJAxD?=
 =?us-ascii?Q?jiLOqNW+BoGpTAPG4hagj+P5A6CD1NZeK1QolwQG8//Y0oOoTHkMSkjkmnzI?=
 =?us-ascii?Q?0Y+5Z0oIwUt/0MbTHfnM+T0k1bB+yWyioZCSTFRp3tcGP9MUjo5GxxJSX37G?=
 =?us-ascii?Q?NP4TUV64xrVhaE76x1Om62gwvuaJlERVYgAIA/vRMjPtCJ8UYDVr0ETDReSu?=
 =?us-ascii?Q?aAafn7lBMAOa78eUwePG+eXVBLBW9uLiZ5sSvKWGUqPP0Htqip43xlUT+tJm?=
 =?us-ascii?Q?G8Tup0LgMBqicm/O/F3d5DbGnP/F4yU98e286aMRnbVSE4lQ/od/7w/qfQi3?=
 =?us-ascii?Q?W/uX7Gg1buYJxXCwIIeXsBi9FvmFpOuTA8LCBSLq3hRV/wCQjLYVZ3qhdmxj?=
 =?us-ascii?Q?+qt2OJzdgbCVl95x/Aqd6+Qil8VvKPGBPaWJCzIFJdFEkkOd2hFWKHRykp3y?=
 =?us-ascii?Q?N3MK9y2HIeihqQRGn2PsrszMsk8drA6PBY/+mlugB78b+ZRVbTeb3gZoNNnP?=
 =?us-ascii?Q?AAjlw6/bn5S1i0fkAV0hRG5WyorYcyaVrxBKlettfEmy3G9WWUBCbS0wegeR?=
 =?us-ascii?Q?a4dyuLX/l6ywd4iB0D4EAYUUSo6xKCT1P3KRGBDjGyKh3oaZEEAqiHbS3mUq?=
 =?us-ascii?Q?+vXo0sjd8STJoHCZtQF7fi7YBh07/c+PqDdG/3aZ65hRwpD0QpF9rr3dr1+U?=
 =?us-ascii?Q?u7LqBTHSR5EIGP+EfKSUhJOGffzBOtvZS/Gq1ZLZjaNr55irM2OrvlfH3R3s?=
 =?us-ascii?Q?A4jDmRaPfBkaZz5PBd6AP/9QfKkMfI9AYh3r99qQKUqX4LbMpjrGndeX0+H3?=
 =?us-ascii?Q?gZkQYQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2970e6f-aa2a-4b25-6739-08d9e5ecd3dc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 01:39:18.2083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8KVT/VuDlL1MNX5PodgzvRI2bF8A0+8QETePkdDnxh3VJUnI2xBR0uT95rMcZ3C1WStiykXnyMGD7A24d8Irh0Fi8/400tPWcR1l0OhtcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5355
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020004
X-Proofpoint-ORIG-GUID: 7dVZxb7GLFFPZUuZprFWi_FLW7qe5RGw
X-Proofpoint-GUID: 7dVZxb7GLFFPZUuZprFWi_FLW7qe5RGw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> This will be used help avoid deadlocks during panics. Although it would
> be better to include this in linux/panic.h, it would require that header
> to include linux/atomic.h as well. On some architectures, this results
> in a circular dependency. So instead add the helper directly to
> printk.c.
>
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> ---
>
> Notes:
>     v3: Move the helper into printk.c due to circular include
>     v2: Switch from macro to static inline function
>
>  kernel/printk/printk.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 57b132b658e1..b33c2861a8fc 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1762,6 +1762,11 @@ static DEFINE_RAW_SPINLOCK(console_owner_lock);
>  static struct task_struct *console_owner;
>  static bool console_waiter;
>  
> +static bool panic_in_progress(void)
> +{
> +	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
> +}
> +

Unfortunately this is defined within a (very large)
#ifdef CONFIG_PRINTK section. Thanks to the kbuild bot which will have
earned the reported-by tag on this patch :D

v4 will be tomorrow. Sorry for the noise everyone!

>  /**
>   * console_lock_spinning_enable - mark beginning of code where another
>   *	thread might safely busy wait
> -- 
> 2.30.2
