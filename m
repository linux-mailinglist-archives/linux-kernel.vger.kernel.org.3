Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AA15AD53F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbiIEOkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238608AbiIEOkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:40:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EE013E29;
        Mon,  5 Sep 2022 07:37:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B274661156;
        Mon,  5 Sep 2022 14:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB7DC433C1;
        Mon,  5 Sep 2022 14:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662388677;
        bh=6Q7HGVentmMLXaWL6fgIUTQqVOYenukFu1wRiem/7c0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nzGBB0kSd3hjZ2BLzPKk37c5MFBDOf/nMPBlb7HtAY1VQjVzURA82sNB4MgIn/Ki9
         wAYrVrWI/6dKa1ltDrB554HAzB495oveTWmLG+AEV+ZWzykZ76FX/OQWSokX8Bnxn4
         3PQ+EJwbpY0/G5DN/kTLBH6wiKMQ1/G7xcyUXG/FoBsJinqPvjYekpd/E2FqgdX1QF
         lPE/qF3IH12XheVji2m6wMlg3TSG5ewZflr3lyFonsAfenAU3DM7COsthRW+IjTlME
         wivAsQ1pE6pwrG9QaaRZlyuUzhoSTqnoDXZeHPauYRAfevVJX3uK0Q+MscvJ91KYYs
         zXIQ23P6tOeUA==
Date:   Mon, 5 Sep 2022 15:37:37 +0100
From:   Lee Jones <lee@kernel.org>
To:     Sergiu.Moga@microchip.com
Cc:     krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
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
Message-ID: <YxYI8/bprIV2wd1c@google.com>
References: <20220817075517.49575-1-sergiu.moga@microchip.com>
 <20220817075517.49575-3-sergiu.moga@microchip.com>
 <942accc5-70aa-3bb2-63dd-306a39ee5ea4@linaro.org>
 <d1aad8ea-3852-f36b-366b-7aa67d2dd9d5@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1aad8ea-3852-f36b-366b-7aa67d2dd9d5@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022, Sergiu.Moga@microchip.com wrote:

> On 18.08.2022 11:39, Krzysztof Kozlowski wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > On 17/08/2022 10:55, Sergiu Moga wrote:
> >> Convert at91 USART DT Binding for Atmel/Microchip SoCs to
> >> json-schema format.
> >>
> >> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> >> ---
> >>   .../bindings/mfd/atmel,at91-usart.yaml        | 190 ++++++++++++++++++
> >>   .../devicetree/bindings/mfd/atmel-usart.txt   |  98 ---------
> >>   2 files changed, 190 insertions(+), 98 deletions(-)
> >>   create mode 100644 Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
> >>   delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-usart.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
> >> new file mode 100644
> >> index 000000000000..cf15d73fa1e8
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mfd/atmel,at91-usart.yaml
> > One more thing - I think this should be in serial directory, not mfd,
> > even though it includes SPI. MFD is just a Linux naming/wrapper device.
> >
> > Best regards,
> > Krzysztof
> 
> I would rather keep it in this directory, since its corresponding driver 
> is also in the mfd directory.

Looks like a UART driver to me.

Which MFD driver does this pertain to?

-- 
Lee Jones [李琼斯]
