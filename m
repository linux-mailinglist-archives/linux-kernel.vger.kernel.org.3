Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D076570E43
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 01:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiGKX1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 19:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiGKX1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 19:27:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BED8876C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 16:27:42 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BMYitI001799;
        Mon, 11 Jul 2022 23:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=IMrxXoPE2WQGBqD/bgCcTizgk6cokrNpuHyDHng0n1g=;
 b=P/adS2XvgEXtUcdt36w3KzgN04do1yoOMFn7HNetZU5umSkmkFafMBZp6B3o3DKrPrgC
 UL2Gn14thPXAiER+X7i9rFYb1n1V7POyMM5lrlbuLe30z2zL33R9bOAN2APdCJ8Nt8uF
 M5YDumjwMHA+iazQ0HKnTZLKlCxK53HrsKUqms6Ys7O/qzoDH9lz8LTgYmA/R5BIx74U
 SvACLG+0PM91AJSmmMHFCsdcsg+uGRXEPz9G1JTJ6Q1GTKNpRHDfJy1Kr2kuW/0hdBmc
 EEUMEPgSSZYTby/XAr7xFvGxnUBv1WyMG/h5Pmtrm0cMq/vI1ZxrjQWFoo2GKV3SqPC+ fg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrcye9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 23:27:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26BNL2jx026150;
        Mon, 11 Jul 2022 23:27:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7042mpqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 23:27:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmvvcGLM2vm7RkC47q9JldBV6oq3QWp4cAwwQAdlIz1hwv1LO/YiUSVYajWdSF3zMlwIDoAhs4QMlRIv8cik2O1UnI1IiHMlVvlyfqolvUQW/AO1BBUZkM9stM3w+yTAoah/GsyilP8LHKlv438nB0Q0cvjNe/doZKbGGDkjC/Ri4xUKqYXawOyhfTzfBWZfsvHkE4wI+e4oaQvT6UBcW/uGdKlGTVJI6Sp1RGNYcHbWRiHWYaEIynWpuw3CqsAcCp8xzERE9hIyWSkQOw5u/Qwo+8i3SdeDBLol8vzEkKw/W7GFHa9svZa2hfAPTv0UEoTG6o49lvNKokZ3xj/94g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMrxXoPE2WQGBqD/bgCcTizgk6cokrNpuHyDHng0n1g=;
 b=aEcOi8xGtYvCQhNVk1RKLHH2CdlhanIFF6uP2ixwsvPrS1JoBqXQR6Q+7D38KFDVc6teow9ivU0TAZKkQ51bCYzIIqc6Mv6AnQXp4urDd2ktiHz++NB3JWPqjLbvTIPOFw82QfIrXP1Br1trPcc7SpxwoEvqYRHcFQNwudiaDUYwfrCYE3JLavegTY8JCGYsNsmVhfBYC/wGHe+GYUjzzrbA2c9S0D/Oky8N1hRmbcGA8XhTlXfsrcFgMrZ70iTa8wSbcXHISX9CCZ3lrnMGgK3JRq51+pDYd4F3LGeOUoFSAyGIKfHOhDlK6NTNfgy5hcvXR/CehhiL1xe7v96zXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMrxXoPE2WQGBqD/bgCcTizgk6cokrNpuHyDHng0n1g=;
 b=DOrNK5MOHbDVSOVti1MCIq4qHK56Tch0n3LIuC+Uz7Z1CMIeQi2QxgCjEz0KTe+Yx8RV+TluGBCirOlzZhGV68vQUp1MRPc84KL87ETtWwPVTtsHSekiuisx2dE344FPquSTULcy45oOcccgcYrQNtVknT1y3DMSyG5Hwr4BmvU=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by PH0PR10MB5819.namprd10.prod.outlook.com (2603:10b6:510:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 23:27:25 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2ce3:447b:f3ee:bf1e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2ce3:447b:f3ee:bf1e%4]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 23:27:25 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, hch@infradead.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] acpi/nfit: badrange report spill over to clean range
