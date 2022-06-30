Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D942C562188
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 19:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbiF3Rwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 13:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236440AbiF3Rwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:52:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310D329802
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 10:52:34 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UHOrFe009107;
        Thu, 30 Jun 2022 17:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=uXAYBi8tDqcYRCFN3ztMYXGjtjjyzf6LzKv4WeHqwFs=;
 b=r3y5Uo4jk/42JGPU/XA9pyivmiaC711++Pd32sjbe5WWw0Rz5CiqlQYBuuGx+VcSTfEq
 urpH4SXH00QBUIUjbpsplYF4/mlAQRvhK/b9niKfQUuJga6xBdLWWdV9R7EdN3AhB2hQ
 FHZh5h7KZe7WtP8i1I3Gd8iiZN06W0sFzovVC+ANtUcypFMWYF6MdcDU5KpJNBCx3Hf1
 VZiNdGNjxTtFe+XqF8iCifkKszzY8SE193yMcIB26gnZfWETyfn12x8YzwtbrbBDm5Xu
 8Qapyh2YvZXJfPO4fcZiQKNxrAU01kcCkjDkEkG+JYzPFOaQFrLs2U4q+A0OMaKfEHno Pw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52n41f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 17:52:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25UHef6O040212;
        Thu, 30 Jun 2022 17:52:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt48vfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 17:52:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6WOiBcPP0sST/5bgom1eZz876kz5Nq6SIXj3YV62xmm1c1dWTiS4on7LYR4Do9gsPKG7byOkz8hua64pFYa+sXFPTt2q5rzaWCTA5982XHa35aB7H+IZy33uxCOLtO6+N0hLX0TGoVQe/xpZMoW+ZoE5QLGiV7TMLRjWWwnHdNE+kOe+yJzoQUH1CbyYCydrs2S6LOZxRI1zMqRGokJIsgoGoaKULA5As9x/24kP2Q6Wd6ugfDu7B/jRKI3stodLbosyg6o7ge2nmcoj78MJHtFXY08e8rsmYOq0EEp8bx6UbeTsSbSYl0e6IyJ/lLi+SjCudPaCIHW9U1rrxss2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXAYBi8tDqcYRCFN3ztMYXGjtjjyzf6LzKv4WeHqwFs=;
 b=IQtD//xKLpUKqHp4EJPpUcTJrC1unzG2tMPoe2FioLITd+Ui/lXhjO3QDsWNbYO2E7eX7fa32Z6D6f6hQbkbAC8FyQ2tOWcPqKIr2W6UKuh3LohOd6k9XFZQG7euqUXHg9tNFIEMCf7GW2cQp931Qh4xsvAT3RT98bzti35RF0Ke9TtXLb/tqiDJU+eB5w0uf19Mem4Kkb0DJhK6R6JGqoQqrsovOdK/A6Rhorl4zmWFFluy13rl+v/uTyaAdcGdU0/JJROObW7WONgw1dTupBkeV+klXm0U63sK73ojCKM2/7X/Ug7jj5399ku6jpJ+ql+vGsC5LwpE3MrKsq31tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXAYBi8tDqcYRCFN3ztMYXGjtjjyzf6LzKv4WeHqwFs=;
 b=veKdBfous2dEb8FYwM2vzXlD1KrVRMYC5Wt6J9hTavzA2FVR/hrFo2Nb20Dih/1DInrnFDffSFwphqahlgKZRlbZioVCcZYsnRqr4y7UhxCWb237WYhzJbICtBeAWTGx58mD7rF9rXkvLtaOKqLu5JtayXSR8pTM7NO6xPpDb7I=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by MN2PR10MB3885.namprd10.prod.outlook.com (2603:10b6:208:1ba::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Thu, 30 Jun
 2022 17:52:18 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::20c4:5b7f:ce53:eb20]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::20c4:5b7f:ce53:eb20%9]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 17:52:18 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, linux-kernel@vger.kernel.org, hch@lst.de,
        nvdimm@lists.linux.dev
