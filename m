Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A9F527EB0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241159AbiEPHi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbiEPHix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:38:53 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00091.outbound.protection.outlook.com [40.107.0.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BB52ACD
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:38:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkC7fq5lF9W4Mv0ET+4dxfzf/FvsbJoUcNb7pKQjH4XDdV5lm0EBmBnvrwHnegVy6wQgLn6RtUOUS0rV8MYcO7Fv9LYzzd3sJOSzHQIPwVSZy2pSUJqYZK/6TSLIl7XpENkPs186/baAf2pgxh7Np45p4WhujWgsMdJAEx0+EiNpAJ8BvxXcpZQaCCq+w2hJxBLQcTVAXNxJ9Bq4X+j/CVjntPY1ChQDiBmRHZoth/Az6W3ntOa+b8MuJKH1G/Zlpuh5UfmhG6lMZGeyF2EKg/w7t/l5OkA/SYxfUs6eBhd+ZkmNbahnIxx854bu0NbmBw6jdAlthZ+SFOAs9ABA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1FxcVc7VY86yEc9M2pBy1GLKNPbgugBg4Hi55b1Kys=;
 b=dFgBm3ODYdYCy0lPWYhKzdwiB+Dq5ArQDrY9fUitcHx4lzT1CNSyX2buZV5ah3TndFAfYW3PtgCV/U/GgQZojEf5usgI0N+wO6E/Nh0Z3KlLqScshyWUFPf8nwXtHiLJdfw6IOHkFZh/bT0Y/kjHpqsNqQaQ036bQLLfliS+C9oCjZZ0wks9f8HyAuc4eOqV5Et0PeOqWmUubW+HMgjXjLGFFX1/K7NoCTAkZJuUvWnAdMkept/X/KJMz7EAWx1zbwe4ZByvcd3WmtyaZWRvcPgjncRkSjce2Bqh2PX/UaMmFWN+sec26VrABrZBdieR9DSfjjPVVgFRrBgkSo1zqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1FxcVc7VY86yEc9M2pBy1GLKNPbgugBg4Hi55b1Kys=;
 b=cT1OeGQgG4zPsKmxY+8+c9mQp9w1w/0qszlWgxTK67GPTRAARtHVVniajdlwGezkyRxTTN6Tm6PFcTP9fTzIQM1djCIhMlfbByMtPKpTeK0OCtjObhZRFjh49UCQm+zvfyt3WlnqTGhBWRmno4YdpEXbspO/5TVNBSvROQHrafs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS4PR10MB5443.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 07:38:46 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d0e:eb72:973:1e71]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d0e:eb72:973:1e71%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 07:38:46 +0000
Message-ID: <05966ece-65c8-ff7c-cb44-55c4d5a5542e@kontron.de>
Date:   Mon, 16 May 2022 09:38:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] mtd: spinand: add support for detection with param
 page
Content-Language: en-US
To:     Chuanhong Guo <gch981213@gmail.com>, linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220414143426.723168-1-gch981213@gmail.com>
 <20220414143426.723168-2-gch981213@gmail.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20220414143426.723168-2-gch981213@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8P251CA0015.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:2f2::14) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 787a1983-6d61-4848-eb81-08da370f1c0b
