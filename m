Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C6B5310DC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbiEWLJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbiEWLJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:09:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B930E3F88B;
        Mon, 23 May 2022 04:09:15 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NA0WYg010026;
        Mon, 23 May 2022 11:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=P0kgMrixaZFMjj/LxxuR4IWxecXWKH9yfhxicxylTj8=;
 b=nufinJU4XqX4RnNsVtUpfs8Nr8rRAxX6h49EYH8dnyz1wYbKDd4LxozC0+EAxQS/f9ee
 0MHTq8+Kj5wIoPrDCoddvDGgdNVkUNQFsX1saGj1jcMej/BqLhNy1cdU3TxpmRtuot9d
 JOaKSYyTjoy5Yf5TLZmjXZrqmx2Okq9kCd+Vq0+Nu35iNl7EhcgMUwNV4TupXMA50V47
 AP4KbJeD/qhpahOdlO7oEDocRP2qQa5lShTFISMFvNOBXgl/qcwYPTAK3tadin5HCm6V
 GhaNlZrSZyDWc/cwrzOZQ2W6AUBnQtlmylrQB/TZhtR01STFujcaLrNO4qckc1YmwIjg iw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6pp031eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 11:08:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24NB1HBO013426;
        Mon, 23 May 2022 11:08:41 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph1ftdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 11:08:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abSAA4i1VPSpjjAb8zXy8MbdrWK8gbf9gDZPfMxErmobhlEkYNU82KjukZ2x8H5tUs8+XIjD5h6AowJ4W0PPFDvJpf4hswF/cNyuAjug574vwoKPJTTR/YYjGqlmN1koGHgrDrX9PV93JGozY7IscJa5Bdwrrq3IJ7D6NByGbWSQ0fYpT77ZYLElwPLeiCOP0rE2NnXeRkkoVd9qrinl0g4G0WxOjHRwmGMuKPmROlyYrT3KD3haStloVAVWGs4ABNcD8AeLj9xF9C3NGffbFYAVZm0W6GiGTwpJnwBeEiB8gyIj4pezeAuHxdIDmJ0xDp0AkwYJ2G5TS7HIRu85Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0kgMrixaZFMjj/LxxuR4IWxecXWKH9yfhxicxylTj8=;
 b=aLmi8BM3HWhHfUAQgOOq+/Chq1FD9VzHg+KpdPtZQYOGeEoWAaj1Ce0LyhjRAhjS82JdbPvEsez9zKQn4OTCeAcriBf8nq7U1YhIXeqLNFWQ2EAOGHK9D+NzFByc4IHMBfzU51eF0YFmxeIuOy5spojAKqAqokn0SUc4vJbSKLX+g7Q0qnsBfVleSUQDrqIZBKJbXnamn2fF3gHwIPdgEYHks1JntYsC3wXIYq1RgLft+11H9GpDsyaEc7B4tvhLXvSf7GKCIu8SJT36/3aYQWPjtBXce+NZj/EIXgHDRPRcgcPTbIoBLPiuQjTx37+Str7tdbsbQDZ2T958NKU3nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0kgMrixaZFMjj/LxxuR4IWxecXWKH9yfhxicxylTj8=;
 b=ykjVnWJrzlUHyjd/LUkEGYgWYygFMShr78qde0HlDhV+EeBiRG6ejUNZiQY2F1ydwF+OGoCKG1Pr5P0LsOWBIc0tq7wd9x71XYhxS38xXpYstNy733aGF7FKJnpInZ3RIFS1IT3K0P2tpqhh64ZABnHZ1BOX/IvT6PYayp9XTTY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5649.namprd10.prod.outlook.com
 (2603:10b6:303:14c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 11:08:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 11:08:40 +0000
Date:   Mon, 23 May 2022 14:08:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, John Garry <john.garry@huawei.com>,
        damien.lemoal@opensource.wdc.com, joro@8bytes.org, will@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
Cc:     lkp@intel.com, kbuild-all@lists.01.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-scsi@vger.kernel.org,
        liyihang6@hisilicon.com, chenxiang66@hisilicon.com,
        thunder.leizhen@huawei.com, John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 3/4] scsi: core: Cap shost max_sectors according to DMA
 optimum mapping limits
