Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA1051EC10
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 09:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiEHH0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 03:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiEHH0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 03:26:07 -0400
Received: from 6.mo548.mail-out.ovh.net (6.mo548.mail-out.ovh.net [188.165.58.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACDEE096
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 00:22:17 -0700 (PDT)
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.7])
        by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 5870E22521;
        Sun,  8 May 2022 07:14:55 +0000 (UTC)
Received: from kaod.org (37.59.142.108) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Sun, 8 May 2022
 09:14:53 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-108S002fbf65d7b-541b-4859-a882-6af3346e7bf3,
                    6A42E68C8A7CF0A161EF91BD72A2EC4D9931BD41) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 86.250.26.110
Message-ID: <4af36c47-0895-bce4-b074-c934749e6faf@kaod.org>
Date:   Sun, 8 May 2022 09:14:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v6 03/11] spi: spi-mem: Convert Aspeed SMC driver to
 spi-mem
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-aspeed@lists.ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tao Ren <rentao.bupt@gmail.com>,
        Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
References: <20220503060634.122722-1-clg@kaod.org>
 <20220503060634.122722-4-clg@kaod.org> <YnFseFBfe5eaIqg0@robh.at.kernel.org>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <YnFseFBfe5eaIqg0@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.108]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: eb910b0c-0e8b-44c4-8db7-9c6365255b15
X-Ovh-Tracer-Id: 7921550270037658570
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeigdduudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeekteejtdelkeejvdevffduhfetteelieefgeefffeugffhfeekheffueefledujeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehquhhitggpjhgrvghhhihoohesqhhuihgtihhntgdrtghomh
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/22 19:55, Rob Herring wrote:
> On Tue, May 03, 2022 at 08:06:26AM +0200, Cédric Le Goater wrote:
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
>> Tested-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
>> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   drivers/mtd/spi-nor/controllers/aspeed-smc.c  | 921 ------------------
>>   drivers/spi/spi-aspeed-smc.c                  | 717 ++++++++++++++
>>   .../devicetree/bindings/mtd/aspeed-smc.txt    |  51 -
> 
> This belongs with the binding patch. But then it is converting rather
> than adding a binding. You should be converting the binding and then
> adding to it (like adding 2600 support).

OK.

So, I will send, some time next week, a v7 patchset updating the binding
patch 02/11 to include the removal of the old binding.

Thanks,

C.

> 
>>   MAINTAINERS                                   |   1 +
>>   drivers/mtd/spi-nor/controllers/Kconfig       |  10 -
>>   drivers/mtd/spi-nor/controllers/Makefile      |   1 -
>>   drivers/spi/Kconfig                           |  11 +
>>   drivers/spi/Makefile                          |   1 +
>>   8 files changed, 730 insertions(+), 983 deletions(-)
>>   delete mode 100644 drivers/mtd/spi-nor/controllers/aspeed-smc.c
>>   create mode 100644 drivers/spi/spi-aspeed-smc.c
>>   delete mode 100644 Documentation/devicetree/bindings/mtd/aspeed-smc.txt

