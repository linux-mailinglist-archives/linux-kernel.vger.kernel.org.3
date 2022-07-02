Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F223256433C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 01:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiGBXEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 19:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGBXEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 19:04:34 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E65B7EB;
        Sat,  2 Jul 2022 16:04:33 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id pk21so10315391ejb.2;
        Sat, 02 Jul 2022 16:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q4Q0u3OQPYSEIHOkfKsjK+dUNLGGXfSmT08dMRTZRyc=;
        b=GKIjLleN2Qf7u+9okq7Vd6qkSsc3mf7MgRNZWk8SQDtG6CEqKhTSfzCPmeAAkzQZ4g
         IdwxNXqneAvIAL8P81nHB2Bb/0GoY2KGrV5MXHUfZj9L+SONWt8LvmF+gT7EJk+7nhlh
         mb0ul7mWDozIXgW7uyXStqlqMcoGaP8huGmE7crxE0GIbFUOyw9Bi8YuC0VdPBtKZQ5R
         xZktX10C1ibypwB9XvKzljcbV1DsOphHvGjJEPGBJFf6ZwhZRJ/cPKRapsRdLas8ZKQT
         Zz0hZrIq7Yg7IJ3t8SlernEF6UjcQ0RTHxWYaXgki+lRVmq+d4DR1pgNeO2RcL3w0B9B
         nQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q4Q0u3OQPYSEIHOkfKsjK+dUNLGGXfSmT08dMRTZRyc=;
        b=gaDLDnZzBJ6rFD+k+p/l1oMdRsVOGGknM6/hGLqDLHUnilYpU1EAa9sSKtLTDlelth
         nFvDbcDHGhVv0c4qSeJrdbiBAH3v0opylQqKRshZmJiEXZRDmwJKz08KtBXmD4nH5yzL
         ohGkB7PJvW4go0qiKbyej+QfwATcwLVlV34rANdbejsQ9vyQh5LR3LfS6U4lvxwoxj8E
         dxHS/KuUUGTLVTQYEHK100QcTTDzpl/2OOua2NR9EgNpcAh+CDrbMH9lNKDMYmgmqKgs
         NVuzyGRi4NGuCwYqNyLKrOORoxnn6nMoku/5VRCcH8d/CDARmDoSjfRKFi2RH6f5nMib
         WdaQ==
X-Gm-Message-State: AJIora9qvk5VuImLQn0wAVXgi1lUfXvTNk7tAY6C4zMRDo6lTqKN5VK0
        enEY9sAMBLLWHLZQ5cfM/7NujKiRmrv/ZmgI0Xc=
X-Google-Smtp-Source: AGRyM1uTEi+dowzJS3hYBz1ryLHs2/it9gJrhBZslQZ4YqcQBE4bP0ofSJArdONYEdYHdmbEGYEx4xqL+BxvVNazowA=
X-Received: by 2002:a17:906:7386:b0:715:7024:3df7 with SMTP id
 f6-20020a170906738600b0071570243df7mr21406740ejl.543.1656803071611; Sat, 02
 Jul 2022 16:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220628124441.2385023-1-martin.blumenstingl@googlemail.com>
 <20220628124441.2385023-4-martin.blumenstingl@googlemail.com> <20220701163350.GA1078312-robh@kernel.org>
In-Reply-To: <20220701163350.GA1078312-robh@kernel.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 3 Jul 2022 01:04:20 +0200
Message-ID: <CAFBinCARuO0WFLufwgPxQkY_Mh+Pfn6V8QAe-HZ8sjUBKTYhtQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/9] dt-bindings: reset: intel,rcu-gw: Update bindings
 for "legacy" SoCs
To:     Rob Herring <robh@kernel.org>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, vkoul@kernel.org, kishon@ti.com,
        rtanwar@maxlinear.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi Rob,

