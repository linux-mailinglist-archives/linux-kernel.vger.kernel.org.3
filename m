Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF0C4BBBF9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbiBRPS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:18:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiBRPS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:18:27 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218A73BB;
        Fri, 18 Feb 2022 07:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ma+YyjNhVfgLB+vMR+lpMr7bDERVJ4XvdHuAywIrWUc=; b=F3qkGQabV1uEdMdKEo2n+HpWgU
        5MPL+A9oQArJlTWfnyELzBUg2dAt04AwZyFdkMfpbXu1LyEr/a/t8HQKlX7M662e55Hr3AruQfs9b
        cU2AVmXYkGvU9QkhyX4MvsBRGed3VC5FUqXzVWQTprTPvVESvzgvUhIIIRSwIJrDz/ZY=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:42846 helo=debian-acer)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nL51C-00063a-OK; Fri, 18 Feb 2022 10:17:59 -0500
Date:   Fri, 18 Feb 2022 10:17:58 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Rob Herring <robh@kernel.org>
Cc:     hvilleneuve@dimonoff.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Message-Id: <20220218101758.a12d51b57b5c096210de29e7@hugovil.com>
In-Reply-To: <Yg7hWRlxNY2zzg+B@robh.at.kernel.org>
References: <20220211205029.3940756-1-hugo@hugovil.com>
        <20220211205029.3940756-15-hugo@hugovil.com>
        <Yg7hWRlxNY2zzg+B@robh.at.kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v2 14/14] dt-bindings: rtc: pcf2127: add PCF2131
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2022 17:59:21 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, Feb 11, 2022 at 03:50:29PM -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Add support for new NXP RTC PCF2131.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  .../devicetree/bindings/rtc/nxp,pcf2127.yaml  | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > index cde7b1675ead..57eb0a58afa3 100644
> > --- a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > @@ -14,7 +14,9 @@ maintainers:
> >  
> >  properties:
> >    compatible:
> > -    const: nxp,pcf2127
> > +    enum:
> > +      - nxp,pcf2127
> > +      - nxp,pcf2131
> >  
> >    reg:
> >      maxItems: 1
> > @@ -48,4 +50,19 @@ examples:
> >          };
> >      };
> >  
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        rtc@53 {
> > +            compatible = "nxp,pcf2131";
> > +            reg = <0x53>;
> > +            pinctrl-0 = <&rtc_nint_pins>;
> > +            interrupts-extended = <&gpio1 16 IRQ_TYPE_LEVEL_HIGH>;
> > +            reset-source;
> > +        };
> > +    };
> 
> Just a new compatible doesn't really justify another example.
> 
> Rob

Hi,
yes, now that I've remove the specific properties, the example can be removed.

Hugo.
