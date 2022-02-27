Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA084C5EFD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 22:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiB0VNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 16:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiB0VNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 16:13:50 -0500
X-Greylist: delayed 383 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Feb 2022 13:13:12 PST
Received: from 7.mo552.mail-out.ovh.net (7.mo552.mail-out.ovh.net [188.165.59.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C38A2251B;
        Sun, 27 Feb 2022 13:13:11 -0800 (PST)
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.105])
        by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 44B8422DC0;
        Sun, 27 Feb 2022 21:06:46 +0000 (UTC)
Received: from kaod.org (37.59.142.96) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 27 Feb
 2022 22:06:45 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-96R00115e110f1-ecce-4d7f-bb2b-9bf0158c7309,
                    3C1F276A0880C75D3AA0293DFE804433F7F83470) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <ceace047-6d07-1ca3-c1ae-7137456975c5@kaod.org>
Date:   Sun, 27 Feb 2022 22:06:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 04/10] spi: aspeed: Add support for direct mapping
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
 <20220214094231.3753686-5-clg@kaod.org>
 <20220225091219.bv62jm3nehg4e4z4@ti.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20220225091219.bv62jm3nehg4e4z4@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG9EX2.mxp5.local (172.16.2.82) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 0b4b9ae5-d348-4927-88b8-76128bb7f478
X-Ovh-Tracer-Id: 16710043469378063236
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrleekgddugeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepkeeljeefveejheeihfegleegleduudeluedvffetudeigedvgfetveefteekteefnecuffhomhgrihhnpegsuhhfrdhinhenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/22 10:12, Pratyush Yadav wrote:
> On 14/02/22 10:42AM, Cédric Le Goater wrote:
>> Use direct mapping to read the flash device contents. This operation
>> mode is called "Command mode" on Aspeed SoC SMC controllers. It uses a
>> Control Register for the settings to apply when a memory operation is
>> performed on the flash device mapping window.
>>
>> If the window is not big enough, fall back to the "User mode" to
>> perform the read.
>>
>> Direct mapping for writes will come later when validated.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   drivers/spi/spi-aspeed-smc.c | 67 ++++++++++++++++++++++++++++++++++--
>>   1 file changed, 65 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
>> index 0aeff6f468af..8d33fcb7736a 100644
>> --- a/drivers/spi/spi-aspeed-smc.c
>> +++ b/drivers/spi/spi-aspeed-smc.c
>> @@ -345,8 +345,8 @@ static int do_aspeed_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
>>   		if (!op->addr.nbytes)
>>   			ret = aspeed_spi_read_reg(chip, op);
>>   		else
>> -			ret = aspeed_spi_read_user(chip, op, op->addr.val,
>> -						   op->data.nbytes, op->data.buf.in);
>> +			memcpy_fromio(op->data.buf.in, chip->ahb_base + op->addr.val,
>> +				      op->data.nbytes);
> 
> Why change this? exec_op should be independent from dirmap APIs. And you
> don't even do the ahb_window_size checks here.

no indeed. Now that direct map is configured, all reads of flash contents
should go through the direct map op. This is mostly for the RDSFDP command
which has a different address space and uses 3B.

Theoretically, we should be able to use memcpy_fromio() and memcpy_toio()
for all commands but not all controllers (6 of them) support this mode.

Thanks,

C.


> 
>>   	} else {
>>   		if (!op->addr.nbytes)
>>   			ret = aspeed_spi_write_reg(chip, op);
>> @@ -426,10 +426,73 @@ static int aspeed_spi_chip_set_default_window(struct aspeed_spi_chip *chip)
>>   	return chip->ahb_window_size ? 0 : -1;
>>   }
>>   
>> +static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
>> +{
>> +	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
>> +	struct aspeed_spi_chip *chip = &aspi->chips[desc->mem->spi->chip_select];
>> +	struct spi_mem_op *op = &desc->info.op_tmpl;
>> +	u32 ctl_val;
>> +	int ret = 0;
>> +
>> +	chip->clk_freq = desc->mem->spi->max_speed_hz;
>> +
>> +	/* Only for reads */
>> +	if (op->data.dir != SPI_MEM_DATA_IN)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (desc->info.length > chip->ahb_window_size)
>> +		dev_warn(aspi->dev, "CE%d window (%dMB) too small for mapping",
>> +			 chip->cs, chip->ahb_window_size >> 20);
>> +
>> +	/* Define the default IO read settings */
>> +	ctl_val = readl(chip->ctl) & ~CTRL_IO_CMD_MASK;
>> +	ctl_val |= aspeed_spi_get_io_mode(op) |
>> +		op->cmd.opcode << CTRL_COMMAND_SHIFT |
>> +		CTRL_IO_DUMMY_SET(op->dummy.nbytes / op->dummy.buswidth) |
>> +		CTRL_IO_MODE_READ;
>> +
>> +	/* Tune 4BYTE address mode */
>> +	if (op->addr.nbytes) {
>> +		u32 addr_mode = readl(aspi->regs + CE_CTRL_REG);
>> +
>> +		if (op->addr.nbytes == 4)
>> +			addr_mode |= (0x11 << chip->cs);
>> +		else
>> +			addr_mode &= ~(0x11 << chip->cs);
>> +		writel(addr_mode, aspi->regs + CE_CTRL_REG);
>> +	}
>> +
>> +	/* READ mode is the controller default setting */
>> +	chip->ctl_val[ASPEED_SPI_READ] = ctl_val;
>> +	writel(chip->ctl_val[ASPEED_SPI_READ], chip->ctl);
>> +
>> +	dev_info(aspi->dev, "CE%d read buswidth:%d [0x%08x]\n",
>> +		 chip->cs, op->data.buswidth, chip->ctl_val[ASPEED_SPI_READ]);
>> +
>> +	return ret;
>> +}
>> +
>> +static int aspeed_spi_dirmap_read(struct spi_mem_dirmap_desc *desc,
>> +				  u64 offset, size_t len, void *buf)
>> +{
>> +	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
>> +	struct aspeed_spi_chip *chip = &aspi->chips[desc->mem->spi->chip_select];
>> +
>> +	/* Switch to USER command mode if mapping window is too small */
>> +	if (chip->ahb_window_size < offset + len)
>> +		aspeed_spi_read_user(chip, &desc->info.op_tmpl, offset, len, buf);
>> +	else
>> +		memcpy_fromio(buf, chip->ahb_base + offset, len);
>> +
>> +	return len;
>> +}
>> +
>>   static const struct spi_controller_mem_ops aspeed_spi_mem_ops = {
>>   	.supports_op = aspeed_spi_supports_op,
>>   	.exec_op = aspeed_spi_exec_op,
>>   	.get_name = aspeed_spi_get_name,
>> +	.dirmap_create = aspeed_spi_dirmap_create,
>> +	.dirmap_read = aspeed_spi_dirmap_read,
>>   };
>>   
>>   static void aspeed_spi_chip_set_type(struct aspeed_spi_chip *chip, int type)
>> -- 
>> 2.34.1
>>
> 

