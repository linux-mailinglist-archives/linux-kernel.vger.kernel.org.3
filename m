Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5D557F27E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 03:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239456AbiGXB0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 21:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238147AbiGXBZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 21:25:58 -0400
Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087311183D;
        Sat, 23 Jul 2022 18:25:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09236334|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.030501-0.019971-0.949528;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=23;RT=23;SR=0;TI=SMTPD_---.Oc.dXjP_1658625951;
Received: from 192.168.10.152(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Oc.dXjP_1658625951)
          by smtp.aliyun-inc.com;
          Sun, 24 Jul 2022 09:25:52 +0800
Subject: Re: [PATCH 0/3] Add SFC support for Ingenic SoCs.
To:     Tomasz Maciej Nowak <tmn505@gmail.com>,
        tudor.ambarus@microchip.com, p.yadav@ti.com, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aidanmacdonald.0x0@gmail.com,
        paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        jinghui.liu@ingenic.com, sernia.zhou@foxmail.com,
        reimu@sudomaker.com
References: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
 <e700eecf-e7e0-c2e7-9e20-b5d20df4b65f@gmail.com>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <36084c97-b675-1400-52da-f74bf4b61930@wanyeetech.com>
Date:   Sun, 24 Jul 2022 09:25:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e700eecf-e7e0-c2e7-9e20-b5d20df4b65f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On 2022/7/23 下午10:47, Tomasz Maciej Nowak wrote:
> W dniu 22.07.2022 o 18:48, 周琰杰 (Zhou Yanjie) pisze:
>> 1.Use the spi-mem poll status APIs in SPI-NOR to reduce CPU load.
>> 2.Add SFC support for the X1000 SoC, the X1600 SoC, and the X2000 SoC from Ingenic.
>>
>> Liu Jinghui and Aidan MacDonald provided a lot of assistance during the development of this driver.
>>
>> 周琰杰 (Zhou Yanjie) (3):
>>    mtd: spi-nor: Use the spi-mem poll status APIs.
>>    dt-bindings: SPI: Add Ingenic SFC bindings.
>>    SPI: Ingenic: Add SFC support for Ingenic SoCs.
>>
>>   .../devicetree/bindings/spi/ingenic,sfc.yaml       |  64 ++
>>   drivers/mtd/spi-nor/core.c                         |  42 +-
>>   drivers/spi/Kconfig                                |   9 +
>>   drivers/spi/Makefile                               |   1 +
>>   drivers/spi/spi-ingenic-sfc.c                      | 662 +++++++++++++++++++++
>>   5 files changed, 768 insertions(+), 10 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/spi/ingenic,sfc.yaml
>>   create mode 100755 drivers/spi/spi-ingenic-sfc.c
>>
> Even tough it's still early in revision process, I'll add my
> Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
>
> The test was performed with Damai DM6291A SoC which is a Ingenic X1000 IP
> but with 256 MiB RAM. No bugs yet observed on my side.


Thanks for you test!


>