On Fri, Jul 1, 2022 at 6:33 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jun 28, 2022 at 02:44:35PM +0200, Martin Blumenstingl wrote:
> > The Lantiq Amazon-SE, Danube, xRX100 and xRX200 SoCs have up to two USB2
> > PHYs which are part of the RCU register space. The RCU registers on
> > these SoCs are using big endian. Update the binding for these SoCs to
> > properly describe this IP:
> > - Add compatible strings for Amazon-SE, Danube and xRX100
> > - Rename the xRX200 compatible string (which is not used anywhere) and
> >   switch to the one previously documented in mips/lantiq/rcu.txt
> > - Allow usage of "simple-mfd" and "syscon" in the compatible string so the
> >   child devices (USB2 PHYs) can be described
> > - Allow #address-cells and #size-cells to be set to 1 for describing the
> >   child devices (USB2 PHYs)
> > - #reset-cells must always be 3 (offset, reset bit and status bit) on the
> >   legacy SoCs while LGM uses a fixed value of 2 (offset and reset bit -
> >   status bit is always identical to the reset bit).
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  .../bindings/reset/intel,rcu-gw.yaml          | 84 +++++++++++++++++--
> >  1 file changed, 79 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
> > index be64f8597710..b90913c7b7d3 100644
> > --- a/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
> > +++ b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
> > @@ -11,9 +11,16 @@ maintainers:
> >
> >  properties:
> >    compatible:
> > -    enum:
> > -      - intel,rcu-lgm
> > -      - intel,rcu-xrx200
>
> It is okay to remove/change this because ?
I'll update the description in v2. The "intel,rcu-xrx200" compatible
string isn't used anywhere (upstream or downstream in OpenWrt).
u-boot on Lantiq xRX200 SoCs is too old to pass a dtb to the kernel,
so we're appending the DTB to the kernel image.

> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - lantiq,ase-rcu
> > +              - lantiq,danube-rcu
> > +              - lantiq,xrx100-rcu
> > +              - lantiq,xrx200-rcu
> > +          - const: simple-mfd
>
> This says child nodes have 0 dependence on anything in the parent node.
> Such as a clock in the parent needing to be enabled.
>
> > +          - const: syscon
>
> Given the child nodes depend on this, I find the combination to be a
> contradiction. But it's widely used, so oh well.
I can think of two ways to solve this:
1) remove the simple-mfd compatible string and make the driver also
discover child nodes
2) remove the simple-mfd compatible string and remove the USB PHY
child nodes - then add add #phy-cells = <1> to the RCU node itself
(and somehow update the RCU and USB PHY drivers accordingly)
3) introduce a separate child node for the reset-controller, then the
child nodes depend on each other (but there's no strict dependency on
the parent anymore other than the fact that the parent needs a
"syscon" compatible string).

My understanding of this IP block is that it was initially designed as
a reset controller, hence its name "reset controller unit" (RCU). Then
additional logic was added after the fact.
So I think 1) (dropping the simple-mfd compatible string) or 2)
(dropping the simple-mfd compatible string and the child nodes
altogether) is the right way to go here. Which route would you go and
why?

[...]
> > +patternProperties:
> > +  "^usb2-phy@[0-9a-f]+$":
> > +    type: object
> > +    $ref: "../phy/lantiq,xway-rcu-usb2-phy.yaml"
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: intel,rcu-lgm
> > +    then:
> > +      properties:
> > +        "#reset-cells":
> > +          const: 2
>
> else:
>   properties:
>     "#reset-cells":
>       const: 3
much shorter, thanks - I'll take care of this in v2.

[...]
> > +        usb_phy0: usb2-phy@18 {
> > +            compatible = "lantiq,xrx200-usb2-phy";
> > +            reg = <0x18 4>, <0x38 4>;
> > +            status = "disabled";
>
> Why is your example disabled? Don't use 'status' in examples.
I should know this better - I'll fix this in v2.


Best regards,
Martin
