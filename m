Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20F054A9FA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbiFNHEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237621AbiFNHEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:04:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF79C1B7B8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:04:07 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E1HcxG025264;
        Tue, 14 Jun 2022 07:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=L6SczF3CHEd8C6Dn+p/+yqIrknKZln0w1m2CQWt94fI=;
 b=rNUpoBbg2H2vYOqZVx0WkZtKsSyBGDYYLyfl8WdjBjN8JgdsD/1Q+lNJxcvn4dzsz3NF
 sQC2RfpLUENPo0ppKh+ItoCz5CkY1lvtDXLh0nroLDsGgLAL/nxlr8e1AcxikajmTgHH
 r3+7zz5GUGKN6sdcqreCdPyLkKPNooNn2UQZcUmRhpP7bG1KhwnWcunqpihMKWPURTuJ
 QXqZtmbba47A00zFLRMDeOvXgNilmWKHsB7Rb/PGKtINTiy6qTRaJJq5F3D1QI5kGQxQ
 7xcc6atnwjRhHuJHZmGaJE8yEDXLLqUFkWRVNv6QjMmK91KtOhQOf2kQEu6fdz0ZdVW3 Ew== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhn0d0f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 07:04:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25E6ujNv032419;
        Tue, 14 Jun 2022 07:04:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpngnr6b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 07:04:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mx04oNf9gTp1iFYXDurM2fkGwwo79eq5QI3x8B/TNG97YJat+sRr1ypjcrjhS8r3d5z1ykHQPNfoy0Ldkub547hCPbyw87vSY3UGK96nwlyWGsy7jSGKaA2j6kBqZ1PKC2bXHSHTql4q64ojqKt5NhxP3zjSaVdo+ISQfUdl4OsO44GRw6pJ/Dz6XdkA2yDuI2kH5VP104xZDx6GbKghnfnspMLf7UTwcENQtF8al29ySkiN/OnSdfeBRVAKtaMTLn/4MSFEGkDDJXFsYInfNFsnq/Bk06dhkT5zJc/8YmYbnIzgdH5DZA269W8pscEdbr+j8hxUCQ4NOso0jTphpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6SczF3CHEd8C6Dn+p/+yqIrknKZln0w1m2CQWt94fI=;
 b=Y0e2fOEzdfpbuxdCPQqpoubEBwT8BKgyCu4fJSFCWaEWl/reIk6DBtOvIW5fGRolWSwNYUXePRVhkwLySJWYT65S/5FcE3ocQ/yma4TOEYZyG+2/esLy86MqZIAdfqW4NvNj5SHxsJVjq1vHduoxYXJXuvCoE63j6Dvo8T5uZiIwEoNRcMFoddzdFzK/b4B6HUwBXrgYPwEEfAUslQ5JBYDYWeTgPIyUTdFCWMBHBqvwJlAn2CNpUbhJg+9JMlLCFNM0KjfroXuAUQw3p7fmkuw7JjBC1iiO9fRGwLPeppKnKq0jBpqaNcMOjfgaZj9DNSFi6lZnXmNe1vqPK2LkcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6SczF3CHEd8C6Dn+p/+yqIrknKZln0w1m2CQWt94fI=;
 b=tSHGNAR9L70fYtuAVCjEHz1shmC4moLLvS5svTpvGRU4ciF3gdGqMEa09KMYvoURPPP/75QOqUlBaPwMj3gWTbTbs9s5ZXC1cFWM4JcPa+0KKGsxomP0cP7cJ639wGpcKMxG8yUTy05arjJcWnuz3r1Ug3NwSoJOXwFG5b4nJhg=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BN6PR1001MB2339.namprd10.prod.outlook.com (2603:10b6:405:2d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Tue, 14 Jun
 2022 07:03:59 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%9]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 07:03:59 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] kernfs: make ->attr.open RCU protected.
