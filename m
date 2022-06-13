Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDF0549943
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238280AbiFMQqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 12:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240829AbiFMQpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 12:45:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52DA4B847
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 07:34:01 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DDYwIu003920;
        Mon, 13 Jun 2022 14:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=S5l8wg5tRm5QQKoWmr2wequzjrVvZN3qTYBiJObE710=;
 b=qyF8P/hzBGtMRriWM0K7R5uXhCNq8X7sTre82XA++a7VRXF8lyzGDjkVaGG0w8Tbz6MO
 0yyS8PJ/HpIe9vT18ptdLWhPuia0RWLE/AnXEN5hAQ2a5DdkH7ZJ49rRbq92G97UJ17u
 yMMcf1sbMlWrElGSYoDSauj5eg/Ive7WFl5TrT2w5uKA5C1w6PMJ8T3wguvr/ca6fS/O
 ku5/cUcVVxDCNgxrLqjlnKOj2Sc+M9PEMJcUNWeVewg376g1FwOzMLBj6vfNDV7OWkAX
 La7PXiJB1+fd3dv3a7q46BFdpQ+aOi6hSPPfchcQgDy91sXbXFo8bNlyBY8n/tP2V3YY 5w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9b855-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 14:33:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DELx1N032436;
        Mon, 13 Jun 2022 14:33:49 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gp6xf0b5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 14:33:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bb8pqcjAsxwmmQxlZAVHsSpzy00dps53FPAWAcTSfMNRom55x/lRx0jC9Y7hWtsD7scYcmL4rhZ9B2REWVQBLyATa0Yjx7U/3kO/MlqFr4gsS9gFuas1OBetmudhSjL6VZq7h+R1ennHUgZzsA55VoRlfxbVHn8rOhpDp6Pb8YtI6/qsfQT+50/FSxUDE1GBmXHjS5wuvhH260HlSYJFV/X9Ex8qqkgQKJXkK3oF62zMUhNRZg+zW9A8CQPef8/vAMOhFOQWOkrRFU8vIWAc0tPbQ0646vXNLrmINK2sAj32wjAcmsKb20ll/ms99EJC1wRVIQ2JE2evWo3XOspZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5l8wg5tRm5QQKoWmr2wequzjrVvZN3qTYBiJObE710=;
 b=cjO+pEKzF+AyjzQ5S2X7vDsmOeo+38HjOm1iqIDllofO3jBNvlK3BA6fHaKlJLPDmdgwCa1sPVcT0Qr5403NPq33JRlHcd2jkqVPWk+GWzlJ1TPyQDmmquRtSnEbVIi7xs57P0mxYdZNAPmQaOdkLPGM0Ur+GSVI5yz65fx8P7WJNaem6MTUrGPybmfxcq3U4KsOzNC9d/B6Mxd2blx+AgIGTwI85dlQF1FlR4HrRo7dL9sGHdLdkgwY3TIkG4bYCcuglTGZUhRMLhprOVL22gn0bIX/qko2i2GbBDmBJUFDB3TA7Ga7v8k1hkHG5IASxKLI4rMv41DRc3XFJDthog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5l8wg5tRm5QQKoWmr2wequzjrVvZN3qTYBiJObE710=;
 b=b6/G1oVovbbPQJ4drEb9OqHdWffMJvmeXc/oYVm+wnRIgJgSq0hYA5j8HxHomOrAIRkAyF5lJx4LRxrFWWgb3YirNBqMw3yJeb0cyyitVe8NTc3PN0i6K8HtNULbIZ5sAoNYYp/MWIbACUkLgEP7PMj2/4YumYrHpiFF5Ew/JdU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1371.namprd10.prod.outlook.com
 (2603:10b6:3:9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 14:33:47 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 14:33:47 +0000
Date:   Mon, 13 Jun 2022 17:33:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Haren Myneni <haren@linux.ibm.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: drivers/crypto/nx/nx-common-pseries.c:1146 nxcop_get_capabilities()
 error: uninitialized symbol 'hv_nxc'.
Message-ID: <202206121940.30TYe8Nk-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0166.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0bd0cff-5c99-4770-0a4a-08da4d49ba04
X-MS-TrafficTypeDiagnostic: DM5PR10MB1371:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB13713EE07651A57C8B9047738EAB9@DM5PR10MB1371.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YvbrjlGeOUYv5mbVpsi/yBXdHHPSf3+18cAHoD+hzLrsQolqZ3AVIvW+zecpmA5nPnP7OYv+n2e+g3b+3qIwVKaHPYsH3BzRlZHxqMy0Wr8EZft7bFo57DIedDtRyi+sxjz385tB4+MyJQg85qkJhQyhFYpGeNP0WkWYOf+reZs7i3SNrfAu0RsMGrZJaJ2KR26CJIYIymTCCIQFcIrIq0bwQhe/PxNw7dOlDgCEvRBFPT09NERqCh9daXOOihUUqPUPHCIdPNZJg6UMDLtHZsFVOBUmHFl7jbZjV5Ovv+71ebTuBo2QNxvwsjKCdDxiymocoE008O0tHTfigwLMsKK017y9++CZ8yER1JSk3SMnxNyt3pwSYwGrmdewN82BeaM8KjYF6zja0lhxoRA7WHW7ClUg9Jkc1qABKxABvWaqu3tYIoXGUFTLdFsJ7LJw7KwmiSktbK/M+q51La72B4Q+xeSkO1naQMPEZXQIumJb5HfmxZDgwJXKmwmdnbqm/Meg9IXlisqYojWhihJfmqXCj5UrC4GQQnlBAQ50uTjCeSxUpfmRm80+iZZrG1XhEa3T68z6FsiU2OmpBwLuWhRZLOVL76JmIkKgbWvljEsMk3EDZPGuQk4y01TAslJd/dsA0eU4iLEjdUJGVq+n1qjeqKaKrF+VoSXiZFwXIwo9NydZO+Mxp1e3eRg193WT/+OQZNthzY58Kp/e3nhqoHAZyXHDKIZCoMNOeYewtHiccJJQoglJOPAlcdXavemG+LvwJbLjkCVwy4mc/VB5z6du7zMmr2ZQPuD2vHvIcHskJuaQb6wqK+k3aiK75if6UkjVFNcdle48RqHZqE8WcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6916009)(1076003)(38350700002)(36756003)(86362001)(38100700002)(9686003)(186003)(4326008)(8676002)(6512007)(66946007)(26005)(66476007)(66556008)(316002)(2906002)(83380400001)(6666004)(6506007)(52116002)(508600001)(6486002)(966005)(8936002)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZTqTR6MSNtn27MlMJO3/wzIEQ/kUwtbGw1IvV2RS2+6F8TPXkIgXYJevGuFf?=
 =?us-ascii?Q?bc/2y14zT+ZpU22BBvx5TF6RwV0ZNrHWCHZg+oEGmsh79NW1yogQUjkCqvh0?=
 =?us-ascii?Q?tyPT4PfQ/DivDjgIRKboMyrW6Z+l7ysVUM9JQMBjZ/tajxxQJRql18A/5Mhy?=
 =?us-ascii?Q?bAYAkUM+KgwC7WIXpNamrZmOcbGGFq2J/RuOQFcnxpJyNV62qxUA3kr+wlsL?=
 =?us-ascii?Q?gLirkmwIsCcG0RwJUp71ZjGPNBbplLzfzxtO5C9myFcwhtaB/TmjhgRPtola?=
 =?us-ascii?Q?Xx2kR7TkWDbHYR4gQdIV8MgVEJ/1SNF3QNU/m1GIffOirXEeX+wWcrAM8a/N?=
 =?us-ascii?Q?WGjvwNFnUOOyNyXkIrbfN0X49jrCkVs+MPcgZkWHRFEWNstjddXQR8Eqbc2q?=
 =?us-ascii?Q?BUcJr8Sb3i6Y5Zj7irDAV+nTTUhG7T0zLdlS45Z+mbPLMvwxaM1nabXY4eWg?=
 =?us-ascii?Q?II1B6YdMTrAfoUB2k04clJkciUYILOG8UZAZwMojV9tZUekTTSJ4dv03Wj6o?=
 =?us-ascii?Q?88ukv9Cj5PRKzBybBQ3NDG7JdkHulSyI4CCcUPd6S+KWheUcX9BDdInmNkNI?=
 =?us-ascii?Q?JE6d/ah07+K/LYVRM21CUzGb3n81FdSNEiXUPvATw1XZGXKMgRIJ4lPpYI7N?=
 =?us-ascii?Q?Ih8egeDU4W3RZaB3WpLxlUgZaXg+WuMug1LMddLxCjbswTjH3hLphjeAKST0?=
 =?us-ascii?Q?0Ao7+P9slRxeMKYzScv1JdZHaX0IpadN+0epJdf6eGKM7hZdsOQtX6vrqTtc?=
 =?us-ascii?Q?VEhb2yq2gNJHCSNaTy77X7G0X8laRWpJciEmVPbfRxS1nHfE1C/fkRQAHcbA?=
 =?us-ascii?Q?kV9/qdCWPiGlpNpUKFJkMAl/j9iE8WTkbLAHVmhq4Rju6P/YMlmci7MoUdVi?=
 =?us-ascii?Q?dM/2M3xMQQ0dN1GU0/eiSErfK0uCO3buKJlLwc2xFqHCrNcCI77+pvLDzURD?=
 =?us-ascii?Q?BHViz55VsMqpf62rZF20yUEdDKzzn6hbEk/uhtmGiV2HKYIGcJT8e3C4Fl5p?=
 =?us-ascii?Q?gKYOWSbAOv6Of1/zBemySFcqcZc/7lrqaIUrrgS5qO+LtLLXJxs4VTsZcyAd?=
 =?us-ascii?Q?M9y1ho10+M4l30Oa5rvLeSHw4sd2rXo1kbjHNzjT+S/ID0qBrLMRz6dhpyl5?=
 =?us-ascii?Q?lgJONdcjndwGUHgMU3J6Lb7lMsTfs4VREe3rZ2iAYP6QOlJR6Ed5oGgNNGQa?=
 =?us-ascii?Q?0hLVkj0Sek65fbfP5eOGvYtwjmxGgb6CFStTGjLWaZNpJMcJmp4qYY5oUOC7?=
 =?us-ascii?Q?MhV86bGoGjR4tTz7Vfqak//HjTdMbnt14VtM9SLCmbzu9kdCWT5a950DNT7P?=
 =?us-ascii?Q?ycABf1DHtrB+02wHKrcvl9EiVyHB6VD5PuTt+D/fHpc8+wiZFmBwCyxPFcpa?=
 =?us-ascii?Q?tbbl1QodGvWU/dVF2OfD7UHg/NTW7WnL+OnXtiGY9oAyK4BiM9X3C46bQqbB?=
 =?us-ascii?Q?0MA1dGasnfDY59yUlLtJXOBvVTBPOm36ya7iJJAd7pn1w+56pUJ9ORPohXYo?=
 =?us-ascii?Q?+C0uE9bCJZgJVe8Efxy8EfBQHtGRbtiiPJMxBoUTnzsW1u7zjXC9eIOivjAT?=
 =?us-ascii?Q?Wru9XZGE6E9oR4PEvF3rj5HDbK8sW2lmV3pKY4BFl8hLN0215qy2qXq/dSCC?=
 =?us-ascii?Q?XCfavyL88VbzYfa/OUWJVR1ddtt62dNtaj//t++fcnW+PfseSBMWF9tCEBWg?=
 =?us-ascii?Q?pJu+R6X+8YvRZkpU72OMFV/9PDxo6l/lSGpUymjRvt46cDOuDGPgxmPDtV0D?=
 =?us-ascii?Q?BRqLdx/X3wBnmBwxetcJTX/+XpnDjTg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bd0cff-5c99-4770-0a4a-08da4d49ba04
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 14:33:47.6530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhrzRL7AiHAjo1cBVccQ+bRSJsQ3/THNjWNzn1TADViGbWMK9WqEUXcRMLPk7II2cK6pyKZq6XLNilRpg8p8+YCYqpwjItEkDBAZiKwkYYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1371
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_06:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206130065
X-Proofpoint-ORIG-GUID: 4MSOEMB2Wy-YZTn3ZkMcG170U1NgdmnP
X-Proofpoint-GUID: 4MSOEMB2Wy-YZTn3ZkMcG170U1NgdmnP
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0678afa6055d14799c1dc1eee47c8025eba56cab
commit: b4ba22114c78de48fda3818f569f75e97d58c719 crypto/nx: Get NX capabilities for GZIP coprocessor type
config: powerpc64-randconfig-m031-20220611 (https://download.01.org/0day-ci/archive/20220612/202206121940.30TYe8Nk-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/crypto/nx/nx-common-pseries.c:1146 nxcop_get_capabilities() error: uninitialized symbol 'hv_nxc'.

vim +/hv_nxc +1146 drivers/crypto/nx/nx-common-pseries.c

b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1098  static void __init nxcop_get_capabilities(void)
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1099  {
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1100  	struct hv_vas_all_caps *hv_caps;
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1101  	struct hv_nx_cop_caps *hv_nxc;
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1102  	int rc;
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1103  
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1104  	hv_caps = kmalloc(sizeof(*hv_caps), GFP_KERNEL);
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1105  	if (!hv_caps)
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1106  		return;
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1107  	/*
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1108  	 * Get NX overall capabilities with feature type=0
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1109  	 */
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1110  	rc = h_query_vas_capabilities(H_QUERY_NX_CAPABILITIES, 0,
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1111  					  (u64)virt_to_phys(hv_caps));
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1112  	if (rc)
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1113  		goto out;
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1114  
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1115  	caps_feat = be64_to_cpu(hv_caps->feat_type);
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1116  	/*
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1117  	 * NX-GZIP feature available
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1118  	 */
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1119  	if (caps_feat & VAS_NX_GZIP_FEAT_BIT) {
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1120  		hv_nxc = kmalloc(sizeof(*hv_nxc), GFP_KERNEL);
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1121  		if (!hv_nxc)
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1122  			goto out;
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1123  		/*
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1124  		 * Get capabilities for NX-GZIP feature
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1125  		 */
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1126  		rc = h_query_vas_capabilities(H_QUERY_NX_CAPABILITIES,
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1127  						  VAS_NX_GZIP_FEAT,
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1128  						  (u64)virt_to_phys(hv_nxc));
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1129  	} else {
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1130  		pr_err("NX-GZIP feature is not available\n");
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1131  		rc = -EINVAL;

hv_nxc is not initialized on this path.

b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1132  	}
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1133  
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1134  	if (!rc) {
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1135  		nx_cop_caps.descriptor = be64_to_cpu(hv_nxc->descriptor);
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1136  		nx_cop_caps.req_max_processed_len =
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1137  				be64_to_cpu(hv_nxc->req_max_processed_len);
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1138  		nx_cop_caps.min_compress_len =
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1139  				be64_to_cpu(hv_nxc->min_compress_len);
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1140  		nx_cop_caps.min_decompress_len =
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1141  				be64_to_cpu(hv_nxc->min_decompress_len);
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1142  	} else {
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1143  		caps_feat = 0;
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1144  	}
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1145  
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17 @1146  	kfree(hv_nxc);
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1147  out:
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1148  	kfree(hv_caps);
b4ba22114c78de4 drivers/crypto/nx/nx-common-pseries.c Haren Myneni  2021-06-17  1149  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

