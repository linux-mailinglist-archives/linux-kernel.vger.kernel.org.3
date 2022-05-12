Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CCB524A12
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352547AbiELKN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352517AbiELKNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:13:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F32D663C6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:13:07 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24C7LOjH010429;
        Thu, 12 May 2022 10:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=2sh6sKqVoXb7YfdzJdEDifGFTCD6HtokVmjxB0EaZcM=;
 b=cdHySTaw0hGh5X5ryJJ9owJHFzAg4qJFGqwqp8INvqg04vBEy2ddQIKahQYIVAXf9K+5
 A97vXly4qY6Gh/pa8COq0CmYGv4frzpMG6ZkTpID06A9Y6nPzB7SsdeeKgOHof/nZYL0
 xuFMDXbV/Un7LipHXbleBY6YJjFg2os7yINsMWSbatEho4rQxPKvbTagh39A1jSE0Kha
 JRba5b7nhYsZQecEBhT8WjuI+gpxvakbQ1LzwtyY8rN/V/8XWi7zB3cputH8rtMC5jqK
 1so3b8bbCe7k9RYpC5Kh9B/pxY9uqiYu2RupB9qpu+zTZvHaEPYXrrMRR6PiTEv9jUyz Zg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwf6cc07p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 10:13:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24C9uW9x006198;
        Thu, 12 May 2022 10:13:02 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2041.outbound.protection.outlook.com [104.47.56.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf75386v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 10:13:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6xQmKpCOr9uEDR/3FQy/ZhGc8ARJbfjGDvQ8lK2nlYrlRAo5+crcjh9SzMqculcthrdhzuViESYtQkuvixbgAtV03O45bpM9CkpjRQO4m0whyOzzfPDjdY2qAiIk9o0NaYQUVWyIB6ZX0BJmESQrB5Pj3gN1NTZWZG0kBNWCCJxCaZ7wAmHDWlse+CeOXfx9n6C2ylqgDlVK/g5Q6cP1/ST4sSYstKLXr0Bh6Q2cvjoFu36QqaXYpezYA5uEcCzAM8+x9WMxer9nfRhu0ntBEVS8wOjiYFttULE5hVx7qkyc2f94XOSjWVsKzUJP7j4F1+7XkE5T7JRT+Fl7kEy6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sh6sKqVoXb7YfdzJdEDifGFTCD6HtokVmjxB0EaZcM=;
 b=m42t2jeIocuxlx2XghcqCfSDkOLQJoADmK+F/MN3AAS0M0XVKNKxriCDsLiK4AlkvrnBXQkCkTxCIZJYl8d65b2yGPXMc2Zuxb8a9gpTgJzlhY9uNwEcrNl0joiLDqGHvnO7k/VcFeHluQIAfrOLCLcod63b1aY8SOAHo98+fvQGRw6UI58Cd2I+0jpSB7RX1mXnNxaCLG7ZIq3gkeG1ncTPlr0PthSUoaCLwz0+GeBk6dWES4UqnC5p84NhLEgEr+fpSvsjoJvJDS4TZMmBcqU2gGzS7CJkEzEPyMqUU8tLJfHp0azJ0gxwxli6oTv6LiVfwvPCknguWwktY5Xn4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sh6sKqVoXb7YfdzJdEDifGFTCD6HtokVmjxB0EaZcM=;
 b=ZRFZkFITRb5SiN2RGmy7aMIARcwZQf+hgt2npKitVSOZwf2388i4VZ+irabopsJ9/ic2VGOJjxoDtmQ1mbXuGZ8N8QwtdHPWNlvIWp3xw0ViJfhyrc6LIc/JcytU5+iwPmHn13JQRUsPGXtc+e4JhgsBuDrjYStgB4C55zLH4vg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR1001MB2136.namprd10.prod.outlook.com
 (2603:10b6:910:44::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 10:13:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 10:12:59 +0000
Date:   Thu, 12 May 2022 13:12:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Allison Henderson <allison.henderson@oracle.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [allisonhenderson-xfs-work:larp_cleanupv4_pptrs 35/35]
 fs/xfs/xfs_ioctl.c:1756 xfs_ioc_get_parent_pointer() warn: maybe return
 -EFAULT instead of the bytes remaining?
Message-ID: <202205121128.R82udPf8-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0148.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f80897f5-bbf6-4503-5d40-08da33fffdbe
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2136:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB2136E6D5FC927D4A4FF011718ECB9@CY4PR1001MB2136.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XRhdVFDVf2zs1vwtcnpRDhXd7ZXjmg33Z/1ijATwz+z5j2HC8E0g6irEppuIRQz7dCzYMJ6kSdRCv/B+RbT0XflR2eGgi0T5OOWquzuhLeU92DZ40B+Gle0IDFvHMnCB8yr9Zvs4TYDGrJF1oqmkkVIg0uju6s5Eqo2FxkFgWhy8vBsGl32HSpdZhmaDQKFJSSkpEw7bpoXDG6Zo9TPNFXf4HhaGYT+8vw1ABGrrWEU7QvUhWq4OwnlpdZcRrynMQFYQB4kyBthnUsjBp1drtuRHhzi9Lqjy1ZCuWnLN8cjbVkCcGW1YRiC0kAnH804B/XazUYgp+TxfXv3CCVLY6ZMYjFQQN5hR2p2zAZmXxtxHxhoKwPzHUxrJLK7RpheTN1bf7vV+4LisNJ8knut3OblAMvLpfsfGBQJ0t6pklGcPG2TiA048L+4L+8+5VjaHR3vLGLD7BUg0iIqotiLyb6XBqZUsKIHI+vF7xJozjupWJwetgxwGBRR3Sk5dZt0MDDCzHNzUtjho7KZCorpy7xsZKo8Q2VB3D/9UmL9/VF8eDv1zGNgakeZ0e73WvxXyiMso3PZL8KZk0gKjreEIRhhxafNtk/fioqRHEXmlpxVdyELLDgV2Fp/8S0yLhOFdLhOdfo3OYuTtzHFRrPoQiWrHhf/holtBJju3zDFw+dKH8tzvC9d+m/jj8NqxqxbK4Q+AnNNHMmAcvpAm/MI+k1aUFMbxDhekv1Rb4VjTcNBHn+T7Dyt17orPD3plsUpYQVCM3Or0Y+cReKn/e9BnZwo/8wrptkX7aeCB1wTLKcQrPNVumUzzjUmZ8hDxKtn0Se+8NJdss49CFLq2Qy0gmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(4326008)(6862004)(66946007)(36756003)(52116002)(8676002)(38100700002)(5660300002)(66556008)(66476007)(6666004)(966005)(186003)(9686003)(6486002)(508600001)(316002)(26005)(6506007)(1076003)(6636002)(6512007)(86362001)(8936002)(44832011)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JYdlWD4Zujnaglo59Bc8qWNwo0YEMqmGtSxqnpDPTSPAi7Pr4lDYo61T5fUN?=
 =?us-ascii?Q?m97qdI4s5X/YAh2UaLkFg/i459YRQoaPlw/Hh8rOA1KrX/uf8hi5J7cqhhGu?=
 =?us-ascii?Q?QOWoUyO7KfieI8rawM/Hq4mLARevaDYR39pXZ2zguqQmgf1lIo+QZwKauUmQ?=
 =?us-ascii?Q?/9n7KxjXBqlgTlgm8Aqz3/BmNNGmT6qKlPlYiKy64gzYMNGkirbv2eMtWlZK?=
 =?us-ascii?Q?5te93DWZ4hQN2gZBlg0IbWirOpOPBhwygBrnMVmCX5ab/uLJkcOl1vNW49CS?=
 =?us-ascii?Q?BDONcAw/bjZqEE2fOh1gaFiDtRa8TMSZS87ek0pAn7O4sGu4olGFzC3Oj5TI?=
 =?us-ascii?Q?q2opGD4AIfqIfeDzmHLbC2miRz5EKkQWfJoi3NxUSE3dcg3Rm+57iN6O/9sh?=
 =?us-ascii?Q?5koZp0xqEsAkFeEJM729qbbi3TjriTcwRTc1/mJcb5TUMkk+1SbgUL0dY3Cg?=
 =?us-ascii?Q?0NTvAtD1jnKA9v31IfTtxB3h1vPwy2OCGBeMKfC0w7vUQyGvselyJQWYtEQC?=
 =?us-ascii?Q?oztAhO4oEqXRDDlcpSNhmzaGuSXsk3HzntPlvDowQ2eN/ig0KKbXneXPcojx?=
 =?us-ascii?Q?/bpFWFYQhTjDlltDgIhqlhqZ4gtzwX0aBMKmU9+2pEPoGmw8Ldg3m8SQW6Pc?=
 =?us-ascii?Q?g/Uribm6AuFnWj2E4ZZ80H9OcEHjtv2xQ3Y4r7wXIerXjx7Cg9Nki+FQz1Ys?=
 =?us-ascii?Q?NOail/6ZQS64uwDxm3r6NNmOuo3H3Fvd6vSaLePmmOcQNLmY5nZBJGNGKom5?=
 =?us-ascii?Q?xYNYcpT6BjkS0/gi528cwh/dwQzmlCy7n1po6c0dA92WfVxdMWZzDRbXrjrw?=
 =?us-ascii?Q?U6NlQiO4sTN1s8j62jpCB7vUl8p23HujoxoHsa88nI/6mkE+7fSnd62uaDlR?=
 =?us-ascii?Q?cFkIqVfvBfWTsKstc5dMlZC83O5uGTLtvf9PyxCbT1p17+PEHRt/pdGdkMns?=
 =?us-ascii?Q?2f/s6JxCToCJuS40uJplF2JGX6Jzv7J/1v2NUflgy64QHMpMxPY0c3h0cpKn?=
 =?us-ascii?Q?mwZ2dcve/RvZkfa6arOmIydcRoya5SMIxJD1L1wLddzlN6+VhU0CjXunmDhi?=
 =?us-ascii?Q?S0slT/NN7MBkMpduEiH3TFsdNH4hGH4pfpOmaTFx5ndTJZorASHa/rrZpus9?=
 =?us-ascii?Q?oLn1p8w/mTBkT/F6VR7YMFLoL20p8T6H5pot0I6ImScU5p9Z6iAsQLkJ60Zx?=
 =?us-ascii?Q?dO9Yrwi8KLN9F3sWXO2w5BAmQQ+k9HBxjDKGPOpJCSYGecIP9Hrv3TGQMrGJ?=
 =?us-ascii?Q?jxnIV2YHtOg0fnWBm82Zl10TihFpQonmr4wtpQ3hyun1IvznLPqBUtrXu/Xv?=
 =?us-ascii?Q?6fO6GJTHQt7y0jf659ltJdzzuE4GqnfEoGGsws8Eb1ejVYyQ6iCpQuc4a1A8?=
 =?us-ascii?Q?TaJqfolVieKqzZyvW6U8XErzrjZc3MbFLLpY8kQXYnz69+9bwxdCz2Elmkgb?=
 =?us-ascii?Q?tcUMXb6aHi9IlGO7WLk5LgLvoDHh4GIrTrjum7MDUEh3MUUMkGrUIG8gSpIn?=
 =?us-ascii?Q?wkWZbinCGh2uQ6FgaWGfzG5SaAfhYAoR02yy0KlrlmqxI94R7eVJvYs1zody?=
 =?us-ascii?Q?nd4vdpxbvrFXlsoYsrrduDp5fLpqNriJr+PpGPTJk2YfS2alhV4WEhsFIDrk?=
 =?us-ascii?Q?9HMlIrZ2zV8oJoSNM0YIMvvPc23HU3lwwp8d8wpmlRlY2eG1xiwA5P9b5OO/?=
 =?us-ascii?Q?x+10eIDkHojPikBvcz9G8y1w2d6DqD/mT6dTnNAOMpx+YF1I6B7cyhBP9uti?=
 =?us-ascii?Q?Dtz+DyC+14B/ADCm63j5Enm8eXseOfk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80897f5-bbf6-4503-5d40-08da33fffdbe
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 10:12:59.6415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kq7sEFdrLxlK6EFWk0BizE/sUQu3+fRFoPcJtafKVM934QOxng6X4qcHsCaq/wb2Tg/8icUFnv7BHbv+wE6bG2obCijeXeFLCvB0kvoE5eY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2136
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_02:2022-05-12,2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120046
X-Proofpoint-ORIG-GUID: KWGLGLeQ8cQdI4kjMhpDe9hB-h195XMa
X-Proofpoint-GUID: KWGLGLeQ8cQdI4kjMhpDe9hB-h195XMa
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/allisonhenderson/xfs_work.git larp_cleanupv4_pptrs
head:   3d7771d8177638d5d115404cbee0b9a77cf0bb4c
commit: 3d7771d8177638d5d115404cbee0b9a77cf0bb4c [35/35] xfs: Add parent pointer ioctl
config: i386-randconfig-m031-20220509 (https://download.01.org/0day-ci/archive/20220512/202205121128.R82udPf8-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/xfs/xfs_ioctl.c:1756 xfs_ioc_get_parent_pointer() warn: maybe return -EFAULT instead of the bytes remaining?

vim +1756 fs/xfs/xfs_ioctl.c

3d7771d8177638 Allison Henderson 2022-05-10  1689  STATIC int
3d7771d8177638 Allison Henderson 2022-05-10  1690  xfs_ioc_get_parent_pointer(
3d7771d8177638 Allison Henderson 2022-05-10  1691  	struct file			*filp,
3d7771d8177638 Allison Henderson 2022-05-10  1692  	void				__user *arg)
3d7771d8177638 Allison Henderson 2022-05-10  1693  {
3d7771d8177638 Allison Henderson 2022-05-10  1694  	struct xfs_pptr_info		*ppi = NULL;

I would just declare ppi on the stack to void the krealloc().  It's
not a huge struct.

3d7771d8177638 Allison Henderson 2022-05-10  1695  	int				error = 0;
3d7771d8177638 Allison Henderson 2022-05-10  1696  	struct xfs_inode		*ip = XFS_I(file_inode(filp));
3d7771d8177638 Allison Henderson 2022-05-10  1697  	struct xfs_mount		*mp = ip->i_mount;
3d7771d8177638 Allison Henderson 2022-05-10  1698  
3d7771d8177638 Allison Henderson 2022-05-10  1699  	if (!capable(CAP_SYS_ADMIN))
3d7771d8177638 Allison Henderson 2022-05-10  1700  		return -EPERM;
3d7771d8177638 Allison Henderson 2022-05-10  1701  
3d7771d8177638 Allison Henderson 2022-05-10  1702  	/* Allocate an xfs_pptr_info to put the user data */
3d7771d8177638 Allison Henderson 2022-05-10  1703  	ppi = kmem_alloc(sizeof(struct xfs_pptr_info), 0);
3d7771d8177638 Allison Henderson 2022-05-10  1704  	if (!ppi)
3d7771d8177638 Allison Henderson 2022-05-10  1705  		return -ENOMEM;
3d7771d8177638 Allison Henderson 2022-05-10  1706  
3d7771d8177638 Allison Henderson 2022-05-10  1707  	/* Copy the data from the user */
3d7771d8177638 Allison Henderson 2022-05-10  1708  	error = copy_from_user(ppi, arg, sizeof(struct xfs_pptr_info));
3d7771d8177638 Allison Henderson 2022-05-10  1709  	if (error)
3d7771d8177638 Allison Henderson 2022-05-10  1710  		goto out;

copy_from_user() returns the number of bytes remaining but we want to
return -EFAULT to the user.

	if (copy_from_user(ppi, arg, sizeof(struct xfs_pptr_info))) {
		error = -EFAULT;
		goto out;
	}

3d7771d8177638 Allison Henderson 2022-05-10  1711  
3d7771d8177638 Allison Henderson 2022-05-10  1712  	/* Check size of buffer requested by user */
3d7771d8177638 Allison Henderson 2022-05-10  1713  	if (XFS_PPTR_INFO_SIZEOF(ppi->pi_ptrs_size) > XFS_XATTR_LIST_MAX) {
3d7771d8177638 Allison Henderson 2022-05-10  1714  		error = -ENOMEM;
3d7771d8177638 Allison Henderson 2022-05-10  1715  		goto out;
3d7771d8177638 Allison Henderson 2022-05-10  1716  	}
3d7771d8177638 Allison Henderson 2022-05-10  1717  
3d7771d8177638 Allison Henderson 2022-05-10  1718  	/*
3d7771d8177638 Allison Henderson 2022-05-10  1719  	 * Now that we know how big the trailing buffer is, expand
3d7771d8177638 Allison Henderson 2022-05-10  1720  	 * our kernel xfs_pptr_info to be the same size
3d7771d8177638 Allison Henderson 2022-05-10  1721  	 */
3d7771d8177638 Allison Henderson 2022-05-10  1722  	ppi = krealloc(ppi, XFS_PPTR_INFO_SIZEOF(ppi->pi_ptrs_size),
3d7771d8177638 Allison Henderson 2022-05-10  1723  		       GFP_NOFS | __GFP_NOFAIL);
3d7771d8177638 Allison Henderson 2022-05-10  1724  	if (!ppi)
3d7771d8177638 Allison Henderson 2022-05-10  1725  		return -ENOMEM;
3d7771d8177638 Allison Henderson 2022-05-10  1726  
3d7771d8177638 Allison Henderson 2022-05-10  1727  	if (ppi->pi_flags != 0 && ppi->pi_flags != XFS_PPTR_IFLAG_HANDLE) {
3d7771d8177638 Allison Henderson 2022-05-10  1728  		error = -EINVAL;
3d7771d8177638 Allison Henderson 2022-05-10  1729  		goto out;
3d7771d8177638 Allison Henderson 2022-05-10  1730  	}
3d7771d8177638 Allison Henderson 2022-05-10  1731  
3d7771d8177638 Allison Henderson 2022-05-10  1732  	if (ppi->pi_flags == XFS_PPTR_IFLAG_HANDLE) {
3d7771d8177638 Allison Henderson 2022-05-10  1733  		error = xfs_iget(mp, NULL, ppi->pi_handle.ha_fid.fid_ino,
3d7771d8177638 Allison Henderson 2022-05-10  1734  				0, 0, &ip);
3d7771d8177638 Allison Henderson 2022-05-10  1735  		if (error)
3d7771d8177638 Allison Henderson 2022-05-10  1736  			goto out;
3d7771d8177638 Allison Henderson 2022-05-10  1737  	}
3d7771d8177638 Allison Henderson 2022-05-10  1738  
3d7771d8177638 Allison Henderson 2022-05-10  1739  	if (ip->i_ino == mp->m_sb.sb_rootino)
3d7771d8177638 Allison Henderson 2022-05-10  1740  		ppi->pi_flags |= XFS_PPTR_OFLAG_ROOT;
3d7771d8177638 Allison Henderson 2022-05-10  1741  
3d7771d8177638 Allison Henderson 2022-05-10  1742  	/* Get the parent pointers */
3d7771d8177638 Allison Henderson 2022-05-10  1743  	error = xfs_attr_get_parent_pointer(ip, ppi);
3d7771d8177638 Allison Henderson 2022-05-10  1744  
3d7771d8177638 Allison Henderson 2022-05-10  1745  	if (error)
3d7771d8177638 Allison Henderson 2022-05-10  1746  		goto out;
3d7771d8177638 Allison Henderson 2022-05-10  1747  
3d7771d8177638 Allison Henderson 2022-05-10  1748  	/* Copy the parent pointers back to the user */
3d7771d8177638 Allison Henderson 2022-05-10  1749  	error = copy_to_user(arg, ppi,
3d7771d8177638 Allison Henderson 2022-05-10  1750  			XFS_PPTR_INFO_SIZEOF(ppi->pi_ptrs_size));

	if (copy_to_user(arg, ppi, XFS_PPTR_INFO_SIZEOF(ppi->pi_ptrs_size))) {
		error = -EFAULT;
		goto out;
	}

3d7771d8177638 Allison Henderson 2022-05-10  1751  	if (error)
3d7771d8177638 Allison Henderson 2022-05-10  1752  		goto out;
3d7771d8177638 Allison Henderson 2022-05-10  1753  
3d7771d8177638 Allison Henderson 2022-05-10  1754  out:
3d7771d8177638 Allison Henderson 2022-05-10  1755  	kmem_free(ppi);
3d7771d8177638 Allison Henderson 2022-05-10 @1756  	return error;
3d7771d8177638 Allison Henderson 2022-05-10  1757  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

