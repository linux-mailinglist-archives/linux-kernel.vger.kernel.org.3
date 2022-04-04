Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382DE4F0FF7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377659AbiDDH0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 03:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238908AbiDDH0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:26:38 -0400
Received: from 9.mo552.mail-out.ovh.net (9.mo552.mail-out.ovh.net [87.98.180.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D033616C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 00:24:40 -0700 (PDT)
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.93])
        by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 74BD722AA4;
        Mon,  4 Apr 2022 07:07:09 +0000 (UTC)
Received: from kaod.org (37.59.142.102) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 09:07:08 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-102R0043f1c04d9-24e1-4a64-8174-b0226c23ff7b,
                    193BEDB8EED17CFBFC1316EE01F9191BF107EB6B) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <3b7ecaa4-1de9-3a4c-b057-805a5e6d2e48@kaod.org>
Date:   Mon, 4 Apr 2022 09:06:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 03/11] spi: spi-mem: Convert Aspeed SMC driver to
 spi-mem
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
        <linux-kernel@vger.kernel.org>, Tao Ren <rentao.bupt@gmail.com>
References: <20220325100849.2019209-1-clg@kaod.org>
 <20220325100849.2019209-4-clg@kaod.org>
 <20220330193343.qg5kcr6twerde6ho@ti.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20220330193343.qg5kcr6twerde6ho@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.102]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: e382a813-ab73-414e-b3c8-ba9556f6581c
