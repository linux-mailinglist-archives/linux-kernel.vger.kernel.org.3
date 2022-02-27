Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788B84C5E5B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 20:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiB0TDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 14:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiB0TDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 14:03:47 -0500
Received: from 9.mo552.mail-out.ovh.net (9.mo552.mail-out.ovh.net [87.98.180.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD81E12771
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 11:03:09 -0800 (PST)
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.17])
        by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 8335022D92;
        Sun, 27 Feb 2022 18:46:29 +0000 (UTC)
Received: from kaod.org (37.59.142.106) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 27 Feb
 2022 19:46:28 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-106R006071d4dc3-1d39-46b8-9114-493c988cf54f,
                    949565DF20DEE76D4A77FF7731A75FE8B07B1F6B) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <444bb236-b128-a429-c5d3-c28a73dd545a@kaod.org>
Date:   Sun, 27 Feb 2022 19:46:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 03/10] spi: spi-mem: Add driver for Aspeed SMC controllers
Content-Language: en-US
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-aspeed@lists.ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220214094231.3753686-1-clg@kaod.org>
 <20220214094231.3753686-4-clg@kaod.org>
 <20220225075007.73xypamm3zbjnkg6@ti.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20220225075007.73xypamm3zbjnkg6@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 2da4bcfc-1220-4029-9fee-d80abcb9560f
X-Ovh-Tracer-Id: 14340868590511819652
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrleekgdduudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepieegvdffkeegfeetuddttddtveduiefhgeduffekiedtkeekteekhfffleevleelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/22 08:50, Pratyush Yadav wrote:
> On 14/02/22 10:42AM, Cédric Le Goater wrote:
>> This SPI driver adds support for the Aspeed static memory controllers
>> of the AST2600, AST2500 and AST2400 SoCs using the spi-mem interface.
>>
>>   * AST2600 Firmware SPI Memory Controller (FMC)
>>     . BMC firmware
>>     . 3 chip select pins (CE0 ~ CE2)
>>     . Only supports SPI type flash memory
>>     . different segment register interface
>>     . single, dual and quad mode.
>>
>>   * AST2600 SPI Flash Controller (SPI1 and SPI2)
>>     . host firmware
>>     . 2 chip select pins (CE0 ~ CE1)
>>     . different segment register interface
>>     . single, dual and quad mode.
>>
>>   * AST2500 Firmware SPI Memory Controller (FMC)
>>     . BMC firmware
>>     . 3 chip select pins (CE0 ~ CE2)
>>     . supports SPI type flash memory (CE0-CE1)
>>     . CE2 can be of NOR type flash but this is not supported by the driver
>>     . single, dual mode.
>>
>>   * AST2500 SPI Flash Controller (SPI1 and SPI2)
>>     . host firmware
>>     . 2 chip select pins (CE0 ~ CE1)
>>     . single, dual mode.
>>
>>   * AST2400 New Static Memory Controller (also referred as FMC)
>>     . BMC firmware
>>     . New register set
>>     . 5 chip select pins (CE0 ∼ CE4)
>>     . supports NOR flash, NAND flash and SPI flash memory.
>>     . single, dual and quad mode.
>>
>> Each controller has a memory range on which flash devices contents are
>> mapped. Each device is assigned a window that can be changed at bootime
>> with the Segment Address Registers.
>>
>> Each SPI flash device can then be accessed in two modes: Command and
>> User. When in User mode, SPI transfers are initiated with accesses to
>> the memory segment of a device. When in Command mode, memory
>> operations on the memory segment of a device generate SPI commands
>> automatically using a Control Register for the settings.
>>
>> This initial patch adds support for User mode. Command mode needs a little
>> more work to check that the memory window on the AHB bus fits the device
>> size. It will come later when support for direct mapping is added.
>>
>> Single and dual mode RX transfers are supported. Other types than SPI
>> are not supported.
>>
>> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   drivers/spi/spi-aspeed-smc.c            | 766 ++++++++++++++++++++++++
>>   drivers/mtd/spi-nor/controllers/Kconfig |   2 +-
>>   drivers/spi/Kconfig                     |  11 +
>>   drivers/spi/Makefile                    |   1 +
>>   4 files changed, 779 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/spi/spi-aspeed-smc.c
>>
> [...]
>> +
>> +/* support for 1-1-1, 1-1-2 or 1-1-4 */
>> +static bool aspeed_spi_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
>> +{
>> +	if (op->cmd.buswidth > 1)
>> +		return false;
>> +
>> +	if (op->addr.nbytes != 0) {
>> +		if (op->addr.buswidth > 1 || op->addr.nbytes > 4)
>> +			return false;
>> +	}
>> +
>> +	if (op->dummy.nbytes != 0) {
>> +		if (op->dummy.buswidth > 1 || op->dummy.nbytes > 7)
>> +			return false;
>> +	}
>> +
>> +	if (op->data.nbytes != 0 && op->data.buswidth > 4)
>> +		return false;
>> +
>> +	if (!spi_mem_default_supports_op(mem, op))
>> +		return false;
>> +
>> +	return true;
> 
> Nitpick: You can just do return spi_mem_default_supports_op(mem, op);
> 
>> +}
>> +
> [...]
>> +
>> +static int aspeed_spi_init_devices(struct platform_device *pdev, struct aspeed_spi *aspi)
>> +{
>> +	struct device_node *np;
>> +	unsigned int cs;
>> +	int ret;
>> +
>> +	for_each_available_child_of_node(aspi->dev->of_node, np) {
>> +		struct aspeed_spi_chip *chip;
>> +
>> +		if (!of_device_is_compatible(np, "jedec,spi-nor"))
>> +			continue;
>> +
>> +		ret = of_property_read_u32(np, "reg", &cs);
>> +		if (ret) {
>> +			dev_err(aspi->dev, "Couldn't not read chip select.\n");
>> +			of_node_put(np);
>> +			return ret;
>> +		}
>> +
>> +		if (cs > aspi->data->max_cs) {
>> +			dev_err(aspi->dev, "Chip select %d out of range.\n", cs);
>> +			of_node_put(np);
>> +			return -ERANGE;
>> +		}
>> +
>> +		chip = &aspi->chips[cs];
>> +		chip->aspi = aspi;
>> +		chip->cs = cs;
>> +
>> +		ret = aspeed_spi_chip_init(chip);
>> +		if (ret) {
>> +			of_node_put(np);
>> +			return ret;
>> +		}
>> +
>> +		if (of_property_read_u32(np, "spi-max-frequency", &chip->clk_freq))
>> +			chip->clk_freq = ASPEED_SPI_DEFAULT_FREQ;
>> +
>> +		aspi->num_cs++;
>> +	}
> 
> SPI MEM already gives you all this information. Get it from there, don't
> parse it yourself.

I agree for spi-max-frequency". It's even redundant with the setting
done in :

   [PATCH 04/10] spi: aspeed: Add support for direct mapping

> You can get Chip Select via spi_mem->spi->chip_select.

yes but we are still in the probing sequence and some initial settings
need to be done for each device before accessing them. See routine
aspeed_spi_chip_init().

I think a spi setup hook could do that. I will change in v2.

> You can get clock frequency via spi_mem->spi->max_speed_hz.
>
> With these comments fixed,
> 
> Acked-by: Pratyush Yadav <p.yadav@ti.com>
Please recheck v2.

Thanks,

C.


> 
>> +
>> +	return 0;
>> +}
>> +
> [...]
> 

