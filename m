Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062E95AFDC4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiIGHnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiIGHnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:43:18 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503019E0FF;
        Wed,  7 Sep 2022 00:43:17 -0700 (PDT)
Received: from [10.28.39.72] (10.28.39.72) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server id 15.1.2507.6; Wed, 7 Sep 2022 15:43:14 +0800
Message-ID: <ea0dda97-2f53-0a3f-6168-18b20a4095c0@amlogic.com>
Date:   Wed, 7 Sep 2022 15:43:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH RESEND v8 4/5] dt-bindings: nand: meson: convert txt to
 yaml
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        <linux-kernel@vger.kernel.org>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <devicetree@vger.kernel.org>, YongHui Yu <yonghui.yu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220906060034.2528-1-liang.yang@amlogic.com>
 <20220906060034.2528-5-liang.yang@amlogic.com>
 <1662471645.297810.360952.nullmailer@robh.at.kernel.org>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <1662471645.297810.360952.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.39.72]
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

I reproduce this error and will fix it next version.

Thanks.

On 2022/9/6 21:40, Rob Herring wrote:
> [ EXTERNAL EMAIL ]
> 
> On Tue, 06 Sep 2022 14:00:32 +0800, Liang Yang wrote:
>> convert the amlogic,meson-name.txt to amlogic,meson-nand.yaml
>>
>> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
>> ---
>>   .../bindings/mtd/amlogic,meson-nand.txt       | 55 ------------
>>   .../bindings/mtd/amlogic,meson-nand.yaml      | 88 +++++++++++++++++++
>>   2 files changed, 88 insertions(+), 55 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
>>   create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.example.dtb: nand-controller@ffe07800: Unevaluated properties are not allowed ('reg-names' was unexpected)
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> 
> doc reference errors (make refcheckdocs):
> MAINTAINERS: Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 
> .