Message-ID: <202205210545.gkS834ds-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653035003-70312-4-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0003.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a92b4be8-7f0a-48ce-ab02-08da3cac9703
X-MS-TrafficTypeDiagnostic: CO6PR10MB5649:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB564937E05203B252FE3B429A8ED49@CO6PR10MB5649.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C6Yo5gT8vVnE7/nxBuflzJs5UjxXjNv9Na4A+ojwlXd4YtAXNnUfO4VmmLU8oAhC3OyfCs13DNCFpZpYxgOVPeVg9bbtUxbEAGQutOj050+7vrMRXg29rSJ3Fi70ncylpeM7CDsl2PdFmr5ImNjsRTPCLVUZlUmHpbHLmFVW1KE2XUDJew0hbdnpxkc+VuEgjyk6OdM3NasOTGLGDGYjZtUDThp7zpg5ztYnXA+0QfNLyMwtFe9BMPVKkm2B5/G3KCT5p9qx3Fh1UnRn1NKtbSZ7y/fpSwwhWhaFnE4XQOEKf+CY6KmJKSr6k9yX5VDH9datABwJQc5h8uXoiigj8D+RZNUon4QfOO52NMK+siXFIQg/kYqu26EwF7lxQI29SQr5Fcv5bc38rz/0fFDf6GJzThBFEE/rlylJP/hXjWcmAMMURiKuL+9QWHg4EszRaIo9PH6PN1gc8/1+Jt+D22oDV2MUqXjB0M8lg+YfKTIuZIVXwOctimydk/1kBXaJq8BQUOoX1/3/grsRNAnvPnxti/F5DxxC0RyeGKgVfXlUQ/ObuQzHt+ajcnXFiNRdSF0v8RrfGr8Y/jN23lQdxBOaS9+lsW3UGa46j7bjVd1JRwmlwm9AhadOUdU6NwsmUOaorXw2rzvFHG5mhHdZ313vKsZhMwzz1AWuT+g4QxhwekN6WVronZM5swXd6x/H8TYIB5f/wPAB8X3D4/suIXUbTLYJ4uX0bbA/sJwDmrzNawrDxuMj39TNLTe9N6w//uC47vNR0Yey4S0ZvCpJrdolhoXUXqxF9GdYkCNPzLGhml4CEGouz8NHMW6+7TqL/b1jeSKxEsVKn9WtXMUGvSJbNgHJ63+J4pxnSAyPQ/I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(38350700002)(86362001)(921005)(2906002)(966005)(6486002)(316002)(6512007)(52116002)(9686003)(44832011)(7416002)(8936002)(5660300002)(8676002)(4326008)(1076003)(83380400001)(186003)(6506007)(26005)(6666004)(508600001)(66556008)(66476007)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dPUz4lWMX5eT70VRdStycrxIr6KZ/Mg2RIL+SNt+OGJGPhSA38MMtmNbT5oT?=
 =?us-ascii?Q?CUxnQauCeGCi/pGUlx2HpYfzR+IHRBnTgUUC7/iAQuJ4NsF/Q2L41jQQXaoU?=
 =?us-ascii?Q?oa3OOxe/krEGmjvxTR9D/jKlMc+Kp+KW2PHJniym7/Z41z1qWJADQtex4PVz?=
 =?us-ascii?Q?j1G8P6wLQLI3Ijr/2vAttarDDdZq9rMGcv1zyld8V3ezkWGMVuC4OZ/57FpF?=
 =?us-ascii?Q?SQXYT5y2mrZVFf30gzGaMYgiDNc2HafTCWCDhb2s1Abo2ck6qhIihILD7xmH?=
 =?us-ascii?Q?3aq9Ak0aI1DusCvHZX7giJokcfQLfIdL/t6Tp49dISr9RBR64sOTAd14jzZK?=
 =?us-ascii?Q?Xv7FtJLa7eNjYGNeBNaNSUjvqynt9UxXFJmcVrLS053Hlsvf7lhrT33emGJ8?=
 =?us-ascii?Q?YCycgHkWEHjTSNaz/+jjYuxrUc0Xk+Zfayr6fkbvWOUBLA1Wcx5j8vCluxKZ?=
 =?us-ascii?Q?ljaAsfA79Q+K36KFmddG1CqrakAuuRM5hpfVQkzMmIuKK9bBtbufd8I0Q+Er?=
 =?us-ascii?Q?syEM48s46pu3vXEdqTeqATpa6RczaIzrqiH2BvqfGhyXapLDC+YoQElQ+Qrw?=
 =?us-ascii?Q?RcQ5F/0nrFv5FfwzkPI610xU8QMp0hly4UvNiNVWnafVS+MMqbffFhhpknvq?=
 =?us-ascii?Q?/P/ABmk41MX5JksAKIZh7JQtaOTUNCSE32dc4xnjMNj0c5bdLqwe2RMmXruo?=
 =?us-ascii?Q?TK1wgLVYCpAfpNlMDAaTJeG9lzy+WhmzHLhP+i7CjO+hPYJuBkUmwvqxwJ3P?=
 =?us-ascii?Q?e4AA2Zz4OtQVzve6MOcEFlRHLfe7OMDxdYdCrERO1H/bMII69Z/F5DyZ7gKi?=
 =?us-ascii?Q?JpOGITen6XEjbwOSiUOhf1WXmo1zYRUFyvbCOlC9NNRhMBzTwKUpSfimP9j8?=
 =?us-ascii?Q?LzgVWDsopY0HAAoql/UbPNeqAMjWhnIjdlXWogUBtXqM1nwzpZjWoPaqR/aL?=
 =?us-ascii?Q?csR4mhzTh31jUigyC4h4LLl+D6hKo1JPRV5ktA3Ez5z3Wx6XqA9U8wQfq4M3?=
 =?us-ascii?Q?qhl83Kk0WE3u/WOgdBZm8NQUP7vn2Nyuc2ROH9hk7xEPDzOJW3AzGo6V2CUi?=
 =?us-ascii?Q?WQDcGgfsUpgCMKOnxSzEsbKq2zaIHTcndVY+/+AojIBwcw+vWDA+zyW4PQjc?=
 =?us-ascii?Q?xRAKMatIh9nOlCx8YGXRIF7u0MlzoXnCKicrl3B1pY/AAcxH/5xP3mK4Fup/?=
 =?us-ascii?Q?stlOuMGtUiR+0Rk4Rr3O35bXu9LxfEj7iVFhB10x7XLGzWIVxwd1QkrE08ax?=
 =?us-ascii?Q?gY0eTqFKBSrxdVzyg7PmYIf3yZJiePoXXopEEcIwLE+JdOwqRrO+p4+RgzQ2?=
 =?us-ascii?Q?/hGAwHG3cEzR9FzBmw4ymjh4T/HMw/SIhcbGgp8S0LDWIARcfU8Lz9DhmrxU?=
 =?us-ascii?Q?4GL59a42veJUjk3XVUZwaCpYVW7I5ULTuQVC4p+5/rIabZ4dnx2j6OaPyr87?=
 =?us-ascii?Q?BTMc6QdD8JBUZ9GcU7jJFPnkNGvqpbVGC3aNGYd9tGy27FTh6SZ3MT1R9NEo?=
 =?us-ascii?Q?Z9Sb/8c/CAf45+pYj27P2ZUS6ALnPXKnwRM7YjlYXVLViTSp6HyflVAlQ4q5?=
 =?us-ascii?Q?QHkz5C0Iikw/NsYVkrsCixln4VR3FPqZEEKK1Uh3X7CbjuFHVcHhPEcjWm36?=
 =?us-ascii?Q?7ckZX0uv5qfQQHk9LonUbmmumkP10F7lKTmMrrW5zEaigd3FKGkTYvzSzQda?=
 =?us-ascii?Q?M5CvvUiNMwmghvL1m4kOXOE90B/K+fE+nKJsOzm4bCdvUHglI2M47ic3xeSp?=
 =?us-ascii?Q?wrSsBM06VZSnVKL7zgVA4knEshAOzoo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a92b4be8-7f0a-48ce-ab02-08da3cac9703
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 11:08:39.8549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7krEQbSRCu5rMX/cxRHot2cHd0dJ26zPj6KhGxiYYjTNoQk3v6fU03tSX+yP0WuDgqKZM2pN91cM3WNUBtQUaIL2EAJm2SvOMmujvOtStA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5649
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_04:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205230061
X-Proofpoint-ORIG-GUID: -AmVAojPos4YiEr7NnOjABv_8nVXOhgM
X-Proofpoint-GUID: -AmVAojPos4YiEr7NnOjABv_8nVXOhgM
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

