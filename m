Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4B557839E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbiGRNW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiGRNWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:22:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B7E248E4;
        Mon, 18 Jul 2022 06:22:22 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IB483K031635;
        Mon, 18 Jul 2022 13:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2022-7-12; bh=kkJxg1qK2Rk1I0TwVfuraqSkSXNR9SlMPMNdyMlP8/Y=;
 b=Slj8ZRBGV/68VQ6AJ6lkaMHEs6iRcElfC8mE1YnLo+IASaZtgp3drWLF1Rh5Jzm9avPo
 kymqn5G+gd1oyGgq/wG+XbPlBlO/F3tbLh0ZcoUN+mWEdHw628TWIoKh+pGCPs7u5frg
 BWnnZ2GKoXYqj7NHu+pd6LuuY0wJnFL/8UGZHHNT2CjNvJdBq6DGXJXXnfIAiFidog8G
 jmFPshmf+Qm5AEWciCfTSjSfylcqB10BXVbyO/SunikELCMSiR5snMpJ5Ix7Q9PSZfNB
 zI/SP/RN1SMvaUImbooyjD0tAXYxOTuZnWlLs36ebVIWeAQryhUwMYqT85ADfrtWVh+S rQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc38ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 13:22:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26IBRSQl028106;
        Mon, 18 Jul 2022 13:22:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ma8dmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 13:22:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dzyo3QaI+7stst08M0sHm3NQHKAyPdO5EQ9cI2pFoxNevKpQH2ixOMiYxxsBmNoAL4Mh3DyO7tT8SQA1oOsF0AfafBSdAgeUuATJRYWcKRffliITMHVej6ZlbV10Zhe/RYZw1sFhSrrE5ozTG2v/YemHls9pn7hRldryUOTU2t3eCKHgZwvg1TV41iT9KxOheS1cHkIvjYYvPU5PeSBPfumarPVQ9iB8NxlSHXfBXW5OXLj5xcDQJhz2FPF0ItDwI//a99UDUH9DgW8CT8HoIWKvMK5OmOo/QKV8CMw83UrPa5koawHkxpHJOQMhyoOT45su8GiVc1jwJym2TuwYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkJxg1qK2Rk1I0TwVfuraqSkSXNR9SlMPMNdyMlP8/Y=;
 b=kd9qtSGlehvjA6YAcgHNS1gHyEVqMKrObA4IAor9a+ZWTqlXe4Tnrnq4MtBFl1WiI517mrkLcG0QP3CmoTvW8j8iO2ImSeVYIArVWnV/78EFlHCsBfpf+ICWYlfoQ+SLf9xkQzTU528KKlTy2K/WQKlZNbs2so+whLGHG6Jca9N6xb8v3ENjHnBh1QKMKp1lzAiLIx0icA8ZVouatjoLK7Pltb0LXxmJpcaM1rjcNxPNgTN2lHMgf3Bmkj9mHCKFbiHNnkPf1W+33cIMNs0Y64G4DVJ35wtJlRFdqDKp9O+tyVL6bn64qZ2iNp0gnQ1/Zv1hxemZxxq53iaZce662Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkJxg1qK2Rk1I0TwVfuraqSkSXNR9SlMPMNdyMlP8/Y=;
 b=IloY4HITW0yPiUYB7mzzYNw+kcJC6NrsjROfWDxI0NT9UddKiUKSR6pz0yuCTHUuCHRfpfitZMxB6ExG3YkUbY7nelIoSRLMFgklrvB0mMM4DVB1AwuZiBcrHXxnaScxxcLIuGfAzBpp4Fw5UI3dV2EvuQPDCY2F9BeSHJwg2a0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB5597.namprd10.prod.outlook.com
 (2603:10b6:a03:3d4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Mon, 18 Jul
 2022 13:22:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 13:22:01 +0000
Date:   Mon, 18 Jul 2022 16:21:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Li Chen <me@linux.beauty>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Li Chen <lchen@ambarella.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] of: add struct page support to rmem
Message-ID: <202207181758.YyEzUSPl-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711122459.13773-2-me@linux.beauty>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::27)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 178848fb-ef4b-4e67-f7e0-08da68c07f19
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5597:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AcsU4OcaW7R9JnIMwdJ/t/y01fnHdu+GSdw6k8TyM30ZThXBcHqS+jCxKMaQhzSyc6oz+WXxO0pgtYnJJqERq9oC0UyvQj/yO2QNqxFZ0Q2YO1vDADoXJCaKlPiTpWJMV2cUmMZb1hFzzGyfurvuNQEG9M3Nt1GZmo0UY4ePDkyW0bBYr7fhaKCXzB0bTmyXml57H7KwLeQ7FFbtRm/pdIokHD7+yumyCF7C7aYtpQY1iPiQLy7vU+XkWrCQjygYfB019hRizlhSNvKwmPlD/DVmsGUpiaTydkH9GKTb74PePQB88zi9cu1ywXUI6WFCUou4j5bdepsnb7EjW0/CncDgEmLgwl5jNAa0QwHE+UtO4lJSbM13uUlXICN5BQ2BpsPv4pnk5fllMNB38gqrFjrXp+7ejn1XltQqc/R8RDTsB8wJNtJ8o5ahQ0fTGh8FdqLodVjD5qTzxxiB2aiXu7EXGlqfebbFYPZTSfZfbvWo7BKGd39Y3UMdc6jAvt7pyKkA/SGpMfPmM3Lo51i5cfAHFnzbcLsx7lUhUeYsj6nnsaqcUi525KeOpCIFzrI9OPU0zE3nCMHA8Qfdn5XpJWWb94nFtjpK1JkRtcJpq0ru21sE+UkJI5I5mZNnyZZ3AxxB0BFliFP7gg9Ta9lbWDo9gS0qtLApsjuVIdryu84r4hBbmt0N9JCdXn/pXnuL7zTgaZyxjO1WRFqMlGjJfYgelf+w+qn718N7kzILpXkOSF9bkKI22BWt7aidWuFCdaZ/RiYSLFFD+PBQmkZEM7CRcqMfHZc+bZHkcddvQbya4VcJF+oCUW9t7lVnewg68zyQQlj9SNGELVEKKjLcgQMN0eAoCXcYGiWry1uMh9bDdmOlyKHp6ShBeTO4AJ7U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(346002)(396003)(136003)(83380400001)(54906003)(110136005)(5660300002)(44832011)(966005)(7416002)(186003)(1076003)(6486002)(316002)(38350700002)(38100700002)(478600001)(86362001)(66476007)(66556008)(66946007)(8676002)(4326008)(26005)(36756003)(9686003)(6512007)(6666004)(52116002)(6506007)(8936002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3PXdBkkMBYOa8f8lZwptArpUkRWw7QToCdMM7EozPqFL/a/kUq2HTwDNQzkz?=
 =?us-ascii?Q?VjOyt3LWnSd/wLoEkruzg/hbl9otQ96kochqTBDV+AT1UfLi+8HzCCMGT7hF?=
 =?us-ascii?Q?02ekD5nLtMd7j+ficwBMdmtuPw3yYJFPr3eQ9uVh7UlKLjY1WPVHH3KXHnV0?=
 =?us-ascii?Q?itZuYdAn2wrYkw/v2fS0ewgU0H/rPSnqtjnrG9NlRNgO/1A8r60Te9KvhrgL?=
 =?us-ascii?Q?OVUiQf6TBKUhW4VS0AVvB9rpbnJWtyKkToQkpRcRedEKeEeEHLYUig/n4The?=
 =?us-ascii?Q?UaLHm4YK6Kxs96X0UB2jywZUyCWGgK/AmxespXqcEM/qo1SyPG4IZL2le53l?=
 =?us-ascii?Q?ydAug7g4dJ8mcB62FKIH466AUKL329rb6RuMyj+G+CvGPmYEmI5Y7N3QhinL?=
 =?us-ascii?Q?NfIcGuHAbG9WKaTt45enrYN2mzJEZ9hKv0zruxPSuinMGD6S0PlrkOBiSqHv?=
 =?us-ascii?Q?Zt6fJN0EWWXp0z62QT68zleU9PLAn5axRtKRnQhIjSAFSw6LXNI9pbD01s2I?=
 =?us-ascii?Q?7A6Q5QbyHCvwfDVtKK7f6+DURcMiNfrLZZFvy7vrTYgIgQy7Z7UltpYIRv0v?=
 =?us-ascii?Q?j08XHGolCklot336E+NkCmTMzA7dcUGd/eJrpnq7L6FH/GOqVXzcovNqFvaQ?=
 =?us-ascii?Q?+XtOtYM00UpMyfYTgY2cTgP4dccrRXrsWbR6jZxCBr1ZNPocKMGPYpNYfAWc?=
 =?us-ascii?Q?buFXafFeqHMSyMgxuAbBo3c2Zm9/7RaEbCFYR7IrPIXbW50i0U421jiQVSDD?=
 =?us-ascii?Q?Jo9XKiM4YIt39LoX0+t38Pi+AVHv6o+/HMbU1DyAYBxL5XQCCCopY4eIiWtJ?=
 =?us-ascii?Q?kS/2dT88vSQjCSSzsM/zQly/4wveVKqUGLzmizzhDIvMJgguL6eqCR3mhqpZ?=
 =?us-ascii?Q?Pd9Jr3fbXD3CbipzT7qf/5/52eNBGx8izM/7NwLTivxZxPq8Md1X+zvyj2HN?=
 =?us-ascii?Q?7a6aeMS5AIFFTiPh6FBJlFBqBN/c8MUbBsLcckbFt8t5xHOD/td9Cm6R8YUV?=
 =?us-ascii?Q?V6aWzhQKLnp/cHZXZMEih1DL04pn8tEzBm4yfogAXS1mXZjFSupcnt92QaUw?=
 =?us-ascii?Q?5v8PaieaS3CGvfp6nbroXr0bOMluu/CzqY3FKjA0hfFA5W1zjAR8grgaK+3f?=
 =?us-ascii?Q?yK91ICcBgKc78I8FKDjp7mO4QqK1jsuz4fuAjymw90+l6K+KVwwR9mpD4Zcm?=
 =?us-ascii?Q?ZTsnzR9yMlVYasN5OWMJM5MRKFGsYKuZ17V4UTaaMLdmkjvZ96fx8AFDknsF?=
 =?us-ascii?Q?TfHkH3vX57sTPVgpYaVMxwdc27wXUpOeb1wV7JZaA7Z0y9CUacWVnDEaVRuT?=
 =?us-ascii?Q?EaX7wB7xYJQndhz+kX9ssQA0n2/xDY2iMum6B2Y6jXtlFIweEksISk4aenVP?=
 =?us-ascii?Q?Y50PuPkoMb8CT3IBbkg9jr5PuOyrsDdTxR5r3R++YVHBp4OJyHYV/EKKWbri?=
 =?us-ascii?Q?8qiGqRWWBYTKUN+cMmYyjG5qYCv0QTGAmjZftCIDexDz9lM5riJiL81KzEvB?=
 =?us-ascii?Q?vn1LFDgov9xvH/rmxqhMpBrYHSj487VEV9RVpzJ31gDKOWNXEzopIoIHHeti?=
 =?us-ascii?Q?vInERyacp+m8+2KWucRyjBSN5Y/m3zvWukIDUz+aEYtHNqkJYlc6fsOu+mh3?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178848fb-ef4b-4e67-f7e0-08da68c07f19
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2022 13:22:01.4419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1svvUFEMeYFi9a2p85oJ+i2YyNx3RP0ls2sDp/Yup7+HlQo5V1rxk2IRATjVfRAVAkr+TLuq0BP7FpVe4s+QxjfCh0FGfEhnr4vARlNHMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5597
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_12,2022-07-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=637 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207180058
X-Proofpoint-GUID: DGjNCR7jQ7jT1Orq8QFJU94HsRLsigcG
X-Proofpoint-ORIG-GUID: DGjNCR7jQ7jT1Orq8QFJU94HsRLsigcG
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Chen/add-struct-page-and-Direct-I-O-support-to-reserved-memory/20220711-202957
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: nios2-randconfig-m031-20220717 (https://download.01.org/0day-ci/archive/20220718/202207181758.YyEzUSPl-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/of/of_reserved_mem.c:472 get_reserved_mem_from_dev() error: passing non negative 22 to ERR_PTR

vim +472 drivers/of/of_reserved_mem.c

8b66b4b9614f1c7 Li Chen 2022-07-11  457  struct reserved_mem *get_reserved_mem_from_dev(struct device *dev)
8b66b4b9614f1c7 Li Chen 2022-07-11  458  {
8b66b4b9614f1c7 Li Chen 2022-07-11  459  	struct device_node *np = dev_of_node(dev);
8b66b4b9614f1c7 Li Chen 2022-07-11  460  	struct device_node *rmem_np;
8b66b4b9614f1c7 Li Chen 2022-07-11  461  	struct reserved_mem *rmem = NULL;
8b66b4b9614f1c7 Li Chen 2022-07-11  462  
8b66b4b9614f1c7 Li Chen 2022-07-11  463  	rmem_np = of_parse_phandle(np, "memory-region", 0);
8b66b4b9614f1c7 Li Chen 2022-07-11  464  	if (!rmem_np) {
8b66b4b9614f1c7 Li Chen 2022-07-11  465  		dev_err(dev, "failed to get memory region node\n");
8b66b4b9614f1c7 Li Chen 2022-07-11  466  		return ERR_PTR(-ENODEV);
8b66b4b9614f1c7 Li Chen 2022-07-11  467  	}
8b66b4b9614f1c7 Li Chen 2022-07-11  468  
8b66b4b9614f1c7 Li Chen 2022-07-11  469  	rmem = of_reserved_mem_lookup(rmem_np);
8b66b4b9614f1c7 Li Chen 2022-07-11  470  	if (!rmem) {
8b66b4b9614f1c7 Li Chen 2022-07-11  471  		dev_err(dev, "Failed to lookup reserved memory\n");
8b66b4b9614f1c7 Li Chen 2022-07-11 @472  		return ERR_PTR(EINVAL);

Missing - character on -EINVAL.

8b66b4b9614f1c7 Li Chen 2022-07-11  473  	}
8b66b4b9614f1c7 Li Chen 2022-07-11  474  	return rmem;
8b66b4b9614f1c7 Li Chen 2022-07-11  475  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

