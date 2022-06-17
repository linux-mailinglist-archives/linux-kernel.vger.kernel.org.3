Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F06054FF3B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbiFQVMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 17:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiFQVMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 17:12:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1FF13D62;
        Fri, 17 Jun 2022 14:12:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25HGTkJo029754;
        Fri, 17 Jun 2022 21:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=soTXftoOZWzSCrILHnuPYDrowf0zvgBTuyPMyqaY3tA=;
 b=R4cfOJSCrpdjVWRdFQ1xSDsLPJk2J4Y/qhJq/p/TtyWvRMAeHH8YqKFbgns39G3JCbVB
 xxS8bQ+DP95iRWL5SVWrsvOJ4/Eb0lQZf0ex2sGeU/GjxflzaMsRjL4V4mnwPaeKNPlY
 /di/CsiwHbLBhen0vh/uk54OQ7Wv3DhXycnllEtdy1hEENpEhjgjnco8y0xK3J78RBnq
 WrV7LWgAt68U0eWdbWjdDiO0twFvoqBHalofymsiU0IERT1J3BldGeR1qsv6B3B5QNu8
 /Xl0Cx3+Xkc9M5pK5f6jf3dm0IIQsk73HHqnwk+oA5lIFKY/dm+fcupnD3CHe+ijTGB6 IA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9peg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 21:09:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25HL0LoE016941;
        Fri, 17 Jun 2022 21:09:57 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpr2cxwe0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 21:09:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzrcGxSDqA5sbzMd82N3BB/8xiSTFSqb+X82WLfylPenpJQxsi87rglAOCTitxARMcR5UPRD3zfk6+tAq4n4/vVB6aTjhEYMr9dboaSk+P5hm+3R2UQVVkHe7gJxKq1/H6aQXL5QII1ZA1Xt4RB/sTcmV7ImNgV5iJBEkYGM1l+DX7D5fnOoiOCIR444g2QdGDOZRLWIPyfLHSVUHb8xaFkJkAD7ojAPmMDVCNDiuoZOMLoJUOcaMHrmrriioVCipN47lpGgegH6AqRKFgQaYAhQN/8iPOwMa++yLKbxu2WOH3DerGugub/Jmxa+uCWEnvnjXv1WdP1EQOGMI2oirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soTXftoOZWzSCrILHnuPYDrowf0zvgBTuyPMyqaY3tA=;
 b=XbItzNpAdRBC4GV2OiRtmuS9Z51m6MrgqBt06K7W98V2WudT2GIdWS2qw3h05rwa0jiMv1i61ev34Ho/d1VSVI5g64BTXEMO+EwcVSMMfTgORBNx8iMx8QDZu3wJmnmbJWAhxtGoLTpRIngXae3LJYoAfwG4BUsjTuChnun2pgLL5KRpryNrJZuZsey4tMQe5VyiQsu48D3SNiD6Q8+YG14k//bixJ1BMfNQM6r3SlWuFm6Ews8cQrTPzUDJ/M6NLUz1yz9w+VXrLLXqOm/9hksgIfb8gZYH7vd/aKyst8kkcTnMqjAA3lwnlDX0A1OS81WMRYRukx3S8sI+WJzXqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soTXftoOZWzSCrILHnuPYDrowf0zvgBTuyPMyqaY3tA=;
 b=vvLWexQv0HWmo5vyPRThkDXt6m986u1fOkd+AfSJTuo2w+H+sgv18ELrhIFjN5hWuU9nuNtbIE0rChdM/cgsJyjiXt6+1B/RHcsVHO0rd9OZWufOQcf1iFjiR7/82BlbypjeYtZ6wmOAkWZgC0RYYkI2hq0R3j3BKXcS5w91iTM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB5616.namprd10.prod.outlook.com (2603:10b6:a03:3dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 21:09:55 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%8]) with mapi id 15.20.5353.018; Fri, 17 Jun 2022
 21:09:55 +0000
Date:   Fri, 17 Jun 2022 14:09:51 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Muchun Song <songmuchun@bytedance.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        catalin.marinas@arm.com, will@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] hugetlb: skip to end of PT page mapping when pte not
 present
Message-ID: <Yqztn/1skXZSNgW1@monkey>
References: <20220616210518.125287-2-mike.kravetz@oracle.com>
 <202206171929.ZIUrNg6p-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206171929.ZIUrNg6p-lkp@intel.com>
