Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA6D5A7620
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiHaGBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHaGBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:01:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93618BB687
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:01:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27V4uAiB018723;
        Wed, 31 Aug 2022 06:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2022-7-12; bh=V366PT18K1qn5CQP1PbdMubfGxZvI18evXWD1fuZ3fg=;
 b=QS985yLoDVDObvN2wpRhoqmoVMvk9ORPAYfKDE0KC6gCyfsB+jtFoSjCfzfCZKAUqu40
 RROsauDrFe165F0g99DkNgXTGhzmmPXzCBJfK8UsBflHDSNlDInuD8kRbZyAupC+rjXs
 N12PRe1XJBhcx9+rRONt94atmKtEGxaqnsijGb+HY4eAmaC45d6eK4pF6LEct62IJ8t9
 hfmS54poVZzLsEy+gA7p1gDlVxDF8/A4YV+VoKYpw8Hk6qKoekzMMyMylmNqWcAnIeS2
 4nXAu8Bd/bxIvHbCy7YhMTLsRc7yG+U8ZiVZjC7rY1M3F/3ojIEpIPL6LThtO3NnXPIP fg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7b5a04wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 06:01:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27V2Q61c038175;
        Wed, 31 Aug 2022 06:01:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q4r76f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 06:01:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqVlSHzASJarvTozwCzrJya9AcFJ3E53RZBAbU7HBta8vLpFsj9JPY80pNA2mTZt3rLq0yK9Ebiy+Q9W+vayrzkXbfdNMBTipDD+8cZSUOk2sUsRm798ebTxJILpY/WORTHdPkrYkfF9Raa0MLfTPILXU4epo7MkERnInmD9i91BPT2Hh+9fVjrKaBP/vekGDcyuuKcUDV81dfJU7A3nVKbbW4htD8+bVkda+d/WhWlHmdUiKYVLTxgQdSB/2/Eq3PlOPAgbdV+GsG97oGr19eNdOVsCVimmBVyPxbyDcy7QzdfWkJ4P3dgrpc/0jFxogZrx15h2iJLk+7R6Keq7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V366PT18K1qn5CQP1PbdMubfGxZvI18evXWD1fuZ3fg=;
 b=I9FaXff1SdRRaNZfgGcGq3HrkLkVpBHfXEBaFTAGMAVonX9C/IqOr0nxdbNQU74/NEV74hvxtlMOeSeZiRLyHoZPvIeBawL9bg3O0gyPDZ4iO74sBfzzMcSjt48sABC773LzP0HMCveWNBAxfcZM6sXCE6gk7IXgtnDWMSFiLJ/4xQygdC1BW73aOODBqdmzzprqielXHIPNUKR8P23Ri3AFM8XQc/PxdGEkcsns0F+o+WnWpZ4L9EETXZU6Mj3vut90NKYSzhAFAMpZGqMuohoK3JRwxAFRWZvlHoxg/tSawXHnG3tZnTo9QEP608qdrmTFXuAkPJSvHS5DYYl5LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V366PT18K1qn5CQP1PbdMubfGxZvI18evXWD1fuZ3fg=;
 b=buDeGhcVI+QDC451REofDRJMELU268n+s4AzOOmp/PZk+Fxu1v/UT0N6pu7eKhnf4sLKe3gzyCHhAaPiqZptyybIrtM4qoRchxDA2h7FmTofi5wEcYUUbUvWBpIPjaDD6zR0SUvjTQCIEXBLFcEBkYsHY5SnSZr2RB1iQrdc9TQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS0PR10MB6175.namprd10.prod.outlook.com
 (2603:10b6:8:c1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 06:01:33 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 06:01:32 +0000
Date:   Wed, 31 Aug 2022 09:01:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Yu Zhao <yuzhao@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dongli Zhang <dongli.zhang@oracle.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH] Revert "swiotlb: panic if nslabs is too small"
Message-ID: <202208310701.LKr1WDCh-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829232934.3277747-1-yuzhao@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0019.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::31) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44fecda5-e40a-4d43-60fd-08da8b1640a7
X-MS-TrafficTypeDiagnostic: DS0PR10MB6175:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +BHRsAuhoZG/667w+2CtGftkW+QLdOOwe8KkLLEV3n8VHf5VfQ8IJZ28EV93jB5e1UPFiLRGhT5JDTtsrfp/R9w9yw4Xw/gI5IACBfa9Oiw9KAhr4SHkBNvy2D7V01oEexPBiEQ7tlkWd9/1p+fiRleZ0jHZNE/wEvGEjj2lwPMUonhwqt9bV0PUh4/v0hDUEEKPVDFh1Ik6gMUTtVGAj8Zygm4sWAHPM2Sx/Xgi/5LTCGyQ2UZdBqmdmHmt02C4p/waSq730DTLhKnWmd3x8cp7O4CgxBCOCgTUWt9S2QjJsBBrVYP32o0IukdDa1bHThycHkv2nkALyZnkBAZWXDrJ61uo8vHhVHnom8FRL7VevmdSBxVUKOuFCkUMiFGdzIfKV6Wz2WuFVU3TG36symj00KiayR0rHzoa1Xj4sbVamp8vtqsxDA+OdJY1wx5ovSR86m1JjnKydRpxo5zx2JthSmS2Kt5cx0tQ1jJmtFKIBBvJdj7TX3PHDHGVIpkV63syvTZqE+cjl6Bjl653RlEWgii4d0iaqG4HFYFj4qnWVvrs3Sn6xuqKdVwXTbhOKyODUWh5BErStcDdbydXAo0Sjmv8i+Q2sRc7LY9Go11gWAHuEsmzZsFYMm7qk9tjw2ZkA508V9IhQUvzJ67oLABYmSd49b/hwzeTtidaxhGtIBW2W4AP9A97PLU4+6D7dD8CvHAg54y8uC81ZK8kQe8I0gIjPo67Md93oVRIh369q2/EglcR/EdskkfsmqxLJXQqJd3wuDDSzKkGzsMJ/0DWYmuYy7yXLKcfPu6V45HM7RW0O/6PY3Y7UJ4K86CxFdP6SKb5jsPpnKFn7HCITNNgEO2S3E05atcDDjbK3GTT122yKcKlOSExeq7TnPAv1Kc7YBr9AC7HAZELa5OH1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(346002)(366004)(39860400002)(136003)(66556008)(52116002)(478600001)(6666004)(44832011)(66946007)(8676002)(4326008)(66476007)(966005)(83380400001)(5660300002)(8936002)(6486002)(6506007)(86362001)(41300700001)(6512007)(1076003)(9686003)(26005)(186003)(2906002)(38100700002)(38350700002)(36756003)(316002)(6636002)(110136005)(160913001)(15963001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?owwUbhmokw+HUKaV/B4nwbDW2E0RKCB5S6je4swaNyKZ4XwDPdjUoW6i4Mbf?=
 =?us-ascii?Q?kjQLb/UPwbP+axxgdQ0+uRvw+RXLMJ8z5jNcynZs1InnHaODBa7Yz6dPWA8U?=
 =?us-ascii?Q?QwUvssKZmlUKhxzW3qtulwqQ8qNkmEoKd8jbE6CUEa6q7b6vHpZIdCAMHMeZ?=
 =?us-ascii?Q?AD49JpHD0kxjOHBi8pholH0ZZ1XSqYANvgmrc8qM4/S+XLqCDsfoRHQV9ZlI?=
 =?us-ascii?Q?/PmOHvT1BCPeVo8SqUVLgm8/2+3BLHz5IUj8amOaZA4L+hm+hu5AJiTtk7mH?=
 =?us-ascii?Q?JDT0axio9ZZIaE8RA1AC+1LPuKzm2i2EoDRIN3AW5s8JtAUp7LN+FqWc6pJz?=
 =?us-ascii?Q?IpHVJAGqDMM06wm1sd8/YTdmj3fkhku+tiTeog4nhrMEWxy6IcNF7QN62NKK?=
 =?us-ascii?Q?pdISZ4otp12+8IFMQZT1L+CHK20VIuAY2CSfeHzaWcKGQX4XDL8/v17p6uD/?=
 =?us-ascii?Q?NEyy4Re9LSmkXYaGPetd0eYdVVRqQFqkRWoJ9lRKAs/Iq9re+wcjAyoQ60qW?=
 =?us-ascii?Q?wrj6O+ydILK9SfB1HG3DzDyN4a/VyxRq6WenWUZVMyIftuGDc2AC4ByHYypV?=
 =?us-ascii?Q?wGzHAhBprgmO+rPmk4TjEODIMP1FRgKpp2OLR9eePo0KbWFkY2AI2X6eV4Ln?=
 =?us-ascii?Q?UeZ7v9L74QMbn4xq18YYEJi2Hb5+XhgMuAZlZlg95Nq/pBwwwf0YcPliMtxW?=
 =?us-ascii?Q?NDgqhHmFUvfcBFoYdkB+0LEoxJHy8aBGVCSdN4RbUVpVz3PpCTkWyHQuTavc?=
 =?us-ascii?Q?iLNPe4sBju0w6EHtPjaHaCOlqaaKuGVgSNKsuTVgtOaQQerdT2V3T+ZE3nsd?=
 =?us-ascii?Q?0Onwu1Io5WV1rIzdIWVW53idBdpQYv43Kzi6/5TViCpazRJ96tv4JurjJwbI?=
 =?us-ascii?Q?UMznJ49tfePjLOvzxCzbepkrfv+12F83MjBwU1wf8YLwWRmPub9IGA0IlCrk?=
 =?us-ascii?Q?8OKkzHgrLx6xl6RDYrX5vREJCI+TCUkzAGAEYoF0SQkMbM8MxVHtY/PKygF/?=
 =?us-ascii?Q?Rm2i1HBe1RlMnl5VM7kxkZzjeev9KjrxqBq3RH21DamNDB0Rxl0bDFJELn7J?=
 =?us-ascii?Q?ROqdBPnK+fJy6I3urcpt4MIRy4yI1ztR2Kr+zHPkaLivOZVktS9t7Y0f5o/Q?=
 =?us-ascii?Q?J3TgFbNi7ZnmfcPl27NDvp7pf3lFjzuPf1T3/JVW7+2WEMbJlFsJm9+TicGT?=
 =?us-ascii?Q?MmlQJM/1kw3YutXDK2ilMKddtc/5xplv1/n+mw4uqxdxnJot+YUxB6MR4WLx?=
 =?us-ascii?Q?s6gBsN2hiIo4Cv2EH00t0GUDdYOhcit/fJzYJ5cXatF+cloIJmtJUDdYRLSP?=
 =?us-ascii?Q?PoYzQLzCznK0SZvfDgJOUVUFn7zVB85K4RMHavqXkLPEh/L8+aOSyq3ENqhh?=
 =?us-ascii?Q?DBAwra0yiR/7FZuIHQ+XS8cxIRO0o54MjetR59HKNy/VEC5Fi1cPsQ9gBhoU?=
 =?us-ascii?Q?hR1u/pVO987FmdDOZf63c/fZbYzG/KtYU0Kgx79yPPo8SqjxxqKHNoIA6DCI?=
 =?us-ascii?Q?zBcu0JVAQj3qZtAw5QVumj7gElQt8ho+1DDPQSrUzTeNDya8He2C5CzIwRGO?=
 =?us-ascii?Q?cT9/s7iZWue2ceK/4wjcrbwhCMQxRYabSZP8iy5x1aHrRqEQi/DZpt+XlJ3T?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44fecda5-e40a-4d43-60fd-08da8b1640a7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 06:01:32.3004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loPFunkC12eCGiuHQdcaHhWg5oAaBn5Nr3ajCNViF9jhtC4gPX30pKy4/B5yVlc4uw45zaeE2K8Z5gAm7KkoY14UVaE/u7xKiKuzmXLUAnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_03,2022-08-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310028
X-Proofpoint-ORIG-GUID: sbWDdPiE7L1CXFaIXz4Y8y86LV57Czyw
X-Proofpoint-GUID: sbWDdPiE7L1CXFaIXz4Y8y86LV57Czyw
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

url:    https://github.com/intel-lab-lkp/linux/commits/Yu-Zhao/Revert-swiotlb-panic-if-nslabs-is-too-small/20220830-073123
base:   c40e8341e3b3bb27e3a65b06b5b454626234c4f0
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220831/202208310701.LKr1WDCh-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
kernel/dma/swiotlb.c:334 swiotlb_init_remap() error: uninitialized symbol 'nslabs'.

vim +/nslabs +334 kernel/dma/swiotlb.c

7374153d294eb5 kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-14  307  void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
7374153d294eb5 kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-14  308  		int (*remap)(void *tlb, unsigned long nslabs))
                                                                                                                              ^^^^^^

