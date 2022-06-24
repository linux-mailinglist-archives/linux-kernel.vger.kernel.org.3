Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB27155A32E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbiFXU6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiFXU6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:58:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2726E83
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 13:58:21 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25OHdPHa017949;
        Fri, 24 Jun 2022 20:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=tHOV7RIHwDbA/0Ke2QkZUDFo1DUsI3ENpQm6wwi7FPw=;
 b=Wni3JqvNTuYumqewzXzooIM93VsACZHevl0yPjwQIhK7fL6lMxD1+bjldT/WLnIdjc8F
 80YII7BrC2HCLeWRO7uZMLz+GEAbzskDM4XXQTRfeBkUR/h1IpvKskIRwLOlQ+Y7YrIU
 AeRCveanaiJadJ9F3CHg8FKfOtvCD/AtF/PZDGELvgTDb4jMThWfx3w9UeadR3TbTbWK
 xqZPqaW0KoowZGUVEa7CCcb4IJr8BI9/DPyymJbScXu2SNZefmrVDbJDV20HVEXKWtjl
 T5xsS4Y0QKlIElgVjzhLPU+39RpGFS1cDuqxRW1TRFP4mphr140XA/DqJigu+xJBn3hf 4Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6at6sqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 20:58:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25OKsq4x018848;
        Fri, 24 Jun 2022 20:58:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtg5xqb1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 20:58:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuYkPIdR1SzRbH4m/M7PAU5y/iRiXVkuFJ6nPQFDXWxP9BEzlFEFILJkfOUxckKTjA86lOqIp5/ICGm3WJ1Lb7xLn1dMQ1BDBpem8E35pJVTF9suMOxv8H3vrJbBOO0PuzG4cGkWb64Y5p8PFyj2ITMM8a1e2W/HQhp4L/Jx2uH7KR9gRofdP0TJ1C1lGaXD+ovDDM2LmIHhhoORzSoQDFAjISHBikOAZ6jsqKJpfE+W/CRxlZI4VH/LcSMAXUMLaxS+LxAZmb4FsQq8dO/aCUiM2XCT6BQTXEuQ7r4NcwqdknX3K53wVkc3td9uvUB6D6inEf/y3QzOU8YS7eulew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHOV7RIHwDbA/0Ke2QkZUDFo1DUsI3ENpQm6wwi7FPw=;
 b=jjZ94WuFfmS0tQykuJoJziCCchagEqPDWODFOdyfQAMXGXF44QCFBB39ylJyyG0l9FZz0SCCEhq78iSilk5+xJY2tMFnNQSjNmHSMKIjKFBK5KCP9/l2DVi2M/vS5KGxh9/RtUc17I3+XZ1mGAEHe3mx542CGEFGG5707sjMcAuqrwMYyOXdhz6I2sE8yMRwgQ2IIbU7qlxsOhodMl5Kh+rtc2lggkmXbW5f3K9vYP7jRL93u4dhyFqN13vDhMNrZpn9JSCBfDN0Q6ocVie+mmx1Mrtch/hxl9MQfqC1GSAlrc5AJIVYq5XtQ50yhGbBz5WaN0njuNTtgizPnl4+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHOV7RIHwDbA/0Ke2QkZUDFo1DUsI3ENpQm6wwi7FPw=;
 b=ZXE4eHCcLLbmUWKEL1xQ75zs924lIxqqoG0Bkigf4jGITI0AwStA00MK+qNCcAoOKKKVyX+kJDOUmsdnV75ZqBGKmOaV5BqH0x1TsUMDsUmgl6tvVZ2QZ0g3fT+8Llv213fD9m8sFuPX+NGCpP3iBNU18ZHDJzuelFD5taTfzYE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4475.namprd10.prod.outlook.com (2603:10b6:806:118::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Fri, 24 Jun
 2022 20:58:00 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c1ba:c197:f81f:ec0%4]) with mapi id 15.20.5373.017; Fri, 24 Jun 2022
 20:58:00 +0000
Date:   Fri, 24 Jun 2022 13:57:57 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] mm/hugetlb: separate path for hwpoison entry in
 copy_hugetlb_page_range()
