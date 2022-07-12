Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE00571622
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiGLJua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGLJu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:50:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193A233E33
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:50:27 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26C7twBs018649;
        Tue, 12 Jul 2022 09:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=hJUGMg0dH5A10GoMzfSmBGPfdksK8e073Pc3dP4EUvg=;
 b=HtDhI1Z9FeOtv1VuDBejJe8xIDZuLo1bTCBCYBwcL9M7Cc+LdoZTZ9cHvfJc++I7rY1U
 V17cVlv+7DvZu2jY//6uFiiHcUQ4UBHuyGNaE3B2D64sYbLVk0KOQDxiskvw9vOQA4MH
 boT5ZduTJQj998Ib/2jTNH4xRPI6P32gPXjkXETak/GOvPmXohzhNPk7YiGSyEmDnj7j
 Zl6sLrY71r5VdoAvcdtTuVwQcul9GZj9AVghQ382pcsDPDPzZ99v3sUCR+rUAUh4oWvD
 Youd6abqn/sgg+Q+6/ynDrZ40KalMIAnvJi5mCIk44kc71c/LKjev0kwl9Up4idcG3Ws dw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h727sects-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 09:50:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26C9fJNK008319;
        Tue, 12 Jul 2022 09:50:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7043g5ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 09:50:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JR3PZNpjN+GkDmJ7tTwVsUCoNSIoT79hwnsoWiE4KIF8w04KD1p5xt6VOf0TjBusEpwHIm9BKrgus3+WGrcicUnbH062hQjWNdt70GV0qGgnhhboknmR0tPOymENZiaNYO3snhuWy80fGKHUkByLCCLMMu1uw4F5YzeI2uwowb4TM4z5nhdL42cgZGm1bbuNl8XgmsRO1AlIZfuGq5ooyxTIHo6Y42l88s1VTbtyg1CmVNoBohKUVw/cyfJkon8luz4g1lEVJD5BCfFCc6TDM9YNSdzmWm7+y1WHqpopQHoX0PeSGBc8sn1prl3s2Im542omP0Y0NWwtSUCK3OgLSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJUGMg0dH5A10GoMzfSmBGPfdksK8e073Pc3dP4EUvg=;
 b=J2PWcNnMSJk0TDP6/hnn7SZ0WMuoiUCMAQGopQLd28sz2kQbdKNx+MebAVqFKcwXLn+RMJwaC+xTOxYqRwvBSDsOXEM2HfH/+sFvBLZ9cmd3SCI6BB6/uLpnGyA+tna86J5aN/RcD3zsOmrudv850bbF+drVa/aIPPYPqFDFY3SdFV5T+gh22KM0vE3tqWzQ8b/6m4lgfJ+HVjzkczesfArWIDI2V6pBbO60UqHCjeczTTmrZp09jFjFMnRgwa5zf3DJGW4XqTRKi5RWPF7NbfhrlxWa7l0suC/087fgv//+cV4w327kP5QfNdrZOQTedwkr1y3LJSgANybJOUjNVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJUGMg0dH5A10GoMzfSmBGPfdksK8e073Pc3dP4EUvg=;
 b=QsYH6Prbvi256lHIs6dLbXmZsMlljWKcj0BPD0mWWBDyhiNHs+6VDjsvGv1kcqtO0v5nBAIB0/fMccjF82YNgQavNLwqkGxAs2RaKqHj3Fz2AtLwi3Xy0hmg8jqqxo/XuCGwqrUHZYvEXD0Hs+c/Ij1yqOdwAThF6KWTGNTUShE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR10MB1525.namprd10.prod.outlook.com
 (2603:10b6:903:27::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Tue, 12 Jul
 2022 09:50:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 09:50:10 +0000
Date:   Tue, 12 Jul 2022 12:50:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, David Howells <dhowells@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: [jlayton:ceph-netfs-llist 1/10] fs/netfs/buffered_flush.c:923
 netfs_require_flush_group() error: uninitialized symbol 'group'.
Message-ID: <202207091447.3Om783sk-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0152.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 854bd46b-8801-4681-5a85-08da63ebe8d6
X-MS-TrafficTypeDiagnostic: CY4PR10MB1525:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jPUPXZxiGPrEZP31hBuvgqs1fi/yx8jW4aQEnZQZt6B1QojOjPD4IdSfK2ZRwb2xOddowRjPWJ510GJ+lzQYZQNvzNHe+1zuZ3NySwPAEAod/96CpE/T+o+lskUvMqI4qQTLClgo86+xNW2663xtaQBPvW2S/FM4gZD1kwMbBlTdYJBerwXuMP42ENyp+G3rorWvf0G4ymuyll9jd/mS6WK0RsB2cr5qz+k0JK1A49xMYVUsJ2ddywBgmYel6BUsDe9TrJvVHKMJb/kCWbxl8nrsR1vg2uheHjgAaSOI2eheIpXoAN/XphIJ13YEHzigrfG2A8AmfYJfwxs+uOhJQO8MuJcGxTVEaum3G6AgAFY0k5dsdWxP9Ge/TkfY/ZVTUKc7C7AbZ/U8wpuBL06rVa0vnb8+cBg5zT40qj7YNbt1HMOtKjEYM4t5ODPTiiyVB3SJSQ3J7RMM3opQax9ZmdfH+YSt9bmverovm/31bIDB2e+b8d6hzWhpEGnPVNv/1tdxFUOHdX5f+YU3BCK7jRdrto05BY34rWqakbIYExmbeDPu/wKuxAvcMyMwJThqK3rBlE3SIu5OgVkSbV+HU3xZQuf83vV2uLiSfj6sNK3SzQQz1pprZy5t9DmEoZoapyfvKNcV5kBl/fJ1GD9xa6VQDHnJIvzSRXjEyTMmDG1dkpQC4Zhb+oc+8HG3mZ/et/KD0IN+2rKDnVrk4WDa3DlFgGC2g8b9toCKzJTWlDfiQNA1PaLfZszd936G1E1zKynGUkQakA2G/stkQp6gdjUaGbU5aEn+k2uOJOsCrJk1v18ieuRYKCX6z//1+Xj2HhfdhigygPElaxJutUujcE93yl9Ls84TR9S8VHjhPRcsQR6A6UvvzPboeeDRi6z3UNP9bqm/eAF79265/b8Ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(39860400002)(346002)(376002)(83380400001)(86362001)(38100700002)(38350700002)(186003)(44832011)(966005)(6916009)(66946007)(6486002)(4326008)(316002)(8676002)(66556008)(36756003)(8936002)(66476007)(26005)(6512007)(52116002)(9686003)(478600001)(6506007)(6666004)(41300700001)(1076003)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uFlldvzD4BOg0B+X/kHBrvIiusgZVXNt5Dv03yvMwahNK+ko1rpC1jrM+ua+?=
 =?us-ascii?Q?lhwEDZVfYnkiEqX3a3MdxqR7KwGQzasJE6UiCdqYCxb77nnhyXbODvz6YVpc?=
 =?us-ascii?Q?C9R4GDObgsqIrNrf1apcUwOLO1OFehgPf1AXiH0lPKi8twBaEIuL7rkGdUu5?=
 =?us-ascii?Q?Jj0YmhMUHiLEUN0HlBv4COy39U1Zcjl61ehcU+nPhWLFckzsAMFz74ORVCD7?=
 =?us-ascii?Q?r6aGNzw9E/uGYeuWw++Z0EpiJYFkETu6YbOQVP43TRxIGJZzuvg/WY9oB+CA?=
 =?us-ascii?Q?ocbxJWtK0lufCMrI9XHjpbSsNlaWyWgVW47g4wLpsg4muKq3EIzPBkPZV3d8?=
 =?us-ascii?Q?H2c9azWt5E6NyBWs66BiREK1WwnTUK1qKS6f+SMEl6AYxlHqASuHRaxIOKOu?=
 =?us-ascii?Q?GBRtyvaZCWYgX8kLsFQ7cn++DEVCxLKt5tsVw6muINQD+gNhKrF+u7327FF4?=
 =?us-ascii?Q?3twlDQeYGPUP2ao4NuDCYZGtIT4Q4OdYZ35O/Da3bR2bwgE75uQTpyuS1627?=
 =?us-ascii?Q?9TwcW0dkUgK17tvjYF/7MTuAHCykDyeb9x98NzNQe5UYc6/FD6dQMoBWLPPV?=
 =?us-ascii?Q?cZTt8ItY0At7omxBYoigwv5HlAVK/w3tg87Z777yKdMH36OHYh14lkp71Q9g?=
 =?us-ascii?Q?yN8BIhCS+03UOdI/SVspeD6fzIOP+HqsQ8TFqm2z2BeNsc3TqzmGRE9K7twU?=
 =?us-ascii?Q?lmrXUVEi34hf5ubKujVGiyNblsXKaLR0SEYMI8RbVnG6c/A6Eg44xxOuCp/b?=
 =?us-ascii?Q?OQZQNhNRN8YYUQJwKCwNbACdr5w5gF70R2pTkeprW7AK5strSei54rYf5Vk2?=
 =?us-ascii?Q?+qADfIaRC8e9Mc898CXtakC72x3K7pl1NpeL+O/1lFmAeiDX8w7veFhOvsuJ?=
 =?us-ascii?Q?u6vysx6IKmXYyCAhAIs9EnlIUzuAn0gLcTm6MRj6i6SE4a0Mf0glLbPJaN50?=
 =?us-ascii?Q?cjFDFBMMXNIUHANQhwfBvn68zvAzkCHbZKcSdspsgzMJiYil25zETto1WOcF?=
 =?us-ascii?Q?1Bw7uwE4aUh/xooCdEZt6vyxoW9FtT3pYdUjXwBS+W0c0q/WdLcGaHLtgZwC?=
 =?us-ascii?Q?pOTiklqlDjdDZO9mgEQcEi+CAeHPFdT8Zakt+oE03QJpDlVIeGQYLzDI5mF4?=
 =?us-ascii?Q?yE1XT4ZhzUErZtvajSvhaHadbZpycgvAingPVuLioallf/H+7UfmS9WubhHT?=
 =?us-ascii?Q?35lcEsHafQ6mOFl9R1N0/Z6B8QWIIvGzlP71PRO+EiDSl1J5k1+191O50Ilx?=
 =?us-ascii?Q?8qnB2COcDS4PFSSsAOGKhwgIXfc0PH5tp/XleEf+w5QqcupSZojgjDwuRIx1?=
 =?us-ascii?Q?61GpuUo12bDPiWGUW9hxi7FKUSNdkYYrqlK8RTD6AbNlrnITAZzLW0VUfgRx?=
 =?us-ascii?Q?JUW+dE9dO8LYbjrju5RMp2UhClPg81GV2bFqNkGRoLlAHbKJMGX+NBvB4rOO?=
 =?us-ascii?Q?EhF9k8K8hxor37xxtbyoMCypHPIe1+SjmuBHJbNkN3g7+0Cz2RI/kCz6zu/Q?=
 =?us-ascii?Q?IQg+7XXn7ux3bUwR9GkXldM1qUFjCTo5fr+JvtMGn7dNyPH3nX+V16kvlpe2?=
 =?us-ascii?Q?7fvL1b+uhMKxpjoNTJQvA1EZYc1RQrMn3j8/xH16s9hi/YKJG1yFC7xxkM6S?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854bd46b-8801-4681-5a85-08da63ebe8d6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 09:50:10.2422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hU2hyw/ui+4Azl1ZnmniPe8rksiyhYsysUJ/mVFTsbpzkoJvouoMmNYzUe6fLO+iP428d3mkx7X6TWhLE+86+3HxtrCrUlL3PTzbBuNyKfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1525
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-12_05:2022-07-08,2022-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207120036
X-Proofpoint-ORIG-GUID: 1z197IJiMNRz77CkgNea0BDiBI357TuV
X-Proofpoint-GUID: 1z197IJiMNRz77CkgNea0BDiBI357TuV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git ceph-netfs-llist
head:   fd428464b2220bd6c59f0a30f9dadb4720b3efb5
commit: 3d4ae7bbf12af2c1ee8f93df5d6ea3556bdfb6ca [1/10] netfs: Add a write context
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220709/202207091447.3Om783sk-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/netfs/buffered_flush.c:923 netfs_require_flush_group() error: uninitialized symbol 'group'.

vim +/group +923 fs/netfs/buffered_flush.c

3d4ae7bbf12af2 David Howells 2022-07-07  911  int netfs_require_flush_group(struct netfs_write_context *write, bool force)
ce4670495468b7 David Howells 2022-02-07  912  {
ce4670495468b7 David Howells 2022-02-07  913  	struct netfs_flush_group *group;
3d4ae7bbf12af2 David Howells 2022-07-07  914  	struct netfs_inode *ctx = write->ctx;
ce4670495468b7 David Howells 2022-02-07  915  
ce4670495468b7 David Howells 2022-02-07  916  	if (list_empty(&ctx->flush_groups) || force) {
ce4670495468b7 David Howells 2022-02-07  917  		kdebug("new flush group");
3d4ae7bbf12af2 David Howells 2022-07-07  918  		group = netfs_new_flush_group(ctx, NULL);
ce4670495468b7 David Howells 2022-02-07  919  		if (!group)
ce4670495468b7 David Howells 2022-02-07  920  			return -ENOMEM;
ce4670495468b7 David Howells 2022-02-07  921  	}

"group" not initialized on else path

3d4ae7bbf12af2 David Howells 2022-07-07  922  
3d4ae7bbf12af2 David Howells 2022-07-07 @923  	write->flush_group = group;
ce4670495468b7 David Howells 2022-02-07  924  	return 0;
ce4670495468b7 David Howells 2022-02-07  925  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

