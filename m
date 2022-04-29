Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF59514C60
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377115AbiD2OLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377035AbiD2OKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:10:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EE45B3CC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:06:45 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TDliVS003733;
        Fri, 29 Apr 2022 14:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=cD9KWXgl0ip9rCoiBlYlMtdzy4SNccw/hhJ/j41Uj8U=;
 b=xp3BgtBJoMY6sr2hAUOFf7FKJBAe8dO39/6om0HDLSruYwUG41wQVzmJJGYiWdshN2ym
 yQfGsxo9oiq6AZsq2tmTr3f9FIcyT/fY+zGkhV2w/ug7cwlLwLgKcJg69uNWCX7Zcp6T
 /Xeh+N66zcaYqobLZ1TczCUoT0W3LhQsvlm+xGHJ+n/3S5SPkb3dLUyn2Qxt8oKCUnfq
 OtKdlRGuFCu6guoO+ATn0t5bpJkRE5P25eUkFdHlaVJwCpGFnv9loS4uGfkXTr0gtAHq
 W4+DsQEB29BySx2dX2khk/r1LI49KU2XOtn/6sbWO8hSUchnIwQJbGTcTIm3BVOXjatC IA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4xd2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 14:06:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23TDq2wW002542;
        Fri, 29 Apr 2022 14:06:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w83n48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 14:06:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htU59u+01Zj7UX2Jnp5+CuQJEEOvu0mdrEqSouDG5jzywGSfy7MKpWQDI8MI0JsC/+CP+2ym2/dTpWzXp8GsInCvr643eIUDbRB+YLhnSx8ECBCH+e8nfgFoQEjBEoOk60k/xkqkZhuWEB2V8/FW9qhOiaUV7GJMVNFdHdMXJ7e6xm30k242ELiK9lNiFYluo6WhfHbR0Fjarq9Yy9FBADM2yORyK7i5CWWA6JwcbsNYKPqQzXmnydMYOIPo7It+coD3Thnz7p8B68NzccYWGpA0eYp04wkKeDIA4CGqu/BWZU3/ZyhKZ3z1br0wSGuk57Lg/PyQFf8kj9iBCZxAxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cD9KWXgl0ip9rCoiBlYlMtdzy4SNccw/hhJ/j41Uj8U=;
 b=Ba02XdJwpiGZNQbK4SSZhhXoOA5FulTrrqIA9RVruyZQ84eBFMsFciOxNquXG6iP9jpQaEi91PYIWHPPj0gG3MLT9mk4NVXK+pyf/UAJyByT+YrUuPsejWAkSgSRhaOAsKrdRDxmW7OUJB0pi3rM79nWg1KlJ1YB9jXMC77YCELWPiLkYTpY2inaDtnYIAInfFPi8W91CDrv9rzxqUXlcF4HSv5MJIzkZoDw8D9HTgXRpSKDJR66mVmqOtBPoZf0mWhs7LRTioP+nYBGls5xoCf/AwgRrZgxvIepXFb9NBdS6i4q2tsWxJESk4eLH5y58cAYbKrXBQNApB8Kpq2D+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cD9KWXgl0ip9rCoiBlYlMtdzy4SNccw/hhJ/j41Uj8U=;
 b=tWYwH07g6+LgMUKt3GJXNuPG3g4Dhedj+hXS2Oi7IWvrwDfnsCcWomKjeQYHe17PLTXEpXn25weqkGeBraY8vr5A3SjgKU0Jbknuj/T13v+HeStcScvvdCg+/92ulzqOkNHXR9EurY/dqIbYFzhDX4K2/j5+5zfUSWqEWy71vXM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB4931.namprd10.prod.outlook.com
 (2603:10b6:208:331::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 14:06:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Fri, 29 Apr 2022
 14:06:15 +0000
Date:   Fri, 29 Apr 2022 17:06:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Bart Van Assche <bvanassche@acm.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [bvanassche:ufs-for-next 6/6] drivers/ufs/core/ufshcd.c:5430
 ufshcd_uic_cmd_compl() error: we previously assumed 'priv->active_uic_cmd'
 could be null (see line 5418)
Message-ID: <202204292110.C5vOQk2e-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MRXP264CA0021.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::33) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 612a84a4-0c25-4747-4836-08da29e96cc2
X-MS-TrafficTypeDiagnostic: BLAPR10MB4931:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB4931E335802A5907A3198F7B8EFC9@BLAPR10MB4931.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1zcHnpbIeklkNG4g127YIk9ZU1Z0YhV1VNn4jZdx3gQ/ciQasXh66Mbjz3rUxf9vOzAeg1nxvrfzNeu/183CoUoAmetnP8D6zBAhnzI7x0OIYnq01fJJyMjummWI/fb2w0VN1M/sq7g3oO1UcjPqLWygWr/XFwcqpgf/GgNWd2WwDA756kKClRxEA11zXAnbf7xY+6Ttx/d95nwuhq26hsjZ9z9WWkIHMyehIbTLqLJLvDRC+jkivRzhzvqo/0YB9ny/eEICRE5DajeH+W4fm962thAzazpvQMpFPelDXtGy9ivcMNpgAzPDhgL+UGiaNlj+NjEnkaFUQMshd/5M/sRxWeANyPgTIWmzZQJFoC2UgCDTTAWu/rxfl4K4Es+wEKKjlDvmF4efnQmxft20cwoLh1bWtlPCFrdYwfehL34T5nNm7wnSew9GQN/7O+SX1JY/j8aqP+nLFkGJHDlzA7wLN8eSEBOn3Wzm5lR5fX7Qq+1crURfGVfurdRhnzRzXN6hNhVLN97OEGtSVY9IDzKV9/RxbIu7MRpGdfX/fmC4THzJeor77nsxzpBBohtlyFBcKRJhjPjQM3GIB8DORFYKWtTpgBg4t8MyfWcduQRlHkqTDE9M/33N/4Td/5P6CBOYIOQ2r8ialAg8q51WWyZcFkKYlOLnmaiFJZo1Dd2RRxBLHjxMvB4HIr++972GvHn1Tvu+lk1W2zMAB7A6pjGsRLhcaPnJVN7/sCyznhU/gaK/OwtXp5dF3C4tKn5IEVzlkjblYJudbhsJVQzpYl2PEffTZVCkM0zNmg+e9yStJGBGhz0Sy6BlCbPHldY6EAlG0EXBdOPyWzraHmITaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(966005)(6486002)(508600001)(1076003)(26005)(6506007)(9686003)(6512007)(38100700002)(38350700002)(6666004)(52116002)(4001150100001)(2906002)(66556008)(66946007)(44832011)(66476007)(316002)(186003)(36756003)(5660300002)(8936002)(83380400001)(4326008)(6916009)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nGXCueMCMFDMsjJj9bE4I0Uc020dXL2jrKZ+HRAE3UC4589URqmcqhxTcmy0?=
 =?us-ascii?Q?Z/dqGEcaYh8U6F7I4g7DINPf1P3K3Mr3SyoIB6p0U9CT8Q3Lx2iWQ5n+TG8U?=
 =?us-ascii?Q?7FSCiQeDMBV6ZogM97eQEj7Wwwo7uwqEg37sUFRtJEAqdRfoGLCPKyW7Kv8u?=
 =?us-ascii?Q?VUkMSB0qPzeCIvXv4UAB1bVMYNbTmeudJ/b0lFpWJ+0Na1rnQYmncK9oYxyK?=
 =?us-ascii?Q?wqbDa0TVBlfraSg80i9po3WFtzdFSBsj9atcTXyI1TC4elzKK//Tto8aT22q?=
 =?us-ascii?Q?+YtjzMAbDRVRePcVxtSuIw80NTQgTqXLhnKfEHsNDpWRlUn0SlBg5PwgUYnp?=
 =?us-ascii?Q?HNOOKa3hAsOuoHnus0wB8TSVxxPIz7V6WhAeOaT/Fzq5kMlM8qOGZFWuymM8?=
 =?us-ascii?Q?VJr+9uekoAbIcLx8Dk4yD+wyY8REG3TOZLwM66QFF8XE2mIZtJ0rDnadUhrj?=
 =?us-ascii?Q?7/YHG30Rz2N3m73zGr9wTVny0dlnmCb8GYgEOlGNymJsJelU6QFwfvRWqZsQ?=
 =?us-ascii?Q?XrZ/rkLVx0T5a6Z1P/vs4OuyBzDBOvQJgCG+bCy2D4WYEW7isr5AUN9knmPr?=
 =?us-ascii?Q?v76iu6Sg+aTrkjlEPaU/00qHgsPhnGYsRw+80q5ggvHyf5YSp8nmwdQ2PLUW?=
 =?us-ascii?Q?8RhFa/RjIq4KXJcLG9M6R+hNcvbmNqMJhPtvKJ/Jquq4lgvk/a4NTT4WF3T2?=
 =?us-ascii?Q?09MpKavZq/GiHnYvM1t0jcwmpySBZoMCHWnMIGcpVvwZmHJGo66UfyaC1r4Z?=
 =?us-ascii?Q?nK/Y45Fm81WVGeqAR/t4OnSvkm07Tj8bgaNtaz53TmJOUlADOjc0Z1vZHoFu?=
 =?us-ascii?Q?ROXpLa5RomigeOPuj5VkvFlirMTa8AGhzaUWchrIoVSs0gg6QQLO9vpMnaES?=
 =?us-ascii?Q?cxaGlpZjCmiK/yE/2OQbVBAxEBL0EWs09PBj8WiVWvKivW4jOJ4GvhXQR0Y0?=
 =?us-ascii?Q?7SlrKFXmbInNAaRCiwntn7vCRoYr9DY91n/64MtLR0GXhjMIvuCLtuSqOFwb?=
 =?us-ascii?Q?fotf+HyjfY7su5S/s0MVff9UhCnihe4Lf9U1rB8TRA6DeT0NeMZGjidVHK9Z?=
 =?us-ascii?Q?z1tS9QQabF6/JN9DW8PhzOurM1YDSV+AoJBKJoS9eHnN4/njgAbrPcDYqZj5?=
 =?us-ascii?Q?tM/MnDgK2UtpSJOr5+XnpphcogSvqBLRIMbDPZAemnMfpU7MLU+FuGutm++c?=
 =?us-ascii?Q?r9RhoKMGnbONruDLnEE4RanItCbgrLbgnFyP1ElWEKi3LqI7sbIH2aJeLlK4?=
 =?us-ascii?Q?klcMGTgWeSZhQ55WeSnKfro0mCF0QlbZC2DlOuIINdehBx8fKlhYxnM7JmAK?=
 =?us-ascii?Q?jl7ZJhNS8E7cPulZaRRU5Ai+/cPglxiyiiVm+Y30coHHLpvp17F9yu5W9aql?=
 =?us-ascii?Q?j7mKGtjU4Vjude0zzfWrrKsD81puWf3wJbyjFWVLl2ZbnoqhwxeqK4eUf58/?=
 =?us-ascii?Q?eAHLbMXYXkHnDAW9I7glOADZRx/CXPAgXRx67hMz163cTcx1XZThgrp0lch/?=
 =?us-ascii?Q?7wuKSd56pWYbGcx2Z3zgzF6rwK0rRv+DgPRSn2rWBYGvUYdUgeEXsLtNVlEo?=
 =?us-ascii?Q?0pioxG1V0QN7a1wDwIU2UTyg41nrRVyWEpefLf5gR6/DZL+HD/u4vEgpWfrV?=
 =?us-ascii?Q?c6Xg77N2MI1OcV/mlWNggWRpBrsqJF2JV26lzUpHD421Zx01nNDa6SpsLSw4?=
 =?us-ascii?Q?yT2NlOw6qkVtCfqsNHTXh2MiyBMtUKs8ZzCm//3I3Fct2hCd+TPM3mVqU20b?=
 =?us-ascii?Q?CXRJ5jU1tSXXSI2UivgCmm76Vr26+Aw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 612a84a4-0c25-4747-4836-08da29e96cc2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 14:06:15.6543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DROpe1eVHPdugP26ibsmyrrNc18Qyz+9CN86ZPTaT+2RkIgRVkqGaIz7cA95e/ro7rBo+dlYXfbrRA+oEPGwBlWTx1BP39cNAZZwR5T7es8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4931
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-29_04:2022-04-28,2022-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204290079
X-Proofpoint-ORIG-GUID: 2sOVkFSObRWpopI9YyWPDkNRwb996VHw
X-Proofpoint-GUID: 2sOVkFSObRWpopI9YyWPDkNRwb996VHw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux ufs-for-next
head:   d34bcd2acd8e932a32bf1aac6296ee8ea8d230d3
commit: d34bcd2acd8e932a32bf1aac6296ee8ea8d230d3 [6/6] scsi: ufs: Split struct ufs_hba
config: nios2-randconfig-m031-20220428 (https://download.01.org/0day-ci/archive/20220429/202204292110.C5vOQk2e-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/ufs/core/ufshcd.c:5430 ufshcd_uic_cmd_compl() error: we previously assumed 'priv->active_uic_cmd' could be null (see line 5418)

vim +5430 drivers/ufs/core/ufshcd.c

9333d77573485c8 drivers/scsi/ufs/ufshcd.c Venkat Gopalakrishnan 2019-11-14  5409  static irqreturn_t ufshcd_uic_cmd_compl(struct ufs_hba *hba, u32 intr_status)
6ccf44fe4cd7c45 drivers/scsi/ufs/ufshcd.c Seungwon Jeon         2013-06-26  5410  {
d34bcd2acd8e932 drivers/ufs/core/ufshcd.c Bart Van Assche       2022-03-19  5411  	struct ufs_hba_priv *priv = container_of(hba, typeof(*priv), hba);
9333d77573485c8 drivers/scsi/ufs/ufshcd.c Venkat Gopalakrishnan 2019-11-14  5412  	irqreturn_t retval = IRQ_NONE;
9333d77573485c8 drivers/scsi/ufs/ufshcd.c Venkat Gopalakrishnan 2019-11-14  5413  
d34bcd2acd8e932 drivers/ufs/core/ufshcd.c Bart Van Assche       2022-03-19  5414  	spin_lock(priv->host->host_lock);
a45f937110fa6b0 drivers/scsi/ufs/ufshcd.c Can Guo               2021-05-24  5415  	if (ufshcd_is_auto_hibern8_error(hba, intr_status))
d34bcd2acd8e932 drivers/ufs/core/ufshcd.c Bart Van Assche       2022-03-19  5416  		priv->errors |= (UFSHCD_UIC_HIBERN8_MASK & intr_status);
a45f937110fa6b0 drivers/scsi/ufs/ufshcd.c Can Guo               2021-05-24  5417  
d34bcd2acd8e932 drivers/ufs/core/ufshcd.c Bart Van Assche       2022-03-19 @5418  	if ((intr_status & UIC_COMMAND_COMPL) && priv->active_uic_cmd) {
                                                                                                                                 ^^^^^^^^^^^^^^^^^^^^^
Check for NULL

d34bcd2acd8e932 drivers/ufs/core/ufshcd.c Bart Van Assche       2022-03-19  5419  		priv->active_uic_cmd->argument2 |=
6ccf44fe4cd7c45 drivers/scsi/ufs/ufshcd.c Seungwon Jeon         2013-06-26  5420  			ufshcd_get_uic_cmd_result(hba);
d34bcd2acd8e932 drivers/ufs/core/ufshcd.c Bart Van Assche       2022-03-19  5421  		priv->active_uic_cmd->argument3 =
12b4fdb4f6bccb5 drivers/scsi/ufs/ufshcd.c Seungwon Jeon         2013-08-31  5422  			ufshcd_get_dme_attr_val(hba);
d34bcd2acd8e932 drivers/ufs/core/ufshcd.c Bart Van Assche       2022-03-19  5423  		if (!priv->uic_async_done)
d34bcd2acd8e932 drivers/ufs/core/ufshcd.c Bart Van Assche       2022-03-19  5424  			priv->active_uic_cmd->cmd_active = 0;
d34bcd2acd8e932 drivers/ufs/core/ufshcd.c Bart Van Assche       2022-03-19  5425  		complete(&priv->active_uic_cmd->done);
9333d77573485c8 drivers/scsi/ufs/ufshcd.c Venkat Gopalakrishnan 2019-11-14  5426  		retval = IRQ_HANDLED;
6ccf44fe4cd7c45 drivers/scsi/ufs/ufshcd.c Seungwon Jeon         2013-06-26  5427  	}
53b3d9c3fdda94d drivers/scsi/ufs/ufshcd.c Seungwon Jeon         2013-08-31  5428  
d34bcd2acd8e932 drivers/ufs/core/ufshcd.c Bart Van Assche       2022-03-19  5429  	if ((intr_status & UFSHCD_UIC_PWR_MASK) && priv->uic_async_done) {
d34bcd2acd8e932 drivers/ufs/core/ufshcd.c Bart Van Assche       2022-03-19 @5430  		priv->active_uic_cmd->cmd_active = 0;
                                                                                                ^^^^^^^^^^^^^^^^^^^^^^
Unchecked dereference.

d34bcd2acd8e932 drivers/ufs/core/ufshcd.c Bart Van Assche       2022-03-19  5431  		complete(priv->uic_async_done);
9333d77573485c8 drivers/scsi/ufs/ufshcd.c Venkat Gopalakrishnan 2019-11-14  5432  		retval = IRQ_HANDLED;
9333d77573485c8 drivers/scsi/ufs/ufshcd.c Venkat Gopalakrishnan 2019-11-14  5433  	}
aa5c697988b4c7e drivers/scsi/ufs/ufshcd.c Stanley Chu           2020-06-15  5434  
aa5c697988b4c7e drivers/scsi/ufs/ufshcd.c Stanley Chu           2020-06-15  5435  	if (retval == IRQ_HANDLED)
d34bcd2acd8e932 drivers/ufs/core/ufshcd.c Bart Van Assche       2022-03-19  5436  		ufshcd_add_uic_command_trace(hba, priv->active_uic_cmd,
28fa68fc557a7eb drivers/scsi/ufs/ufshcd.c Bean Huo              2021-01-05  5437  					     UFS_CMD_COMP);
d34bcd2acd8e932 drivers/ufs/core/ufshcd.c Bart Van Assche       2022-03-19  5438  	spin_unlock(priv->host->host_lock);
9333d77573485c8 drivers/scsi/ufs/ufshcd.c Venkat Gopalakrishnan 2019-11-14  5439  	return retval;
6ccf44fe4cd7c45 drivers/scsi/ufs/ufshcd.c Seungwon Jeon         2013-06-26  5440  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

