Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A834A73A9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345138AbiBBOu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:50:56 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26002 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231220AbiBBOuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:50:54 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212DBw9I011396;
        Wed, 2 Feb 2022 14:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=FFz38I7GOG5UmgX72QOtznBmFiB45tWkntLjkYTugtw=;
 b=Rt+Om4/XKzPpQVoXepph3F85t+GirL53/kyfbENGaWYoS1AVsHeV6EfDx/LUlVZmHkFk
 suK069Y/0Mcat9EUEuC5QvZN9mE5gWwkyihywk7dFPsls7DBwLyuoUd6fEjbZ6xDcRV3
 kaK77gSznr/irlQtu8/VCbhsiv1kE40jp4AiKVx6wCT/s5DLpigCaSpImOjNGyywTjv+
 vbaHSYiVbSjEI1IQA9bcfUWTEkaP+rE4p2Re0RxVirCsWTq345UZJEZ6tE9AIAfI4Y/B
 oc8tJOvylnUuOmteG549zA+oPciRYo4+NiceUL7YS+WYTnQ1b+Rt7rq4b7iGEL5+fOud eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fx9fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 14:50:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212EfRB6114549;
        Wed, 2 Feb 2022 14:50:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by userp3030.oracle.com with ESMTP id 3dvtq2s84m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 14:50:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXLUfZz7xdANBn7xd+OOdPAlgiY2ZgafCjzvi82e962mJN+aVw0t3hRTYJNtiaTIZPkw6b8lKlXu+bODglU9YIrPhUK4NiN5/2q04vXttcFH9IjpX9RPlXYtrluNXYwSK18l0AxTDQ/4doPH0YON7Q6inSXTMlIa5eQ5lgtoPuelmou4dUfLg7EAtgn88pVgsefkrdEasYce+C3mVWy7vxb41JZR+I9URCaAQkcg10w/f/qNbrhCXhhkwbm5sC3ByCU3r739vQecy+P8zDrva6HTy+pH+iOvAbZGEow85kPrF0ObuTbql9LfJMqWVf3KVq9XoC+6pfG/FmOOGrs61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFz38I7GOG5UmgX72QOtznBmFiB45tWkntLjkYTugtw=;
 b=JicaNqC328gbOwV6oweB7bK0eMppI5D1nDhADqUE+RlEBsSD6klgTyFAyYU41ElA9HqAiQGT6UR5BGUonscosWXzsevHlkakWqqFWYFksyXSUayT31tAhuK0HcX+uF5qEaf/54OnLsO6oConlrKbrTj6iaiAYb33nfz6zInUMeneGA9DaBu8X3oilMWx4uWUF7CCmKlnjhVxCvZQDmmF0O+tfZPrbt3y/i4NZHyk+VTxKsfpEHhu4Cglz7VWlpQHNwm8duT3jZK6DkSmc5dNxeFXYE7uY7Y79GypAQbsi46znDhbvcVbnQqLGjUbs67DPS2IBVtYGq8Us6t73iCP6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFz38I7GOG5UmgX72QOtznBmFiB45tWkntLjkYTugtw=;
 b=G9IpotXOAaxdVtRDnOl2joRbfrjsHfOINBVcPp0kkmCc3m7rZ1A31MUoX/FWvW1sPh3hbIWyCd8sXoDSXC46r8DF8ebR9+UYkphpPSRAl0Ul8Tb7g2lt4e5LHxugxXmtOZ24rh3CP+jjSrxitIsc482pQDqJRt82F1P+G4M+loI=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MN2PR10MB3597.namprd10.prod.outlook.com (2603:10b6:208:117::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Wed, 2 Feb
 2022 14:50:43 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1%3]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 14:50:43 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] kernfs: use hashed mutex and spinlock in place of global ones.
