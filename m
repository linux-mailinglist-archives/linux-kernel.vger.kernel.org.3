Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EB14FAB8E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 04:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiDJCkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 22:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243443AbiDJCkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 22:40:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E4643489
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 19:37:58 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23A0nRJY022836;
        Sun, 10 Apr 2022 02:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=G+zk6BTdPp3WcWupeg8y67GItBolaH7F3aaOuKbLi2U=;
 b=lPV0MasBJuxI6kSk8jZ+zCUgVl5bysqNEeLUS1t7FCnejSHLA3b6W9TuN4XkGru4L58/
 d15ae7/vdM/3Nb4QKnoY9RiBOo4o1SsIt7lLlgXI7NDnTNBL+b/jySb026+dJo87dRiJ
 yqb+HRzK7f+FwwJa7aqGGBiNEqXDds4IUhrvAZhaRWzQHne/5gQUUeAW2rm1QDnDyT+k
 YkdbJOJ31PU3r75gylcX6u4ACAv+2+9uJwCi7SPJdfZ4CzCmrdxVx45eofjRUWX5Lsog
 CRrj6AAtLGk9wua46HDMU3xBvbATBtoYBkKfBlEGPnfIsuMjTbpKS5pjOtU+8D1Lcark OA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jd1111-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Apr 2022 02:37:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23A2UeME024150;
        Sun, 10 Apr 2022 02:37:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k0h5hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Apr 2022 02:37:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUcLCC7yzbt7pO8pgQc3xhC27PFiqgwMH7p29pCl3k3BSq3S4oOFCf4G64RMKVM9EjyDyxpldFE1136xDGc2turZZsPgcpub9oyFEwNjy0VuteWMeaaEglkCy9CUq8YLScX1Nlt2J1DLy5vISxbfnHPjidU//OWY9PWzFXadOxXNBwoQZa1fY6G/ayuBPo2dFSy0a66kp09YYCacD6CVtEOHNtqnkuPgrSLR9WUIOP/2QFk/6fxsMrhgR6UJEq4o7aoy0PGy6hkzDGQQem0G9Fv3KDH6EzKRftdH2p8VgO4BkSVZkpjdP/GgNiYS7ZC2WqD27e6j2MbG5CjaV6hMAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+zk6BTdPp3WcWupeg8y67GItBolaH7F3aaOuKbLi2U=;
 b=cjpxkX509bI0xXphOL3EsuqrfsEq6N/6xWZCVkJkUHv8ZK3hQvWLsTJlm6NRDpEMbmeWQCQlCPyU/gvDMtWev91RV9HEspBlH/3geca4y1VPtZVdmo8O3gnEi/PoqT35BPx1aB011xlqUkyu8TDt7cf+w/6/MyVEYRgZwZjqnT6YlOK9EhtpX1oPYKUd/nNrQV/7A/9PzYSZ7xxOdaioI1JxaZKHUS79JFG62PYdHNxA/2b3A0qGHl/f3ZVEGyt3h8dsrBkYSe04IkSrZ+Ygw4/Wt2OScaW7qwwPe9K9i4NsQo17UrX6JIyRsMLWGJoeDYraR6LqH7MCe5t8+8Pfxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+zk6BTdPp3WcWupeg8y67GItBolaH7F3aaOuKbLi2U=;
 b=jRMx4NQNDTvVf2nrNPILexhtMUj8pVYUAjSLlph1uVQVi/3MPfWyeNEGyALApaEEhheFzlL3gcPyBJQba8Gt7BFcVnXOVF//yC7cbp+SD4mxXAHlQSipPcFCnDnf7hs/FnVk2xIej2id214eVqV0cZgeXW3aRaGinArQiQSySEo=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CY4PR10MB1238.namprd10.prod.outlook.com (2603:10b6:910:7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.28; Sun, 10 Apr
 2022 02:37:50 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5144.028; Sun, 10 Apr 2022
 02:37:50 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        ebiederm@xmission.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v8 09/10] kernfs: Replace per-fs rwsem with hashed rwsems.
Date:   Sun, 10 Apr 2022 12:37:18 +1000
Message-Id: <20220410023719.1752460-10-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220410023719.1752460-1-imran.f.khan@oracle.com>
References: <20220410023719.1752460-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0054.ausprd01.prod.outlook.com
 (2603:10c6:10:2::18) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2683126d-a28f-49f3-ffb5-08da1a9b1b09
