Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEB649344A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 06:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349034AbiASFWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 00:22:39 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8560 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231512AbiASFWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 00:22:37 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20INxYl0012923;
        Wed, 19 Jan 2022 05:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=lKYAt/g11mhqehVVlNAzCJu+jUd01da8N96xx4y7tK0=;
 b=EAJiqvtODFRfkOHeh0UbwUeyyt0MSidgEHSkklK5Z2jazo1FlQCoZSJi5BlFqtuAiwtz
 zLhkiRSLcCx//SsVTtUd6P1W3DMM9J0l70ZXsS1m2sT+b3iLb2WDKGibGtfbOu6TuTM6
 6tNXx6IUpeErSZoi584UENY0TjNnQ6R4KvKlJo0JK9P1NbjHafVMk6FGyuiGpdj7re+m
 Ypl9TMFOS0gRmEI094K0ySqkRo8bro5tt9eZihWFl3I3qXA4YC7/a+lsEWTu31hiS33Z
 wAcexC1aov3Jji5hoYBnAVKRPW3ztfQ+sfgIYG/au3gOZBwmJalldEOL0Z04swtlTXPm bg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4q41rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 05:22:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20J5A4u5097261;
        Wed, 19 Jan 2022 05:22:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3020.oracle.com with ESMTP id 3dkqqprdkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 05:22:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLdsEiG9ds4gpwz/ylCcrNMZNbtVCzgLmsRA6vIi4QiKen1LtBq83MdPUr2XRyvntQQhp/9S8v34JmH3kdZrjFRl3mo68D/2BXaEPDjq8li0kYAatUhd1DDZpvK8ETSLKAvrygZjBpGalBa1sTJmsraXcAUESODS9oFb4/vo7hYhkvyF84eaj1CCBODgR/g9eF43rqCMKiE2mBGZfpfQzI6hjV6ebj8TIhQPKYR+rM01Gz+ipZvaukCuXaBKgDkBl8b5rwy13bCt02AsOKvnJfTAq/z4LYel1dqzSRtVYU7/cDFr31F/Nr+oeqwr6lZA86n4Ge7Mp2KeuXOTvsqK/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKYAt/g11mhqehVVlNAzCJu+jUd01da8N96xx4y7tK0=;
 b=QC2nyKKjGzRvgUErUKybDxI05TMI5pGyIjNviJlPijpJjkvRL7dt6H9+PJnkVk1y0ppdrb/NDRWkW0zFdhDizJf9YaI0v9+N4aQwMrdM5f4p2aJuMR30bUCBsH6ncSbszZaIuWOWw1iL00IuHYoUs3X8GtMMEmSHnKh+2pGDUbbLLlhSOAerXuiYdXZc4uPNt59N/To1+C8DgtOfqpd8hH9lBl2nzJZHgm/EIG9xGf+kkhoeZsL/WV9EyKdKOkAhksG8gMHt/T432IoLRpsGYW8qPLm+zHUIt0p1b1QiKY5Cup3OQBkGY8lYOOPdnMtsktNRFU1BhNgxmEqa9DzqmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKYAt/g11mhqehVVlNAzCJu+jUd01da8N96xx4y7tK0=;
 b=uKD0OdsW7eW1uvKSJnQfRA5fiyVsgR8DyyiWE8+Na+cEtzNpYnNMo/iD6rGbGThdN7oTpoulmEy8neFzbbh3NzQ048gbcRtafTs9vvH1Sby0db/IrqikdBtB+kp+CRkvStxBvlaSOMtBcGpnlShsN4LEmyc2XsCyHulChmPhM/s=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB4290.namprd10.prod.outlook.com
 (2603:10b6:a03:203::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 05:22:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%5]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 05:22:03 +0000
Date:   Wed, 19 Jan 2022 08:21:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Lukas Czerner <lczerner@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: fs/ext4/super.c:5656 ext4_fill_super() error: we previously assumed
 'sbi' could be null (see line 5648)