Message-ID: <YrYlVdXV+TFLDAGs@monkey>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-3-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623235153.2623702-3-naoya.horiguchi@linux.dev>
X-ClientProxiedBy: CO2PR04CA0062.namprd04.prod.outlook.com
 (2603:10b6:102:1::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fcaa1de-2da4-4d60-7d0a-08da5624392b
X-MS-TrafficTypeDiagnostic: SA2PR10MB4475:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OPOs11MfbR3PcUF2TUql+LffcdGDxgpv02pVjShrT+xLL75s7aIV3MhSkHMCN2j/G1FX+2dQLcNhup/cbGbKwVfWe3fqATrg2Awf+2B8J3MKesfpgPyC34nvF0GnyPE6OaBqR1LoeRW6ZRVD5PUPntXl/n+yhAOui2G4Ov39iJER9lVQKvTtGtnGk4CKAWD+F6vxrqjEKXf3O2d7MgIjzeRfJetIPL//oPNejHN/lql+6iL9ZkA8bDo0sidG4Rnaw4aC8VY9LAgPQpoKa8o1foPMWh3qOKDPbAh1Hf1USWFpjvVc3rz6hNrnqY7aNmk7YpqJcidBT0ZOoQ/qFuj99/s+S6JWgUI5yWxOLotF71ZAd55ePxFqmwh7bghN/Gqx0uworLfaWg4j889JE4IWKbFW3ujhW4Ce5WR2McReM9PSNA39Tl3n+jlFAsFEGBdKIj3W90UusbNGPZJnaL124J+nSSPdUhQr56bFKTnEFEQtuhxPWmOYX5PKW28mmISIouCV7Mpze+cQGnSBmC7RWDqos1JkeR7ckY9IJaf8/riFTd1gFfRkfBzqZU876ekN7qzSkLiZwwuWVV3I2yewZj84MLOhD1XpxKgHk6+YT/f7xS1grIe7P2Ooz33lj/w1L+ZTMG+bo7OTWqmdSDy22xUJ6n8kNB1YZ6ScFBKU3mlWM1mX6BULqzGn0R0L2yd5EDPeWc1WoUfHRLey2YqF5c+11EodzhzwBfiuhNOc2rcCjri8JaKgb6Vk/Zp5k4yJ+Xk+A15cQJ+hfMWdm+3Oox/NoxBNGuV5ZJTYwtkfBFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(366004)(39860400002)(136003)(376002)(396003)(478600001)(8936002)(7416002)(6916009)(44832011)(5660300002)(54906003)(2906002)(66946007)(86362001)(316002)(6486002)(8676002)(66476007)(66556008)(4326008)(186003)(41300700001)(9686003)(26005)(6512007)(83380400001)(6666004)(6506007)(53546011)(38100700002)(33716001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?09zZHU015/Bv7EX7ONsp+TFuc/Fh/zTN1yYSyA0IssBVby6pSr1un+db3+tX?=
 =?us-ascii?Q?SruxrEeTfVVfsYZpemBwiKwKCL/XxctBU8k2iAorgG+Qu+uM9dcbN4mIWXyS?=
 =?us-ascii?Q?z8CpHtP6YCOxrLgcqzUW/dzjySZse6qTqUTJFPrsDlmwN4XFrRKMWUAUYIIx?=
 =?us-ascii?Q?qFeUaBk80QpETMquhQE1m0stIhSu5HBtI9n6mQc114cbm5vWs+cKGtjp4mRd?=
 =?us-ascii?Q?vaVoxsURc/EZBm49oB0G8jWpI7AmnGipwKHyN84F0hYJFp04UGLZcxo932Sc?=
 =?us-ascii?Q?NIqhmbJ/TMjo+8xYGIQW/lY0lKQn/+j+q0suUFVKS2ImOCTUuHoubAMDEYJG?=
 =?us-ascii?Q?VtTynNC9N4PjwJqGw1WFQuCgqnhJ/w5g0HNaSftRi0xLeNRl+yoIf+aiyLoF?=
 =?us-ascii?Q?qZgMJbr6M60zuK8JVqnYtsxysmgLtrD7+w3Sg4I1TMDybgYKZJC5MQdeYp94?=
 =?us-ascii?Q?IfzfWdh0qQ6VfBCh3bXywjmjD9qo7RUfy1WMq2gRzxmaUy9N1c9y3RuD/Oux?=
 =?us-ascii?Q?LSHQK9MiWpGCcf4XfnvfI8kC0qYKKKIXXdeWs/I98q40P80nJprsuTY3sQp4?=
 =?us-ascii?Q?1S6+cFt9+wPDzHxXfl+7KUAYQxCGo+xvybVs1L/mc1H3/458eldDS+J20kYb?=
 =?us-ascii?Q?tO+4na+Aa4wluEZlfCrP3B7wAP2ZRGs6O/hftv4Qj8zMadtpJNGqJZ1aV0Qn?=
 =?us-ascii?Q?j0t2HwfvpHbwgx4vqx8J7ahsDj4tXLY1IbLQXHXYll3/9mgzsjR00RW2TYxi?=
 =?us-ascii?Q?S1+vQCBC/Vbij/BvM5NgTQZLAjmmdQli+AsqH4jQbb8NxKYW8Dqxt7vB5Nwp?=
 =?us-ascii?Q?5Sia+G+sK0Y5MbJqM0aBQ2IQJIvUMQq4XzUu6vrAhCYWMpdey5hT33Obyw2A?=
 =?us-ascii?Q?NL0Rd8Yo+gUVfTDMrYOfLI7btKXhl6svkjVR8VOUb6y8ZSzv6gHRAlkGNjUy?=
 =?us-ascii?Q?JgOWidDFASUuoNXMqYaQXfZaXEQ3fdty3ynzIl7gfMbwV46V66bAyPJJ5x3h?=
 =?us-ascii?Q?LRh+cu+nFGv0AIh51CwACS0IFvx5Z7zYGfqvJQbg0EqxdUxdrIKyjnlT1RLq?=
 =?us-ascii?Q?69+u2W2li/0ETGs4pNQRSVkv4xY8zAoI8wOpEBHV/FogIQM/cdDBsxXOoNKn?=
 =?us-ascii?Q?qmB5T+BRwksqFNVvMLlBt2kdQ8uporjN/QQ6ZFLIIo4zPZ9rU5aM3yAiW8Jx?=
 =?us-ascii?Q?rSOc9sC6Uz/zhf/+mc7VsaaOMbbC1Qrf/6xlXcorS0RLkszQ37QD6ITgqEYW?=
 =?us-ascii?Q?uur9vsWJx9J7nQdxNTVCVssewrXKBLiOU/wCLDO7YCxiWdovEQTNYRBs3Rbi?=
 =?us-ascii?Q?1Yl8YZuyFWhkj+YPNZRZlVxpF4ec5qUbmt00fHPT+95IYyzs/R1GGJta7h3g?=
 =?us-ascii?Q?BrLb7PZX74One5vI4HlV8U7mtnhvMCzdrxKHTJHDh4oImvZVYdOghJGHUHgY?=
 =?us-ascii?Q?ew/zUYZDYIms1/5T4HcUXoGg5IAZsjf8B1ygb2tjBtSw20hUUObod5td7E8z?=
 =?us-ascii?Q?gCkGwUKPHU33adIzMIjEcpyvdtLHHP/Sfi913k1m4jqzubjaWjbZRKb07WJ4?=
 =?us-ascii?Q?pebie1EiAFbivXba6ryKQvbHwFtX239ac+OJfYsV5EtxZoPfP/9N1c0dZxft?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcaa1de-2da4-4d60-7d0a-08da5624392b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 20:58:00.5885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMzqlD//nFTiLAasTbGc0HcfnpcmJPixhphvg9qTG0sbVnW7ipONuQLdL5ANr5rEf5SD++Nxz1bPcH+htdHbRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4475
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-24_09:2022-06-24,2022-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206240080
X-Proofpoint-ORIG-GUID: nIv-FMF51KhAGXAjpP9HMUvYh_W9h0lw
X-Proofpoint-GUID: nIv-FMF51KhAGXAjpP9HMUvYh_W9h0lw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/22 08:51, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> Originally copy_hugetlb_page_range() handles migration entries and hwpoisone
> entries in similar manner.  But recently the related code path has more code
> for migration entries, and when is_writable_migration_entry() was converted
> to !is_readable_migration_entry(), hwpoison entries on source processes got
> to be unexpectedly updated (which is legitimate for migration entries, but
> not for hwpoison entries).  This results in unexpected serious issues like
> kernel panic when foking processes with hwpoison entries in pmd.
> 
> Separate the if branch into one for hwpoison entries and one for migration
> entries.
> 
> Fixes: 6c287605fd56 ("mm: remember exclusively mapped anonymous pages with PG_anon_exclusive")
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: <stable@vger.kernel.org> # 5.18
> ---
>  mm/hugetlb.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Thank you!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
(with typos pointed out by Miaohe Lin)

Just curious, are there any hwpoisoned tests in any test suite?  I run
libhugetlbfs tests and ltp on a regular basis which sometimes catch
regressions.  If there are no tests in any suite today, this might be
something we want to consider for future work.

-- 
Mike Kravetz
