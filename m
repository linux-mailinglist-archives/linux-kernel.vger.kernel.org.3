Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E305A87A5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 22:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiHaUnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 16:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiHaUnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 16:43:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983A7E9900;
        Wed, 31 Aug 2022 13:42:58 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VHigc7003788;
        Wed, 31 Aug 2022 20:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=JU4YckjFRhn3F3wZZSTsFZeZPCj3lffR5sBjLDD9QGk=;
 b=Xsyb4+XQwA1GH6holcfdFkhL6ddKabbe1osHrid8XbEPjKiZm0Cpny7cENGfPb5PibTn
 BX1KB+VRnpE8ddwiQArINn07h7r4RTQBEUIs22r2nP9xeEMIyb+J87DUWydl1s+OVGFp
 GkxoM0p6556V4IvDUqVICkIUmrqNo5qVlZrYD1L5bqo2VOFDS6hMYRw5VTJJwHJiisq3
 jbUN3f+g5iBg6mXdpDEtk6d55fwOwNuEJKD/hbTqiv3Ut+rYRajR2ImkK4hI47qEEK2b
 CtMt1c332ZPfft42L9XnVzTSaUOwD+UDl1pUCGdeog78GCDgTE9GBRFrM+dk3L5KNGCx 3w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v0tb0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 20:42:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27VK05dJ022117;
        Wed, 31 Aug 2022 20:42:13 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q5enk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 20:42:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Go/4NdP5Yxqjn+Lm4lOELo4cTDtgFUJ2GUGEsZsIP6TquVUP2olK9k4N4ataV7uOwzeUP2bhvlo2CXhlR9rHmZhgON0xM/g2Q5NM9TuMHwgVziUhDXPxCNWgFImNl4giNbqC+ULDt9eg8ED6s9ul0eTtBvdKXowkXWWljecAgKjB+mTE/21er/CFFOqTLXkvgWiPCJ/EjYdluIDt3R+VtKkqhhwS/XhxpZxOgfbqU7jX441ZYDQXLTNzl/H9LZjDK44QwSSSALJe94+5XuPFOVoXgGLev+ysSUnfoB5hHt49HZlyn6O2aiUQQ9PgbBzAS23z6tt1yNmBJBW+jV1Ubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JU4YckjFRhn3F3wZZSTsFZeZPCj3lffR5sBjLDD9QGk=;
 b=WTm61dUFLxDvPp4wq1QMAjk/i7dCmr1JAWMT/HFwVhgRQVMHcYjDDlUhL31LqClR32giqIvDCups9VyvlV5yOppvcPbTGalZxkJ3Mo4OEXB7oy6RIlLJSI2gJkkDhbnnK4OPfTEklF2CTbsRZqkmTQ/eN1X7usAV74VlSip/x3/YffEF+aQkbQfvLpBplNoLkGlCDhejUIcNoq/mRcRpHCuYVNKxV+b6dPYWBjrnTkJoWq7S7Krsjw2gwxWKWi1szsLIxDmw04wn09X5YW0x2SmLdXh5TNNwIMegfdPoHBZXJ/WZRKzOyaULaLxpYD4rqzJL880aFmqzOjvq8TqHgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JU4YckjFRhn3F3wZZSTsFZeZPCj3lffR5sBjLDD9QGk=;
 b=sqRQgB+xyd1wwXKL6dtnskpt0So83uEd6rgorFMgCSdmV69QEfB69TJeTDFESnKIqXJDVEI/CK7rolzXSOnhdzo2L43+V7+TZf0GSbruPwDHUSX56rjoLfld+eviK6wXVsZsd6PIFPMpfin7eZLCEy+1AmddxTjwQsROjtwsQJM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB4139.namprd10.prod.outlook.com (2603:10b6:5:21d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 20:42:11 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e9d2:a804:e53a:779a%6]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 20:42:11 +0000
Date:   Wed, 31 Aug 2022 13:42:08 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        inuxppc-dev@lists.ozlabs.org, linux-ia64@vger.kernel.org,
        kbuild-all@lists.01.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlb: simplify hugetlb handling in follow_page_mask
Message-ID: <Yw/HoERzKsv1mKbY@monkey>
References: <20220829234053.159158-1-mike.kravetz@oracle.com>
 <202208311341.ybNgt0Kz-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202208311341.ybNgt0Kz-lkp@intel.com>