Subject: [PATCH] pmem: fix a name collision
Date:   Thu, 30 Jun 2022 11:51:55 -0600
Message-Id: <20220630175155.3144222-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: SN7P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::19) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 086a4cc3-aa54-4dcf-a25a-08da5ac14625
X-MS-TrafficTypeDiagnostic: MN2PR10MB3885:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XoeszS8uZAvw7BeBmivd3xI1QFHtD1D4SBKHZU4OP1ejAiuvItYnFgnI6xiU3u7z+3Deh1bCpFed2mATrnfAn2p/N0nE6uOXAm/W4emxOJUXLPRY4yO7nJSl5JKOl1LxdB/bRGHRb5ft09tz4GX1Zn6lATjJurq6S/HiMcFF1soBhOFHiT93WPjq/bKRbYin+P6iKz4l22i9HFbCWrqM8w8sKIqfPhYapnobekur88BRwjOtUFST8zJUlfqE7OqKyMJVx+jBiaFKGJvFn0RuV7AUB4B96W8O21/cdlLZ5DA2xHU8svBdDe4xshTBPTvFWFmsV9qGEWcTbcYWuTMCdiEfmaC4XBi+f+4+P2uj7ZgdJ8SP4aNAvB0hPIhJ+G/2PEfgbZcesWG3Pm9clnB9EvTY47RCWuOvfiB/1+ISi1v2pxWbw6L833YA7PMfVeDbbs+LClVoaGh2ZFeApcZnGzHP8mtkguwXO+QSvjUClZ3ltK8Mvt9WeYUYxUc8ZWsA6oxIZ58rQxGqI4oByK4R8xQRCTSXrbc3sx6FHLC5ydK7bGsF9w2CJFIGuWi890ocUDRxgdVj2ztYxIHU/n+Ep+B8349mJAp9EMIRZ1vKnAswKYCSokouz096EZP9g656iFcEzej0OaU9aIBvKHNvYUuuTXiwm2s4ZrGzSCB4s/85qyWgZ5mG5KEMECDxoGCqQZR/4fS2xyfwZCQtRSWfTX07b+PT7sglWPJGXVBeLC617ptY5XHYmW8CmBHLI9IAHBtX+PGv1kbsoJfQXkAijQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(39860400002)(136003)(396003)(376002)(52116002)(6666004)(38100700002)(8936002)(6506007)(66556008)(36756003)(86362001)(6512007)(66946007)(44832011)(83380400001)(186003)(2616005)(478600001)(1076003)(316002)(6486002)(8676002)(66476007)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HDU641/y6X81RUwOCBZa5FW40iM81LuCmA/WfGphYl00GaHKbprbAomPn836?=
 =?us-ascii?Q?20gAaO88Eec7GiEul/LxPuEZj2BgpUlnTp9zf8/C7oDT5Tyvm6DPPS/IXIaM?=
 =?us-ascii?Q?Lvi/S/qwvoJv7ohhLg5QHQP/81BQ9z75hFAdq8/35+pv7ABGf5yk/SAyDb9v?=
 =?us-ascii?Q?gS4uSVUBIU4yvkM3CmQYduQfSZbAVhNr63WWP6IGidMxRFH2wKbl1U6+1rsa?=
 =?us-ascii?Q?2SCCLHu5BL33X0aVEDqjEFw9E9vWcxpEHVqeCwIZQY4LD1BMlB41cc7pc6cE?=
 =?us-ascii?Q?aFWmARUn1trktJxxoUFZSMn5SsZavxlLF6jBnDvkOMg9eBSas0mb6T6zvV7U?=
 =?us-ascii?Q?/MWIjslhDmhu7EJGwlqPWSqwrO5peGAhnjl1iLTD6Qq53UpFcebBov149rvz?=
 =?us-ascii?Q?6VbfniQt5z45XUk/GxiY55PlEvTRtYJ0N0qe9BEjpUHiDAcBeFTnjNiv8q/o?=
 =?us-ascii?Q?6Fjm59/i5v4AaCsHSKRVlHjV0fuFT9ZtQ+9Hax+SeVFe5BXxh0EYJ8uL1dQj?=
 =?us-ascii?Q?bAAS+XtOaZc7xjtg7UKrWg+iS50XT6E4BSc75j562d5NHG+rhbv/H9gmibCl?=
 =?us-ascii?Q?6gHhY/gzD96tvcBsMrkrV+iAEaVEpVZHcg1z7hqvOqZuxkbJFoZzG/T/ckRH?=
 =?us-ascii?Q?h4G8azfog1zIWErDxhe1oGqoTWvdLRCRPziyQonky4dkH2eoXKgsMDICBVnA?=
 =?us-ascii?Q?LOh3QJA2T+TuCY3F5jZAdAfY5f5ovCD6TIG+iU/BXdLUZs2VpYN0E/jQUnSr?=
 =?us-ascii?Q?ZOsmBElNLUcQCUIn0xzkM2WUp7nOBRPobLBhxb6FlkxTdO2o+sMQvLmlCzrJ?=
 =?us-ascii?Q?ChBBHF8kDAnFUQgWqRhpR9gXpMGqR6b6jJ3LICBbxxi6zqu7x5fA9Vw0fljI?=
 =?us-ascii?Q?kZswF6hE3H7Z/bp0M11LTJMs2G1CmlvWzUim6mbxMDk9Ug9lTxu+kXX53Ah1?=
 =?us-ascii?Q?zGQHQwkZX6bBqsrTK5O34aMP2HWuMlQTB06dueRHdJG874vYwscWYOR/MWct?=
 =?us-ascii?Q?G4r+U8nDjmBEidbWf9fUj+lb2/SwnYLOij30Azo5ZVNllem73U0k5KtC6UOZ?=
 =?us-ascii?Q?X6AN3n1NiQwv13u5+27a82HKqbjhdk6XLwNv64HeGyR2ElmrKV0zljLgiEpj?=
 =?us-ascii?Q?OnQYDLshrKRfqW9wfA/eGHhWyo3jM2b4yAizPd3w3N82LGSr0pGBvztnplzT?=
 =?us-ascii?Q?bbfDo+t5azA8LTAsi8tmd6mwlNvOoAlc37HF6wDcNZWL00uTPTmLbN6RMpeN?=
 =?us-ascii?Q?vKdmrDSwh/ttaADkdoN4UGF/MfcPAQDjKALigEWMAymIj0UYrPj9MwIqFz1X?=
 =?us-ascii?Q?SenlL7CdH/eg1W13uhBiXaJtR2eU3qIv79ZwJll91iic+ad8OfhC4nHlgqRF?=
 =?us-ascii?Q?Diicc1P6TLa2Y4YlulASKig18ozInqiE8GfYnPoREbtHZMvwPiUiXbtkt1HJ?=
 =?us-ascii?Q?EGiBnYwcUKCWdTAWeWA7BBi/6bqYUXInpCt/LoLF63WCr2NaRgwOAieOc3F0?=
 =?us-ascii?Q?H96A72EkvCDIImppewNoGPjlUK2TG4MG31bPIDI6e4P/psy8TzQ7RNZO8unS?=
 =?us-ascii?Q?I14kZNYfWo4yA/6oGrGPfOuOl9CNHog7FWz70bJ7qx/HaglTOh/VYbzS8ed/?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086a4cc3-aa54-4dcf-a25a-08da5ac14625
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 17:52:17.9968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSLuTAR0fDjTI1fnkc8M1bipj40gXFgY/EQ4yM1S1iedei7vUmgO5B+q2Yaqm1UbGMawYQ8IgYKLcHyrbgViiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3885
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-30_12:2022-06-28,2022-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206300070
X-Proofpoint-ORIG-GUID: mfm2e0aqI3yOdrOVm4bYl-Uhz6lrTJcy
X-Proofpoint-GUID: mfm2e0aqI3yOdrOVm4bYl-Uhz6lrTJcy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot detected name collision when compiled on 'um'
architecture.  Rename "to_phys()"  to "_to_phys()".

