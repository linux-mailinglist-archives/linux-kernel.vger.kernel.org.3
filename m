Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D2C4F4FB0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839227AbiDFA6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384699AbiDEM1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:27:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8D16A00A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 04:44:13 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2359UuYY006378;
        Tue, 5 Apr 2022 11:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=HMgFTs78o6HyO3q2UWbaZPBGpVCKBAa8QQovjlQpQ48=;
 b=C9yrY8Vyk+hxVkg9VvfwRyXv9e8hGolfASAFao9vugPHemv7KNXOOYjGtJbb8Ek5hEds
 iL/4zsKYTYeRVtgsQgERZuGZvwpErJ9+Awci/OYfwNDuJacUiWsKQJ9MK6OGdfWQ2Htv
 3UHtgxGwLX5Eu+xypVEMy/Gv3qn1gG8TnZhIGLHGW5DiyD2sEgUHnB8mT+AqGkHoGFiB
 JBLCPv0UxyNxN2ndmi6CTMTb7Q9wzldl5ZjcbxBoaGpooHjVVmd4xYXohUCLwcnZ4ONz
 ZsTQjDA1knjEBXkAD9MaoXT6zDlhiI+6cfoCFl1pwJ8VqlIUdIa775tXmWpSMADoAvKC Ow== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31dunf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Apr 2022 11:44:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 235BfXog007303;
        Tue, 5 Apr 2022 11:44:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx3bug0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Apr 2022 11:44:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lyuhj6VFd1N1fieIbS1IkNF0SzLX33XWs5zlnPBL3SXXBSIqK6gRyuHNXPVQCvvEWZfeeKZJv0pHf9a0ZE7E/Rymv2KpceWFVffT3qw3ZQxoH8ATS7GSEw99KjjDtIdh6TVmh2q36Go/3Ohrwn6mvxAW5q9u/PWmRiytSRV+3JixenBvnZ6EsuZDE6xKVlejrHgx8WNJObLk8P+AbIFntglv8P4JexlrnmKvOXpLzxDybkbXJ23Xi2zlPgrFcSaAst8rF+d3L5cEivjpc0jD+xJSI9jNgzgF1KFg8NLCUmxywM1NH63i29zjrz+3BTjgYyIhHweh9PZ9lU/93v54/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMgFTs78o6HyO3q2UWbaZPBGpVCKBAa8QQovjlQpQ48=;
 b=OrTptTTOImjj+lxMX9jJ/xgXfWPjzG5o37AEF6rrza1M0Fv2IFutOQdF9XKQp3qVWGAdzlg5RuGBFMpPEezqKFfCINwU4/pIl4JsjhY3w/O6z2icjNhPnCsPIB+OtJLy9b+dd69JH341ShTl4585ZwCikfC/amaDz9gT4W+skOroUwQuWGeSOFcawknkfRcGJaQIUAlLpKQdGm+yjrW4gezcTRAz+cLwZF5jnQWQUaCaFz7kYLIE9KRHvrcvXM+qBcUNwAeD568VuabzVWy8NsPb6XMATl5Q0Kk4E0SVVaXZAJjPi1wWfGlKKDXzWoKz0kksPFAqrzUmxHKLW7nVMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMgFTs78o6HyO3q2UWbaZPBGpVCKBAa8QQovjlQpQ48=;
 b=dprDKJudgK4IdV6GYiSOjONB8oU1UtY2N6jf/Md6URUW1e9B5DtW0vsa9Cu1CLZGJtH246LGt70kGFFG8Mfl3KYDTWpyrMENktcXehhTZjoczKF8iFreNrUy6idBSjFIGGrRRdJF6IQKESWqqPT4WnyxMQcfUQQQNaA8ikqLr0M=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB4007.namprd10.prod.outlook.com
 (2603:10b6:610:9::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 11:44:04 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 11:44:04 +0000
Date:   Tue, 5 Apr 2022 14:43:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, David Howells <dhowells@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 35/40]
 fs/netfs/buffered_write.c:793 netfs_page_mkwrite() error: uninitialized
 symbol 'spare_region'.
