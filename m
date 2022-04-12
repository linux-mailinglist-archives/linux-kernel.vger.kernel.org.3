Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04484FD80E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389779AbiDLJYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351808AbiDLH7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:59:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31463574B4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:35:16 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23C7QGCL018415;
        Tue, 12 Apr 2022 07:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=uLX9XetfJBBtO1PKuRqAo+z7Xohk+k4Qg9CqICxcbLw=;
 b=E6rVAxwBhJEs/8WcaITEJXmb8xROEU5xm52MKlwPd+HiWPC8gZj/mRn6r4L6rWTts2ca
 h6CiVg5smA8nf1TQX4GG77FHHeNcKHk+tAP4jP3Vc54kParEoL9z9dZ3eszCb4foWjbb
 M0fP4J+bE1Bc02KLCgW4sNJR0ADo87sArOiFi2cepAkTT5pCtOyuXlWqz0UOi/M/LX20
 T5I8NOAM0yGPq8pLO+tu07D9abkxRnDQYNt5sT+DlQPGJ0psAKfWX57jcgl6VGZbGKeg
 05N/Anvz9K15VhkSnr3a0x2fCrE8/oq5XZUMWMkd0o06vs/Tzb5Iqy7fTmt+RR9DJovJ mg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0r1dw6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 07:35:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23C7PiEa034295;
        Tue, 12 Apr 2022 07:35:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k2m6r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Apr 2022 07:35:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWhSgd+du8lFSr3qrzWkywZ6eEYhZrCtsNZDkMoXh8Nv2gt7F9uFYDkNNC73BiqwxihVnRs+lD5O6hnJOej9jT/x2OHYIa0/ffu0WTbKByFEwm95RQB4Z65h+ak65CCsYAB8KbeGJUCiBSWrFeaS59AScWdOOPyaVA5cmYZz29vVdEvvBXJzdOSYfUnLYxKWr39CXlzmq96JGF39JphwrOW40/19qysmJr7Fdwb8KMGLoAVcheoPzaX1poFnkQdVRXuVQj8azGjUaw4vWgzN4KvSQtumzSaD9QEdHSVGYgB3Ko9LxX6By62OaRK6VO4i4pB+K6ImYcmee88GNsXJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLX9XetfJBBtO1PKuRqAo+z7Xohk+k4Qg9CqICxcbLw=;
 b=JDk0H2D4vsLu3H8YNvmziAHB2wwjdgvZ1mrGofcd/HyAfd7KgefgLnltUOQ8SGaXzuq2y2xJWIBZXSzpA5G3oXAGnFhKs7dRIvKgpjcerfWAqsAA+3zoiKXAesv2qKuYaSNm30Fl2C9y9hma5Bs6DeuBGhcMFTFN/JDWqD2MA7zCg9/TqWT9hm03qY7eLn/hEpFAHdHgGUgtDgp72trbjksj57i0vmKqlpajKbU1l12BVNqre7ZfpknIOmfO80v98Ka2B8kO6VK8RfC/MWxLBYcRLtwAlTvnMyxGoQzxBcPfBvvV+HPUSD1gCZsD+DXoTRYH6qao58P6VWy8V3UWSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLX9XetfJBBtO1PKuRqAo+z7Xohk+k4Qg9CqICxcbLw=;
 b=vf8/JZ89s2bXytFh1oIDGOXHzrUF5jconUOeTglJppS1o5RuHGUJr9E9AjLcMSXqJPQPSrLXJx/dEZg6HEZaOWeSX7+iLPzKki8nbLUoWXxwZ9H8gOZ47WYcp73uZP/vul+87rRajL+g+bm2xlM1jNCKUnZ3C3VcHuyXcW021MU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB2813.namprd10.prod.outlook.com
 (2603:10b6:805:cc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 07:35:07 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Tue, 12 Apr 2022
 07:35:07 +0000
Date:   Tue, 12 Apr 2022 10:34:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jaehee Park <jhpark1013@gmail.com>
Cc:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, Stefano Brivio <sbrivio@redhat.com>
Subject: Re: [PATCH V3] wfx: use container_of() to get vif
Message-ID: <20220412073444.GE3293@kadam>
References: <20220412041218.GA2859599@jaehee-ThinkPad-X1-Extreme>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412041218.GA2859599@jaehee-ThinkPad-X1-Extreme>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: badfef4a-cbbc-46f6-9cbd-08da1c56f71c
X-MS-TrafficTypeDiagnostic: SN6PR10MB2813:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2813F5AA22DE883DB2BDD1188EED9@SN6PR10MB2813.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AKKHha207ZBLDRKkUS3ekJqMFygGD52oEOm2UbC3c9OPRd7E2Q2c8BFQ8SLms3lyoAUGhUcA/Qk/LB4FB03pugdRmoTCr2Qv6PXPCYNCVbJrlMhOrfudnpAB0CtyBg+b0EkJKcM/IBWZZukysZCTCJ/Iyncs42oJ0Fpf5vqNuq8ticeppSuxPT4/TuTtF+8ls3Q/sU0+bUYUb9IBa75vwY0yq0VucGaKNk1PM4qqomysN+0qcO/zqBYXmuT0iUlLeASjWsRJlJu4kVsoYELSbRO54ceqn6x4X29ZJVC3An9YivhBrDvf+vFepSJzqPUICF/XIpdLBWDvdrgdqbqfwNHI6pN7VP3sCi/i98rjTH3O3SGm37UZCJy30qR6FOgc65fEPbscwwxwCdJpwxshwFjK8lbhxDrKjxbNHNWNFPrb7EgA1w87a9Cl55J5tTJ05L0u+joeLQwInEYzRNVsfJE86nZ5DUW2wX7kzlu3n0R4hY0JIrxfwYgiUR2rSDiO7u3y5tGjz6WceMnI4AEd5Y9rehfEODqE19tpK6FIMlhlLxkldDWC0kvdGmWH4zxVGA5j9EvkpSfJXtE+52qEyAKYtQEc2t9g4nGuDOBP1YjGHGXk485ipwSbdOFekoC6ugtPFH3NOCR4ODOm0/rvblm0Gf9n78oFy7XXHkTMyUdIvLLWWjm4Q8kdOskgFlG49w5jn5Hu4tzYAdg6m6+qWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33716001)(5660300002)(33656002)(6486002)(1076003)(54906003)(66556008)(508600001)(8676002)(6916009)(4326008)(66946007)(66476007)(38100700002)(44832011)(38350700002)(316002)(83380400001)(2906002)(86362001)(26005)(186003)(6666004)(6512007)(6506007)(9686003)(52116002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IDAYtQ80XasYzSA0l4AGJqMJptjUrW08J+0PFQ8urjRCliwQOUpXAT2xjV/t?=
 =?us-ascii?Q?hNOIkvBROO9NZY+ieNVGBI0vt+8o5y6SnM3+9Pv0GUI78zyY4+f3iyk+PqKV?=
 =?us-ascii?Q?f8Kr41MT3x9Yu4qmymOOKcb8s7WhEQ8wcWFEqNoBxdOL63oCFNZO8pD4m3ZV?=
 =?us-ascii?Q?gEG/5FvCJjskzdaghDuYwdCQSnTA73WtlCdeZjk/7KVhiSQeKNM/2OBEW1WR?=
 =?us-ascii?Q?5C9c94tWyMCcL6HlnbLk7AyVLNixRNRIWD3TLN5iz9sHl2fRHaCvu2v0WXRr?=
 =?us-ascii?Q?7gxlbbFWwhXk25mhu70VWdr0D8EWnsh7mXvO5AesDwAnhEqbEM2IaKFDmctx?=
 =?us-ascii?Q?pOp5/hb+PmR6zlYC0u94cFoCvZqep4lHw9Bd4iiFnXKtLJrG5G9/VkpcAJmO?=
 =?us-ascii?Q?VTnvZYiGmpfYmy7814JHYZ34McL2iyQE5wEC1ze+hzvGbRTnMJ++SHKkPiTj?=
 =?us-ascii?Q?ru72zk+eYmcSlE0hgPM4sZAsV7YiPQCwEi1ZWbEfL3JoxSttaqgdvCuMr31H?=
 =?us-ascii?Q?N/cu275zhuYS+2spjRFGZVznYzMmkumvKCIaAh/cH5vdPPDJKbFFDLvmX2x/?=
 =?us-ascii?Q?/NOo4xbIg+t9CRll88O3eBhBRCG299xLRlRKGyKUCbYUG8FnMrv7AoFNjqGJ?=
 =?us-ascii?Q?6Wz9k6hJDMXBPPNmbKxrkRZz/IJzJNVZPYCnzIBdjlfMFAurRj6LmMjrNIG8?=
 =?us-ascii?Q?dfSs9agTQv/0eAEYFD2qvlGAF4BrNZYRZcHl5MTzsu2B9sSfWJVpaSiZpX1n?=
 =?us-ascii?Q?cZTL5SZlZP7jQQ4SuKuLqkZmm0J64wZq8kN3eiVwC8cYwOgqv4rH4ny/TQwY?=
 =?us-ascii?Q?9KZ2bFAcXvA0C3th4WbDbGyQnOMgVxKG3c9R2Qbpczdy8VPsKifatiUywdoH?=
 =?us-ascii?Q?UI5b6OOiZzI2wFQ105EnSW7EDdAgXG5eeBG1Rr2xiw9UtHJA9RbPxGlN24J9?=
 =?us-ascii?Q?g5IUwFPVW6l+7fgQSIb8GDduNPRnjHQgcSUU6Yb8pL/E5TE41rtbzOAcUzd3?=
 =?us-ascii?Q?sEl0et71X2ouhrjj9ydD0XuI+ha8GP7HiTaD4Zl4Olh5pqu0oddIktPZPC2t?=
 =?us-ascii?Q?9Vi/EMkt7XdeMUXlwxE0GHbWapn0SQ77WFlzQ/kyoD1DUrrxmLa3SfoNZewQ?=
 =?us-ascii?Q?fxHopR1fudZdPv5WdzkwUsHs3N7kZworvzqCnq59jTZV8j3J2Nx+mmDiOi1z?=
 =?us-ascii?Q?3ctxY0XpkVeGCpAXZYFSFdWlkbt+P2Vdm1l9gu6jwHQYhId3Lcjif7C6IAUm?=
 =?us-ascii?Q?pBD6wz0Slnzt0h534crYtQMwx0b0NMl/vXsR3pp1/njdxjtZ0sfnTUFa3FjB?=
 =?us-ascii?Q?ZJSRqNBQ1DQJtTjm/0DBOpLwOCHOBQpMazB3Xq1Yfk0w5tHIipX+hUs3PXOT?=
 =?us-ascii?Q?vRi+E5OPHKNP7cKgcRejmd8K0aC/nuasTm7RgXhlP+OfZ95gSjwwZk4/5pNY?=
 =?us-ascii?Q?e2KWFeD0ATqsvxs7p5IMg+/vj9mUNJiGfXtD5pInpKZlTy1DpAnWOdkQXE6A?=
 =?us-ascii?Q?wjXhNkzBv5d9s25gUOHdttmeJXAzQxp7lobWtm2rNOVOnGslKCcmbJ4VhxXV?=
 =?us-ascii?Q?WwUw2velI990o4iusCmdOdjRDgAgF2HZAXnHMfiGLkXW1LzNe6oj9Fj+JzUw?=
 =?us-ascii?Q?m9QUM7f0mVzcMmruDvMatRoKnL7p7/x1EpVwLiJucfmv4V514Ihs31zgULdW?=
 =?us-ascii?Q?GqlRtm8yXkJGNiBRrnHZLMVYSbU/J6hBBqWmmRJbgEs1zr050YSTdXz5BTlc?=
 =?us-ascii?Q?801DtEM5FBJM07zdftXS3hiMGTqp804=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: badfef4a-cbbc-46f6-9cbd-08da1c56f71c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 07:35:06.9490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXjtwSs2O2ZcCR0LEYR72SbBh4x1HUiVprYuJSzb45TQHIXnTn0e+M7pptzm8f2ltb3ZL2Oh37SnUWea5HJZmMP71GRiTg3m3XDQisdBe98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2813
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-12_02:2022-04-11,2022-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204120035
X-Proofpoint-GUID: STR57IbJSYVfAF72RgT4vF6FyyzvEj1U
X-Proofpoint-ORIG-GUID: STR57IbJSYVfAF72RgT4vF6FyyzvEj1U
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 12:12:18AM -0400, Jaehee Park wrote:
> diff --git a/drivers/staging/wfx/wfx.h b/drivers/staging/wfx/wfx.h
> index 78f2a416fe4f..a07baadc5e70 100644
> --- a/drivers/staging/wfx/wfx.h
> +++ b/drivers/staging/wfx/wfx.h
> @@ -25,7 +25,7 @@
>  #define USEC_PER_TXOP 32 /* see struct ieee80211_tx_queue_params */
>  #define USEC_PER_TU 1024
>  
> -#define wvif_to_vif(ptr)(container_of((void *)ptr, struct ieee80211_vif, drv_priv))
> +#define to_vif(wvif)container_of((void *)wvif, struct ieee80211_vif, drv_priv)

Missing space character:

#define to_vif(wvif) container_of((void *)wvif, struct ieee80211_vif, drv_priv)

> diff --git a/drivers/staging/wfx/scan.c b/drivers/staging/wfx/scan.c
> index 5c25fde3fc41..e90170062d42 100644
> --- a/drivers/staging/wfx/scan.c
> +++ b/drivers/staging/wfx/scan.c
> @@ -24,8 +24,9 @@ static void wfx_ieee80211_scan_completed_compat(struct ieee80211_hw *hw, bool ab
>  static int update_probe_tmpl(struct wfx_vif *wvif, struct cfg80211_scan_request *req)
>  {
>  	struct sk_buff *skb;
> -
> -	skb = ieee80211_probereq_get(wvif->wdev->hw, wvif_to_vif(wvif)->addr, NULL, 0, req->ie_len);
> +	struct ieee80211_vif *vif = to_vif(wvif);
> +	skb = ieee80211_probereq_get(wvif->wdev->hw, vif->addr, 
> +				     NULL, 0, req->ie_len);


You need to add a blank line after the declaration block.  Also there
is trailing white space.  Run checkpatch.pl --strict on your patches.

regards,
dan carpenter