X-MS-TrafficTypeDiagnostic: AS4PR10MB5443:EE_
X-Microsoft-Antispam-PRVS: <AS4PR10MB5443993EC726646B4FC6B15FE9CF9@AS4PR10MB5443.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YL67Q+Pnz/edZg9vDJlPLvyzA4t8f8UsSToXqpObW/bMxYQZ6/97otaW30L1tNCP+dVUlYChGzYoukIXQZjuo0gayKd6jMKD0fW8Y+HzMPQaWNUmk7ZlW5J2ZTxBuAgfIuSvvYbZFGmE4kSHS77HN64jpxAgWoZUP2dC/reygRBCBOZodV/S76zsX745XWfyUb5UTbbWr41X/RU+lQ3LSn9MX9s0lP8+IT1tMy9VCfyjOU5OsK9j5ixZkWz2OJroFnC1J1FJUvVrDdIc8QlN+ntz24RbRMwzDAznjA0qCqNj+RUWcNx2kjfJZLWAFtv8IYJ1Xo0ycByQ1s6gtqAoGez1R9UsJkHvSG/oW4/n6VOvEezN/IhyFy/TNaZ+NOKEoQMbgXd1+TPpRt6hec+dFHfgf8VIgglPLC2KS9oBhWahX99tqNQm7Kb/ycUrNMkhktpgSAw7Z97VnPvMi4oPQT2ntu4ZXwpiocRQqIfjr1nCik0bHn8F6sOcWZwgecWZXvyMv+IkTRSCoQOUmD5yL26XfwEQuceIuz4KTupRtpKACZkOMImip2MIEuDwN9u4M8AZLPRptTRT2qFIJmGemlqz8K8aaTEBJOm3eTwtXj/rFSIcasXIRlUV1cKEtxhmbn3vYd/f8ebyVuCuLXpvFLL34DqSrxGaLTu6nMrlByTbELGo9LbmGvQF6fi58jwyIq4xkrJWKiZM379HkNt05UTgnXJn6cC+uzPKMZdn6N3h4jJ/vVp92Ie0cvs+acAWWTDMLjdm0Kx9vbIiIP+SJksicEJpDAmCZlZB3MHxu8PU2l4FP6KihVnUQs0cQjzcAgp9+4zh30x7galp0VqQdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(316002)(54906003)(66476007)(66556008)(66946007)(31696002)(31686004)(5660300002)(38100700002)(8936002)(30864003)(6486002)(44832011)(36756003)(2906002)(508600001)(7416002)(6506007)(6512007)(186003)(4326008)(8676002)(966005)(83380400001)(26005)(2616005)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmNxWE0zWEY4bndLUlA3VUVBT1Y5RWFoeDJESUxJSkVhU0dWQTA0RC92MS9a?=
 =?utf-8?B?RmY0czNhWm4wdUN3VmU5WEVidnR2U3oyZU1LZFFxK3AzeW81MTZYb0Y4TlIy?=
 =?utf-8?B?RkgxK0lXeU1jQ25MOFBvdWkzTDlTVXdxTUVHU3NLM1MvSUdSNTRGempRRjZa?=
 =?utf-8?B?NTZLSlF3WUkrYkp3WWhHUUNvdUdrVnpac2ZpUkREUVJBOW5XTW1Dc20zTkxJ?=
 =?utf-8?B?QlF4SWZDSEdHZHBNUlAzb2QwOFlSOGVwMUtXMVJ0NW82anc3SlJtaFhqcEZW?=
 =?utf-8?B?VUo4ejZiQ09mcDhPNVF2ZXp1d2kvM091dWhJNkdWM2dsQkovc1BJT1I5a3R0?=
 =?utf-8?B?U0YvTExlZEJoRnBOUzRNK0Nad3Q4VVd6OFJ5ZmhBcjU3Z294eVpOYUtqK3Fv?=
 =?utf-8?B?ZGxqOExIZnI3T2FwamZDS0p5b0FhOWJkYytUUUR5dUltR2xiL3J2Z3pkN0dD?=
 =?utf-8?B?OWsyMTNWTUtVcjJoZXdBdmFxTTI2Zm92ZGR4dzQ5bnFwT29XMTJ6M0VwRVZo?=
 =?utf-8?B?ekRhVDlIeXVvcEh4Nm5CMHZlVEIrVTl3NlRab3dmVURLOXAxa2RVV2FoYjVz?=
 =?utf-8?B?Y3Jwbk1DckdqeVRIdHUwK21UcS9lTUU4TDY1V0tXZXpmVnU4YmhVczYwMDdY?=
 =?utf-8?B?QlFWRmZ2Q1Q4NDdmYUJERkZjQjdjWVJHSStjekM4Wml5eUd5QUJCaXZrNnlZ?=
 =?utf-8?B?VlVjaG54clhPN2JCU0tJT2p2NDNkcCtGdGlCOWVGS0JFZUVMZDlUTGZDV3hK?=
 =?utf-8?B?MDFzMzdpbGVHZGpzWVZpWlpkdHQ4TDlUeXlTTy8vZU1XMHpkcnZMc1IrcktO?=
 =?utf-8?B?K3RKS1BWVkVPakZQZTUxcWZyVSt5MWptRGlaRCtTRm9ua0NMZStKU1BXZkU2?=
 =?utf-8?B?R2lHNGx6amdXUDNPd3VDK1lDaDF6NXlxOTRyZUxaalRIRk05MkVJWEFlblho?=
 =?utf-8?B?REF6NlFnMmpQYkNOdW5PYThwYUdWZ05sbkpRemlOWEE3dmlPNjNSU2cyNHdp?=
 =?utf-8?B?WTUzV082YUxpODRqY3BzZkNhV2JtSnQ3SHZPMWM0K3YvSWpFUUxSYUtlMnBx?=
 =?utf-8?B?WUhneFgyQ09XdHYvNUlQaUJUVFJ4NGZIRnNsT29jNGIxT1loNHpDSEdUWm5u?=
 =?utf-8?B?aUZHVmV2Q3pub1RkT0xVd3o0dkFiWnRxZXR5M21BR1NuM01XVGdkUjIralU5?=
 =?utf-8?B?VGFadGxkVDM4bGdjcmZpa211V3FreEVUdTFUR2dOamtPa2Q5azZlOUl3WVBi?=
 =?utf-8?B?WllkTlFJaHZCSmhLbUw4RmdTSmpCbjZQRG1TV0F0ZWkwZEUzL2VSTTlTV3hU?=
 =?utf-8?B?NmFmQmN1NlR0TzI4ZzVsMWxnT3NLUFg2QnNGNHRILzk5MkJjb0djeHhVM0ZQ?=
 =?utf-8?B?SDhGWHhrM29FVkExYUcxaEZIVDFNZytTS095T3ZYSDl5VkxUdmNDdExqdnN5?=
 =?utf-8?B?eXJ6WXluUC8yNmZvWmdBSmhuejA3TTlWNFBNN1Yxa01OQW9ydUpmREV4eHA5?=
 =?utf-8?B?aTdUL01YOFUxcjNiVWhzRFB2YlYySFVWSDhxcUtmeWtmbFFxVXArcnR1b0Vn?=
 =?utf-8?B?SU5CaUpsYTkwK1NjZWZ1aU5FL1dUWXRsOG92dDVLOFJSUmt4aEdGVHpEcXFy?=
 =?utf-8?B?aXJ0R1V2T3UyQmJ4QVdaNm90K3pEbU1zSWhhZ0JoQjdjU1ByMy9QTC8zVVpu?=
 =?utf-8?B?UU1nLzhkWFozbGs1ZnhMU1JORzJSZVZFQXVWcG9oS0FVYVhOejNjMTJjN0lU?=
 =?utf-8?B?QUl2NVFFSjBtdFVuUGl5R2RSV09jZHAxRStNNUFCK1pUZWZGU3l5VU96LzE5?=
 =?utf-8?B?V2NDeFRTNXBsRkxwTDBaOWFGUkpSTk0vWWV5aVNrUHIxWG5YUGM1c2RsTkgy?=
 =?utf-8?B?SDg0MXVocmtNZFpXY1BvQldkZElsNk5RTFpXcktRZklSWDJWaFdQMkYvUXpT?=
 =?utf-8?B?TDducVBqRy9BOW1qYjllaDJqcEpxcWRNN2daa0JjRmFCSXZpMTUxMk1pTTA3?=
 =?utf-8?B?b2NQcFR6Y2lOelM5bTE0NVBSaDR0eTZ6SVo0T2VobmlqUWp2Z3h0TnVhU1Q4?=
 =?utf-8?B?Unh4VTBwdGZ6SEpSUExyb0FmYXJRV1o2OWNsdi9TaEhOaEkra25teXM3WExr?=
 =?utf-8?B?VmtKNnJPRFA4NUpielRGNTZvNmNzYXdiUmlwb25GOWFQbWYzdHJJL0x3eldS?=
 =?utf-8?B?cm1kRTBWRzFOa2ExcFB3anN5ckw0RXhONklWWUFHcjhGS21WU2o1bDFENGs1?=
 =?utf-8?B?L01tVkwrY2FweEh5ZUxSSThFS1hWNEx2bkx1VmZtVmdWNGQ1Z1pjMnRydGdE?=
 =?utf-8?B?T2FSYy8xM3hBUERFMUMxMy9mNmpTZTEvVUJCZVFuK2ROVFdXTDU1N1ZnN3Yr?=
 =?utf-8?Q?J1vqVsdCG8x4iYgY=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 787a1983-6d61-4848-eb81-08da370f1c0b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 07:38:46.3270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvFwE8wvnsvY+QmAjs3MxuyYoHQTrTcBOf4k/6xJ5vCqCaIVvnE6VegeCxXSJ6mTAZxAwkV25RSE9+HDO4mqOJQH/6YNLHpSGrimOSwLGJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5443
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuanhong,

