Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFB9550E61
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 03:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbiFTBOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 21:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiFTBOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 21:14:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FEDAE56
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 18:14:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25JIeK2O032324;
        Mon, 20 Jun 2022 01:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=oyb6qhlf/F3wScOiTGyBvyRA7y9zdj7nWZB7asnY/EM=;
 b=gjLJjAlNHMrkQ2IZ5VlVvUptBob9Yvtu8jaGyLJSWerOJJmIomCwo8NocJtI+RyCaOaZ
 h30aNU6PbaiphIZPaOhOX/4p6DB2zurhblJew7et+PcqhZ1ZpbbxWBjFewQ2bU2Gp9Sj
 xYwnnCA0ifiJ3aZ32otcGqTogE4kPuCuGkuxU9Zw4k2+Ei9tk4l20+G4JcdrF4VFj4Qn
 dkPvqW7oqwTedsUckWJoTzsahwoQ3ydgDflJlvLQZ4e7IM1AxF99rCdo0Q3F/bYYduHB
 RG4RhSGmgHGd4MINWBbUrdAJGOaqI3PACOBrcbZgpc6NGlgQTzMmyS3vejzrXDh9sV01 +A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kf1xqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 01:14:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25K1A3RW038698;
        Mon, 20 Jun 2022 01:14:12 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtbu5tbf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 01:14:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXcuau5/TdLRlER1PCc34t/J3bFLmkwanW9SarPZnaVlDD2Ntm15ZE+EnVAZtPRf6jivQdHObqhyRDB1wmKUooPGkdxvv0XFnwfiInmMfmxlLffK+sA8xnDZokJYvE4vQVDr56Nl1fpolMRM3QOoMLpergKEoU+7NTPpB3/8S0J/29ofsAYEjXitliBCZa5jf0bsyd24VB/WqRwlqM95ylSsniowhktpugVtogdIgJgKp2kcVzaIzlDj6mhNNhXLoN7tVHTU8JbCdliSbJZaraaMGYeBVDoSAl64aGqFBO7/bd9319qNjrezdxhUFEeJq7nvhEAWbKYVot6flu+EkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyb6qhlf/F3wScOiTGyBvyRA7y9zdj7nWZB7asnY/EM=;
 b=XjuCyfjNmwfJhQoemoHVLi0uU64cu8Bsa2NcClSLgRvA5yx4MKokSI0U/wLtPd68uZKvR3xSEq7xdROzpCfCBOer87q/W0KokdXHl7gIidyShevNMo5AQeaSoj0IlpdrQj1RbtuYcoRfRxbDfUn8hJj2LZqvLcKJOEoDJXrXI5WrzTDUhBBbFycwZOLohyqSmYxov3O/p2m4tQKlUh5gzvCXpObYGJiecksu6pHmCwaEWG/SlfN2wPXuRqgEd/P0crbmLbYEy16TTHgIVg+eDhgqBSpX+neYWTF8KKN9YexDjyDdTlG9wWU2Oi9oE7vZjqMIVCfNIzcNtxJ6Jq8EOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyb6qhlf/F3wScOiTGyBvyRA7y9zdj7nWZB7asnY/EM=;
 b=J3w5cYydf2r0g8IUJ1+HIUFNMitcVbXq6BbT4hC2aSjvQQe+fkYlRo5bUpxXDZCjBp5yZ1zRFiRO16/jsUOC3nkRdtdNXdEeKH3DNPRkJ/dNK8FZwaEjxyYo5NhzBH6c0V5fPsG1bczZl5TcSa89xGOQ5roRiyWl6tCand1Smk0=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.18; Mon, 20 Jun 2022 01:14:05 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5353.018; Mon, 20 Jun 2022
 01:14:05 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: [PATCH v10 0/8] Use copy_process in vhost layer
