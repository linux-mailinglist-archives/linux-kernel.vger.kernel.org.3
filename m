Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C13F565696
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbiGDNJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbiGDNJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:09:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EA02AF6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:09:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 264D1u1q008060;
        Mon, 4 Jul 2022 13:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=rSZEHx+xmmX0HMApg7mBOtUwx3LvRmE691q4dx2x2Fs=;
 b=TlUo1oyaKIk/I5PQmdbWc8TCo1ardBmf/kKOR5CZuFsOOGsDxMe685nNKMB79Oh8FiUz
 oyTF9f+QJ9/1ksonGkWYLot/UNQSNdyj9VtFU9eBU/FqQy33EVdKfLRRaE7xI4eV53K8
 nR6sqb+k/tlE28cs+GNgCEkuedEYa/IbzsiSrXDTQwre8aISS0zSrOJgAOd8V148VOh5
 pzcMgseSQRk8Z+Frj9jD/w8EdbfmtyW0SZxn9MKUJ1pMlT9n3VodGay7HEQpqoy8wOeJ
 VYRacEijA1BLp2QAUrDbUKMD9BYDvYshwoe5yFbjxfmory5/sUoQkaMEmMSbw5JQw46x 1A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h2dwakduk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jul 2022 13:09:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 264D7OSB033982;
        Mon, 4 Jul 2022 13:09:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h2cf7r5ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jul 2022 13:09:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBK4MiMehK1xicFo2pew+jSmylbBN/38C3224iccxGYeyt9cihjhlu4HCXFSDS+r5rgLhXRq8qstoE2g6PA5StEjBdv/A/fGrS1KLF8eRQXvGql0pthjmoT03qec/ca3qpIwfAwIdJgBY4H3/rL6oJWYRy2XpVqERNEAAzYO+qDFW3ANHsSwKmARHTNA2GM7iMOQD6WtVt8ST66LARLuN8syViensxA9gZNxfGClZxEjYAw2flHHU+Uic4jR5nBtjePJASdNFw/RWdfkyGp2IRtsg09SFZtM8FxwjtEvAWQXP4dZaFe8lqyffvkj/4ZoDYL3YOlI1dsxVIxEDd8GOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSZEHx+xmmX0HMApg7mBOtUwx3LvRmE691q4dx2x2Fs=;
 b=a7TKfEsgU2HK8I8eE4NAqeDxyuOAzkWKyKav86dk4rG7FsURHS1744jyXa1I0cYwF+3I+OHuK9DpKG+NZg2ze/DP0cLE+lEWe9SHw0L81mOGWBJS9NiTcD6w69KbuYmCV/cMRfPu/JLyDIir+LeKRnh/6SE1q1wnvHlLCJcAwXE+G2sQ/1TO4E74am9GKKmI345k/CTWiVim70qnTFXjybaOcjCiYV+5Dou/FRkS8pwnZCW3PZUfAdkcEo8O3LcEurFRIgSWsLteH+vhK0nbt9G7b6BtfrLkKPYbw6A2Ur2ZVKndbCoqQG/POdcWX4GAGVfmdXpeGVY1uVcKx7cwbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSZEHx+xmmX0HMApg7mBOtUwx3LvRmE691q4dx2x2Fs=;
 b=ice9hLbGT07VtCoaOQ9exybfog88V71UYS8YtN8yuVT1KbSwq3TK8rHAwMQzNof4jBUc8kRAn91xyqmPUqfQYrOKl7F57ewqR/9HSYiX7Ib5t87K58sgbI5X3/XYEECwQ+qrXg3K7w1QcOApk19dDrz+ZH7zoB6Pr0QxQ81JTFA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB3804.namprd10.prod.outlook.com
 (2603:10b6:5:1f6::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Mon, 4 Jul
 2022 13:09:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5395.021; Mon, 4 Jul 2022
 13:09:15 +0000
Date:   Mon, 4 Jul 2022 16:08:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, David Howells <dhowells@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 56/61]
 fs/netfs/truncate.c:177 netfs_prepare_trunc_buffers() error: uninitialized
 symbol 'from'.