abbceff7d7a884 lib/swiotlb.c           FUJITA Tomonori   2010-05-10  309  {
6424e31b1c050a kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-15  310  	struct io_tlb_mem *mem = &io_tlb_default_mem;
20347fca71a387 kernel/dma/swiotlb.c    Tianyu Lan        2022-07-08  311  	unsigned long nslabs;
                                                                                              ^^^^^^
Merge issue?  How does this compile?

a5e891321a2196 kernel/dma/swiotlb.c    Christoph Hellwig 2022-05-11  312  	size_t alloc_size;
7374153d294eb5 kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-14  313  	size_t bytes;
2d29960af0bee8 kernel/dma/swiotlb.c    Christoph Hellwig 2021-03-18  314  	void *tlb;
abbceff7d7a884 lib/swiotlb.c           FUJITA Tomonori   2010-05-10  315  
c6af2aa9ffc976 kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-29  316  	if (!addressing_limit && !swiotlb_force_bounce)
c6af2aa9ffc976 kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-29  317  		return;
c6af2aa9ffc976 kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-29  318  	if (swiotlb_force_disable)
2726bf3ff2520d kernel/dma/swiotlb.c    Florian Fainelli  2021-03-22  319  		return;
2726bf3ff2520d kernel/dma/swiotlb.c    Florian Fainelli  2021-03-22  320  
20347fca71a387 kernel/dma/swiotlb.c    Tianyu Lan        2022-07-08  321  	/*
20347fca71a387 kernel/dma/swiotlb.c    Tianyu Lan        2022-07-08  322  	 * default_nslabs maybe changed when adjust area number.
20347fca71a387 kernel/dma/swiotlb.c    Tianyu Lan        2022-07-08  323  	 * So allocate bounce buffer after adjusting area number.
20347fca71a387 kernel/dma/swiotlb.c    Tianyu Lan        2022-07-08  324  	 */
20347fca71a387 kernel/dma/swiotlb.c    Tianyu Lan        2022-07-08  325  	if (!default_nareas)
20347fca71a387 kernel/dma/swiotlb.c    Tianyu Lan        2022-07-08  326  		swiotlb_adjust_nareas(num_possible_cpus());
20347fca71a387 kernel/dma/swiotlb.c    Tianyu Lan        2022-07-08  327  
8ba2ed1be90fc2 kernel/dma/swiotlb.c    Christoph Hellwig 2022-02-28  328  	/*
8ba2ed1be90fc2 kernel/dma/swiotlb.c    Christoph Hellwig 2022-02-28  329  	 * By default allocate the bounce buffer memory from low memory, but
8ba2ed1be90fc2 kernel/dma/swiotlb.c    Christoph Hellwig 2022-02-28  330  	 * allow to pick a location everywhere for hypervisors with guest
8ba2ed1be90fc2 kernel/dma/swiotlb.c    Christoph Hellwig 2022-02-28  331  	 * memory encryption.
8ba2ed1be90fc2 kernel/dma/swiotlb.c    Christoph Hellwig 2022-02-28  332  	 */
7374153d294eb5 kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-14  333  retry:
a5e891321a2196 kernel/dma/swiotlb.c    Christoph Hellwig 2022-05-11 @334  	bytes = PAGE_ALIGN(nslabs << IO_TLB_SHIFT);
                                                                                                   ^^^^^^


8ba2ed1be90fc2 kernel/dma/swiotlb.c    Christoph Hellwig 2022-02-28  335  	if (flags & SWIOTLB_ANY)
8ba2ed1be90fc2 kernel/dma/swiotlb.c    Christoph Hellwig 2022-02-28  336  		tlb = memblock_alloc(bytes, PAGE_SIZE);
8ba2ed1be90fc2 kernel/dma/swiotlb.c    Christoph Hellwig 2022-02-28  337  	else
2d29960af0bee8 kernel/dma/swiotlb.c    Christoph Hellwig 2021-03-18  338  		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
1521c607cabe7c kernel/dma/swiotlb.c    Christoph Hellwig 2022-05-11  339  	if (!tlb) {
b253fbc6b9640a kernel/dma/swiotlb.c    Yu Zhao           2022-08-29  340  		pr_warn("%s: failed to allocate tlb structure\n", __func__);
1521c607cabe7c kernel/dma/swiotlb.c    Christoph Hellwig 2022-05-11  341  		return;
1521c607cabe7c kernel/dma/swiotlb.c    Christoph Hellwig 2022-05-11  342  	}
6424e31b1c050a kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-15  343  
7374153d294eb5 kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-14  344  	if (remap && remap(tlb, nslabs) < 0) {
7374153d294eb5 kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-14  345  		memblock_free(tlb, PAGE_ALIGN(bytes));
7374153d294eb5 kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-14  346  
7374153d294eb5 kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-14  347  		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
7374153d294eb5 kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-14  348  		if (nslabs < IO_TLB_MIN_SLABS)
7374153d294eb5 kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-14  349  			panic("%s: Failed to remap %zu bytes\n",
7374153d294eb5 kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-14  350  			      __func__, bytes);
7374153d294eb5 kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-14  351  		goto retry;
7374153d294eb5 kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-14  352  	}
abbceff7d7a884 lib/swiotlb.c           FUJITA Tomonori   2010-05-10  353  
a5e891321a2196 kernel/dma/swiotlb.c    Christoph Hellwig 2022-05-11  354  	alloc_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), nslabs));
6424e31b1c050a kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-15  355  	mem->slots = memblock_alloc(alloc_size, PAGE_SIZE);
6424e31b1c050a kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-15  356  	if (!mem->slots)
6424e31b1c050a kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-15  357  		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
6424e31b1c050a kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-15  358  		      __func__, alloc_size, PAGE_SIZE);
6424e31b1c050a kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-15  359  
72311809031217 kernel/dma/swiotlb.c    Tianyu Lan        2022-07-21  360  	mem->areas = memblock_alloc(array_size(sizeof(struct io_tlb_area),
72311809031217 kernel/dma/swiotlb.c    Tianyu Lan        2022-07-21  361  		default_nareas), SMP_CACHE_BYTES);
20347fca71a387 kernel/dma/swiotlb.c    Tianyu Lan        2022-07-08  362  	if (!mem->areas)
20347fca71a387 kernel/dma/swiotlb.c    Tianyu Lan        2022-07-08  363  		panic("%s: Failed to allocate mem->areas.\n", __func__);
20347fca71a387 kernel/dma/swiotlb.c    Tianyu Lan        2022-07-08  364  
20347fca71a387 kernel/dma/swiotlb.c    Tianyu Lan        2022-07-08  365  	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, flags, false,
20347fca71a387 kernel/dma/swiotlb.c    Tianyu Lan        2022-07-08  366  				default_nareas);
6424e31b1c050a kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-15  367  
6424e31b1c050a kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-15  368  	if (flags & SWIOTLB_VERBOSE)
6424e31b1c050a kernel/dma/swiotlb.c    Christoph Hellwig 2022-03-15  369  		swiotlb_print_info();
^1da177e4c3f41 arch/ia64/lib/swiotlb.c Linus Torvalds    2005-04-16  370  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

