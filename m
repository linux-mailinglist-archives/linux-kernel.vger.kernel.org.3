Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EC4550F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 05:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbiFTDpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 23:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiFTDpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 23:45:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E242BE3A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 20:45:34 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25JGt8JB018712;
        Mon, 20 Jun 2022 03:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=V0nFqoiVYEb44aTtjgIWrliw/DACwV6Lb1BvQer+H2s=;
 b=eoZxR64PXK13iTuepyMptHwkTzXCMrXleBEm+b6/fyeM1ReVCP4e9ESb+m8cLTnNnEmb
 Kx6l8U18xExXOPldoJiCpBbHkQwIY1FxPrN33xMGSSa4aHpYK+4TayrG9bAXiuhJrJ/O
 N4m7mcmxZ+WCgK+vHtZxbF05HIhpV64P1wIQMsTw6zIIsLI4sMeR1koAoo+TyngR3eo/
 DGC0teb2hymZM2z0qTBvAXCVtCrKkq8wnZUCwJI/8ToRkkTooDH9/WpWqySK3Z6pnIr0
 L2TtPc8PSIso04j1BmgNsbfT0OjDJyIux6SSQsO1RB01fzQEmRvx59JK5jxn2Nkt82up gA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g1t6bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 03:45:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25K3AggJ000846;
        Mon, 20 Jun 2022 03:26:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtg5t0rer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 03:26:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+mzkJBcdAdNT+JbEDl+fWdApo9pjSXwAnyfy+esLAl+4HbEcf8WFFB/n6InMyTIPZ9Ke143L6rnhclNaedbu5OhD2V0aOsEJV1Eiio+oiMSmm1dlq4proAB8NAfA9hdyatEYqow7+M4vIr7Lb3P9ob9TAl40pL5m+cDOdQ5xh9GebnXu1+f2BMfQMPgzlW0/Z/Xs6E4dzZmxCE1KKuKU85iHvD/B+DhM3eI2QTzhfXgBxI5aFiB79rO/JCfZssTcEiLhFYDpd4NApNyhqdlJ8FeL0juCkSok7x5tB6lSUo0z0Bz97gxLSKxegPBYTw0RfuFpLnOJS83T4zvalbqsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0nFqoiVYEb44aTtjgIWrliw/DACwV6Lb1BvQer+H2s=;
 b=XnREJdo6ZPVBXEUMU1t90PTArRGm8QiAyptKJx0i0ny206bRIQjw6YzyaWY/U6kNWf04d4cFHIkLdevd6SXWozTQrGDYxIct9Dib2wnU11yovGNjAOWuZvHZSGAi/dCjuMaZJxOIE2ZEo/Ovk3UAhZkVKmH34jkpteog+WUVwqw/kkeqvN6k/FKU7/xoi0LNhx2HvZ0qmM/W711IYFAOMOnbtY3J+Y7qKgmI6ZnEviG8MDH+F8Hv3sfcpm6NuHEkgNZNYGBO37X9VEmCqiBrdagiCaUKnE0YNmhfdAa/V31hgL3sG+Viga9SxgYKiTmyzUqgVlxs1/lskSjEx4/u4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0nFqoiVYEb44aTtjgIWrliw/DACwV6Lb1BvQer+H2s=;
 b=k94kS+292KVmkEg6+wVsBplnhuKgFe/MkqpLHAmeyJRMHvjrEGRmWHf2atH3z12oMoxiyDDeM4nmBDX1b+9Z2YTMxqgsNtf34LGLEbDFad2Q3RR+TEruLBFcJNgsaLfGQCrtBy3VdbjCOAs9/sjviqZOpsbiUIRYRwd1bhykTo0=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by SJ0PR10MB4750.namprd10.prod.outlook.com (2603:10b6:a03:2d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Mon, 20 Jun
 2022 03:26:48 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%9]) with mapi id 15.20.5353.021; Mon, 20 Jun 2022
 03:26:48 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kernfs: Change kernfs_rwsem to a per-cpu rwsem.
