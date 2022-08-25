Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EA45A10D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241270AbiHYMm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241992AbiHYMmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:42:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663B5B4E8A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:42:16 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PA97TW019323;
        Thu, 25 Aug 2022 12:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=XVD0Dsou4yUGIdlBExiDBn1v9JySR8afRIKMpxNnWus=;
 b=ZX66W8hJNAdnlm/ziCqPD6Ew0pCWA07oIB29yUsjV4nuaqOts4mgKS3R9UEx4+Lkft+t
 N54QYO0QAQUnKy/Eg0gkP42Jh9GlkO9cZ7zniw8Q2eVG3QO4+1c3fKeahYImBzUkKq+9
 aulSHJGr3gQ/zjmkQvS4Yha0kHQhO/LVESdlz+avv1gDkjlMJOxlLYH/rmJMgnvLEQMp
 cqvZ8p4s7hfLbOh8I1Y1Z/YfKTqZzjE9DdMLgefy3fszntPko0qSISkH2eswDuAelJWR
 YWHv0iHR1dP+BZ4qey+raii6gDNgpOE1Q8qqJ6XEyC2UjfWX7E08L7sOPeT7LngGMLG5 Vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55nycq86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 12:41:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27PA2Jvi008135;
        Thu, 25 Aug 2022 12:41:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n7bheq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 12:41:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akOa91RRy7jmB+UIpY4vpqKQxDctMPUl9+XESPM4035UNbW17eU5U5ULtbOkIVUN9Hgf+76wnXB1mNXbPvvTYraobMKFydNEJTkwiT53OkMPpr4UhvAxOZmvOd8CAgizevnwAnnOoscH7J/92C7qlUQ9q6rRrYdlEnEZqYcXiAVMa6lwhOuGaQnQLegFjzGZRjCyEeLBvYj2oZDYaT4QVCvn/3mxA/VafYDuWkYI6DF93lghcHmPkcv7puCTtIseveHQDWsTTLmUlOeeG0b9v3ZIJ50bCxgma5m29CmgVtEPp08ErRi8ZTfItQCk1PNu3Yhnn0Cg8tmqnnS0bhgKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVD0Dsou4yUGIdlBExiDBn1v9JySR8afRIKMpxNnWus=;
 b=OwKDdKo4hRUhWSwvBtzaI5otnjtAVCThL67cWqPr8FqiFQDW8nlc2cuJdrw3TsvOiMioR+6vPwm8VOarpzypwbe1psylHDUpfoZiAWPJ42BT4z9Aau6t9QHzHGpGoeUrza2zBOkwMy3EWzDjPxO5o/3WBlP5BUaQlmFAkRIYhFkYxyNQJPdqPJ3BgBRhomKz0QOeEBhe0bfcZ5RvLSdAWKUg05nvwrIYdvkT7T51vUw2zDXFwQJRg45SFVfcRiYQ72bF6Jxl+xq007k5LEjMRK2XRzh5zdeaZFFf6qa7Q06aa3dKA0u7J5EC7y3QlahQ2JDy/Lrmd0eJbXNcn9Lcwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVD0Dsou4yUGIdlBExiDBn1v9JySR8afRIKMpxNnWus=;
 b=XWER3wRuMBYdDIs4TJEpPhSixL204XQeathSprcCUUyVKRpqZS9HwxkjpNQPcTHqh/IOCYLcyDTW/Ui37FNTNvkv5xXdHtYTQ//H2Xv2n1EfiX3MkbsUt+ASQTbhX5gfH4Y/1UVfgu/rGC6BK11EnI2DvWBqDtxU15+gClUmbM8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB2699.namprd10.prod.outlook.com
 (2603:10b6:5:b3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Thu, 25 Aug
 2022 12:41:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5546.024; Thu, 25 Aug 2022
 12:41:48 +0000
Date:   Thu, 25 Aug 2022 15:41:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Czerwacki, Eial" <eial.czerwacki@sap.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arsh, Leonid" <leonid.arsh@sap.com>,
        "Twaig, Oren" <oren.twaig@sap.com>,
        SAP vSMP Linux Maintainer <linux.vsmp@sap.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andra Paraschiv <andraprs@amazon.com>,
        Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Eric Biggers <ebiggers@google.com>, Fei Li <fei1.li@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2] drivers/virt/vSMP: new driver
