Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74414FAB8A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 04:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiDJCkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 22:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243402AbiDJCjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 22:39:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADBA43489
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 19:37:45 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 239FZSw1029058;
        Sun, 10 Apr 2022 02:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=AvWvzVdfHaC18TpjvuIW94HOcyxivUQkHg1n/ZppXtY=;
 b=vqcRAFl5B7UsFzaeouSPqKO9Y7hyRlcOACUgZmrLiKsw+TQREdOxM/h5elhWaFN98Q4W
 oXXM6YtbS4Yj4HhjfYrrKBtOe42l4AeIekfqgjiBg/LHnJD4wMpt5JmiFH7aySWDEFVu
 l1MYtlBr3tD9GLsusvc9xXpxq0sWGvRWAdnJPuOTr6hsHsYGS4ZgC7zwyBP7624lW30x
 FJoGArkqO+VEUK5mYtd0nOPX+7woqtYu1NiHroUmxY4SSBvYepC1GZL6f1z/549tThNF
 AYGnPIvoW42ejjQr4DQTZPjn0NFtnis+EmmXT/JqfXYPdwGjbO4jahKK+fdNW4+9mzVK kQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rs0yqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Apr 2022 02:37:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23A2V1Pj000864;
        Sun, 10 Apr 2022 02:37:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k0tn7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Apr 2022 02:37:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6AbXw75qcKE3va9QBR6X2FdnAhDRRFG67b4ZtqyIF9kgn36zEne3/LG/37Oc2wOXLtkUgAzbvg69YeOjww7p/c3+Ftx19oUV5GGaKBYPYMEiDCFLG3+kFbLZ7QBfbpc3F/gnWPxnU1N2lZaIbBNnRfL6twY1+HY3w9gKAyP7uNArvseE4CDrJrzrJaSnBQ8fvlIoF1VAU3a0FMWI8aZCVygR9Ok7VS9B7AZuvyMJQM/DNqqTCZSV1B1Bd5Knyt4oPeEyvZD7a/z/KuxiXWCpRizTVYaYlzZrtMdmD23PjfqlJ5j+Mbl4ExUOO4lageTAlShywAtzsaTJZKNsVke+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvWvzVdfHaC18TpjvuIW94HOcyxivUQkHg1n/ZppXtY=;
 b=RBCMSNRDV6MGSFINkYH/ZQn8LDpdDTb9pFe5e2kbGJhrLah+ALs4yaOX1fKrLVEC4zjzzn3dfkrolPDLTdtt5efVwkYMqFWS9J5QYRpsyrskOeiVOsZ9nkoeJ1O89oLBiJXTjvTawok6Vs4NlLGh87NJ58OUlzW59Pa3zROLnW6+mZbxRfntXOEtGCcZ4UjUr5pcOuabARqPFn0aVEppfSZO5dpisB7+qfcDq6iAxsTRc/WfJf/mMMeexMBV2UxjFrSn7YDQn4Uca53UAFQX5gqTdPvrd5/xsVbUwuplBVq15RFbZR3J60VoZuDAQeyrW5XoO/BCefyoVYUhvXLP8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvWvzVdfHaC18TpjvuIW94HOcyxivUQkHg1n/ZppXtY=;
 b=PvHvvV6VB39XaQfCwNl0Ogb0xGE3bFzrdYaWSik9NWNhEqzK3LKRsVahGYLx6njCCQ4McMKA7TLytzZ1ZHikfmhnW5kXuAJjTUmFIsWsWnQiIln+XbvTlIEo/rdUxQMFSAVZTMhIGPjJ/KieVvVuScywP8tb/RdV9wiJMuYbIDc=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CY4PR10MB1238.namprd10.prod.outlook.com (2603:10b6:910:7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.28; Sun, 10 Apr
 2022 02:37:37 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5144.028; Sun, 10 Apr 2022
 02:37:37 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        ebiederm@xmission.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v8 02/10] kernfs: make ->attr.open RCU protected.