Date:   Mon, 20 Jun 2022 13:26:34 +1000
Message-Id: <20220620032634.1103822-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0147.ausprd01.prod.outlook.com
 (2603:10c6:10:d::15) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2de10d7e-54c9-48f5-eac5-08da526cb521
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4750:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4750E87594270FFFD8C845D5B0B09@SJ0PR10MB4750.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wOWUuxG7KISyd8MZOTNsOl6uASqPVQUjQeF8ajhlUYdASqnTMZgss8ht9Iy8zovEqvX0Ml649nJk5qEMyE6mItD5v8Gac9sAYHoicrAOowyP2dmJPora5omZhgY2LoJ2g/OYWHj1s1NSxJD4ux2wYoliAkKhTxL/oz85RsL5M39Qd8cXx7DuAkxwC5hYMsES7VaqP+s2LsVYiZM9AGX7YSjazvUX//rslrw8ZCJhVNUXRi5g3dNb1c4oQTqVCmA6IVxdHMoXrZqFs6Oa+dQ5KDrl4y7XQOiI14ETkUdG2kumgPm3XBnLNEv8C6xf++ftN3weSKkEF/QgAAkii4KYHzttedzlZ29rsGWDZyogjNbohmPhEocIih1l8NaMrDQXfu9zw20SY6VHkk/XFNwVmMpiicpotLdQPz3t3Teya4oJeVdEcazTv8SahYbNYxPy5/9XXbQjlATgNCWlmV/5QMmRrxYKGNKE4pbx0DehFNUJli008NTIcwT4Gz+PenIWLgJa8oQlP+OxIoS9BVuWV7YH+TQxt2RrpJK9aAg+83SR2j8s8cV6m0uATjLkE5zX5XS59ro1Y/Wymg7xeMAEf38uh7FkAMSfVLdwTvvhtYCwpMYSF6h1GN5vdUM/zSx6e0iwS/xjjKl1pH1JLrIjfLb/G1HZ2kb6IhCXltJQfwDQYUIsALm4q4BXPnRLukQdwNzN/SkwbGeRTJYcuMxcfLtVCI8Dc1bgC2QaJBzRvBtM760MdxthvRmGyWeQ4KBhdtbB4zgN4DrrRb7FldVixTQYPk0+VDNyZuSl+dr2h01td136Ij6bi1K0xM1i7uzdvVcNqYXQbdofZwwyVyZFow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6486002)(966005)(83380400001)(4326008)(103116003)(66476007)(8676002)(1076003)(66556008)(66946007)(186003)(26005)(2906002)(6506007)(6666004)(52116002)(498600001)(2616005)(6512007)(8936002)(86362001)(5660300002)(30864003)(36756003)(316002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N+xVU9Jc8b3BxpRo6MvnzXzvkF0a1+ZwjpUYnd2JgqAQaRmMVQDHl7OF9yn9?=
 =?us-ascii?Q?+CiO+y0rO6majHjAQbmNJnvYym6ygfR68rS7Pt1dAH6L487KxugIYp3AokOY?=
 =?us-ascii?Q?sbiJ7UJogwSX3scmvneCDwM98cXr3Ke0YeYGMIPgUif3WeAuiPKJbi+6SaJO?=
 =?us-ascii?Q?noLsX5O5g98vQ2eaLAAZ3+cFJsFp8N36+oRG2tjdX2hQVgcgujDAGKPHWHJp?=
 =?us-ascii?Q?8DlxXHpi5GrXtcBQIpcnSf1SAZuBmE04SmoiWkiTq0WYFQtc8FUcI8BN9vKA?=
 =?us-ascii?Q?5kYRL1S222EcW9KI7goGDRf1tHXtDlQvKQR4gODGX01v4XmWchwRV/ygGKnk?=
 =?us-ascii?Q?z48pYDIRe+sM80LCBAud0C/aQxaID3gToP1jY8NZc1DSZ1uAS5jH/qshy/sW?=
 =?us-ascii?Q?SU67RcL/W4KaZxxfyqAOaMI21zotnjcPWetnrc4Ul6vofO2UYNvQHXb5jJl8?=
 =?us-ascii?Q?KzvLp/eamAnnvWhWKdzMTzw+o30X4LjNyzf0wS4zF2LkI2hlDiNogTn0j7O4?=
 =?us-ascii?Q?fxuQPIzDEj5a1VhesE+05ixDTYfyN3XjI5xF2Ap4G/vK9KHW2kJ9SXWSMrlA?=
 =?us-ascii?Q?m7LLmP4+5BWmFzIlJ/f1sOQyWB125U4I6TM0fI8VKernuyDbGSaNpgGPijre?=
 =?us-ascii?Q?GAeYxLZcZdmQ/fAS3hPzyO3zu7ARl7cd9UJCRcriigBykgpru+uZNLunsWJL?=
 =?us-ascii?Q?ZZmhxE7e93bVGn/1+QUdMny0vUXXcHJxxs21atKfXe9Ck10IVRsQ1EaGnv+J?=
 =?us-ascii?Q?547FLiKjOV/244m+qTWjP6KdIV6n6+OtrQ8EYPMiNJyerHjKN7gk6PbdNq29?=
 =?us-ascii?Q?/kSlF1OkE9pQhPx3PjXtbepAmiO1F8xe0puSlHOgQgaSDE3s2o8TlXXoaEY5?=
 =?us-ascii?Q?0WIec+RFVTVZs9O2Q3X+kfhu5rNZyWFdhRpUZT+S6I119BpBgthb2c86QDSo?=
 =?us-ascii?Q?mnPrMjdTQrPIh6K9NnuPX1Tj9Q9WA0F+rht5k7u0/c1FRVG/xkLC6GCeE+5H?=
 =?us-ascii?Q?LxLJWHckdc5CGNqUpRd7DX6arCZAIu/qv8NNPXjmO4HSzi3+WhzxE0YZhfmN?=
 =?us-ascii?Q?0FRLA9LBS7m8fc0jyjH0O/UydyB3VI72V2tNldf8TM7VmURFB3gWsv7ZtW7a?=
 =?us-ascii?Q?x1ETOFiQSX4iM2RZK+cBPwuwrz7XdirqRj7/gIMc4AR1mFdeKrmJJ7A6Bjwb?=
 =?us-ascii?Q?GSaCW+ikpwOQ5/Ahqk+601Mkb4L34z9PypxU3uOmWqzr1i69dNq6ldrz/Tns?=
 =?us-ascii?Q?/CZAjlT1AOT2lp6bgRF99hT0jel3Dx5dqJrD5j6/dv923528SyLeqLw897I1?=
 =?us-ascii?Q?ojaSpBiehW7MCJugYQTE4+r4vIgA3mutUlO+xb7ATRrMkD2sAdaj98LsiGxI?=
 =?us-ascii?Q?hN3pU6xfuDJTM+pMn3ZmGqd9UX/4Zcul1DaKUvI4ON+mtK6udYfZGxCrOf0B?=
 =?us-ascii?Q?s/aJcu7f/+FRGLzV0hWCO7hD/YoDIM3PgweJIQbdD4pFBxHGgIw8Ml4Ym4gw?=
 =?us-ascii?Q?BHu4C8LBveAoUSLazQDU5kmTag6FnJ94kcO5n5plQzsyQ4UmW27U6eo61k6Y?=
 =?us-ascii?Q?T86a3cyd67qOn9/EspoBzT4wgAYy12727u/FQa4nReqGeXqidnCKLU+1Qu9m?=
 =?us-ascii?Q?ZuK8ZQxITxYewxk8WplTPgKp2x1JrwFa4GWXs/5vpujSOJmiVizjv7Fv4416?=
 =?us-ascii?Q?4/2941xzfP175MralZgfEcBZsGpNEP2lwZ64fBB2mIrtctFQqB13nX1YyN4n?=
 =?us-ascii?Q?u7cRlOZz+sPi553ARltY2DxTr5yjDsQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de10d7e-54c9-48f5-eac5-08da526cb521
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 03:26:48.1139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmcxNrPsAqhwkif2xeVxdLkGYYqKuxpnfN/LoCEGHKr4Dn9XKAT0eGI4lFU7YsJR1uPUgtUknR4vf9jGcCcDhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4750
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-19_12:2022-06-17,2022-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206200014
X-Proofpoint-GUID: YkbRxng0zhz63mA3yWPKRvPCW2DCW-uS
X-Proofpoint-ORIG-GUID: YkbRxng0zhz63mA3yWPKRvPCW2DCW-uS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On large systems when few hundred CPUs simulateously acquire kernfs_rwsem,
for reading we see performance degradation due to bouncing of cache line
that contains kernfs_rwsem. Changing kernfs_rwsem into a per-fs, per-cpu
rwsem can fix this degradation.