Date:   Tue, 14 Jun 2022 17:03:42 +1000
Message-Id: <20220614070346.810168-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY2PR01CA0036.ausprd01.prod.outlook.com
 (2603:10c6:1:15::24) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f9c485e-32d4-4b55-a2d4-08da4dd40de2
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2339:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB2339E57AF5B4E2F957E47689B0AA9@BN6PR1001MB2339.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4LnlvR/1iyOIX/Blt26q43PzdpK0/W/vfyTWTKWWM5aLFUizCPlVeN+IhRB0vPNrzQIAqiaPJArCZVpzvQgtoBoRKtD8i77DIbK6CwKipFFOYSd85IvDkDBhKRRnP/HL9D1ypmtkmGtZCiRxtTKb3Lf8J5fkamlmNlQKlgHDrq7/z/tWlctRxYI4e7nNIOIdv2VVMaESxjrZ9/O+wbB/FU0ARPcPOOKPIPMeBRW2LfUtXXqLRQtNbZM7fDaxv9ERt0Sd9iv/Bha9X2UnBHvLHD6kT4wzu4k/am6ppULGcZsW+cLoDPKzouQlsgyQ4LXz9W/RnyUBClEMx5sz6p7yVDj/sumFQKRSyNbWqBFut3XykR6pPKanBwo2g5crCf/basjuuRzFGcEYwGw/GiqaTjYTzMzCWwf/hve5TES8JLEZfuwzxw2jk6yyC4tulgewgcFrL7pCcYPUhCH+9nyKqdmdYwoZvvqxGzeadLqbvoU8tB9EFMXG1mzjXbRexT/9l2RFPNaiciitoc+p4H8aGa6E+7iNR/0VEogTS7os5xizQ1mY1ykCOE7gV+PsvsbkvCIHXvO0twaWA/YcZpy5loSbYAk1teQFNjBqXwlGyLU9/sfIVjlzQZJWhM9P9vS0t6gXMEKIblsmomjmLNOP/WkzpIvrQOig59S8eR5eicNwSyfVRXD1p7mZzAK5qRazGCzcrqgsH5dkEgdKHuYAoLizJkDuGSmf/5ymQJabpbFIffYBnXM77KY3Z/BtRSIJXMBlahqnza5yAinPMO3lx25wu1/37agGrioosDonQNgwiwsmyeml9ssm/MeDtHVRCvFNJofW6q44GXkoeb8ayEYPn7oZHTMuEORJ8R4p9qw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(316002)(38100700002)(52116002)(6506007)(6666004)(103116003)(36756003)(83380400001)(38350700002)(5660300002)(86362001)(8676002)(8936002)(2906002)(6486002)(966005)(1076003)(6512007)(186003)(26005)(66946007)(2616005)(508600001)(66556008)(66476007)(4326008)(87590200002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WtzdrOco23YTE8BmtfHlh1j3P8Q/ElRcD2G72e5QNyG/xAJDotLTYRs61Bca?=
 =?us-ascii?Q?OeGDBC0wT14bxzFSwqpvbCtTuwGs5pdHzI5J+8R1YhHMyX2uIopFpf/JQ3Yi?=
 =?us-ascii?Q?egjhzfcCZzyeCq4uIaUD+fWjovqW5oWtgy2sl7bKub1c6JOHpTvf34NDsBM8?=
 =?us-ascii?Q?+dhMpWM1pJ2VA1sGt2k/7m/z1AKBgZca2KNbBllO4Z/APEeVtTEJfl4KzN9S?=
 =?us-ascii?Q?jKhS0s8uCM0UpF51oDkIoxTgL2UlAZyr+S9zd/MmeDUPJ20QSkLjZ4N4c8Xf?=
 =?us-ascii?Q?8xGw8x5MtfwuZagrZ6z/W8D2HRewToIQv7Crp3mnCN3XYhnLKqP0qkKdo84r?=
 =?us-ascii?Q?MwoM0EyWSDpyXMwCVmVhxBWKU9JfIGcaCT4qQGwwQjp/tM4Q3SpKvmJE3OyQ?=
 =?us-ascii?Q?fOpuw/aTPBAYP0jlspyxJ5cxTw20yWc6IbosZeYwOCgwIMGCxi8FHHIGCyZ5?=
 =?us-ascii?Q?wQJgyYxU5quzBjdYovoY+8htIjs255rcmu+ZkGGMGKVx+srgYib/DOD4KRZQ?=
 =?us-ascii?Q?JmiLsBscr+JkP1kWBvVU/Oo8HBg2qyxyzZnBJGhK+Pf/EW05GKkQJtFUpMl+?=
 =?us-ascii?Q?MFEWy6pmmwuqWkWKD/dxKYeNwBpBkO/ZpBPkr9Vaow3rg6CxCnI3mw2BZigN?=
 =?us-ascii?Q?+8jUfBqiQghj+zkNllbhZiBvzYWYYXimqmvy/D/GNEOtp6yX/mp/8I4P6wFS?=
 =?us-ascii?Q?0DxVM7GZGDEDr9h24wHoAnMJ6yGvorv/vVO1l6OXpcIsblCs+NmDDwTUyJJZ?=
 =?us-ascii?Q?4GDl82EiLkFmAZYDU/dXFBPK8JeEOag7fO2SLU1hHCz1PJNweyWHgklG/lw0?=
 =?us-ascii?Q?obWgDPLl30JvrxX7YgoJVSzjgieC6qrzhOaPrlkURo0z6xl/idhx2pzfW6wg?=
 =?us-ascii?Q?xLRBneEx3b3IBSoQIg6U9CYxMaJg3gOXR5pCRPivwQIDCSQSEJuqth/efiWt?=
 =?us-ascii?Q?Ep+phM8uFy2yOFv2XAE8o6LtwFX7cUL4IUWdBqdWuL+bPWSZZOzC5zpMJeKW?=
 =?us-ascii?Q?OIA4kw1GOehbnGd4YLHJoG4CuCVofN/GDcYGPxk243tfzhT8+2BvrzcxA3DP?=
 =?us-ascii?Q?ko39P859Xxi32HGjGbfuiOqOOwcGEMb45+4aGDQpmkMJH9XvXRcMB9WgTtB9?=
 =?us-ascii?Q?IO2DbY97qPFQApmFYWVJSZIMcIbH8MlikKZo+5Ifd0bmYcZb7znwgQU50pgG?=
 =?us-ascii?Q?+RJrpfluXR3+xpWYSDueo1FPzdIXll+geiTJ3w0TJYgSi2Y3uMaOxfF3RWJi?=
 =?us-ascii?Q?I3QBS0yfHf2v3cpfK8R+/Dj+BYWdmGXRfIaPXHzrOWknyubuuE2VXxoW5m5T?=
 =?us-ascii?Q?3EiuNfIoSORORkEccUoT3Vyo/F08trxQpu7nM/k5Bw03d3zROjYpLI+2SAEr?=
 =?us-ascii?Q?s/8f8dWtqin+84+wYSFmQk1so4r9UHJaisHg1ERfTK1mt2GItezBxw5jjkRN?=
 =?us-ascii?Q?DN+pRmY8GEzKZwKdTw6XP16tmJ+EaNDDQbeyEPk0tQK4AyHvbM28XZlB4vnv?=
 =?us-ascii?Q?zkniaiomZ3fVLlzJpGoRdjRH05p+f+PJQm5OVq48+1+UmNdYGm4I6aN3LOGI?=
 =?us-ascii?Q?gOHIHraSF1RoB4lkMB9Ydq66HURPqBXFo3Y34MQYcrw5JY2sf7mhG8cYMuqV?=
 =?us-ascii?Q?A8ZpS9nOeP0xVtsCt+PJg0BmESdj8HmodpjPIycjUVv5Durq8jszG7OpnzOz?=
 =?us-ascii?Q?SCTBgYl871wU75See1yZkY7sRv3TsAsrcemNvZMiHv9YJuTuNjE9kGl+TNHj?=
 =?us-ascii?Q?ckoin6MM05SdViXB2y0Au4D+B1TMwFU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9c485e-32d4-4b55-a2d4-08da4dd40de2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 07:03:58.9113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ynnV37l88i2HpAIfowxzBJ6EnGMpaRVZ9dcITZmeLpDvS9NVEZ0cRCB+LDnf9tSF8F9kB9wxiCbAqSIpahZ5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2339
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-14_02:2022-06-13,2022-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206140026
X-Proofpoint-GUID: 3g1_92lPbflgMjRDUABQBDfLbfIPbXhP
X-Proofpoint-ORIG-GUID: 3g1_92lPbflgMjRDUABQBDfLbfIPbXhP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patches in this version of the patch set are as follows:

PATCH-1: Make kernfs_open_node->attr.open RCU protected.

PATCH-2: Change kernfs_notify_list to llist.

PATCH-3: Introduce interface to access kernfs_open_file_mutex.

PATCH-4: Replace global kernfs_open_file_mutex with hashed mutexes.

Changes since v5:
 - Use 2 helpers for ->attr.open dereferencing

Changes since v4:
 - Rebase on tag next-20220610
 - Use one helper for all ->attr.open dereferencing.

Changes since v3:
 - Rebase on tag next-20220601
 - Rename RCU access related helpers and update their description
 - Address errors reported by kernel test robot
 - Include Acked-by tags from Tejun for the acked patches (PATCH-2,3,4)

Changes since v2:
 - Rebase on tag next-20220510
 - Remove PATCH-1 of v2 because it is present in tag next-20220510
 - Include Acked-by tags from Tejun for the acked patches (PATCH-2 and PATCH-3)


Cover letter for v2:
--------------------------------------------------------------------------

I have not yet received any feedback about v1 of this patchset [2] but
in the meantime an old version of first patch from [3] has been integrated in
linux-next. Functionally first patch in both [2] and [3] are identical.
It's just that [2] has renamed one of the functions to better reflect the fact
that we are no longer using reference counting for kernfs_open_node.

In this version, I have just modified first patch of v1 so that we use the
modified function name as done in [2] and avoid those parts that are already
present in linux-next now. The remaining 4 patches (PATCH-2 to PATCH-5) are
identical in both v1 and v2 albeit v2 has been rebased on tag next-20220503.

Changes since v1:
 - Rebase on tag next-20220503

[2]: https://lore.kernel.org/lkml/20220428055431.3826852-1-imran.f.khan@oracle.com/
[3]: https://lore.kernel.org/lkml/20220324103040.584491-1-imran.f.khan@oracle.com/

Original cover letter
-------------------------------------------------------

This patchset contains subset of patches (after addressing review comments)
discussed at [1]. Since [1] is replacing multiple global locks and since
each of these locks can be removed independently, it was decided that we
should make these changes in parts i.e first get one set of optimizations
integrated and then work on top of those further.

The patches in this change set introduce following changes:

PATCH-1: Remove reference counting for kernfs_open_node.

PATCH-2: Make kernfs_open_node->attr.open RCU protected.

PATCH-3: Change kernfs_notify_list to llist.

PATCH-4: Introduce interface to access kernfs_open_file_mutex.

PATCH-5: Replace global kernfs_open_file_mutex with hashed mutexes.

[1] https://lore.kernel.org/lkml/YmLfxHcekrr89IFl@slm.duckdns.org/

----------------------------------------------------------------

Imran Khan (4):
  kernfs: make ->attr.open RCU protected.
  kernfs: Change kernfs_notify_list to llist.
  kernfs: Introduce interface to access global kernfs_open_file_mutex.
  kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.

 fs/kernfs/file.c            | 249 ++++++++++++++++++++++--------------
 fs/kernfs/kernfs-internal.h |   4 +
 fs/kernfs/mount.c           |  19 +++
 include/linux/kernfs.h      |  61 ++++++++-
 4 files changed, 235 insertions(+), 98 deletions(-)


base-commit: 6d0c806803170f120f8cb97b321de7bd89d3a791
-- 
2.30.2