Date:   Thu,  3 Feb 2022 01:50:25 +1100
Message-Id: <20220202145027.723733-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::30) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb7ae6f0-8401-44f9-7014-08d9e65b6332
X-MS-TrafficTypeDiagnostic: MN2PR10MB3597:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB359792EB6E34D081EBBB16AFB0279@MN2PR10MB3597.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W2HJgnflkgQHhLLnKP6d4/twRyAOk7y4+w85A2pQumzXv4a14nefxvL6Ru2ttoiRREfMbGNH0E8Vrtp5bB9kfRBPotqIt+as6Ro6sNl+3T4/V3d6gb8aU53RK+tuD7ZOK7GAg90iAE0AXNIJpyZazh9UrVNs8lP4mU3LM8/XHcq2CQXQmu2weTfI/avFvBROIo3BdwVnNE12yMOyBfVr/GEjRzrVl9yeh/WTsbYOACt5MC+bPOu4U1HRyrZipHauciHH+5CCO+WEWWDfShU4Lhr+oGCgTCcK0BjwOp16lQXA8fBbZP7srjIaI/0gIbwHF4GhAvvf1I3FnLDA+e4/KSuIchLi0a2FLumqviVlWYo1zJVpYpZcf4Z0H6xmJ6Ad3MdVQnBOt5EhYMgBLLYwdVSyxgpq4ibb7d3UWsFMgifc4iqE51vL7sWEsx3HObf2JbASazLDJDAiIeLmSCvLou8gdpiRbwbXaz2nJBOL/sTaquHz0i9YkzQUFLUoZYmUI+vNqA9yM9/qqfqyp/A23Gl6vH8Q/I7xulDQJCR6ALfAZKBdQVP2BMROvDJ9UX+zrYp2KwiwtVWX7lwX+YTbdu/SPY3ADtfB02gSonVb0GgyzkkSXjhGoJ0FWU64gGyUAECg8AKHQUEgppJYe5I9IQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(1076003)(66556008)(66946007)(2616005)(36756003)(6506007)(52116002)(6666004)(38100700002)(6512007)(5660300002)(86362001)(508600001)(6486002)(186003)(2906002)(103116003)(4326008)(8936002)(8676002)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JjGdEcjwv6UJQpjdE+D5xZPhDgKVOXpm7GZVqbKvK9egiXZM9coGyuwaclgq?=
 =?us-ascii?Q?TcaBwW1qwz3G8kTneRbGtXrYjTRmeYZThriM+nBpefDteQCAMKk+MxlZWbJ6?=
 =?us-ascii?Q?ZCbGs1+z6r4fVy5m2MiIXxyJPsX/HmHRL1G1WBiC/AbLhdqEl8ZSC70p3baM?=
 =?us-ascii?Q?c/SaNaUzbNi+Q3iErVPctGNAPbnU7Wwi4zzMac9RO2IUcRAxrH645uBuB7BE?=
 =?us-ascii?Q?MQ9F/RJbKMYThhIKWlpXKuBknZkTzfK7fVBI/Dhtb0RegGbTOv5d85acV0ch?=
 =?us-ascii?Q?awPcaCAQH0J4TCFuvIokbFdZ5KgLjYB2nY7fjd2OKeQptIRIDXwVSuxN65QM?=
 =?us-ascii?Q?wQ8ToO09UrBMg8iHvIAyiZ6wXQr3O71dMzBBzOd7xesEmsdMXJhCEQJpaGGJ?=
 =?us-ascii?Q?vmm+Z0qkTd8uzpobbji8eLgDgidBYbsNGo208gfoKJBcLD/oSw8n/Xb9cIva?=
 =?us-ascii?Q?iLvqCJ8MNz+oY8/ewM7SgSIUITH9L+GQuxJmHb0+DzB5ww/YFWHz6O5K3kL7?=
 =?us-ascii?Q?ulNmFyR1OMYNRWIcesB62XyBKfBlwwCtdZyTC4oWhMjeFLOznokl63eYJxoB?=
 =?us-ascii?Q?ORVgfwcU7BQEaek+9BIvOTDWzIi1a48pUw57+XEgepdr8p9eNBa/QygJ2A2t?=
 =?us-ascii?Q?/iOKuhllkFfVLrmu2u/HfqQSihqxyIguzb7HoBS6WRRhkbrcNwVI0cDh812w?=
 =?us-ascii?Q?R2qZ6cU3n//wCuFa5FdALii0tRQaxjClG79kTc+PKDSucPcqGvr6N7eQTgur?=
 =?us-ascii?Q?+8o9aOyeqxkYuATqAHLS6fXTlIZW7GZ7+KWp99/ENjiT8TdeOfotEX0zYkQj?=
 =?us-ascii?Q?jgrKqxQCgH2luOnEIuJvuViR6T0SCzyttDuRtGDzsEtVd7mcmXEZrL8Y5hVh?=
 =?us-ascii?Q?/luMk5eFJWddpI/v4jWo/gLtFyL9z6jEGmVOUiuaPf7GflhGrkIQEnxkX7wr?=
 =?us-ascii?Q?hL1Db4jCVlrnxnqk/lO46+rhpn3Y4bS83ab80Q9ANLqI+PyV8Vl3XIfibxr6?=
 =?us-ascii?Q?F4ufDTbHIjqPgxsbP6bfcqffLEBbcjKn+2W8tZOEPskzAbMhbMwXsA8505v9?=
 =?us-ascii?Q?Kb/0iLcue3W8BKZQbF7BqyKrwyAtLqMaliTsF5uBRtmplpQ9TlhWxDnLR5gI?=
 =?us-ascii?Q?LBS034CI9MNTYOcxTFKu+GooUzF+hp4hMfGdKW7lm1GWZV+8z1kN1hNWYkFn?=
 =?us-ascii?Q?Z9/iiBbrFePMNRc+x9EeNdMGrzPpk4aV2WiQe28Y0nmJqKmJD0W5PChRgXzF?=
 =?us-ascii?Q?V9FOMgwN5sRp9TKWcS6kcEGSJpmpUsW7SmQsRNnWDNAcqVifa0rDl8egil9O?=
 =?us-ascii?Q?KzKsvnzZ84w2lMlHUxtqEa5W/HpE3OFH/gc2GydMtUqFvQcsZqLLMfudw8Ft?=
 =?us-ascii?Q?+M6yJwbUllO4c+un5LwOZYiJmiTjftY38jkxyWeBSBvNhgfcWavlgGYuE0Sh?=
 =?us-ascii?Q?UcRkAcKpRkW8JrW5hUTRUc9tntL+8P/dZQ3gQaB3n5b2tIBcli1YMv+K4gJ2?=
 =?us-ascii?Q?JjkrSxJ9FXr3TMySeRIGQAk0mqD+lyH3iMzx+RZwykvPCTcaTOwoHZcyogwn?=
 =?us-ascii?Q?XSHxy8Rm9s5q6GQIRzM37qsA7dPR3luy3Zle1+2paOAr0PskakrCCmA7HVzw?=
 =?us-ascii?Q?pWrHzKUoU9aWuw3DNHRpusV/veo90Sjk43sEvcc2wYyN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7ae6f0-8401-44f9-7014-08d9e65b6332
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 14:50:43.5153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tnk4QRfOh0EqhHEAKo2goKsQ8COoCQgB85eWDpWp3BXfMB7/V3oJrsW6HTmQ2Wt6qayV7c3Grrg3cxJ/+0a1wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3597
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=706
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020081
X-Proofpoint-GUID: VvEOmAtHECJsCggqv8yXRkIG0e2Kptze
X-Proofpoint-ORIG-GUID: VvEOmAtHECJsCggqv8yXRkIG0e2Kptze
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

