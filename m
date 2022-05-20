Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CE552ED88
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349997AbiETNwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbiETNwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:52:34 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38615E745;
        Fri, 20 May 2022 06:52:31 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BC9EF240014;
        Fri, 20 May 2022 13:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653054744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+bOjW1b8w++QSKTTjEeZgfbqJDg2u0gptb5iXkZEb88=;
        b=BVxr94oPQhfAiYxwDjhe2bG3Z6/SMBrYYEZafMACzM4CcLha3a5UMnIu3Pmtq9A49uz52A
        R8m4JdTcaTi8kigUhs8WqAGLuyKj0D9T/aEzSqOWxLmNdkBsGAbehvMglVYuMDxkIC4ffc
        SF6gSivmwl3gYM1VmYln49skYbOEK2h0x3KEKgFSqDAmIrYwbEfK88ZZeh9T+Fl7SptLza
        lbyt4Vs1hWGvXbW0Wgsx786klXuPMiMBFMOS3Yd+nZ6Ev3WnrPlk5U5qIlvpRvfshsWCDB
        sc0pGkUiGTTyH5spF0BPxFwFH60xBZyatTS+u9lB+Xr8Qqb1RTueDGc9ltgUSw==
Date:   Fri, 20 May 2022 15:52:22 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/3] dt-bindings: usb: atmel: Add Microchip LAN966x
 compatible string
Message-ID: <YoedFkAsTdoOn/3Y@mail.local>
References: <20220513105850.310375-1-herve.codina@bootlin.com>
 <20220513105850.310375-3-herve.codina@bootlin.com>
 <8f0d4127-7e66-cf50-21c9-99680f737e30@linaro.org>
 <20220520133426.3b4728ae@bootlin.com>
 <b087c34f-0e2f-edd0-a738-3ffc2853a41b@linaro.org>
 <20220520142109.57b84da2@bootlin.com>
 <01b31a02-523e-10bf-3b46-5b830e456522@linaro.org>
 <20220520150243.625723fa@bootlin.com>
 <d26c7ebd-fc1a-391e-39e4-5ec41bf4fbfa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d26c7ebd-fc1a-391e-39e4-5ec41bf4fbfa@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 20/05/2022 15:38:36+0200, Krzysztof Kozlowski wrote:
> On 20/05/2022 15:02, Herve Codina wrote:
> > On Fri, 20 May 2022 14:50:24 +0200
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> > 
> >> On 20/05/2022 14:21, Herve Codina wrote:
> >>>>> I think it makes sense to keep 'microchip,lan966x-udc' for the USB
> >>>>> device controller (same controller on LAN9662 and LAN9668) and so
> >>>>> keeping the same rules as for other common parts.    
> >>>>
> >>>> Having wildcard was rather a mistake and we already started correcting
> >>>> it, so keeping the "mistake" neither gives you consistency, nor
> >>>> correctness...
> >>>>  
> >>>
> >>> I think that the "family" compatible should be present.
> >>> This one allows to define the common parts in the common
> >>> .dtsi file (lan966x.dtsi in our case).
> >>>
> >>> What do you think about:
> >>> - microchip,lan9662-udc
> >>> - microchip,lan9668-udc
> >>> - microchip,lan966-udc  <-- Family
> >>>
> >>> lan966 is defined as the family compatible string since (1) in
> >>> bindings/arm/atmel-at91.yaml and in Documentation/arm/microchip.rst
> >>>   
> >>
> >> You can add some family compatible, if it makes sense. I don't get why
> >> do you mention it - we did not discuss family names, but using
> >> wildcards... Just please do not add wildcards.
> > 
> > Well, I mentioned it as I will only use the family compatible string
> > and not the SOC (lan9662 or lan9668) compatible string in lan966x.dtsi.
> > In this case, the family compatible string can be seen as a kind of
> > "wildcard".
> 
> I understood as "the "family" compatible should be present" as you want
> to add it as a fallback. It would be okay (assuming devices indeed share
> family design). If you want to use it as the only one, then it is again
> not a recommended approach. Please use specific compatibles.
> 
> I mean, why do we have this discussion? What is the benefit for you to
> implement something not-recommended by Devicetree spec and style?
> 

Honestly, I would just go for microchip,lan9662-udc. There is no
difference between lan9662 and lan9668 apart from the number of switch
ports.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