Am 14.04.22 um 16:34 schrieb Chuanhong Guo:
> SPI-NAND detection using chip ID isn't always reliable.
> Here are two known cases:
> 1. ESMT uses JEDEC ID from other vendors. This may collapse with future
>    chips.
> 2. Winbond W25N01KV uses the exact same JEDEC ID as W25N01GV while
>    having completely different chip parameters.

I think they share the same first byte of the JEDEC ID, but the second
byte actually differs and would allow to differentiate between them, right?

I have this patchset [1] that I didn't manage to send upstream yet which
adds support for the W25N02KV. I added the second ID byte to detect them.

Still your approach using the ONFI data is more flexible of course and
probably a better way to handle this. I will see if I can find some time
to add support for the W25N02KV based on your patches.

Best regards
Frieder

[1]
https://github.com/fschrempf/linux/commits/feature/upstream/winbond-spinand-support

> 
> Recent SPI-NANDs have a parameter page which is stored in the same
> format as raw NAND ONFI data. There are strings for chip manufacturer
> and chip model. Chip ECC requirement and memory organization are
> available too.
> This patch adds support for detecting SPI-NANDs with the parameter page
> after ID matching failed. In this detection, memory organization and
> ECC requirements are taken from the parameter page, and other SPI-NAND
> specific parameters are obtained by matching chip model string with
> a separated table.
> 
> It's common for vendors to release a series of SPI-NANDs with the same
> SPI-NAND parameters in different voltages and/or capacities. The chip
> table defined in this patch supports multiple model strings in one
> entry, and multiple chip models can be covered using only one entry.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
> 
> I'm not brave enough to touch raw nand code without testing, so
> sanitize_string, onfi_crc16 and nand_bit_wise_majority are
> duplicated from raw/nand_onfi.c into spi/onfi.c
> 
>  drivers/mtd/nand/spi/Makefile |   2 +-
>  drivers/mtd/nand/spi/core.c   |  23 +--
>  drivers/mtd/nand/spi/onfi.c   | 296 ++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h   |  50 ++++++
>  4 files changed, 359 insertions(+), 12 deletions(-)
>  create mode 100644 drivers/mtd/nand/spi/onfi.c
> 
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
> index 9662b9c1d5a9..a4e057cbdaf7 100644
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> -spinand-objs := core.o gigadevice.o macronix.o micron.o paragon.o toshiba.o winbond.o
> +spinand-objs := core.o gigadevice.o macronix.o micron.o onfi.o paragon.o toshiba.o winbond.o
>  obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index ff8336870bc0..3b51ca7232d0 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -20,7 +20,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/spi/spi-mem.h>
>  
> -static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
> +int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
>  {
>  	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(reg,
>  						      spinand->scratchbuf);
> @@ -34,7 +34,7 @@ static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
>  	return 0;
>  }
>  
> -static int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)
> +int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)
>  {
>  	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(reg,
>  						      spinand->scratchbuf);
> @@ -339,7 +339,7 @@ static void spinand_ondie_ecc_save_status(struct nand_device *nand, u8 status)
>  		engine_conf->status = status;
>  }
>  
> -static int spinand_write_enable_op(struct spinand_device *spinand)
> +int spinand_write_enable_op(struct spinand_device *spinand)
>  {
>  	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
>  
> @@ -496,10 +496,8 @@ static int spinand_erase_op(struct spinand_device *spinand,
>  	return spi_mem_exec_op(spinand->spimem, &op);
>  }
>  
> -static int spinand_wait(struct spinand_device *spinand,
> -			unsigned long initial_delay_us,
> -			unsigned long poll_delay_us,
> -			u8 *s)
> +int spinand_wait(struct spinand_device *spinand, unsigned long initial_delay_us,
> +		 unsigned long poll_delay_us, u8 *s)
>  {
>  	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(REG_STATUS,
>  						      spinand->scratchbuf);
> @@ -1006,7 +1004,7 @@ static void spinand_manufacturer_cleanup(struct spinand_device *spinand)
>  		return spinand->manufacturer->ops->cleanup(spinand);
>  }
>  
> -static const struct spi_mem_op *
> +const struct spi_mem_op *
>  spinand_select_op_variant(struct spinand_device *spinand,
>  			  const struct spinand_op_variants *variants)
>  {
> @@ -1117,9 +1115,12 @@ static int spinand_detect(struct spinand_device *spinand)
>  
>  	ret = spinand_id_detect(spinand);
>  	if (ret) {
> -		dev_err(dev, "unknown raw ID %*phN\n", SPINAND_MAX_ID_LEN,
> -			spinand->id.data);
> -		return ret;
> +		ret = spinand_onfi_detect(spinand);
> +		if (ret) {
> +			dev_err(dev, "unknown raw ID %*phN\n",
> +				SPINAND_MAX_ID_LEN, spinand->id.data);
> +			return ret;
> +		}
>  	}
>  
>  	if (nand->memorg.ntargets > 1 && !spinand->select_target) {
> diff --git a/drivers/mtd/nand/spi/onfi.c b/drivers/mtd/nand/spi/onfi.c
> new file mode 100644
> index 000000000000..5cc888e3d038
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/onfi.c
> @@ -0,0 +1,296 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Detect and match SPI-NAND info using ONFI parameter page
> + *
> + * Author:
> + *	Chuanhong Guo <gch981213@gmail.com>
> + *
> + * Part of this code comes from nand_onfi.c in raw nand support.
> + *
> + */
> +#include <linux/crc16.h>
> +#include <linux/mtd/onfi.h>
> +#include <linux/mtd/spinand.h>
> +
> +#define SPINAND_IDR_EN BIT(6)
> +#define SPINAND_PARAM_PAGE 1
> +#define ONFI_PARAM_PAGES 3
> +
> +/* Sanitize ONFI strings so we can safely print them */
> +static void sanitize_string(uint8_t *s, size_t len)
> +{
> +	ssize_t i;
> +
> +	/* Null terminate */
> +	s[len - 1] = 0;
> +
> +	/* Remove non printable chars */
> +	for (i = 0; i < len - 1; i++) {
> +		if (s[i] < ' ' || s[i] > 127)
> +			s[i] = '?';
> +	}
> +
> +	/* Remove trailing spaces */
> +	strim(s);
> +}
> +
> +static u16 onfi_crc16(u16 crc, u8 const *p, size_t len)
> +{
> +	int i;
> +
> +	while (len--) {
> +		crc ^= *p++ << 8;
> +		for (i = 0; i < 8; i++)
> +			crc = (crc << 1) ^ ((crc & 0x8000) ? 0x8005 : 0);
> +	}
> +
> +	return crc;
> +}
> +
> +static int spinand_onfi_read(struct spinand_device *spinand, void *buf,
> +			     size_t len)
> +{
> +	const struct spi_mem_op load_page =
> +		SPINAND_PAGE_READ_OP(SPINAND_PARAM_PAGE);
> +	struct spi_mem_op read_cache =
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, buf, len);
> +	int ret;
> +	u8 cfg;
> +
> +	ret = spinand_read_reg_op(spinand, REG_CFG, &cfg);
> +	if (ret)
> +		return ret;
> +
> +	ret = spinand_write_enable_op(spinand);
> +	if (ret)
> +		return ret;
> +
> +	ret = spinand_write_reg_op(spinand, REG_CFG, cfg | SPINAND_IDR_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret = spinand_read_reg_op(spinand, REG_CFG, &cfg);
> +	if (ret)
> +		return ret;
> +
> +	if (!(cfg & SPINAND_IDR_EN))
> +		return -EINVAL;
> +
> +	ret = spi_mem_exec_op(spinand->spimem, &load_page);
> +	if (ret)
> +		goto cleanup;
> +
> +	ret = spinand_wait(spinand, SPINAND_READ_INITIAL_DELAY_US,
> +			   SPINAND_READ_POLL_DELAY_US, NULL);
> +	if (ret)
> +		goto cleanup;
> +
> +	while (len) {
> +		ret = spi_mem_adjust_op_size(spinand->spimem, &read_cache);
> +		if (ret)
> +			goto cleanup;
> +		ret = spi_mem_exec_op(spinand->spimem, &read_cache);
> +		if (ret)
> +			goto cleanup;
> +		read_cache.addr.val += read_cache.data.nbytes;
> +		read_cache.data.buf.in += read_cache.data.nbytes;
> +		len -= read_cache.data.nbytes;
> +		read_cache.data.nbytes = len;
> +	}
> +cleanup:
> +	spinand_write_reg_op(spinand, REG_CFG, cfg & ~SPINAND_IDR_EN);
> +	return ret;
> +}
> +
> +static bool spinand_onfi_validate(const struct nand_onfi_params *p)
> +{
> +	u16 crc;
> +
> +	if (strncmp("ONFI", p->sig, 4))
> +		return false;
> +	crc = onfi_crc16(ONFI_CRC_BASE, (u8 *)p, sizeof(*p) - 2);
> +	return crc == le16_to_cpu(p->crc);
> +}
> +
> +/*
> + * Recover data with bit-wise majority
> + */
> +static void nand_bit_wise_majority(const void **srcbufs, unsigned int nsrcbufs,
> +				   void *dstbuf, unsigned int bufsize)
> +{
> +	int i, j, k;
> +
> +	for (i = 0; i < bufsize; i++) {
> +		u8 val = 0;
> +
> +		for (j = 0; j < 8; j++) {
> +			unsigned int cnt = 0;
> +
> +			for (k = 0; k < nsrcbufs; k++) {
> +				const u8 *srcbuf = srcbufs[k];
> +
> +				if (srcbuf[i] & BIT(j))
> +					cnt++;
> +			}
> +
> +			if (cnt > nsrcbufs / 2)
> +				val |= BIT(j);
> +		}
> +
> +		((u8 *)dstbuf)[i] = val;
> +	}
> +}
> +
> +static const struct spinand_manufacturer *spinand_onfi_manufacturers[] = {};
> +
> +static const struct spinand_onfi_info *
> +spinand_onfi_chip_match(struct nand_onfi_params *p,
> +			const struct spinand_manufacturer *m)
> +{
> +	size_t i, j;
> +
> +	for (i = 0; i < m->nchips; i++)
> +		for (j = 0; m->onfi_chips[i].models[j]; j++)
> +			if (!strcasecmp(m->onfi_chips[i].models[j], p->model))
> +				return &m->onfi_chips[i];
> +	return NULL;
> +}
> +
> +static const struct spinand_onfi_info *
> +spinand_onfi_manufacturer_match(struct spinand_device *spinand,
> +				struct nand_onfi_params *p)
> +{
> +	const struct spinand_onfi_info *ret;
> +	size_t i;
> +
> +	for (i = 0; i < ARRAY_SIZE(spinand_onfi_manufacturers); i++) {
> +		if (strcasecmp(spinand_onfi_manufacturers[i]->name,
> +			       p->manufacturer))
> +			continue;
> +		spinand->manufacturer = spinand_onfi_manufacturers[i];
> +		ret = spinand_onfi_chip_match(p, spinand_onfi_manufacturers[i]);
> +		if (ret)
> +			return ret;
> +	}
> +	return NULL;
> +}
> +
> +/**
> + * spinand_onfi_detect() - match SPI-NAND using ONFI parameter page
> + * @spinand: spinand private structure
> + *
> + * Return:
> + *  0: Success
> + *  -EINVAL: failed to read a valid parameter page
> + *  -EOPNOTSUPP: chip isn't supported
> + */
> +int spinand_onfi_detect(struct spinand_device *spinand)
> +{
> +	struct nand_onfi_params *p = NULL, *pbuf;
> +	size_t params_len = sizeof(*pbuf) * ONFI_PARAM_PAGES;
> +	struct nand_device *nand = spinand_to_nand(spinand);
> +	struct nand_memory_organization *memorg = nanddev_get_memorg(nand);
> +	const struct spi_mem_op *op;
> +	const struct spinand_onfi_info *info;
> +	int i, ret;
> +
> +	pbuf = kzalloc(params_len, GFP_KERNEL);
> +	if (!pbuf)
> +		return -ENOMEM;
> +
> +	ret = spinand_onfi_read(spinand, pbuf, params_len);
> +	if (ret)
> +		goto cleanup;
> +
> +	for (i = 0; i < ONFI_PARAM_PAGES; i++) {
> +		if (spinand_onfi_validate(&pbuf[i])) {
> +			p = &pbuf[i];
> +			break;
> +		}
> +	}
> +
> +	if (!p) {
> +		const void *srcbufs[ONFI_PARAM_PAGES];
> +		unsigned int j;
> +
> +		for (j = 0; j < ONFI_PARAM_PAGES; j++)
> +			srcbufs[j] = pbuf + j;
> +		nand_bit_wise_majority(srcbufs, ONFI_PARAM_PAGES, pbuf,
> +				       sizeof(*pbuf));
> +		if (spinand_onfi_validate(pbuf))
> +			p = pbuf;
> +	}
> +
> +	if (!p) {
> +		ret = -EINVAL;
> +		goto cleanup;
> +	}
> +
> +	sanitize_string(p->manufacturer, sizeof(p->manufacturer));
> +	sanitize_string(p->model, sizeof(p->model));
> +
> +	info = spinand_onfi_manufacturer_match(spinand, p);
> +	if (!info) {
> +		dev_err(&spinand->spimem->spi->dev, "unknown chip: %s %s",
> +			p->manufacturer, p->model);
> +		ret = -EOPNOTSUPP;
> +		goto cleanup;
> +	}
> +
> +	/* setup memory organization using info from parameter page */
> +	memorg->pagesize = le32_to_cpu(p->byte_per_page);
> +
> +	/*
> +	 * pages_per_block and blocks_per_lun may not be a power-of-2 size
> +	 * (don't ask me who thought of this...). MTD assumes that these
> +	 * dimensions will be power-of-2, so just truncate the remaining area.
> +	 */
> +	memorg->pages_per_eraseblock =
> +		1 << (fls(le32_to_cpu(p->pages_per_block)) - 1);
> +	memorg->oobsize = le16_to_cpu(p->spare_bytes_per_page);
> +	memorg->luns_per_target = p->lun_count;
> +	memorg->planes_per_lun = 1 << p->interleaved_bits;
> +	memorg->ntargets = 1;
> +
> +	/* See erasesize comment */
> +	memorg->eraseblocks_per_lun =
> +		1 << (fls(le32_to_cpu(p->blocks_per_lun)) - 1);
> +	memorg->max_bad_eraseblocks_per_lun = le32_to_cpu(p->blocks_per_lun);
> +	memorg->bits_per_cell = p->bits_per_cell;
> +
> +	if (p->ecc_bits != 0xff) {
> +		struct nand_ecc_props requirements = {
> +			.strength = p->ecc_bits,
> +			.step_size = p->data_bytes_per_ppage,
> +		};
> +
> +		nanddev_set_ecc_requirements(nand, &requirements);
> +	} else {
> +		ret = -EINVAL;
> +	}
> +
> +	/* setup spi-nand specific ops */
> +	spinand->eccinfo = info->eccinfo;
> +	spinand->flags = info->flags;
> +	spinand->id.len = 0;
> +	spinand->select_target = info->select_target;
> +
> +	op = spinand_select_op_variant(spinand, info->op_variants.read_cache);
> +	if (!op)
> +		return -EOPNOTSUPP;
> +
> +	spinand->op_templates.read_cache = op;
> +
> +	op = spinand_select_op_variant(spinand, info->op_variants.write_cache);
> +	if (!op)
> +		return -EOPNOTSUPP;
> +
> +	spinand->op_templates.write_cache = op;
> +
> +	op = spinand_select_op_variant(spinand, info->op_variants.update_cache);
> +	spinand->op_templates.update_cache = op;
> +
> +cleanup:
> +	kfree(pbuf);
> +	return ret;
> +}
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 3aa28240a77f..dc218082d773 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -255,6 +255,7 @@ struct spinand_manufacturer {
>  	u8 id;
>  	char *name;
>  	const struct spinand_info *chips;
> +	const struct spinand_onfi_info *onfi_chips;
>  	const size_t nchips;
>  	const struct spinand_manufacturer_ops *ops;
>  };
> @@ -386,6 +387,46 @@ struct spinand_info {
>  		__VA_ARGS__						\
>  	}
>  
> +/**
> + * struct spinand_onfi_info - Structure used to describe SPI NAND with ONFI
> + *			      parameter page
> + * @models: Model name array. Null terminated.
> + * @flags: OR-ing of the SPINAND_XXX flags
> + * @eccinfo: on-die ECC info
> + * @op_variants: operations variants
> + * @op_variants.read_cache: variants of the read-cache operation
> + * @op_variants.write_cache: variants of the write-cache operation
> + * @op_variants.update_cache: variants of the update-cache operation
> + * @select_target: function used to select a target/die. Required only for
> + *		   multi-die chips
> + *
> + * Each SPI NAND manufacturer driver should have a spinand_onfi_info table
> + * describing all the chips supported by the driver.
> + */
> +struct spinand_onfi_info {
> +	const char **const models;
> +	u32 flags;
> +	struct spinand_ecc_info eccinfo;
> +	struct {
> +		const struct spinand_op_variants *read_cache;
> +		const struct spinand_op_variants *write_cache;
> +		const struct spinand_op_variants *update_cache;
> +	} op_variants;
> +	int (*select_target)(struct spinand_device *spinand,
> +			     unsigned int target);
> +};
> +
> +#define SPINAND_ONFI_MODELS(...)					\
> +	.models = (const char *[]){ __VA_ARGS__, NULL }
> +
> +#define SPINAND_ONFI_INFO(__models, __op_variants, __flags, ...)	\
> +	{								\
> +		__models,						\
> +		.op_variants = __op_variants,				\
> +		.flags = __flags,					\
> +		__VA_ARGS__						\
> +	}
> +
>  struct spinand_dirmap {
>  	struct spi_mem_dirmap_desc *wdesc;
>  	struct spi_mem_dirmap_desc *rdesc;
> @@ -511,7 +552,16 @@ int spinand_match_and_init(struct spinand_device *spinand,
>  			   unsigned int table_size,
>  			   enum spinand_readid_method rdid_method);
>  
> +int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val);
> +int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val);
> +int spinand_write_enable_op(struct spinand_device *spinand);
>  int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
> +int spinand_onfi_detect(struct spinand_device *spinand);
> +const struct spi_mem_op *
> +spinand_select_op_variant(struct spinand_device *spinand,
> +			  const struct spinand_op_variants *variants);
>  int spinand_select_target(struct spinand_device *spinand, unsigned int target);
> +int spinand_wait(struct spinand_device *spinand, unsigned long initial_delay_us,
> +		 unsigned long poll_delay_us, u8 *s);
>  
>  #endif /* __LINUX_MTD_SPINAND_H */