X-Ovh-Tracer-Id: 11032974666386082631
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejuddguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeekleejfeevjeehiefhgeelgeeludduleeuvdffteduieegvdfgteevfeetkeetfeenucffohhmrghinhepsghufhdrihhnnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheprhgvnhhtrghordgsuhhpthesghhmrghilhdrtghomh
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 21:33, Pratyush Yadav wrote:
> Hi Cedric,
> 
> Thanks for doing the conversion.
> 
> On 25/03/22 11:08AM, Cédric Le Goater wrote:
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
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>> Tested-by: Joel Stanley <joel@jms.id.au>
>> Tested-by: Tao Ren <rentao.bupt@gmail.com>
>> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   drivers/mtd/spi-nor/controllers/aspeed-smc.c  | 910 ------------------
>>   drivers/spi/spi-aspeed-smc.c                  | 709 ++++++++++++++
>>   .../devicetree/bindings/mtd/aspeed-smc.txt    |  51 -
>>   MAINTAINERS                                   |   1 +
>>   drivers/mtd/spi-nor/controllers/Kconfig       |  10 -
>>   drivers/mtd/spi-nor/controllers/Makefile      |   1 -
>>   drivers/spi/Kconfig                           |  11 +
>>   drivers/spi/Makefile                          |   1 +
>>   8 files changed, 722 insertions(+), 972 deletions(-)
>>   delete mode 100644 drivers/mtd/spi-nor/controllers/aspeed-smc.c
>>   create mode 100644 drivers/spi/spi-aspeed-smc.c
>>   delete mode 100644 Documentation/devicetree/bindings/mtd/aspeed-smc.txt
>>
> [...]
>> +static void aspeed_spi_send_cmd_addr(struct aspeed_spi_chip *chip, u8 addr_nbytes,
>> +				     u64 offset, u32 opcode)
>> +{
>> +	struct aspeed_spi *aspi = chip->aspi;
>> +	__be32 temp;
>> +	u32 cmdaddr;
>> +
>> +	switch (addr_nbytes) {
>> +	default:
>> +		dev_warn_once(aspi->dev, "Unexpected address width %u, defaulting to 3",
>> +			      addr_nbytes);
>> +		fallthrough;
> 
> I think it is better if you reject ops where addr width is not 3 or 4.
> This you can drop this. Or if you really want to keep it, you can change
> it to a WARN_ON() and return an error.

OK. This is a left over from the initial driver.

I have added both at WARN_ONCE() and a 'return -EOPNOTSUPP'

>> +	case 3:
>> +		cmdaddr = offset & 0xFFFFFF;
>> +		cmdaddr |= opcode << 24;
>> +
>> +		temp = cpu_to_be32(cmdaddr);
>> +		aspeed_spi_write_to_ahb(chip->ahb_base, &temp, 4);
>> +		break;
>> +	case 4:
>> +		temp = cpu_to_be32(offset);
>> +		aspeed_spi_write_to_ahb(chip->ahb_base, &opcode, 1);
>> +		aspeed_spi_write_to_ahb(chip->ahb_base, &temp, 4);
>> +		break;
>> +	}
>> +}
>> +
> [...]
>> +/* support for 1-1-1, 1-1-2 or 1-1-4 */
>> +static bool aspeed_spi_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
>> +{
>> +	if (op->cmd.buswidth > 1)
>> +		return false;
>> +
>> +	if (op->addr.nbytes != 0) {
>> +		if (op->addr.buswidth > 1 || op->addr.nbytes > 4)
> 
> As mentioned above, this should reject ops with addr width 1 and 2.

yes

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
>> +	return spi_mem_default_supports_op(mem, op);
>> +}
>> +
>> +static int do_aspeed_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>> +{
>> +	struct aspeed_spi *aspi = spi_controller_get_devdata(mem->spi->master);
>> +	struct aspeed_spi_chip *chip = &aspi->chips[mem->spi->chip_select];
>> +	u32 addr_mode, addr_mode_backup;
>> +	u32 ctl_val;
>> +	int ret = 0;
>> +
>> +	dev_dbg(aspi->dev,
>> +		"CE%d %s OP %#x mode:%d.%d.%d.%d naddr:%#x ndummies:%#x len:%#x",
>> +		chip->cs, op->data.dir == SPI_MEM_DATA_IN ? "read" : "write",
>> +		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
>> +		op->dummy.buswidth, op->data.buswidth,
>> +		op->addr.nbytes, op->dummy.nbytes, op->data.nbytes);
>> +
>> +	addr_mode = readl(aspi->regs + CE_CTRL_REG);
>> +	addr_mode_backup = addr_mode;
>> +
>> +	ctl_val = chip->ctl_val[ASPEED_SPI_BASE];
>> +	ctl_val &= ~CTRL_IO_CMD_MASK;
>> +
>> +	ctl_val |= op->cmd.opcode << CTRL_COMMAND_SHIFT;
>> +
>> +	/* 4BYTE address mode */
>> +	if (op->addr.nbytes) {
>> +		if (op->addr.nbytes == 4)
>> +			addr_mode |= (0x11 << chip->cs);
>> +		else
>> +			addr_mode &= ~(0x11 << chip->cs);
>> +	}
>> +
>> +	if (op->dummy.buswidth && op->dummy.nbytes)
> 
> Nitpick: op->dummy.nbytes being set should imply op->dummy.buswidth > 0.
> 
>> +		ctl_val |= CTRL_IO_DUMMY_SET(op->dummy.nbytes / op->dummy.buswidth);
>> +
>> +	if (op->data.nbytes != 0) {
>> +		if (op->data.buswidth)
> 
> Nitpick: op->data.nbytes != 0 should imply op->data.buswidth > 0.

Indeed. Fixed both.

>> +			ctl_val |= aspeed_spi_get_io_mode(op);
>> +	}
>> +
>> +	if (op->data.dir == SPI_MEM_DATA_OUT)
>> +		ctl_val |= CTRL_IO_MODE_WRITE;
>> +	else
>> +		ctl_val |= CTRL_IO_MODE_READ;
>> +
>> +	if (addr_mode != addr_mode_backup)
>> +		writel(addr_mode, aspi->regs + CE_CTRL_REG);
>> +	writel(ctl_val, chip->ctl);
>> +
>> +	if (op->data.dir == SPI_MEM_DATA_IN) {
>> +		if (!op->addr.nbytes)
>> +			ret = aspeed_spi_read_reg(chip, op);
>> +		else
>> +			ret = aspeed_spi_read_user(chip, op, op->addr.val,
>> +						   op->data.nbytes, op->data.buf.in);
>> +	} else {
>> +		if (!op->addr.nbytes)
>> +			ret = aspeed_spi_write_reg(chip, op);
>> +		else
>> +			ret = aspeed_spi_write_user(chip, op);
>> +	}
>> +
>> +	/* Restore defaults */
>> +	if (addr_mode != addr_mode_backup)
>> +		writel(addr_mode_backup, aspi->regs + CE_CTRL_REG);
>> +	writel(chip->ctl_val[ASPEED_SPI_READ], chip->ctl);
> 
> Why do you need to restore defaults here? Do you expect some other piece
> of software to use it as well?

We expect the controller to be correctly set when dirmap_read() is called.
But it is only required in the next patch.

> 
> The patch looks good to me apart from these.


Thanks,

C.



> 
>> +	return ret;
>> +}
>> +
> [...]
> 

