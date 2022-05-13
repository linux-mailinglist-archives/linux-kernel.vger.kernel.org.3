Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EFB526911
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 20:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiEMSOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 14:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382940AbiEMSN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 14:13:59 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792B91A4095;
        Fri, 13 May 2022 11:13:57 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id r11so16644712ybg.6;
        Fri, 13 May 2022 11:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=afx4AehawcU53cvWkjRY/XZQhZ6b42W2IQ/KydnVvwE=;
        b=lzR5+nflHuD8VjXcDFz2xvcrWBvRb81Labwhox35YVwzarez8x/CmSaxe+ZgNu0LNa
         oVhax3UdNVSiQ+J1wxzZVeLFGtcNu2kcPXGV7zv24axEeBY38ZztpdUIw73aHOtkPbi1
         9Wo3GPaQEt1TghE1iQjvNzP7yfjnfZKmOVa6LjafjDB3Q5MJLB8IkKBESX5CuHCBcjn4
         c4YMweHPNhp1BASRR0RfitJ90ntkqkNJbxA35KET9CSUfX+HvL5BO8mMju8uRODITRTH
         sBnQHZ0U87W3MHNnp3XxwxUUpsxmFtQlWhC2FLSiLxI+dQSblTixvCO3OnkiwjVn/+qS
         x/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=afx4AehawcU53cvWkjRY/XZQhZ6b42W2IQ/KydnVvwE=;
        b=y2WpwQtwpUjlBSSXZ/GynuSkUPeqEpasmBR1JnXeoh+3s9K1Np/nY/hyIl+2509Rll
         a6PjiBKKvOxPVkGdo8gxArHCyl0QRvCQmbe3wZpv/6q2rmF4r9R2QtxVj8ka1DESdf+z
         W1Ey+I7wmjQBI1LszEqDoQ73l1T3aUJjwj5sOyGKljTbLPwnYzwPd0rY5arWusKM1lSE
         QTe5IrwFT93zvRcpEtVv/JBiUDESV4T1IJQOpA0XyE7kFTBGdHBNLMHHH20b7JUo8W9A
         SVavHHxaTphOqwIZnhPdofXIS73YCX8MgfDsWl7QDf2znBtugTiqZUoGS3LmTVqX90hY
         ZqBA==
X-Gm-Message-State: AOAM532NScymxudN4BZraj5r+EKSVyWzhf21nfhG6lrqcY4BtmbPeLUW
        MDZ1IxV5eibie4/ELYaQNlB+5sLRDAp9TfmpooY=
X-Google-Smtp-Source: ABdhPJyUY9acIYVu8V132wJGMXCf4p5KKBh5KfOt0X2WQApAtAAISHRaHPzSHlmNsv2hIP0JSGydxhioIeAi5JEboK4=
X-Received: by 2002:a25:83d1:0:b0:648:725c:6a05 with SMTP id
 v17-20020a2583d1000000b00648725c6a05mr6083963ybm.218.1652465636605; Fri, 13
 May 2022 11:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220511183210.5248-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXDQ+eECWwvAGOb-MaN16H17qm_v_1baZ7PdT8qx9McSw@mail.gmail.com>
 <CA+V-a8tNrJQtAQYoUKVwH9w4QOyA9JUWNjiYDPUPsj6UuJ4vaA@mail.gmail.com>
 <CAMuHMdVazy9y_U6Nva+B-3vuX1Ersq+QirXDDgSh28pj8s=EJA@mail.gmail.com>
 <CA+V-a8s2Gf22MPLoZMJS_5uDwzOboJ2i8rZ3KdRFy7a7wv8pGg@mail.gmail.com> <CAMuHMdXHJ385isGd-x8u4sFm1w=rxOC89SUryYbSd34bijkb0g@mail.gmail.com>
In-Reply-To: <CAMuHMdXHJ385isGd-x8u4sFm1w=rxOC89SUryYbSd34bijkb0g@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 13 May 2022 19:13:29 +0100
Message-ID: <CA+V-a8uXakF45TLvpsfeAY_EZKDGHr-wfgqLR_LTz1ZAo8FYmg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to
 handle GPIO interrupt
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

