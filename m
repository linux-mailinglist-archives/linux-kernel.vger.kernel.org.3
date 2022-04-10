Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C7E4FAB88
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 04:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243386AbiDJCkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 22:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243383AbiDJCjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 22:39:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30038101EA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 19:37:43 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 239ExwMM031505;
        Sun, 10 Apr 2022 02:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=nQ3EhoPXc/tbOU5tY7HUOBL5NKWlW/IuyKIivC5/1QM=;
 b=F/3aO7G19CkVdhGCppeK8u0NScTq7TyA4N5Tz9+qX8pRnCXGHl7oJN1OhLqgkDWMgwyH
 NodmElyBP/YMCkrqPM/2LwTKjMOBi8J5GhL0dD9WcNcorHTCPuQKBd4Kjbh2pp98mFRZ
 CENW9h/XPQuECu0GpZF53fOt6dwdnNbWqyJz8PkcgR4pDYBSyLymNmNHiN2Fgv/6uEQY
 R0xOoCBMA3JDij5RXZSE6Br11tE/+PjjN12osi5y+JgYAWBUuIuvhns8FU0hRbVrAVhO
 gB3uPto2sOU8YLHqgYhif1tbhqMRoQFG5rvhuYwgZWx8fzp5XqFT2VhJyezm+tSSQtMu SQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rs0yqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Apr 2022 02:37:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23A2VFxE034320;
        Sun, 10 Apr 2022 02:37:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k0gmt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Apr 2022 02:37:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAhJa5KlL5m2ZzYADb6jIG2bvf/1wWAhkhW+fnGCCAZ8eJLJCsUrjSe2s4ihDgvkzeRz1/mmFxQYtShq4EcmLb5zv/GbFa2W8WhApY/QpaBryb68P+ppq76jSSK6SdyPRIsEV96Ettk2Ul+bdDm0gKsNs6rBQdd5iuORBBJp25R6KL06vL72rbkFOJnWNSv7ft/IUqav7tfWbSyNGA+KyT6HBwbpSyq255FTIj2yOydAU6Fn5r2FAOOAhVWa7IyIxmUJbFhbcfdQL01X7FgkftUOeO97JkYEt6ecK2gPKlUYsY9SVE8+BrgsFeOKFlnBOvxxRBAU1+BNNZUCLXD39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQ3EhoPXc/tbOU5tY7HUOBL5NKWlW/IuyKIivC5/1QM=;
 b=ftWumAsw8joCtLDNwdVLnQC9Z3mBLMUurjOMmMbZBSnz/0eHZeF5WCQmgF/S0i79bYH2ZhkG1b3EIvStV7oqtuCsL8fDA1pTVKVxhXa2MH5ovg8Io7V/M3fmsvq+Ee85r5wYSwUiEibzNEq5WxQjyIIY1tDx6fq8izETAE9sJKLTB+5+xOKUXf32TDIbcU+P+/q191XBmVkF6F6yKDezunJ5TEfYpf7FK0ICXC2dq8Sq+ydxWrRbIsFd76aPZjzoNH7vw6bF3yILxSHEyGMxncoQim8zZqjK2KdsM3/nRC1oT5AGwcG2H5gbK+ExQ6Q73xtuuqMCllccPj1K3xVioA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQ3EhoPXc/tbOU5tY7HUOBL5NKWlW/IuyKIivC5/1QM=;
 b=gayx70pYBFSbirxBqYYKc0UbboGou1Wm6OVtWTT/t0/HiryduBLCh8xhaqcIn71Xh/ay11L6mM0E6q9IAzxtEYrYh/AOcT+c9CjNcCRVs5gpx8qKhOApaj9tzAoNkpW/bOxXEgWK4nrM4FQbMblxVTScO6Rvm2yJiDg5oXEWo9M=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CY4PR10MB1238.namprd10.prod.outlook.com (2603:10b6:910:7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.28; Sun, 10 Apr
 2022 02:37:33 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5144.028; Sun, 10 Apr 2022
 02:37:33 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        ebiederm@xmission.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v8 00/10] kernfs: Remove reference counting for kernfs_open_node.
Date:   Sun, 10 Apr 2022 12:37:09 +1000
Message-Id: <20220410023719.1752460-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0054.ausprd01.prod.outlook.com
 (2603:10c6:10:2::18) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1030703-a3bb-42f6-08dd-08da1a9b10d4
