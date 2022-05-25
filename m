Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538E0533C8E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239640AbiEYMZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbiEYMZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:25:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE916D3AC;
        Wed, 25 May 2022 05:25:32 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PCEOHg025732;
        Wed, 25 May 2022 12:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=FuqPJDXfkWN7EqHirK/xv2KwI3gp2Vg1KcLyr6usmts=;
 b=L72UCdSH3p1d+MbHbSM+ijA2ErKZjvtqY8/nQBAo7UY8hhxRz/pIVj/YFjXMlegSWYj3
 9xerevt1RsArQ/vj7ybjyTmatlkMDyK6KzCJDdnkMWn3cmbg7YbssqJYAOwWT+BUEkVr
 R7CfEwGDYnfpXyrwW2xwhI5ARJoh0UBDaBaohwuLrAwTXSshfeF+5HwjDEvr/ElnYJ+O
 8DdNuryNyfC4Bwe3Vm/n3x9tRkYonk5NQa8JY1Zy/rHBE8m+nETGsvDoGYV+wv5P+pR5
 lKdzjikvJdTvVmRpg3Twu0TncjxMTRW42h6VwfAnwwrIB1GxAqjBO0F7EBXVZnG+Ii2w 2g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tdsy9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 12:25:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24PCANMl002299;
        Wed, 25 May 2022 12:25:20 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g93x0fmg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 12:25:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOOyyuFNpeRZBXZYrBwsNBcVOS4XfwOHB7C/rYTg9O3HlatSNB3+9LtOcEsyFKBUKEoIRXvXlbSvfDRxqk/cIkmJ8+so7WxWAVSBfhX8r2yBznGBuBWoMCrDE0E7L3uQUimC32/bgMRw/eszi3ilMY88XB5xhFrVKAhQgiMfrclC2u/KRH1YsXTOu9UYuFrfBW9tXKkQn+6fknfJhrW8bNNEjipwzcEE9prKdFARQDIedHk+sNnV5CAKOEWNdk1Ln2iLJR7pDtzZH6AiDLh//NVj3u6Q1J5Xj02D43Rq9MSMHHzQMpjzNji4lq9vDBcrap7Q169YTzG/0nsUptdxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuqPJDXfkWN7EqHirK/xv2KwI3gp2Vg1KcLyr6usmts=;
 b=PEULliHFDsSARDEUwR8GxYtixkP2w4fhbXtxmLMX/c73AG/mzKDshD6E5DDLD7D92/ceSZzIVcqer5BL6Iy8PZt6MI4XcJa3PUzg2U4zAYff8EQzdkVO1wApzXwWLMTXnqGQDOiQNR8nkmwoQIj1H1au1Kgcs+yOBT76l2AuDPiLEoIfhJYZwFlOyQDiRs5rAjobodIF6qUE4g4oGezvd4FxLLVNBbrzGHNcxGJGUM5+g/INTdmFaAwpJlgzndV2wHufPfJGfV3mU8KAHdPjt2fjVuO80zwmDoFcGeSwpygPnxyzBe43qdKLdq4KdeNYen098uopjC0FpOFoX7Sz4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuqPJDXfkWN7EqHirK/xv2KwI3gp2Vg1KcLyr6usmts=;
 b=fZqohYakGFNpH4AgayUrX2uUnaxc2XVyqbX8AOOb+r8bB+sY3pJlL9A7WeJuymm+Kbvm1mOuqHyzpRlQVVyv2B1iyfOZMdk+6bdm45OleCUM1Tg3VFAvyapnmvy1GUHdqP1GmzrC0iiLZ/y18eokgUINX4mvLdCwwsmeli56rgE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1392.namprd10.prod.outlook.com
 (2603:10b6:300:22::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Wed, 25 May
 2022 12:25:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5273.023; Wed, 25 May 2022
 12:25:18 +0000
Date:   Wed, 25 May 2022 15:25:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Oded Gabbay <ogabbay@kernel.org>, Ohad Sharabi <osharabi@habana.ai>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yuri Nudelman <ynudelman@habana.ai>,
        Ofir Bitton <obitton@habana.ai>,
        farah kassabri <fkassabri@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] habanalabs: fix double unlock on error in map_device_va()