url:    https://github.com/intel-lab-lkp/linux/commits/John-Garry/DMA-mapping-changes-for-SCSI-core/20220520-163049
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: s390-randconfig-m031-20220519 (https://download.01.org/0day-ci/archive/20220521/202205210545.gkS834ds-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/scsi/hosts.c:243 scsi_add_host_with_dma() warn: variable dereferenced before check 'dma_dev' (see line 228)

vim +/dma_dev +243 drivers/scsi/hosts.c

d139b9bd0e52dd James Bottomley   2009-11-05  209  int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
d139b9bd0e52dd James Bottomley   2009-11-05  210  			   struct device *dma_dev)
^1da177e4c3f41 Linus Torvalds    2005-04-16  211  {
^1da177e4c3f41 Linus Torvalds    2005-04-16  212  	struct scsi_host_template *sht = shost->hostt;
^1da177e4c3f41 Linus Torvalds    2005-04-16  213  	int error = -EINVAL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  214  
91921e016a2199 Hannes Reinecke   2014-06-25  215  	shost_printk(KERN_INFO, shost, "%s\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  216  			sht->info ? sht->info(shost) : sht->name);
^1da177e4c3f41 Linus Torvalds    2005-04-16  217  
^1da177e4c3f41 Linus Torvalds    2005-04-16  218  	if (!shost->can_queue) {
91921e016a2199 Hannes Reinecke   2014-06-25  219  		shost_printk(KERN_ERR, shost,
91921e016a2199 Hannes Reinecke   2014-06-25  220  			     "can_queue = 0 no longer supported\n");
542bd1377a9630 James Bottomley   2008-04-21  221  		goto fail;
^1da177e4c3f41 Linus Torvalds    2005-04-16  222  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  223  
50b6cb3516365c Dexuan Cui        2021-10-07  224  	/* Use min_t(int, ...) in case shost->can_queue exceeds SHRT_MAX */
50b6cb3516365c Dexuan Cui        2021-10-07  225  	shost->cmd_per_lun = min_t(int, shost->cmd_per_lun,
ea2f0f77538c50 John Garry        2021-05-19  226  				   shost->can_queue);
ea2f0f77538c50 John Garry        2021-05-19  227  
2ad7ba6ca08593 John Garry        2022-05-20 @228  	if (dma_dev->dma_mask) {
                                                            ^^^^^^^^^^^^^^^^^
The patch adds a new unchecked dereference

2ad7ba6ca08593 John Garry        2022-05-20  229  		shost->max_sectors = min_t(unsigned int, shost->max_sectors,
2ad7ba6ca08593 John Garry        2022-05-20  230  				dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
2ad7ba6ca08593 John Garry        2022-05-20  231  	}
2ad7ba6ca08593 John Garry        2022-05-20  232  
0a6ac4ee7c2109 Christoph Hellwig 2017-01-03  233  	error = scsi_init_sense_cache(shost);
0a6ac4ee7c2109 Christoph Hellwig 2017-01-03  234  	if (error)
0a6ac4ee7c2109 Christoph Hellwig 2017-01-03  235  		goto fail;
0a6ac4ee7c2109 Christoph Hellwig 2017-01-03  236  
d285203cf647d7 Christoph Hellwig 2014-01-17  237  	error = scsi_mq_setup_tags(shost);
542bd1377a9630 James Bottomley   2008-04-21  238  	if (error)
542bd1377a9630 James Bottomley   2008-04-21  239  		goto fail;
d285203cf647d7 Christoph Hellwig 2014-01-17  240  
^1da177e4c3f41 Linus Torvalds    2005-04-16  241  	if (!shost->shost_gendev.parent)
^1da177e4c3f41 Linus Torvalds    2005-04-16  242  		shost->shost_gendev.parent = dev ? dev : &platform_bus;
3c8d9a957d0ae6 James Bottomley   2012-05-04 @243  	if (!dma_dev)
                                                            ^^^^^^^^
The old code checked for NULL

3c8d9a957d0ae6 James Bottomley   2012-05-04  244  		dma_dev = shost->shost_gendev.parent;
3c8d9a957d0ae6 James Bottomley   2012-05-04  245  
d139b9bd0e52dd James Bottomley   2009-11-05  246  	shost->dma_dev = dma_dev;
^1da177e4c3f41 Linus Torvalds    2005-04-16  247  
5c6fab9d558470 Mika Westerberg   2016-02-18  248  	/*
5c6fab9d558470 Mika Westerberg   2016-02-18  249  	 * Increase usage count temporarily here so that calling
5c6fab9d558470 Mika Westerberg   2016-02-18  250  	 * scsi_autopm_put_host() will trigger runtime idle if there is
5c6fab9d558470 Mika Westerberg   2016-02-18  251  	 * nothing else preventing suspending the device.
5c6fab9d558470 Mika Westerberg   2016-02-18  252  	 */
5c6fab9d558470 Mika Westerberg   2016-02-18  253  	pm_runtime_get_noresume(&shost->shost_gendev);
bc4f24014de58f Alan Stern        2010-06-17  254  	pm_runtime_set_active(&shost->shost_gendev);
bc4f24014de58f Alan Stern        2010-06-17  255  	pm_runtime_enable(&shost->shost_gendev);
bc4f24014de58f Alan Stern        2010-06-17  256  	device_enable_async_suspend(&shost->shost_gendev);
bc4f24014de58f Alan Stern        2010-06-17  257  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