Date:   Sun, 19 Jun 2022 20:13:49 -0500
Message-Id: <20220620011357.10646-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:5:bc::27) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e86dff4-414a-4def-9ae4-08da525a2b1f
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB146697FE3C8DDE9C852450AFF1B09@DM5PR10MB1466.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BGszH5f+UIiQsakEWSi57o89XS11WU8hlLCAeojcl5ZevNIGIdz00dU18WRDfW9RSiR3sx0ad1D7J+GJ9D4PymzkPf/4c6nc5ottnCgYyrbNSixZcmL2oP4C4Fpd3AsZYFaaY3CaemoWnLfhAdWm7OFecjiUC/G0oeFqEo7xef8Uyj66oR0NONuBlCLJPrwnat4s7g4ZQ6ZvCUSz+gloeibpVzVs1/Ygr/rofnUeSB+aaEj86tpu3Cj6FCM48rGBBQV67k9+hsHuyTGPSJS1NRzJMcqIPkcK1CXmwiZ+yAw7JrS2Og9Vo5cx0DLyqcBYJatNARIavIPihDHtHGFRwlXFVRZF1bG26boMagyU0zTXJMWwwpTKspJQIM711whI9bCqR9WZVEwd4s4CIa0BbqCePNL0oMkwKJL32UKq5xzp5teYb48Pb4hgkpPRchTsQwewiHhNWLvpZw1FJTlZcwE3REzVwLNxPQDROnrvGwCnGnLtJy3x4twI/DAKefspONA71N8mPMgPclXyJEgC8Hx7ByHiqm1za/l2wyhd6EYjLM/4OUOsK6lQyx4jRSJ/uS1mYDvUdomnZ68gCmQGg0dMDrogcZjNGAJWEAUMl3OEjOOpShzwDmG+G1VQAMt2NIgks1ISB6P387iTtwia6o14IKplnzG+AMoObFGrI5neioP0Y11xmyCjNnhssxaqDM3y344TNI7JoB8CCUz0XUwifIjsjJleE/OOKW22oZsy3XbnpLWejg6omdjELptAzom+2wxTMdnk/C6V5POifPwH3r20/MZiTP8dyHclnrk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(966005)(316002)(6486002)(6512007)(26005)(38100700002)(8936002)(38350700002)(5660300002)(83380400001)(6506007)(2616005)(8676002)(36756003)(52116002)(66556008)(498600001)(66476007)(66946007)(86362001)(1076003)(2906002)(6666004)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uEjyA0Zag9ToruXnZFLBXioGxmxKtiyU3rBWNeemdMu3bvqLD7VDV8HzU+Gn?=
 =?us-ascii?Q?aD3FniBsYPjUKOQAPNsj/uBwzv9MDV8hShiiHXpOs9eX7YxcGLCCKWb1x5yG?=
 =?us-ascii?Q?pmtVPI8rtK7jT067XxyjMcpFlkdTvFDFGFYgcOhlLmfvrduQClvbtUXEFmT8?=
 =?us-ascii?Q?BsL6FBADucjh43qKcZcMzZ3v1NT4O+9+i2CbfnefNlkKPgdrgdbSeAUbPfS8?=
 =?us-ascii?Q?9tPE17Qva6Do/p9HBWgHq/pW/0iG6U+DVwpJrycc0dz6JKkG6xFROkL4HN4N?=
 =?us-ascii?Q?bOiRXYNMIRfKXhm6iwkEXjfjKYCKl5UIP/G1LRAzDwdo2eF485ph2IEWOpu8?=
 =?us-ascii?Q?5tlq8uhYi05tWMqG8b3Kt23kQdd46gs+erClnErdOUy8YZwMbbEMwUb6OwGA?=
 =?us-ascii?Q?fJHHU0Eh3eDn9huYdHJaQr6fwK9uqvaOp9cHWZDgz2ie4ZJH9yTgR6AygmNo?=
 =?us-ascii?Q?0M2jl5sbUQ88y018cghToHioAG5IwnmFy1EncFWkJN8rHSnZ1XaCPn2JQrWo?=
 =?us-ascii?Q?JojaF7YGeDtVuSQWDGqHlnikrycXoOyF57/Ue9a8WwxWm3CRmQEJW/ZKJOgA?=
 =?us-ascii?Q?0mvGBBMKi8pqHE33EzTnva6r0pma8qK86VUlOfkHjRBge4KN8eh4V8UmKduB?=
 =?us-ascii?Q?nY7senD+CnK0YkciylxO0hkGtzuaQwSp+K75X/0IYklI4VKaX77BE2b3GazP?=
 =?us-ascii?Q?ZijZXqD/LSr5Q2dEi8AgrfWrMVy6tYbQzLGsgXzT04QrOKi3OtfusFhdhNAs?=
 =?us-ascii?Q?EkSoXcjbKaprU6KFe45wGyHClzwaFGT+Wu/MG4FZqwU7SVqJD6PjmqrVrkW/?=
 =?us-ascii?Q?Bk5aTn23fUnprnpjgxK8u6weu+djKr42Ozt1OdJS2z1MdiCApl1uQiWnDF2O?=
 =?us-ascii?Q?K/2WHF8XGofXHUJiS2nKnsMqMZ6CctQjqokINLPzlA9LecDEa1gRpUwDBrnr?=
 =?us-ascii?Q?QD6uoqBF9dvFE9yVvrue6Qos7bVFDs1fRH/0CxwPkkkXAwbQrd6EqQlz9aRu?=
 =?us-ascii?Q?DScAoZR0UQN/aY+FjteQGJGkOsa8mXoXF37tRl+avtLMA5dvSgLWU3jE8Ya8?=
 =?us-ascii?Q?eMLcn9breZSfe/MqwvjtIZRXt3NND5l0HgA0sEK6T/spe1TSimvFHrakSoWx?=
 =?us-ascii?Q?pB9vyINauvQ7TWipjiXxndGbI2r5Bs2Ln7z45ZFk3M1hTAdFX7dhp/ruLhIA?=
 =?us-ascii?Q?A9jBF96iL50D1r7M6US8RioiWxlTxQYp+k/Z5kTx8RjdJcOmYi8/S4Z2sqHs?=
 =?us-ascii?Q?t6cOhmJYpSVdVSMRt3iIWE8zv6iHjzFAc5N6AYjTYUJ89ZWmytHni2BoRN2o?=
 =?us-ascii?Q?gTsxOMcPp+ARo/uxhyw3Ag0ZEICyNqwRIDA7om736A7wR/+mfA2tBZhG0oi1?=
 =?us-ascii?Q?0Yu3zF9TL9uxslUkI+pJPeNYf1KD2BLcxuRwwfWqZrTCffchKlfJU+TqFvee?=
 =?us-ascii?Q?wHp0eTu3xdLCviuYr5aR8z3U+4s+82Iuu3QAjOT2dakCAKWMDghAno3yqV2b?=
 =?us-ascii?Q?mEFwBaKvmFDST6jpLKbRKnxGrQ2fvEVbZpBDLW/Bc/NZX9l9YDZdFlnx9Po3?=
 =?us-ascii?Q?MN9kRkAFUodTiCjM71Oa+4HobUcfrPRJTPDdJnLAXnGBjliyiuMfOwW0H+N0?=
 =?us-ascii?Q?ManvTmz1ZODAPlrM3OjDWTFrpobc65PYsGHbQM2nPYQs6CLwXNveyz8lWQDS?=
 =?us-ascii?Q?7yNjD48o8qxnlYoBUL84TtFyMOcd3Ieu/NPA1FE+A7ByW44zYckqBzSWb+aM?=
 =?us-ascii?Q?mfwu81IKdqlF7grOnC3grZh0Mug/cR8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e86dff4-414a-4def-9ae4-08da525a2b1f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 01:14:05.2247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSDPfk8gavBofLXIbk79l9MgE4J9fztLlFJ08vtFL4RozPwzy1ObdZxHq4LbjzGCGVcZ/cHvXzGcGo8JXHqxGmjgqjlZMcQfOMysX9hxfkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1466
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-19_12:2022-06-17,2022-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxlogscore=322
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206200004
X-Proofpoint-ORIG-GUID: x8cZHIRs_JqrnYkfg1doJI-90AgwSqHM
X-Proofpoint-GUID: x8cZHIRs_JqrnYkfg1doJI-90AgwSqHM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches were made over Linus's tree.

Eric and Christian, the vhost maintainer, Michael Tsirkin has ACK'd the
patches. I haven't got any more comments from you guys for a couple
postings now (Jan 8 was the last reply). Are you guys ok to merge them?

For everyone else that hasn't see this before, the patches allow the
vhost layer to do a copy_process on the thread that does the
VHOST_SET_OWNER ioctl like how io_uring does a copy_process against its
userspace app. This allows the vhost layer's worker threads to inherit
cgroups, namespaces, address space, etc and this worker thread will also
be accounted for against that owner/parent process's RLIMIT_NPROC limit.

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

V10:
- Eric's cleanup patches my vhost flush cleanup patches are merged
upstream, so rebase against Linus's tree which has everything.
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



