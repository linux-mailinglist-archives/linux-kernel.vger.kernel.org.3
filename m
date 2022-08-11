Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263FD58FAB5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiHKKed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbiHKKea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:34:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95A48992E
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 03:34:29 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B95QdI021745;
        Thu, 11 Aug 2022 10:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=oTPGyjE+l44n7Wm0FcerH13Mvrn6SyDRO6YS+XxurC0=;
 b=G6T+u+H3OV11UZhAEszlJyRdhlBGsZn/8KoUNcUR6Gke/1uhcy4SiL/xk3kcuQSNNBey
 uTGcwzqpaoFSoxxa0wdG8aEBT2V/Cs04YemLOxZEuzjsrLvx8QT2L6Bsd+9xqdQYJ0Nz
 aap/RV1b4qZJ+QVwY9TTmbKZEuhM3TVdE3Gw35q0zdHbq+8/hUFZz1a5WlJtHrIFCWqQ
 nce63a5bzueCpiaGFxr9sK1pjus4H0dAdF63ryK1Jm0A8dwB5YSWUTwPRhx7/POq6TM+
 o7owW97o+DaPmIjoqaNom49TJvqs59X9vCsyqZtd6xkcw+VBiMoVfVE6XhCOCFGQ33Bh TA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqj49s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Aug 2022 10:34:10 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27B8oHTc018951;
        Thu, 11 Aug 2022 10:34:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqjyr6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Aug 2022 10:34:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6ApUVLdEqOSL87bAdhDXF3x2w8uE0HIYX8zMPacZ72yEP7cRzbCI39sXZAxZbQhPbG7Xg/qPgF+8m2dwV0Vx7Bo8tO4M0AbcSA+H62vsfZ86QX4gbrE4fAi74y5cVZgUABh0GNvsRGtB50atToQaNurGWO46EZiYvOf24NWDmFsWsOEm8NpM50PENHeehWSyMf/5a6D7+ilQo1mz8SiCJCpghPPPVVfMhiGwt/snruCFGnFMoLgJbdvFxIB9cyGrp4ZLjkcjcVoR6276Zkoy1cqgc0tJ/hyPuE+tSPy0WAR5+YX8SSnQwk/7RkG2DQPafvxTksCyXMnWAr+TNysFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTPGyjE+l44n7Wm0FcerH13Mvrn6SyDRO6YS+XxurC0=;
 b=gRS5wDQZTw5nmho/stHMh/YxJvB6NsGKTG+tEfbsJ5GVpm2sMzZEzaFbO6MIFhhZcOMt7mmfGSpRJvRS1MlKmv0POdgZPc4CqtQPcPVGuxBxLrXsiQyfuse2bIHSWx+YhKSkwLDMrwYgywRmmuBFQIbZO0ZFptL4K63JV4oQNSuKqOkTZrGaVrPE5r6a1GNAnVzsG/5npdRTBaPwfBhJxC/iinWCASgKA7uhs6WARwR4PK/+VHlNrbuxzWnWDdU8AVirlncVckJT9SwYdKi0lcA7AFM0L0LAVtUQzo+0VK8nVSGCIosxnruBPj0fceWILGIb6cWgiW9HWvd6jddoig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTPGyjE+l44n7Wm0FcerH13Mvrn6SyDRO6YS+XxurC0=;
 b=Fue3hohgcxTvDewwsFK5Cd1fjPIcj2H6emINop99fcc/uvHK0Hk/HB11PBK1L2VPSRj6AIZbP9PvBqU21fExuY8rHUEb79ROE9SqAcVSHpzF8rvWqLJI69/2b2NdqbtxA2tQ0QhbQn/kkAA/UWXt0jzP8zK/c/K9MaMOFqjB/AA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB2933.namprd10.prod.outlook.com
 (2603:10b6:a03:88::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Thu, 11 Aug
 2022 10:34:07 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.024; Thu, 11 Aug 2022
 10:34:07 +0000
Date:   Thu, 11 Aug 2022 13:33:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Subject: arch/riscv/kernel/traps.c:48 die() warn: variable dereferenced
 before check 'regs' (see line 46)
Message-ID: <202208110538.uaLOQmBs-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0027.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1839f38-540b-4012-5c7c-08da7b8504e9
X-MS-TrafficTypeDiagnostic: BYAPR10MB2933:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WqCeW61tFE/GCy/GxYyWLA77SIv4ohjy5zEcUTAeUrcVO91nBjzDY0wD9gQPMHUbiWAzeErxm+h5uuZ45xql26Hrt6a1lHbjHezoZeKxuG3tWP+CWs5jGY6OkdjoDWCNriYNjXYIKWvvY4XZL4uSGjVaE2WCitIV5yReERiVL/idCaMjGQ1byXcUqLbw7w+gbc41+dP5+dsOrIn67aj1X09duEuKYBVcFuoXOyawppqAbPG/48HLbhHZGTq5FdecrV/4yCYALZRxUyXt7iLaktjyd/5PRi7NyAxemakNct9d1HepaacUL0Qj1QehjxUKm6c5txYE3eYCNkWhExAq+rlUNB49rTZYD7iU/smGAwCHjCkWGIZbvqh5NzRA1oyqaFhh3RkVC5ucq/Xj7p1wO7XlHu09tJk1b/QoDX905sCSYXOKvyYD+HQi6y5O/zotxP6Ve6T3IMEC3QaKIxMbH9jgsty+iiHPbLPovyKMowqbE+00rq34mgww+HVAf/qNJ0a7UiYL36guEa+6+RthsB44D73oKuFIhPAtKuy/FGTmpHRdX4haIgHZ1EZ5FlYugZwhfvA/dfwWeI0BM/jvdVk751fVrOp6Tqlm7hadxzfSYWxlLrQN5DdhDhQAzeT7VApnLhrAdbeJCyB3pooaICqBNJ926Y3rY1AmFeOYhneSIjj/OA08wkmqB1oxu1S8Xkv0dso101sijFCCCbw3KHbAMSQSphyFq5tPvVRwxQYcvNJkF/oCO5cyFO50j5UU6p22g6jzEdBdaf/vgstzMmMoFGn//N4WeqhE0n+qi9O0833WHzeWlFjcR64TrHnjl3C2M8vy9P7OKu1Y+g0aE5QUOh3leOOR0YxSu5pKKS7AUHmjzNNmPCjSCI/+Xbqq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(366004)(396003)(376002)(136003)(2906002)(4001150100001)(36756003)(83380400001)(6916009)(38350700002)(38100700002)(54906003)(4326008)(8936002)(316002)(6512007)(9686003)(8676002)(26005)(6506007)(1076003)(5660300002)(966005)(6486002)(186003)(478600001)(52116002)(66946007)(41300700001)(66476007)(44832011)(6666004)(86362001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EC54uTtup8OgpfC2Dkf/F6YXldLQWa5AcObAjMhXk2u5jdhQ+szQh5cyyDJV?=
 =?us-ascii?Q?WEImSvDOECSSRPsFr/OhTrL6DQAtFqSwsiNDlfDJ+gS8tq7gy6Gfl/cceepA?=
 =?us-ascii?Q?efYysGTOC2OldOmyyk5aW8KH6QESuPHKPCPqyIEDex+8ZbtPn3QvtP1CIcSu?=
 =?us-ascii?Q?m9OOf6U8k41e7ZFMOBHSoKuORsyaoOPNIV5rKAMfnv7AGfW5DW0npkqwdFdA?=
 =?us-ascii?Q?nsv7P/0wu1QciwiKkzO9Y3uX9DCMBAIpnLK3PLP8QSkrnWe9sgbAZJQwNX+B?=
 =?us-ascii?Q?29W1XaOBi+IGW8mr4OkBWZbiSsjzGqBP+chfcQ571AmVT4v3ydQFfX/5CNmF?=
 =?us-ascii?Q?CXe9l3r3z8ufBbHrrxAdNt6uatuDlK3ChqBAtTnUx16aCnVeIisGHviZLq1i?=
 =?us-ascii?Q?2J+fNt4I9Wx8Y0MT8bvKzQjq+LgQNHDz5eN81UzIosuDOLgMADvo7xymSYvr?=
 =?us-ascii?Q?+t0TVv7V95rFU5j2dVSo7ogvgCfwM/wUVfGlsO9n96mpX5tNpgSAAXu1U+40?=
 =?us-ascii?Q?2v45qsHvRprokEwkNqdLF7VKydfAYh4nDCGBw2EzAtqEBEqrWq20K/s+niYl?=
 =?us-ascii?Q?pr84TITBbYBC/sNzpAcwpvWrvN+dKYVGnI04mtwtO6R5Cn94xox29RKuCmFk?=
 =?us-ascii?Q?onxh6sa8mZVdJXLlvFYA2JvXHRjq8cLTsT/bh7R9ZL/MvUlea8x0HpGv1ybr?=
 =?us-ascii?Q?g8Wo6aVTpT9/y76CGDSmKdhgcDoCsEtxsV9OTbX5QfehWPIuJRpf+loi/EuJ?=
 =?us-ascii?Q?GrPTmeBVz2491HJWa3EgXayX9YrMnfXm0dWbKnwNQa2Mi66Q5jWjMBXN15oW?=
 =?us-ascii?Q?tLofNPpARbJS7foFWLyV4eoOCwLx50l8C1HvP+YjKOZ59DaGjxRhHa9tUv/d?=
 =?us-ascii?Q?zSuXcUargh7fBx1lJ+K6aBiDjzq8Sp/e6+lRjNbNw5iIoNMH3YOBVFeVOeen?=
 =?us-ascii?Q?PHpfXJj5bV2+KxLUI3yvTlc+ZnbVy6OuaXTGv9UuNNUaiE7hteLlGe0++nDW?=
 =?us-ascii?Q?kLilMF0otf6lWI/f4h2GaT+eAogUdNWP3pSVWr4EibfspTKddyDCpaqX1VRU?=
 =?us-ascii?Q?Yg1r6cfDmFhvy/kufmVRexmRqxY7wEjHisLwQvbSV8VT2wRwQtnVUU9PtO3p?=
 =?us-ascii?Q?7yEalJU8dv5aVzBbsb2/71sLnlAKNmkEnMwdC+DZkhf8m4SZO6467mQW/214?=
 =?us-ascii?Q?RazVddBCen18zxeD/gPnHciCmpwADdj2A7u7KINeT5Tygt5BAtUENcFO9D4/?=
 =?us-ascii?Q?hXYiiflLXKxyJy1VdRlpfrxrZn9wXht6mq/VECY2PAEXQBuCicx305hMs8Mh?=
 =?us-ascii?Q?NRxwv1gqqecDLleI7zAzkkIuvrOdZifBhNzYuKCXzfapCZl/ERmHnK1reD78?=
 =?us-ascii?Q?iIorUxL+vOVrJfLGHuUuZh00NKE6wtnaEhM9XJqpDCCw7q/yv9doyzSc112L?=
 =?us-ascii?Q?EZ2b9T3na+1csCF4GeHOyc2FkZP+C4CZhfpRTL9KFi1ifdp5rLyzb8gmV1qK?=
 =?us-ascii?Q?R4uaDwGhwnvI7Sr/QmQrBHFkEjpRD7KrHlwEqUZBxxFFzt6CaoZ5YLKIkAf0?=
 =?us-ascii?Q?ro8b3YcSUS8MN11E3rcLN4v7iGB+ZRstLkf9HAlfMSfWTFA2/uqMmzYB7ky9?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1839f38-540b-4012-5c7c-08da7b8504e9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 10:34:07.4146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIfRVF+o576z+EU5Uxpl6WoDPHZQ7I38yiS7taRve+MQDEeMOugFOKE5E6/TM6eUt7vrsFvDF8OTNJo8LCx1AHcYp9xAKGGQzM5lLrHdHFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2933
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_05,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208110030
X-Proofpoint-ORIG-GUID: yq67-M20uUEGArBOiHRvIdn281TNh8FI
X-Proofpoint-GUID: yq67-M20uUEGArBOiHRvIdn281TNh8FI
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
head:   f41445645ab5d172e6090d00c332c335d8dba337
commit: 3f1901110a89b0e2e13adb2ac8d1a7102879ea98 RISC-V: Add fast call path of crash_kexec()
config: riscv-randconfig-m031-20220810 (https://download.01.org/0day-ci/archive/20220811/202208110538.uaLOQmBs-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
arch/riscv/kernel/traps.c:48 die() warn: variable dereferenced before check 'regs' (see line 46)

vim +/regs +48 arch/riscv/kernel/traps.c

76d2a0493a17d4 Palmer Dabbelt    2017-07-10  31  void die(struct pt_regs *regs, const char *str)
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  32  {
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  33  	static int die_counter;
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  34  	int ret;
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  35  
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  36  	oops_enter();
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  37  
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  38  	spin_lock_irq(&die_lock);
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  39  	console_verbose();
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  40  	bust_spinlocks(1);
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  41  
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  42  	pr_emerg("%s [#%d]\n", str, ++die_counter);
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  43  	print_modules();
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  44  	show_regs(regs);
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  45  
a4c3733d32a72f Christoph Hellwig 2019-10-28 @46  	ret = notify_die(DIE_OOPS, str, regs, 0, regs->cause, SIGSEGV);
                                                                                                 ^^^^^^^^^^^
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  47  
3f1901110a89b0 Xianting Tian     2022-06-06 @48  	if (regs && kexec_should_crash(current))
                                                            ^^^^

Delete this NULL check.

3f1901110a89b0 Xianting Tian     2022-06-06  49  		crash_kexec(regs);
3f1901110a89b0 Xianting Tian     2022-06-06  50  
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  51  	bust_spinlocks(0);
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  52  	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  53  	spin_unlock_irq(&die_lock);
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  54  	oops_exit();
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  55  
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  56  	if (in_interrupt())
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  57  		panic("Fatal exception in interrupt");
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  58  	if (panic_on_oops)
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  59  		panic("Fatal exception");
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  60  	if (ret != NOTIFY_STOP)
0e25498f8cd43c Eric W. Biederman 2021-06-28  61  		make_task_dead(SIGSEGV);
76d2a0493a17d4 Palmer Dabbelt    2017-07-10  62  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

