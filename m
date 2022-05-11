Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B61D523090
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiEKKSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiEKKSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:18:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D12E26AD3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:18:13 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B8ovvi003183;
        Wed, 11 May 2022 10:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=phL6nBEsM26PAnolFtMCilckhd/ab/avxAVOPvIFugY=;
 b=T2k/nGhFsrzXlfODlWriCcsDcgwaqP0UfMM75KGpv9+Zngj5hX0vTS20OdwHZbrD+BrD
 xjgoLeWFL3B4SKx+xjf/B72xcPudlbvgYNmtLIXz0zVotcBPotBXC2qE7IOZGdSVuFPy
 ia22B9/PYlFfUZdwPp7t5rhm+K4jUE8WgcNwE46mn1BReANgU8mN44o4N/yOe647lP7Y
 U22YhsevGdC3gQ79XE/2lsOgCXXjZoteyl/jXEOGa+SPoAKpjeJfS92SXntGp2HpJy9R
 m4JslIo3hi3FPsWjdC10UkeLI25VAHee9OwR7IwpVKodCjjHPZRgzDKDAJ/gDMY0IGVA 4Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g0a04g71p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 10:18:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24BAFS3C029901;
        Wed, 11 May 2022 10:18:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf73ejtx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 10:18:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQYq+Bh+UiAUplUu97pCZKRSNqLW5BiArL6ytNaiTM+XUGRCt37Ix53rGJqkppsvFPJv8QQQdHcuoUElPQMAovKtlcqPn32lcBx+MR70SOeyX0NOt9fyDupefpi8jeruSxeNcMALVi5eTqU4DwXnMwC2AuiwVCBB0TbVnKIPMd9ffdhcTYLn8AryHJcVhlXDUBwVg0e+8saG8rzgPxUixO1+Vq3zy4bTRBBgOGQGmjcnLcI2hNAm7NuDA4vB6rXSfXA6qP/SSKVUmikgsKE5zkAqb2d/9dAkjeyO9ex6NtnoN4/kudll9Byor+8R1dORQtipCYGV/nXv7MhoyZXl6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phL6nBEsM26PAnolFtMCilckhd/ab/avxAVOPvIFugY=;
 b=BJ1M/yyxBayy1eLArvw3cO/qOcA5xWB6Kc9WNhDfJpkKpablwv9iPXqTYUr1MOYgDx4aZogKRI2A5mAnqgpY8bF3rfyC5FVY/ZZ7c0XR4LiZz6KhFfgYcVt0/NyQlSYkDvZ7xIQ5cbNTOadmsoZbIid3RIPfGD4qA9BAiWJOIa7c3cUGpsRwAg0kPTANG3DvRyQD/EbKS5/rXJLG3cn1r/R9PNl7YxHE4zNvjfrlEeu8LJ2gVFKKCWCEPqzkNYC3xLd0pEFSl1SOPLlvDHFrI/d5xq5p0nxwjNbJB0vgbrLAl2YaU+HrKkZ+OBg+f8WEYbvj/cvjWwbNQ4GlS+lHgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phL6nBEsM26PAnolFtMCilckhd/ab/avxAVOPvIFugY=;
 b=cwKRvknVp12cDH8GETPdqSHT6oBMf4XbSaMZAwTEG+RuCPRRtDhdBqrsOnvaQv8X9Jwz+gUuF7o7/R7i4V+DQlxNAa8pyFs1zNSwisHDv4pdfSVb4w5GDWfIpbBtWP0EYbTXNGXCYsJT2hP9ES8SabL0/OcqiZaS92wCYguAj7Q=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1293.namprd10.prod.outlook.com
 (2603:10b6:300:21::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 10:18:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 10:18:02 +0000
Date:   Wed, 11 May 2022 13:17:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Michael Walle <michael@walle.cc>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Pratyush Yadav <p.yadav@ti.com>
Subject: [mtd:spi-nor/next 16/18] drivers/mtd/spi-nor/debugfs.c:84
 spi_nor_params_show() warn: '%ph' cannot be followed by 'n'
Message-ID: <202205110320.WNi7ZQaB-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0009.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d104801c-10fc-4eea-cefd-08da333787e1
X-MS-TrafficTypeDiagnostic: MWHPR10MB1293:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1293DE21AC8B00A54E308D1C8EC89@MWHPR10MB1293.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d8FszbvE4fv9mV9Q6VrhRL1o938dbpkOFVQVQrn3yT6k1KtTyiA0j6IkGDuWtqFHWM/tE82TfKDo36uSu+qMSO5+klUEuFojlt+nmXiGB8c4tmS2vobUvyH0gc73Ftel9vjDsW3wOK4rNLtZRvm4avUyq0lzZ6h71qThfRgDUXb+u/RYgYFU48pNGEqDqjODjSm1mPOODhyHe4pBWRJINWuXmnovjeOHTxpPdBAg/03rsVFGsNCZt0enW+xlvkxv5bSeEcaQP+aqN7o2jHrp//u3bHWQVpISzldvdMlJqkS1jagpZxiv9R4T4oX8ZL9DR6Lvj8F4iorgcQMrEaQOFcSLXaAns6ow20yAvd5uZ6V0G5Vol3A6VuBL+P2cMVVto/4ylUVylQM/D+oinLZLUJli9NYNrZMyc+Zj+cZooJN519U3jY8UGMyxvBzo66oyS4U+3F11LGnOAKd9/tKwwk/VGyvp38YAUTakiED1Cq9uKMbJubFkOc/EHaMEj+kcWdGW+FbKcIHt7v3ROExvLjf09YII8MQJKXJAFUkuN19TuYTxtAjaYtGWQGCjWmQK9q18/CnAGVWM42oheBRQZ4gV3cF7EZJOALkTleFZNvQjXJvCeyHl2lIW9FedfvLE1IqByhSAPKyUgxeI/SXHdqdPvOCwaRDgAkgVKTZcX3uYYyaxQGBC10I5ATb8ry+09YmRuFK7WGgN0+NariJvRE3XJB2/WnJ2YMTvxAWCYFok4/cUvIpjgj/I4IxvGdd3hqU5qMYrDJwrq/M/oDtkam63TzzOWyseCwU3WrOt+fEkhXGgDafkmp0aF792vZlKzumO7VEf02gLsnzk+3/6ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(66476007)(66556008)(316002)(6916009)(4326008)(8936002)(83380400001)(6486002)(36756003)(2906002)(5660300002)(44832011)(966005)(66946007)(186003)(6512007)(26005)(9686003)(1076003)(6666004)(508600001)(6506007)(86362001)(38100700002)(38350700002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IFBTWZQBRriPp2wTFuesx87UgeVqBOWFylPgxpPA+fBsJ+LY9l5s3g6vaha3?=
 =?us-ascii?Q?An1LDkFtbGhs87s17BfHEx+aN4ch7/LNop2xYcdxSVEf8ZfaEuJUuOX+sqSC?=
 =?us-ascii?Q?QUI+poAKX5MGSIFu4rsyYfXARSnWI3/+gdsos3rXyOqBgVq0e1Mg3IDFhM/B?=
 =?us-ascii?Q?UA1u8OZZoJMfXVKSnLgWZuxzymwBpTvXWUJrIZLBJxVJb01sA+DulAtuvSLs?=
 =?us-ascii?Q?DsoMdO4sAXRwq7zdmSs70Op9pk6QN+BpqNmFDoEznEtK7pkbjmw8othYHvCw?=
 =?us-ascii?Q?f1KI8+qtPCxsnY7OEZw6PnSeRn2IP5zZ4IsBYWwkQ+aYBBkdgxaaC3/xfOdB?=
 =?us-ascii?Q?Fh+qzIeQ4xa0Rcdv1YDv/xHLJrw1cDVexW5DbGAQN0pMgLof1dlyHwDYZYjv?=
 =?us-ascii?Q?PtJ0hruY7cgEAbi16szvDAPbIryWMD4vrM5oS3CqY5Y136lKDNXex+u36m2F?=
 =?us-ascii?Q?DQaA+RyNC9nzrtjOeobabGIRZ+flHHR/bwDgow+tNuHjlCmyFdRrhDLGYmuX?=
 =?us-ascii?Q?XPb6nv4VlnT1mQJsqpMnW8ki073q2P742UbDcJqiPmK06sjyKUc2sqiv4cY1?=
 =?us-ascii?Q?WRVvPR1GkzTyT2U2xpi1dzfx2n6uVfKjiC6OEZv6p7Fu2mRb/w9Tp/1c4PmJ?=
 =?us-ascii?Q?GhNMB0YkWzMdyqPV2K/6+5tKBD2ZwNQmnWLKuATESJDYTo7BiqtPK+qmlKmd?=
 =?us-ascii?Q?8HjPfu8AnUMexIqO6aovApTEnYWTB/UjrfJpHf2WFvbh9ZwtWgZjFooTg/w9?=
 =?us-ascii?Q?BNRG2MKcLjBdyjVHv1mDVqXKO+2Dv84naO1SL1gu+W7HxqKm4oe6daZLKA6k?=
 =?us-ascii?Q?zmOEo0H0D9dFNqGPIe2k/cGKrsePuSkrkwQBQg8JBQq7NdHjIaTHBY/FU3L9?=
 =?us-ascii?Q?Bo4uCbDPwzeNLfdydlWvF+o1NIX5c2ZnB49jc1wWRGKnwEz0/Xlx1ERDCmlM?=
 =?us-ascii?Q?8dqzkpvbbJLL1xWvBMC5QyIijBPFoLlz7r2zcPF3oGFgu0K/p5pttxgqVZHb?=
 =?us-ascii?Q?gvzWKotgertvNTgw3dFKiLR/w8kE85OpDVsVVd5q/BcGwKqtMHDNx0nj3oGH?=
 =?us-ascii?Q?09WmJoyy6+Nen+K3Cj7uvVE9L+1phBZrJ1J+xPNzV6/MRA5dOGyuZi78XprP?=
 =?us-ascii?Q?HZRO/HSk2bKVLo7zbwxf9hCRPwtP+9KTx4FRyUntWUm2dUi9cYLGl8egb/za?=
 =?us-ascii?Q?Fndlmi0WwwBIl8BHejbwod6yFHDS5s8SlYQLQdlUBJP3OhIDyM5eVYdPg+PD?=
 =?us-ascii?Q?hYhceuGsIN991gYEa9UIwN+uab++7e+WRV4UwkA2Dvv0MWIoMZAZZIoihXj6?=
 =?us-ascii?Q?vjAow8Pt2bTV35P75V4SAYIg3XYgAqOp1RqcdxewG+eQymfu1Fk0e9PZwzFt?=
 =?us-ascii?Q?fe+teRLjcAAugjnNms6K5SZIkCgljLsWNkJXmw/CrJL2wwPE2gwPGVCN2/N9?=
 =?us-ascii?Q?635UB5DPO/yjJezYC4qcUFg8gQsuiexkTAjYehuDYD0q6Udoa2VCV0I1x92s?=
 =?us-ascii?Q?S1ya3ZGl0fh2RBIk1/Pi9Ty+bxI8Ci2aD5V2nBvD9fwWIPjUClQt0evNquLh?=
 =?us-ascii?Q?2r9+VYLNoZw3SHbQfP3hUAX8cO4J9KG3dq9UvsP+Ga9j8niiNd7kRpSrIntv?=
 =?us-ascii?Q?MSqOpA4L2gvr9nOUmsJjIAXogcIAnVT2SyBxLE4U4JjlyRj007v+pjLMQj7q?=
 =?us-ascii?Q?fXxEBuiJIPmPo510K9PLu6HnX/7YudodRz39fFi403N3CIS/mopzHHht8uwe?=
 =?us-ascii?Q?wGvhf6B816alkS9qrgjqFYRb7kE6J/E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d104801c-10fc-4eea-cefd-08da333787e1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 10:18:02.5724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xeXR9H4yMZiboVr08d8k+E9GCS2j0+rtLut/Yr1VGh/3IRuOEpIL1v+mIHn89ko1KMxg7xEEK8R4VUcjgwWEgPqT25ZJ2Y+zUjoIpB3q3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1293
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-11_03:2022-05-11,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110047
X-Proofpoint-GUID: FadCfQ2bqCIFrw9qtQQ-JzVL4IM-v-iE
X-Proofpoint-ORIG-GUID: FadCfQ2bqCIFrw9qtQQ-JzVL4IM-v-iE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next
head:   cdbc44dbb2c73d8bafa1a8ae0d780608be5dbd40
commit: 0257be79fc4a16a3252ce80aa13b3640f728c425 [16/18] mtd: spi-nor: expose internal parameters via debugfs
config: x86_64-randconfig-m001-20220509 (https://download.01.org/0day-ci/archive/20220511/202205110320.WNi7ZQaB-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/mtd/spi-nor/debugfs.c:84 spi_nor_params_show() warn: '%ph' cannot be followed by 'n'

vim +84 drivers/mtd/spi-nor/debugfs.c

0257be79fc4a16 Michael Walle 2022-04-29   73  static int spi_nor_params_show(struct seq_file *s, void *data)
0257be79fc4a16 Michael Walle 2022-04-29   74  {
0257be79fc4a16 Michael Walle 2022-04-29   75  	struct spi_nor *nor = s->private;
0257be79fc4a16 Michael Walle 2022-04-29   76  	struct spi_nor_flash_parameter *params = nor->params;
0257be79fc4a16 Michael Walle 2022-04-29   77  	struct spi_nor_erase_map *erase_map = &params->erase_map;
0257be79fc4a16 Michael Walle 2022-04-29   78  	struct spi_nor_erase_region *region;
0257be79fc4a16 Michael Walle 2022-04-29   79  	const struct flash_info *info = nor->info;
0257be79fc4a16 Michael Walle 2022-04-29   80  	char buf[16], *str;
0257be79fc4a16 Michael Walle 2022-04-29   81  	int i;
0257be79fc4a16 Michael Walle 2022-04-29   82  
0257be79fc4a16 Michael Walle 2022-04-29   83  	seq_printf(s, "name\t\t%s\n", info->name);
0257be79fc4a16 Michael Walle 2022-04-29  @84  	seq_printf(s, "id\t\t%*phn\n", info->id_len, info->id);

Maybe N was intended instead of n?  (I have no idea).

0257be79fc4a16 Michael Walle 2022-04-29   85  	string_get_size(params->size, 1, STRING_UNITS_2, buf, sizeof(buf));
0257be79fc4a16 Michael Walle 2022-04-29   86  	seq_printf(s, "size\t\t%s\n", buf);
0257be79fc4a16 Michael Walle 2022-04-29   87  	seq_printf(s, "write size\t%u\n", params->writesize);
0257be79fc4a16 Michael Walle 2022-04-29   88  	seq_printf(s, "page size\t%u\n", params->page_size);
0257be79fc4a16 Michael Walle 2022-04-29   89  	seq_printf(s, "address width\t%u\n", nor->addr_width);
0257be79fc4a16 Michael Walle 2022-04-29   90  
0257be79fc4a16 Michael Walle 2022-04-29   91  	seq_puts(s, "flags\t\t");

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