Message-ID: <202201182249.eXYOFfs9-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0048.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::36)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6643dc1-cd9f-4c36-718e-08d9db0ba005
X-MS-TrafficTypeDiagnostic: BY5PR10MB4290:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB429025736E9EC979986029A48E599@BY5PR10MB4290.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kwsmfkrKqEHLaGlrFscuf7fCmAqHGBnBXToJrIJdTt6iRNPAPaJRu3mfPfH0aDPtlaoS4O7qbB5HQZ6LSlPZKot3cPisAXTRi0rw45tN6u7L26KMUmiLsAc0v1GkCsw8PhXh6hQxp2GqGeUtJ71uo9Bhcg1KezZNo9ihyOZwQjIsK8a+azsXbWGh56Tg/K5VNJB1M5uLYp4BJVaVBc1savZzfd2gySJ26l0NBsRxeCZgJJ3hfh+6Tg5hsytkVLU2cGe40MhFNYWZPMfyOZrKM5dtA5j2/Roi8fj8/ly8F0cn4mYRuKrYtrXwodpKvqtRhgzDrLm4jBtaZk/o6J47y1DYrTfRfUBbfyulqm3SE+PR5fVySlosPyyXMk7fTU4Ozpyny6NnVWZCH3AEBW6HckUtuslw3hbTULEYc8F0wRdwfL1Zn5zaqRAwOZVjD1556TAuTGc/ANtlXXqCbNLD9BeLdnOAbB9kCb32tGSA6ACCTc9KOxZopuxsNo3RqbaSSwCbQR+y7BLsvIR3JIYK/RUlcJ27E8PZtxOiZkLYpYU+uhzJ6nVIy8YpLfU8OxoONgmPfuqt8CA1lJzNzKMjrRRSJlRpf7gUWBp7gnpROXVHJumBQ4nGg2Icsz/iDCucNXBMuHR3+ektG4k/alfR3lesds0QtTBaIygrs2ESfP4LtUsvBbI/zqxQ3DY/MRJlUaB2qqLRdjoWw+Z5P/QUdweaoiro/EJmz7Mr62KJXNK+E3i1czk14ZQ8Bhm72U7AfeEwHyzc76Mkm3CZz8xSvDQiBzMMXHNv8je/XyqUTVpA/rSQU4yNB69yM2vu1YNKHHlSmVOyVIItjgsp985rwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(4001150100001)(83380400001)(6486002)(38350700002)(38100700002)(36756003)(2906002)(508600001)(66946007)(966005)(8676002)(6916009)(6666004)(66476007)(8936002)(66556008)(186003)(4326008)(26005)(52116002)(1076003)(6506007)(86362001)(44832011)(6512007)(316002)(9686003)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2eukLzgMDj4vS8RukDaSNJZMOwESQ5SY56D/AiIHkGK1qZ6OO8lONpJlEgq9?=
 =?us-ascii?Q?IQ9NqL7uxZMD16CRDSU8f9QuVaweMVcelcma9mfaHySWb15scrJzmsgPnjJm?=
 =?us-ascii?Q?CBhquZXT1b0R8SLv0LIT5WDiVYG3xV+SuvWN0yxZVAbscZK289Z2sFmZdrdY?=
 =?us-ascii?Q?l66DxBTMJY6NbtD3HClJKl/Yu/3DufBPlb0/935iTYKTqkPJ0MaZG9mBBg4w?=
 =?us-ascii?Q?hyYSJsGz2KH1P1jzjNh4HlxJbnsIUMlT+/0XsI3j4x1Ob5v1lY658cemlEv3?=
 =?us-ascii?Q?Ps8nFo9ppuPBP0CDzF85EOm+JSIssfWcaWkFbzg507hvf4GZPd9DLEPWKDm2?=
 =?us-ascii?Q?FWsEmJLLJlQdfdmYQ7A0WmvzFNz+cv+w+J7EBCloEB6AEoazcYR/OknwXclm?=
 =?us-ascii?Q?8uqyDNRgULyeHPqDsC9WVWYGktfVvu6x9WaordypHoJ2bG6yGmwcOhGpMotU?=
 =?us-ascii?Q?khc116A9ljKjxHyBwBdBwMNX8r32cJ9SVDZLyJIXEq+5XbO/8T2HxhA1FVhl?=
 =?us-ascii?Q?p1lFjrETSVuB416dEBlTYIjW1wYW67jj6Fwh7LAL6iNYGb/UeEvO/kXXo8ua?=
 =?us-ascii?Q?U5GmtgJkm5I08d8Sh40+7TSg0GpZ3dO7pLrqUVjCDx7+n9/SzB4Cbx9OcYrU?=
 =?us-ascii?Q?3NSe6ifP2mLHhk/2WV35nzic3WyiyhWlQyiH3E6rhlZJZlmYe033blZK9lt+?=
 =?us-ascii?Q?mW8Tzwx0NmwajYJw2YqFrPVS5OY6a7QeuZ+g8f9nhL57rUMG0/w2RodezHdY?=
 =?us-ascii?Q?Tds6xSPQx7g7uToEfz9vlLp3LUE00pbmQYiftWdQa3vn169YvS3ADl1uDh8o?=
 =?us-ascii?Q?/en29oQCyqWZCt2OsABJ0kxkRmywOjIqhOoFVOKF/R/xCLPa7Pw9o0jMwhRJ?=
 =?us-ascii?Q?SepDMCHTyAZZQJulqDNY5U49fLdAjimdKdFT5sk7AwDKPImDH+ZPNz5iWvq5?=
 =?us-ascii?Q?eFkcjUFai3ck9oDM9MKHC01nJTXVjBI+CalS/mqasTmZPes6kVL3FhAah9Km?=
 =?us-ascii?Q?HXEEoBLAeNGPYGAGFR7UHCALQTtVjdIrK2kKZ+eVI9+OJGOujkXAhMA6psTi?=
 =?us-ascii?Q?FMsDEuQrHXK0dQbW/97WFgY/oCY154imvwAMUjIHkumhcNbBdcWyS6+KMO+T?=
 =?us-ascii?Q?HcScubKr14LJOwLBlmd2HfBi74MBCiG2RKgne9e5+vBUl7kCrT5auOTWvn9l?=
 =?us-ascii?Q?+vMyDblMsqVMWSZI6wpBItfG9aN7MDrUxFhGDq24rf4OJPfAHiKmfFeWxyd2?=
 =?us-ascii?Q?65QVXwREPg1z0capDjAVGyL9ERxmza1KYwfUTDkkz6F947fCvzhxvT37/g/J?=
 =?us-ascii?Q?evXL+WTCIsnfb0c7Bqa7uvX4mtDb3eziIJd6S6iJCAAjE54pZITyrFHz7qHO?=
 =?us-ascii?Q?bvN5XbP1EYY4IMDEnydaUNyorilqZBWKPkAAd7UnmVya887rNF3qiF5JG6IW?=
 =?us-ascii?Q?anLD3YvJTlhbGct/48yfpa4O4zp0PJAz8NzqeuyWZnk3B25jH2gfZ9j3/8zD?=
 =?us-ascii?Q?cibwTtp3C0CItSiUb5iP2opdTHMpTs7lM8BwzaCXFTc7E5fs7bsiWWxwOBMY?=
 =?us-ascii?Q?0YEMThwmwPh+QTQfNtu904vIiGyjXkuNEiOvHmFqq6lqeB7Gc8f7lTLijfM2?=
 =?us-ascii?Q?+EwaZ1IXxM5J6OBqFkvraSpAbeshf7SeFucIAEq1gsOY5o0JdVvYlH3JTnW5?=
 =?us-ascii?Q?H2ZHlLtU1QmGbpuceyVRFXCwyPc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6643dc1-cd9f-4c36-718e-08d9db0ba005
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 05:22:02.9845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8I8ymbb9VDROnpDsDksqAgFU+360P2cClhycduvAtbFwWZx/nBjVJNyuFylcKVZ4J9gP0HOUN6bPFKu+cOAlFst61ijtvMQ4fsMiSGfGZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4290
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190027
X-Proofpoint-GUID: 7vmRMChnA98OLQoBJanewopN592TT_ew
X-Proofpoint-ORIG-GUID: 7vmRMChnA98OLQoBJanewopN592TT_ew
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fe81ba137ebcc7f236780996a0b375732c07e85c
commit: cebe85d570cf84804e848332d6721bc9e5300e07 ext4: switch to the new mount api
config: s390-randconfig-m031-20220117 (https://download.01.org/0day-ci/archive/20220118/202201182249.eXYOFfs9-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/ext4/super.c:5656 ext4_fill_super() error: we previously assumed 'sbi' could be null (see line 5648)

Old smatch warnings:
fs/ext4/super.c:4165 ext4_register_li_request() error: we previously assumed 'ext4_li_info' could be null (see line 4147)

vim +/sbi +5656 fs/ext4/super.c

cebe85d570cf84 Lukas Czerner 2021-10-27  5640  static int ext4_fill_super(struct super_block *sb, struct fs_context *fc)
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5641  {
cebe85d570cf84 Lukas Czerner 2021-10-27  5642  	struct ext4_fs_context *ctx = fc->fs_private;
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5643  	struct ext4_sb_info *sbi;
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5644  	const char *descr;
cebe85d570cf84 Lukas Czerner 2021-10-27  5645  	int ret;
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5646  
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5647  	sbi = ext4_alloc_sbi(sb);
cebe85d570cf84 Lukas Czerner 2021-10-27 @5648  	if (!sbi)
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5649  		ret = -ENOMEM;

Presumably this should be "return -ENOMEM;"

7edfd85b1ffd36 Lukas Czerner 2021-10-27  5650  
cebe85d570cf84 Lukas Czerner 2021-10-27  5651  	fc->s_fs_info = sbi;
cebe85d570cf84 Lukas Czerner 2021-10-27  5652  
cebe85d570cf84 Lukas Czerner 2021-10-27  5653  	/* Cleanup superblock name */
cebe85d570cf84 Lukas Czerner 2021-10-27  5654  	strreplace(sb->s_id, '/', '!');
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5655  
7edfd85b1ffd36 Lukas Czerner 2021-10-27 @5656  	sbi->s_sb_block = 1;	/* Default super block location */
                                                ^^^^^

cebe85d570cf84 Lukas Czerner 2021-10-27  5657  	if (ctx->spec & EXT4_SPEC_s_sb_block)
cebe85d570cf84 Lukas Czerner 2021-10-27  5658  		sbi->s_sb_block = ctx->s_sb_block;
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5659  
cebe85d570cf84 Lukas Czerner 2021-10-27  5660  	ret = __ext4_fill_super(fc, sb, fc->sb_flags & SB_SILENT);
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5661  	if (ret < 0)
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5662  		goto free_sbi;
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5663  
cebe85d570cf84 Lukas Czerner 2021-10-27  5664  	if (sbi->s_journal) {
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5665  		if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5666  			descr = " journalled data mode";
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5667  		else if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA)
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5668  			descr = " ordered data mode";
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5669  		else
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5670  			descr = " writeback data mode";
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5671  	} else
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5672  		descr = "out journal";
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5673  
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5674  	if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs mount"))
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5675  		ext4_msg(sb, KERN_INFO, "mounted filesystem with%s. "
cebe85d570cf84 Lukas Czerner 2021-10-27  5676  			 "Quota mode: %s.", descr, ext4_quota_mode(sb));
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5677  
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5678  	return 0;
cebe85d570cf84 Lukas Czerner 2021-10-27  5679  
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5680  free_sbi:
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5681  	ext4_free_sbi(sbi);
cebe85d570cf84 Lukas Czerner 2021-10-27  5682  	fc->s_fs_info = NULL;
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5683  	return ret;
7edfd85b1ffd36 Lukas Czerner 2021-10-27  5684  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