Message-ID: <20220825124123.GE2030@kadam>
References: <PAXPR02MB731058B69D178E026C578BB481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR02MB731058B69D178E026C578BB481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::30)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 718b8c6a-36a0-4579-a9ce-08da86972cb4
X-MS-TrafficTypeDiagnostic: DM6PR10MB2699:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ay7Qq341j0WDy1Qv3KBglIi9FpI2OGnLc8A2Ip6qX3wIOAFY9uVrJrKA6OQ0pFDurXK6e4grn/zL8HakHscU6hUr1gduJKqbFF3N9nmO/jDwU+Inrf5u9g8eN7I+ffO3wWnFmi+tO/ZMjjU1OKZzkF2TTZxxcvi+EcqCg9fM+P9W6eOVWfJE3qaYzFfZ80ZOjM1Fb6zuBUSuttUdBe014yO391v0Hp/5Z7+vr1GC6vmY09XwSEcSK7H7gVmjFaJMUjSIR5vCPuEaJ6CGYAq3cLTy5+ySZe7Zx/Pw0k1hFELj8Ae1rQsccn4/Am+DWOiKx8N95+8H1DoDRzbXsOMqTykf1B83t3x7J0KKLQIy0BwCysxISaxYvhIMQp2qUxdl5x06iN3TNy/RD6C8x1DNybeFZsUMgKyOxYG4NJl2obhnQbat3dsqxWEt9aBuODTDy3KWg40bv3F/allY1ILI8UTu3LoIAEzR0pJJmfb/mRVbh1wD3PCKmBklvsB4KttZxg+p0f6lPSharculuAMLX99qE4xRL0S/zWbr4M4uOlMfLyb9s6M1/S685xqaowNTojFJUgYkimbD3fSaNgv3R7OwvK/9MYwkeN+bejBrqs05OsWYKOQ1EslIo5nFFWEfSrgrU2ccZy0qvRIYxqKRgDFs/nROFm6ntC9k/Wd59kG4BC25bn8XiZiVL6RdcrByXfohmKCpt8fofA3yt3oaGMIbmcIvM1F8z/O4M7xBP+z/NoKBmLtA8BtYY2eC2B8oiN1JmLziCWUoIcF41w4PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(396003)(136003)(366004)(376002)(39860400002)(86362001)(41300700001)(6666004)(66556008)(478600001)(6512007)(6506007)(33656002)(9686003)(52116002)(83380400001)(1076003)(6486002)(186003)(26005)(316002)(30864003)(66946007)(33716001)(66476007)(54906003)(8676002)(2906002)(4326008)(38350700002)(6916009)(8936002)(5660300002)(7416002)(44832011)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zg6/dukQOW+UkFFeZWAm0/whgxVr8+iZuchCV3ZKa9BfM5Ed4NjrZdOFph7b?=
 =?us-ascii?Q?zum+GYglMxmqaZG8cKJBMLx2HyRKb298hRlsCj+iRhfzpAPjzYEBfimCLpxV?=
 =?us-ascii?Q?yD2qxriJXiKQ0CEyHUtettDtBweglWv0GXTPj8oZh/aOzuEgKjbd18oli1nw?=
 =?us-ascii?Q?E5pzR3h7/HRSkW9l5EGt+YVD3lPwjxvlkxTjBzC7USl2XRtXbvjPNa4O8zoj?=
 =?us-ascii?Q?+B7KeN55f9M7b3TvE0S8Hwyofa2/f3lVxUlpSkPVxpFa3bSAE+VUSbxTmrQh?=
 =?us-ascii?Q?Ape5iMVMjatRh5bGh4kFBcKRKCJo0znXfLVPfLuokOR9URRB5CS2zslguqTK?=
 =?us-ascii?Q?KvnTPI1FJNL5m9wY/WxQOqWaapTO8pBotlzOv/fqJheJ7UnqDN7suZn3HYOw?=
 =?us-ascii?Q?kf59OzSmYKITR9+48ujBsZHD+dGJLtmcKzxmwBF+KSQR2X50XvX9coEyz6zU?=
 =?us-ascii?Q?LtoMPZUvbAUCH5uCY30pT8I8/CKCA7G8nSM39qyiYYXxIjBwxc/+zFUzVIGH?=
 =?us-ascii?Q?YUc/pKcL8lxnPEBaT3uP5ywMpl4wYHiGgayW9F770ESFxphnJ5ski/APEOqj?=
 =?us-ascii?Q?pAZ8g88sRNa1wpNr21ieX5z3c7Flg1/bRkLvqQ83JiPGmyf260vpSS3N7T3W?=
 =?us-ascii?Q?L5HDM8iQ7CVaWFvZ854EdYUdJYbpm3FbG8mb1+dPYJ9qVi1iOw/CqS7f6STu?=
 =?us-ascii?Q?CLQqDT3pqe3nnB+hn++p1AdQ//ZfXkSr6BXrmj9cMGdZmjgaQBNwj1hdoN8s?=
 =?us-ascii?Q?SOeo2WV+FeEoDJj8qZb2+PlzHRbcwjkhCxZG5mH7txOcE0JkD/UZ3IkjTp4v?=
 =?us-ascii?Q?dtlGsrWFlNYaBa4VBIwWHag/2kV34IuD3jAyoP0Konpg0+QxVZdQYtK82Ynq?=
 =?us-ascii?Q?m9TzC+6w1dbQxQxnyMikRiRFuiMWwFRhigMrjVvrWQiUfri6KZmaVl/Dv5Ez?=
 =?us-ascii?Q?TsBJaPejKxB1ihpWKHQ64l0pPhwLmK74THZ7BrRG21V+t8Z7g2DXgyIDFGbE?=
 =?us-ascii?Q?3j3ODGoWe8oMMrv4YPz9ePtlp6ZmVkLMh8T89J9xu0Z1ifyG+IYWUjWz8mWt?=
 =?us-ascii?Q?PSGN5uWuslQYXn0pRR7KDiNCTJjELFmIabB8hFZm9p8+VegTL7ePBTzw+yEh?=
 =?us-ascii?Q?vNQ51VMUDJEm3GiJrnI10qyxImk0tOGjflQQZX2cdyrTRZjZAS63BEhSg9Wk?=
 =?us-ascii?Q?NNUT+x4J56VQ3UkrUlmJ/x9jovwlZnjBvyLN/DEIIPVNu8NFvth2XiTPXAqe?=
 =?us-ascii?Q?TMvXAE+EAWN5boL9pd0zkliYN3sP+kSzz2P0wUQxTvzC9SSOWWCp5MkgHHKk?=
 =?us-ascii?Q?4rIyss5NHXQj2wwbNKFpDhwlEJ4g4yJrCmLyGnosvUn38o8R+2eg7MluutX0?=
 =?us-ascii?Q?QDnrhpO0KsAc8ksP89+zQU3ANmc5P43G+htCmPNIPsKYXzYnvZcX9jQObjEm?=
 =?us-ascii?Q?EVFnPzUazGT12297oM4U4mfYzDuweQE8Vwk5Ac6R19eBK2y97C5Ud9Vc+X9o?=
 =?us-ascii?Q?i1OCpetHilX1dMSUqo7aCRRU1paQGhGzEYz58OJ7sJvYBnIRrqPP72y1GDzC?=
 =?us-ascii?Q?6o1MVD5byN4YM18qDM1VOgmH5OlhXktBABAlTLtO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 718b8c6a-36a0-4579-a9ce-08da86972cb4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 12:41:48.1129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BynDDgeCPiVRN9+D/n0NOXowyr/2DE3aQC1kHxtZ6ngw8vooN+DpnXEtwaoh3kXDcBAy1lNuWnVCE0EQDvbiaNh5Qk/TxHSIRZgo4Wv84jE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_05,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250049
