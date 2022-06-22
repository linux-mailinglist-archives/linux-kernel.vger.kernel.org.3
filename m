Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF33555166
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359354AbiFVQkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbiFVQkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:40:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D74369F7;
        Wed, 22 Jun 2022 09:40:13 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MFRs9E009478;
        Wed, 22 Jun 2022 16:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=cpwKvGFwon5BcHR6bv35W2QjqrATaNGhh+P6yOc9J+I=;
 b=s1+djyLQODvQWQlM6Wx88lUh5ejY41FAumOfgijNRCFogGs786B57vQBBGWe+0CHCjWR
 3MoqP1FrkmJHbA98rzlYApF3+X2b6mLVyjQH+iVlNbIM6TU5UskTv79UPbJKzDxgh5iy
 UWdWWNzbU5bmxGRK2ja4x8NIkFkvhxuM1KS8rQFNtQdiZQd2gKnxZAxWHc1pKu29+ZKf
 tCH/OsHDkT/wl3S2j6yRoXM7K5p62hsD+L1PZn0/edAljEHGuLib+laQrYV6sM24Hc6u
 ht+hjEhxJZLvyWP9pnUy3tZiVX2y/3JT9LscoZ3DNeqriHgVwCnov1OIGJ9T6PczF9UN lg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g212qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 16:39:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25MGa1FL028545;
        Wed, 22 Jun 2022 16:39:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkfvtecx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 16:39:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKLJGQowp6Smzy4XCgzFtD8AzOn0mdo+9a7Ef2g11hf+5t3EwU+pePcgWT49CpoQh2DAOZ2b+OgYU5Co1nZyvHe0I31MjONANb7B63NQUtSc2IgQOTVJSxYayF9mZ+bkgiYO5JQmaS4c9y8Ljt/+xwqwwLX1BwY3GzoQROpJg3996hZr7lZTr7V6xfPGguZw52pBtk4KEZ+ZPa3Tp0H5sdwG2A/7FpGITLkv+wcEYZI7/PkiWT1UlDkzvRMDo5vwl2ULLpCmXEuaQo7lMPX3rkgXnaoDlXQKHdBYP2IMhtgAqgL0Th1SIKk9tW328vEBgLluVkBjbZZKjkQXMBGEuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpwKvGFwon5BcHR6bv35W2QjqrATaNGhh+P6yOc9J+I=;
 b=ifQP01RDZUTCfIsT18jbmkPOgyf8vbq2sC2MmGZgrRN+ga/FzHJk3D4cdUsiAqoiIMUd6+RyXqDo014MzRMQpXMVdWFZg7R7vMPAcx2YflHkJoz9/R2NyhG9Ggc3tTSyYSogkxH/OHG9tF3hrUFn4XJSkMXy+xEvsGM3BQY4BROH6DnBpoAJR4aJdLXpTcQInbQo/5DhfZlWEtau9b6FhuLIXHpk+sFm1MiuHRgajaOB+2V571gVaWDfD4Vbfj8TZiaFobr1al2mMYh2xE6ZwnDFbczYM6toH/wfIrhJImUxZykpXrXxk0lASV2DtMLOXO4UvXmmCNLnlzmnAXmW2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpwKvGFwon5BcHR6bv35W2QjqrATaNGhh+P6yOc9J+I=;
 b=PEhk5qUzyQoGMjmUXl3kaNnl33somqH/ODnBzl2hGX4bKL89y3imbWvETypznxDDUx7oQjRf7B96HegWEstm3srxeGCfZ9/HDWM1DW8UQblixF/UYLiSUCIPeNRliFmtfWjXwF8KUVwrfKQEyq5KjnGucktkt129Qup9DzoX+9s=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by BN8PR10MB3140.namprd10.prod.outlook.com (2603:10b6:408:cc::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Wed, 22 Jun
 2022 16:39:49 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::b4e4:47de:856e:f435]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::b4e4:47de:856e:f435%4]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 16:39:49 +0000
Date:   Wed, 22 Jun 2022 09:39:46 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm tree
Message-ID: <YrNF0i01rU/r3yQn@monkey>
References: <20220622155408.3ba2a9b7@canb.auug.org.au>
 <20220622171117.70850960@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622171117.70850960@canb.auug.org.au>
