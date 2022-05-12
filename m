Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4763525740
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358852AbiELVrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbiELVra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:47:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490502DA84
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:47:29 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CLVQPe003190;
        Thu, 12 May 2022 21:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=7xGEGrhtekoMbDa61k6WnBSIndaw/ZcLhv3345DvZdE=;
 b=cRCZhEN7+yNLIK3Vx4W72D/Osks0SHozgIAxJ9grdjZ0kfTX4s6IZyqG3bSXJIbLL80m
 UXIt61+9IDZGlS6XA0AuALvIAXYFqogA5wFVns2/8uyRHAZVS/GxwZpiAq2X8tNT7nsy
 nFsG+0FYTdU6ici+NbQaBMJRLowIVZ51I2CiV8ITbBNIHOF3LYllD1Rr1Y3vhthAtG9Q
 Jw6YxppJsg/BVJYVYhojQLDJIRhrUcLZfVQJLAFOMWuQqiIcwGRpRMwBZjZSTMeaaE38
 gvTGrGqDDmhjeFIulwoV4A7E5wvCSQXHfOf/tnNV+KQt/11NZpv3CLuDYci84RIe28qm 5Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g0a04n2hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 21:47:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24CLgIkJ004728;
        Thu, 12 May 2022 21:47:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf7c98s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 21:47:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSgLqMKpvRdA4qzsSCNc2BLA7efBdfSkDRwr14rnjj5hMN+09KWzmWREAsHGc/7CuEkk35ZDulb+LzRSfZb4kYoCu6Jm4xb6hh4vd3m7OQRbKanloBT3Ifo2E5ivNgn3gbew9Knq7+861+IQ74ugoAyublIzOUgQ7czZ7Okt5pFWA7enGUD5WA3Q1ePtykeO4lHACW+Uv/HWQpeS3BoaqrAiqhNOMX6V1eZUMFCetw4bzAqbGC82IN1CjgtBXDwRowNbxLymTHHrA85E9NZBNnKHmaWncZgDzqAzoffwABNQHc4N4YJJ/SoiW172awt8L5kTe5LmKJRwXmKDbrAj1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xGEGrhtekoMbDa61k6WnBSIndaw/ZcLhv3345DvZdE=;
 b=AwNJdkPFga0ybnK+5JpIzoZ09QVRSWZyY38sinA1F1U7XP2umI+0SSmwgLfVlrZNMNpCyPqe8MP6tITeN/wLOAozXmczM8D/1qxjKxRS+L5IWQXh81yK/bG/O3fniNO6ExBk7AlHJIrbog6Gb/JgpZ6g4sc1QV5H8ohuhnaONp7fWpAH8Sx553x/t36Ci6RvwYKEvARh3MLlTNyagX17mSSkn+r+TxV87MECO3wUI4EA82wx2ziX+iHeeefIFtikxwiMw6d0ULOcF3ZI0M79sIVK1dQVeh+qkxe3HNdfcfIRWk3pJ6DT2I/2OqPicY4+WczDLjilVfT8P6p9x8jB+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xGEGrhtekoMbDa61k6WnBSIndaw/ZcLhv3345DvZdE=;
 b=r18DdUfj377vy5I55o2KmnyeOOKV9zlDIMiymwpgxDN1ZMlg9dS25aTP2/7dFShMKbIo3tlbPs9m0ZHZulyf9WloxY1W5Hr0p/zFCAGi/YGfAcFPjbxTS4D+pzJ3Jat5hf2rOULgQVkjKLN/s0WmQmIgmFTn7LgRfc6jnZh++lk=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 MN2PR10MB3311.namprd10.prod.outlook.com (2603:10b6:208:121::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 21:47:12 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 21:47:11 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: [PATCH V9 0/8] Use copy_process in vhost layer
Date:   Thu, 12 May 2022 16:46:56 -0500
Message-Id: <20220512214704.104472-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR07CA0089.namprd07.prod.outlook.com
 (2603:10b6:4:ae::18) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8163b4ac-3864-496e-05bb-08da3460f878
X-MS-TrafficTypeDiagnostic: MN2PR10MB3311:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB331112A4323B45A977C90038F1CB9@MN2PR10MB3311.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B0sAXOkb5e6O6ORUy4vReSqUfypb1086hZBH1GMZHWlZJu69aWAiSeAR4A4LQapHovlPblcqZ1FwXTEKWm5DHpnTc5Fqp3r2oWfBkoTd1SBYwUla+HDeBfsjaQ1AUmwNvRlErHCTgyzKm2i46zCriyJ/vxyq9dosOfqUgYBoNioig1DBVTFoLLA110x9Vsfsl6j45wwS0of86J1zzJTOD/QI2XA5/QRQgYVGapOZJu0bm60tVZSLSjRIu3ifzsdLKJiWN2Rq9AiQhYLl/yOo5c/UYhLuzCTCylDBoLfMdz2wP5rHZcSLfqNwmKZoGvDvcMMxpuRstg5jWARBH90iMT+2mt7StZCl6fqD2sHFioXFtqy9CZfx12kT37hgDq3rGL+9wGNVUYdK1Jo/6qZA2i9/ej0zC/vfx6oK8B0IFR2O6FfMm+zEK42oMbqajBSZQPL4XN54Kz9QUomtL01MgXBU+IHg6rvtKvBwlbUX7YBr0t9EJLbo99zm8vR/PScs0NJ9YLxSuhvSnVRlfTLDkjsV4em4z7qGzVlA2y6rJQHIER8eReC1vSZW4pgXWn3JZp/YxUK7bloNDrgSmJYL0fDBMf+4VsyQHrFEfXh5bQeM9DnenEaSOt2x6XD6svVSe6nd24HYrGinC3ntJkbyJGlMCFYIZS2U4OTGjoN+ofQq5Gck1rrXOAMVvlorTpKxDxMfb3ZbA6mPxPdWOypdbTPMTJ5iBU7quSVifsyVHpXuiyBoGorQSSrSqFbcX7qVLJ0PBbRajOVXTnKmASFMRlrbTo5YqmKVcCDXOfpOaw4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(2906002)(66556008)(66476007)(316002)(66946007)(508600001)(36756003)(6486002)(26005)(6512007)(966005)(8676002)(6666004)(6506007)(186003)(38350700002)(38100700002)(83380400001)(8936002)(2616005)(1076003)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PtpSNr/aGRrJFCAQ91jkCoY/ZZeBMfDLGu0XUS0lS/M4ul+bcXAswlzZlIld?=
 =?us-ascii?Q?qKRnyh8X1SPtCDeUETsK/XHrOKH4VmdRdEfv6Bu1+mGxkfu5RLL6oC+t90YS?=
 =?us-ascii?Q?luLFDdVHwJfEeL8xPIjmRTFMcDSjO96Pm9UrogibNi86aqdd7FStIUsh/iXD?=
 =?us-ascii?Q?cBxPhp/wxQ97ZEVR3Bi3WianOoEbuLfu0yMpPIcNEfHQpWqimcU7NE7EXy2a?=
 =?us-ascii?Q?Z+Lr5zVBJMdBCeZ8A02UigkPZT7f3qG7vNzHU/0QCPQZy0q50CIKPbNKudtk?=
 =?us-ascii?Q?dasJVISxEvww91BxWTlpeKKD2vF2Z+OoYl0d8KLihjEG6yf7Ln8vNtfZqSG+?=
 =?us-ascii?Q?qyIq0GxnMtnOgyfTFy+6siIAQuPkbkfW81maGTMHZ/Mmo+ZOTHNV22qXF3DL?=
 =?us-ascii?Q?zmYLXnD2WNZ2JtncU5AzAz2wiI4ynu5/cRAe1vXWFrHB4MEpsObYFfyIfXI/?=
 =?us-ascii?Q?B6+lvbvHpUGpWOBtk4eibAgNEf17A9CLO613blCGG/d6u1v3JIrUA3BZdmZ7?=
 =?us-ascii?Q?Y0XkGrw3byt9DB4xhLEx4hnWxD9+E09heKZz+MClD3o+GsIIROZk9vSvd2Bn?=
 =?us-ascii?Q?VaZKAu/ZgoEuvBz0v4Rl1l364V5wDPafe6ONZlRMA4+CVkroRNdNDDbwAWZO?=
 =?us-ascii?Q?RhONwZcrjrpgzztbe+YFEcEik7I4P0A+pk60q/WZtQEeVyxBeqmcGkcT6LYV?=
 =?us-ascii?Q?bbsHtXirwjq5sLrm1DXuUo7U22LLBGqcmAtzQAdc4eztxUPLUErZKfRBGPTm?=
 =?us-ascii?Q?FsKJdZTTotN45J+9hk+HA/rDwZZR9NueHiFttaNmeX8v3WwIekCJmG29pu4y?=
 =?us-ascii?Q?FSj+iHKZQ/ovMAMLzckEKZpibO0nOcIhQ6Bu8UbBAbM09qTfYSKqNDnqOye4?=
 =?us-ascii?Q?rT+tgqhRMAt3yxOG8y9UVZcPOQb2hi6Zrq/dbJo/6BnBMLqC6CdMM8OIbRVR?=
 =?us-ascii?Q?Vc8TKZ9AV8RM8nDSb7pHYk3JDpiPZCQUX5/Fjb4bMzOJwBfvygOZLMxfY3b5?=
 =?us-ascii?Q?w2lDG2pfMZVjor0XaLz4MhC3CQXkmlC1akqIw0mHXZlh6NPZZlrFoCyzkg3d?=
 =?us-ascii?Q?H47oLBm+uQo9V5uxNFZNqA7er4e2QXQdmBQm8C2Ke87f0l3btJFQitUurC5v?=
 =?us-ascii?Q?qOthoUTmIMxikGZ596/KxKfsJgc4PE4rcuK2ww1XHrpRj+M0Di3AigpCICdS?=
 =?us-ascii?Q?bcljCaIuU96o4hkSo+FWy5Cj3NS8m9cz6CrSxGRFsUNyrkbjFg3iAeCRbdnf?=
 =?us-ascii?Q?TY45ueJL0YAQYtsGWfeGS5cmIDagrE4it8nCksyiakJfQJ8t5LgDKy5/vymk?=
 =?us-ascii?Q?YV9xljKC810X4/nUlsWUK+RojmvpKFua/esB+Ghh8ZsYJnUbyVyoSb1VEWuN?=
 =?us-ascii?Q?fyzYCWPE03LPrqTVZCGoVqIJip0j11CxdtW/tFvYVX/wVjHa1RL9q9X+r28w?=
 =?us-ascii?Q?MHW5vjaXe3hRWid5zYCMU2Oh03oN1hYCixDtK+lEOqG0USFtzlZOzlYYznSd?=
 =?us-ascii?Q?ulpAu9qA6kT/QlSYQ9exSpkVqu+pieUNZ83s8F/F+BNL6kcQLN/sWfscHXn0?=
 =?us-ascii?Q?rbz+pWlaco/1X4vX8LhmbrNhKvz5rxzN2g7Pu6Z/GoCDKW7my3r+bBxdPWEz?=
 =?us-ascii?Q?3v6kqF16cY3CZMk8UfaRI4M3OK6JRMBolCc/zjYuW3HO3FVlACHHFFPCQnsx?=
 =?us-ascii?Q?mz4E9LUDYrqmQ9VG4VH2iiST5C8D15/HH/6cZ45d0yw3+iXD/OZfAVM7i0g8?=
 =?us-ascii?Q?tHES5RsvdYwBzQYHscX49rGgKgvJr+0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8163b4ac-3864-496e-05bb-08da3460f878
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 21:47:11.8185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NyfZSOIwUbMHyeST8QofAfztXW6R0NQ0QAlEckvl+5Zcbas/BLgt9E6IRX997SAlQx3WAaYz2miVIlrK7R8xxBOKolQj1UaBXbdxagtA+YQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3311
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_13:2022-05-12,2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=373
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120091
X-Proofpoint-GUID: _GTEMP-t6MW2ZiVB_m0DK-6vjZ6WXO5Q
X-Proofpoint-ORIG-GUID: _GTEMP-t6MW2ZiVB_m0DK-6vjZ6WXO5Q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches were made over Eric's tree:

git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git

and his kthread-cleanups-for-v5.19 branch. They allow the vhost layer to
do a copy_process on the thread that does the VHOST_SET_OWNER ioctl like how
io_uring does a copy_process against its userspace app. This allows the
vhost layer's worker threads to inherit cgroups, namespaces, address
space, etc and this worker thread will also be accounted for against that
owner/parent process's RLIMIT_NPROC limit.

If you are not familiar with qemu and vhost here is more detailed
problem description:

Qemu will create vhost devices in the kernel which perform network, SCSI,
etc IO and management operations from worker threads created by the
kthread API. Because the kthread API does a copy_process on the kthreadd
thread, the vhost layer has to use kthread_use_mm to access the Qemu
thread's memory and cgroup_attach_task_all to add itself to the Qemu
thread's cgroups.

The problem with this approach is that we then have to add new functions/
args/functionality for every thing we want to inherit. I started doing
that here:

https://lkml.org/lkml/2021/6/23/1233

for the RLIMIT_NPROC check, but it seems it might be easier to just
inherit everything from the beginning, becuase I'd need to do something
like that patch several times.

V9:
- Rebase against Eric's kthread-cleanups-for-v5.19 branch. Drop patches
no longer needed due to kernel clone arg and pf io worker patches in that
branch.
V8:
- Fix kzalloc GFP use.
- Fix email subject version number.
V7:
- Drop generic user_worker_* helpers and replace with vhost_task specific
  ones.
- Drop autoreap patch. Use kernel_wait4 instead.
- Fix issue where vhost.ko could be removed while the worker function is
  still running.
V6:
- Rename kernel_worker to user_worker and fix prefixes.
- Add better patch descriptions.
V5:
- Handle kbuild errors by building patchset against current kernel that
  has all deps merged. Also add patch to remove create_io_thread code as
  it's not used anymore.
- Rebase patchset against current kernel and handle a new vm PF_IO_WORKER
  case added in 5.16-rc1.
- Add PF_USER_WORKER flag so we can check it later after the initial
  thread creation for the wake up, vm and singal cses.
- Added patch to auto reap the worker thread.
V4:
- Drop NO_SIG patch and replaced with Christian's SIG_IGN patch.
- Merged Christian's kernel_worker_flags_valid helpers into patch 5 that
  added the new kernel worker functions.
- Fixed extra "i" issue.
- Added PF_USER_WORKER flag and added check that kernel_worker_start users
  had that flag set. Also dropped patches that passed worker flags to
  copy_thread and replaced with PF_USER_WORKER check.
V3:
- Add parentheses in p->flag and work_flags check in copy_thread.
- Fix check in arm/arm64 which was doing the reverse of other archs
  where it did likely(!flags) instead of unlikely(flags).
V2:
- Rename kernel_copy_process to kernel_worker.
- Instead of exporting functions, make kernel_worker() a proper
  function/API that does common work for the caller.
- Instead of adding new fields to kernel_clone_args for each option
  make it flag based similar to CLONE_*.
- Drop unused completion struct in vhost.
- Fix compile warnings by merging vhost cgroup cleanup patch and
  vhost conversion patch.




