Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41B459EE33
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 23:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiHWVaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 17:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHWVao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 17:30:44 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C545AC5A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:30:42 -0700 (PDT)
Received: from [192.168.1.138] ([37.4.248.80]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M6DrU-1oXEFW09nM-006cep; Tue, 23 Aug 2022 23:30:18 +0200
Message-ID: <fc54a7a3-c67b-79ab-5e87-d468695e5553@i2se.com>
Date:   Tue, 23 Aug 2022 23:30:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v10 0/6] Raspberry Pi Sense HAT driver
Content-Language: en-US
To:     Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Nicolas Saenz Julienne <nicolassaenzj@gmail.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, rh-kdlp@googlegroups.com,
        Joel Slebodnick <jslebodn@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220823174158.45579-1-cmirabil@redhat.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220823174158.45579-1-cmirabil@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EMUDiMqWAHXy3M1kjM6bOveS7/bWLqDT/Xqhx0tZdT265kJRXnO
 3+pV5hMndzFGIo8pP+ozvOSrKl5L2M60gQO7QwKEdpKuRyi+pJdVgGen5r/cRCggrS8OV0W
 zoWlVqhaPHrF6xseubO/nOnmUCJf9MJZ+eXF+RjheDNC3eaTh0Z5Hw28xOXLq5omprUGNlN
 6zmokigvaShWf7fGFZtqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZF0VV4gF6As=:OUGGFq7IhZs3ktxQtwr5yH
 t3n1pbtgUzDekgucE317M3MJaNzDZ9ZsimSYerhHCJQzx0Lls/MRER0rN8wYpIFGMLLlDx4E0
 IiRt69KrI9NP2+qrOyhqgmeacbtZtBxk6V/Pahx6ro6bN4LGgCxLtaF5iqEoVmkDYVP3pXRf5
 98HK1emjymZVqqwZCf+p16DOYCZb5uW0WAIgO8Nya/KRgEM3jbuVq43H/CqmXuSi+Dqr1KGmw
 z2FnohudymZw2ExnskzWk+qI4KIwgnGykHWZITHsSutLyGrePJABjbRoCrJe7Yj7gjTtlEbM5
 5OkjzX44I80CA8VsFReuxFnSvToyjGFe+1vcA+xDk2jdhx4nC5B771b9LMAP+jXpM0U7ILoQL
 ymjENBA2K/9We1ngbFmbTjcpQBix0TCd2eGO5tNWkTeBYQWubnG5e2TPNrtiYjgdz99MRqq6j
 SAXibr2jhJ7bnzQGE4YJBRhZFyfCGh7k3K5PVtTEBKTd1gISl0/XHmpKe9n+WjVTejUL4gYZA
 CR92KLS6el1oBSmiGIwGkbqEVEvpwBVuvMZCjNU4ereqLXxL7GxKHsg1gpOgJEcsJMzEwHilC
 mIPni20p1aE6/epZZN4/c/DYU7nncjHCbXx6eNCDeR0ln4sIHp36VTn1mV/ihhic0yNdMhNyz
 mVr9kNPhZ5+vcZpbQU9Cmk9HY9D8uIZjtqU9NR4iMYrxfeOffTBukJ6JG/6VKiyMiIUrQou+8
 eTonXTkIi07Y3w39mWIp3e5M2xCJlSpKX6m+kn192ozf38GhDxFUvPHFcEY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

+ Maxime & Noralf

Am 23.08.22 um 19:41 schrieb Charles Mirabile:
> This patch series adds a set of drivers for operating the Sense HAT
> peripheral device. This board is an add on for the Raspberry Pi that is
> designed to connect using the GPIO connector and communicate via I2C.
thanks for sending a new version of this series.
>
> It features:
> 	- a joystick
> 	- an 8x8 RGB LED matrix display
> 	- a whole bunch of environmental sensors with their own drivers
> 	  (those are already in upstream Linux)
>
> This is a refactor of the work of Serge Schneider, the author of a
> version of this driver that is currently in the Raspberry Pi downstream
> kernel. We modified his code to make it suitable for upstream Linux.
>
> A couple of tests are available for the driver in the test folder in
> this repo: https://github.com/underground-software/sensehat.git
> 	- sensehat_joystick_test logs the input events from the
> 	  joystick to the console
> 	- sensehat_display_test displays various solid colors on
> 	  the LED panel.
> 	- full_sensehat_test displays a single lit cell that can be
> 	  moved with the joystick. Pressing the joystick ends the
> 	  program.
>
> For more information about the Sense HAT, visit:
> https://www.raspberrypi.org/products/sense-hat/
>
> Changes since v9:
> 	- The driver for the sensehat joystick was accepted upstream so
> 	  it is no longer included in this patchset.
> 	- Some of the people involved in the development of earlier
> 	  versions of these patches are no longer involved in the project
> 	  so they have been removed from the list of maintainers and the
> 	  patches.
> 	- The code is completely unchanged and so based on the discussions
> 	  from version 9 of the patches, it should be ready to be merged.
>
> My appologies for the long delay between v9 and v10 especially given the
> fact that there are no changes to the code. We appreciate the maintainers'
> patience and guidance throughout all 10 versions of this sensehat patchset,
> and we are excited for this driver to hopefully be fully accepted.
>
> Best - Charlie
>
> Co-developed-by: Joel Slebodnick <jslebodn@redhat.com>
> Signed-off-by: Joel Slebodnick <jslebodn@redhat.com>
> Co-developed-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
>
> Charles Mirabile (5):
>    drivers/mfd: sensehat: Add Raspberry Pi Sense HAT to simple_mfd_i2c
AFAIK Lee Jones has a new kernel.org address the old linaro address 
shouldn't be used anymore. We don't get any further without him.
>    drivers/auxdisplay: sensehat: Raspberry Pi Sense HAT display driver
We don't have an Ack for this display driver. Maybe we should ask Maxime 
Ripard and Noralf Trønnes especially Pavel Machek had concerns about the 
right subsystem?
>    dt-bindings: mfd: sensehat: Add Raspberry Pi Sense HAT schema
>    MAINTAINERS: Add sensehat driver authors to MAINTAINERS
>    DO NOT MERGE: full sensehat device tree overlay for raspberry pi 4

In case you want to send a new version it would be nice to enable the 
driver in bcm2835_defconfig for better test coverage. But this is not a 
show stopper.

Best regards

>
>   .../raspberrypi,sensehat-display.yaml         |  26 +++
>   .../input/raspberrypi,sensehat-joystick.yaml  |  31 +++
>   .../bindings/mfd/raspberrypi,sensehat.yaml    |  57 +++++
>   MAINTAINERS                                   |  10 +
>   drivers/auxdisplay/Kconfig                    |   8 +
>   drivers/auxdisplay/Makefile                   |   1 +
>   drivers/auxdisplay/sensehat-display.c         | 205 ++++++++++++++++++
>   drivers/mfd/simple-mfd-i2c.c                  |   1 +
>   sensehat.dtbs                                 |  52 +++++
>   9 files changed, 391 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/auxdisplay/raspberrypi,sensehat-display.yaml
>   create mode 100644 Documentation/devicetree/bindings/input/raspberrypi,sensehat-joystick.yaml
>   create mode 100644 Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
>   create mode 100644 drivers/auxdisplay/sensehat-display.c
>   create mode 100644 sensehat.dtbs
>
