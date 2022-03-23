Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE874E58D8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244223AbiCWTEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiCWTEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:04:49 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102E065BF;
        Wed, 23 Mar 2022 12:03:16 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F1281100004;
        Wed, 23 Mar 2022 19:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648062191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jn4eEh+cMlzdXNoYeFxpZsql1R7mD18vfamv6OpnlJo=;
        b=EVK5SV6gKLJ1Wmc8xcKelEB5XgHl439t77Ep+sR3gT6kk+SAGiGqsNvlrOKw4TtaikP1Nq
        CVlmvTnqhRBp6RjC5r3FdtYxQmr9EB3RIYPHFroR8oLpxyFbtK32DdFpavBBy3wxj4SfGb
        DiqJmvdWvwdMJP+lQo/9omI0nHpITPHB+tC3wkJez2NhRbeDUQdpIv1RDlWw8N54fOV8rJ
        NIOVYVOLNP2r2WSs2LVqp/dnL39x1AhWZCvXpr2SVwQx8VSj787HB/vSaJ0WT+XeJEf/r8
        tax6aC6tUlPp7oC5LYsbpirqNmz/9nAEY1P0s857vkER9MQhJX6cF4zevdAuVQ==
Date:   Wed, 23 Mar 2022 20:03:10 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: rtc: at91: rename rtt bindings file
Message-ID: <Yjtu7sRdl3yIR0u8@piout.net>
References: <20220308155735.54146-1-alexandre.belloni@bootlin.com>
 <CAL_JsqJXz01F_+-xg8VfAOQ=-C96NVa1KO+nRbXf9mq289kmYQ@mail.gmail.com>
 <CAL_Jsq++eqGS6xJ6EgwXe2RpZYgbB30kfTvZQx=sGmb-LgVWXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq++eqGS6xJ6EgwXe2RpZYgbB30kfTvZQx=sGmb-LgVWXg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/03/2022 09:39:07-0500, Rob Herring wrote:
> On Wed, Mar 9, 2022 at 3:05 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Tue, Mar 8, 2022 at 9:57 AM Alexandre Belloni
> > <alexandre.belloni@bootlin.com> wrote:
> > >
> > > atmel,at91sam9-rtc is a confuing name for this file as it is documenting
> > > the RTT used as an RTC and not the other regular RTC (atmel,at91rm9200-rtc
> > > and atmel,at91sam9x5-rtc)
> > >
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > ---
> > >  .../rtc/{atmel,at91sam9-rtc.yaml => atmel,at91sam9260-rtt.yaml}   | 0
> > >  1 file changed, 0 insertions(+), 0 deletions(-)
> > >  rename Documentation/devicetree/bindings/rtc/{atmel,at91sam9-rtc.yaml => atmel,at91sam9260-rtt.yaml} (100%)
> > >
> > > diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> > > similarity index 100%
> > > rename from Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
> > > rename to Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml
> >
> > Now failing in -next:
> >
> > ./Documentation/devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml:
> > $id: relative path/filename doesn't match actual path or filename
> >   expected: http://devicetree.org/schemas/rtc/atmel,at91sam9260-rtt.yaml#
> 
> Still failing...

Sorry, this is fixed now.

> 
> Rob

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