X-MS-TrafficTypeDiagnostic: CY4PR10MB1238:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB123841BA580097C53F181B7DB0EB9@CY4PR10MB1238.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ojehbUo4/cpQAJy5VqNUV/j5F6EBVvNO+1ILgZLv5lhyUsmQ2kFH7I0UR1+eIWpYRB5YR4cetqlLs/ASKd6c5I0YdBPXNG88WSECcpYxOe7fTJGLydPZr8ijyX7jnY/yoMnwz1a2ubyqMC00qdhMwJ5lbteapgsGBeFRgssN/JLIoKScFgnmcpmSWgVBwazNFl/7ybMTmvwxCpyJcpMhqKTfj6ix8z/cdCKsACnKaBnxsp6Neo1oGKNC26OupJZS0qRls3bBqt6TEqOqKzkwqQs1+WeLdg5RCeZhvagfp2k7B/NzvgVRymOjG48h1nCYWkjzN3zWNQlHmX9nR5ABMopXzw0kesihbCkB075iLbL6BsiK1jUwHjEbjEIJl2A5lJi1jjncj1ynV+pvSnsfYYdn1/Bior/kNtiJ8KRC7KNdOJsZyns6SQIzU5FN0NXc6gJLperyzVjk0gYEXTXZZk1jWgPTTKlglW5dzU679q0W5mbNdrgUZhrSlvP84w+RNTbTjlNnYWGhrEpJrWPa9BRMxE9iFoAv9KI4P/DtXmzo7NTCk+Jgg+oTJkDklaca/1YUpw4rO7aiecjnNq38fPvoxQWCrVaoJBO48xNRqoLmDXRpbAXDhaB3JPIEKfrD1RVuOR3JF01MCdgbW3olb6rO7LiWOQnprXc5cqeh5u3PADDSOSEiNYLh2V3kxqS2Mbuoi1vO/61IdAF5JLvi2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(26005)(186003)(66946007)(66556008)(66476007)(8676002)(4326008)(83380400001)(36756003)(316002)(6486002)(103116003)(508600001)(8936002)(2616005)(30864003)(6666004)(5660300002)(38100700002)(38350700002)(86362001)(2906002)(6512007)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xUGNrMRg+cq6fAVy3zjm6zOg8oHj5y+XhQgwzMRFrDsvBa15NYO4O45rDhzw?=
 =?us-ascii?Q?49uauHbT7HcSw+6CXdQ0BfBYwvPCkgCdnGj0dt4rb4kx9t2cGFvfwlXBOFhu?=
 =?us-ascii?Q?Ip6JEQkTEeJX3cSFMhIcOOO9iNyXc6/p0pTT2x0P+bS7M4K9pTaBS/uE7IUK?=
 =?us-ascii?Q?cYGsK/hulB+VSNTMTPmN1ZwaVvxmBwTagOj1PQaXjBItZ4GLsz7VbuwHbc3Q?=
 =?us-ascii?Q?8kohYe71/m6tfVRTmOcGf0XX0IWjF/bkwVVOn0hBuFimpv3cL0pQhss7fRrb?=
 =?us-ascii?Q?Cz182BDBpWwSlrz37qsn3j9c7n9h057zRDmiYRz4+x5X44xNjEx28ZXeIYix?=
 =?us-ascii?Q?49QBAbLW6QbAoioU3HxK9VpQFurYxmr+p99GPX+ppaDfb9TGj3bC1iuWU363?=
 =?us-ascii?Q?X12KNzsBUlyTH4drz2YBlcC7Pju2XlX/J72xRuXAnHyGi4DJTnbHrCpPq+3g?=
 =?us-ascii?Q?LuR8AIA96baLatPAlY8pxxFAZOaTvSVwvyi0YNIs2HNlo1O3zXH/8bXJ1fSq?=
 =?us-ascii?Q?fHrtONSJBrl3O+r7GDgwp7Rozrvy89N/81nUNwAyEttoNxBSNptgLL1Q/Ssb?=
 =?us-ascii?Q?8K0g6LVOWfGWkDOcfwMSgorgzOn3GtrvIlbdT+jqYrGZAjq4+FIJ6Fi+A1I6?=
 =?us-ascii?Q?jeWld9PW5T9K5uGQryWAV1geozcgcFcuzkStcTreq7QfaL5iHMOWGalAYlm8?=
 =?us-ascii?Q?r3ftF7DZlFPUOm6ii1Bkf8OKD2X5q02enrVzjwCqe4HnNv9GmCgk1WGo1C3O?=
 =?us-ascii?Q?EQeOfSx10Tzv9VAGMRVaYOkL59Un5e0Cfe3YV86plro8ZrOjjojglNN2NoCx?=
 =?us-ascii?Q?rMjpLGnEkELzhEsFfWdwGyiaoJlhewb+86pKdQM7yb/2tyNb3pRosL/JVa8e?=
 =?us-ascii?Q?AP2av18v2oYfgfppsU/um4mhsbJZipKKNLlEjzne9HS3VxATkPtyWjaGQFTg?=
 =?us-ascii?Q?ijk24M4ozZy5ZGauQNwxGAeAMH0/1zSgDKoFquzKggL4VBvejmDYX64ehXTt?=
 =?us-ascii?Q?bP1wD8DVt8gGPzmFt8P8OQnB+TryystlZ+mHAVUAaraNZ7yCaaVIzTOBkwql?=
 =?us-ascii?Q?AP7tsDv3WO2A2SViOVFT/w9qynDnmc+jo3t0Hi2DFYTN7f8/L5fZSRC0KU+H?=
 =?us-ascii?Q?W8WD81Se10EPjgbxW1PPse+vg0dO3863eJcZo9t0KC/MAcR8GFqmJJJ0RbX8?=
 =?us-ascii?Q?G5MKk4ldzKAYEKQHV6ylZpiqXcwBwPl08P9SGuoHEvYjCHyOCdQm3QRVCMJr?=
 =?us-ascii?Q?X4QS+wyrymbW8EdpxWaJOQot2NIlXfSj65NSlkGVnkQfnWSE0x2qkF6aeTn4?=
 =?us-ascii?Q?OwOgQwmQ1OstSZ8UOwNEJHFDHmxGx/85cgc6GDMcpmJVs7dddMzSDGHarwmq?=
 =?us-ascii?Q?XsbB2MpS46w0bxmROjj3r5LZcPGySYVEtyWi1zN8ssjlLZdFYRY/FX0Nevpd?=
 =?us-ascii?Q?c7WzCzBNr4Lr01zRAnppkmjuzWyrk+sZCNHGyZgAaE+/3gv3Qb18JOFWyQ8o?=
 =?us-ascii?Q?in4SMW93WGLQeKwz+VxG7onmqk4An/NYtNZjGD1SCfcTt/EZdwPPUZjmGkBr?=
 =?us-ascii?Q?LjyVVtgXGdF/dwaeTV9G8gsc9w0VT+FOLeA533eOvxkYbGq9fakirw3Z2s53?=
 =?us-ascii?Q?7AXCAEMyQ2mi1itjoolNBe7hTjuFKTY2mqo5ioEgi6iPQbc4Wc9Ku4DaPjpv?=
 =?us-ascii?Q?Yh2NaWSHx8v+pKzOGHyyVokEtdGfUMoS3cy5pvxviF4tGi+wtpVjfS3ud/JH?=
 =?us-ascii?Q?DCNZ1DbR7DvosLO8VGZxJVsLQU+kWHQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2683126d-a28f-49f3-ffb5-08da1a9b1b09
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2022 02:37:50.4113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eeCtssZct+jIwtPFFcEOgNmiJXETzQfVI2c4Ncrn1aetX7QJZei3u94y9gYCZ6JloHRtS7n+fFNdputzHC94nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1238
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-09_25:2022-04-08,2022-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204100014
X-Proofpoint-ORIG-GUID: 1lyq_sd3uaPfGKmsbRp4NPlq42AxOt8o
X-Proofpoint-GUID: 1lyq_sd3uaPfGKmsbRp4NPlq42AxOt8o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a single rwsem to synchronize all operations across a kernfs
based file system (cgroup, sysfs etc.) does not scale well. The contention
around this single rwsem becomes more apparent in large scale systems with
few hundred CPUs where most of the CPUs have running tasks that are
opening, accessing or closing sysfs files at any point of time.