Date:   Sun, 10 Apr 2022 12:37:11 +1000
Message-Id: <20220410023719.1752460-3-imran.f.khan@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: eb3e2586-844f-4acc-ab70-08da1a9b1317
X-MS-TrafficTypeDiagnostic: CY4PR10MB1238:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1238924BE31A2E89AC2FFE5FB0EB9@CY4PR10MB1238.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bN12NO+mWytT9McQulJ7pAdM+Koj7TQwW4vdGG35caMrFr41xnkcJXmNze2m1fazPhb6Xj/DacKnICKYoEF8CoxJCREL62kho53IXl7GVlVDsZ/Pfm3egGO+Lh4dHbMdtKgKu4RkwWbr/kVvgo7JVuTa5diSVwervGCb9IkNK0ifjNeAvHTDZvrJSyZZiLMDVdGDW4uGi233ydbVS3pQhhpDlEALrQhnLtSZDtyx+11oxrmaN6hPDJ2+y5KPpFa5tLGgI4MFZ5KkHRLtzOMA1uJ0w11KxhXz2e7WR/D4uOV8D5CdSaAWEUaBgvFKPVywyk3oUJgM1vimcQDaZko6YPff++d7TcmKoCKWd5PNAO/qTHRItwJFhXHWjw+uDI2bhXp+zVzyy5FOXmfsSzVn/tMOJtJ4Rm5nSYM5wUVW44dAJ8mKGfKOjBbBS2bAFmCPvKprooOHlAVRB0/wz2xX63HnM1B6oZt6HfCOhz5tl82oNEW1VENqaKwUj0TUQOPcgV5ry/3OduGPEcOswRr01yK0/BvUTlCb+LlEsxz2dV8cJMoDphv98qBsDYedStwG8HEeisjWOJZPjbmIEQGZtWO6KWZjT+azyeR8GRgMVQ4mZ62247MyMMyxpZc9JNeKfhhcew0RQElvqhjRTY/YXP94NSs0btT3H415Y6/lI57/5ZFxZXLe5EgG+ody9MDQsmvcKkNTgtKiRcQj9Mr6PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(26005)(186003)(66946007)(66556008)(66476007)(8676002)(4326008)(83380400001)(36756003)(316002)(6486002)(103116003)(508600001)(8936002)(2616005)(6666004)(5660300002)(38100700002)(38350700002)(86362001)(2906002)(6512007)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?az/j3Nn5Zo2qB+JxIsxQoOk/Ap7ws2Kh3LXZUzj+RLhzdUMXg/sNG4/aW41C?=
 =?us-ascii?Q?umR9h3ESjho3xvWgb0T9JA08X0cyTfv8q8GLe5vUYBI3rjQa78uhAfI79kU6?=
 =?us-ascii?Q?QNcpZa+MWZ1zZLPWZqxPzelPEC0NJ3nSrjNDI/kAI/+KJ+KiX7Hx7sD6R2Mu?=
 =?us-ascii?Q?Pl0eb9UgZVmGL8UKXopdAv/iXpw/dz63DMg3tLU4fHjGXOETrp4TpbtR+SEL?=
 =?us-ascii?Q?asieut4e/vYu8zA/OlLXPd8Ins3K1GRrjURUCaDx8M17zpjtyLbQRrRIITmL?=
 =?us-ascii?Q?9OOU8LLDLuieywzUiafBsW3ImAByeofBKdO97km6zC9TCsfcuzDDnFG2cDQa?=
 =?us-ascii?Q?akvmtUdMx753NEg0s1CbpoCMIcaucA/62twMzE/mAGS55gnE//iPK0ZheXYa?=
 =?us-ascii?Q?etuWfLgv9yAOg25cHoWN+Hy8b4HzCVA8U4pcSeHH9KNkWPlPfUeDvGbyDutv?=
 =?us-ascii?Q?t6AQZoMYRKK87GaZt1twVqPQ4+PIMYEz4+ugsYCNANRcGHPRL66eyCWWQCI/?=
 =?us-ascii?Q?+ig0L4EviRnFeZmPeoaaflppLpt6LSWpbrkX/7Ai5DkmGkQw3/B0L9F7iZ2E?=
 =?us-ascii?Q?KDmwU1xQJsdXnL2OVhOC9wydG7e69QPMZBo4meHRTQIUYzpFnKb7JSgaWxPT?=
 =?us-ascii?Q?7sALWcuFesQtT7iWtJ2w1qc17rMbKBpZQtzPqUpUQYS3Y379m/C+/zEgKMaL?=
 =?us-ascii?Q?/EhRi12wJMbQJlZCHq2Ul9mOHqVZaa2ULprukrYyl3j5zJ/v2GWrgN7Bu24w?=
 =?us-ascii?Q?UXsE0kErC5CNqWn0jBcvxS7z4sZfngFA6e9U3IQxgqt9Pxq+Eg5Ps4218/Kv?=
 =?us-ascii?Q?Y2Sf390IeNhPaOO9fKItslaGEEsv6I8VhLuM388ifNWagaNNkLu80PDk7gj9?=
 =?us-ascii?Q?Q5g3RRXmLhy33++dw9r9mkzK+vo8kl5jTeKGjPyJgXIsdGj4a+P9DWdpPv9h?=
 =?us-ascii?Q?nxiuUwBlXIz22BAis6cQjqJckKtd3clJsiiE4y86Ye0psrEQciXnghuz7jsk?=
 =?us-ascii?Q?34wtd0Bu/25tUPEUSuieV1o5cQKYfHGC/qMrpKxc2iLCfMGaRb5kFLgtWFrN?=
 =?us-ascii?Q?Dx0eVMJKMlpFvkcJNEa9T0PtdGjBAWWsO114ELa3viKMcNXfZh0WXbQisS/i?=
 =?us-ascii?Q?02tSKCRVGZIe6qNDAnAM/gg3SJFD9eBycOKIZwNhFrlYN012auyELW1dohs5?=
 =?us-ascii?Q?CffMk5jAaIhL5eHitG9/jUxEkHO0dKuDiF2cyFydZdkUCWVxCykwkwQby5LD?=
 =?us-ascii?Q?skN/f9s5vRq2JAsaqjzSSKe+VyCpLNeVfmTwFeIF6GgXsYKsLONtqBJSiwKk?=
 =?us-ascii?Q?4wowF7/KCtg4hyEPCdxtsunJ7tb2uJtcH0CCWyiV06Gj5TWSXHQDYLmU9hF9?=
 =?us-ascii?Q?kiFWtz9N7NMUlySWmiOY6fuN2iuw3ryZhmzr8djc6SXV/3OvZh3ivcMfhfHc?=
 =?us-ascii?Q?4b6+w6QQoYn6xbp/tqPiL2sIeyF2REfxphl5OXzZO+byRIufUaY2E0ba5nHB?=
 =?us-ascii?Q?nglHNyP60Pphb59SFOlNVBJFVep08wsiqhKSATq0flUKa+8vkgn8HzgHMW5l?=
 =?us-ascii?Q?NJemF92ZTv5U091auvT3Ly6mPvLaBrpIyRyrY7wWc4DVlrlB099T3S6WFGYk?=
 =?us-ascii?Q?szfsLHOSCQrRBwg9gE7v1IyVhgM9U0UUBBoppd/0sY6H3oc8hh3wJw5dD2uO?=
 =?us-ascii?Q?080MDMrwqVk/+Lda68x9ELZR3a13/uO3iNWWnW/Gx9ZlZsN3/rLj1Q6sZ9g2?=
 =?us-ascii?Q?YVl8LJiubnXIadzndqjKh2sFwUWgSis=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3e2586-844f-4acc-ab70-08da1a9b1317
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2022 02:37:37.2041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siZ20musZWQx3aOfurZ9wtSuxnQ/XnaJgm3cdSwrdiatdCASh+i5oVZKzRhRZMxaoiWT3ygRbzVhhri/oBRrKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1238
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-09_25:2022-04-08,2022-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204100014
X-Proofpoint-ORIG-GUID: KYVYt-KbzWIwBA59itLAo8qENGE5RelR
X-Proofpoint-GUID: KYVYt-KbzWIwBA59itLAo8qENGE5RelR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After removal of kernfs_open_node->refcnt in the previous patch,
kernfs_open_node_lock can be removed as well by making ->attr.open
RCU protected. kernfs_put_open_node can delegate freeing to ->attr.open
to RCU and other readers of ->attr.open can do so under rcu_read_(un)lock.

