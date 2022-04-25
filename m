Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A64D50D92D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241413AbiDYGHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241405AbiDYGFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:05:46 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10103.outbound.protection.outlook.com [40.107.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822E3659C;
        Sun, 24 Apr 2022 23:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBFI8sJ4l/DHK/urVyRzAIarUOm1viRvJLC5kc/jebK0RyL62Z96KIS2j2UX4vAEoNL3nA5xldvk0JpyHOI23vJ18cqlrkwOIDv6KfDbIXkHNS40T02MO0eXe0n3H5+XItyJuH+l6Nz9V/N7POKoo6piC65vaXegvxItz3kESoQBGMEQLA1V0XzjvWizLaXO+/WX8uKR2hk4iGeL4cUsLK6TVKR+OcPFohRZwgjltR1Xp4kNNK4MqtlR4/lhd/amRMGuAUmlzfLmbUPrmqxnR9DoeT89WOr/u+ac47q7wRaNwJ9Ssisz4vQ4DZsWhAxGGjEVRRg5LxM6dHEBZlA28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5Oe3cKlQEnXhu2wqhKGPmHPw28p23pWL0iw3VDw77Q=;
 b=AQ7g9RpOY6M9q2g2TxEyXqyxfJh2s1W5fEzN3mVD17+bDDXQrovfeM+6Q7lpADSxHVf+slu1qEkeXCaJkabsmFeLPdkG3ueX9zFv3nfJrhloPAyYUwvoT7VCdG0yI+uF5a8o1RwxCXKSu8XY/s5kGwEGTHl0T0YKOkDOkFsC9rwdKwSJbphPaGvl0T+utYbngm8pzTumEmvm5a2+XsoYdr3gU5rV1JSdjaCtkzA++B013AwmybzyY/lr3oleNeOYJpCLqeTBEF5aSAS6EA/1VTcjmVgvDA8NaeOAhwIk04+aU189mjaZ+7S8VJCotpjAWGJ7IMx4TcxCY+yVYVvsOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5Oe3cKlQEnXhu2wqhKGPmHPw28p23pWL0iw3VDw77Q=;
 b=ipyP/4S5ucvUNkm+scbgOUuHznlKnIJS2h3oRbNHHFCneT2nkOw9NBR2OPeTOfnmKF1GsoznVcXqg6SU4azypDsLggFo1KxRGkzlhYSiFbrGhfbKrjzYfA2zwELlszWJrDscWmhJCNMRz0VjjwawsqJ2kQJF7lbMSqlk96mfBoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by AM4PR02MB3025.eurprd02.prod.outlook.com (2603:10a6:205:10::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 06:02:36 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423%5]) with mapi id 15.20.5186.020; Mon, 25 Apr 2022
 06:02:36 +0000
