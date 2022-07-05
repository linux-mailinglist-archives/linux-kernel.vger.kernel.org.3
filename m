Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B407856667B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiGEJq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiGEJqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:46:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DC4D6C;
        Tue,  5 Jul 2022 02:46:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DAB66190D;
        Tue,  5 Jul 2022 09:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51D3C341CD;
        Tue,  5 Jul 2022 09:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014411;
        bh=I3JxnK9mzNlfq3QSj73KfJmk+72j39RkmG1N22D+EEc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=svQLVRPiYTDWaDFlSeRSHAGkGSTlwdZ+RsJv8UOSSXAfcZWlnm2CgvYEplI1c+ULs
         3abx6Rp+/Xs6TcwU72t2Pr+I5uqzF0GlAwCOYf9QddM0Z4PPaICLFgXExMj17T1Fax
         anO3CU9s4PG7vcjthtJI26goDO2F18I4MAage4E6+9UbkES0xxJoLDMKhGLKwmAU4L
         onViqlGL8k+yBIQ0unMeqmhMZcObPv5cMmQSKQBjK3W959v6TE5M7SPdbJhpG45Pbv
         T61CFKM8fN213scnSncczoFOjk3XaJJ/oInMCuDkOKLRCe04NrlyQ3LDBNTieZZUW4
         15hPCIgR+Q6Ww==
Message-ID: <c945d724-bc18-071e-2c84-d3af39127fc0@kernel.org>
Date:   Tue, 5 Jul 2022 11:46:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 06/15] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
Content-Language: en-US
To:     Brad Larson <brad@pensando.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, blarson@amd.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gabriel Somlo <gsomlo@gmail.com>, gerg@linux-m68k.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>, samuel@sholland.org,
        Serge Semin <fancer.lancer@gmail.com>,
        suravee.suthikulpanit@amd.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20220613195658.5607-1-brad@pensando.io>
 <20220613195658.5607-7-brad@pensando.io>
 <b42b197f-2b11-cb6e-458a-ed12b2eb997d@linaro.org>
 <CAK9rFnwj0c5fuWk8TxxX_RBXDCBpEa8f-rh3V13BN_j_U7Fo7w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CAK9rFnwj0c5fuWk8TxxX_RBXDCBpEa8f-rh3V13BN_j_U7Fo7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2022 01:41, Brad Larson wrote:
> Hi Krzysztof,
> 
> On Mon, Jun 20, 2022 at 5:56 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 13/06/2022 21:56, Brad Larson wrote:
>>> From: Brad Larson <blarson@amd.com>
>>>
>>> Add support for the AMD Pensando Elba SoC System Resource chip
>>> using the SPI interface.  The Elba SR is a Multi-function Device
>>> supporting device register access using CS0, smbus interface for
>>> FRU and board peripherals using CS1, dual Lattice I2C masters for
>>> transceiver management using CS2, and CS3 for flash access.
>>>
>>> Signed-off-by: Brad Larson <blarson@amd.com>
>>> ---
>>>  .../bindings/mfd/amd,pensando-elbasr.yaml     | 93 +++++++++++++++++++
>>>  1 file changed, 93 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
>> ...
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/reset/amd,pensando-elba-reset.h>
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +
>>> +    spi0 {
>>
>> Just "spi"
> 
> Changed to spi
> 
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +        num-cs = <4>;
>>> +
>>> +        spi@0 {
>>
>> "spi" is for SPI controllers. Use generic name matching the device.
>> Usually this is "system-controller", however Rob pointed out your
>> inaccurate bindings and example.
> 
> Proposed the below change node in the reply to Rob.  The model I
> followed for this was the Altera mfd/altera-a10sr.c

You pointed driver, so how is it related to bindings? Do not mix Linux
implementation with the bindings.

> 
> spi@0 {
>         sr_regs@0 {
>                 rstc: reset-controller@0 {

No underscores in node names. sr_regs is not generic name.

> 
>         dw_i2c@1 {

Again, not a generic name. If it is i2c controller, should be i2c. If it
is i2c device/client, should be something generic matching class of the
device.

> 
>         lattice_i2c@2 {
> 
>         flash@3 {

This looks ok, depending on compatible.

> 
> Regards,
> Brad


Best regards,
Krzysztof
