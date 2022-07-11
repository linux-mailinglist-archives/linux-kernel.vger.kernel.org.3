Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B1356D4D8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiGKGnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGKGm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:42:58 -0400
X-Greylist: delayed 602 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 10 Jul 2022 23:42:57 PDT
Received: from 4.mo552.mail-out.ovh.net (4.mo552.mail-out.ovh.net [178.33.43.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302B119026
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 23:42:57 -0700 (PDT)
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.105])
        by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 785E126B9D;
        Mon, 11 Jul 2022 06:25:13 +0000 (UTC)
Received: from kaod.org (37.59.142.104) by DAG4EX2.mxp5.local (172.16.2.32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Mon, 11 Jul
 2022 08:25:12 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-104R005ebdefd4d-3105-4c10-b49d-0193a9ed4928,
                    B4A626E929F7F6A388BA3F96B07B1F4CEE71A9BF) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <6d019ed1-6408-aa58-4bb1-4d8a54be4878@kaod.org>
Date:   Mon, 11 Jul 2022 08:24:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] mtd: spi-nor: winbond: add support for W25Q512NW-IQ/IN
Content-Language: en-US
To:     Jae Hyun Yoo <quic_jaehyoo@quicinc.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>
CC:     Jamie Iles <quic_jiles@quicinc.com>,
        Graeme Gregory <quic_ggregory@quicinc.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220710145721.1207157-1-quic_jaehyoo@quicinc.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20220710145721.1207157-1-quic_jaehyoo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.104]
X-ClientProxiedBy: DAG8EX2.mxp5.local (172.16.2.72) To DAG4EX2.mxp5.local
 (172.16.2.32)
X-Ovh-Tracer-GUID: ee4a0401-b15c-4abf-aa5d-5a08f516980e
X-Ovh-Tracer-Id: 13999439444030819177
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudejvddguddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepkeffueekkeetueekhffhfeefudffleevhfegffduvdduieejjeduheehudfflefgnecuffhomhgrihhnpeifihhnsghonhgurdgtohhmnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehhedv
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/22 16:57, Jae Hyun Yoo wrote:
> Add support for Winbond W25Q512NW-IQ/IN
> 
> datasheet:
> https://www.winbond.com/resource-files/W25Q512NW%20RevB%2007192021.pdf
> 
> Test result on AST2600 SoC's SPI controller:
> $ cat /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/jedec_id
> ef6020
> 
> $ cat /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/manufacturer
> winbond
> 
> $ cat /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/partname
> w25q512nwq
> 
> $ hexdump /sys/bus/platform/devices/1e620000.spi/spi_master/spi0/spi0.1/spi-nor/sfdp
> 0000000 4653 5044 0106 ff01 0600 1001 0080 ff00
> 0000010 0084 0201 00d0 ff00 ffff ffff ffff ffff
> 0000020 ffff ffff ffff ffff ffff ffff ffff ffff
> *
> 0000080 20e5 fffb ffff 1fff eb44 6b08 3b08 bb42
> 0000090 fffe ffff ffff 0000 ffff eb40 200c 520f
> 00000a0 d810 0000 0233 00a6 e781 d914 63e9 3376
> 00000b0 757a 757a bdf7 5cd5 f719 ff5d 70e9 a5f9
> 00000c0 ffff ffff ffff ffff ffff ffff ffff ffff
> 00000d0 0aff fff0 ff21 ffdc
> 00000d8
> 
> Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>   drivers/mtd/spi-nor/winbond.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index ffaa24055259..d6f1a3b7267e 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -133,6 +133,9 @@ static const struct flash_info winbond_nor_parts[] = {
>   	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024)
>   		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_QUAD_READ |
>   			      SPI_NOR_DUAL_READ) },
> +	{ "w25q512nwq", INFO(0xef6020, 0, 64 * 1024, 1024)
> +		PARSE_SFDP
> +		OTP_INFO(256, 3, 0x1000, 0x1000) },
>   	{ "w25q512nwm", INFO(0xef8020, 0, 64 * 1024, 1024)
>   		PARSE_SFDP
>   		OTP_INFO(256, 3, 0x1000, 0x1000) },