Message-ID: <6e63f598-ff54-6cb6-8c7d-83e9d6231af0@axentia.se>
Date:   Mon, 25 Apr 2022 08:02:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
In-Reply-To: <b657ebf9-e2e3-6d3f-e7e9-c660e860e54c@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH 2/2] iio: dac: ti-dac5571: add support for ti,dac121c081
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0068.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::35) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 785596c2-7d42-4e9b-78c3-08da26813243
X-MS-TrafficTypeDiagnostic: AM4PR02MB3025:EE_
X-Microsoft-Antispam-PRVS: <AM4PR02MB3025C774DED22F08C0CE1C84BCF89@AM4PR02MB3025.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DNEYYnSg6Q9t6AYYPxzNxaeM9Cmin9fCga7kAgK5i08j1hZqt0FN0C+LYbemxAF/mRWEnWgMP8tnfYi6wei4HqG4HmnC+jugCtXyGhherGk0cQFSkWi3wd1tMkJ6WgovJAjp8cYnrUgNdyPRJ0pQLSpYfos49vV+yYPNbPyoy1DDHM6900Z8kQksmiCIRm5ZsLNghTMm/ihNZufK8C7PIgV4f4N1sIY8J0LZshmJCWWFp/uUySMrrETRQNt+NDNSlkBFSzI7rS+aqtYqoiWO8enXwYYvpy6VDrsOd8F/Jify9unsULhFB5R7PcGvUb35q+7Gg7+Fy+HBQPjj7inA5Bs5l9+ckczXauW7JOH/V7tTCuQZ10Yon9WbIZ08dvSIzhlVgOHLAjhlcbD2WBqzd2TH71+2fYw7NBuXh7HzSSHStrAljR3+vllGmPv/rmvVuBHkw5W6sSAoKv4a2pzwAJnxEuryLCmhwbUmM4Fko3j5p24ejLYicubkIbsup7JZpnaZAKzfXT5g3iFLICIjQIiOesZFTgQHDXjvrmbVdjscPjKBwj/6gTm5XyOigl0IKVJRVLekFN7Y1OxB4l13+Y8u0wgYj9qKaW4Itkhgt1UFM6EY47/FZ3W29hnA72r6lS0VWl1Z2ZS/V6OLhogILot5jyyvXHsHv9/2vVMVtNSEqiJh1hYGLMr3yJojZ+2JGNVylzZsL7Qal+qFiEWnvhyiZ0XNhm25zMomN3tBRnP9RMQcrdYksf8d8whUybna5rx8FQu3bg9Tl6m8UIIh1G+5BXcw4TedvTCuTJz1wmkDaD4OhM2sI8vc+3FHgmat
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39830400003)(366004)(376002)(396003)(136003)(346002)(508600001)(316002)(8936002)(36756003)(5660300002)(38100700002)(83380400001)(31686004)(54906003)(6916009)(2616005)(66476007)(66946007)(8676002)(66556008)(86362001)(31696002)(186003)(4326008)(26005)(2906002)(6486002)(966005)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djRtbytTY3dEQkNSNDZDRFlTalhWYzU0MEJjSCtlVDB4VkZta1puYXhGMkJJ?=
 =?utf-8?B?Z3hkbUt2bnJSK1luWlk2TXlyQVRBOElBVjlhZmtqekYzaEhLb0FtdTZXUHNX?=
 =?utf-8?B?Z2FkTUhaQ0lMV0lheCsrSy8zRlArb2lPazgxRjMycDdTTVhUQUhKNWRjTndv?=
 =?utf-8?B?dXpCZHBQakdpNmdqZ1gwWGYzK01LdUlweitEM1pjOXpkeGU4bjBjMjBnb0dw?=
 =?utf-8?B?Uk03alVTWlpmc0xQeHVsS2ZRYkVvRmdXZnZYNzdDUjNlV0xzSElybXFYUVVh?=
 =?utf-8?B?ekFnakJjTGlWRlNmUnZLSy9zOTRMWlJXQmc4aFVrUEkxYkZFMVZpdVdTSjBM?=
 =?utf-8?B?a3I0V3poT0RuOEZES3VnejZCOEZvRGNoYTBTWjNuQzNmSXRhNGFwK2FINkVV?=
 =?utf-8?B?aXNuWmYxUDJqb3lxWnZvYlVZNUoxUGNuQ2pBelNxcjViVml4RzJPbkl2VUtM?=
 =?utf-8?B?dHpZM2NaNFRmVy9VcG1yN1BtbExQdlY5VEhJU21NbDM3K0RwQTlxU2hUcGFD?=
 =?utf-8?B?T2R6YmxacnlxYWRTelA5WWVOVEwwcUFRb016Tk5UeUUvUEZHN2NDMnRyU2RU?=
 =?utf-8?B?ZVNMWWgyU1F3ZitZdC9GVnFwazNXZmw0QWxKSUJnRE5jaE04ZU5KVnU0cXBh?=
 =?utf-8?B?TE93YlhMcnFFc0tsbFp4U0NTeU9VWVNINDlrQ2E0akdVbEpUYkhIZ2VtRlNO?=
 =?utf-8?B?RGVuZzBOOUNJOGFIMW5aYm5mODRiMGN5emNMUkdWVmNvN3BRMEZtTGlBMHRX?=
 =?utf-8?B?QlhwU1dQNEwzZHhoQmY4cndDaldIZkkxQXdrcERUQ1hZUm9hMDg1K3pTTjZs?=
 =?utf-8?B?ZnVkWGVRSlUvVUlKZkJvSnRNU1RDcndHTldETEVvblNZUkZML05qYllHSHQv?=
 =?utf-8?B?UTdWdDQ3SmlWYTF5NldtdFRCOU5URVB0dHlsK1JJanJnRU0zZmdXSFpzb3du?=
 =?utf-8?B?dy9nUzRteVVsVEhUSlVVOVV1Q1UvbjIwNktwYjJaWithdExWL3BJeHlmeDBD?=
 =?utf-8?B?RENaaHpUQjc4WUdRMHI0VGRBdnFFdkNydlI3Q0RhZXhRdkE3VmFNajgzSjFi?=
 =?utf-8?B?UjcxZmJxeWQvTTFJbEsyWlpycTlMYUl2QWJVd0hUQ0x6K1F3cTNXVVEwaWJi?=
 =?utf-8?B?Z2hsa2JpOWZBUVdmdU55Z3R5UDZ4SlpBamdjQjlMbjF3M3QzRktsQ1hheUU3?=
 =?utf-8?B?V3VvdTJPb3M3Y2gzNDRkc3VEeEV3R3UvOFdHUUw4VjdXc3pVT2dYZ2lpU2Uw?=
 =?utf-8?B?T0IwekRmaVMvNUJ5K1pvZ1ZwSnIxdEpBbi82SjIwdDFsTXIxcTNzNDZXZU90?=
 =?utf-8?B?T3Y1OWZRQUNoTlpCYnZXQkVacUMyZXF0TFZSclhZUWRScmJoMHZOMTVzcDhR?=
 =?utf-8?B?ZGNwRytqZHBJSmUxTm1BSVhDZ2tJS2NzUHQyNzFTWWVqTXQ1bjFPUE9CUUE5?=
 =?utf-8?B?bmlFTXlSOCt2OFdiRkp3ZVdsbERPQWprWDZ3ZVVyV0lXQ1AvSU9ES3czWUJ1?=
 =?utf-8?B?WHFGV3dkUFNMNDBrMmllV1RrV2xMdWoxK0s3UXRQclNIZmxlSWJaczVoT0dL?=
 =?utf-8?B?SXhjK1FTRzduc3VTL0RxNC9ZTDhQMDBHZTl6YkRZSkpWYklPaHVuaWx1aVdq?=
 =?utf-8?B?ZzNGYnlJSngxRGtQS1B2N2hSRGVNTmdFd21FMHE2Wmo4VDJKRjRmQUpHVlc5?=
 =?utf-8?B?R3RBRjZUK2dmaXd4QkkxOXRYVkUwR0oyZlhsS1NUcytrMDBrZmtzS1VrMEJ5?=
 =?utf-8?B?MEY3Z3g2N2tIVDRkKzR3UW96MENoR0NCNkdLRnh6Y2lJVytZZFgzZUl6Z2sx?=
 =?utf-8?B?eVBkZ0VGVEs5ZHRyTXh5eTJqSExrWEYxcmRFNFpPSllqREI2bHFMTDYyNG5M?=
 =?utf-8?B?OHYwMW4ycmhFL2Vrb2VYM3hPTnU5VzBZNjB0dFM3a213T2Q3K0hzZnB4VUFP?=
 =?utf-8?B?N2RkK3V3Vy9Tc2dOVjU5czBKeVhaNUNtN255MnJnbDB2Q3l2M2N3c2VVRWt3?=
 =?utf-8?B?aytiN3l2TXRjdTQvVEY2Mm1KbmNNd0FUQ1BTcERmMUVBV1J2T09BTUR4NVd3?=
 =?utf-8?B?dHYwa3pieEVzNWZLK3poOG8rV0N6L3pEZkFSZnFES1VZUm5yajJLaTc2ZGlJ?=
 =?utf-8?B?dUpnUzBHUXZySkFpd1ptb3RncnhGekpMN255MXVMaXhzM0RsUVFaMzZOTUZF?=
 =?utf-8?B?WVFSa1dYSU54Sks1WXFWK01Cb2ZaNFFuWlVaNlp0ZjRlQUp3M3BMYTlZYmhQ?=
 =?utf-8?B?M1BQNC9WM2ZQQ2ZwTHFESmFtRnZDMnF2bWhJWjdyUjZlcVorNUpoWkFOQTBD?=
 =?utf-8?B?UXU5QmVaRkZ2SEUyWmoxUjdFUmpIcWZvenV3eUZEK3QwZGI4c0xTZz09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 785596c2-7d42-4e9b-78c3-08da26813243
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 06:02:36.3203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrNsMh7IzVmrfpT0/aXpyzBqx6oXeuSQhtU/FHV24HHnNQJAxYWQ9I5w9q42gQ02
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR02MB3025
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It fits right in as a single 12-bit DAC.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
  drivers/iio/dac/Kconfig      | 2 +-
  drivers/iio/dac/ti-dac5571.c | 3 +++
  2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index c0bf0d84197f..d6248b188645 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -417,7 +417,7 @@ config TI_DAC5571
  	help
  	  Driver for the Texas Instruments
  	  DAC5571, DAC6571, DAC7571, DAC5574, DAC6574, DAC7574, DAC5573,