So make ->attr.open RCU protected and remove global kernfs_open_node_lock.

Suggested by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/file.c       | 101 ++++++++++++++++++++++-------------------
 include/linux/kernfs.h |   2 +-
 2 files changed, 55 insertions(+), 48 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index aea6968c979e..bc393dcf4efa 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -23,16 +23,16 @@
  * for each kernfs_node with one or more open files.
  *
  * kernfs_node->attr.open points to kernfs_open_node.  attr.open is
- * protected by kernfs_open_node_lock.
+ * RCU protected.
  *
  * filp->private_data points to seq_file whose ->private points to
  * kernfs_open_file.  kernfs_open_files are chained at
  * kernfs_open_node->files, which is protected by kernfs_open_file_mutex.
  */
-static DEFINE_SPINLOCK(kernfs_open_node_lock);
 static DEFINE_MUTEX(kernfs_open_file_mutex);
 
 struct kernfs_open_node {
+	struct rcu_head         rcu_head;
 	atomic_t		event;
 	wait_queue_head_t	poll;
 	struct list_head	files; /* goes through kernfs_open_file.list */
@@ -156,8 +156,9 @@ static void kernfs_seq_stop(struct seq_file *sf, void *v)
 static int kernfs_seq_show(struct seq_file *sf, void *v)
 {
 	struct kernfs_open_file *of = sf->private;
+	struct kernfs_open_node *on = rcu_dereference_raw(of->kn->attr.open);
 
-	of->event = atomic_read(&of->kn->attr.open->event);
+	of->event = atomic_read(&on->event);
 
 	return of->kn->attr.ops->seq_show(sf, v);
 }
@@ -180,6 +181,7 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct kernfs_open_file *of = kernfs_of(iocb->ki_filp);
 	ssize_t len = min_t(size_t, iov_iter_count(iter), PAGE_SIZE);
 	const struct kernfs_ops *ops;
+	struct kernfs_open_node *on;
 	char *buf;
 
 	buf = of->prealloc_buf;
@@ -201,7 +203,8 @@ static ssize_t kernfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		goto out_free;
 	}
 