For example on a system of 384 cores, If I run 200 instances of an
application that is mostly executing following loop:

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
  }

I can see contention around kernfs_rwsem as follows:

-   21.09%    20.95%  showgids       [kernel.kallsyms]        [k] down_read
     20.95% __libc_start_main
        __GI___libc_open
        entry_SYSCALL_64_after_hwframe
        do_syscall_64
        sys_open
        do_sys_open
        do_filp_open
      - path_openat
         - 19.55% link_path_walk
            - 10.60% inode_permission
               - __inode_permission
                  - 10.60% kernfs_iop_permission
                       down_read
            - 8.18% walk_component
                 lookup_fast
               - d_revalidate.part.24
                  - 8.18% kernfs_dop_revalidate
                       down_read
            - 0.76% kernfs_iop_get_link
                 down_read
         - 0.74% may_open
              inode_permission
              __inode_permission
              kernfs_iop_permission
              down_read
         - 0.66% lookup_fast
              d_revalidate.part.24
              kernfs_dop_revalidate
              down_read

-   16.04%    15.96%  showgids       [kernel.kallsyms]        [k] up_read
     15.96% __libc_start_main
        __GI___libc_open
        entry_SYSCALL_64_after_hwframe
        do_syscall_64
        sys_open
        do_sys_open
        do_filp_open
      - path_openat
         - 15.04% link_path_walk
            - 8.36% inode_permission
               - __inode_permission
                  - 8.36% kernfs_iop_permission
                       up_read
            - 6.15% walk_component
                 lookup_fast
               - d_revalidate.part.24
                  - 6.15% kernfs_dop_revalidate
                       up_read
            - 0.53% kernfs_iop_get_link