Message-ID: <202207031955.5MWchcdz-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0065.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6cbdffd-19ac-4c9a-9f59-08da5dbe6536
X-MS-TrafficTypeDiagnostic: DM6PR10MB3804:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIy+sLQu7Q9fwKjafxsOcm0vKAszfP9zQgw6x9e876gDu3v7+Gv/CanBU8QLGmWHwwYLVhDOIT+5cT3RumZqvf8TP3onlJuNi84aF57FY7DiBceebcGinb8cNsIda9GshyXqcicHmCujHP0X449S1zxx+8QZQITmuZq0yq8/eL7A1Zj7BJO5UPe19gXMUzpF+Njf41GFcnG9N1AkZtVgBmG6STGKko9wHYKDxHZlUap8Nr+D4UBJmX45QtTuTMHrKXSxqyjtm53WCmKtXFyWoeClGl9vseRTc1p4IUvWzD+ZT/oqaoBIDaVxfPOLHswuTAjbp67ZEO43Vtj10xVfjMjH8wqpvV5Vh4GYVpQyl2wI08zgpVJnNOKE5TIOA9iUKPoOxx2dKSsEloFvZf53jeejGi0XPUDatcFmIOPUno1wEuQZeRrbrS229WsmB3OasGQzSMp1snB6mRuZPg76MB06HLxoidl6WyD/EpaWsaTHos3up3gPjYZxkEaLVWD1w9/kwBNoTMx1oZKrYn4nvvoMfANtZ/x+LTc+JYM8e4XjYMv5LFDGBRmCxy03s1MmE+51VwMOhst+oUFRiEWObLVSq2x/zMu37ISChe2ufysFsQgTsfAD8QIVQWh6/Fmgxvubmq6nRLed1Bg19zz6kEsC/SsMKAI4VjiUvYk5y1rghpSBBPOvgJRjC2/WWR8tYhdtTFxWEbf6z6KZPds0/mmThSLyH9xe7DHYjB/JxbmKaAI8aDDu3V/LSs1R9NvN8mo7sK5hvCfezBpU5yVfonUzMdaQWOSyXxz2ftWIJYnp3jrWKct7nrxGLTpGkrU0w2pLbORijHeun6xXHDN9F2LJypXBjk15dsVqhYiapWClUc9thyWfcpVkhF3HyCA2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(376002)(346002)(39860400002)(366004)(86362001)(5660300002)(38100700002)(38350700002)(186003)(83380400001)(8936002)(1076003)(36756003)(66946007)(9686003)(6506007)(478600001)(966005)(6486002)(316002)(6512007)(41300700001)(52116002)(6916009)(26005)(66476007)(66556008)(6666004)(2906002)(4326008)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lg4CswR77tZvEfvscskYeI9tiU4flTq0rrl/q4TgUDH6qTuXdGsxhiaZeIXZ?=
 =?us-ascii?Q?m/7LpPheWhLZar2yl5Rv8YlpEh4qg5idQofzXGBtmKn/ZoRTj2ulSdUcBPNi?=
 =?us-ascii?Q?JT/Fa0+vXY33aCfABPLZmZ5YDATHdClipowcrj1vXTsVUuxFzuSYAexb6Q9R?=
 =?us-ascii?Q?6I8AU2bgg+0WIqZJyxxLwnjvLnx0l7Uj3DyDjmhQtW1zjKuFkph11ZDwqNQz?=
 =?us-ascii?Q?156JFPoYmn3sFH+3UOrRCT7ZupxioGVMWQc9uywKGYUut51aV5jzKcg/xbe4?=
 =?us-ascii?Q?BJdf0u1Ik4imrxR2PSvjDCWFCbW5pGQcV+cnJ6PiSk/2z9mT7ztUu0HnVvCY?=
 =?us-ascii?Q?SBLEWbRpoO9nIVi/BfEPJ120y2no0uudIrmbB1OsHMPP4remS50VPpVlT1vj?=
 =?us-ascii?Q?IZe/vej08xa9RlgshOFq5dnlK6n9IZUyjE/XLF+uZEJwnZWjOyHfJ/XwtTAR?=
 =?us-ascii?Q?NwNQiyuvdzaGjC5T5P34e7TDbWmJig1sg+WLvCm4Wv1cLoNgpboX3GPOHbO0?=
 =?us-ascii?Q?DYoWKKf+OOVzzcUx3TRRSS//B7u24rYndNTOQHTWG50jKdCIrrbJn4Xa6Q0Q?=
 =?us-ascii?Q?J1wHw2Bm4TKAiMn44NefyWs3d2PlXNxGHEeJnkTpaqyIdOHJUfTPiH1FvM6c?=
 =?us-ascii?Q?MwMKSDgo0nKkgWn1VOOT3QrQZHfNIHWUCZmBlw3g15CYTjCkmsxOnCJD3Vw5?=
 =?us-ascii?Q?gU7y0+6rlPQEnjJIR17YJVRlBZkxrc4HdVofG3LhyaIs2QMPoDXhULPgGEg7?=
 =?us-ascii?Q?umX5pBfLAY+tDpJN2ba4yeN6oLI2k+dM2WyTN+hl7Mx0g8M2yXqFsUUzehIa?=
 =?us-ascii?Q?9rDZ7dz8Bu2iL61Z0EEyzuiGIUZLQzLL+VJ753JCW6Hrw3TVHKHRIcGw7pSv?=
 =?us-ascii?Q?l01folj2yvH7drP4vA8GQ/9METbwPI8x5mI68Leu1X3QJsnRBOWEz02fdkgh?=
 =?us-ascii?Q?Ictq+XtY9zkHKLXu224SKzVu855aLw+AseHBXB1Kzu84PK0SEYDJYyRlY0nw?=
 =?us-ascii?Q?7lvkRNo2QKVV205zjOuP1FXCCg+gVWkbEhsK0MSTKlKAntMz078ZxOH+KB4u?=
 =?us-ascii?Q?PTywt76l8uEtmt+B0aWFWBc/FydcfkOW78mJVTuBSQzJB8bQMVVZi+oiR0Kb?=
 =?us-ascii?Q?rSY/lZCNNFz3+rSriNezFxoDhFyazjzPdfL+iazfEUBj9j2iqNIfaqOXRP0e?=
 =?us-ascii?Q?B/bWxwP2jJtOp5Q4lt2o6dTy/NfJb8QfDxjNxQaTf901BUHI/6iHcH/T8R1v?=
 =?us-ascii?Q?HM0wn5rD5MeTWRvio6TlIRnT9BLvTNF2Saknk0Er8VIQGZEvUABrt/XC6r65?=
 =?us-ascii?Q?KJh2UBZ193f7bXR5D3BVdRNMGSdj9RoHtN6G7sNJDaIDM1oKCOQYt63Ef2nr?=
 =?us-ascii?Q?MW1Y+hc2H5ciZQ+djo+O4pxndZ0MqXxHTDp5zJGQLbEju8q/ZsIKqSq0HgTP?=
 =?us-ascii?Q?EZiCnzYxB2l/s/iNOTsXw5GV18yB4Oy/QiSe5sHxY0p4Q+qm4MQU1itsmmh9?=
 =?us-ascii?Q?wgGCxKBuCi48vlVThbK+WNgczlRot0sT3gn2wZnsI27QqchhcfOzw/Hhjm/i?=
 =?us-ascii?Q?B39fu7/mW4OzDGSg173izfHeL7FbQ5sRCqjYkzMKMP7sY6EBA8zKRviJ3FgV?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6cbdffd-19ac-4c9a-9f59-08da5dbe6536
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 13:09:15.1156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6iQXZpQR8+UcysA3xv1oDq40lTkjO2KPwGOLO+HsmezE80puI659WjCmdaxTIX4LYypCG2lDq5hsBUZeoFy2U2hR6GmZIosU+HXHfbJ6Gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3804
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-04_11:2022-06-28,2022-07-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207040057
X-Proofpoint-ORIG-GUID: VUmjIGwYPQXvGSAr0cVyPCVuzilNuRuo
X-Proofpoint-GUID: VUmjIGwYPQXvGSAr0cVyPCVuzilNuRuo
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   ce4670495468b797b0c5927fcb661bc0da48b9ab
commit: b0af788660145c19754695953b240c9eaa311df8 [56/61] netfs: Implement truncation
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220703/202207031955.5MWchcdz-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/netfs/truncate.c:177 netfs_prepare_trunc_buffers() error: uninitialized symbol 'from'.
fs/netfs/truncate.c:189 netfs_prepare_trunc_buffers() error: uninitialized symbol 'to'.