Hi Geert

On Fri, May 13, 2022 at 3:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Fri, May 13, 2022 at 3:56 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Fri, May 13, 2022 at 7:53 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Thu, May 12, 2022 at 7:36 PM Lad, Prabhakar
> > > <prabhakar.csengg@gmail.com> wrote:
> > > > On Thu, May 12, 2022 at 8:39 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Wed, May 11, 2022 at 8:32 PM Lad Prabhakar
> > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > > > Add IRQ domian to RZ/G2L pinctrl driver to handle GPIO interrupt.
> > > > > > GPIO0-GPIO122 pins can be used as IRQ lines but only 32 pins can be
> > > > > > used as IRQ lines at given time. Selection of pins as IRQ lines
> > > > > > is handled by IA55 (which is the IRQC block) which sits in between the
> > > > > > GPIO and GIC.
> > > > > >
> > > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >
> > > > > Thanks for your patch!
> > > > >
> > > > > > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > > > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > > > >
> > > > > >  static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
> > > > > >  {
> > > > > >         struct device_node *np = pctrl->dev->of_node;
> > > > > >         struct gpio_chip *chip = &pctrl->gpio_chip;
> > > > > >         const char *name = dev_name(pctrl->dev);
> > > > > > +       struct irq_domain *parent_domain;
> > > > > >         struct of_phandle_args of_args;
> > > > > > +       struct device_node *parent_np;
> > > > > > +       struct gpio_irq_chip *girq;
> > > > > >         int ret;
> > > > > >
> > > > > > +       parent_np = of_irq_find_parent(np);
> > > > > > +       if (!parent_np)
> > > > > > +               return -ENXIO;
> > > > > > +
> > > > > > +       parent_domain = irq_find_host(parent_np);
> > > > > > +       of_node_put(parent_np);
> > > > > > +       if (!parent_domain)
> > > > > > +               return -EPROBE_DEFER;
> > > > > > +
> > > > > >         ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &of_args);
> > > > > >         if (ret) {
> > > > > >                 dev_err(pctrl->dev, "Unable to parse gpio-ranges\n");
> > > > > > @@ -1138,6 +1330,15 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
> > > > > >         chip->base = -1;
> > > > > >         chip->ngpio = of_args.args[2];
> > > > > >
> > > > > > +       girq = &chip->irq;
> > > > > > +       girq->chip = &rzg2l_gpio_irqchip;
> > > > > > +       girq->fwnode = of_node_to_fwnode(np);
> > > > > > +       girq->parent_domain = parent_domain;
> > > > > > +       girq->child_to_parent_hwirq = rzg2l_gpio_child_to_parent_hwirq;
> > > > > > +       girq->populate_parent_alloc_arg = rzg2l_gpio_populate_parent_fwspec;
> > > > > > +       girq->child_irq_domain_ops.free = rzg2l_gpio_irq_domain_free;
> > > > > > +       girq->ngirq = RZG2L_TINT_MAX_INTERRUPT;
> > > > > > +
> > > > >
> > > > > I think you need to provide a .init_valid_mask() callback, as
> > > > > gpiochip_irqchip_remove() relies on that for destroying interrupts.
> > > > Are you suggesting  the callback to avoid looping through all the GPIO pins?
> > >
> > > gpiochip_irqchip_remove() does:
> > >
> > >         /* Remove all IRQ mappings and delete the domain */
> > >         if (gc->irq.domain) {
> > >                 unsigned int irq;
> > >
> > >                 for (offset = 0; offset < gc->ngpio; offset++) {
> > >                        if (!gpiochip_irqchip_irq_valid(gc, offset))
> > >                                 continue;
> > >
> > >                         irq = irq_find_mapping(gc->irq.domain, offset);
> > >                         irq_dispose_mapping(irq);
> > >                 }
> > >
> > >                 irq_domain_remove(gc->irq.domain);
> > >
> > >         }
> > >
> > > The main thing is not about avoiding to loop through all GPIO pins,
> > > but to avoid irq_{find,dispose}_mapping() doing the wrong thing.
> > So in our case if we don't implement valid masks, that would mean all
> > the pins are valid. irq_find_mapping() would return 0 if no mapping is
> > found to the corresponding offset and irq_dispose_mapping() would
> > simply return back without doing anything if virq == 0.(In this patch
> > rzg2l_gpio_free() does call irq_{find,dispose}_mapping())
>
> But "offset" is a number from the GPIO offset space (0-122), while

The "offset" reported by kernel is 120-511:

root@smarc-rzg2l:~# cat /sys/kernel/debug/gpio
gpiochip0: GPIOs 120-511, parent: platform/11030000.pinctrl, 11030000.pinctrl:
 gpio-120 (P0_0                )
 gpio-121 (P0_1                )
 gpio-122 (P0_2                )
 gpio-123 (P0_3                )
 gpio-124 (P0_4                )
.....
 gpio-507 (P48_3               )
 gpio-508 (P48_4               )
 gpio-509 (P48_5               )
 gpio-510 (P48_6               )
 gpio-511 (P48_7               )

> irq_find_mapping() expects a number from the domain's IRQ space,
> which is only 0-31?
>
Nope, let me demonstrate with an example, I have configured the gpio
pins as GPIO keys in DTS:

+       keyboard {
+               compatible = "gpio-keys";
+               status = "okay";
+
+               key-1 {
+                       gpios = <&pinctrl RZG2L_GPIO(43, 0) GPIO_ACTIVE_HIGH>;
+                       linux,code = <KEY_1>;
+                       linux,input-type = <EV_KEY>;
+                       wakeup-source;
+                       label = "SW1";
+               };
+
+               key-2 {
+                       gpios = <&pinctrl RZG2L_GPIO(41, 0) GPIO_ACTIVE_HIGH>;
+                       linux,code = <KEY_2>;
+                       linux,input-type = <EV_KEY>;
+                       wakeup-source;
+                       label = "SW2";
+               };
+
+               key-3 {
+                       gpios = <&pinctrl RZG2L_GPIO(43, 1) GPIO_ACTIVE_HIGH>;
+                       linux,code = <KEY_3>;
+                       linux,input-type = <EV_KEY>;
+                       wakeup-source;
+                       label = "SW3";
+               };
+       };

root@smarc-rzg2l:~# cat /proc/interrupts | grep SW
root@smarc-rzg2l:~#
root@smarc-rzg2l:~# insmod gpio_keys.ko
[  925.002720] input: keyboard as /devices/platform/keyboard/input/input3
root@smarc-rzg2l:~# cat /proc/interrupts | grep SW
 82:          0          0 11030000.pinctrl 344 Edge      SW1
 83:          0          0 11030000.pinctrl 328 Edge      SW2
 84:          0          0 11030000.pinctrl 345 Edge      SW3
root@smarc-rzg2l:~#

In here 82/83/84 are virq and 344/328/345 are hwirq, which can be
confirmed from sysfs file:

root@smarc-rzg2l:~# cat /sys/kernel/debug/irq/irqs/82
handler:  handle_fasteoi_irq
device:   (null)
status:   0x00000001
istate:   0x00000000
ddepth:   0
wdepth:   0
dstate:   0x13400201
            IRQ_TYPE_EDGE_RISING
            IRQD_ACTIVATED
            IRQD_IRQ_STARTED
            IRQD_SINGLE_TARGET
            IRQD_DEFAULT_TRIGGER_SET
            IRQD_HANDLE_ENFORCE_IRQCTX
node:     0
affinity: 0-1
effectiv:
domain:  :soc:pinctrl@11030000
 hwirq:   0x158
 chip:    11030000.pinctrl
  flags:   0x800
             IRQCHIP_IMMUTABLE
 parent:
    domain:  :soc:interrupt-controller@110a0000
     hwirq:   0x9
     chip:    rzg2l-irqc
      flags:   0x15
                 IRQCHIP_SET_TYPE_MASKED
                 IRQCHIP_MASK_ON_SUSPEND
                 IRQCHIP_SKIP_SET_WAKE
     parent:
        domain:  :soc:interrupt-controller@11900000-1
         hwirq:   0x1dc
         chip:    GICv3
          flags:   0x15
                     IRQCHIP_SET_TYPE_MASKED
                     IRQCHIP_MASK_ON_SUSPEND
                     IRQCHIP_SKIP_SET_WAKE
root@smarc-rzg2l:~#
root@smarc-rzg2l:~#
root@smarc-rzg2l:~# cat /sys/kernel/debug/irq/irqs/83
handler:  handle_fasteoi_irq
device:   (null)
status:   0x00000001
istate:   0x00000000
ddepth:   0
wdepth:   0
dstate:   0x13400201
            IRQ_TYPE_EDGE_RISING
            IRQD_ACTIVATED
            IRQD_IRQ_STARTED
            IRQD_SINGLE_TARGET
            IRQD_DEFAULT_TRIGGER_SET
            IRQD_HANDLE_ENFORCE_IRQCTX
node:     0
affinity: 0-1
effectiv:
domain:  :soc:pinctrl@11030000
 hwirq:   0x148
 chip:    11030000.pinctrl
  flags:   0x800
             IRQCHIP_IMMUTABLE
 parent:
    domain:  :soc:interrupt-controller@110a0000
     hwirq:   0xa
     chip:    rzg2l-irqc
      flags:   0x15
                 IRQCHIP_SET_TYPE_MASKED
                 IRQCHIP_MASK_ON_SUSPEND
                 IRQCHIP_SKIP_SET_WAKE
     parent:
        domain:  :soc:interrupt-controller@11900000-1
         hwirq:   0x1dd
         chip:    GICv3
          flags:   0x15
                     IRQCHIP_SET_TYPE_MASKED
                     IRQCHIP_MASK_ON_SUSPEND
                     IRQCHIP_SKIP_SET_WAKE
root@smarc-rzg2l:~#
root@smarc-rzg2l:~# cat /sys/kernel/debug/irq/irqs/84
handler:  handle_fasteoi_irq
device:   (null)
status:   0x00000001
istate:   0x00000000
ddepth:   0
wdepth:   0
dstate:   0x13400201
            IRQ_TYPE_EDGE_RISING
            IRQD_ACTIVATED
            IRQD_IRQ_STARTED
            IRQD_SINGLE_TARGET
            IRQD_DEFAULT_TRIGGER_SET
            IRQD_HANDLE_ENFORCE_IRQCTX
node:     0
affinity: 0-1
effectiv:
domain:  :soc:pinctrl@11030000
 hwirq:   0x159
 chip:    11030000.pinctrl
  flags:   0x800
             IRQCHIP_IMMUTABLE
 parent:
    domain:  :soc:interrupt-controller@110a0000
     hwirq:   0xb
     chip:    rzg2l-irqc
      flags:   0x15
                 IRQCHIP_SET_TYPE_MASKED
                 IRQCHIP_MASK_ON_SUSPEND
                 IRQCHIP_SKIP_SET_WAKE
     parent:
        domain:  :soc:interrupt-controller@11900000-1
         hwirq:   0x1de
         chip:    GICv3
          flags:   0x15
                     IRQCHIP_SET_TYPE_MASKED
                     IRQCHIP_MASK_ON_SUSPEND
                     IRQCHIP_SKIP_SET_WAKE
root@smarc-rzg2l:~#
root@smarc-rzg2l:~#
root@smarc-rzg2l:~#

root@smarc-rzg2l:~# rmmod gpio_keys.ko
[ 1143.037314] rzg2l_gpio_free offset:345 virq:84
[ 1143.042488] rzg2l_gpio_free offset:328 virq:83
[ 1143.048700] rzg2l_gpio_free offset:344 virq:82
root@smarc-rzg2l:~#
root@smarc-rzg2l:~#

I have added print in gpio_free callback where
irq_{find,dispose}_mapping()) prints the correct value above.


