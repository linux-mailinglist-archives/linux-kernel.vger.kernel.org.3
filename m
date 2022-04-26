Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B9D50FC10
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349574AbiDZLln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346234AbiDZLlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:41:42 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 679146F9E5;
        Tue, 26 Apr 2022 04:38:34 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1njJWa-0002ta-00; Tue, 26 Apr 2022 13:38:32 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 8E0F3C01B1; Tue, 26 Apr 2022 11:32:03 +0200 (CEST)
Date:   Tue, 26 Apr 2022 11:32:03 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] MIPS: dts: align SPI NOR node name with dtschema
Message-ID: <20220426093203.GA9655@alpha.franken.de>
References: <20220407143328.295762-1-krzysztof.kozlowski@linaro.org>
 <249f6136-6dd6-0c03-df86-7da02a1b17f0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <249f6136-6dd6-0c03-df86-7da02a1b17f0@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 09:46:33AM +0200, Krzysztof Kozlowski wrote:
> On 07/04/2022 16:33, Krzysztof Kozlowski wrote:
> > The node names should be generic and SPI NOR dtschema expects "flash".
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  arch/mips/boot/dts/brcm/bcm97358svmb.dts                   | 2 +-
> >  arch/mips/boot/dts/brcm/bcm97360svmb.dts                   | 2 +-
> >  arch/mips/boot/dts/brcm/bcm97425svmb.dts                   | 2 +-
> >  arch/mips/boot/dts/ralink/gardena_smart_gateway_mt7688.dts | 2 +-
> >  arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts         | 2 +-
> >  arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts         | 2 +-
> >  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> Hi all,
> 
> Anyone from MIPS folks willing to take it? I got three acks, so maybe
> that means I should handle it?

I'll take it.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