Moreover the test execution time has reduced from 32-34 secs to 18-19 secs.

The patches of this patchset introduce following chanages:

PATCH-1: Make global kernfs_open_file_mutex and kernfs_open_node_lock
	 per-fs hashed locks, where address of a kernfs_node acts as hash key.
	 This results in kernfs_node objects, whose address give the
	 different hash value, using different kernfs_open_file_mutex
	 and kernfs_open_node_lock rather than all kernfs_node objects
	 using the same kernfs_open_file_mutex and kernfs_open_node_lock
	 as was the case earlier.

PATCH-2: Replace per-fs single rw semaphore with per-fs hashed semaphore,
	 where address of a kernfs_node acts as hash key to reduce contention
	 around single per-fs rw semaphore.

------------------------------------------------------------------

Changes since v3:
 - Make open_file_mutex and open_node_lock per-fs.
 - Replace per-fs rwsem with per-fs hashed rwsem.
   (Suggested by Tejun Heo <tj@kernel.org>)

Imran Khan (2):
  kernfs: use hashed mutex and spinlock in place of global ones.
  kernfs: Replace per-fs global rwsem with per-fs hashed rwsem.

 fs/kernfs/dir.c             | 273 +++++++++++++++++++++++++-----------
 fs/kernfs/file.c            |  67 ++++-----
 fs/kernfs/inode.c           |  18 ++-
 fs/kernfs/kernfs-internal.h | 163 +++++++++++++++++++++
 fs/kernfs/mount.c           |  13 +-
 fs/kernfs/symlink.c         |   5 +-
 include/linux/kernfs.h      |  44 +++++-
 7 files changed, 447 insertions(+), 136 deletions(-)


base-commit: a70bf4a85b43cb952bd39dd948b103b1b3eb2cf8
-- 
2.30.2