> > > The loop is over all GPIO offsets, while not all of them are mapped
> > > to valid interrupts. Does the above work correctly?
> > >
> > I haven't tested unloading the pinctrl driver which should call
> > gpiochip_irqchip_remove() (we don't have remove call back for pinctrl
> > driver)
> >
> > > > > However, the mask will need to be dynamic, as GPIO interrupts can be
> > > > > mapped and unmapped to one of the 32 available interrupts dynamically,
> > > > > right?
> > > > Yep that's correct.
> > > >
> > > > > I'm not sure if that can be done easily: if gpiochip_irqchip_irq_valid()
> > > > > is ever called too early, before the mapping is done, it would fail.
> > > > >
> > > > The mask initialization is a one time process and that is during
> > > > adding the GPIO chip. At this stage we won't be knowing what will be
> > > > the valid GPIO pins used as interrupts. Maybe the core needs to
> > > > implement a callback which lands in the GPIO controller driver to tell
> > > > if the gpio irq line is valid. This way we can handle dynamic
> > > > interrupts.
> > >
> > > Upon closer look, I think the mask is a red herring, and we don't
> > > need it.
> > Agreed.
> >
> > > But we do need to handle the (possible) mismatch between GPIO
> > > offset (index) and IRQ offset in the above code.
> > >
> > Agreed, do you see any possibility of the mismatch I have missed?
>
> gpiochip_to_irq():
>
>         if (irq_domain_is_hierarchy(domain)) {
>                 struct irq_fwspec spec;
>
>                 spec.fwnode = domain->fwnode;
>                 spec.param_count = 2;
>                 spec.param[0] = gc->irq.child_offset_to_irq(gc, offset);
>                 spec.param[1] = IRQ_TYPE_NONE;
>
>                 return irq_create_fwspec_mapping(&spec);
>         }
>
> Same here: in the absence of a child_offset_to_irq() callback,
> the default gpiochip_child_offset_to_irq_noop() will be used,
> assuming an identity mapping between GPIO numbers and IRQ
> numbers.
>
Agreed, gpiochip_child_offset_to_irq_noop will return the "offset",
but irq_create_fwspec_mapping() in gpiochip_to_irq() will return the
virq number which will not be equal to the offset.

