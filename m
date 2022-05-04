Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786C451999E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239255AbiEDIYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiEDIYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:24:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B98C20F6A
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:20:39 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24489DtC013665;
        Wed, 4 May 2022 08:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=aGaAsXMh4xMGXkq6h932lHu9RhOkkAoQfCiMAKJPfAs=;
 b=zEseRr6wcvBy7PJARZVjOeYL0qBwNkYzPXf0qKjjQsUIeKyowtS7gnmf5vfpWqs+zZJs
 iNp3obhM+gXZGQr1xYpf9EqOUtmInmL2pMxSb1h4U9lFZyXcrpl0xdpcP0GN2II5QSpo
 3G4DN2F+l2dghFKUQDhLiGFBv+1HPVY0qsLSzX0WrKpWIyIzUXnI+p7hhrQHz4+QhXJC
 CLjaMEndNKaJ5kCWD4JqmXUXOx2oKcBl4tK/V4aCTaHnZ5pzagOyJUyixp4ymX+A19t3
 4Tl1e+zkOdcCr7v6vIcjx3KAKIo0RjCuUMpw2N6raBQ+IWnaOEOud4kKY5hvc4TkvxXa NQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsfrqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 08:20:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2448ASmc010464;
        Wed, 4 May 2022 08:20:34 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2174.outbound.protection.outlook.com [104.47.73.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj35hk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 08:20:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y37IVo1vAX/8K2D+NEcC8e3UCFgBHhOrNRE/2Mc2clev/sr+fhQ3ESrJ1c/XLTOZpfgfyIjmDAPBR3y/VDpVVesdeZMH0iVQJ40b81EYvdjdqExRIPMu9yiHyW/6V3wjmePjWOlgisB0OSJ9h5W1IhI+kbGcKxZS1NjmiIIisREIorA0XkzvV96mVUN9vBRp3SPBB5StBo8RWWcqSNLc/4aOtwoqOAz8+0lz6pD9j6tTOb8Z445AMyEM+cDxI7vwHQyNy/rgDp3Etu9X0YNMmsPqMGkqdWGkaHWxg0TFwWU9ITwJpTv1jOkKiUhLjAYy8rUfZ4y/y6fLCRXMCFudVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGaAsXMh4xMGXkq6h932lHu9RhOkkAoQfCiMAKJPfAs=;
 b=c7B7XE9GXg9uvjMU5gUvkOoa70ASZ4OQcXCIDmyPqRifqnVSFkZbuWFdQHaDfBKZpedoMoCJpkziEL2rTcqYa+JBobU86a5QbY83/6TwRNJvXIxp1fQQ2Tze3Meuf1uTwV32DnKwJDJY+0HxJrKc+9eZAuOadAHzHDsFg5z4LX6k/YxHTm2zHY3F21eU86o0vJn2YSmJarVbzx1hQutITv/9GX0BhWBOX/S9m9HD+yaSfFT99DOcHHfSItgPvI2q/iMa4D9KPjfqlxIuG8OkKhmK8eHjpNi31wOBa6C64IpNmtWkzSjB4JYWGBiAhteeyjO6kGdcZ8d11VLE5SjbxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGaAsXMh4xMGXkq6h932lHu9RhOkkAoQfCiMAKJPfAs=;
 b=EoDEAzBX0sik2885QqNnW2Gy4gMjydTDg4Jb1k3mKphSWEd443jZgWkbG5WjzS7BP2e7lCjjQm4H+wQAmISU6InLGoepfKTIluhybE12RHynluK0I4If/TxdRl8QqP2NCCZSCxUk5kBGJW+r4glDRJ6xe+F8bTtI8Rtk5tv48Wg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3507.namprd10.prod.outlook.com
 (2603:10b6:408:b1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Wed, 4 May
 2022 08:20:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 4 May 2022
 08:20:31 +0000
Date:   Wed, 4 May 2022 11:20:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Thierry Reding <treding@nvidia.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/tegra/gem.c:153 tegra_bo_pin() error: 'map->sgt'
 dereferencing possible ERR_PTR()
Message-ID: <202205031734.WXoZd12a-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0068.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cc28ab9-3b00-4659-cef6-08da2da6f43d
X-MS-TrafficTypeDiagnostic: BN8PR10MB3507:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB35074DF8BA488C012503C45F8EC39@BN8PR10MB3507.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lweA+kwPllokCdWzQE8C4NSi/cbDfU6NUXJmwSgFcyxKZUVHW+IYE2sQANT1GKB0siAdqik1aCsQCrCqE3p1aj/iegESgojWa2OP1kE4We+q2/40DR27pN9+kDzYe+I9bFscdF3TDCbBCH2uDy2D3IRL4rkZ4qAbK8PrvjwvZ3TgzQuA9DOzb5LBb+XSNr1JNqtNK/kJhtAwRyvK/sXwEwjHq9PfNvohbPZHV4tRJUnnct6Y1Dax8atb30ws8ORmQCSMtqgA58jAgs4n5ZOvcBX+Ajqex+YCaKGe2IGHDDAF65NO6D/wKHADD2oWwxP8yIECqjZ4PuilD/pxVI7/GLGUnbfjH9XlHd7NOnu1rvOjKYxarmIm6k7xIcIdAKQmR7FUupwswpLKjcr6pFCYvXUQpahUNCfzIljiqpYlnna1V3WqhX6QvqtfaCyhEZKqSwSz19vDvC0gD3YqEFuXYohsm1jnybBnjglCyRVDCz5L3Jbe99cF2EZyAdrmJnYKMDHPuKApiXbqOTsJiBFoE8LhrbkcK+H0LTfdGjHwj0h5tgi7dnRxALH/62iEJDrhvL4LFs9y79ZjyboddnVc6S0dXSafhICgHjbA2k0jKQuyqGYzVEXCHX3vYxCeEBXx/X5Y5IAMl7LGhBMp9i1JOn4jeudQCrG5L5N5KNcDJEfxMjMAaXQJKVnzF2O3KvyMwIny+8sktARZbojJzi6qWub9jinVXeOkLa0CBlABoGvFnPRQGZmQ2LlpluVutEXtSJsI9JBEm5oTuNVHqysRCgQC5cfQsFoQGgPOQkolpUhvSb7MKn4lQFxMtuSHVFeeIsZFjPIau6sn/OMXlw6E/qn15V89+KnUqjS5yegUDTg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66476007)(5660300002)(8676002)(2906002)(4326008)(66946007)(36756003)(38350700002)(186003)(6486002)(1076003)(38100700002)(508600001)(26005)(6916009)(4001150100001)(6666004)(9686003)(6512007)(316002)(52116002)(6506007)(966005)(8936002)(83380400001)(30864003)(44832011)(86362001)(357404004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TElOxbudDC1kT/B2+IKSAbRSV3IzfCcpnvk0UjoTxGdAvN9a+pqGYLpfh04k?=
 =?us-ascii?Q?mxBi3wDHAiT+IQwazu8IOvL8ehVFCLu2m7y8if4mTa6ex2DAVjS+95NssgRz?=
 =?us-ascii?Q?OxR2oK5T5W0n+oZJ1yIageDR9jIXzHjA/Ee3GF6EC+AMf6HNZAjgyqq1JfNS?=
 =?us-ascii?Q?Y83uWV8bX2QeTfsY/8O2QrUFAvQ4VfT/TmRQgoT27ztBAWF2PE4YCus1gfq5?=
 =?us-ascii?Q?qj1V3kGWqAWi0wokCzOICTqP0RYFuSN0QlxQxzMXg2+QvFtvRaWGepAdgpt3?=
 =?us-ascii?Q?HryG/lt87JoCd6mK2gXtelRboAHjNvLd5GNAOq4fwnwpeLc+UCYVfOEGJUe5?=
 =?us-ascii?Q?5pO7sMMNAGXdwavu1+MmV0uylcZhoWW9eUNwG4qnEo2yUPvf5ZoXK/9v7W3y?=
 =?us-ascii?Q?vUbKODPZL7022T2UEuRCIgFylQZXmntyLqwrYv3+WuqVCtv44421azdkvpyS?=
 =?us-ascii?Q?9HDe1XOTAJbq/+q1Amk6T9utJo5iuhG++KiHyldhfOQigO+5udvcrX9Aiodv?=
 =?us-ascii?Q?9vsHHOyDeQlNtWj2Bbo4G4CWYMrJLREzODJaFo0UqGa4fvT2SShV1pB0gDxf?=
 =?us-ascii?Q?fxENmRX1tcIaJtp9RQYyj7DAgGfyx4Kx2Nehwv4yl8sb2WLu2T67VgnR9bQB?=
 =?us-ascii?Q?nUZaEY2CHNQvL8PYr+3mUqC/KhXl47zq13e4HWUwHaGrJP0VR20sTBCoONPM?=
 =?us-ascii?Q?T3b7JRB2fBKdaPmXg7bvPrM9GwROG1PHHyTZO4B/8iA11ATME8bnqDQDvgDn?=
 =?us-ascii?Q?W8pERXiVITQxXllWmuAo4yuxrCjCTYlt2XozxYpYokzSzVnE4TlXvs8aP19H?=
 =?us-ascii?Q?wuEyF/CelbncvhPiOD/VQqbmu5j9wlXt/vAa1ED5CVVijLVIEPp4jDtggPTh?=
 =?us-ascii?Q?+nNPO1US2DMOBjy5+uoPuJWMsMYsKwkgfp6boBX2Nlv1PQaYaGxOdV8buiHy?=
 =?us-ascii?Q?skPT5wveTStwh40DlNY58VtbLYLJEshJxCvakfPW2kagwjdnztO8OrL78cmD?=
 =?us-ascii?Q?54OnCeJhdjwOP/QwkNKaPGIWJ+ReMhrdHPjgxmtJv8fR+cZGpaYIJ81Z1ngU?=
 =?us-ascii?Q?eO/sBS8qUCe2O5aEdV3CYqS9HgAcDEvACOLeuhjT1ob2F9lP3juh2NCrc3HU?=
 =?us-ascii?Q?L2J+UoBF+aINI+XsLXBEqRHXXz0+/Ipyg8+oa5QMZZBp2mKSmTstd03LQPpg?=
 =?us-ascii?Q?Yuw9nzsFNvpnjJHZzDBZYJ4acD/aTjeZsuiFnz5+bmiLhzfb1zJ41YTHlnRd?=
 =?us-ascii?Q?KcF8lHaxPET0gXAo+q4rMNOCBNxLnaS0bnz+gnc/P2m2C1UeGsKBEH+O7wb4?=
 =?us-ascii?Q?7oBwqAajD/PCoeVfU0kXENHnneBb8wfaj+JB7X8DRvcL9VxaKHAcIAyD8cxX?=
 =?us-ascii?Q?a8J80jTb0GjhxZRaoSM0ToatrCAR2OISm4v6Io0eX36x+66IQpK5NpeYNtcX?=
 =?us-ascii?Q?AzoQuURVInA1G1sSIrRcDbO7W6PZ5RRPMpp7OS1qqvEm4ZE3chJYhVLWTcTB?=
 =?us-ascii?Q?nNVNNv2zpX9UFUX1cpzkd6vIUpLVL9bfLzzZisd1YL5kd76Bcxf/mSqlvXGU?=
 =?us-ascii?Q?tnXn9kibq2/C2rwYoncbQxzhL0ucg4HkE2583Zu+aAgyVPDGsOJ5NqIs22M8?=
 =?us-ascii?Q?7ll0DbwebzFQ9i61u2S81papRK3VEefE/smE4qni2zrEixPR5e6ynWySGSEk?=
 =?us-ascii?Q?iCm9Lss9ZRhP7U5tgI93nqpzj92Prm+GVAJklZND842u5omcLA/WD5d1HUc0?=
 =?us-ascii?Q?2ExdPt6M9g/Zq5hiZzZL6zrShK2gak4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc28ab9-3b00-4659-cef6-08da2da6f43d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 08:20:31.3421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAPLngmlpkkXvzK+7U5YsN8nm1Ks3luja+3Yo7N87evAX9B+DJnRlNuEvNOuE/RgITS2D1NXUrZtM6jxNEH/tK9bcRB6irliqFmKkf5uZa4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3507
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-04_02:2022-05-02,2022-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040055
X-Proofpoint-GUID: 5USXKz9GlXW9xkIxOSLNn7cb3SXJgLOL
X-Proofpoint-ORIG-GUID: 5USXKz9GlXW9xkIxOSLNn7cb3SXJgLOL
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9050ba3a61a4b5bd84c2cde092a100404f814f31
commit: c6aeaf56f468a565f6d2f27325fc07d35cdcd3cb drm/tegra: Implement correct DMA-BUF semantics
config: arm-randconfig-m031-20220427 (https://download.01.org/0day-ci/archive/20220503/202205031734.WXoZd12a-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/tegra/gem.c:153 tegra_bo_pin() error: 'map->sgt' dereferencing possible ERR_PTR()

vim +153 drivers/gpu/drm/tegra/gem.c

c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   58  static struct host1x_bo_mapping *tegra_bo_pin(struct device *dev, struct host1x_bo *bo,
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   59  					      enum dma_data_direction direction)
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03   60  {
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   61  	struct tegra_bo *obj = host1x_to_tegra_bo(bo);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   62  	struct drm_gem_object *gem = &obj->gem;
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   63  	struct host1x_bo_mapping *map;
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03   64  	int err;
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03   65  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   66  	map = kzalloc(sizeof(*map), GFP_KERNEL);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   67  	if (!map)
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   68  		return ERR_PTR(-ENOMEM);
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03   69  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   70  	map->bo = host1x_bo_get(bo);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   71  	map->direction = direction;
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   72  	map->dev = dev;
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03   73  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   74  	/*
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   75  	 * Imported buffers need special treatment to satisfy the semantics of DMA-BUF.
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   76  	 */
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   77  	if (gem->import_attach) {
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   78  		struct dma_buf *buf = gem->import_attach->dmabuf;
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   79  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   80  		map->attach = dma_buf_attach(buf, dev);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   81  		if (IS_ERR(map->attach)) {
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   82  			err = PTR_ERR(map->attach);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   83  			goto free;
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03   84  		}
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03   85  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   86  		map->sgt = dma_buf_map_attachment(map->attach, direction);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   87  		if (IS_ERR(map->sgt)) {
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   88  			dma_buf_detach(buf, map->attach);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   89  			err = PTR_ERR(map->sgt);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   90  			goto free;
                                                                                                ^^^^^^^^^^

1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03   91  		}
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03   92  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   93  		err = sgt_dma_count_chunks(map->sgt);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   94  		map->size = gem->size;
de2ba664c30fcdb drivers/gpu/host1x/drm/gem.c Arto Merilainen 2013-03-22   95  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09   96  		goto out;
af1cbfb9bf0fe07 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28   97  	}
585ee0f27ef7b8d drivers/gpu/drm/tegra/gem.c  Mikko Perttunen 2016-11-08   98  
af1cbfb9bf0fe07 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28   99  	/*
af1cbfb9bf0fe07 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  100  	 * If we don't have a mapping for this buffer yet, return an SG table
af1cbfb9bf0fe07 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  101  	 * so that host1x can do the mapping for us via the DMA API.
af1cbfb9bf0fe07 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  102  	 */
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  103  	map->sgt = kzalloc(sizeof(*map->sgt), GFP_KERNEL);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  104  	if (!map->sgt) {
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  105  		err = -ENOMEM;
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  106  		goto free;
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  107  	}
80327ce3d4edaa9 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  108  
80327ce3d4edaa9 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  109  	if (obj->pages) {
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03  110  		/*
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03  111  		 * If the buffer object was allocated from the explicit IOMMU
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03  112  		 * API code paths, construct an SG table from the pages.
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03  113  		 */
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  114  		err = sg_alloc_table_from_pages(map->sgt, obj->pages, obj->num_pages, 0, gem->size,
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  115  						GFP_KERNEL);
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03  116  		if (err < 0)
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03  117  			goto free;
80327ce3d4edaa9 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  118  	} else {
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03  119  		/*
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03  120  		 * If the buffer object had no pages allocated and if it was
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03  121  		 * not imported, it had to be allocated with the DMA API, so
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03  122  		 * the DMA API helper can be used.
1f16deac766926f drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-12-03  123  		 */
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  124  		err = dma_get_sgtable(dev, map->sgt, obj->vaddr, obj->iova, gem->size);
80327ce3d4edaa9 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  125  		if (err < 0)
80327ce3d4edaa9 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  126  			goto free;
80327ce3d4edaa9 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  127  	}
80327ce3d4edaa9 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  128  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  129  	err = dma_map_sgtable(dev, map->sgt, direction, 0);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  130  	if (err)
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  131  		goto free_sgt;
80327ce3d4edaa9 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  132  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  133  out:
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  134  	/*
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  135  	 * If we've manually mapped the buffer object through the IOMMU, make sure to return the
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  136  	 * existing IOVA address of our mapping.
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  137  	 */
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  138  	if (!obj->mm) {
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  139  		map->phys = sg_dma_address(map->sgt->sgl);
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  140  		map->chunks = err;
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  141  	} else {
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  142  		map->phys = obj->iova;
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  143  		map->chunks = 1;
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  144  	}
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  145  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  146  	map->size = gem->size;
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  147  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  148  	return map;
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  149  
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  150  free_sgt:
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  151  	sg_free_table(map->sgt);
80327ce3d4edaa9 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  152  free:
c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09 @153  	kfree(map->sgt);
                                                                                      ^^^^^^^^
This is an error pointer so it will crash.

c6aeaf56f468a56 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2021-09-09  154  	kfree(map);
80327ce3d4edaa9 drivers/gpu/drm/tegra/gem.c  Thierry Reding  2019-10-28  155  	return ERR_PTR(err);
de2ba664c30fcdb drivers/gpu/host1x/drm/gem.c Arto Merilainen 2013-03-22  156  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