vim +/from +177 fs/netfs/truncate.c

b0af788660145c David Howells 2021-09-30  144  static int netfs_prepare_trunc_buffers(struct netfs_io_request *treq)
b0af788660145c David Howells 2021-09-30  145  {
b0af788660145c David Howells 2021-09-30  146  	struct netfs_inode *ctx = netfs_inode(treq->inode);
b0af788660145c David Howells 2021-09-30  147  	struct iov_iter iter;
b0af788660145c David Howells 2021-09-30  148  	struct folio *folio;
b0af788660145c David Howells 2021-09-30  149  	unsigned long long base;
b0af788660145c David Howells 2021-09-30  150  	pgoff_t from, to, fto;
b0af788660145c David Howells 2021-09-30  151  	size_t offset, seg;
b0af788660145c David Howells 2021-09-30  152  	size_t bsize = max_t(size_t, 1UL << ctx->min_bshift, PAGE_SIZE);
b0af788660145c David Howells 2021-09-30  153  	int ret;
b0af788660145c David Howells 2021-09-30  154  
b0af788660145c David Howells 2021-09-30  155  	/* We want to hold the entire replacement block, but we round that out
b0af788660145c David Howells 2021-09-30  156  	 * to a multiple of pages.
b0af788660145c David Howells 2021-09-30  157  	 */
b0af788660145c David Howells 2021-09-30  158  	base = round_down(treq->trunc_i_size, bsize);
b0af788660145c David Howells 2021-09-30  159  	treq->start	= base;
b0af788660145c David Howells 2021-09-30  160  	treq->len	= bsize;
b0af788660145c David Howells 2021-09-30  161  	treq->first	= base / PAGE_SIZE;
b0af788660145c David Howells 2021-09-30  162  	treq->last	= (base + bsize + 1) / PAGE_SIZE;
b0af788660145c David Howells 2021-09-30  163  
b0af788660145c David Howells 2021-09-30  164  	ret = netfs_add_folios_to_buffer(&treq->buffer, treq->first, treq->last,
b0af788660145c David Howells 2021-09-30  165  					 GFP_KERNEL);
b0af788660145c David Howells 2021-09-30  166  	if (ret < 0)
b0af788660145c David Howells 2021-09-30  167  		return ret;
b0af788660145c David Howells 2021-09-30  168  
b0af788660145c David Howells 2021-09-30  169  	ret = netfs_add_folios_to_buffer(&treq->bounce, treq->first, treq->last,
b0af788660145c David Howells 2021-09-30  170  					 GFP_KERNEL);
b0af788660145c David Howells 2021-09-30  171  	if (ret < 0)
b0af788660145c David Howells 2021-09-30  172  		return ret;
b0af788660145c David Howells 2021-09-30  173  
b0af788660145c David Howells 2021-09-30  174  	/* We need to fill the buffer. */
b0af788660145c David Howells 2021-09-30  175  	iov_iter_xarray(&iter, READ, &treq->buffer, base, base + bsize);
b0af788660145c David Howells 2021-09-30  176  	do {
b0af788660145c David Howells 2021-09-30 @177  		folio = read_mapping_folio(treq->mapping, from, NULL);
                                                                                                  ^^^^
Uninitialized.  Weird that kbuild is complaining about code from 2021,
though.

b0af788660145c David Howells 2021-09-30  178  		if (IS_ERR(folio))
b0af788660145c David Howells 2021-09-30  179  			return PTR_ERR(folio);
b0af788660145c David Howells 2021-09-30  180  		if (folio->index > from ||
b0af788660145c David Howells 2021-09-30  181  		    folio->index + folio_nr_pages(folio) <= folio->index) {
b0af788660145c David Howells 2021-09-30  182  			folio_put(folio);
b0af788660145c David Howells 2021-09-30  183  			kleave("-EIO [unexpected folio %lx != %lx]", folio->index, from);
b0af788660145c David Howells 2021-09-30  184  			return -EIO;
b0af788660145c David Howells 2021-09-30  185  		}
b0af788660145c David Howells 2021-09-30  186  
b0af788660145c David Howells 2021-09-30  187  		offset = (from - folio->index);
b0af788660145c David Howells 2021-09-30  188  		fto = folio->index + folio_nr_pages(folio) - 1;
b0af788660145c David Howells 2021-09-30 @189  		seg = min(to, fto);
                                                                  ^^
Same.

b0af788660145c David Howells 2021-09-30  190  		seg = (seg - from) + 1;
b0af788660145c David Howells 2021-09-30  191  		kdebug("buf=%lx-%lx fol=%lx-%lx s=%lx@%lx",
b0af788660145c David Howells 2021-09-30  192  		       from, to, folio->index, fto, seg, offset);
b0af788660145c David Howells 2021-09-30  193  		if (copy_folio_to_iter(folio, offset * PAGE_SIZE, seg * PAGE_SIZE, &iter)) {
b0af788660145c David Howells 2021-09-30  194  			folio_put(folio);
b0af788660145c David Howells 2021-09-30  195  			kleave(" = -EIO [copy failure]");
b0af788660145c David Howells 2021-09-30  196  			return -EIO;
b0af788660145c David Howells 2021-09-30  197  		}
b0af788660145c David Howells 2021-09-30  198  
b0af788660145c David Howells 2021-09-30  199  		/* We keep the refs to discard later - we don't want read
b0af788660145c David Howells 2021-09-30  200  		 * interfering with what we're up to.
b0af788660145c David Howells 2021-09-30  201  		 */
b0af788660145c David Howells 2021-09-30  202  		from = fto;
b0af788660145c David Howells 2021-09-30  203  	} while (from < to);
b0af788660145c David Howells 2021-09-30  204  
b0af788660145c David Howells 2021-09-30  205  	/* Lock the folios and clear the uptodate flag.  Read must wait. */
b0af788660145c David Howells 2021-09-30  206  
b0af788660145c David Howells 2021-09-30  207  	/* Clear the region after the new EOF */
b0af788660145c David Howells 2021-09-30  208  	iov_iter_xarray(&iter, READ, &treq->buffer, base, base + bsize);
b0af788660145c David Howells 2021-09-30  209  	iov_iter_advance(&iter, treq->trunc_i_size - treq->start);
b0af788660145c David Howells 2021-09-30  210  	iov_iter_zero(iov_iter_count(&iter), &iter);
b0af788660145c David Howells 2021-09-30  211  	return 0;
b0af788660145c David Howells 2021-09-30  212  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