Moreover this run of 200 applications take more than 32 secs to finish on
this system.

After changing kernfs_rwsem to a per-cpu rwsem, I can see that contention
for kernfs_rwsem is no longer visible in perf data and the test execution
time has reduced to almost half (17 secs or less from 32 secs or more).

The overhead involving write operations with per-cpu rwsem will be higher
but frequency of creation/deletion of kernfs files is much less than
frequency at which kernfs (cgroup, sysfs) files are read.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---

This patch introduces an alternative approach to address problem of kernfs_rwsem
contention discussed in [1]. Since [1] was dealing with 3 global locks i.e.
kernfs_open_file_mutex, kernfs_open_node_lock and kernfs_rwsem and most of the
major changes were around kernfs_rwsem we decided in [2] to sort out
kernfs_open_file_mutex and kernfs_open_node_lock first. These 2 global locks have
now been removed and corresponding patches [3] have been Acked.

As far as kernfs_rwsem is concerned, we are trying to use hashed kernfs_rwsem in
[1]. These changes have not been Acked yet and there may still be some broken
corner cases which I am trying to find/fix at the moment. But in the meanwhile
I tried with per-cpu rwsem for kernfs_rwsem and found that it is giving me
similar improvement as far as my test case is concerned. Compared to hashed
kernfs_rwsem, per-cpu kernfs_rwsem is less intrusive because in worst case we
may incur some performance penalties for some unknown scenarios but it will not
break kernfs flow.