>> drivers/nvdimm/pmem.c:48:20: error: conflicting types for 'to_phys'; have 'phys_addr_t(struct pmem_device *, phys_addr_t)' {aka 'long long unsigned int(struct pmem_device *, long long unsigned int)'}
      48 | static phys_addr_t to_phys(struct pmem_device *pmem, phys_addr_t offset)
         |                    ^~~~~~~
   In file included from arch/um/include/asm/page.h:98,
                    from arch/um/include/asm/thread_info.h:15,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/um/include/generated/asm/preempt.h:1,

   arch/um/include/shared/mem.h:12:29: note: previous definition of 'to_phys' with type 'long unsigned int(void *)'
      12 | static inline unsigned long to_phys(void *virt)
         |                             ^~~~~~~

vim +48 drivers/nvdimm/pmem.c
    47
  > 48	static phys_addr_t to_phys(struct pmem_device *pmem, phys_addr_t offset)
    49	{
    50		return pmem->phys_addr + offset;
    51	}
    52

Fixes: 9409c9b6709e (pmem: refactor pmem_clear_poison())
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/nvdimm/pmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 629d10fcf53b..26c81ed7c0fe 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -45,7 +45,7 @@ static struct nd_region *to_region(struct pmem_device *pmem)
 	return to_nd_region(to_dev(pmem)->parent);
 }
 
-static phys_addr_t to_phys(struct pmem_device *pmem, phys_addr_t offset)
+static phys_addr_t _to_phys(struct pmem_device *pmem, phys_addr_t offset)
 {
 	return pmem->phys_addr + offset;
 }
@@ -63,7 +63,7 @@ static phys_addr_t to_offset(struct pmem_device *pmem, sector_t sector)
 static void pmem_mkpage_present(struct pmem_device *pmem, phys_addr_t offset,
 		unsigned int len)
 {
-	phys_addr_t phys = to_phys(pmem, offset);
+	phys_addr_t phys = _to_phys(pmem, offset);
 	unsigned long pfn_start, pfn_end, pfn;
 
 	/* only pmem in the linear map supports HWPoison */
@@ -97,7 +97,7 @@ static void pmem_clear_bb(struct pmem_device *pmem, sector_t sector, long blks)
 static long __pmem_clear_poison(struct pmem_device *pmem,
 		phys_addr_t offset, unsigned int len)
 {
-	phys_addr_t phys = to_phys(pmem, offset);
+	phys_addr_t phys = _to_phys(pmem, offset);
 	long cleared = nvdimm_clear_poison(to_dev(pmem), phys, len);
 
 	if (cleared > 0) {
-- 
2.18.4

