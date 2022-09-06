Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C715AF041
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbiIFQUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiIFQT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:19:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F3D326DA;
        Tue,  6 Sep 2022 08:49:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1F49B818C2;
        Tue,  6 Sep 2022 15:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603B1C433D6;
        Tue,  6 Sep 2022 15:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662479354;
        bh=HyOzm5VMGmYJGCUZJSGax0V3uAmkTmNzZyIR1FAA+RQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OB6QEsUCynTHvPxAqfPNLKgNfjrOnGNuCsjcCMghiOVfEjqklmu+JjF1pE6s740tR
         o73CbEg5qg4GocYd4ffIXKqn2Vn374C0VE8irVivL//j0IM8oXHcQzfyzS4ff7zLTn
         0SF6aY/qx6kzV0f8dBPG8p9iYJiu272Hw8LCBiPwZWHLjQ4tFH2Ysv6JOROT/tfRi9
         LsFO2D59VxPZo7JsdEkoJMXCQ82H2gPyFjaiTftXzSBGdw0oL1DIUoIfeoZq7lRk91
         7Teieml4YBhcnYEPOdflYkLXh+krGUQfR9276k2zwRoLAzAVEYpig0v2XAA/PtLHWV
         EpC+kNT2h9nNw==
Date:   Tue, 6 Sep 2022 16:49:03 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sergiu.Moga@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        admin@hifiphile.com, Kavyasree.Kotagiri@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: mfd: atmel,at91-usart: convert to
 json-schema
Message-ID: <Yxdr76d2KVdUDfpW@google.com>
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
 <20220817075517.49575-3-sergiu.moga@microchip.com>
 <942accc5-70aa-3bb2-63dd-306a39ee5ea4@linaro.org>
 <d1aad8ea-3852-f36b-366b-7aa67d2dd9d5@microchip.com>
 <YxYI8/bprIV2wd1c@google.com>
 <d6a498e7-838b-addf-bc7f-81e6805806d3@microchip.com>
 <80abf192-0313-aade-7780-604f4c9c6810@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80abf192-0313-aade-7780-604f4c9c6810@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Sep 2022, Krzysztof Kozlowski wrote:

> On 05/09/2022 17:22, Sergiu.Moga@microchip.com wrote:
> > On 05.09.2022 17:37, Lee Jones wrote:
> >>
> >> On Fri, 19 Aug 2022, Sergiu.Moga@microchip.com wrote:
> >>
> >>> On 18.08.2022 11:39, Krzysztof Kozlowski wrote:
> >>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>>
> >>>> On 17/08/2022 10:55, Sergiu Moga wrote:
> >>>>> Convert at91 USART DT Binding for Atmel/Microchip SoCs to
> >>>>> json-schema format.
> >>>>>
> >>>>> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> >>>>> ---
> >>>>>    .../bindings/mfd/atmel,at91-usart.yaml        | 190 ++++++++++++++++++
> >>>>>    .../devicetree/bindings/mfd/atmel-usart.txt   |  98 ---------
> >>>>>    2 files changed, 190 insertions(+), 98 deletions(-)
> >>>>>    create mode 100644 Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
> >>>>>    delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-usart.txt
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
> >>>>> new file mode 100644
> >>>>> index 000000000000..cf15d73fa1e8
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
> >>>> One more thing - I think this should be in serial directory, not mfd,
> >>>> even though it includes SPI. MFD is just a Linux naming/wrapper device.
> >>>>
> >>>> Best regards,
> >>>> Krzysztof
> >>>
> >>> I would rather keep it in this directory, since its corresponding driver
> >>> is also in the mfd directory.
> >>
> >> Looks like a UART driver to me.
> >>
> >> Which MFD driver does this pertain to?
> >>
> > 
> > Hi,
> > 
> > It's this one: drivers/mfd/at91-usart.c[1]
> > 
> > 
> > [1] 
> > https://elixir.bootlin.com/linux/v6.0-rc4/source/drivers/mfd/at91-usart.c
> 
> Which is not a "real MFD driver" because it probes exactly one child
> (depending on the chosen serial protocol). Aren't MFD supposed to have
> more then one child?

It's a single piece of silicon which supports multiple functions.

There is no stipulation detailing simultaneous usage.

Still, happy to receive suggestions on implementing this differently.

-- 
Lee Jones [李琼斯]