So in this patch I am proposing the idea of using per-cpu kernfs_rwsem, so that
I can get some feedback about this approach as well.

[1]: https://lore.kernel.org/lkml/20220410023719.1752460-1-imran.f.khan@oracle.com/
[2]: https://lore.kernel.org/lkml/f2ca9d19-023f-76d9-5c76-6f08ccfbe348@oracle.com/
[3]: https://lore.kernel.org/lkml/20220615021059.862643-1-imran.f.khan@oracle.com/

 fs/kernfs/dir.c             | 70 ++++++++++++++++++-------------------
 fs/kernfs/file.c            |  4 +--
 fs/kernfs/inode.c           | 16 ++++-----
 fs/kernfs/kernfs-internal.h |  4 +--
 fs/kernfs/mount.c           | 12 +++----
 fs/kernfs/symlink.c         |  4 +--
 6 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 6eca72cfa1f28..678e71856afc0 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -472,7 +472,7 @@ static void kernfs_drain(struct kernfs_node *kn)
 	lockdep_assert_held_write(&root->kernfs_rwsem);
 	WARN_ON_ONCE(kernfs_active(kn));
 
-	up_write(&root->kernfs_rwsem);
+	percpu_up_write(&root->kernfs_rwsem);
 
 	if (kernfs_lockdep(kn)) {
 		rwsem_acquire(&kn->dep_map, 0, 0, _RET_IP_);
@@ -491,7 +491,7 @@ static void kernfs_drain(struct kernfs_node *kn)
 
 	kernfs_drain_open_files(kn);
 
-	down_write(&root->kernfs_rwsem);
+	percpu_down_write(&root->kernfs_rwsem);
 }
 
 /**
@@ -731,7 +731,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	bool has_ns;
 	int ret;
 
-	down_write(&root->kernfs_rwsem);
+	percpu_down_write(&root->kernfs_rwsem);
 
 	ret = -EINVAL;
 	has_ns = kernfs_ns_enabled(parent);
@@ -762,7 +762,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 		ps_iattr->ia_mtime = ps_iattr->ia_ctime;
 	}
 
-	up_write(&root->kernfs_rwsem);
+	percpu_up_write(&root->kernfs_rwsem);
 
 	/*
 	 * Activate the new node unless CREATE_DEACTIVATED is requested.
@@ -776,7 +776,7 @@ int kernfs_add_one(struct kernfs_node *kn)
 	return 0;
 
 out_unlock:
-	up_write(&root->kernfs_rwsem);
+	percpu_up_write(&root->kernfs_rwsem);
 	return ret;
 }
 
@@ -869,10 +869,10 @@ struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
 	struct kernfs_node *kn;
 	struct kernfs_root *root = kernfs_root(parent);
 
-	down_read(&root->kernfs_rwsem);
+	percpu_down_read(&root->kernfs_rwsem);
 	kn = kernfs_find_ns(parent, name, ns);
 	kernfs_get(kn);
-	up_read(&root->kernfs_rwsem);
+	percpu_up_read(&root->kernfs_rwsem);
 
 	return kn;
 }
@@ -894,10 +894,10 @@ struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *parent,
 	struct kernfs_node *kn;
 	struct kernfs_root *root = kernfs_root(parent);
 
-	down_read(&root->kernfs_rwsem);
+	percpu_down_read(&root->kernfs_rwsem);
 	kn = kernfs_walk_ns(parent, path, ns);
 	kernfs_get(kn);
-	up_read(&root->kernfs_rwsem);
+	percpu_up_read(&root->kernfs_rwsem);
 
 	return kn;
 }
@@ -922,7 +922,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 		return ERR_PTR(-ENOMEM);
 
 	idr_init(&root->ino_idr);
-	init_rwsem(&root->kernfs_rwsem);
+	percpu_init_rwsem(&root->kernfs_rwsem);
 	INIT_LIST_HEAD(&root->supers);
 
 	/*
@@ -1078,12 +1078,12 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 		if (parent) {
 			spin_unlock(&dentry->d_lock);
 			root = kernfs_root(parent);
-			down_read(&root->kernfs_rwsem);
+			percpu_down_read(&root->kernfs_rwsem);
 			if (kernfs_dir_changed(parent, dentry)) {
-				up_read(&root->kernfs_rwsem);
+				percpu_up_read(&root->kernfs_rwsem);
 				return 0;
 			}
-			up_read(&root->kernfs_rwsem);
+			percpu_up_read(&root->kernfs_rwsem);
 		} else
 			spin_unlock(&dentry->d_lock);
 
@@ -1095,7 +1095,7 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 
 	kn = kernfs_dentry_node(dentry);
 	root = kernfs_root(kn);
-	down_read(&root->kernfs_rwsem);
+	percpu_down_read(&root->kernfs_rwsem);
 
 	/* The kernfs node has been deactivated */
 	if (!kernfs_active(kn))