Date:   Mon, 11 Jul 2022 17:26:58 -0600
Message-Id: <20220711232658.536064-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0053.prod.exchangelabs.com
 (2603:10b6:208:25::30) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 194abd2d-cbe7-42d0-c9eb-08da6394e9ed
X-MS-TrafficTypeDiagnostic: PH0PR10MB5819:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LW3dn/eGibDvyAEPVDFmFQOy3Wwivb3E0QEw3UxHfq4MkzFgtdDwu4KkohC5g4b5/qRn8CpV1W3r9kuCjAkERCHCLAZUt8wCfehPYIUp5APVxbhZjro0/x1XkoZRdfq647wy4RBM9ODO+BIGA1R8SSfsMbbYnOS7X9zN7RfX6h9XWVzr4jzZhHAnLa+OpLIWoFv72wP5g9hoh7flyqVpOou1Jar2oJvqTYifljJHRYZ8v27PCSpfi4dCP2oGXgI8sllKn0eRNqk9VdMEokU5glpgFx+ZRO0SabltCeXIK++JU3MvaTcj6DRJQ2OCHipDc2/WnWNa2FkAt7/irvAQ0E2H+2nmgrkREo4XJ64fVej/CLmh2/vUt0MY4ojEZtXUQkhcNqIqDSeGiY7dTEBe9GxYCZH7hyt77bNEUMJ809pf02ZApO7UaD1PMgHgMLE7cDeZnApb32p8lJ9Aqx4LxCIlSKDpu7gKn7VJjVei5p2LZ80/JLrUPNPtXNAU77nvcvMqtSUlLvhdfP88rGBUMQKEFgXs8wKL77s+hWhZFpg9nsdc5LBSlJBd05p+qya3L7FkF+0D/1ec5UQi0Tnce/WjZNxsIkBW7yh72prisJoERA4JPUb0nM4O5d6mD47sJNtKO+1cBh9y3w/c3HhJcXuBkMI+80LtPfZnBeo8l+pwZD6mDenqPC5B/OOpfT3HFG83tc+3cj2d+gw5tKntLDXqgSJaQtKHamygE3YeqGlig0dA+AxD16rgVYjOZVrruvcpOlV5rQ0x5O+P5XzehOOuNFwlp11GtAy9rZ/6IKQyqp19p2OPGF5RgQjjckwY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(346002)(396003)(376002)(366004)(38100700002)(1076003)(52116002)(41300700001)(6512007)(6666004)(6506007)(44832011)(36756003)(5660300002)(8936002)(2906002)(478600001)(8676002)(66476007)(66946007)(6486002)(83380400001)(2616005)(186003)(66556008)(86362001)(316002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lS4m8Sd3WYED6qxVFvs0Jcz8yXo5847XWErptuqpdHkGMpBc5B9LsBC0PO6n?=
 =?us-ascii?Q?Ou0dBrQSStMR0koDJdxAofnJptfkAX4hPdRsXGvWpM20aELRpqgYzW1eUlRR?=
 =?us-ascii?Q?SWbvbz1920iNydIo+Gkk/IMw4pw0etmSJ2cpYhPAl0FvUMRlkUWZhWi+CgJx?=
 =?us-ascii?Q?GbaVGVevGOpVdPqC/0Waa4CURQF0vEyt0G3y3oPpJFkztZuzUCvXnHn2Kl5h?=
 =?us-ascii?Q?gpjO1TJ7IFQbf5dz912BTcYBqIS6yxdl/8GitnL0Sb0AEY5i41RhLvpVLl3D?=
 =?us-ascii?Q?Xi8wYFkZlRgDIRzLLr0cfCAwDfQf/Yrwx0xmhnMDGP/TYoANub9cIFVODNac?=
 =?us-ascii?Q?9z91tgg5POn/g0wvQkMdskrABfIyeMjTPiygXnIhyZXUyvJpGOv5SHsRvmRO?=
 =?us-ascii?Q?O/3RqoFw/8/NiN7cEypF+ZtA0Dxglc7yMOT1L/hvvNV7VQYLEz9FaiPjpFYV?=
 =?us-ascii?Q?o0+X2bnVRjgr1iSMisKSTISs6PLO/XRA8+KC+ZsizczIhuDrv3Et0KYljFBe?=
 =?us-ascii?Q?hU0m087vZMG3WRLqcOrkIh4Oeoud+LZtedZ/s+IHM4ezIhqWyyqVpM4f0f1m?=
 =?us-ascii?Q?yqudNduNlQKloh2skHwaJSBm7QZFjzsnqA2AbTpRydBNdaOOk/ZkTT9/OPID?=
 =?us-ascii?Q?wTWFAbhBSmjCM+BzAqx0qcdAgP3ugTFyFoXNVPP9maT6u6s7wXlSDujQgZcU?=
 =?us-ascii?Q?W+jjrIIEeiKu7iq+9zIrfG5N3j87Zr4/gobU3GzY1SoKVPi7MqW1Ea1KiYe9?=
 =?us-ascii?Q?KNtaJi5q56RALEilWCB+vXppHPBZtd4sJB+TBCh6b+k6SVILiOItwjkcq6N6?=
 =?us-ascii?Q?xsBFhGqlmyTRVBQec9JrymXZWzswxU49vO26zup756L7cfThSZNczkackIOB?=
 =?us-ascii?Q?1DrotRFFp6vMb8H0iFnYBbk3ISpm++Ap/ODjcVx/a/8ezGfabm9sRsz2iaOm?=
 =?us-ascii?Q?aDF6xDE+3a620WTXwOJcGQICyWG05xItIfbj/xq4eQPEBR5N430ll/Jmsei6?=
 =?us-ascii?Q?khUhefuIO/onES3gpVD+1V1RHzGD92aTzrd+g79qS/hZ5xIzSsRYvEuOv1lQ?=
 =?us-ascii?Q?mEZe/YoIzEpflIFYeHO4YoAXF4nwuIvtE7Z0/5SBn8llW6FWd799rNrXzjt6?=
 =?us-ascii?Q?PVA9B6xdYSLBa8O1Ktq8sQmYz91lbg6jZaHi0eHs8NZAGlnaHMYh56upL5V6?=
 =?us-ascii?Q?BH0YG6VygDi31KazaOijUR07AfU93KRmaKDEA3zvPfNwflykiem/yBVBNZw1?=
 =?us-ascii?Q?uTnD3N4U5EYLrNs+dNx+tbM1oa0ux9l6Dry3lq/JJMnRzs2gQIqXboHQJnp/?=
 =?us-ascii?Q?+oChpImGWT5WzOT71Tw1WeZ/YNFvkRyxnaWRIBmlCNCzrRqePE3oRx/2SZt4?=
 =?us-ascii?Q?OyZHQsjraleZOrIa1WhBHgT5iSYAXnnvwbRmqJBrLEa+2y/7xtAJw8SGer0w?=
 =?us-ascii?Q?PTyPFv4ToCXiAGO+F1iV0CFONAN7QeRSJgvU514fAE2gMW0d2YRh5BJn7o5h?=
 =?us-ascii?Q?HBv2+/UHaw1ZBAAtElf7idntczOD63vAu7zZFHPbqp5fOPWFzIBOgW2q/jdb?=
 =?us-ascii?Q?mac3PKzM9wjlHMtDdzMHOLmZzeNKRaSQACchdveOqDMAxQASjQzFy7I6z91r?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194abd2d-cbe7-42d0-c9eb-08da6394e9ed
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 23:27:25.8424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HflaB7oLyEFHwtUqjWLrMaBpsZdho7SbQGsdwoOybySWC7SGLUSV9kqHaLdOv2kef0NX4VO6YM3CZFRSCG1uOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5819
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-11_25:2022-07-08,2022-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207110095
X-Proofpoint-GUID: D0zxFR2QtP6rZ653WSG5IVSQ-FO-6YJw
X-Proofpoint-ORIG-GUID: D0zxFR2QtP6rZ653WSG5IVSQ-FO-6YJw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7917f9cdb503 ("acpi/nfit: rely on mce->misc to determine poison
granularity") changed nfit_handle_mce() callback to report badrange for
each poison at an alignment indicated by 1ULL << MCI_MISC_ADDR_LSB(mce->misc)
instead of the hardcoded L1_CACHE_BYTES. However recently on a server
populated with Intel DCPMEM v2 dimms, it appears that
1UL << MCI_MISC_ADDR_LSB(mce->misc) turns out is 4KiB, or 8 512-byte blocks.
Consequently, injecting 2 back-to-back poisons via ndctl, and it reports
8 poisons.

[29076.590281] {3}[Hardware Error]:   physical_address: 0x00000040a0602400
[..]
[29076.619447] Memory failure: 0x40a0602: recovery action for dax page: Recovered
[29076.627519] mce: [Hardware Error]: Machine check events logged
[29076.634033] nfit ACPI0012:00: addr in SPA 1 (0x4080000000, 0x1f80000000)
[29076.648805] nd_bus ndbus0: XXX nvdimm_bus_add_badrange: (0x40a0602000, 0x1000)
[..]
[29078.634817] {4}[Hardware Error]:   physical_address: 0x00000040a0602600
[..]
[29079.595327] nfit ACPI0012:00: addr in SPA 1 (0x4080000000, 0x1f80000000)
[29079.610106] nd_bus ndbus0: XXX nvdimm_bus_add_badrange: (0x40a0602000, 0x1000)
[..]
{
  "dev":"namespace0.0",
  "mode":"fsdax",
  "map":"dev",
  "size":33820770304,
  "uuid":"a1b0f07f-747f-40a8-bcd4-de1560a1ef75",
  "sector_size":512,
  "align":2097152,
  "blockdev":"pmem0",
  "badblock_count":8,
  "badblocks":[
    {
      "offset":8208,
      "length":8,
      "dimms":[
        "nmem0"
      ]
    }
  ]
}

So, 1UL << MCI_MISC_ADDR_LSB(mce->misc) is an unreliable indicator for poison
radius and shouldn't be used.  More over, as each injected poison is being
reported independently, any alignment under 512-byte appear works:
L1_CACHE_BYTES (though inaccurate), or 256-bytes (as ars->length reports),
or 512-byte.

To get around this issue, 512-bytes is chosen as the alignment because
  a. it happens to be the badblock granularity,
  b. ndctl inject-error cannot inject more than one poison to a 512-byte block,
  c. architecture agnostic

Fixes: 7917f9cdb503 ("acpi/nfit: rely on mce->misc to determine poison granularity")
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/acpi/nfit/mce.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c
index d48a388b796e..eeacc8eb807f 100644
--- a/drivers/acpi/nfit/mce.c
+++ b/drivers/acpi/nfit/mce.c
@@ -32,7 +32,6 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
 	 */
 	mutex_lock(&acpi_desc_lock);
 	list_for_each_entry(acpi_desc, &acpi_descs, list) {
-		unsigned int align = 1UL << MCI_MISC_ADDR_LSB(mce->misc);
 		struct device *dev = acpi_desc->dev;
 		int found_match = 0;
 
@@ -64,7 +63,8 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
 
 		/* If this fails due to an -ENOMEM, there is little we can do */
 		nvdimm_bus_add_badrange(acpi_desc->nvdimm_bus,
-				ALIGN_DOWN(mce->addr, align), align);
+				ALIGN(mce->addr, SECTOR_SIZE),
+				SECTOR_SIZE);
 		nvdimm_region_notify(nfit_spa->nd_region,
 				NVDIMM_REVALIDATE_POISON);
 

base-commit: e35e5b6f695d241ffb1d223207da58a1fbcdff4b
-- 
2.18.4