Using hashed rwsems in place of a per-fs rwsem, can significantly reduce
contention around per-fs rwsem and hence provide better scalability.
Moreover as these hashed rwsems are not part of kernfs_node objects we will
not see any singnificant change in memory utilization of kernfs based file
systems like sysfs, cgroupfs etc.

Modify interface introduced in previous patch to make use of hashed rwsems.
Just like earlier change use kernfs_node address as hashing key. Since we
are getting rid of per-fs lock, in certain cases we may need to acquire
locks corresponding to multiple nodes and in such cases of nested locking,
locks are taken in order of their addresses. Introduce helpers to acquire
rwsems corresponding to multiple nodes for such cases.

For operations that involve finding the node first and then operating on it
(for example operations involving find_and_get_ns), acquiring rwsem for the
node being searched is not possible. Such operations need to make sure that
a concurrent remove does not remove the found node. Introduce a per-fs
mutex that can be used to synchronize these operations against parallel
removal of involved node.

Replacing global mutex and spinlocks with hashed ones (as mentioned in
previous changes) and global rwsem with hashed rwsem (as done in this
change) reduces contention around kernfs and results in better performance
numbers.

For example on a system with 384 cores, if I run 200 instances of an
application which is mostly executing the following loop:

  for (int loop = 0; loop <100 ; loop++)
  {
    for (int port_num = 1; port_num < 2; port_num++)
    {
      for (int gid_index = 0; gid_index < 254; gid_index++ )
      {
        char ret_buf[64], ret_buf_lo[64];
        char gid_file_path[1024];

        int      ret_len;
        int      ret_fd;
        ssize_t  ret_rd;

        ub4  i, saved_errno;

        memset(ret_buf, 0, sizeof(ret_buf));
        memset(gid_file_path, 0, sizeof(gid_file_path));

        ret_len = snprintf(gid_file_path, sizeof(gid_file_path),
                           "/sys/class/infiniband/%s/ports/%d/gids/%d",
                           dev_name,
                           port_num,
                           gid_index);

        ret_fd = open(gid_file_path, O_RDONLY | O_CLOEXEC);
        if (ret_fd < 0)
        {
          printf("Failed to open %s\n", gid_file_path);
          continue;
        }

        /* Read the GID */
        ret_rd = read(ret_fd, ret_buf, 40);

        if (ret_rd == -1)
        {
          printf("Failed to read from file %s, errno: %u\n",
                 gid_file_path, saved_errno);

          continue;
        }

        close(ret_fd);
      }
    }

I can see contention around above mentioned locks as follows:

-   54.07%    53.60%  showgids         [kernel.kallsyms]       [k] osq_lock
   - 53.60% __libc_start_main
      - 32.29% __GI___libc_open
           entry_SYSCALL_64_after_hwframe
           do_syscall_64
           sys_open
           do_sys_open
           do_filp_open
           path_openat
           vfs_open
           do_dentry_open
           kernfs_fop_open
           mutex_lock
         - __mutex_lock_slowpath
            - 32.23% __mutex_lock.isra.5
                 osq_lock
      - 21.31% __GI___libc_close
           entry_SYSCALL_64_after_hwframe
           do_syscall_64
           exit_to_usermode_loop
           task_work_run
           ____fput
           __fput
           kernfs_fop_release
           kernfs_put_open_node.isra.8
           mutex_lock
         - __mutex_lock_slowpath
            - 21.28% __mutex_lock.isra.5
                 osq_lock

-   10.49%    10.39%  showgids         [kernel.kallsyms]      [k] down_read
     10.39% __libc_start_main
        __GI___libc_open
        entry_SYSCALL_64_after_hwframe
        do_syscall_64
        sys_open
        do_sys_open
        do_filp_open
      - path_openat
         - 9.72% link_path_walk
            - 5.21% inode_permission
               - __inode_permission
                  - 5.21% kernfs_iop_permission
                       down_read
            - 4.08% walk_component
                 lookup_fast
               - d_revalidate.part.24
                  - 4.08% kernfs_dop_revalidate

-    7.48%     7.41%  showgids         [kernel.kallsyms]       [k] up_read
     7.41% __libc_start_main
        __GI___libc_open
        entry_SYSCALL_64_after_hwframe
        do_syscall_64
        sys_open
        do_sys_open
        do_filp_open
      - path_openat
         - 7.01% link_path_walk
            - 4.12% inode_permission
               - __inode_permission
                  - 4.12% kernfs_iop_permission
                       up_read
            - 2.61% walk_component
                 lookup_fast
               - d_revalidate.part.24
                  - 2.61% kernfs_dop_revalidate

Moreover this run of 200 application isntances takes 32-34 secs. to
complete.

With the patched kernel and on the same test setup, we no longer see
contention around osq_lock (i.e kernfs_open_file_mutex) and also
contention around per-fs kernfs_rwsem has reduced significantly as well.
This can be seen in the following perf snippet:

-    1.66%     1.65%  showgids         [kernel.kallsyms]      [k] down_read
     1.65% __libc_start_main
        __GI___libc_open
        entry_SYSCALL_64_after_hwframe
        do_syscall_64
        sys_open
        do_sys_open
        do_filp_open
      - path_openat
         - 1.62% link_path_walk
            - 0.98% inode_permission
               - __inode_permission
                  + 0.98% kernfs_iop_permission
            - 0.52% walk_component
                 lookup_fast
               - d_revalidate.part.24
                  - 0.52% kernfs_dop_revalidate

-    1.12%     1.11%  showgids         [kernel.kallsyms]      [k] up_read
     1.11% __libc_start_main
        __GI___libc_open
        entry_SYSCALL_64_after_hwframe
        do_syscall_64
        sys_open
        do_sys_open
        do_filp_open
      - path_openat
         - 1.11% link_path_walk
            - 0.69% inode_permission
               - __inode_permission
                  - 0.69% kernfs_iop_permission
                       up_read

Moreover the test execution time has reduced from 32-34 secs to 18-19 secs.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/Makefile          |   2 +-
 fs/kernfs/dir.c             | 171 +++++++++++++++++++-----
 fs/kernfs/inode.c           |  20 +++
 fs/kernfs/kernfs-internal.c | 259 ++++++++++++++++++++++++++++++++++++
 fs/kernfs/kernfs-internal.h |  52 +++++++-
 fs/kernfs/mount.c           |   4 +-
 fs/kernfs/symlink.c         |  11 +-
 include/linux/kernfs.h      |   1 +
 8 files changed, 478 insertions(+), 42 deletions(-)
 create mode 100644 fs/kernfs/kernfs-internal.c

diff --git a/fs/kernfs/Makefile b/fs/kernfs/Makefile
index 4ca54ff54c98..778da6b118e9 100644
--- a/fs/kernfs/Makefile
+++ b/fs/kernfs/Makefile
@@ -3,4 +3,4 @@
 # Makefile for the kernfs pseudo filesystem
 #
 
-obj-y		:= mount.o inode.o dir.o file.o symlink.o
+obj-y		:= mount.o inode.o dir.o file.o symlink.o kernfs-internal.o
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index f8520d842b39..bdc355143735 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -17,7 +17,7 @@
 
 #include "kernfs-internal.h"
 
-static DEFINE_RWLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
+DEFINE_RWLOCK(kernfs_rename_lock);		/* kn->parent and ->name */
 static char kernfs_pr_cont_buf[PATH_MAX];	/* protected by rename_lock */
 static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
@@ -25,7 +25,6 @@ static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
 static bool kernfs_active(struct kernfs_node *kn)
 {
-	kernfs_rwsem_assert_held(kn);
 	return atomic_read(&kn->active) >= 0;
 }
 
@@ -450,26 +449,24 @@ void kernfs_put_active(struct kernfs_node *kn)
 /**
  * kernfs_drain - drain kernfs_node
  * @kn: kernfs_node to drain
+ * @anc: ancestor of kernfs_node to drain
  *
  * Drain existing usages and nuke all existing mmaps of @kn.  Mutiple
  * removers may invoke this function concurrently on @kn and all will
  * return after draining is complete.
  */
-static void kernfs_drain(struct kernfs_node *kn)
-	__releases(&kernfs_root(kn)->kernfs_rwsem)
-	__acquires(&kernfs_root(kn)->kernfs_rwsem)
+static void kernfs_drain(struct kernfs_node *kn, struct kernfs_node *anc)
+	__releases(kernfs_rwsem_ptr(anc))
+	__acquires(kernfs_rwsem_ptr(anc))
 {
 	struct kernfs_root *root = kernfs_root(kn);
 
-	/**
-	 * kn has the same root as its ancestor, so it can be used to get
-	 * per-fs rwsem.
-	 */
-	struct rw_semaphore *rwsem = kernfs_rwsem_ptr(kn);
+	struct rw_semaphore *rwsem;
 
-	kernfs_rwsem_assert_held_write(kn);
+	kernfs_rwsem_assert_held_write(anc);
 	WARN_ON_ONCE(kernfs_active(kn));
 
+	rwsem = kernfs_rwsem_ptr(anc);
 	kernfs_up_write(rwsem);
 
 	if (kernfs_lockdep(kn)) {
@@ -489,7 +486,7 @@ static void kernfs_drain(struct kernfs_node *kn)
 
 	kernfs_drain_open_files(kn);
 
-	kernfs_down_write(kn);
+	kernfs_down_write(anc);
 }
 
 /**
@@ -729,6 +726,11 @@ int kernfs_add_one(struct kernfs_node *kn)
 	bool has_ns;
 	int ret;
 
+	/**
+	 * The node being added is not active at this point of time and may
+	 * be activated later depending on CREATE_DEACTIVATED flag. So at
+	 * this point of time just locking the parent is enough.
+	 */
 	rwsem = kernfs_down_write(parent);
 
 	ret = -EINVAL;
@@ -826,28 +828,39 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 {
 	size_t len;
 	char *p, *name;
+	struct rw_semaphore *rwsem;
 
 	kernfs_rwsem_assert_held_read(parent);
 
-	/* grab kernfs_rename_lock to piggy back on kernfs_pr_cont_buf */
-	write_lock_irq(&kernfs_rename_lock);
+	p = kzalloc(PATH_MAX, GFP_KERNEL);
+	if (!p)
+		return NULL;
 
-	len = strlcpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
+	/* Caller has kernfs_rm_mutex so topology will not change */
+	len = strlcpy(p, path, PATH_MAX);
 
-	if (len >= sizeof(kernfs_pr_cont_buf)) {
-		write_unlock_irq(&kernfs_rename_lock);
+	if (len >= PATH_MAX) {
+		kfree(p);
 		return NULL;
 	}
 
-	p = kernfs_pr_cont_buf;
+	rwsem = kernfs_rwsem_ptr(parent);
 
 	while ((name = strsep(&p, "/")) && parent) {
 		if (*name == '\0')
 			continue;
+
 		parent = kernfs_find_ns(parent, name, ns);
+		/*
+		 * Release rwsem for node whose child RB tree has been
+		 * traversed.
+		 */
+		kernfs_up_read(rwsem);
+		if (parent) /* Acquire rwsem before traversing child RB tree */
+			rwsem = kernfs_down_read(parent);
 	}
 
-	write_unlock_irq(&kernfs_rename_lock);
+	kfree(p);
 
 	return parent;
 }
@@ -867,11 +880,20 @@ struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
 {
 	struct kernfs_node *kn;
 	struct rw_semaphore *rwsem;
+	struct kernfs_root *root = kernfs_root(parent);
 
+	/**
+	 * We don't have address of kernfs_node (that is being searched)
+	 * yet. Acquiring root->kernfs_rm_mutex and releasing it after
+	 * pinning the found kernfs_node, ensures that found kernfs_node
+	 * will not disappear due to a parallel remove operation.
+	 */
+	mutex_lock(&root->kernfs_rm_mutex);
 	rwsem = kernfs_down_read(parent);
 	kn = kernfs_find_ns(parent, name, ns);
 	kernfs_get(kn);
 	kernfs_up_read(rwsem);
+	mutex_unlock(&root->kernfs_rm_mutex);
 
 	return kn;
 }
@@ -892,11 +914,26 @@ struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *parent,
 {
 	struct kernfs_node *kn;
 	struct rw_semaphore *rwsem;
+	struct kernfs_root *root = kernfs_root(parent);
 
+	/**
+	 * We don't have address of kernfs_node (that is being searched)
+	 * yet. Acquiring root->kernfs_rm_mutex and releasing it after
+	 * pinning the found kernfs_node, ensures that found kernfs_node
+	 * will not disappear due to a parallel remove operation.
+	 */
+	mutex_lock(&root->kernfs_rm_mutex);
 	rwsem = kernfs_down_read(parent);
 	kn = kernfs_walk_ns(parent, path, ns);
 	kernfs_get(kn);
-	kernfs_up_read(rwsem);
+	if (kn)
+		/* Release lock taken under kernfs_walk_ns */
+		kernfs_up_read(kernfs_rwsem_ptr(kn));
+	else
+		/* Release parent lock because walk_ns bailed out early */
+		kernfs_up_read(rwsem);
+
+	mutex_unlock(&root->kernfs_rm_mutex);
 
 	return kn;
 }
@@ -921,9 +958,9 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 		return ERR_PTR(-ENOMEM);
 
 	idr_init(&root->ino_idr);
-	init_rwsem(&root->kernfs_rwsem);
 	INIT_LIST_HEAD(&root->supers);
 	init_rwsem(&root->supers_rwsem);
+	mutex_init(&root->kernfs_rm_mutex);
 
 	/*
 	 * On 64bit ino setups, id is ino.  On 32bit, low 32bits are ino.
@@ -1093,6 +1130,11 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	}
 
 	kn = kernfs_dentry_node(dentry);
+	/**
+	 * For dentry revalidation just acquiring kernfs_node's rwsem for
+	 * reading should be enough. If a competing rename or remove wins
+	 * one of the checks below will fail.
+	 */
 	rwsem = kernfs_down_read(kn);
 
 	/* The kernfs node has been deactivated */
@@ -1132,24 +1174,35 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	struct inode *inode = NULL;
 	const void *ns = NULL;
 	struct rw_semaphore *rwsem;
+	struct kernfs_root *root = kernfs_root(parent);
 
+	/**
+	 * We don't have address of kernfs_node (that is being searched)
+	 * yet. So take root->kernfs_rm_mutex to avoid parallel removal of
+	 * found kernfs_node.
+	 */
+	mutex_lock(&root->kernfs_rm_mutex);
 	rwsem = kernfs_down_read(parent);
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dir->i_sb)->ns;
 
 	kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
+	kernfs_up_read(rwsem);
 	/* attach dentry and inode */
 	if (kn) {
 		/* Inactive nodes are invisible to the VFS so don't
 		 * create a negative.
 		 */
+		rwsem = kernfs_down_read(kn);
 		if (!kernfs_active(kn)) {
 			kernfs_up_read(rwsem);
+			mutex_unlock(&root->kernfs_rm_mutex);
 			return NULL;
 		}
 		inode = kernfs_get_inode(dir->i_sb, kn);
 		if (!inode)
 			inode = ERR_PTR(-ENOMEM);
+		kernfs_up_read(rwsem);
 	}
 	/*
 	 * Needed for negative dentry validation.
@@ -1157,9 +1210,11 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	 * or transforms from positive dentry in dentry_unlink_inode()
 	 * called from vfs_rmdir().
 	 */
+	rwsem = kernfs_down_read(parent);
 	if (!IS_ERR(inode))
 		kernfs_set_rev(parent, dentry);
 	kernfs_up_read(rwsem);
+	mutex_unlock(&root->kernfs_rm_mutex);
 
 	/* instantiate and hash (possibly negative) dentry */
 	return d_splice_alias(inode, dentry);
@@ -1339,27 +1394,40 @@ void kernfs_activate(struct kernfs_node *kn)
 static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
+	struct rw_semaphore *rwsem;
+	struct kernfs_root *root;
+
+	if (!kn)
+		return;
 
-	kernfs_rwsem_assert_held_write(kn);
+	root = kernfs_root(kn);
 
 	/*
 	 * Short-circuit if non-root @kn has already finished removal.
 	 * This is for kernfs_remove_self() which plays with active ref
 	 * after removal.
 	 */
-	if (!kn || (kn->parent && RB_EMPTY_NODE(&kn->rb)))
+	mutex_lock(&root->kernfs_rm_mutex);
+	rwsem = kernfs_down_write(kn);
+	if (kn->parent && RB_EMPTY_NODE(&kn->rb)) {
+		kernfs_up_write(rwsem);
+		mutex_unlock(&root->kernfs_rm_mutex);
 		return;
+	}
 
 	pr_debug("kernfs %s: removing\n", kn->name);
 
 	/* prevent any new usage under @kn by deactivating all nodes */
 	pos = NULL;
+
 	while ((pos = kernfs_next_descendant_post(pos, kn)))
 		if (kernfs_active(pos))
 			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
+	kernfs_up_write(rwsem);
 
 	/* deactivate and unlink the subtree node-by-node */
 	do {
+		rwsem = kernfs_down_write(kn);
 		pos = kernfs_leftmost_descendant(kn);
 
 		/*
@@ -1377,10 +1445,25 @@ static void __kernfs_remove(struct kernfs_node *kn)
 		 * error paths without worrying about draining.
 		 */
 		if (kn->flags & KERNFS_ACTIVATED)
-			kernfs_drain(pos);
+			kernfs_drain(pos, kn);
 		else
 			WARN_ON_ONCE(atomic_read(&kn->active) != KN_DEACTIVATED_BIAS);
 
+		kernfs_up_write(rwsem);
+
+		/**
+		 * By now node and all of its descendants have been deactivated
+		 * Once a descendant has been drained, acquire its parent's lock
+		 * and unlink it from parent's children rb tree.
+		 * We drop kn's lock before acquiring pos->parent's lock to avoid
+		 * deadlock that will happen if pos->parent and kn hash to same lock.
+		 * Dropping kn's lock should be safe because it is in deactived state.
+		 * Further root->kernfs_rm_mutex ensures that we will not have
+		 * concurrent instances of __kernfs_remove
+		 */
+		if (pos->parent)
+			rwsem = kernfs_down_write(pos->parent);
+
 		/*
 		 * kernfs_unlink_sibling() succeeds once per node.  Use it
 		 * to decide who's responsible for cleanups.
@@ -1398,8 +1481,12 @@ static void __kernfs_remove(struct kernfs_node *kn)
 			kernfs_put(pos);
 		}
 
+		if (pos->parent)
+			kernfs_up_write(rwsem);
 		kernfs_put(pos);
 	} while (pos != kn);
+
+	mutex_unlock(&root->kernfs_rm_mutex);
 }
 
 /**
@@ -1410,11 +1497,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
  */
 void kernfs_remove(struct kernfs_node *kn)
 {
-	struct rw_semaphore *rwsem;
-
-	rwsem = kernfs_down_write(kn);
 	__kernfs_remove(kn);
-	kernfs_up_write(rwsem);
 }
 
 /**
@@ -1516,9 +1599,11 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 	 */
 	if (!(kn->flags & KERNFS_SUICIDAL)) {
 		kn->flags |= KERNFS_SUICIDAL;
+		kernfs_up_write(rwsem);
 		__kernfs_remove(kn);
 		kn->flags |= KERNFS_SUICIDED;
 		ret = true;
+		rwsem = kernfs_down_write(kn);
 	} else {
 		wait_queue_head_t *waitq = &kernfs_root(kn)->deactivate_waitq;
 		DEFINE_WAIT(wait);
@@ -1572,11 +1657,17 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 
 	rwsem = kernfs_down_write(parent);
 
+	/**
+	 * Since the node being searched will be removed eventually,
+	 * we don't need to take root->kernfs_rm_mutex.
+	 * Even if a parallel remove succeeds, the subsequent __kernfs_remove
+	 * will detect it and bail-out early.
+	 */
 	kn = kernfs_find_ns(parent, name, ns);
-	if (kn)
-		__kernfs_remove(kn);
 
 	kernfs_up_write(rwsem);
+	if (kn)
+		__kernfs_remove(kn);
 
 	if (kn)
 		return 0;
@@ -1596,14 +1687,26 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 {
 	struct kernfs_node *old_parent;
 	const char *old_name = NULL;
-	struct rw_semaphore *rwsem;
+	struct kernfs_rwsem_token token;
 	int error;
+	struct kernfs_root *root = kernfs_root(kn);
 
 	/* can't move or rename root */
 	if (!kn->parent)
 		return -EINVAL;
 
-	rwsem = kernfs_down_write(kn);
+	mutex_lock(&root->kernfs_rm_mutex);
+	old_parent = kn->parent;
+	kernfs_get(old_parent);
+	kernfs_down_write_triple_nodes(kn, old_parent, new_parent, &token);
+	while (old_parent != kn->parent) {
+		kernfs_put(old_parent);
+		kernfs_up_write_triple_nodes(kn, old_parent, new_parent, &token);
+		old_parent = kn->parent;
+		kernfs_get(old_parent);
+		kernfs_down_write_triple_nodes(kn, old_parent, new_parent, &token);
+	}
+	kernfs_put(old_parent);
 
 	error = -ENOENT;
 	if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
@@ -1638,7 +1741,6 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	/* rename_lock protects ->parent and ->name accessors */
 	write_lock_irq(&kernfs_rename_lock);
 
-	old_parent = kn->parent;
 	kn->parent = new_parent;
 
 	kn->ns = new_ns;
@@ -1657,7 +1759,8 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 
 	error = 0;
  out:
-	kernfs_up_write(rwsem);
+	mutex_unlock(&root->kernfs_rm_mutex);
+	kernfs_up_write_triple_nodes(kn, new_parent, old_parent, &token);
 	return error;
 }
 
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index efe5ae98abf4..36a40b08b97f 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -101,6 +101,12 @@ int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 	int ret;
 	struct rw_semaphore *rwsem;
 
+	/**
+	 * Since we are only modifying the inode attribute, we just need
+	 * to lock involved node. Operations that add or remove a node
+	 * acquire parent's lock before changing the inode attributes, so
+	 * such operations are also in sync with this interface.
+	 */
 	rwsem = kernfs_down_write(kn);
 	ret = __kernfs_setattr(kn, iattr);
 	kernfs_up_write(rwsem);
@@ -118,6 +124,12 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (!kn)
 		return -EINVAL;
 
+	/**
+	 * Since we are only modifying the inode attribute, we just need
+	 * to lock involved node. Operations that add or remove a node
+	 * acquire parent's lock before changing the inode attributes, so
+	 * such operations are also in sync with .setattr backend.
+	 */
 	rwsem = kernfs_down_write(kn);
 	error = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (error)
@@ -188,6 +200,10 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 	struct kernfs_node *kn = inode->i_private;
 	struct rw_semaphore *rwsem;
 
+	/**
+	 * As we are only reading ->iattr, acquiring kn's rwsem for
+	 * reading is enough.
+	 */
 	rwsem = kernfs_down_read(kn);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
@@ -285,6 +301,10 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
 
 	kn = inode->i_private;
 
+	/**
+	 * As we are only reading ->iattr, acquiring kn's rwsem for
+	 * reading is enough.
+	 */
 	rwsem = kernfs_down_read(kn);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
diff --git a/fs/kernfs/kernfs-internal.c b/fs/kernfs/kernfs-internal.c
new file mode 100644
index 000000000000..80d7d64532fe
--- /dev/null
+++ b/fs/kernfs/kernfs-internal.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file provides inernal helpers for kernfs.
+ */
+
+#include "kernfs-internal.h"
+
+static void kernfs_swap_rwsems(struct rw_semaphore **array, int i, int j)
+{
+	struct rw_semaphore *tmp;
+
+	tmp = array[i];
+	array[i] = array[j];
+	array[j] = tmp;
+}
+
+static void kernfs_sort_rwsems(struct kernfs_rwsem_token *token)
+{
+	struct rw_semaphore **array = &token->rwsems[0];
+
+	if (token->count == 2) {
+		if (array[0] == array[1])
+			token->count = 1;
+		else if (array[0] > array[1])
+			kernfs_swap_rwsems(array, 0, 1);
+	} else {
+		if (array[0] == array[1] && array[0] == array[2])
+			token->count = 1;
+		else {
+			if (array[0] > array[1])
+				kernfs_swap_rwsems(array, 0, 1);
+
+			if (array[0] > array[2])
+				kernfs_swap_rwsems(array, 0, 2);
+
+			if (array[1] > array[2])
+				kernfs_swap_rwsems(array, 1, 2);
+
+			if (array[0] == array[1] || array[1] == array[2])
+				token->count = 2;
+		}
+	}
+}
+
+/**
+ * kernfs_down_write_double_nodes() - take hashed rwsem for 2 nodes
+ *
+ * @kn1: first kernfs_node of interest
+ * @kn2: second kernfs_node of interest
+ * @token: token to pass unlocking information to caller
+ *
+ * Acquire hashed rwsem for 2 nodes. Some operation may need to acquire
+ * hashed rwsems for 2 nodes (for example for a node and its parent).
+ * This function can be used in such cases.
+ *
+ * Return: void
+ */
+void kernfs_down_write_double_nodes(struct kernfs_node *kn1,
+				    struct kernfs_node *kn2,
+				    struct kernfs_rwsem_token *token)
+{
+	struct rw_semaphore **array = &token->rwsems[0];
+
+	array[0] = kernfs_rwsem_ptr(kn1);
+	array[1] = kernfs_rwsem_ptr(kn2);
+	token->count = 2;
+
+	kernfs_sort_rwsems(token);
+
+	if (token->count == 1) {
+		/* Both nodes hash to same rwsem */
+		down_write_nested(array[0], 0);
+	} else {
+		/* Both nodes hash to different rwsems */
+		down_write_nested(array[0], 0);
+		down_write_nested(array[1], 1);
+	}
+}
+
+/**
+ * kernfs_up_write_double_nodes - release hashed rwsem for 2 nodes
+ *
+ * @kn1: first kernfs_node of interest
+ * @kn2: second kernfs_node of interest
+ * @token: token to indicate unlocking information
+ *		->rwsems is a sorted list of rwsem addresses
+ *		->count contains number of unique locks
+ *
+ * Release hashed rwsems for 2 nodes
+ *
+ * Return: void
+ */
+void kernfs_up_write_double_nodes(struct kernfs_node *kn1,
+				  struct kernfs_node *kn2,
+				  struct kernfs_rwsem_token *token)
+{
+	struct rw_semaphore **array = &token->rwsems[0];
+
+	if (token->count == 1) {
+		/* Both nodes hash to same rwsem */
+		up_write(array[0]);
+	} else {
+		/* Both nodes hashe to different rwsems */
+		up_write(array[0]);
+		up_write(array[1]);
+	}
+}
+
+/**
+ * kernfs_down_read_double_nodes() - take hashed rwsem for 2 nodes
+ *
+ * @kn1: first kernfs_node of interest
+ * @kn2: second kernfs_node of interest
+ * @token: token to pass unlocking information to caller
+ *
+ * Acquire hashed rwsem for 2 nodes. Some operation may need to acquire
+ * hashed rwsems for 2 nodes (for example for a node and its parent).
+ * This function can be used in such cases.
+ *
+ * Return: void
+ */
+void kernfs_down_read_double_nodes(struct kernfs_node *kn1,
+				    struct kernfs_node *kn2,
+				    struct kernfs_rwsem_token *token)
+{
+	struct rw_semaphore **array = &token->rwsems[0];
+
+	array[0] = kernfs_rwsem_ptr(kn1);
+	array[1] = kernfs_rwsem_ptr(kn2);
+	token->count = 2;
+
+	kernfs_sort_rwsems(token);
+
+	if (token->count == 1) {
+		/* Both nodes hash to same rwsem */
+		down_read_nested(array[0], 0);
+	} else {
+		/* Both nodes hash to different rwsems */
+		down_read_nested(array[0], 0);
+		down_read_nested(array[1], 1);
+	}
+}
+
+/**
+ * kernfs_up_read_double_nodes - release hashed rwsem for 2 nodes
+ *
+ * @kn1: first kernfs_node of interest
+ * @kn2: second kernfs_node of interest
+ * @token: token to indicate unlocking information
+ *		->rwsems is a sorted list of rwsem addresses
+ *		->count contains number of unique locks
+ *
+ * Release hashed rwsems for 2 nodes
+ *
+ * Return: void
+ */
+void kernfs_up_read_double_nodes(struct kernfs_node *kn1,
+				  struct kernfs_node *kn2,
+				  struct kernfs_rwsem_token *token)
+{
+	struct rw_semaphore **array = &token->rwsems[0];
+
+	if (token->count == 1) {
+		/* Both nodes hash to same rwsem */
+		up_read(array[0]);
+	} else {
+		/* Both nodes hashe to different rwsems */
+		up_read(array[0]);
+		up_read(array[1]);
+	}
+}
+
+/**
+ * kernfs_down_write_triple_nodes() - take hashed rwsem for 3 nodes
+ *
+ * @kn1: first kernfs_node of interest
+ * @kn2: second kernfs_node of interest
+ * @kn3: third kernfs_node of interest
+ * @token: token to pass unlocking information to caller
+ *
+ * Acquire hashed rwsem for 3 nodes. Some operation may need to acquire
+ * hashed rwsems for 3 nodes (for example rename operation needs to
+ * acquire rwsem corresponding to node, its current parent and its future
+ * parent). This function can be used in such cases.
+ *
+ * Return: void
+ */
+void kernfs_down_write_triple_nodes(struct kernfs_node *kn1,
+				    struct kernfs_node *kn2,
+				    struct kernfs_node *kn3,
+				    struct kernfs_rwsem_token *token)
+{
+	struct rw_semaphore **array = &token->rwsems[0];
+
+	array[0] = kernfs_rwsem_ptr(kn1);
+	array[1] = kernfs_rwsem_ptr(kn2);
+	array[2] = kernfs_rwsem_ptr(kn3);
+	token->count = 3;
+
+	kernfs_sort_rwsems(token);
+
+	if (token->count == 1) {
+		/* All 3 nodes hash to same rwsem */
+		down_write_nested(array[0], 0);
+	} else if (token->count == 2) {
+		/**
+		 * Two nodes hash to same rwsem, and these
+		 * will occupy consecutive places in array after
+		 * sorting.
+		 */
+		down_write_nested(array[0], 0);
+		down_write_nested(array[2], 1);
+	} else {
+		/* All 3 nodes hashe to different rwsems */
+		down_write_nested(array[0], 0);
+		down_write_nested(array[1], 1);
+		down_write_nested(array[2], 2);
+	}
+}
+
+/**
+ * kernfs_up_write_triple_nodes - release hashed rwsem for 3 nodes
+ *
+ * @kn1: first kernfs_node of interest
+ * @kn2: second kernfs_node of interest
+ * @kn3: third kernfs_node of interest
+ * @token: token to indicate unlocking information
+ *		->rwsems is a sorted list of rwsem addresses
+ *		->count contains number of unique locks
+ *
+ * Release hashed rwsems for 3 nodes
+ *
+ * Return: void
+ */
+void kernfs_up_write_triple_nodes(struct kernfs_node *kn1,
+				  struct kernfs_node *kn2,
+				  struct kernfs_node *kn3,
+				  struct kernfs_rwsem_token *token)
+{
+	struct rw_semaphore **array = &token->rwsems[0];
+
+	if (token->count == 1) {
+		/* All 3 nodes hash to same rwsem */
+		up_write(array[0]);
+	} else if (token->count == 2) {
+		/**
+		 * Two nodes hash to same rwsem, and these
+		 * will occupy consecutive places in array after
+		 * sorting.
+		 */
+		up_write(array[0]);
+		up_write(array[2]);
+	} else {
+		/* All 3 nodes hashe to different rwsems */
+		up_write(array[0]);
+		up_write(array[1]);
+		up_write(array[2]);
+	}
+}
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 0c49cf57f80f..4e630abe4a18 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -19,6 +19,20 @@
 #include <linux/kernfs.h>
 #include <linux/fs_context.h>
 
+/**
+ * Token for nested locking interfaces.
+ *
+ * rwsems: array of rwsems to acquire
+ * count: has 2 uses
+ *	  As input argument it specifies size of ->rwsems array
+ *	  As return argument it specifies number of unique rwsems
+ *	  present in ->rwsems array
+ */
+struct kernfs_rwsem_token {
+	struct rw_semaphore *rwsems[3];
+	int count;
+};
+
 struct kernfs_iattrs {
 	kuid_t			ia_uid;
 	kgid_t			ia_gid;
@@ -46,8 +60,8 @@ struct kernfs_root {
 	struct list_head	supers;
 
 	wait_queue_head_t	deactivate_waitq;
-	struct rw_semaphore	kernfs_rwsem;
 	struct rw_semaphore     supers_rwsem;
+	struct mutex            kernfs_rm_mutex;
 };
 
 /* +1 to avoid triggering overflow warning when negating it */
@@ -165,11 +179,17 @@ void kernfs_drain_open_files(struct kernfs_node *kn);
  */
 extern const struct inode_operations kernfs_symlink_iops;
 
+/*
+ * kernfs locks
+ */
+extern struct kernfs_global_locks *kernfs_locks;
+extern rwlock_t kernfs_rename_lock;
+
 static inline struct rw_semaphore *kernfs_rwsem_ptr(struct kernfs_node *kn)
 {
-	struct kernfs_root *root = kernfs_root(kn);
+	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
 
-	return &root->kernfs_rwsem;
+	return &kernfs_locks->kernfs_rwsem[idx];
 }
 
 static inline void kernfs_rwsem_assert_held(struct kernfs_node *kn)
@@ -243,4 +263,30 @@ static inline void kernfs_up_read(struct rw_semaphore *rwsem)
 	up_read(rwsem);
 }
 
+
+void kernfs_down_write_double_nodes(struct kernfs_node *kn1,
+				    struct kernfs_node *kn2,
+				    struct kernfs_rwsem_token *token);
+
+void kernfs_up_write_double_nodes(struct kernfs_node *kn1,
+				  struct kernfs_node *kn2,
+				  struct kernfs_rwsem_token *token);
+
+void kernfs_down_read_double_nodes(struct kernfs_node *kn1,
+				    struct kernfs_node *kn2,
+				    struct kernfs_rwsem_token *token);
+
+void kernfs_up_read_double_nodes(struct kernfs_node *kn1,
+				  struct kernfs_node *kn2,
+				  struct kernfs_rwsem_token *token);
+
+void kernfs_down_write_triple_nodes(struct kernfs_node *kn1,
+				    struct kernfs_node *kn2,
+				    struct kernfs_node *kn3,
+				    struct kernfs_rwsem_token *token);
+
+void kernfs_up_write_triple_nodes(struct kernfs_node *kn1,
+				  struct kernfs_node *kn2,
+				  struct kernfs_node *kn3,
+				  struct kernfs_rwsem_token *token);
 #endif	/* __KERNFS_INTERNAL_H */
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 0e872824b7db..5efa0f4ca209 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -395,8 +395,10 @@ void __init kernfs_lock_init(void)
 	kernfs_locks = kmalloc(sizeof(struct kernfs_global_locks), GFP_KERNEL);
 	WARN_ON(!kernfs_locks);
 
-	for (count = 0; count < NR_KERNFS_LOCKS; count++)
+	for (count = 0; count < NR_KERNFS_LOCKS; count++) {
 		mutex_init(&kernfs_locks->open_file_mutex[count].lock);
+		init_rwsem(&kernfs_locks->kernfs_rwsem[count]);
+	}
 }
 
 void __init kernfs_init(void)
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 9d4103602554..5e404ea455bd 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -110,15 +110,20 @@ static int kernfs_get_target_path(struct kernfs_node *parent,
 
 static int kernfs_getlink(struct inode *inode, char *path)
 {
+	unsigned long flags;
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_node *parent = kn->parent;
 	struct kernfs_node *target = kn->symlink.target_kn;
-	struct rw_semaphore *rwsem;
 	int error;
 
-	rwsem = kernfs_down_read(parent);
+	/**
+	 * kernfs_get_target_path needs that all nodes in the path don't
+	 * undergo a parent change in the middle of it. Since ->parent
+	 * change happens under kernfs_rename_lock, acquire the same.
+	 */
+	read_lock_irqsave(&kernfs_rename_lock, flags);
 	error = kernfs_get_target_path(parent, target, path);
-	kernfs_up_read(rwsem);
+	read_unlock_irqrestore(&kernfs_rename_lock, flags);
 
 	return error;
 }
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index cc514bda0ae7..19506bdb6d2b 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -87,6 +87,7 @@ struct kernfs_open_file_mutex {
  */
 struct kernfs_global_locks {
 	struct kernfs_open_file_mutex open_file_mutex[NR_KERNFS_LOCKS];
+	struct rw_semaphore kernfs_rwsem[NR_KERNFS_LOCKS];
 };
 
 enum kernfs_node_type {
-- 
2.30.2