X-ClientProxiedBy: MW4PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:303:6a::15) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 807ad24e-ec1e-4141-3879-08da546dd260
X-MS-TrafficTypeDiagnostic: BN8PR10MB3140:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3140A2828CE61A77167579D6E2B29@BN8PR10MB3140.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wk7DyGVBL2GS2w0ytrJ4qxqL4vujcirz1UsKdubBIPfM1wW6tUv8cnBtIm1f5ZTYFBcEcUXca3XmlRv9JEndQ+FDajyVGqLJc6vNr1wIsgOBEzZCWyBXdWDKJcDz+Zr7XOZu02BB2omwuJCFqzMYmLkyr3blZz5sHnvf8C2B0qJY+/UuhLEI+73FDM0z4teVdCYoA7OiW4vJaK+knwBy5AGsLpyNLBPN1VYB+CMI4eug2KNNiUIf4tcwbk77Mrve6UJQfp/SRYlL6YO54eFOpot87VzpUrXlTbarYKvORTX8GAAQdWWdicwDaDx9mUbdkQFo8tUPjOnB5fCWPjlnakjyYm3nnMBpUjKlYx8ioC2E74aDZjNjIIE2N/nZVucTVYh+XypZf9pB9Y0J/SK+lQo+E6SRyZEIqik9/RwYHBLdLivXfwDzAPdx8CPczTy+3c04fyhBMlXm7Q2IWvlrRikRh432Ecu2heN0RvVUe3iNSLFjSVRRmTKFBN3Yk4s/e7kdYlwED94uhxpOIdwWWtLx8+uaT/GL0Nxmdz7AVHJr34JwIg61Nf4cssGMHWgw0bK09a35V/W42bmvw261TETF1x/W70KPvQf0f8EPVaYv/RxlEsGS9ydsMESIvYEZcOO96Eq7F0+ztCDyAC37YWUkIVqDv8hQWJAq5dN1ybzkCfOu9iHtbssVcF2UVfa8Jj6Id8i057wJo8rUFCUVew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(396003)(346002)(376002)(136003)(39860400002)(5660300002)(478600001)(26005)(53546011)(8936002)(6486002)(83380400001)(186003)(6506007)(41300700001)(6512007)(9686003)(44832011)(54906003)(66946007)(86362001)(2906002)(6666004)(316002)(38100700002)(33716001)(66556008)(8676002)(6916009)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kEtK9PMK+BQ6koaE0ebcb3UPDt26b891/9uCDwniBDezLl89zLZDV4nnP8WD?=
 =?us-ascii?Q?qQVEztmHjbGTtKvLf6ADk1G9KbgAAIKvNO02K+xujhSzVRNt0TmcmRQvkhm7?=
 =?us-ascii?Q?S8HLRmcMWF5CbgFoaOj4if2PRoB43KAsaExw5Ut1WJK44eL4JL44JD65R4Mn?=
 =?us-ascii?Q?HuPAWyOYhbC5afZWTLm3JvEHKiV2k4SeQ2lp/3khVk0Pj6G2NAn5lEMrmRx9?=
 =?us-ascii?Q?OWojRZL2YF0PCUW/G9kbMoM54jEapQ3y5Itbsq0dBSkAa7pKKUFVbCG0gwr7?=
 =?us-ascii?Q?hhtXkymSSiBWf/5wvy7hrIdEzstgiawGzNveOSbB0fQOqZJQGhqD/4B1iLJj?=
 =?us-ascii?Q?rlwRsI9+bJPG8m6G70OlHHTFsz6Tkxfy119RrIkXhxwHlaGXALMJUAT6Plss?=
 =?us-ascii?Q?VxxDu86zNbyQf1+OF1fmHFHZnsY4ZSsC5n0p2Y08uko1dYLFyNbo+XyTxteS?=
 =?us-ascii?Q?0NC7LF8ifjHRRjuagWKer5gsOugd+vXIWSL9MQVea6Emk/TB6cKBF0lUGizt?=
 =?us-ascii?Q?PZ6iOflJ/va7DZQg26KDHdw9pVdqCbUXnVqt0uP1Kxd6Slpb0uu8liYsCmM5?=
 =?us-ascii?Q?Sq7MpQxK8xbHRWe903GDK2XmQbvRLkejrlZfSK7/DrsAfhUrpewAFqnl0RtW?=
 =?us-ascii?Q?atW4Yi6QS38GKv3FdE52BC2sZo/JdcFLi96aDkxNML4h/aapUExwWDH5eZJg?=
 =?us-ascii?Q?lTgiP2JvCzj/xCasEzbgQMKWes1i7IsLyi5/FOL9PnBuMcNpncUDPNU0pM2i?=
 =?us-ascii?Q?Nt0k/j9NOGbfvZCMzWm4aqnM3TaJXlHbsOcvuOQLCIu034OBjY5+VEfB8nyJ?=
 =?us-ascii?Q?+JUZJ9Mb4L30tXFEyGB+uGjhwNkkmajIH0uHkZA+aJ0YBlVz5Hb/R0+c7Wkr?=
 =?us-ascii?Q?tHyMqfSf1YoljYNhy+3kEVZVIZsV6Q3HV45IbQKWl9TCJEsR5c0iyHnnOVzY?=
 =?us-ascii?Q?JDlTVhFSeyGOOJQcynHIUjf1mkvmibB8OvuGV02mtBrE25JCtsfszxd6PE1G?=
 =?us-ascii?Q?J2YwUdUTkK+Rt2ZNmXl+li4c+jPKyDLo0rXJFv8RO7Z9FNIfofjuTt+0V7Ju?=
 =?us-ascii?Q?cF8RHjS3k5btdonA94k40AD60AfdjkJ8uNnPyzDt8MGDdm38Zn/Mj3gFKpeI?=
 =?us-ascii?Q?iIvVDt0isE+U5JnrSw7mdDe8uSRptx5APHN/Ik662WookT17d5TJ1sRQPyHu?=
 =?us-ascii?Q?sqtMc3MGkO9QrSK4AzpbUosGlTULbBKuvRCFHY4jmttSUJRJY8Z7WrApvLjd?=
 =?us-ascii?Q?oe7t/CCE0qbEkWsH98CyMSY9pkptOp352fChNJvwx1BZyIF02SGvGLojpQlq?=
 =?us-ascii?Q?tsLQTc/W7oPVtX4wNQfGybqc03Lvmh/UbC3QgiNfM0GiChzxIGDcWHVwFvMu?=
 =?us-ascii?Q?pmQ6albVj4RrrCaDU9YJrnCpRpsuzh0vRvxUXNTQMSecCVDrLsFDJLGCL1/4?=
 =?us-ascii?Q?mKX4vBq5Osd9FcqUrqRIp/y0reRz/qTSmocOnlRtOjY9IM+eQFJKZAnLMTfS?=
 =?us-ascii?Q?nfCY67JXXLyBCbvMbDYhg1wsGkPXbOgkcAb16Tl0NidNqE0sCe3r+16aKLD7?=
 =?us-ascii?Q?LzIdtBglvZGwlqZ7AQz6dtZxo1kLxnF20C3BHCf+3tgWfuk6m+/PTNpUkhOV?=
 =?us-ascii?Q?RqeDXJou8XJI98nkdzW3OlV2+lrmMRbeTH54H9yXEgLU0oC4HpwpqNcx1bEl?=
 =?us-ascii?Q?MRzAbVyPkOY/74BymJ85N3dFf9EWpvGn83rAtmVmw/5wy33qZ9qkiEqqr1LA?=
 =?us-ascii?Q?tOCv7mYS4I3eK5L4mvK9V1HGb7GpyGA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 807ad24e-ec1e-4141-3879-08da546dd260
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 16:39:49.3266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15t/fBi4e64HzC0w8Kewbju40iCvJfsYayMyp4j/pS9DtgB8n8haTiuGl16SmX58Dgbmo/sfSj7nofv7yMztLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3140
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-22_04:2022-06-22,2022-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220080
X-Proofpoint-GUID: 5frLOEX1Xg3VATWuAONP1DpHCr4O--DF
X-Proofpoint-ORIG-GUID: 5frLOEX1Xg3VATWuAONP1DpHCr4O--DF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22/22 17:11, Stephen Rothwell wrote:
> Hi all,
> 
> On Wed, 22 Jun 2022 15:54:08 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> > After merging the mm tree, today's linux-next build (powerpc
> > ppc64_defconfig) produced this warning:
> > 
> > mm/hugetlb.c: In function 'hugetlb_mask_last_page':
> > mm/hugetlb.c:6908:23: warning: unused variable 'hp_size' [-Wunused-variable]
> >  6908 |         unsigned long hp_size = huge_page_size(h);
> >       |                       ^~~~~~~
> > 
> > Introduced by commit
> > 
> >   76005bedbc32 ("hugetlb: do not update address in huge_pmd_unshare")
> 
> This became a build failure in my powerpc allyesconfig build, so I
> applied this patch:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 22 Jun 2022 17:04:46 +1000
> Subject: [PATCH] hugetlb: fix an unused variable warning/error
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  mm/hugetlb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 2e4a92cebd9c..f338640fbe4a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6905,10 +6905,8 @@ unsigned long hugetlb_mask_last_page(struct hstate *h)
>  /* See description above.  Architectures can provide their own version. */
>  __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
>  {
> -	unsigned long hp_size = huge_page_size(h);
> -
>  #ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
> -	if (hp_size == PMD_SIZE)
> +	if (huge_page_size(h) == PMD_SIZE)
>  		return PUD_SIZE - PMD_SIZE;
>  #endif
>  	return 0UL;
> -- 

Thanks Stephen,  my bad for not building !CONFIG_ARCH_WANT_HUGE_PMD_SHARE and,
the error is pretty obvious. :(

Andrew, do you want me to send an updated version of the patch?  Or,
would you prefer to include Stephen's fix?
-- 
Mike Kravetz