X-Proofpoint-ORIG-GUID: upGukqwJe1TbdStaChnUl8BJjls_144Y
X-Proofpoint-GUID: upGukqwJe1TbdStaChnUl8BJjls_144Y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 06:24:02AM +0000, Czerwacki, Eial wrote:
> +obj-$(CONFIG_VSMP) = vsmp.o
> +vsmp-y := vsmp_main.o api/api.o version/version.o
> diff --git a/drivers/virt/vsmp/api/api.c b/drivers/virt/vsmp/api/api.c
> new file mode 100644
> index 000000000000..6e40935907bc
> --- /dev/null
> +++ b/drivers/virt/vsmp/api/api.c
> @@ -0,0 +1,249 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * vSMP driver api
> + * (C) Copyright 2022 SAP SE
> + */
> +
> +#include "api.h"
> +
> +static void __iomem *cfg_addr;
> +static struct kobject *vsmp_sysfs_kobj;
> +static struct pci_dev *vsmp_dev_obj;

Try to avoid globals as much as possible.

> +
> +/* R/W ops handlers */
> +
> +/*
> + * Init a vsmp firmware operation object
> + */
> +int vsmp_init_op(struct fw_ops *op, ssize_t max_size,
> +		 enum vsmp_fw_action action)
> +{
> +	op->hwi_block_size = max_size;
> +	op->action = action;
> +	op->buff_offset = op->hwi_block_size;

The ->buff_offset is the number of empty bytes.  It's badly named,
because it's not an offset at all.

> +
> +	op->buff = kzalloc(op->hwi_block_size, GFP_KERNEL);
> +	if (!op->buff)
> +		return -ENOMEM;
> +
> +	vsmp_reset_op(op);

This is a no-op.  op->buff_offset is already set and ->buf is already
zero.  Delete.

> +
> +	return 0;
> +}
> +
> +/*
> + * Release an vsmp firmware operation object
> + */
> +void vsmp_release_op(struct fw_ops *op)
> +{
> +	if (!op) {
> +		WARN_ON(!op);

	if (WARN_ON(!op))
		return;

> +		return;
> +	}
> +
> +	if (!op->buff) {
> +		WARN_ON(!op->buff);
> +		return;
> +	}
> +
> +	kfree(op->buff);
> +	memset(op, 0, sizeof(*op));
> +}
> +
> +/*
> + * Reset a vsmp firmware operation object
> + */
> +void vsmp_reset_op(struct fw_ops *op)
> +{
> +	memset(op->buff, 0, op->hwi_block_size);
> +	op->buff_offset = op->hwi_block_size;
> +}
> +
> +/* Regs/Buffs R/W handlers */
> +
> +/*
> + * Read a value from a specific register in the vSMP's device config space
> + */
> +u64 vsmp_read_reg_from_cfg(u64 reg, enum reg_size_type type)
> +{
> +	u64 ret_val;
> +
> +	switch (type) {
> +	case VSMP_CTL_REG_SIZE_8BIT:
> +		ret_val = readb(cfg_addr + reg);
> +		break;
> +
> +	case VSMP_CTL_REG_SIZE_16BIT:
> +		ret_val = readw(cfg_addr + reg);
> +		break;
> +
> +	case VSMP_CTL_REG_SIZE_32BIT:
> +		ret_val = readl(cfg_addr + reg);
> +		break;
> +
> +	case VSMP_CTL_REG_SIZE_64BIT:
> +		ret_val = readq(cfg_addr + reg);
> +		break;
> +
> +	default:
> +		dev_err(get_dev(), "Unsupported reg size type %d.\n", type);
> +		ret_val = (u64) -EINVAL;

This can never happen and there are two places which check for negative
returns but both are wrong.  Delete the dead code or make it simple.

		dev_err(get_dev(), "Unsupported reg size type %d.\n", type);
		ret_val = 0;

Then delete all the error handling in the callers.

> +	}
> +
> +	dev_dbg(get_dev(), "%s: read 0x%llx from reg 0x%llx of %d bits\n",
> +		__func__, ret_val, reg, (type + 1) * 8);

This function only exists because we want this debug statement.  I have
a strong bias towards deleting debug code and calling readl() directly.
In other words, delete this whole function.  Or keep it...  But at least
consider deleting it.

> +	return ret_val;
> +}
> +
> +/*
> + * Read a buffer from the bar byte by byte for halt on
> + * null termination.
> + * Expected buffs are strings.
> + */
> +static ssize_t read_buff_from_bar_in_bytes(char *out, u8 __iomem *buff, ssize_t len)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < len; i++) {
> +		out[i] = ioread8(&buff[i]);
> +		if (!out[i])
> +			break;
> +	}
> +
> +	return i;
> +}
> +
> +/*
> + * Read a buffer from a specific offset in a specific bar,
> + * maxed to a predefined len size-wise from the vSMP device
> + */
> +int vsmp_read_buff_from_bar(u8 bar, u32 offset, char *out, ssize_t len,

The type mismatches bother me.  In some of the callers "bar" and "offset"
are u64 reg_vals but here they are a u8 and a u32.

> +			    bool halt_on_null)
> +{
> +	u8 __iomem *buff;
> +	u64 bar_start = pci_resource_start(vsmp_dev_obj, bar);
> +	u32 bar_len = pci_resource_len(vsmp_dev_obj, bar);
> +	ssize_t actual_len = len;
> +
> +	/* incase of overflow, warn and use max len possible */
> +	if ((offset + len) > bar_len) {
> +		WARN_ON((offset + len) > actual_len);
> +		actual_len = bar_len - offset;
> +		dev_dbg(get_dev(), "%lu overflows bar len, using %ld len instead\n",
> +			len, actual_len);
> +	}
> +
> +	buff = ioremap(bar_start + offset, actual_len);
> +	if (!buff)
> +		return -ENOMEM;
> +
> +	if (halt_on_null)
> +		read_buff_from_bar_in_bytes(out, buff, len);
> +	else
> +		memcpy_fromio(out, buff, len);

These are buffer overflows.  s/len/actual_len/

> +
> +	iounmap(buff);
> +
> +	return 0;
> +}
> +
> +/*
> + * Generic function to read from the bar
> + */
> +ssize_t vsmp_generic_buff_read(struct fw_ops *op, u8 bar, u64 reg,
> +			       char *buf, loff_t off, ssize_t count)
> +{
> +	ssize_t ret_val = 0;
> +
> +	if (op->buff_offset >= op->hwi_block_size) {	/* perform H/W op */

Hopefully op->buff_offset can never be > op->hwi_block_size.  (I worry
that because "op" is a global maybe race conditions mean this is
possible.)  Remeber that op->buff_offset means "bytes_available", it is
not an offset.  So if all the bytes are available then...

> +		vsmp_reset_op(op);

Delete everything, and set op->buff_offset == op->hwi_block_size.

> +
> +		ret_val = vsmp_read_buff_from_bar(bar, reg, op->buff, op->hwi_block_size, false);

Read some data.

> +		if (ret_val) {
> +			dev_err(get_dev(), "%s operation failed\n",
> +				(op->action == FW_READ) ? "read" : "write");
> +		}
> +		op->buff_offset = 0;

No bytes available.

> +	}

Or else read what we have.

> +
> +	if (ret_val)
> +		return ret_val;
> +
> +	return memory_read_from_buffer(buf, count, &op->buff_offset, op->buff, op->hwi_block_size);
                                                   ^^^^^^^^^^^^^^^^
Here offset is used as an offset.  If it's not zero then this is read
nonsense data.


> +}
> +
> +/* sysfs handlers */
> +
> +/*
> + * Register the vSMP sysfs object for user space interaction
> + */
> +int vsmp_register_sysfs_group(const struct bin_attribute *bin_attr)
> +{
> +	int error = -EINVAL;
> +
> +	if (vsmp_sysfs_kobj && bin_attr) {

Always do error handling.  Never do success handling.

	if (!vsmp_sysfs_kobj || !bin_attr)
		return -EINVAL;

	return sysfs_create_bin_file(vsmp_sysfs_kobj, bin_attr);


> +		error = sysfs_create_bin_file(vsmp_sysfs_kobj, bin_attr);
> +		if (error)
> +			dev_err(get_dev(), "Failed to register sysfs entry (%d)\n", error);
> +	}
> +
> +	return error;
> +}
> +
> +/*
> + * Deregister the vSMP sysfs object for user space interaction
> + */
> +void vsmp_deregister_sysfs_group(const struct bin_attribute *bin_attr)
> +{
> +	if (vsmp_sysfs_kobj && bin_attr)
> +		sysfs_remove_bin_file(vsmp_sysfs_kobj, bin_attr);
> +}
> +
> +/* Generic functions */
> +
> +/*
> + * Open the cfg address space of the vSDP device
> + */
> +int open_cfg_addr(struct pci_dev *pdev)
> +{
> +	u64 cfg_start;
> +	u32 cfg_len;
> +
> +	vsmp_dev_obj = pdev;
> +	cfg_start = pci_resource_start(vsmp_dev_obj, 0);
> +	cfg_len = pci_resource_len(vsmp_dev_obj, 0);
> +
> +	dev_dbg(get_dev(), "Mapping bar 0: [0x%llx,0x%llx]\n",
> +		cfg_start, cfg_start + cfg_len);
> +
> +	cfg_addr = ioremap(cfg_start, cfg_len);
> +	if (!cfg_addr) {
> +		dev_err(get_dev(), "Failed to map vSMP pci controller, exiting.\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +int init_sysfs(void)
> +{
> +	vsmp_sysfs_kobj = kobject_create_and_add("vsmp", hypervisor_kobj);
> +	if (!vsmp_sysfs_kobj) {
> +		dev_err(get_dev(), "Failed to create vSMP sysfs entry, exiting.\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +void cleanup(void)
> +{
> +	iounmap(cfg_addr);
> +	kobject_put(vsmp_sysfs_kobj);
> +}
> +
> +const struct device *get_dev(void)
> +{
> +	return &vsmp_dev_obj->dev;
> +}
> diff --git a/drivers/virt/vsmp/api/api.h b/drivers/virt/vsmp/api/api.h
> new file mode 100644
> index 000000000000..6142e947979f
> --- /dev/null
> +++ b/drivers/virt/vsmp/api/api.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * vSMP driver api header
> + * (C) Copyright 2022 SAP SE
> + */
> +
> +#ifndef VSMP_API_H
> +#define VSMP_API_H
> +
> +#include <linux/pci.h>
> +
> +// R/W ops handlers
> +#define vsmp_read_reg32_from_cfg(_reg_) \
> +	((u32) vsmp_read_reg_from_cfg((_reg_), VSMP_CTL_REG_SIZE_32BIT))
> +
> +enum reg_size_type {
> +	VSMP_CTL_REG_SIZE_8BIT = 0,
> +	VSMP_CTL_REG_SIZE_16BIT,
> +	VSMP_CTL_REG_SIZE_32BIT,
> +	VSMP_CTL_REG_SIZE_64BIT
> +};
> +
> +enum vsmp_fw_action {
> +	FW_READ = 0,
> +	FW_WRITE = 1
> +};
> +
> +struct fw_ops {
> +	enum vsmp_fw_action action;
> +	ssize_t hwi_block_size;
> +	unsigned char *buff;
> +	loff_t buff_offset;
> +	bool in_progress;
> +};
> +
> +int vsmp_init_op(struct fw_ops *op, ssize_t max_size,
> +		 enum vsmp_fw_action action);
> +void vsmp_release_op(struct fw_ops *op);
> +void vsmp_reset_op(struct fw_ops *op);
> +
> +#define FILE_PREM 0444

Spelling mistake.  Delete the define.  Avoid pointless indirection.

> +
> +/* Regs/Buffs R/W handlers */
> +#define vsmp_read_reg32_from_cfg(_reg_) \
> +	((u32) vsmp_read_reg_from_cfg((_reg_), VSMP_CTL_REG_SIZE_32BIT))

Delete this duplicate define.

> +
> +u64 vsmp_read_reg_from_cfg(u64 reg, enum reg_size_type type);
> +ssize_t vsmp_generic_buff_read(struct fw_ops *op, u8 bar, u64 reg,
> +			       char *buf, loff_t off, ssize_t count);
> +int vsmp_read_buff_from_bar(u8 bar, u32 offset, char *out, ssize_t len,
> +			    bool halt_on_null);
> +
> +typedef int (*sysfs_register_cb)(void);
> +typedef void (*sysfs_deregister_cb)(void);
> +
> +struct sysfs_entry_cbs {
> +	sysfs_register_cb reg_cb;
> +	sysfs_deregister_cb dereg_cb;
> +};
> +
> +int vsmp_register_sysfs_group(const struct bin_attribute *bin_attr);
> +void vsmp_deregister_sysfs_group(const struct bin_attribute *bin_attr);
> +
> +int open_cfg_addr(struct pci_dev *pdev);
> +int init_sysfs(void);
> +void cleanup(void);
> +const struct device *get_dev(void);
> +#endif /* VSMP_API_H */
> diff --git a/drivers/virt/vsmp/include/registers.h b/drivers/virt/vsmp/include/registers.h
> new file mode 100644
> index 000000000000..b6458d25e3b7
> --- /dev/null
> +++ b/drivers/virt/vsmp/include/registers.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * vSMP driver registers
> + * (C) Copyright 2022 SAP SE
> + */
> +
> +#ifndef VSMP_REGSITERS_H
> +#define VSMP_REGSITERS_H
> +
> +#define VSMP_VERSION_REG 0x0c
> +
> +#endif /* VSMP_REGSITERS_H */
> diff --git a/drivers/virt/vsmp/version/version.c b/drivers/virt/vsmp/version/version.c
> new file mode 100644
> index 000000000000..d8ad771daf28
> --- /dev/null
> +++ b/drivers/virt/vsmp/version/version.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * vSMP driver version module
> + * (C) Copyright 2022 SAP SE
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/kobject.h>
> +
> +#include "../api/api.h"
> +#include "../include/registers.h"
> +
> +/*
> + * This is the maximal possible length of the version which is a text string
> + * the real len is usually much smaller, thus the driver uses this once to read
> + * the version string and record it's actual len.
> + * From that point and on, the actual len will be used in each call.
> + */
> +#define VERSION_MAX_LEN (1 << 19)
> +
> +static struct fw_ops op;

Hate hate hate this global.

> +
> +static ssize_t version_read(struct file *filp, struct kobject *kobj,
> +			    struct bin_attribute *bin_attr,
> +			    char *buf, loff_t off, size_t count)
> +{
> +	u64 reg_val = vsmp_read_reg32_from_cfg(VSMP_VERSION_REG);
> +	ssize_t ret_val;
> +
> +	if (reg_val < 0) {

Delete impossible error handling.

> +		dev_err(get_dev(), "Failed to value of reg 0x%x\n", VSMP_VERSION_REG);
> +		return 0;
> +	}
> +
> +	ret_val = vsmp_generic_buff_read(&op, 0, reg_val, buf, off, count);
> +	if (ret_val < 0) {
> +		dev_err(get_dev(), "Failed to read version (%ld)\n", ret_val);
> +		return 0;

Return the error code.

> +	}
> +
> +	buf[ret_val++] = '\n';

This is a buffer overflow.

> +
> +	return ret_val;
> +}
> +
> +struct bin_attribute version_raw_attr = __BIN_ATTR(version, FILE_PREM,
> +						   version_read, NULL, VERSION_MAX_LEN);
> +
> +/*
> + * Retrieve str in order to determine the proper length.
> + * This is the best way to maintain backwards compatibility with all
> + * vSMP versions.
> + */
> +static ssize_t get_version_len(void)

Just make this an int.  kzalloc() cannot allocate anywhere close to
INT_MAX.

> +{
> +	ssize_t len = 0;
> +	u64 reg_val = vsmp_read_reg32_from_cfg(VSMP_VERSION_REG);
> +	char *version_str = kzalloc(VERSION_MAX_LEN, GFP_KERNEL);

Don't put function calls which can fail in the declaration block.

> +
> +	if (!version_str)
> +		return len;

Return -ENOMEM instead of zero.

> +
> +	if (vsmp_read_reg32_from_cfg(VSMP_VERSION_REG) < 0) {

Delete this impossible error handling.  Delete this block.  We already
saved VSMP_VERSION_REG in the declaration block.

> +		kfree(version_str);
> +		dev_err(get_dev(), "Failed to read value of reg 0x%x\n", VSMP_VERSION_REG);
> +		return len;
> +	}
> +
> +	memset(version_str, 0, VERSION_MAX_LEN);

kzalloc() already zeroes your memory.

> +	if (vsmp_read_buff_from_bar(0, reg_val, version_str, VERSION_MAX_LEN, true)) {
> +		kfree(version_str);
> +		dev_err(get_dev(), "Failed to read buffer from bar\n");
> +		return len;
> +	}
> +
> +	len = strlen(version_str);

This is a read overflow because there is no guarantee that
vsmp_read_buff_from_bar() returns a NULL terminated string.

> +	kfree(version_str);
> +
> +	return len;
> +}
> +
> +/*
> + * Register the version sysfs entry
> + */
> +int sysfs_register_version_cb(void)
> +{
> +	ssize_t len = get_version_len();
> +	int ret_val;
> +
> +	if (!len) {
> +		dev_err(get_dev(), "Failed to init vSMP version module\n");
> +		return -EINVAL;
> +	}
> +	version_raw_attr.size = len;
> +
> +	if (vsmp_init_op(&op, version_raw_attr.size, FW_READ)) {

get_version_len() does not count the NUL terminator on the end of the
string so this does not allocate enough memory.

> +		dev_err(get_dev(), "Failed to init vSMP version op\n");
> +		return -ENODEV;

Preserve the error code.

> +	}
> +
> +	ret_val = vsmp_register_sysfs_group(&version_raw_attr);
> +	if (ret_val) {
> +		dev_err(get_dev(), "Failed to init vSMP version support\n");
> +		vsmp_release_op(&op);

Better to return here.  (Avoid mixing error path and success path).

> +	}
> +
> +	return ret_val;

return 0;

> +}
> +
> +/*
> + * Deregister the version sysfs entry
> + */
> +void sysfs_deregister_version_cb(void)
> +{
> +	vsmp_deregister_sysfs_group(&version_raw_attr);
> +	vsmp_release_op(&op);
> +}
> diff --git a/drivers/virt/vsmp/version/version.h b/drivers/virt/vsmp/version/version.h
> new file mode 100644
> index 000000000000..c4430b3065e4
> --- /dev/null
> +++ b/drivers/virt/vsmp/version/version.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * vSMP driver version module header
> + * (C) Copyright 2022 SAP SE
> + */
> +
> +#ifndef VSMP_VERSION_COMMON_H
> +#define VSMP_VERSION_COMMON_H
> +
> +int sysfs_register_version_cb(void);
> +void sysfs_deregister_version_cb(void);
> +
> +#endif /* VSMP_VERSION_COMMON_H */
> diff --git a/drivers/virt/vsmp/vsmp_main.c b/drivers/virt/vsmp/vsmp_main.c
> new file mode 100644
> index 000000000000..95704bc7a32f
> --- /dev/null
> +++ b/drivers/virt/vsmp/vsmp_main.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * vSMP driver main
> + * (C) Copyright 2022 SAP SE
> + */
> +
> +#include <linux/module.h>
> +
> +#include "api/api.h"
> +#include "version/version.h"
> +
> +/* modules info */
> +#define DEVICE_NAME "vSMP"
> +#define DRIVER_LICENSE "GPL v2"
> +#define DRIVER_AUTHOR "Eial Czerwacki <eial.czerwacki@sap.com>"
> +#define DRIVER_DESC "vSMP hypervisor driver"
> +#define DRIVER_VERSION "0.1"
> +
> +#define PCI_DEVICE_ID_SAP_FLX_VSMP_CTL 0x1011
> +
> +MODULE_LICENSE(DRIVER_LICENSE);
> +MODULE_AUTHOR(DRIVER_AUTHOR);
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_VERSION(DRIVER_VERSION);
> +
> +/* Sysfs handlers */
> +#define create_entry(_label_) \
> +	{ \
> +		.reg_cb = sysfs_register_ ## _label_ ## _cb, \
> +		.dereg_cb = sysfs_deregister_ ## _label_ ## _cb, \
> +	}
> +
> +static struct sysfs_entry_cbs cbs_arr[] = {
> +	create_entry(version),
> +};
> +
> +static const struct pci_device_id vsmp_pci_table[] = {
> +	{ PCI_VDEVICE(SCALEMP, PCI_DEVICE_ID_SAP_FLX_VSMP_CTL), 0, },
> +	{ 0, },			/* terminate list */
> +};
> +
> +/*
> + * Init all submodules's sysfs entries
> + */
> +static int add_sysfs_entries(void)
> +{
> +	int ret_val = 0, i;
> +
> +	for (i = 0; (i < ARRAY_SIZE(cbs_arr) && !ret_val); i++) {
> +		ret_val = cbs_arr[i].reg_cb();
> +		if (ret_val) {
> +			dev_err(get_dev(), "Failed to init sysfs entry %d (%d).\n",
> +				i, ret_val);

Clean up on error.

> +		}
> +	}
> +
> +	return ret_val;
> +}

static int add_sysfs_entries(void)
{
	int ret_val, i;

	for (i = 0; (i < ARRAY_SIZE(cbs_arr) && !ret_val); i++) {
		ret_val = cbs_arr[i].reg_cb();
		if (ret_val) {
			dev_err(get_dev(), "Failed to init sysfs entry %d (%d).\n",
				i, ret_val);
			goto cleanup;
		}
	}

	return 0;

cleanup:
	while (--i >= 0)
		cbs_arr[i].dereg_cb()
	return ret_val;
}

> +
> +/*
> + * Remove all submodules's sysfs entries
> + */
> +static void remove_sysfs_entries(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(cbs_arr); i++)
> +		cbs_arr[i].dereg_cb();
> +}
> +
> +static int vsmp_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
> +{
> +	int ret_val;
> +
> +	ret_val = open_cfg_addr(pci);
> +	if (ret_val) {
> +		dev_err(get_dev(), "Failed to open cfg addr\n");
> +		return ret_val;
> +	}
> +
> +	if (init_sysfs()) {
> +		dev_err(get_dev(), "Failed to create sysfs folder\n");
> +		return -ENODEV;

Add cleanup.  Preserve the error code.

> +	}
> +
> +	if (add_sysfs_entries()) {
> +		dev_err(get_dev(), "Failed to create sysfs entries\n");
> +		return -ENODEV;

Don't leak.  Preserve the error code.

regards,
dan carpenter

> +	}
> +
> +	dev_info(get_dev(), "%s up and running\n", DRIVER_DESC);
> +
> +	return 0;
> +}
> +
> +static void vsmp_pci_remove(struct pci_dev *pci)
> +{
> +	remove_sysfs_entries();
> +	cleanup();
> +}
> +
> +static struct pci_driver vsmp_pci_driver = {
> +	.name		= DEVICE_NAME,
> +	.id_table	= vsmp_pci_table,
> +	.probe		= vsmp_pci_probe,
> +	.remove	= vsmp_pci_remove,
> +};
> +
> +module_pci_driver(vsmp_pci_driver);