X-ClientProxiedBy: SJ0PR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:a03:338::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78896da2-67d2-424a-09e4-08da8b91478c
X-MS-TrafficTypeDiagnostic: DM6PR10MB4139:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j7QzZWFW8W2X+hh4iI9gY9u63Grzd6dfGrV3ppAQVZ30hlxU+S2lZNJbNNQLC1HwyMm/GCpP9nf+udR/q/QbwKqyRtUvdHRZ/icrvquauZhtgwSKhBCl/9V1i5Rat7R9IGJwA+7csVMSCGIAhTLrq78igoB++hFhWBGJV1xKWLmVy8HW2N4UkJ/WWAjB4h0AsrDDqEM/CC0kj7xpI0U2/bGkAOwh81xAXJ6p1gvHo2Gzx3YPxXNtTFR0jjeXtjbJunFmQ2HCnv6WQL3R5t0v4JUPZuuumEvNo4soCHZL1STneMrfZDJKXVlzZKrgd+gXm6JnexjurwZDwY6QHUPWeW4J6PaubssJeKJnJ4rTsNRfJtaVH8ZZQ9yFRt7NbbJNTxhYXivlxbJlkxTTHWOcsjB5VwspUpzb8UwSaLsrNY08KLcjolcNOCD61+jc0sf4bg2OdWawMCpTTSWW84Xr9rWZqD61Hb2R7mZPPBt01F41GO2d6yUODwpCwiclVf3wb6L/D4FTabRMRBCWuNWA8ysyWVgvCyQ8jgSSB0XiAuY3ZOy22PEmnEaGT1MAo3jMhYg5ccgWUXVnrxWI6mDOJG2xs74Qv5l8xfm3n9c8/0zG+QSiOtO+CnOvJOpJ11E842cHvkJ7VTOjiwh5ofEB49XlmEI6N8AssWOu1k86+NSsSS0NJP2Arfw0BvvSHjnGyACDiXrMBB/A0oSVzH1YFKhL8n9MG2TK+YGKF2qMUSuvqdKJWtJ+OM3Q8ZCObR0Q6yuDUypF4e8LnuJITOvofQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(396003)(136003)(376002)(346002)(39860400002)(86362001)(38100700002)(54906003)(316002)(6916009)(2906002)(44832011)(7416002)(66556008)(5660300002)(8676002)(8936002)(66946007)(66476007)(4326008)(186003)(41300700001)(83380400001)(966005)(6486002)(9686003)(6512007)(33716001)(6506007)(53546011)(6666004)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rX9zgvSRkx1zvRr4PuNUCwVrpY0HYMyn+q/eRqP+wlezxT9ekm70ZnMpLhns?=
 =?us-ascii?Q?S5AytcpDLsfbjkXe6ViABjzIPkrt0WP4zlw06QrKJxBp4Kvjv9G5xm1DfOrk?=
 =?us-ascii?Q?s5AOoAm20fXbJA1Jqh5qTSDx6UHy0x9DqvJNwYal6c3KtFZ1k/2CNrFC1KO8?=
 =?us-ascii?Q?XFFmWVB2Am/oGDfJylID7rXstSnMKhRLY130sfm+omWeTrfTgrFHFU2zviGn?=
 =?us-ascii?Q?TIxjcq+9lI5b/hmu5ujeouBZJpTALUGTsdKJJ+Y8l5YJwJ04mLxS/x9I8rKJ?=
 =?us-ascii?Q?f8z2t2kWzzK0qqFurFn4V9s18eZVP5BJGZBfmFuz1z/njVU2Dtp4ajSl6fib?=
 =?us-ascii?Q?5d4+Gt437yFJfHdGbBx2LZnUZL1yszvN5fhgdFqT6ZQq8ezzPSgiGlb8WOJz?=
 =?us-ascii?Q?BkVS/mPw76AALzaDADwaRHvK/VYjOIIIxyCyjdlQOcvBwG1/gdoU2cAuYRMI?=
 =?us-ascii?Q?idHuzk26ARtgp/EeVoy6yZFCgs6dkBLNLIhmXMnt/befB7+Aa4ad3nw4osyv?=
 =?us-ascii?Q?jKruZnhpBpI3KIQP4+moydGTMUfNM7ooQX8af40XwXqNUbVBi8nKSZe6a6Pm?=
 =?us-ascii?Q?yAKRRdUj8i91h9mZgkWrp8jqN3aKPC60aB7iXELitykfVq25wWoiJxqchdW+?=
 =?us-ascii?Q?XKqTQnjrB1I+eRtMfT+0G2hMpodUlbAzTM+lqfI6adLWxe2SxutWLDaVzM3d?=
 =?us-ascii?Q?2bTB3c5FUNwpFBh9K3gsGSZ9CoRq0CaNsOJ6TZpFUmAWm7/dVELCJCFcOoKD?=
 =?us-ascii?Q?s/wrCjzc+coZPHpZt5C1rfdUBaiwA4knGOy1IU1no23kWkd+wCPn4HzH2Gql?=
 =?us-ascii?Q?vji1Qld51EbmsZqpBENuvFaFV3K2zPNXjAtKhJTzeF5B1pFrBZrobGZEqmeO?=
 =?us-ascii?Q?Qy9z+fWOIRaIUJcShaxUN+OuPkaMKba1gDCpoPpM3vLQFQa+kImM7xEggrfe?=
 =?us-ascii?Q?Bn5bqnrhCtLTe6NilnjSrUE6FaDLVOadForcY2oehuIBqxyrM98NCVCcV09G?=
 =?us-ascii?Q?N/odESHZt+U4Opzqd09dHqyVBdPL5g+CcxN0SwqGCsIJc9dK7taErwKg6B/e?=
 =?us-ascii?Q?Fu+E8Yz4BGemPj4Rdz4adNF+39k9TDQyfiwiJs9MmjV/+Snjjs3p+901NkzP?=
 =?us-ascii?Q?FetHkW9t8UsdEvHDFXpNzVQMpqhINGvjEPUtzEN/+ol2VC3Rn16ia08WDSve?=
 =?us-ascii?Q?GtPBR4HhxaCVpdOLZhMRq15teVmylgCk7ycVeXejDA508ba1EmGcrtPVrYf8?=
 =?us-ascii?Q?JhM0BC1OM0qkwpFRyItA8PLG0n/4cP9NHsI5suNEKgBGRqB7g2PdPTTXa0Al?=
 =?us-ascii?Q?+WHjJX0kiaxv9pbB7NfbYXZlL+B/sRhT0IxY3/22dpa6481N9DC2hkPws7hw?=
 =?us-ascii?Q?nU3EFHuOB6EXoUwHJ9ETY/KdQcVdUhr0L5hHaYr5LfQ1B6iaqjnWLY4zZ9IL?=
 =?us-ascii?Q?L1/s7EQ30iLpQGJMrWQ+3WZbqyXarniTR7gVBK1t7NB03dnPBAZ3ozMmKhIL?=
 =?us-ascii?Q?yNE4gK/s1cvrFtjnus3ouj1P2W/9W00NGWVvhKjdT9i1fhvRWFKKFn1uvVZB?=
 =?us-ascii?Q?SrnfJ2bwTHI/q4t8R2i2Ve8zuG6YTB0OOGZKzBLWGZlPs0KfKEjys+KP3CDC?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78896da2-67d2-424a-09e4-08da8b91478c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 20:42:11.6817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1E7jemzZTRI7NVrbOkpOtV0Oz5ieOWVtfeQ3eilPGxn8WUig3MvuxBmo8vZy+/wAKJW3bqu6p4/xOH6BotE0IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310100