X-ClientProxiedBy: MW4P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed934ef0-3da4-43fc-d971-08da50a5ba68
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5616:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB56164E7A1B47280C0D2A0DF7E2AF9@SJ0PR10MB5616.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YPBPnLOm0BOlOEvPEn8hfHzILARDSytAF0MH8OvP/80jjFs0jIdGzexKK30Qd/KNLMU/HXZyVzF9FTlox1lMG92bcU2h8qTpn3MK9OBaqUO7jykW5fDlSz8V5FkYPxziN/0YAOV7KhvJ0v1SEUn0afeSfrUQrOG6IgstX6oCKmqyV8zDBU9BOFKPnzL/3eFRXxnAGwJFGdAMpn/vd8+GYaaN68am5CCdliZrAltMYZbpFdcEezCBab7YqWfzE8guce5AbW7VD3fqOhN8MQvq9rOqMuzBjzjFHfqa5CgSVSfJDsMYHhZrVblgsOnJ87B1RSTZkt1Xi8YN26NPRCB3X7pSchmo5HGbh3NtaHWc/XAJ75ZYnYDeB/oOrSHqKzH3U+RGkCYu53icPIh8JXLWcQF3ZU2AksDLSi3OsjyuM/cnfbw0vapca8P87lktdFGO5d84g8+SxgYx4YqqPWm8X7g8ePpgIPrXYUi4gehPtbZHRH3BBZTAsJ+bcVbWKWK2X4FagFiILlMk4x2vZeG0dRSiqVIFCEsgRxIzZedITuQIfwC9r63GsBoUnnuuCFk+XdRyDIa9vfYohqsegY4no9hqYfzxOfCg0O1bEue6bgWRk8YvAw079ZMJvPuNpnZS56+2LFmlrHtSkqANhZsTOjcnaPpWSVHbc1ASFrvf0KDTD67QJFlFzPTJoTFbR3PHRPBNCOCkreTpFSo7JrTqIPYTWjZjZkWPvs/eSw8vLfwCtYDZ4ofwqtBbu9i2SUbyvBn2nmZ21/6gWF5NmbZiJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(2906002)(83380400001)(38100700002)(186003)(53546011)(966005)(8936002)(26005)(6506007)(7416002)(9686003)(66476007)(86362001)(66946007)(6512007)(6666004)(33716001)(5660300002)(4326008)(66556008)(498600001)(8676002)(54906003)(44832011)(316002)(6486002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z4uTSQfDALWc/54A7i0H7EjCtw8MlpDlsjrCGTEc/tjgqNrn//1D6Yql9ruC?=
 =?us-ascii?Q?qhfVJMCWSMCpUFPZH5qRd2t0ip/7dJTQz3Q6K6ReyofGI4nVgM8Ca/MSjy/p?=
 =?us-ascii?Q?HndkerO+iNzQJvNnWFNFxuDvZR0qCu70+QcHLe4fHgmuiGA9F7PxJH/ty61e?=
 =?us-ascii?Q?wxWHaHNDGYd+iW7fKSq4QHar/v0wn+PlQ/k200QerJsSjlhpR6dQYGlZtITd?=
 =?us-ascii?Q?TqjgXwlrSrc3wf3pFyavy3xjoz/GItL04PNHlrUe4DeKgJXKZodY7kb0igHs?=
 =?us-ascii?Q?pLjQ6nnTjBKyvAb6CFQZwyhIpsjffsdU1r++7uE/RN+DYYcDuO6QzaUE7obB?=
 =?us-ascii?Q?RJBuBJXr0ObCpoGs6/An5kudOk4E+JiZZ78IoOV4vbqILhUwh3+E/vIcx7xK?=
 =?us-ascii?Q?oH8DPpSk88qzvNODQ0w10Ffbpwbzzfp0ccm7AqTxMmwav2DEYhYiLfDaF3Wj?=
 =?us-ascii?Q?aI5g5gqCVPXVhB8Y/Qe9sKi0SQSUcInm2rFMvOxiRX8AK0F7hLfRxaBpLg8+?=
 =?us-ascii?Q?0cIgkOifc6GPA014WQRQbJTYybDW/aHnNNfv7LBJ+50yIZjjZj/5x/hDTwak?=
 =?us-ascii?Q?VHl2U8FyFZ77Lqha4/BHm9lkoxVw1iSp8IM7ZysmW3BPcM+6eLcs0r4ie0I8?=
 =?us-ascii?Q?XpCTtHhoY87bcc3XYbQQmbGfKO0zX2JDXamGqHDcPyBuS7250G93CQ5D08MH?=
 =?us-ascii?Q?HXXhFPc/Gwwo+fq9wLyXTicwMDJ+JvYCNDqw2Ip4PggR/DoUYCNS1hfCpFMm?=
 =?us-ascii?Q?i/Wimptlx6fQvFPa0ZcLOFkA/z56WvNn29efkkMPNX96KCGgksPrKcdEOHus?=
 =?us-ascii?Q?Pzdd2IcX1+ve70FG+L5Ou2CnSOaOvhxI5O8prheATZuEy8rQnQK56Ms7CxQR?=
 =?us-ascii?Q?HM+mnRZK9viF2lP+LEVsua+ewsI+QounVZ9rMPhhXIzkT7O1Dl6hPbc2qeul?=
 =?us-ascii?Q?94F3dHF/EH4gLn2g6ZwbfRkg/+wqC+LE94l/LK9sUWeyqCdFn/CTKlYffc9u?=
 =?us-ascii?Q?qVTd1p7DY+psV4CYaLoNk8vcq/1NCsGat+NJA2Vz6mn/WpZh9ioL0y1TvSzT?=
 =?us-ascii?Q?AY8gwdEHS8pMwI3nRwvoBMVlVsIXddn5IbpKNou92xqxkKL1xiZ3cVrG/8s6?=
 =?us-ascii?Q?8N9wh/tH2wcYp0WbhRgy/a2/3XBIy18/xPx3RFCKJ3k+FzNYMcuBzSB5LVTS?=
 =?us-ascii?Q?yZN0Iuu++QSX1wA38glj5lDWOIIHBnAHCI3tg71w7Qy1WjGEHySGCwBF5rtJ?=
 =?us-ascii?Q?BNIoVvcCGmeg1R3BMXLAcCZvbb2jiwuUKtTGy2NJcflHMveuPdPZrK67sRKt?=
 =?us-ascii?Q?z05aGM35C3XqGqUHjJKhUYZpwPr/rFQUbtnqXkqTQr1CSMpTeTAjUpViQjGU?=
 =?us-ascii?Q?kn5btpKACAUItYzZ49hHm6CbUAXHdn0xH/IqYVDu+3yErR6UAWim/ikMOnb/?=
 =?us-ascii?Q?f4QdcIM+ko+ShKiB5X96FGVI1u8ihAFIayqVgzzrX5Rj20rLje7EaStW2w24?=
 =?us-ascii?Q?p1WCGco3xfX+ZIHL8XdSKHuk5H0LsOXM6Z3lIm7HFAUvTc9d2zRR7z++ZCoR?=
 =?us-ascii?Q?6Hk7Ty/SONNoMJ/vBM/vM1Po0XSXye/tp+NsjEkvVBHUVn6sjUHnzG9zx+d9?=
 =?us-ascii?Q?jJuF/rzYUgngiYuctosaG8WPRqEZzKI/Ree4307M0g5rc2fbIG84yarH56Ku?=
 =?us-ascii?Q?Dhdmtc8vUIlct+NDJsV420tyKhiCJ90ku2ixXrMQerRiEwvyrLz3otpPN/mk?=
 =?us-ascii?Q?zLNetIm5RoWewqg4MKvel5vaFnrakcQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed934ef0-3da4-43fc-d971-08da50a5ba68
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 21:09:55.7199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LeLnEZkshajO69BDzI34H1BKqLRNvD18Q6EgQ2S9Ey6YMnR3VJBPNEv6L7OnxC7TeN19VjQQubhJpRmYpVq4ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5616
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-17_12:2022-06-17,2022-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206170091
X-Proofpoint-ORIG-GUID: ZclqbstJx_QuYZKOXZAU-BqqeLuvILuT
X-Proofpoint-GUID: ZclqbstJx_QuYZKOXZAU-BqqeLuvILuT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/17/22 19:26, kernel test robot wrote:
> Hi Mike,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on soc/for-next]
> [also build test ERROR on linus/master v5.19-rc2 next-20220617]
> [cannot apply to arm64/for-next/core arm/for-next kvmarm/next xilinx-xlnx/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Mike-Kravetz/hugetlb-speed-up-linear-address-scanning/20220617-050726
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
> config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220617/202206171929.ZIUrNg6p-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f0e608de27b3d568000046eebf3712ab542979d6)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/4c647687607f10fece04967b8180c0dadaf765e6
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Mike-Kravetz/hugetlb-speed-up-linear-address-scanning/20220617-050726
>         git checkout 4c647687607f10fece04967b8180c0dadaf765e6
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):