-	of->event = atomic_read(&of->kn->attr.open->event);
+	on = rcu_dereference_raw(of->kn->attr.open);
+	of->event = atomic_read(&on->event);
 	ops = kernfs_ops(of->kn);
 	if (ops->read)
 		len = ops->read(of, buf, len, iocb->ki_pos);
@@ -519,36 +522,34 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 {
 	struct kernfs_open_node *on, *new_on = NULL;
 
- retry:
 	mutex_lock(&kernfs_open_file_mutex);
-	spin_lock_irq(&kernfs_open_node_lock);
-
-	if (!kn->attr.open && new_on) {
-		kn->attr.open = new_on;
-		new_on = NULL;
-	}
-
-	on = kn->attr.open;
-	if (on)
-		list_add_tail(&of->list, &on->files);
-
-	spin_unlock_irq(&kernfs_open_node_lock);
-	mutex_unlock(&kernfs_open_file_mutex);
 
+	/**
+	 * ->attr.open changes under kernfs_open_file_mutex so we don't
+	 * need rcu_read_lock to ensure its existence.
+	 */
+	on = rcu_dereference_protected(kn->attr.open,
+				   lockdep_is_held(&kernfs_open_file_mutex));
 	if (on) {
-		kfree(new_on);
+		list_add_tail(&of->list, &on->files);
+		mutex_unlock(&kernfs_open_file_mutex);
 		return 0;
+	} else {
+		/* not there, initialize a new one and retry */
+		new_on = kmalloc(sizeof(*new_on), GFP_KERNEL);
+		if (!new_on) {
+			mutex_unlock(&kernfs_open_file_mutex);
+			return -ENOMEM;
+		}
+		atomic_set(&new_on->event, 1);
+		init_waitqueue_head(&new_on->poll);
+		INIT_LIST_HEAD(&new_on->files);
+		list_add_tail(&of->list, &new_on->files);
+		rcu_assign_pointer(kn->attr.open, new_on);
 	}
+	mutex_unlock(&kernfs_open_file_mutex);
 
-	/* not there, initialize a new one and retry */
-	new_on = kmalloc(sizeof(*new_on), GFP_KERNEL);
-	if (!new_on)
-		return -ENOMEM;
-
-	atomic_set(&new_on->event, 1);
-	init_waitqueue_head(&new_on->poll);
-	INIT_LIST_HEAD(&new_on->files);
-	goto retry;
+	return 0;
 }
 
 /**
@@ -566,24 +567,30 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 static void kernfs_put_open_node(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
-	struct kernfs_open_node *on = kn->attr.open;
-	unsigned long flags;
+	struct kernfs_open_node *on;
+
+	/* ->attr.open NULL means there are no more open files */
+	if (rcu_dereference_raw(kn->attr.open) == NULL)
+		return;
 
 	mutex_lock(&kernfs_open_file_mutex);