X-MS-TrafficTypeDiagnostic: CY4PR10MB1238:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB12382DB00BCDA6BD53AD2FF0B0EB9@CY4PR10MB1238.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1utFbyoen/xdYdE6Khn3BmcWjlNrIawC44wD5nFfKMA9rr6PIrXrXtoL48eM4iQqZoECwvLXEwUL0xMPBSOitGi6mSQcd1s8LTnnXprOn4EpUdekuFT0SkG06tlFXupPNCmn5LHYsjCfYrj0jFxNFdgbK1JThpT222/jyTxhBwXfzB2PReyAEzzMZAE4zSVHyUxueMdz/USDI6AmwM1ETB9Ja7N0x5JheryA1fU6a6M0XuLWrnn0EYSAEXNjnvQCxEILsw7lOipQOTdOj/YIaSzfiW4vt00lLi4tmTUuTd+qkciHsJ4UhRiEWo/XPzD4C2EvtJf7gudqVMVpCQbP3+2NO55q5n6U4ew5VS5PmOZ2MDmwuas1ksY1ak6IZewaI1sHFDtkwLPaXoo8VN78hNfQOl/nElMD5ItFiBe7l0U3PYmyZYMp/Vql1iIIXud+DgFSgPZ3ffBO4Fhfmj+8vjEazK1keYLdUImgBUpzeYH1gTZo08zt1w/3n/RwJDBm3WtdtfRi28vX6Mt4JF+l+Mk/TJxAQOWAk00iM5TZDXUeUtE668qHddl5Akgl0zVFVTQ3J7EnE8IOltePK7n+oNBknmTWS8SI6ZBJga3atdhsiE7suAsG2HWWW1hsJHuA0pr7fTAPOQSUagzR6dFSn2QxcnxfuTJ7GIpSz4XPRGbUTzSO6Nfmqj0TchSOXTUmEJav44hdeHXZUWWy/Nz2Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(26005)(186003)(66946007)(66556008)(66476007)(8676002)(4326008)(83380400001)(36756003)(316002)(6486002)(103116003)(508600001)(8936002)(2616005)(6666004)(5660300002)(38100700002)(38350700002)(86362001)(2906002)(6512007)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TTBEowvACGxSM63r1C9RfMbCulFTzi+COnqV3JMIhnTGMlNO9Od2nWb8fzAG?=
 =?us-ascii?Q?UyfYfZ8Y5fDm5i8zX37B8zaz7jpNa+ilz01t2HoWbyuqGPuiobsm1fyi2hIh?=
 =?us-ascii?Q?0bG3KRR55INnh2suGKnhH5d3nOka08+RKtBunVzubCZ4nhP+UgRF5UuXt9nA?=
 =?us-ascii?Q?jn9LoTPfPoBpUT0tE6POzKDUjjE788O0DToa+6Ls13ZZBIlD2tS7K8FXc6ZO?=
 =?us-ascii?Q?QYVpKTQV0AwDrPTIDUm+9WhaG4Y2Nrp08VSDnV9nOEO5hTHuAYgSmeEwq487?=
 =?us-ascii?Q?V43YCDWiccL5XXNZfu7YjLjJa570lkp2NpUCPaVz5LK4sJWunGApOaC5ryhx?=
 =?us-ascii?Q?lL4LlNWwJrDi9gzUl55TjpyKhVQQ3y4KBsFQrkePaCdHFE+/nntlIc1r8hDU?=
 =?us-ascii?Q?7AEjuEMdH/EqqzuaeYZ5tDEJITsyITVaXy3I5DY/J56ph3dEPCN0jr5F00b5?=
 =?us-ascii?Q?QyWGEwZi+lzrkyZDOVBdufk9VyJx3ejzKSuZmqXh53M+x3BLtWjzPNIk+QzU?=
 =?us-ascii?Q?+tfO8I5vmIdqlVwFOZD+5ib1SDzqRRDcjAvw7UlkGBUhXAPoyiykW56xR5Y+?=
 =?us-ascii?Q?/mciZ7QHzmQxhDNyfFC9bkePyNx78aHRQtVar8NT0kblHSYhM0LEPYCEuW42?=
 =?us-ascii?Q?QsxW0/cYKlhuCStCcZk/ymgirzC21K26rrVKnAUFyMMERNK+egMhbr/88kgm?=
 =?us-ascii?Q?jrUVgM1iyUlQrdnlpS356DliNPSJVAaAUiSAL9OOICn9gyimm7VndDqLLTsC?=
 =?us-ascii?Q?UOZJX92fe/7xY2IHV4XsSM5uxumxksZSAOqBYmY2irDW+2+uBDrrkYIoUmGa?=
 =?us-ascii?Q?jzJb8Ug19PJzOFsfNW6vl7UDpMwnIGwsQ7oJgmIJXgJfAZk4t9A3dW6FhChR?=
 =?us-ascii?Q?9gvXQ0207bTA3Lcl7UKlFctsAkjWzX3i+T2a4A8ZZjDeil4duqKHfBhATCVR?=
 =?us-ascii?Q?C6weYnrptUONBSjGOCoMEg0KFhJ5MtxFcT9Mwy/6/2wpqxpCVryIrdcDPgkp?=
 =?us-ascii?Q?S016OuhHgrFwAwBh7er9TwrUap5AgzaEToDwnk4DndetsXo3fJzkEtqUDn26?=
 =?us-ascii?Q?NNGBKsboHP2TXMitg75hy2/WAPRNWCSTgNfFKc4dFwVwYQtY3ckDrXic/6oZ?=
 =?us-ascii?Q?nebnWxturo3cxQWf5x27zOAWw4yqkD+4F/Fh/FcBhLo9YVIJoFf+bcOZYau+?=
 =?us-ascii?Q?QC/5DFmaVmqdwDNGnUFcdkCOLbOf12pOU06BdhpRXznbw1t6qFTs2ElEVs5/?=
 =?us-ascii?Q?lXKt5/09dxNkySBX3UAsoxL8bkyorY1a+vmPVPY9NXwIVtBEOBx5qRIgpgHK?=
 =?us-ascii?Q?a5OLA29QpPhp2nB2acs9UtVh630GzU27m4x7KSdnw3fN8REoRFb969G0DrV6?=
 =?us-ascii?Q?T9pgOnHoQahb7dTko4uLQ4sPUh2ORIELNdvrxJRWbaDVdnORMgM4vPdkpzY5?=
 =?us-ascii?Q?O349OwOeGsIBpxHpI2D/PI/drhGayh02KlvTEM+X48jtaMva6XjLpDLJd7MS?=
 =?us-ascii?Q?fFp+Wiek/j15drOBtoeovCHT2tdy5dbVbRgns4NxY6tutVNLAFAVNiHZBymf?=
 =?us-ascii?Q?F8KJUVs3wTKHJTV/Ilk3K8KEtSs7tdw75AQBqAeXsjYYlCJhcamnGvew0PiD?=
 =?us-ascii?Q?snWswEd9zqkqhlv4N4vcgSbD6mt3TZU2HBLxquBBXWLt4WyZ4cRaYlQl5WfM?=
 =?us-ascii?Q?/8jdEyOmCOeTciY1+aSRm93Gr+Vcu7UAynqx/P4vgwBSJ5AhpV42yBMJnrU4?=
 =?us-ascii?Q?T8tQ97gnIFP4C3LzTYJPSVK2NVJY5DU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1030703-a3bb-42f6-08dd-08da1a9b10d4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2022 02:37:33.3899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1a6mZ2erjuqaOgyDmXnStikKgkHiOhHzUl2JhOiIwso9EQyYOBEOw09Z6XMaV3MB3F5QfYltWo3YFLhsIzT3HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1238
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-09_25:2022-04-08,2022-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204100014
X-Proofpoint-ORIG-GUID: YN3Ltdej63kMumCQA3kqdTYl08GKmUZV
X-Proofpoint-GUID: YN3Ltdej63kMumCQA3kqdTYl08GKmUZV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce contention around global locks used in kernfs.

