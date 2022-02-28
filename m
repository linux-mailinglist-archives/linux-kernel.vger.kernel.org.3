Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D00E4C6FBF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbiB1OoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbiB1On6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:43:58 -0500
Received: from 9.mo548.mail-out.ovh.net (9.mo548.mail-out.ovh.net [46.105.48.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660B2275D1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:43:19 -0800 (PST)
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.107])
        by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 050CE2339A;
        Mon, 28 Feb 2022 14:37:45 +0000 (UTC)
Received: from kaod.org (37.59.142.100) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 15:37:44 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-100R003a3ef605e-0c0a-4f25-99c2-225566a87550,
                    252894939833E8233A028C6995915A29C4CB1534) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <423d3bfa-c963-c765-fa65-700db9980804@kaod.org>
Date:   Mon, 28 Feb 2022 15:37:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 01/10] mtd: spi-nor: aspeed: Rename Kconfig option
Content-Language: en-US
To:     Joel Stanley <joel@jms.id.au>
CC:     Pratyush Yadav <p.yadav@ti.com>, <linux-spi@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220214094231.3753686-1-clg@kaod.org>
 <20220214094231.3753686-2-clg@kaod.org>
 <20220225073155.f2cxfhm7surf34d4@ti.com>
 <688b7a65-d4b6-682b-494a-1d4178699dba@kaod.org>
 <CACPK8XeCfLmEJSLV6q5BLpCVztzG3dZehCgqrjgrNr7LaOiReQ@mail.gmail.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CACPK8XeCfLmEJSLV6q5BLpCVztzG3dZehCgqrjgrNr7LaOiReQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: cd52e354-2258-48f9-a7dc-fd9434f95e6a
X-Ovh-Tracer-Id: 16012829951295261572
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddruddttddgieeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepieegvdffkeegfeetuddttddtveduiefhgeduffekiedtkeekteekhfffleevleelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/22 07:07, Joel Stanley wrote:
> On Sun, 27 Feb 2022 at 18:50, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> On 2/25/22 08:31, Pratyush Yadav wrote:
>>> On 14/02/22 10:42AM, Cédric Le Goater wrote:
>>>> To prepare transition to the new Aspeed SMC SPI controller driver using
>>>> the spi-mem interface, change the kernel CONFIG option of the current
>>>> driver to reflect that the implementation uses the MTD SPI-NOR interface.
>>>> Once the new driver is sufficiently exposed, we should remove the old one.
>>>
>>> I don't quite understand the reasoning behind this. Why keep the old
>>> driver around? Why not directly replace it with the new one? Does the
>>> new one have any limitations that this one doesn't?
>>
>> No. The old one has more limitations than the new one. The old one in
>> mainline is half baked since we could never merge the necessary bits
>> for training. We have been keeping a full version in the OpenBMC tree.
>>
>> Joel, could we simply drop the old driver in mainline and keep the old
>> one in the OpenBMC tree until we feel comfortable ? I guess we need
>> more testing.
> 
> I would answer Pratyush's question with: the old one is well tested,
> and the new one is not. We would intend to keep the old one around for
> a release cycle or two, and once we're confident the new one is stable
> we would remove the old.

yes but we could handle the transition in the OpenBMC tree without putting
the burden on mainline.
  
mainline would only have the newer spi-mem based driver, the OpenBMC tree
would have it also, along with the older SPI-NOR based driver.

So this patch renaming the Kconfig option would only apply to the OpenBMC
tree.

C.