I added the below change in gpio_keys.c where it calls gpiod_to_irq()
-> to_irq()  and the below is the log:
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -589,6 +589,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
                                        button->gpio, error);
                                return error;
                        }
+                       dev_err(dev,"%s gpiod_to_irq() = (irq) %d\n",
__func__, irq);
+
                        bdata->irq = irq;
                }

root@smarc-rzg2l:~# insmod gpio_keys.ko
[   54.288678] gpio-keys keyboard: gpio_keys_setup_key gpiod_to_irq() = (irq) 82
[   54.297230] gpio-keys keyboard: gpio_keys_setup_key gpiod_to_irq() = (irq) 83
[   54.311256] gpio-keys keyboard: gpio_keys_setup_key gpiod_to_irq() = (irq) 84
[   54.332560] input: keyboard as /devices/platform/keyboard/input/input0
root@smarc-rzg2l:~#

> So perhaps
>   1. you need to provide a child_offset_to_irq() callback,
>   2. gpiochip_irqchip_remove() needs to apply the child_offset_to_irq()
>     mapping too?
>   3. you do need the mask, or let child_offset_to_irq() an error code,
>      to avoid irq_{find,dispose}_mapping() handling non-existent irqs?
>
From the above logs, I don't think this is needed. Please correct me
if I am wrong.


> Or am I missing something?
>
> I guess this is easy to verify by adding some debug prints to the code.
>
Let me know if you want me to add debug prints at specific places.

Cheers,
Prabhakar
