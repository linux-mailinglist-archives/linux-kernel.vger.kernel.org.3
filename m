Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7ABE5524CB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 21:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244876AbiFTTql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 15:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240882AbiFTTqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 15:46:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FA11CFEE;
        Mon, 20 Jun 2022 12:46:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC6B4B811ED;
        Mon, 20 Jun 2022 19:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FC8C3411B;
        Mon, 20 Jun 2022 19:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655754395;
        bh=WBlrQOF2Ubv6PuDT7vYdmC3avEXgN25cye/amsESNc4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tD4J5wMegooFpBts2stBtVFy4+04atCSz//OsQt9o7i5sPlYwPlhGsGoIMtxYgrfQ
         rhJ1zY6Mlc+DSawgxuBY6REpl6tOhVtQtVFSHLp7+6EZxHFWClotZHDz6con+ldrnE
         Dh359N2vPPmanBITBnOugAu1XpkkJYvcFGyJOfS8TUYlR3hOk7x1Mpw0AgDyPC0lbO
         8RjwU99yeCVqfdpeNst3Gfj/VvFZOCDDt1acNugVte4Tm0sE7lpBdE+BFZeUK0Eo72
         MOebacLZLnTUFOMVAmD8iZ3O51LGHROVxFdjYgPuKpus/rvGXnVu+pzzWqLqjQXieX
         qAwbwY6+QTfIg==
Message-ID: <0a68aa72-df85-cf78-dcca-2d75038234c6@kernel.org>
Date:   Mon, 20 Jun 2022 21:46:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 04/15] dt-bindings: spi: dw: Add AMD Pensando Elba SoC
 SPI Controller bindings
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>,
        Brad Larson <brad@pensando.io>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        broonie@kernel.org, yamada.masahiro@socionext.com,
        p.zabel@pengutronix.de, piotrs@cadence.com, p.yadav@ti.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
References: <20220613195658.5607-1-brad@pensando.io>
 <20220613195658.5607-5-brad@pensando.io>
 <20220620193044.ihxfn6kddif7j5la@mobilestation>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220620193044.ihxfn6kddif7j5la@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2022 21:30, Serge Semin wrote:
> On Mon, Jun 13, 2022 at 12:56:47PM -0700, Brad Larson wrote:
>> From: Brad Larson <blarson@amd.com>
>>
>> The AMD Pensando Elba SoC has integrated the DW APB SPI Controller
>>
>> Signed-off-by: Brad Larson <blarson@amd.com>
>> ---
>>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>> index e25d44c218f2..2a55b947cffc 100644
>> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
>> @@ -73,6 +73,8 @@ properties:
>>                - renesas,r9a06g032-spi # RZ/N1D
>>                - renesas,r9a06g033-spi # RZ/N1S
>>            - const: renesas,rzn1-spi   # RZ/N1
> 
>> +      - description: AMD Pensando Elba SoC SPI Controller
>> +        const: amd,pensando-elba-spi
> 
> Not enough. The driver requires to have a phandle reference to the
> Pensando System Controller. So the property like
> "amd,pensando-elba-syscon" is also needed to be added to the DT schema
> otherwise should the dt-schema tool correctly handle the
> "unevaluatedProperties: false" setting (Rob says it isn't fully
> supported at the moment), the dtbs_check procedure will fail on your
> dts evaluation.

The property was here before, now removed, so I assume it was also
removed from the driver and DTS. Isn't that the case?

Otherwise this is incomplete binding...

Best regards,
Krzysztof