The current kernfs design makes use of 3 global locks to synchronize
various operations. There are a few other global locks as well but
they are used for specific cases and hence don't cause severe contention.

The above mentioned 3 main global locks used in kernfs are:

1. A global mutex, kernfs_open_file_mutex, to protect the list of
kernfs_open_file instances correspondng to a sysfs attribute.

2. A global spinlock, kernfs_open_node_lock, to protect
kernfs_node->attr.open which points to kernfs_open_node instance
corresponding to a kernfs_node.

3. A global per-fs rw semaphore, root->kernfs_rwsem, to synchronize most
of the other operations like adding, removing, renaming etc. of a file
or directory.

Since these locks are global, they can cause contention when multiple
(for example few hundred) applications try to access sysfs (or other kernfs
based file system) files in parallel, even if the applications are
accessing different and unrelated files.

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

This patch set is reducing the above mentioned contention by replacing
these global locks with hashed locks. 

For example with the patched kernel and on the same test setup, we no
longer see contention around osq_lock (i.e kernfs_open_file_mutex) and also
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

Moreover the test execution time has reduced from 32-34 secs to 15-16 secs.

The patches of this patchset introduce following changes:

PATCH-1: Remove reference counting from kernfs_open_node.

PATCH-2: Make kernfs_open_node->attr.open RCU protected.

PATCH-3: Change kernfs_notify_list to llist.

PATCH-4: Introduce interface to access kernfs_open_file_mutex.

PATCH-5: Replace global kernfs_open_file_mutex with hashed mutexes.

PATCH-6: Use a per-fs rwsem to protect per-fs list of kernfs_super_info.