@@ -1114,10 +1114,10 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	    kernfs_info(dentry->d_sb)->ns != kn->ns)
 		goto out_bad;
 
-	up_read(&root->kernfs_rwsem);
+	percpu_up_read(&root->kernfs_rwsem);
 	return 1;
 out_bad:
-	up_read(&root->kernfs_rwsem);
+	percpu_up_read(&root->kernfs_rwsem);
 	return 0;
 }
 
@@ -1136,7 +1136,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	const void *ns = NULL;
 
 	root = kernfs_root(parent);
-	down_read(&root->kernfs_rwsem);
+	percpu_down_read(&root->kernfs_rwsem);
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dir->i_sb)->ns;
 
@@ -1147,7 +1147,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 		 * create a negative.
 		 */
 		if (!kernfs_active(kn)) {
-			up_read(&root->kernfs_rwsem);
+			percpu_up_read(&root->kernfs_rwsem);
 			return NULL;
 		}
 		inode = kernfs_get_inode(dir->i_sb, kn);
@@ -1162,7 +1162,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	 */
 	if (!IS_ERR(inode))
 		kernfs_set_rev(parent, dentry);
-	up_read(&root->kernfs_rwsem);
+	percpu_up_read(&root->kernfs_rwsem);
 
 	/* instantiate and hash (possibly negative) dentry */
 	return d_splice_alias(inode, dentry);
@@ -1322,7 +1322,7 @@ void kernfs_activate(struct kernfs_node *kn)
 	struct kernfs_node *pos;
 	struct kernfs_root *root = kernfs_root(kn);
 
-	down_write(&root->kernfs_rwsem);
+	percpu_down_write(&root->kernfs_rwsem);
 
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
@@ -1336,7 +1336,7 @@ void kernfs_activate(struct kernfs_node *kn)
 		pos->flags |= KERNFS_ACTIVATED;
 	}
 
-	up_write(&root->kernfs_rwsem);
+	percpu_up_write(&root->kernfs_rwsem);
 }
 
 static void __kernfs_remove(struct kernfs_node *kn)
@@ -1420,9 +1420,9 @@ void kernfs_remove(struct kernfs_node *kn)
 
 	root = kernfs_root(kn);
 
-	down_write(&root->kernfs_rwsem);
+	percpu_down_write(&root->kernfs_rwsem);
 	__kernfs_remove(kn);
-	up_write(&root->kernfs_rwsem);
+	percpu_up_write(&root->kernfs_rwsem);
 }
 
 /**
@@ -1510,7 +1510,7 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 	bool ret;
 	struct kernfs_root *root = kernfs_root(kn);
 
-	down_write(&root->kernfs_rwsem);
+	percpu_down_write(&root->kernfs_rwsem);
 	kernfs_break_active_protection(kn);
 
 	/*
@@ -1538,9 +1538,9 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 			    atomic_read(&kn->active) == KN_DEACTIVATED_BIAS)
 				break;
 
-			up_write(&root->kernfs_rwsem);
+			percpu_up_write(&root->kernfs_rwsem);
 			schedule();
-			down_write(&root->kernfs_rwsem);
+			percpu_down_write(&root->kernfs_rwsem);
 		}
 		finish_wait(waitq, &wait);
 		WARN_ON_ONCE(!RB_EMPTY_NODE(&kn->rb));
@@ -1553,7 +1553,7 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 	 */
 	kernfs_unbreak_active_protection(kn);
 