Message-ID: <202204051945.mr2bveSZ-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0046.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::34)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d2e55b6-59b3-4573-c553-08da16f99555
X-MS-TrafficTypeDiagnostic: CH2PR10MB4007:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB4007C41084B6C31BC0BA45918EE49@CH2PR10MB4007.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sLjE5oXLpYMnBwE6PY2rhj7nbPm+8QuYFqCIF2hD1ZCxSMIIfoYnO1fH6RsqHWrud+xP8SzsUHsWOcI8jav0J2OKWH+STZTaT4Ew5lguu3TEZOlMpO3Nb3QX60R7IFlpUWln/qFxEkoupiZACkvgXDAokG+VDgINgbB49Amlo0vGmR+Z3rtsX2iMC8byLmkPiqWDnEO+6pqrstVxC9fczrQcrmE3vt2cPVbuPI/Xz2pYP9s2jEMA+xLHzMDK+GXsIRqFJliuwTKGLOqLx0S2vsZgciYs5ojx2cZMhk+B6Z2BebyHZuIrvaOnMik3XPUWqHrzJc9sz2xQeNBXQ9mqCRlYIGH+q+iefSWmA5rDi/R5VN7d+At82G8Rmu/siawE8KhFlsaqW0S97t08qPCNQl0KJhlRdXbOt7ihO7AeZ7Oc8qycRL5stm/TbfbsK/mUndXxNNAhf4lArm48Hl1+VvGANqFkq10/mqyVZW27p18oXjJm9yVPJfatC9ldhU+2XxGtkNONOYJjo3JYWcKk4emXGPI72Jzf+ugqSVwErmGA+l1YzG+pgv3Z7ra30g4wHeOoioJnx27+tvsXJSMoXnl8WzeKMbxmwp6JbxL379QD+tM+0iCzXZ7G3bQyXpCTVdP1B86MVKzMpIFBYNWBETNJo+2b+tSlIC7kGLdWa0U+WTHgYGLrcVrDwBtmCrrfvOodqeCvZxKwd7PPuF4cC1L+vvOAQFFWeKyooORuagK3AA2RhYO33OwQ41UaLGfQiOrpVUUNG58bqUmod3NAYd10F9zH81mLq1UJ3N+aXlHnQV56nzK10fQ7R7E9oBye+uHCvqw54F0y4xQj9/bRRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(83380400001)(26005)(508600001)(966005)(6486002)(186003)(8936002)(44832011)(86362001)(38100700002)(38350700002)(6916009)(1076003)(66946007)(9686003)(316002)(66476007)(6506007)(66556008)(6666004)(2906002)(6512007)(8676002)(4326008)(36756003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I/Y0ZdxxUXasuhcnBTSRaMELU7BVn33bk9LsFffXentRg2OvaggvxSPZmy9k?=
 =?us-ascii?Q?jC337trpvEsSsqvwOBNq6UxYw/csfbjlCdThfrehFmZXTT1wbP0ie8txySRf?=
 =?us-ascii?Q?vyMOMY0htQjJZztNxKjjEC0ipPQZbDHDlUSZFiVITyBQ9shybUswSokq13mH?=
 =?us-ascii?Q?TTEhG1QrOL4IYGqiWKRrszh7koW8rDTKqbTkudJqq7ELd8quCxQoXtk6ns9H?=
 =?us-ascii?Q?TvpaG4dLmwOl1M1BAZUPmb5cdv8Ce7fTh589cw157+9gOkzcku5yfJQG3m3N?=
 =?us-ascii?Q?ZgYL1MirlT2T8wAW4XDZWY1a1ePkzpc6mFj+K+wAGvDHdzlxL9w/nmGqIfJ1?=
 =?us-ascii?Q?PWNM/muC3cNg2jAT2+s9sPez5LtRcju7ZS9MqisD6I/G9zR5iSmytPU5/IhW?=
 =?us-ascii?Q?iso95dnngSo4RHsEGB9TGqfJvf2AqPEZ0ZE8XxGDk4OfOlivK3oUxYFLPwcx?=
 =?us-ascii?Q?k5yYTSrSwal2hq9NaZzdZnJsiHWVfBV7Uu7QCdxsjM/BeuEaY3HnzNLGGnGK?=
 =?us-ascii?Q?yd0mDCc/R3uTkM/2hiG4PCoDABSXHL5WynDtfHkPccUSNNkVZW27s5h/hZu7?=
 =?us-ascii?Q?WhEy+uhbYX+m5a0JDMu/T3ofhVVZueJGT57GXntsqqkJAZ/BM7hIHKatl0+b?=
 =?us-ascii?Q?tKHtdvlM52LYLnQJ3watoDclttWlaB1r81/7+BW/UX3CJQYruajzXrdMpmsO?=
 =?us-ascii?Q?UGSBzvcfI9KzWhrSDXzeL+ZKjPgP80JCyxoWfn3ra3TBgGK06eArppnRN6hY?=
 =?us-ascii?Q?ymmeskImKlTqjdoPTA0iliIl7ihmeIVjeSZBOvwiQACJX9s8JAstH7+xEVuT?=
 =?us-ascii?Q?iojrz9qmwF2uASLNVfO/Q8WX9L115ODknSizwrqM8uG6uXh1umCKdW6LMz/f?=
 =?us-ascii?Q?cOIpsjka3Rzq63tEL2MW7QUZL1GxppLXNmFFzIG3Mj2kgXKaV4mkdLSjbyh+?=
 =?us-ascii?Q?bM3P+YR/ra6aKOdjOs48gJFfcUD3bMYXUOHpureVMsOO+rcUXZ2YdtXxiTer?=
 =?us-ascii?Q?MzdkBF2phaBiqjKCSuw8b8Zts9z3ZQ70qwoUkdV6j3T97OsjdWCiBAVvd7Tl?=
 =?us-ascii?Q?yI9dxvSHmaTHeMXCFbKV/pXwubiLhDs64+iLdsXR7lLZZqeuSomm6NDP150H?=
 =?us-ascii?Q?N6/dg6gDR5SQRyJe0caD6Gzwk98dR4LHqoF8FTcKzo4SoAIe1ccI/2ag42IK?=
 =?us-ascii?Q?7DsbyHWAzdpjY4G4l5P9Z0OPrb/96EtpzKuEO9/xfyHOW3LXa+g94PjJenWX?=
 =?us-ascii?Q?IPZ8R1hoOU60iEXEWE/6E9BkM+fHZIiFHllAjQVeteJQoNX4U5we3KVgzynW?=
 =?us-ascii?Q?DSNDVHqeq9KFRWh4nK54+vvYwXLj3XqlERhOKuZqq2ZfzKN4cMLkGMEWV+Qj?=
 =?us-ascii?Q?MjvnBC78jgIdO7NaCuvemqhPPZD4HHTKNrNFiibvlnGMg2Zs/CP5xhotfGzz?=
 =?us-ascii?Q?kCwtUiwyBrbns5ZRdnB/A4/63XtiVapkszPg9l8eKp7OCY29YjT+9aOkA1lt?=
 =?us-ascii?Q?Di5uoqZRMpavU0AL739lEIcR59NpTM7QNtOkGkAK0qWJcqEmscttXAInV6vi?=
 =?us-ascii?Q?Q7w4+j7W2sKaCbbkriKaIT7sJJNZ+pNiTsfb39yS08ZygyJYXdxNPMVfx/C8?=
 =?us-ascii?Q?Sx60p6XeJBOdemWUMnqxttG2BpM1cQQ5mIXgmWSscK6ROHXwXT0TIuIQdYgt?=
 =?us-ascii?Q?gYq2MW0Ad6NsafiIp2VxtXRjCYQXXtPohYrBUhiOvQbLaQiWf8+VhHSNuSsV?=
 =?us-ascii?Q?fkp1wRWJaYg48dHPW2Wblypxfm3n04I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2e55b6-59b3-4573-c553-08da16f99555
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 11:44:03.8815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oq5VSiRKklfmEjwRT5IJYhk1kl35LMa51w2Rirai46R22kYq4VinvDhEXOf8vm2/scrI35VYfz7yEKmmslpRojWApDppc9VI2JR7HWpxxyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4007
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-05_02:2022-04-04,2022-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204050069
X-Proofpoint-GUID: WiuahVn6EqjYbHnoXxD2Uaxy0bWwp1Zc
X-Proofpoint-ORIG-GUID: WiuahVn6EqjYbHnoXxD2Uaxy0bWwp1Zc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   674eea41fc70a740ff83ec590f9833f805852464
commit: fc20927bc9709523b2a53feee2a52423b9d66456 [35/40] netfs: Allow buffered shared-writeable mmap through netfs_page_mkwrite()
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220405/202204051945.mr2bveSZ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/netfs/buffered_write.c:793 netfs_page_mkwrite() error: uninitialized symbol 'spare_region'.

vim +/spare_region +793 fs/netfs/buffered_write.c

fc20927bc97095 David Howells 2022-02-15  732  vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf)
fc20927bc97095 David Howells 2022-02-15  733  {
fc20927bc97095 David Howells 2022-02-15  734  	struct netfs_dirty_region *spare_region;
fc20927bc97095 David Howells 2022-02-15  735  	struct folio *folio = page_folio(vmf->page);
fc20927bc97095 David Howells 2022-02-15  736  	struct file *file = vmf->vma->vm_file;
fc20927bc97095 David Howells 2022-02-15  737  	struct inode *inode = file_inode(file);
fc20927bc97095 David Howells 2022-02-15  738  	struct netfs_i_context *ctx = netfs_i_context(inode);
fc20927bc97095 David Howells 2022-02-15  739  	vm_fault_t ret = VM_FAULT_RETRY;
fc20927bc97095 David Howells 2022-02-15  740  	int err;
fc20927bc97095 David Howells 2022-02-15  741  
fc20927bc97095 David Howells 2022-02-15  742  	MA_STATE(mas, &ctx->dirty_regions, vmf->page->index, PAGE_SIZE);
fc20927bc97095 David Howells 2022-02-15  743  
fc20927bc97095 David Howells 2022-02-15  744  	_enter("%lx", folio->index);
fc20927bc97095 David Howells 2022-02-15  745  
fc20927bc97095 David Howells 2022-02-15  746  	if (ctx->ops->validate_for_write(inode, file) < 0)
fc20927bc97095 David Howells 2022-02-15  747  		return VM_FAULT_SIGBUS;
fc20927bc97095 David Howells 2022-02-15  748  
fc20927bc97095 David Howells 2022-02-15  749  	sb_start_pagefault(inode->i_sb);
fc20927bc97095 David Howells 2022-02-15  750  
fc20927bc97095 David Howells 2022-02-15  751  	if (folio_wait_writeback_killable(folio))
fc20927bc97095 David Howells 2022-02-15  752  		goto out;
fc20927bc97095 David Howells 2022-02-15  753  
fc20927bc97095 David Howells 2022-02-15  754  	if (folio_lock_killable(folio) < 0)
fc20927bc97095 David Howells 2022-02-15  755  		goto out;
fc20927bc97095 David Howells 2022-02-15  756  
fc20927bc97095 David Howells 2022-02-15  757  	if (mas_expected_entries(&mas, 2) < 0) {
fc20927bc97095 David Howells 2022-02-15  758  		ret = VM_FAULT_OOM;
fc20927bc97095 David Howells 2022-02-15  759  		goto out;

Lot's of goto out before "sparse_region" is set.

fc20927bc97095 David Howells 2022-02-15  760  	}
fc20927bc97095 David Howells 2022-02-15  761  
fc20927bc97095 David Howells 2022-02-15  762  	spare_region = netfs_alloc_dirty_region();
fc20927bc97095 David Howells 2022-02-15  763  	if (IS_ERR(spare_region)) {
fc20927bc97095 David Howells 2022-02-15  764  		ret = VM_FAULT_OOM;
fc20927bc97095 David Howells 2022-02-15  765  		goto out;
fc20927bc97095 David Howells 2022-02-15  766  	}
fc20927bc97095 David Howells 2022-02-15  767  
fc20927bc97095 David Howells 2022-02-15  768  	err = netfs_flush_conflicting_writes(ctx, file, folio_pos(folio),
fc20927bc97095 David Howells 2022-02-15  769  					     folio_size(folio), folio);
fc20927bc97095 David Howells 2022-02-15  770  	switch (err) {
fc20927bc97095 David Howells 2022-02-15  771  	case 0:
fc20927bc97095 David Howells 2022-02-15  772  		break;
fc20927bc97095 David Howells 2022-02-15  773  	case -EAGAIN:
fc20927bc97095 David Howells 2022-02-15  774  		ret = VM_FAULT_RETRY;
fc20927bc97095 David Howells 2022-02-15  775  		goto out;
fc20927bc97095 David Howells 2022-02-15  776  	case -ENOMEM:
fc20927bc97095 David Howells 2022-02-15  777  		ret = VM_FAULT_OOM;
fc20927bc97095 David Howells 2022-02-15  778  		goto out;
fc20927bc97095 David Howells 2022-02-15  779  	default:
fc20927bc97095 David Howells 2022-02-15  780  		ret = VM_FAULT_SIGBUS;
fc20927bc97095 David Howells 2022-02-15  781  		goto out;
fc20927bc97095 David Howells 2022-02-15  782  	}
fc20927bc97095 David Howells 2022-02-15  783  
fc20927bc97095 David Howells 2022-02-15  784  	netfs_commit_folio(ctx, file, &spare_region, &mas,
fc20927bc97095 David Howells 2022-02-15  785  			   folio, 0, folio_size(folio));
fc20927bc97095 David Howells 2022-02-15  786  	netfs_commit_region(ctx, &mas, folio_pos(folio), folio_size(folio));
fc20927bc97095 David Howells 2022-02-15  787  	file_update_time(file);
fc20927bc97095 David Howells 2022-02-15  788  
fc20927bc97095 David Howells 2022-02-15  789  	ret = VM_FAULT_LOCKED;
fc20927bc97095 David Howells 2022-02-15  790  out:
fc20927bc97095 David Howells 2022-02-15  791  	sb_end_pagefault(inode->i_sb);
fc20927bc97095 David Howells 2022-02-15  792  	mas_destroy(&mas);
fc20927bc97095 David Howells 2022-02-15 @793  	netfs_put_dirty_region(ctx, spare_region, netfs_region_trace_put_discard);
                                                                            ^^^^^^^^^^^^

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