PATCH-7: Change kernfs_rename_lock into a read-write lock.

PATCH-8: Introduce interface to access per-fs rwsem.

PATCH-9: Replace per-fs rwsem with hashed rwsems.

PATCH-10: Add a document to describe hashed locks used in kernfs.

------------------------------------------------------------------

Changes since v7:
 - Addressed review comments from Al Viro
	- Remove reference counting for kernfs_open_node
	- Remove kernfs_open_node_lock and make ->attr.open RCU protected
	- Change kernfs_rename_lock to a read-write lock
	- Lock involved nodes before invoking kernfs_find_ns from kernfs_walk_ns
	- Change kernfs_notify_list to llist

 - Addressed review comments from Eric
	- Move interface to access kernfs_open_file_mutex to file.c
 
 - Update document about hashed locks
	
 - Rebase on tag next-20220407

Changes since v6:
 - Addressed review comments from Tejun
	- Make locking helpers compact and remove unlock_parent from node.
 
 - Addressed review comments from Al Viro
	- Make multi node lock helpers non-inline
	- Account for change of parent while waiting on semaphores during
	  rename operation
	- Add a document to describe hashed locks introduced in this patch
	  and to provide proof of correctness 
 
 - Fix for some issues that I observed while preparing lock correctness
   document
	- Lock both parent and target while looking for symlink
	- Introduce a per-fs mutex to synchronize lookup and removal of a node
	- Avoid locking parent in remove_self, because only the first instance
	  does actual removal so other invocations of remove_self don't need
	  to lock the parent
 
 - Remove refcounting from lock helpers
	- Refcounting was present in lock helpers for cases where an execution
	  path acquires node's rwsem and then deletes the node. For such cases
	  release helpers should not try to acquire semaphore for this already
	  freed node. Refcounting was ensuring that release helpers could get
	  an still existing node.
	  I have modified locking helpers such that helpers that acquire rwsem
	  returns its address which can later be used by release helpers.

Changes since v5:
 - Addressed review comments from Greg
	- Clean up duplicate code.
 - Addressed review comments from Tejun
	- Explain how current value of NR_KERNFS_LOCKS were obtained for
	  different values of NR_CPUS.
	- Use single hash table for locks in place of per-fs hash table
	  for locks.
	- Move introduction of supers_rwsem to a separate patch.
	- Separate interface and usage part of hashed rwsem implementation
	  into 2 patches.
	- Use address of rwsems to determine locking order in case of
	  nested locking. This approach avoids ABBA deadlock possibility.
	- Change some #define macros into enum, with proper prefix.
 - Taking a cue from Tejun's feedback about separating hashed rwsem
   interface and usage into 2 patches, I have also divided the patch
   that introduced hashed mutex and spinlock, into separate patches. 	  
 - Rebase on linux-next tag: next-20220211

Changes since v4:
 - Removed compilation warnings reported by the 0-day bot.

Changes since v3:
 - Make open_file_mutex and open_node_lock per-fs.
 - Replace per-fs rwsem with per-fs hashed rwsem.
   (Suggested by Tejun Heo <tj@kernel.org>)

Imran Khan (10):
  kernfs: Remove reference counting for kernfs_open_node.
  kernfs: make ->attr.open RCU protected.
  kernfs: Change kernfs_notify_list to llist.
  kernfs: Introduce interface to access global kernfs_open_file_mutex.
  kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.
  kernfs: Use a per-fs rwsem to protect per-fs list of
    kernfs_super_info.
  kernfs: Change kernfs_rename_lock into a read-write lock.
  kernfs: Introduce interface to access per-fs rwsem.
  kernfs: Replace per-fs rwsem with hashed rwsems.
  kernfs: Add a document to describe hashed locks used in kernfs.

 .../filesystems/kernfs-hashed-locks.rst       | 214 ++++++++++++++
 fs/kernfs/Makefile                            |   2 +-
 fs/kernfs/dir.c                               | 272 ++++++++++++------
 fs/kernfs/file.c                              | 228 ++++++++-------
 fs/kernfs/inode.c                             |  48 +++-
 fs/kernfs/kernfs-internal.c                   | 259 +++++++++++++++++
 fs/kernfs/kernfs-internal.h                   | 127 +++++++-
 fs/kernfs/mount.c                             |  30 +-
 fs/kernfs/symlink.c                           |  11 +-
 include/linux/kernfs.h                        |  62 +++-
 10 files changed, 1041 insertions(+), 212 deletions(-)
 create mode 100644 Documentation/filesystems/kernfs-hashed-locks.rst
 create mode 100644 fs/kernfs/kernfs-internal.c


base-commit: 2e9a9857569ec27e64d2ddd01294bbe3c736acb1
-- 
2.30.2

