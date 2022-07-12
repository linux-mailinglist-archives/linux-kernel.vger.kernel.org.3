Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032BA571A21
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbiGLMgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiGLMgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:36:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4D4AF77C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 05:36:04 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CCDejv009315;
        Tue, 12 Jul 2022 12:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=FtO/gq08lCRe1n8ZMatUYq2jYlaHPlrspjqUzaaC7Rg=;
 b=JxE2aJ84DCsw2CC3gKZ0pfLVdw9huMkXpfjO/mdMnCunjWSNKYZd51a05/fHOaUmn0qe
 2Eo8vV7jIVlnxV0FkvpJZ0wIAuuWp4ADyKTJ5fHpOEckVb4xnqVq4VKBAcNXvkEgj1Pg
 jhTtr9uDB9Wnlm+TqgPxq4i3plM9d8IpobSK+e+SKSwyfucDSbfGieGNaUPiQe3CiiJH
 0r0f8GZ1d32Oxlu+g4XFPMDZEeB/SWJ3JdoABgp6j3cWBUWKqZalEwzIX4WlHDMC7VGp
 T05NsA8T5SZ6Sizj8UvMmtfeV4MCFZm3TvjuPSWzE3LNRkBv+x98QkOixpSc++TDC6jZ Bg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrekbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 12:35:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26CCKCfI003031;
        Tue, 12 Jul 2022 12:35:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7043knc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 12:35:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbyAhrMa07d8bcpjCOxKVsCAJ+9v+92wxtWyFNbjbpMHso0noUv4QlO6n7EQDgXa/HaDpb00mVF75hdGyOWWD1QpBT6OnacVtMHpdAbcebh0Nl5bz8Sg+zjf13D1sgChFBX/c/jvGwJ0y7YGdpZ3KdI7Ha0Hasm1o61kUuswexYaYcU3F42UGmuA6DQ8tGb4iVcSR8YFA/vo6r2X7kB7AkQRyL6fcmjtgsX3wKW093Hv0N+IvJW3BfWTjnLL1RFnPpzz8OimjvV+fMK/EaBdtxWGO8tKdNO4evUfgaDCpIJgz4cyXs+dGNZ4dRVClO9zbo8lgeA/ftc58o8I0KUJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtO/gq08lCRe1n8ZMatUYq2jYlaHPlrspjqUzaaC7Rg=;
 b=C4FABNabK6v23T3YVID15LuOHV9UJrqdKsf5XGFhhdDOGFJBcMslYDXtU+aK8p8H7UmcQkTgDVhSVRAS42Jd9JextKovujHTBeenNxUnVYt29hsu5c2De6qq+N74UbpyDDKVqnw8QCCX+yupew+cz/Qe77KcceiVsBBl8Ab79bfJnq97d6s7sH6QNPXu7WUFWE9Uh602wFQV8O6/7bvnWmGPWC19IbH24/H2JmRRYRgy7LKoF7bY55mpMX/I9CAd3X5uwkoqdWO++PleeFUcLZKoU3iuANh7tpyoZtGbUOZZEmoRmFjDovS8WyUXJ7xF5bFCMG6vzN8aCU4+9iw3mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtO/gq08lCRe1n8ZMatUYq2jYlaHPlrspjqUzaaC7Rg=;
 b=O7/QH2PzbJ+YArUYj9DymhczVk63fvxjrsG0NSO2yNoKBVK1zR/1pSMKb2Oh84SSq1I6F04a9QxTxopCA7eiJrM3TTR+NVvkT0JOn001aVWF6PGs5kD6B6SrsKFSY+a4S/YlZ4HEDgFe4pCILEBwCwvwclGX40jAbWDQ9JaBgdU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BL0PR10MB2900.namprd10.prod.outlook.com
 (2603:10b6:208:79::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 12:35:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 12:35:45 +0000
Date:   Tue, 12 Jul 2022 15:35:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Zach O'Keefe <zokeefe@google.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [akpm-mm:mm-unstable 284/293] mm/khugepaged.c:2409
 madvise_collapse() warn: possible memory leak of 'cc'
Message-ID: <202207100715.TBIYQ4fc-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0164.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::27) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78fb96fc-d723-4a5d-97db-08da64030adc
X-MS-TrafficTypeDiagnostic: BL0PR10MB2900:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yjGhy1CsOZR1LKO5xJjQH4ZqORPuEXhPNBe2wLEgo8be2jaFVUmZsvO3fgyVGPFpouaIaARh9liCxvQxwhE0QCy062lZDecfR1EEHAgauxqnSIyc8aU+uA334bFlrlLW73eMC3tLroxuLBRZ7AzQABSYKINVBUw2OTXJggr9x1mgnT0tlhb1NxQvmLrKGvQn4sq/ZkN9MqFuFjipHrrqPRqDqPNvBcFIULDKt5CizlduoUtI+pjhGpoMAxhSmbbTpTkM/MRO/i5/xJ0J0/JThgzzzunmGRgIl1vlxUcXBwT4WpMSHHE+p86uuunIOgDjDimKE9aKrIqnr3Xb6MEKretU2gBesiHPE5F2VHbTAmXjaBOMoNf9WaacJfUsh37WGgKNNrr1wCXJmvYwVeL/B0SIhyAbvKgVVmL7/PVh9/VAnc6DAHm9o+7d2iKEzJsYJJXOhZM641dslZEDsVWyJFlzCpPXyZXTzTJ6AFuoXWUyfQh5iTOJCpnTnuZ6qJ3nVj1vMlUNOc17OfgmcuR0CeT49cpp98qbph2QEKLTHkbXhTDEHg1E7hzQJ+AIALXsAygXHBu4VoGq8wXaxNEr+7nih1VFuthC64yINzZixiBRLR5Y7PLfHyXNuU+gG++oSlVUR7JQBsOsgAFkhJZtHnPVkGUyi54cTxDO1Q0YhN4za/RuysDvG2gepVdxEZQHrqlrWUMZJ2aqbJzoNVjDT9ZgqbiFDM4Cf2jOcJ1E+1Ab8giXWRM78/fbKkn6ZUoyGKc3YbeVZ+YlzSmeuC2S+lhgxvixcOZrC52JEXFRcFLe8yWyXTcIy+rxPz+YTzyqp5160wLqTLOGpM9Uu4Ktq+dItRWWvBLd9Au9mudRBAWwoB0RTZs0zGWsSRGYsIo3W14qz9mBGcW50u0KO+8JPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(39860400002)(376002)(396003)(366004)(44832011)(186003)(54906003)(6486002)(52116002)(1076003)(4326008)(66556008)(6506007)(6666004)(86362001)(8676002)(6916009)(9686003)(966005)(6512007)(66946007)(26005)(41300700001)(316002)(36756003)(478600001)(83380400001)(66476007)(8936002)(5660300002)(38100700002)(2906002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CRqTqL1Xdh1Z3YPN2nz+exXtL6dAd5UK6ks+NnD2msOWqTatENX9mhP3b4kf?=
 =?us-ascii?Q?lFZMQWCkQPOVeeWBpB7CaPLhDYn1UjCQ7x9GU6ABohg6clFtabKcbBJAWCAB?=
 =?us-ascii?Q?MWz/gOGc5UUP6KFHOgi9N7O1HGMyMRdHkuOlMpX6vWbFf8EfnM/FMBT3PSkF?=
 =?us-ascii?Q?ffnhpW/LtZ5g9E5vI8Z+AYZZQY1yPQO9+lk5wjuHbszdEVnvC6QAH6p5Eehu?=
 =?us-ascii?Q?dOvbLJqoiU4K+LbjSvRlRPHrP8NJcXYQxVCqAuNosla3RBj29LEy0vVKY96N?=
 =?us-ascii?Q?Q/SHVW73ZFjFx11BgnGZHCmmI8EfOlnirorjW/5pTqW4cNE0yw8HZLn3xixh?=
 =?us-ascii?Q?5w4vl6/xO33cM6yJaedbEFB8MJdnglBF6CSa7wO1OdffXDd6Mcw380oweWQ/?=
 =?us-ascii?Q?mLecSpCVxgi7czeps/92gDsLLgjbdM2v6Y77/D30EDzI7C3jPzk4PLVjHhF/?=
 =?us-ascii?Q?rqW5XiQiUO4uPnZUOAJO2Kj+i145x3+f/FBAWww4PUzttESHhKhGM6OSFh6K?=
 =?us-ascii?Q?f3txJQUsn+3vxaIeQ4fWD6eAtwA/HG/YNPpL/qS+2fDMvIjEnD09uk9bUv4y?=
 =?us-ascii?Q?+RPGTuVq5uf38O7nNJo2/2+5loOdbDeRyx+Pti8rtQUXhsibLfGU9SPWxM5D?=
 =?us-ascii?Q?R51I0TjFPqFnqIrn1MpO+bvZ6FLcL3wiDfpv9BeMLFcR+On8Pi2Xhf83VzFS?=
 =?us-ascii?Q?1+cVTqXtHJ3cGuKPSAdHeQiAddAMtv1MI0UVo7X0YCPN21BsPs51oa/mIRId?=
 =?us-ascii?Q?MYpMAZj3KAteVmAXVoKYEOHtAjAmrEcf9NDhEepkKjZCT6DEVGRsqqxE3PCu?=
 =?us-ascii?Q?bdhgWRFVhV2YcNgLKG6LLaDKUyV1+W1tH+h7KHUSjNEXZTD/iWYQzlwjDAH0?=
 =?us-ascii?Q?qoYmuHPIbkyLe7hXgsllyuFnUTp62G7CHjr59abbHdEAo4XmjR90+X1yTM2c?=
 =?us-ascii?Q?2gHZsmBTorrocA+dT2ewL9JtZDWkjqXSvoukzVsUBgzUbOIWyS2hgByR8nx0?=
 =?us-ascii?Q?LOpnLrqx4OJ+8O6Y8rj74d1QiZtQ++yXst6uXYMRShTuH6n8zYk0lsA3XLya?=
 =?us-ascii?Q?CHSnWw1SweuQuRQyZLpXqjNhc3f31InwpliAyGpXlbLa0t0l67VM+II38K8p?=
 =?us-ascii?Q?D5R21WBof6I4ABxoWfiEhgmui3ZjoQfTkXPqS6dK3bBfZqMEvjdua+8CUp/J?=
 =?us-ascii?Q?21QVgYYjpg+SB1dHPFWc1VA9FuisWWzd9frA8Dol+RXTI1+/KMeSRZJ2/i/4?=
 =?us-ascii?Q?WhSjZnM00+tgFJJV21LEKZBfW9BzKpo9mMhuUtSKhSnfeHo6LKq5fp1Mogxa?=
 =?us-ascii?Q?DAnAK0GvO9b5Kcvn18cDa24x8RSv++TKaBEmtAmiwADgCNHsFEm/q2tdAjY9?=
 =?us-ascii?Q?AQ059+u65Q3znWJ+slB8bfJpoL6TgjXu1KNbYhPxNAYed/5UcvMDbri3kyoO?=
 =?us-ascii?Q?tQMlRt/By9GxV5lYsHsiUTRvl1gmhhZIjVw//CQONP8MjmzDPDapLaQ5XJCw?=
 =?us-ascii?Q?jgDD1r+TOYf+d5rJRpNj93Bm7MCMhMzWaNTPzkGJTfTyId1z80ZygmIsmf9o?=
 =?us-ascii?Q?iXn/BlEE+CAECYMZSx93vycAOqS/MLRxHNodcMcY95M+qvXub7iryT7SVZTv?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fb96fc-d723-4a5d-97db-08da64030adc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 12:35:45.7817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QubtRYfsdrJZYS8klNYODROLMTzobcU1GHrkA3YMaOBl7QiosQ5mWlOZ7mZFeHa4U2tfHLgu9FEWIPvQLfJdYPTU+LhzPKXIcRmjzhPI+hc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2900
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_08:2022-07-12,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120048
X-Proofpoint-GUID: bAA6-w4x8M6BzQzft3SKIjJeOz1lxqn4
X-Proofpoint-ORIG-GUID: bAA6-w4x8M6BzQzft3SKIjJeOz1lxqn4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
head:   0e9f775fb0b4adf1a4ef50ea156ead09a0fc5194
commit: 9f626ffb1d1c5c26b4a8e0fdffec784a5f773274 [284/293] mm/madvise: introduce MADV_COLLAPSE sync hugepage collapse
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220710/202207100715.TBIYQ4fc-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
mm/khugepaged.c:2409 madvise_collapse() warn: possible memory leak of 'cc'

vim +/cc +2409 mm/khugepaged.c

9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2387  int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2388  		     unsigned long start, unsigned long end)
9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2389  {
9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2390  	struct collapse_control *cc;
9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2391  	struct mm_struct *mm = vma->vm_mm;
9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2392  	unsigned long hstart, hend, addr;
9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2393  	int thps = 0, last_fail = SCAN_FAIL;
9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2394  	bool mmap_locked = true;
9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2395  
9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2396  	BUG_ON(vma->vm_start > start);
9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2397  	BUG_ON(vma->vm_end < end);
9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2398  
9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2399  	cc = kmalloc(sizeof(*cc), GFP_KERNEL);
9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2400  	if (!cc)
9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2401  		return -ENOMEM;
9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2402  	cc->is_khugepaged = false;
9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2403  	cc->last_target_node = NUMA_NO_NODE;
9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2404  
9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2405  	*prev = vma;
9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2406  
9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2407  	/* TODO: Support file/shmem */
9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2408  	if (!vma->anon_vma || !vma_is_anonymous(vma))
9f626ffb1d1c5c Zach O'Keefe 2022-07-06 @2409  		return -EINVAL;

kfree(cc);?


-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