-	spin_lock_irqsave(&kernfs_open_node_lock, flags);
+
+	on = rcu_dereference_protected(kn->attr.open,
+				       lockdep_is_held(&kernfs_open_file_mutex));
+
+	if (!on) {
+		mutex_unlock(&kernfs_open_file_mutex);
+		return;
+	}
 
 	if (of)
 		list_del(&of->list);
 
-	if (list_empty(&on->files))
-		kn->attr.open = NULL;
-	else
-		on = NULL;
-
-	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
+	if (list_empty(&on->files)) {
+		rcu_assign_pointer(kn->attr.open, NULL);
+		kfree_rcu(on, rcu_head);
+	}
 	mutex_unlock(&kernfs_open_file_mutex);
-
-	kfree(on);
 }
 
 static int kernfs_fop_open(struct inode *inode, struct file *file)
@@ -765,12 +772,13 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
 
-	on = kn->attr.open;
-	if (!on)
+	if (rcu_dereference_raw(kn->attr.open) == NULL)
 		return;
 
 	mutex_lock(&kernfs_open_file_mutex);
-	if (!kn->attr.open) {
+	on = rcu_dereference_check(kn->attr.open,
+				   lockdep_is_held(&kernfs_open_file_mutex));
+	if (!on) {
 		mutex_unlock(&kernfs_open_file_mutex);
 		return;
 	}
@@ -805,7 +813,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 __poll_t kernfs_generic_poll(struct kernfs_open_file *of, poll_table *wait)
 {
 	struct kernfs_node *kn = kernfs_dentry_node(of->file->f_path.dentry);
-	struct kernfs_open_node *on = kn->attr.open;
+	struct kernfs_open_node *on = rcu_dereference_raw(kn->attr.open);
 
 	poll_wait(of->file, &on->poll, wait);
 
@@ -912,14 +920,13 @@ void kernfs_notify(struct kernfs_node *kn)
 		return;
 
 	/* kick poll immediately */
-	spin_lock_irqsave(&kernfs_open_node_lock, flags);
-	on = kn->attr.open;
+	rcu_read_lock();
+	on = rcu_dereference(kn->attr.open);
 	if (on) {
 		atomic_inc(&on->event);
 		wake_up_interruptible(&on->poll);
 	}
-	spin_unlock_irqrestore(&kernfs_open_node_lock, flags);
-
+	rcu_read_unlock();
 	/* schedule work to kick fsnotify */
 	spin_lock_irqsave(&kernfs_notify_lock, flags);
 	if (!kn->attr.notify_next) {
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index e2ae15a6225e..13f54f078a52 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -114,7 +114,7 @@ struct kernfs_elem_symlink {
 
 struct kernfs_elem_attr {
 	const struct kernfs_ops	*ops;
-	struct kernfs_open_node	*open;
+	struct kernfs_open_node __rcu	*open;
 	loff_t			size;
 	struct kernfs_node	*notify_next;	/* for kernfs_notify() */
 };
-- 
2.30.2