A couple of things here,

> 
> >> mm/hugetlb.c:6901:7: error: duplicate case value '4194304'
>            case PUD_SIZE:
>                 ^
>    include/asm-generic/pgtable-nopud.h:20:20: note: expanded from macro 'PUD_SIZE'
>    #define PUD_SIZE        (1UL << PUD_SHIFT)
>                            ^
>    mm/hugetlb.c:6899:7: note: previous case defined here
>            case P4D_SIZE:
>                 ^
>    include/asm-generic/pgtable-nop4d.h:13:19: note: expanded from macro 'P4D_SIZE'
>    #define P4D_SIZE                (1UL << P4D_SHIFT)

In the CONFIG_ARCH_WANT_GENERAL_HUGETLB case covered by this version of
hugetlb_mask_last_page, huge pages can only be PMD_SIZE or PUD_SIZE.
So, the 'case P4D_SIZE:' should not exist and can be removed.

>                                    ^
>    mm/hugetlb.c:6903:7: error: duplicate case value '4194304'
>            case PMD_SIZE:
>                 ^
>    include/asm-generic/pgtable-nopmd.h:22:20: note: expanded from macro 'PMD_SIZE'
>    #define PMD_SIZE        (1UL << PMD_SHIFT)
>                            ^

On i386 with CONFIG_PGTABLE_LEVELS=2, PUD_SIZE == PMD_SIZE.
Originally, I coded this as a if .. else if ... statement instead of a
switch.  If coded this way, the compiler does not complain about the
duplicate values.  The only other alternative I can think of is
something like '#if CONFIG_PGTABLE_LEVELS > 2' around the PUD_SIZE case.

I would prefer the if else if, unless someone can suggest something else?
-- 
Mike Kravetz