-	up_write(&root->kernfs_rwsem);
+	percpu_up_write(&root->kernfs_rwsem);
 	return ret;
 }
 
@@ -1579,13 +1579,13 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 	}
 
 	root = kernfs_root(parent);
-	down_write(&root->kernfs_rwsem);
+	percpu_down_write(&root->kernfs_rwsem);
 
 	kn = kernfs_find_ns(parent, name, ns);
 	if (kn)
 		__kernfs_remove(kn);
 
-	up_write(&root->kernfs_rwsem);
+	percpu_up_write(&root->kernfs_rwsem);
 
 	if (kn)
 		return 0;
@@ -1613,7 +1613,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 		return -EINVAL;
 
 	root = kernfs_root(kn);
-	down_write(&root->kernfs_rwsem);
+	percpu_down_write(&root->kernfs_rwsem);
 
 	error = -ENOENT;
 	if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
@@ -1667,7 +1667,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 
 	error = 0;
  out:
-	up_write(&root->kernfs_rwsem);
+	percpu_up_write(&root->kernfs_rwsem);
 	return error;
 }
 
@@ -1745,7 +1745,7 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 		return 0;
 
 	root = kernfs_root(parent);
-	down_read(&root->kernfs_rwsem);
+	percpu_down_read(&root->kernfs_rwsem);
 
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dentry->d_sb)->ns;
@@ -1762,12 +1762,12 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 		file->private_data = pos;
 		kernfs_get(pos);
 
-		up_read(&root->kernfs_rwsem);
+		percpu_up_read(&root->kernfs_rwsem);
 		if (!dir_emit(ctx, name, len, ino, type))
 			return 0;
-		down_read(&root->kernfs_rwsem);
+		percpu_down_read(&root->kernfs_rwsem);
 	}
-	up_read(&root->kernfs_rwsem);
+	percpu_up_read(&root->kernfs_rwsem);
 	file->private_data = NULL;
 	ctx->pos = INT_MAX;
 	return 0;
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index e3abfa843879c..068651fbcfa70 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -862,7 +862,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 
 	root = kernfs_root(kn);
 	/* kick fsnotify */
-	down_write(&root->kernfs_rwsem);
+	percpu_down_write(&root->kernfs_rwsem);
 
 	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
 		struct kernfs_node *parent;
@@ -900,7 +900,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		iput(inode);
 	}
 
-	up_write(&root->kernfs_rwsem);
+	percpu_up_write(&root->kernfs_rwsem);
 	kernfs_put(kn);
 	goto repeat;
 }
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 3d783d80f5daa..6b8d204839ee2 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -101,9 +101,9 @@ int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 	int ret;
 	struct kernfs_root *root = kernfs_root(kn);
 
-	down_write(&root->kernfs_rwsem);
+	percpu_down_write(&root->kernfs_rwsem);
 	ret = __kernfs_setattr(kn, iattr);
-	up_write(&root->kernfs_rwsem);
+	percpu_up_write(&root->kernfs_rwsem);
 	return ret;
 }
 
@@ -119,7 +119,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		return -EINVAL;
 
 	root = kernfs_root(kn);
-	down_write(&root->kernfs_rwsem);
+	percpu_down_write(&root->kernfs_rwsem);
 	error = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (error)
 		goto out;
@@ -132,7 +132,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	setattr_copy(&init_user_ns, inode, iattr);
 
 out:
-	up_write(&root->kernfs_rwsem);
+	percpu_up_write(&root->kernfs_rwsem);
 	return error;
 }
 
