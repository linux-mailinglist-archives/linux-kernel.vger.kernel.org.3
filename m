Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03A25816DF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiGZP6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGZP6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:58:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A182C12F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:58:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QFnQHv006253;
        Tue, 26 Jul 2022 15:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=uxKilt5LssoVv6ecc2/vVHYpMWItEfkA0KQPjZFfZF0=;
 b=VXHVFwcyTmR14VNAE36XJt0tdcBRW1aYR4XucprqnOf/WaZrMDS0JP3+FUhWctjaAE+f
 oYlLhU5W0BdqMtnelYknYGZixHUS5wMfi2gXy7FeCfbL+z4F33VaQJ0nwDtluFRwfqUS
 MGX2sAC5f3ABAEgJJ77YzqOxIqykcXrnYrWjTBOallmCLwbKmgn1cOGR9D+87hfqtfrL
 6+XZI7A9h2PSDacR8nWzbdMja24UW/IgTtXq2t7xOoc/jPswqZe/DKJ5vPwmUlHXcBPd
 o2IEWu3+1+1ntINt7+jNYlJTbvWLJbN4v9p69WM80+UQzVlAPXVjjrg6r3szL91MqH7e tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg940pswf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 15:58:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26QEElRx023015;
        Tue, 26 Jul 2022 15:58:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh5yuy456-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 15:58:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/Dgm/cg7aWruZ3A+cI0yXCQI7jvat87ce8ZZtN+/9qk6NeZVE6BvmXAHeV5LUjM/JLau62fzE2pFVYrHxD8DqbgZADyH9B+MYt0pB+o6jk0uIyXlWHAZBa+JuMiReliBNoaLDxDTirob0m/xlhJJhxJpkOoDDGqx/KyARxSI2Bj0YZdQJhQdiLlP0mNZuE2+yoCbzM2EDYbXHyKL6l1uIUf2eOQLduDlV9kBB5deWuYleIybWgG3sevERuAB+ESBdyCcMJjMFqcSdWmrHfDWWgSZBjBZMkoSd2I6Fa0gOxV0MZsPhMuie6ywR4B7hSEqIhaWYrPhpkGTqNHf5NSBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxKilt5LssoVv6ecc2/vVHYpMWItEfkA0KQPjZFfZF0=;
 b=dCqLKeJzoRGcqX9AJMezOArewTz2ghV4qkRwD8ob6e3xUzty8Ie2UZvBjsnZ7gLNGK+piDj/5db5QB8rRkBeySJyiW7RypewHkWhtjQ3tTvk0nli4B0VxMfpIBCOlpqC6eV2/cleJpc7M48GKnDDVNDlhRgWXUwrx6ijRtd9NUtAlC0wg0pSV6xCPy0sMQ5uVRew0sBha2taZ30EC8yK5NnkoJOqU85r9yX0tINbttujk79EW9aghqdYcDrelg6sarRVdmIwUgXmwuA9EIviQmoC9AckLXW8tJt36GFHKfpqmH7Gi+zZPInVm1pWWBVPGoid8Erd0ZHbnnkOXKA7iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxKilt5LssoVv6ecc2/vVHYpMWItEfkA0KQPjZFfZF0=;
 b=qPwqhpsxOBkTa2MO3ow6UwEM3cVx3/I0q8Kw4vEanf2wykYdntem81ifLAPyX1n/owDQDafyBci15KcFD4W0ITZdyGsOgyP+O3aoCjbAfRYL63rI1NHFMhsZ/vEZkKHVcaz4PT8xEvlNHxERM+a9FpoWJaWPoLug1CFt9mHDoXU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ1PR10MB5930.namprd10.prod.outlook.com
 (2603:10b6:a03:48b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Tue, 26 Jul
 2022 15:58:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 15:58:42 +0000
Date:   Tue, 26 Jul 2022 18:58:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Pavel Begunkov <asml.silence@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [isilence:zc_perf_tests 10/10] io_uring/net.c:1113 io_sendzc1()
 warn: ignoring unreachable code.
Message-ID: <202207261540.tELcS8V6-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8deb380b-9536-41e6-4357-08da6f1fb6bd
X-MS-TrafficTypeDiagnostic: SJ1PR10MB5930:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AF4TDbF+aijp9y3K+8yRpibbLdwJKJm5DxHp1scv2bkM3LE7YHyKrPrP0fKIjJgpqpl4GAf6nTHx+HrekptSiC+FynYtzh52YYiifkphkWb8ueqnp+ZgPtOtg35mco3lrUbl5YUskY8Ofgwjralle3kIH5FKV/XFMEtReDz6JwyJO9QYO1UX8rOa3ZR1tIgN/Nii/F8L/89t2XgyK87pk9jR/Ft7W9kGbeJH5+zPLz2ecIcA0EWgAfvZORmVru//fyidlubdl7pAemQhA+6lm1gJwkUBkV+T+ufOQ9pSrfxonGD9fxjlxIKyDWHUhGwu1QJIQ97CpklLD4AA5b/6EHQ3vticRgoq0iDv+uNCPzrCe+JCnhz+8yohaWCNLaKwuG+mkpMYbUT2SeS4uNeKpGI5Am+ASC+1nt8QHJzbe4pY+eIdjqrMGoJtAjE/5ZLtYuU7gaz5LEI7vw2OTDVCsYaHCV8d8811lLi/uP1oxQr8sgT6+jLs13DlVn1fo1jZRsN7kLC/Djz9gA7myiUGHbkA38cjOSRCy+TaJT1T5TEaAVQm0EsM5M0wYyM9d4V54px44qm7zPbDlNNkvSUFi697j/sW38n9NrT2snZ0w+CG77CWHmTGanf2PYxsxv/8A5pcBLNvn+PM8ZurNYUNUeOpykxBnJNSn6+AZCKMvi/GXgi/U5LtfaLjgZEorvxg1K/1BM0yAB3tVKWWcaCwkk0zl3GoZCqiNs0n6EaQHvDGdRZA+RVqR0gG4VthV5fF7I511zdwmY/JzlG3bpUjc4DCc+eblOCDOIrAJpIgH5SGFHFzztr7lqjW+NPKlZlBHDFqo2Oioqgzm+WQKaGKs0pw+Hprl/XxGWYiTDpHBT9vEFM7alWMUQNruqeICUt5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(136003)(366004)(316002)(5660300002)(83380400001)(86362001)(38100700002)(6916009)(38350700002)(4326008)(8676002)(186003)(1076003)(66556008)(66476007)(66946007)(478600001)(6666004)(8936002)(36756003)(44832011)(966005)(6486002)(26005)(52116002)(6512007)(2906002)(41300700001)(9686003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+/H1XC8FSk272OikCdaza8KCoxI2he7AmlmJ9SVF+f517VD7AyeIH5JQLrow?=
 =?us-ascii?Q?bwW99mMB61/DhxNPzxPxEQ7JRVkTQpBnIFvARmdIe8KAlx3Zm1Hi1GeZzNht?=
 =?us-ascii?Q?PuhYMnrNegtIZbdV3+S6nSN7PTCQKUZ+2H1mjUmE+nx2jhwuYJdevUoWtMF7?=
 =?us-ascii?Q?7y9hK6IJz/HqWYVpLzBpdKv6lw3kaJm4GBq8ug5YrxIZO0J1MxgHXzDs9LjM?=
 =?us-ascii?Q?PQT1o+HT7RzDLouKgQNtCM20MwC1Z7NHGRFnBz5DlsE0T1EEBVEt714WqhBN?=
 =?us-ascii?Q?xvE9OO5e0rpmPyjZLbUiEH/F26ZSw/v6iMHPZioHY4/u775EKhfzecr9VwzF?=
 =?us-ascii?Q?Eujl0jbVB2KpUSmvEjUMwyd9ZDLhgSwKHwmou5Z+heOQX3OV1CzByLoQ59np?=
 =?us-ascii?Q?lnK+SQhx7JqjBph4jssbH5j4rRaefQAVHvbxiFXSMwU5fsl9GTGW1lgIWcvl?=
 =?us-ascii?Q?H0fZaHWbxDBZIHodcOcfsh+eBwJTdRLzQ8qaSqRlMvMFdNuHpuIKzUcy2N0b?=
 =?us-ascii?Q?drJh+26ec3TIFh6sivrVIsyA8qfKgtyZXgNZ1XG8L/z8wZq3WkUpqYehDXyd?=
 =?us-ascii?Q?P6DLquKvLQTp98eJuCSdEXlAtLPomSTOtAQPZ8xEZfrVF0LdKE6xineV4fvm?=
 =?us-ascii?Q?i6qSQAopGgmU0gQgvKGMqEigy5h9r8T1yyVp5n65SqkF3hzUUlK3+UIopsKi?=
 =?us-ascii?Q?uNkRvo4NkVaDiBr2Duyl5Ig2rdDaf2wcllSh8Il93L4AuSB6WC6zw+stz8jM?=
 =?us-ascii?Q?FQ8bfKDdzFXc2xH30Cn8yi4v9RBFsqRw9nrASH3wNIYSRyxIZRBDYnmnDMrG?=
 =?us-ascii?Q?hEv4Me5smC/Z7kQnG9QutHJ4WiurS8ychH9ue96InLuWzTWRXD+3HhKyLJ1O?=
 =?us-ascii?Q?pKwzcHRdzEnApZrHKGJq6/GC494LA53QNetm2x61hXuNg6cfpctA/z4boNJm?=
 =?us-ascii?Q?ifEYaQoQb5iRvFy7YgxUscywzoqRTosq3pqwzS1Mk+TiDANgy0dwl4HJvEW7?=
 =?us-ascii?Q?mbro0DLI7LBxiQ54rx9X7vzzx0ku5xRhHTlwU7Z5drEYxe5G/JNod1tZQubn?=
 =?us-ascii?Q?rnlrRG4d55UAOf6JgCWXdlhASM/OuZgM0a3msIQbm0S3HWxHNE20rHSDgfF7?=
 =?us-ascii?Q?bIXalKZ4uTlpaHpSdKoUDDb7eQrhdZo1M4qAuv6Y3DgvHyCVPcUdLoqB7r9y?=
 =?us-ascii?Q?w5HbKtLQxOmFV/rbqPOFMWmjFnbkmyoEHYf6Z+HUITpIFuZx9zIfqa3BfBFx?=
 =?us-ascii?Q?gqKyaL4JvqutFLk3WmLNlpFMTup7C7f+2MmX3FpP5xBIzgWFOqC2GU1xCaFN?=
 =?us-ascii?Q?oiPAy4XBmXVZbkssuEBaeyDcUkBvtYZZSdgzEuALoRkBRZdbeaiMPdtI171n?=
 =?us-ascii?Q?xero7P70269RHO+dx3hAucSoytk8WAZWz/dIoWwWuemtezO91vY+QWFYGWx7?=
 =?us-ascii?Q?k/TFblHFr6F/FHWAgudW+qhT4JDZyQUzPcV7SihWRqcpRtZWPnKV/zhYm7/T?=
 =?us-ascii?Q?Yl3j4P1b+01Cj51T9WyE7Sa1p/b0s7AT9pbA1oL62JLNorf90f5DuLNzXuj8?=
 =?us-ascii?Q?gA9ZPc+Zv7TixOQ2QHgj+9L2ZFMm+Z7LMDNFs8UdnNZ3sFV9D3Hrfem6oEGe?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8deb380b-9536-41e6-4357-08da6f1fb6bd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 15:58:42.7966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUMqJvM5+2PSSRI+LeBnSH92WWNjc3oCguoWO9YmHnzC7MetGgo4cQ7CPUe9P3/QJErY0Q6urL9a5azh5knqiq29czYrkDakZ9eVMlXFKp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5930
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207260062
X-Proofpoint-GUID: J4W7ip7d48S6nYNdUo_Jzmuw_QogJIrU
X-Proofpoint-ORIG-GUID: J4W7ip7d48S6nYNdUo_Jzmuw_QogJIrU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/isilence/linux zc_perf_tests
head:   0909a53e1c81ca9432cbb58d15b87e500595bcbd
commit: 0909a53e1c81ca9432cbb58d15b87e500595bcbd [10/10] io_uring: simple zc
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220726/202207261540.tELcS8V6-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
io_uring/net.c:1113 io_sendzc1() warn: ignoring unreachable code.

vim +1113 io_uring/net.c

0909a53e1c81ca Pavel Begunkov 2022-07-24  1087  int io_sendzc1(struct io_kiocb *req, unsigned int issue_flags)
0909a53e1c81ca Pavel Begunkov 2022-07-24  1088  {
0909a53e1c81ca Pavel Begunkov 2022-07-24  1089  	struct io_sendzc1 *zc = io_kiocb_to_cmd(req);
0909a53e1c81ca Pavel Begunkov 2022-07-24  1090  	struct msghdr msg;
0909a53e1c81ca Pavel Begunkov 2022-07-24  1091  	struct iovec iov;
0909a53e1c81ca Pavel Begunkov 2022-07-24  1092  	struct socket *sock;
0909a53e1c81ca Pavel Begunkov 2022-07-24  1093  	unsigned msg_flags;
0909a53e1c81ca Pavel Begunkov 2022-07-24  1094  	int ret, min_ret = 0;
0909a53e1c81ca Pavel Begunkov 2022-07-24  1095  
0909a53e1c81ca Pavel Begunkov 2022-07-24  1096  	sock = sock_from_file(req->file);
0909a53e1c81ca Pavel Begunkov 2022-07-24  1097  	if (unlikely(!sock))
0909a53e1c81ca Pavel Begunkov 2022-07-24  1098  		return -ENOTSOCK;
0909a53e1c81ca Pavel Begunkov 2022-07-24  1099  
0909a53e1c81ca Pavel Begunkov 2022-07-24  1100  	msg.msg_name = NULL;
0909a53e1c81ca Pavel Begunkov 2022-07-24  1101  	msg.msg_control = NULL;
0909a53e1c81ca Pavel Begunkov 2022-07-24  1102  	msg.msg_controllen = 0;
0909a53e1c81ca Pavel Begunkov 2022-07-24  1103  	msg.msg_namelen = 0;
0909a53e1c81ca Pavel Begunkov 2022-07-24  1104  
0909a53e1c81ca Pavel Begunkov 2022-07-24  1105  	if (req->imu) {
0909a53e1c81ca Pavel Begunkov 2022-07-24  1106  		ret = io_import_fixed(WRITE, &msg.msg_iter, req->imu,
0909a53e1c81ca Pavel Begunkov 2022-07-24  1107  				      (u64)(uintptr_t)zc->buf, zc->len);
0909a53e1c81ca Pavel Begunkov 2022-07-24  1108  		if (unlikely(ret))
0909a53e1c81ca Pavel Begunkov 2022-07-24  1109  			return ret;
0909a53e1c81ca Pavel Begunkov 2022-07-24  1110  	} else {
0909a53e1c81ca Pavel Begunkov 2022-07-24  1111  		return -EFAULT;
                                                                ^^^^^^^^^^^^^^^

0909a53e1c81ca Pavel Begunkov 2022-07-24  1112  
0909a53e1c81ca Pavel Begunkov 2022-07-24 @1113  		ret = import_single_range(WRITE, zc->buf, zc->len, &iov,
0909a53e1c81ca Pavel Begunkov 2022-07-24  1114  					  &msg.msg_iter);
0909a53e1c81ca Pavel Begunkov 2022-07-24  1115  		if (unlikely(ret))
0909a53e1c81ca Pavel Begunkov 2022-07-24  1116  			return ret;
0909a53e1c81ca Pavel Begunkov 2022-07-24  1117  		/* TODO: add pinning accounting */
0909a53e1c81ca Pavel Begunkov 2022-07-24  1118  	}
0909a53e1c81ca Pavel Begunkov 2022-07-24  1119  
0909a53e1c81ca Pavel Begunkov 2022-07-24  1120  	msg_flags = zc->msg_flags | MSG_ZEROCOPY;
0909a53e1c81ca Pavel Begunkov 2022-07-24  1121  	if (issue_flags & IO_URING_F_NONBLOCK)
0909a53e1c81ca Pavel Begunkov 2022-07-24  1122  		msg_flags |= MSG_DONTWAIT;
0909a53e1c81ca Pavel Begunkov 2022-07-24  1123  	if (msg_flags & MSG_WAITALL)
0909a53e1c81ca Pavel Begunkov 2022-07-24  1124  		min_ret = iov_iter_count(&msg.msg_iter);
0909a53e1c81ca Pavel Begunkov 2022-07-24  1125  
0909a53e1c81ca Pavel Begunkov 2022-07-24  1126  	msg.msg_flags = msg_flags;
0909a53e1c81ca Pavel Begunkov 2022-07-24  1127  	msg.msg_ubuf = &zc->ubuf;
0909a53e1c81ca Pavel Begunkov 2022-07-24  1128  	msg.sg_from_iter = io_sg_from_iter;
0909a53e1c81ca Pavel Begunkov 2022-07-24  1129  	ret = sock_sendmsg(sock, &msg);
0909a53e1c81ca Pavel Begunkov 2022-07-24  1130  
0909a53e1c81ca Pavel Begunkov 2022-07-24  1131  	req->cqe.res = ret;
0909a53e1c81ca Pavel Begunkov 2022-07-24  1132  	if (refcount_dec_and_test(&zc->ubuf.refcnt)) {
0909a53e1c81ca Pavel Begunkov 2022-07-24  1133  		io_req_set_res(req, req->cqe.res, 0);
0909a53e1c81ca Pavel Begunkov 2022-07-24  1134  		return IOU_OK;
0909a53e1c81ca Pavel Begunkov 2022-07-24  1135  	}
0909a53e1c81ca Pavel Begunkov 2022-07-24  1136  	return IOU_ISSUE_SKIP_COMPLETE;
0909a53e1c81ca Pavel Begunkov 2022-07-24  1137  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