Message-ID: <Yo4gIobpIlRmxqtH@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0191.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::10) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27bb0ac8-1d0f-4593-e2cc-08da3e49a0d3
X-MS-TrafficTypeDiagnostic: MWHPR10MB1392:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1392B142BCD73665AD3FC5CA8ED69@MWHPR10MB1392.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T/h/WjfNrz0cjnsSN4cNOtO0A7bu+HkQV94Qd3jYuYOA751ft7bhSeYJpGOpZ8lsYUET8U4iwzCD1UDr+YjVOXSzv743LdudYi9G9uqxtGZNoPDN1R04e0F+ZKFLx6qOOvxtz6CONLpqYwFusEQz7TcyGNzuf0rCGjGRlojv0yEvsBbY9dAPop8eR2cY1nDgeu5G7nWpDrTvZsFMhUYtzWTzC1cxA/7vv004LCtO50ijVFMeXuuiX1wjGfIe9pG4OlW1OoyEAT0fZmt7+B3/CATb1xPX5G3hCOlEo21wFaREEH0TCY4KuFHvO6WZ7qqjTQJJv8aqPBCkCnC1BQ3SNyPaXgjcw07wiaRFx6bT938olwUPgG8JxeC9oO/mAv2i0rhJRXTzGQSNybIL2UZiNETERomC+aYnn/T0+ir4Akkjq1COd/g4yfdkqyCLGjOJm2gTg5HUhjL8LQ6HYysXcgQ+xBdTFXm+k+goOqn6XkQP7qSHXolKFfKFWi6+DEPVJKPi7KONAeEX/OZ8vbtTHF+4XL3YOaaLNnm6ms8sMr5xJVDl3XEqoPTSujWspjFxiM/zK+MMANMyydEpY12HSmJ45helEhUJTOalvqiuflDF7WsNX7f9cjJOF6A4xXBzNHs4MHSj3Hq3XjROUSExaAlWw6zHZNNPePOx3seJonL26cltUXkD5A/gh4z/P9ie3jBjbiFkpYGMlevO6j3RIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(52116002)(5660300002)(4326008)(8676002)(66476007)(66556008)(66946007)(508600001)(6486002)(26005)(2906002)(44832011)(83380400001)(8936002)(6512007)(6506007)(6666004)(9686003)(186003)(86362001)(316002)(7416002)(33716001)(38350700002)(54906003)(110136005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WOTeXGASr0IA58sGpFfe81lVJbHuGSIywJTKKAM9r0O24h27mQhM5OGUUxLE?=
 =?us-ascii?Q?O1zc0CIElKAzi/dnMnrxuKwcef5fe71eDESh3p9v10ez0lIHU4k0fTMNHLWc?=
 =?us-ascii?Q?0xK86H3ZivWzkUMFa1s+3SFIscWEB8GzLVqHF9NZ7KWoa0WwXMv7zEKyX1l6?=
 =?us-ascii?Q?9zryyaYChRQc+OGQkjPvYkT0oEy4KVensYGdRtQ5fnZOtMYfi0u8zoh/xFFc?=
 =?us-ascii?Q?Mr4pq8hamRcKlGcazuZBiw7JycbZf4do3tAwHMZ89G7VGIiL5ilwi1NQY9we?=
 =?us-ascii?Q?IjSRzURim1ghQw5RjdDhgFZergdRcQp8+FEqYBoP/TtJQfUoGn8oTWpSUEZs?=
 =?us-ascii?Q?8sC00CVH6psu68VDtG4leCjBy2T+nHPy6UDZEon53xZ9c7Fh8Rvdsn93zIDB?=
 =?us-ascii?Q?2gR5bc6sCulVX3lX65X1fBlfRHbhywvfGa6K7nqg9fBh5CMX6rbywUenK5rn?=
 =?us-ascii?Q?EfKCHQ9E3mI0m6MKRoCqmc5fIG+9mLhgO9G9VSAigqtNHiJGmIgePke0v1sO?=
 =?us-ascii?Q?tbHTXEvANql5S07QT1iVWZncigwoRGYBRH0tk9HCPBZI8RDzvS7fDyzey6g1?=
 =?us-ascii?Q?0V+WEl2sz4KhT/heemqvPkdAiS7QFi5JUcRhBlVWBWzSV1tUKnTskAG68LyL?=
 =?us-ascii?Q?J6X2vkrPoK5Qk/RM0yEK8RCMgXliGc23nQknyzcwivBWwb4AWUNC6/0fCy1o?=
 =?us-ascii?Q?LtJXDRkoe1WYZrdSmUoZs5i2eGJmSidDOl1IvAiL5qnwknZzAbN8wUQZlAo9?=
 =?us-ascii?Q?GO7QEd5JqH9HPpdyVE9RF5OAE1qdt0Het+sGBZ+tgepvD73DouWSISEYqhFB?=
 =?us-ascii?Q?daaFBHwHI5yX1cU0sJOZGlZR+mGpCiCjdUSQ5eizAOUEMQKTtoe07GEzcbVl?=
 =?us-ascii?Q?802hT5UHlikyMruuUGKrgXukVCn5W4WdlWljqCZImVMhq+FoAiESquvtdQPb?=
 =?us-ascii?Q?7EBNAumAwEqeT8qxp6363LeV19R1m2fV4uA462uRXZvffZUri2qRj1pJru4h?=
 =?us-ascii?Q?4BJcssBrdMNjDvggte6DY+2qpXAKmJr1eqYeyay0638avhUcL11oOdw5Nraz?=
 =?us-ascii?Q?MjvcPSreF5GWu+UNh2Jn0D6H4HFBpjUOy9FWYIUuE442W1n7eBUhp7cknvHz?=
 =?us-ascii?Q?S+6407d+NPJNKIUsd5JmuaDUZkH8MW+bI6AIhKizGq+FbwCF87EWoJ++B5AI?=
 =?us-ascii?Q?bb2BeGutmMZfdkciwF3/aYXfgSBwCD+QZbXddCitpytQPad8Q2luqZ+iPnM2?=
 =?us-ascii?Q?LRvOyrdMQLVuxnq78a6JZJohBkZuxRAZdpwWFQOuRKsdeA3oV3db8fzdkslL?=
 =?us-ascii?Q?zqCZv7B7Ju0pC4qDajL1+fHWkmAclqHohJDM/vTNr/sqv+aQq6Mio5e0GIEx?=
 =?us-ascii?Q?O7Vz8x5LLnhNtg5Cu3UWuAa6JQz7O/MH0kswGnrvXjYwtvwmRYhPtxdBvvxD?=
 =?us-ascii?Q?1NlIoc1qOBiEDEs2NflR5hWSDTXCAArlcINIOuC80hv2PH9LAo98VgzFM8Aw?=
 =?us-ascii?Q?V5GnUxruNjvnE5nrI2lTdI5wu7xr5JFPkGrtAEtLCHdAjyynx14JM2mNSq1H?=
 =?us-ascii?Q?E2iukpPG3xs7hLlYe72XPnh24MIDWKNz2/ucZydwVzt3RnR8QYUxjkxzu8Iz?=
 =?us-ascii?Q?HoFyUnDKNZsMGmnHbBRdCCdrnIkRQ2oNPa64yczIm66lRbXk36yJgD0D1BCL?=
 =?us-ascii?Q?ooLJ93DpMmIiKj74cmohnVbtyxKU8DA1z80gi0L2aDU0zfQDJSBxy3zvoABe?=
 =?us-ascii?Q?ROv0Ai2pTCMKNnGY4R1G8iFeeTjQ+/I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bb0ac8-1d0f-4593-e2cc-08da3e49a0d3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 12:25:18.2027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnXpa23ZrG+lFHhr2NOZjyfXu8A2laqdAB82ju6q/kVoCSZxLyQ8FK4Jlq5VDxFfj6P74P0KPm0PCLJRw1fsv3RYQm0iN0D9yYEjF7qSllY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1392
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-25_03:2022-05-25,2022-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205250062
X-Proofpoint-GUID: VR8J1tcnnnZ9tHeYoYwf8TeC3XvcG_9o
X-Proofpoint-ORIG-GUID: VR8J1tcnnnZ9tHeYoYwf8TeC3XvcG_9o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If hl_mmu_prefetch_cache_range() fails then this code calls
mutex_unlock(&ctx->mmu_lock) when it's no longer holding the mutex.

Fixes: 9e495e24003e ("habanalabs: do MMU prefetch as deferred work")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/misc/habanalabs/common/memory.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 663dd7e589d4..d5e6500f8a1f 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1245,16 +1245,16 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args, u64 *device
 	rc = map_phys_pg_pack(ctx, ret_vaddr, phys_pg_pack);
 	if (rc) {
 		dev_err(hdev->dev, "mapping page pack failed for handle %u\n", handle);
+		mutex_unlock(&ctx->mmu_lock);
 		goto map_err;
 	}
 
 	rc = hl_mmu_invalidate_cache_range(hdev, false, *vm_type | MMU_OP_SKIP_LOW_CACHE_INV,
 				ctx->asid, ret_vaddr, phys_pg_pack->total_size);
+	mutex_unlock(&ctx->mmu_lock);
 	if (rc)
 		goto map_err;
 
-	mutex_unlock(&ctx->mmu_lock);
-
 	/*
 	 * prefetch is done upon user's request. it is performed in WQ as and so can
 	 * be outside the MMU lock. the operation itself is already protected by the mmu lock
@@ -1283,8 +1283,6 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args, u64 *device
 	return rc;
 
 map_err:
-	mutex_unlock(&ctx->mmu_lock);
-
 	if (add_va_block(hdev, va_range, ret_vaddr,
 				ret_vaddr + phys_pg_pack->total_size - 1))
 		dev_warn(hdev->dev,
-- 
2.35.1