@@ -189,12 +189,12 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_root *root = kernfs_root(kn);
 
-	down_read(&root->kernfs_rwsem);
+	percpu_down_read(&root->kernfs_rwsem);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	generic_fillattr(&init_user_ns, inode, stat);
 	spin_unlock(&inode->i_lock);
-	up_read(&root->kernfs_rwsem);
+	percpu_up_read(&root->kernfs_rwsem);
 
 	return 0;
 }
@@ -287,12 +287,12 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
 	kn = inode->i_private;
 	root = kernfs_root(kn);
 
-	down_read(&root->kernfs_rwsem);
+	percpu_down_read(&root->kernfs_rwsem);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
 	ret = generic_permission(&init_user_ns, inode, mask);
 	spin_unlock(&inode->i_lock);
-	up_read(&root->kernfs_rwsem);
+	percpu_up_read(&root->kernfs_rwsem);
 
 	return ret;
 }
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index eeaa779b929c7..a3c0739db92f9 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -13,7 +13,7 @@
 #include <linux/lockdep.h>
 #include <linux/fs.h>
 #include <linux/mutex.h>
-#include <linux/rwsem.h>
+#include <linux/percpu-rwsem.h>
 #include <linux/xattr.h>
 
 #include <linux/kernfs.h>
@@ -46,7 +46,7 @@ struct kernfs_root {
 	struct list_head	supers;
 
 	wait_queue_head_t	deactivate_waitq;
-	struct rw_semaphore	kernfs_rwsem;
+	struct percpu_rw_semaphore	kernfs_rwsem;
 };
 
 /* +1 to avoid triggering overflow warning when negating it */
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index cfa79715fc1a7..e3059de2e05c1 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -256,9 +256,9 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
 	sb->s_shrink.seeks = 0;
 
 	/* get root inode, initialize and unlock it */
-	down_read(&kf_root->kernfs_rwsem);
+	percpu_down_read(&kf_root->kernfs_rwsem);
 	inode = kernfs_get_inode(sb, info->root->kn);
-	up_read(&kf_root->kernfs_rwsem);
+	percpu_up_read(&kf_root->kernfs_rwsem);
 	if (!inode) {
 		pr_debug("kernfs: could not get root inode\n");
 		return -ENOMEM;
@@ -346,9 +346,9 @@ int kernfs_get_tree(struct fs_context *fc)
 		}
 		sb->s_flags |= SB_ACTIVE;
 
-		down_write(&root->kernfs_rwsem);
+		percpu_down_write(&root->kernfs_rwsem);
 		list_add(&info->node, &info->root->supers);
-		up_write(&root->kernfs_rwsem);
+		percpu_up_write(&root->kernfs_rwsem);
 	}
 
 	fc->root = dget(sb->s_root);
@@ -375,9 +375,9 @@ void kernfs_kill_sb(struct super_block *sb)
 	struct kernfs_super_info *info = kernfs_info(sb);
 	struct kernfs_root *root = info->root;
 
-	down_write(&root->kernfs_rwsem);
+	percpu_down_write(&root->kernfs_rwsem);
 	list_del(&info->node);
-	up_write(&root->kernfs_rwsem);
+	percpu_up_write(&root->kernfs_rwsem);
 
 	/*
 	 * Remove the superblock from fs_supers/s_instances
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 0ab13824822f7..61c8260a55717 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -116,9 +116,9 @@ static int kernfs_getlink(struct inode *inode, char *path)
 	struct kernfs_root *root = kernfs_root(parent);
 	int error;
 
-	down_read(&root->kernfs_rwsem);
+	percpu_down_read(&root->kernfs_rwsem);
 	error = kernfs_get_target_path(parent, target, path);
-	up_read(&root->kernfs_rwsem);
+	percpu_up_read(&root->kernfs_rwsem);
 
 	return error;
 }

base-commit: 35d872b9ea5b3ad784d7479ea728dcb688df2db7
-- 
2.30.2