X-Proofpoint-GUID: 83DH4SpKuFDZcKrcyiwSXSVH-lv6f1rA
X-Proofpoint-ORIG-GUID: 83DH4SpKuFDZcKrcyiwSXSVH-lv6f1rA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/22 13:08, kernel test robot wrote:
> Hi Mike,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> [also build test ERROR on linus/master v6.0-rc3 next-20220830]
> [cannot apply to powerpc/next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Mike-Kravetz/hugetlb-simplify-hugetlb-handling-in-follow_page_mask/20220830-074147
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> config: powerpc-randconfig-r001-20220830 (https://download.01.org/0day-ci/archive/20220831/202208311341.ybNgt0Kz-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/f7dc41c1552ecd1e483a100c8b0921df62980f38
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Mike-Kravetz/hugetlb-simplify-hugetlb-handling-in-follow_page_mask/20220830-074147
>         git checkout f7dc41c1552ecd1e483a100c8b0921df62980f38
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/powerpc/kernel/setup-common.c:35:
> >> include/linux/hugetlb.h:258:21: error: 'hugetlb_follow_page_mask' defined but not used [-Werror=unused-function]
>      258 | static struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>          |                     ^~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> 
> 
> vim +/hugetlb_follow_page_mask +258 include/linux/hugetlb.h
> 
>    257	
>  > 258	static struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,

Thanks! That should be,

		static inline  struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,

-- 
Mike Kravetz


>    259					unsigned long address, unsigned int flags)
>    260	{
>    261		/* should never happen, but do not want to BUG */
>    262		return ERR_PTR(-EINVAL);
>    263	}
>    264	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
