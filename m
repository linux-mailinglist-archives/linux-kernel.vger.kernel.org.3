Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA5F54B3C7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243764AbiFNOry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243830AbiFNOrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:47:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB3DE08B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:47:33 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EBYZcE014900;
        Tue, 14 Jun 2022 14:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=0JKKDhN7UnnzSLiXqIhfzc1MRJxvXFaG5VvmhzQMm/k=;
 b=LLQjFResPrIXEauCNJHPwoYU4ncfP4rcTkbudcsuyvwmNTVw12n7TVdM92arQilG/ID1
 3hOEgNUz8aiw+GZNrZ2TXf8KWfZfDFLpM2L8jh4T7WZhOvcRY66QWtYRHsXftkufggv9
 MYgjV5iHoBGrf8QfUBB47sQS7APRprMwlGMHS803ag3DqSnt4Mr8Rd5BGIW1V+fSA2a1
 H/R8AOzOv2rNxxOOrWFC4yk3YL2shw3CkYJRe/+QPhDn3gS2zZN2AM/xMWjhb3VaYrDt
 SKodbkMkI8HcZ9diV5lZHUmQMHKa0KGds4QU0RL1gwZ7hae2ehYxbt13zA5qPa0PF7/r Tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmkkte1n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 14:47:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25EEjdhw017029;
        Tue, 14 Jun 2022 14:47:19 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr7my0x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 14:47:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzD3/afnkoaTY6WbGbf5Z+Upt09qb0BWE0D0NGLt+DrnqOw2IPwM9IFvWMOnTRel7rjgzkHduUXy0ir+erRydyAjxGSru+nt8Cs4i0LW87WYB89H9WDj6jdc01lPdUvkyW8B+cBUzm9yEy1IRVa5QWuAyLCD292QvmByLJZglWmqObJeeI3luMJ4jhI1Pe946Qs9ywWS3JujTbw+yfjc0EIy2GB4jpB/djDwNjnHJCNbNXLHtUkJOc1dOMZ03rHLrx0Chv4mEld0dJqtvHdvYYrDp1waSQWF4aaScGozPWI7dtY60B11K9HEbRXUMv4ImxKDqjhDeHdQdLTXCpC5bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JKKDhN7UnnzSLiXqIhfzc1MRJxvXFaG5VvmhzQMm/k=;
 b=nncLbvkBEycov/MJLUt9pNvmzRzp160iiveZzdMKoDr8ASuDXQqvjNWYoeI0iDEyNz9W/efe1i1tIkq4FFa6R2ZbOV8e0gH7vOLNWgO9Q9hNyK8Ww1cplCUolnULKvfjASpMlJ/GjNmgslFTEm1fCHEGwT2NfNDUWHsOxJWxvFTLlQN7lPDdKY5c57fRvXQXZadWHUHDASRRhh8iTYa4j9uG9yaS4kbN7KyKcduULN1pDWrlwDkGLSgTtJFNuByFs2Bdf4DOOBXJ/khWDmLnJAihVtq4IlgiKoFV7jCkcinMUwlENbdeuM7t8Xybl3pZviBky3nDFrvBAsLHxMbRaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JKKDhN7UnnzSLiXqIhfzc1MRJxvXFaG5VvmhzQMm/k=;
 b=hRVgzb6JcwsPe6baGt0YzQThbUXX+62ZgQ4p6iZIesTMvC4ffqsZhJjW/2Yr+yTGOg2+Z0sAil1Fp/itxbspoMx3iRn1kZiHlmXFrHdJ8tIv2RJ6h12lc8Ed0vx581y9GewrK9jfXfFSAeKfA7YP3YkJPyUEjfy82UZYDTz8Nsg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB4366.namprd10.prod.outlook.com
 (2603:10b6:208:1dd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Tue, 14 Jun
 2022 14:47:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 14:47:17 +0000
Date:   Tue, 14 Jun 2022 17:46:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Julien STEPHAN <jstephan@baylibre.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: drivers/gpu/drm/mediatek/mtk_dsi.c:951 mtk_dsi_host_transfer() warn:
 check sign expansion for 'ret'
Message-ID: <202206140910.aE0Vlhfq-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0173.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c323de8a-bde3-4348-f28d-08da4e14c6e0
X-MS-TrafficTypeDiagnostic: MN2PR10MB4366:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB436682DA5FB83E779FB19A2E8EAA9@MN2PR10MB4366.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ITyEuIDLVmEmJfMUwyWHYk5twCko/XigvhwtS7WV+0y9EfYAmzdTO0bk9UQpImvoXhNv719fQxXGs+E+KWZu+rsKuAzE6Km2Y80MhhSPLW/jyCjPVrMvyCYzW7mQs/pwAAhqW8VSC/SU07kUTsjV6VVYQ7HNwVAxOKsQnxs0sz0G4z6R/XPwwQf1bDp4S0xf+N9E74RZxBn0Ci5IrVo6a9YPMvZzHDx2awQjuAY4BU8PzvLaCgVv2Vb8wUND9vNdvzO3y971JNa4iszVIBsybgDiLyXj1hqw8wTvqzvuOtDUu9f9eY0vS6rZ36yboIwES3pi6/i0xXgoSTgGAA2WU1q7O6/b1pogcgpRfUlxpuuBdXTXUAstPUq78bhNH9ggo4bA/Lvv2kxEkHvvBHStO5vw1+n1LPd9VqOsNF1+7AkDRigC+1ANPo2p+WQTXf8rJnxrSs/O6qhsX/Y2Qa+TNzAbBk+3jJJbV8V21FqSxdaQ0jLk0oFIL3e0alT0F8AfQyQSUMY3B6JIPlj2wA1y1n1VEes4cXk7aI1dtjFKf6Su8GDZ60ztIY9rz3/NwiXHSSsNXNJuzrC/mlUGrPUf+ejfuE9fi+yq4W+8UcmgEy9uRp10jTA2pKdYB7dvWPWXw4H0cbjCB4QiyJ6AmB3rKZ9q0ECUx0qi10dKe23LRAcK+CT8KX1PVLtQhHGzJmOg9iuGC9z01lgbhyLlL9U3Nma2O0RsNTcQ6LfWVcMEBG3stQH+QE5/IGgOll1Wto8mi/kmPv/feT/sQUlaoCazjVb0BFCOy4A97vkMGTMMv45F9+c/RdcMZx9T8uLA/GItqvw/dhqhvY667rDXFNx2ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(83380400001)(1076003)(38350700002)(186003)(38100700002)(44832011)(36756003)(2906002)(8676002)(6916009)(5660300002)(66556008)(66476007)(8936002)(66946007)(9686003)(6512007)(4326008)(54906003)(6506007)(26005)(52116002)(6486002)(966005)(6666004)(316002)(86362001)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wEw5o8yyk6bFthd2je0VfIMbTDkLH0BBNAln+KbDdxpws8RgOspSSHNjVwgO?=
 =?us-ascii?Q?ICBWRvKmmECP0T62HrNnIQxLuaA11eAFnkg1SAtN9griQBDbqRZB/hjn04hj?=
 =?us-ascii?Q?KdKEfU0VKEUM3CkAuGpNyTOQ6+AZoGJ/9k7FLC+h1e4mSPvDr80Y9NaCuKRT?=
 =?us-ascii?Q?BRSbbCh2esnQvoyzUQlRe2z/MNOiOscryHZhOW/MmZCCHouYFV9w9qn3KdJK?=
 =?us-ascii?Q?aQIC3LS4NXRZ183rxrFKNBOL+p/ZtADOE3sHUcacC1xs7Z/cXvPPvdP44fL0?=
 =?us-ascii?Q?oOs1IM6AeDL5wQI+mk951Pem37Ky+XZGsf02Zb9rQgTvRAmBdGNkxMW0ylz7?=
 =?us-ascii?Q?yyxUn4lF+tcZmefRFTVKi+4vksATLx+ZPKLkETVwAh9v3kW6+5g39gTvrf30?=
 =?us-ascii?Q?E3CC7x0oyyvoRqPRL2uoOfq2RmSGctYJNA85P5Vwoh5RMbpdnoDO5yN2EGc6?=
 =?us-ascii?Q?cHLiMSaKjAi8p1HpNba0NetxjbjjkkzD2gC8f4jjgag/AVnmMIjhR1aiAHmw?=
 =?us-ascii?Q?rmdCZu0yfZ70h2IvO2/L2X2IuV5H1L5WLU5AGQMEOF6LGG+NEuIEMyfJxIW4?=
 =?us-ascii?Q?kcfDLCsQHq9WApQqeSvGHMkx6DMXpaaobb1+ibLFam9YvZsZaUttchxWfR6a?=
 =?us-ascii?Q?JwD+vMdTkhr2W4N1zJcKRukj09CrLi9k8/B7fev4CDzv6ptZ46D2si2LZWuN?=
 =?us-ascii?Q?mzCjgaVftK6CK5iSK7Z3RgxGE5mgnq1/8lmMvpLniB73svNI6OGkG3ggkh8w?=
 =?us-ascii?Q?z+PfEfoiruIL2Uy1Xx9Gf0M1Y00cGwc2TAQUwi9lyWm8GtUPQqw7rjsPvgHK?=
 =?us-ascii?Q?DbKSD7iagv/b9z1Fi+t45USuvsCOH+6MgV6nO5WRIjE3gfa5z/rfsCffQCqm?=
 =?us-ascii?Q?s0mtQklReBQd2hHhw2ZlO6ZdaQWc7dZvqm+1lIobFDTNDzVqvNbf327+L/Hi?=
 =?us-ascii?Q?Z04JY5Ol2vfadsHdEzmQ6HU7TWv1ZAs2bAQ/RYC2xpO54ZehBtj2bHDU0NLv?=
 =?us-ascii?Q?buvc7l5V0GDhgr5unpIJYxvrMpPZlJXuJmTRjNcDy1ia9epMtnAynt5LzipY?=
 =?us-ascii?Q?ZSRY9h2nSXi3VLZysqsUStyROpu5v2bt0VqyHL3rYGACpoSBgDjNgccm4bR4?=
 =?us-ascii?Q?RqI7tayzYEbA7+98XF/RqVXoRrfC1xBS/Ds4yuoj+ugvw1QaazcktgHL623o?=
 =?us-ascii?Q?0tyF4CjajAPBreLQVRlmcEf+F4XDKLCP12f/XwAAKVJIcWKBmf0DcjjP65QB?=
 =?us-ascii?Q?yq6wtNUFWeM961ttFr5sE4GlhKzrmutwKmsMQkvQaQQ6uKBe+kbi3lQiFPBQ?=
 =?us-ascii?Q?ph+cRbsXjo72I8lpGnUA2PIvDcrQRnVfLluu3Skq2+7hRBphvOwPBOTIJeRc?=
 =?us-ascii?Q?jjOo1Hcr14cBBAJTioTG8wJffDYUcwmYpiWNHcbO4WYphbgdO/m5id49qdIU?=
 =?us-ascii?Q?wxHdYNHpxrsAfnDJnRxqb7XHbLh5Zl51lxwIzW/sbJVuRuE8tFzmoKm1MlS6?=
 =?us-ascii?Q?Ga2+m2gZxsCS3z1ZA+UFNABlR0qP56iChAr6h5AtcetPnFEy95x8wES21NsC?=
 =?us-ascii?Q?dE7exDjuFY6gtotQ4lublyXjZDipjI2KgAguNJRJfWYyzQP5wC4jCGZwYV34?=
 =?us-ascii?Q?pVc8tHH07b2n3r5ulmvjKgml+Excg6Kyq4puUaV8IzT2Uwvh95IzSH+aybZD?=
 =?us-ascii?Q?/Hnkmtbc96rvNRlLkEOk9wkJOuksV/rDVH0wahkFwiZM7wTGyJsqD96AjPLZ?=
 =?us-ascii?Q?kn9zHBzpWqgSVGApjA7zvPf+daBWmPk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c323de8a-bde3-4348-f28d-08da4e14c6e0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 14:47:17.0696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2rCFqwwjH5+r9EuvBvpqLvbScLk5LPbQSxHNxFoYGQsK6hiGXzxE1GF1OPE1ApppF7ytOoEYnjVt81Jtm1TRF8UxujxpXFOSt2xaxcukKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4366
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_05:2022-06-13,2022-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206140058
X-Proofpoint-GUID: AQLV9jy7L8bO7_22Qbq_GRKeLXenLWEz
X-Proofpoint-ORIG-GUID: AQLV9jy7L8bO7_22Qbq_GRKeLXenLWEz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
commit: 81cc7e51c4f1686b71e30046437056ece6b2cb4d drm/mediatek: Allow commands to be sent during video mode
config: arm64-randconfig-m031-20220613 (https://download.01.org/0day-ci/archive/20220614/202206140910.aE0Vlhfq-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/mediatek/mtk_dsi.c:951 mtk_dsi_host_transfer() warn: check sign expansion for 'ret'

vim +/ret +951 drivers/gpu/drm/mediatek/mtk_dsi.c

21898816831fc6 shaoming chen  2017-03-31  886  static ssize_t mtk_dsi_host_transfer(struct mipi_dsi_host *host,
21898816831fc6 shaoming chen  2017-03-31  887  				     const struct mipi_dsi_msg *msg)
21898816831fc6 shaoming chen  2017-03-31  888  {
21898816831fc6 shaoming chen  2017-03-31  889  	struct mtk_dsi *dsi = host_to_dsi(host);
21898816831fc6 shaoming chen  2017-03-31  890  	u32 recv_cnt, i;
                                                ^^^^^^^^^^^^

21898816831fc6 shaoming chen  2017-03-31  891  	u8 read_data[16];
21898816831fc6 shaoming chen  2017-03-31  892  	void *src_addr;
21898816831fc6 shaoming chen  2017-03-31  893  	u8 irq_flag = CMD_DONE_INT_FLAG;
81cc7e51c4f168 Julien STEPHAN 2022-02-14  894  	u32 dsi_mode;
81cc7e51c4f168 Julien STEPHAN 2022-02-14  895  	int ret;
21898816831fc6 shaoming chen  2017-03-31  896  
81cc7e51c4f168 Julien STEPHAN 2022-02-14  897  	dsi_mode = readl(dsi->regs + DSI_MODE_CTRL);
81cc7e51c4f168 Julien STEPHAN 2022-02-14  898  	if (dsi_mode & MODE) {
81cc7e51c4f168 Julien STEPHAN 2022-02-14  899  		mtk_dsi_stop(dsi);
81cc7e51c4f168 Julien STEPHAN 2022-02-14  900  		ret = mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG, 500);
81cc7e51c4f168 Julien STEPHAN 2022-02-14  901  		if (ret)
81cc7e51c4f168 Julien STEPHAN 2022-02-14  902  			goto restore_dsi_mode;
21898816831fc6 shaoming chen  2017-03-31  903  	}
21898816831fc6 shaoming chen  2017-03-31  904  
21898816831fc6 shaoming chen  2017-03-31  905  	if (MTK_DSI_HOST_IS_READ(msg->type))
21898816831fc6 shaoming chen  2017-03-31  906  		irq_flag |= LPRX_RD_RDY_INT_FLAG;
21898816831fc6 shaoming chen  2017-03-31  907  
81cc7e51c4f168 Julien STEPHAN 2022-02-14  908  	ret = mtk_dsi_host_send_cmd(dsi, msg, irq_flag);
81cc7e51c4f168 Julien STEPHAN 2022-02-14  909  	if (ret)
81cc7e51c4f168 Julien STEPHAN 2022-02-14  910  		goto restore_dsi_mode;
21898816831fc6 shaoming chen  2017-03-31  911  
81cc7e51c4f168 Julien STEPHAN 2022-02-14  912  	if (!MTK_DSI_HOST_IS_READ(msg->type)) {
81cc7e51c4f168 Julien STEPHAN 2022-02-14  913  		recv_cnt = 0;
81cc7e51c4f168 Julien STEPHAN 2022-02-14  914  		goto restore_dsi_mode;
81cc7e51c4f168 Julien STEPHAN 2022-02-14  915  	}
21898816831fc6 shaoming chen  2017-03-31  916  
21898816831fc6 shaoming chen  2017-03-31  917  	if (!msg->rx_buf) {
21898816831fc6 shaoming chen  2017-03-31  918  		DRM_ERROR("dsi receive buffer size may be NULL\n");
81cc7e51c4f168 Julien STEPHAN 2022-02-14  919  		ret = -EINVAL;
81cc7e51c4f168 Julien STEPHAN 2022-02-14  920  		goto restore_dsi_mode;
21898816831fc6 shaoming chen  2017-03-31  921  	}
21898816831fc6 shaoming chen  2017-03-31  922  
21898816831fc6 shaoming chen  2017-03-31  923  	for (i = 0; i < 16; i++)
21898816831fc6 shaoming chen  2017-03-31  924  		*(read_data + i) = readb(dsi->regs + DSI_RX_DATA0 + i);
21898816831fc6 shaoming chen  2017-03-31  925  
21898816831fc6 shaoming chen  2017-03-31  926  	recv_cnt = mtk_dsi_recv_cnt(read_data[0], read_data);
21898816831fc6 shaoming chen  2017-03-31  927  
21898816831fc6 shaoming chen  2017-03-31  928  	if (recv_cnt > 2)
21898816831fc6 shaoming chen  2017-03-31  929  		src_addr = &read_data[4];
21898816831fc6 shaoming chen  2017-03-31  930  	else
21898816831fc6 shaoming chen  2017-03-31  931  		src_addr = &read_data[1];
21898816831fc6 shaoming chen  2017-03-31  932  
21898816831fc6 shaoming chen  2017-03-31  933  	if (recv_cnt > 10)
21898816831fc6 shaoming chen  2017-03-31  934  		recv_cnt = 10;
21898816831fc6 shaoming chen  2017-03-31  935  
21898816831fc6 shaoming chen  2017-03-31  936  	if (recv_cnt > msg->rx_len)
21898816831fc6 shaoming chen  2017-03-31  937  		recv_cnt = msg->rx_len;
21898816831fc6 shaoming chen  2017-03-31  938  
21898816831fc6 shaoming chen  2017-03-31  939  	if (recv_cnt)
21898816831fc6 shaoming chen  2017-03-31  940  		memcpy(msg->rx_buf, src_addr, recv_cnt);
21898816831fc6 shaoming chen  2017-03-31  941  
21898816831fc6 shaoming chen  2017-03-31  942  	DRM_INFO("dsi get %d byte data from the panel address(0x%x)\n",
21898816831fc6 shaoming chen  2017-03-31  943  		 recv_cnt, *((u8 *)(msg->tx_buf)));
21898816831fc6 shaoming chen  2017-03-31  944  
81cc7e51c4f168 Julien STEPHAN 2022-02-14  945  restore_dsi_mode:
81cc7e51c4f168 Julien STEPHAN 2022-02-14  946  	if (dsi_mode & MODE) {
81cc7e51c4f168 Julien STEPHAN 2022-02-14  947  		mtk_dsi_set_mode(dsi);
81cc7e51c4f168 Julien STEPHAN 2022-02-14  948  		mtk_dsi_start(dsi);
81cc7e51c4f168 Julien STEPHAN 2022-02-14  949  	}
81cc7e51c4f168 Julien STEPHAN 2022-02-14  950  
81cc7e51c4f168 Julien STEPHAN 2022-02-14 @951  	return ret < 0 ? ret : recv_cnt;

This is buggy.  ret is int and recv_cnt is u32.  So negative values
for int will be type promoted to -22U, or whatever, which is a high
positive value in the U32 range.  So it's still a high positive value
when casted to ssize_t/long and not a negative value as expected.

The way to write this is:

	if (ret < 0)
		return ret;

	return recv_cnt;

21898816831fc6 shaoming chen  2017-03-31  952  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