-	  DAC6573, DAC7573, DAC8571, DAC8574.
+	  DAC6573, DAC7573, DAC8571, DAC8574, DAC121C081.
  
  	  If compiled as a module, it will be called ti-dac5571.
  
diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index 4a3b8d875518..ce542bd8b69e 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -13,6 +13,7 @@
   * https://www.ti.com/lit/ds/symlink/dac5573.pdf
   * https://www.ti.com/lit/ds/symlink/dac6573.pdf
   * https://www.ti.com/lit/ds/symlink/dac7573.pdf
+ * https://www.ti.com/lit/ds/symlink/dac121c081.pdf
   */
  
  #include <linux/iio/iio.h>
@@ -394,6 +395,7 @@ static const struct of_device_id dac5571_of_id[] = {
  	{.compatible = "ti,dac5573"},
  	{.compatible = "ti,dac6573"},
  	{.compatible = "ti,dac7573"},
+	{.compatible = "ti,dac121c081"},
  	{}
  };
  MODULE_DEVICE_TABLE(of, dac5571_of_id);
@@ -408,6 +410,7 @@ static const struct i2c_device_id dac5571_id[] = {
  	{"dac5573", quad_8bit},
  	{"dac6573", quad_10bit},
  	{"dac7573", quad_12bit},
+	{"dac121c081", single_12bit},
  	{}
  };
  MODULE_DEVICE_TABLE(i2c, dac5571_id);
-- 
2.20.1

