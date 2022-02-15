Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766B54B6AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiBOLYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:24:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbiBOLYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:24:31 -0500
X-Greylist: delayed 8182 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 03:24:20 PST
Received: from 9.mo548.mail-out.ovh.net (9.mo548.mail-out.ovh.net [46.105.48.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9EE1081BC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 03:24:20 -0800 (PST)
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.11])
        by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 8335821EFF;
        Tue, 15 Feb 2022 09:07:53 +0000 (UTC)
Received: from kaod.org (37.59.142.98) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 10:07:52 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-98R002b27b64c4-57a5-44f9-a47c-4a83fe5690ca,
                    2487B4E7026A90D95ED29794538901B35B4D209A) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <76c3f352-a0fc-f72f-e66e-594f9249cb8c@kaod.org>
Date:   Tue, 15 Feb 2022 10:07:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 03/10] spi: spi-mem: Add driver for Aspeed SMC controllers
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
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
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220214094231.3753686-1-clg@kaod.org>
 <20220214094231.3753686-4-clg@kaod.org> <20220215062743.GA12431@wunner.de>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20220215062743.GA12431@wunner.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG6EX1.mxp5.local (172.16.2.51) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 4e02782a-965d-4bc5-8fe7-6f59370c6abd
X-Ovh-Tracer-Id: 7883832626687085383
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrjeefgdduvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepieegvdffkeegfeetuddttddtveduiefhgeduffekiedtkeekteekhfffleevleelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lukas,

On 2/15/22 07:27, Lukas Wunner wrote:
> On Mon, Feb 14, 2022 at 10:42:24AM +0100, Cédric Le Goater wrote:
>> +static int aspeed_spi_probe(struct platform_device *pdev)
>> +{
> [...]
>> +	ctlr = spi_alloc_master(dev, sizeof(*aspi));
>> +	if (!ctlr)
>> +		return -ENOMEM;
> 
> Use devm_spi_alloc_master() and remove the "put_controller" error path
> for simplicity.
  
yes.

>> +	ret = devm_spi_register_controller(dev, ctlr);
> [...]
>> +static int aspeed_spi_remove(struct platform_device *pdev)
>> +{
>> +	struct spi_controller *ctlr = platform_get_drvdata(pdev);
>> +	struct aspeed_spi *aspi = spi_controller_get_devdata(ctlr);
>> +
>> +	aspeed_spi_enable(aspi, false);
>> +	spi_unregister_controller(ctlr);
>> +	clk_disable_unprepare(aspi->clk);
>> +	return 0;
>> +}
> 
> You need to move the call to spi_unregister_controller() *before*
> the call to aspeed_spi_enable().  The controller must be fully
> operational until spi_unregister_controller() returns.
> 
> You also need to replace the call to devm_spi_register_controller()
> in aspeed_spi_probe() with spi_register_controller().
> Otherwise you'll unregister the controller twice because you're
> calling spi_unregister_controller() in aspeed_spi_remove().

ok. Understood. Done in v2.

Thanks,

C.

