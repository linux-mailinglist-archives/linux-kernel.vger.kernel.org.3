Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2915B54B1D4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245346AbiFNNAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiFNNAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:00:09 -0400
X-Greylist: delayed 435 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Jun 2022 06:00:07 PDT
Received: from smtpout1.mo3004.mail-out.ovh.net (smtpout1.mo3004.mail-out.ovh.net [79.137.123.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A7633A1E;
        Tue, 14 Jun 2022 06:00:07 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.109.143.122])
        by mo3004.mail-out.ovh.net (Postfix) with ESMTPS id A5AC7245624;
        Tue, 14 Jun 2022 12:52:50 +0000 (UTC)
Received: from [192.168.1.41] (88.161.25.233) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Tue, 14 Jun
 2022 14:52:50 +0200
Message-ID: <c96c5554-d2ae-33a4-ba1b-8c76998e0367@traphandler.com>
Date:   Tue, 14 Jun 2022 14:52:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/3] leds: Add driver for the TLC5925 LED controller
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Pavel Machek <pavel@ucw.cz>, <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220609162734.1462625-1-jjhiblot@traphandler.com>
 <20220609162734.1462625-3-jjhiblot@traphandler.com>
 <CAHp75Veurvhxi0Pg1Sjxav+3XpDTVOdan8WFFmZmdhJbZJiCaQ@mail.gmail.com>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <CAHp75Veurvhxi0Pg1Sjxav+3XpDTVOdan8WFFmZmdhJbZJiCaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG8EX1.emp2.local (172.16.2.81) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 9557201359817357787
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudduledgheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthejredttdefjeenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepieejfedukeevudfghfetudevhffhhfekjeeiudegtdehueevgfdvgeeivdeifedvnecukfhppedtrddtrddtrddtpdekkedrudeiuddrvdehrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhofedttdeg
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/06/2022 18:57, Andy Shevchenko wrote:
> On Thu, Jun 9, 2022 at 6:30 PM Jean-Jacques Hiblot
> <jjhiblot@traphandler.com> wrote:
>> The TLC5925 is a 16-channels constant-current LED sink driver.
>> It is controlled via SPI but doesn't offer a register-based interface.
>> Instead it contains a shift register and latches that convert the
>> serial input into a parallel output.
> Can you add Datasheet: tag here with the corresponding URL? Rationale
> is to get a link to the datasheet by just browsing Git log without
> browsing the source code, which will benefit via Web UIs.
>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ...
>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/leds.h>
>> +#include <linux/err.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/property.h>
>> +#include <linux/workqueue.h>
> Keep it sorted?
>
> ...
>
>> +struct single_led_priv {
>> +       int idx;
>> +       struct led_classdev cdev;
> For pointer arithmetics it's better to swap these two members.
>
>> +};
>> +
>> +struct tlc5925_leds_priv {
>> +       int max_num_leds;
>> +       u8 *state;
> unsigned long? DECLARE_BITMAP() ?
>
>> +       spinlock_t lock;
>> +       struct single_led_priv leds[];
>> +};
> ...
>
>> +       if (brightness)
>> +               priv->state[index / 8] |= (1 << (index % 8));
>> +       else
>> +               priv->state[index / 8] &= ~(1 << (index % 8));
> assign_bit()
>
> ...
>
>> +       return spi_write(spi, priv->state, priv->max_num_leds / 8);
> BITS_TO_BYTES() ?
>
> ...
>
>> +       count = device_get_child_node_count(dev);
>> +       if (!count) {
>> +               dev_err(dev, "no led defined.\n");
>> +               return -ENODEV;
>    return dev_err_probe(...);
>
> here and everywhere in ->probe() and Co.
>
>> +       }
> ...
>
>> +       ret = device_property_read_u32_array(dev, "ti,shift-register-length",
>> +                                            &max_num_leds, 1);
> Always an array of 1 element? call device_property_read_u32().
>
> ...
>
>> +       if (max_num_leds % 8) {
>> +               dev_err(dev, "'ti,shift-register-length' must be a multiple of 8\n");
>> +               return -EINVAL;
>> +       }
> Is this really fatal? I would rather issue a warning and go on if it
> has at least 8 there. So the idea is to use a minimum that holds
> multiple of 8.
It is more than likely that it will always be a multiple of 8 here.

We could in theory use a non-multiple of 8 (some LEDs of the first or 
last chips of the chain are not populated).

I didn't think it would add a significant benefit in memory usage. In 
terms of SPI usage it wouldn't change anything.


Thanks for your feedback.

> ...
>
>> +       /* Assert all the OE/ lines */
>> +       gpios = devm_gpiod_get_array(dev, "output-enable-b", GPIOD_OUT_LOW);
>> +       if (IS_ERR(gpios)) {
>> +               dev_err(dev, "Unable to get the 'output-enable-b' gpios\n");
>> +               return PTR_ERR(gpios);
>> +       }
> You have to use dev_err_probe() here, otherwise it will spam logs a
> lot in case of deferred probe.
>
> ...
>
>> +       priv->state = devm_kzalloc(dev, DIV_ROUND_UP(max_num_leds, 8), GFP_KERNEL);
> devm_bitmap_zalloc()
>
> ...
>
>> +       device_for_each_child_node(dev, child) {
>> +               struct led_init_data init_data = {.fwnode = child};
> Missed spaces.
>
>> +               struct led_classdev *cdev;
>> +               u32 idx;
>> +
>> +               ret = fwnode_property_read_u32_array(child, "reg", &idx, 1);
> fwnode_property_read_u32()
>
>> +               if (ret || idx >= max_num_leds) {
>> +                       dev_err(dev, "%s: invalid reg value. Ignoring.\n",
>> +                               fwnode_get_name(child));
>> +                       fwnode_handle_put(child);
>> +                       continue;
> Either dev_warn + continue, or dev_err + return dev_err_probe().
>
>> +               }
>> +
>> +               count--;
>> +               priv->leds[count].idx = idx;
>> +               cdev = &(priv->leds[count].cdev);
>> +               cdev->brightness = LED_OFF;
>> +               cdev->max_brightness = 1;
>> +               cdev->brightness_set_blocking = tlc5925_brightness_set_blocking;
>> +
>> +               ret = devm_led_classdev_register_ext(dev, cdev, &init_data);
>> +               if (ret) {
> Ditto.
>
>> +                       dev_err(dev, "%s: cannot create LED device.\n",
>> +                               fwnode_get_name(child));
>> +                       fwnode_handle_put(child);
>> +                       continue;
>> +               }
>> +       }
> ...
>
>> +static const struct of_device_id tlc5925_dt_ids[] = {
>> +       { .compatible = "ti,tlc5925", },
>> +       {},
> No comma for terminator entry.
>
>> +};
> Where is the MODULE_DEVICE_TABLE() for this one?
>
> ...
>
>> +
> No  need for this blank line.
>
>> +module_spi_driver(tlc5925_driver);
