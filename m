Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B2F5572AB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 07:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiFWFsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 01:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiFWFsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 01:48:19 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0213465C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 22:48:17 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.155]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MAOeB-1nwmef2XNb-00BplX; Thu, 23 Jun 2022 07:48:02 +0200
Message-ID: <189021ff-c8d9-15d9-c997-c3e52eb01c38@i2se.com>
Date:   Thu, 23 Jun 2022 07:48:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 0/6] Raspberry Pi Sense HAT driver
Content-Language: en-US
To:     Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Serge Schneider <serge@raspberrypi.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Daniel Bauman <dbauman@redhat.com>,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <20220419205158.28088-1-cmirabil@redhat.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <20220419205158.28088-1-cmirabil@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:MvqwI51VW2v8fikd5gu1bMZJlVb1nxm31DLD03/8IQ1jP5oh+Oe
 YUmZsyUuQ11b7+F9ij7xiR3n0uL2LwIO0/AIX/fdKrCYbMCXC9Chrcx9A4/IJhS6t4iKOJ+
 hAfADEAg4f3+0m9ipXhvfu6Sy9Is12DaBcnkYqE6jFsbEfLSapHASDveTFy9BgrCUKSYGKx
 o7fATlwbvH7pZ/tD5gMdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QKP2bPlGdLQ=:1U8eHM7ltc1EhaWBUYMc8R
 QRdSR7JaDJPdxvawuOwenGTH/jlrOSjP4+oNcHQYm+9iUBenI6JLIxja/ZvXA01YsjPEIqQkm
 s9DXXDIGvZiTYRdV8hFfymnUm5+qtubh/VLKMeHfNlzdcKfyOd/dyanw4sS6WaJ7EBxgocmU1
 Z11dg35VMteZ9NJ/BOnTOpVWazqL01Il0O6DWBJromg3EYI0SSWH1uzmC08qo/IaO/Txx097C
 qyKkLv5uJWxUsjXKnGtOcuK2YneYS7+kCyzyi6aDhhXMnxb54q/r7LouELbVow4D08Jc7CM8m
 f6QyUcmiSLHcFHk2cpmJ4QvhKY8xiTI+JUfzkz1y+DICHdQZj/v+UVNev9HB1f6dQ2gqqEaob
 sv767bc4Ok8LJKW6SOVMnvr+RID6h+yLzNTMTY6F7rSgZvTe15x5kwy4EchkX6mWv8yAEOfkL
 bbdFRPmkxEOTJekiWtXki8B9/NPenYDj6amGDr1JoY+HOvjdUof7MaNGFw29u/3xuez5KwaH5
 ha1qzaoKJqPznTx7TcIfKpVPd/PSbbl0Ox2aoaxiU/Weg0Lv1TOz2Gt+q6wtygxzo5DKYmRlK
 EGoetFqs3KvraCQEnFzh/vYYxHoEmWhui+pzj4t6yQiLum+QdFmWn673lNgJ3yn1yb/irPtMD
 jiVKxOHzQ9MnfogySgXV3SStMV3PwOMPAJHKdnoSRfXG7sGcAhZBZw/ZV26PvwWATtGROscRY
 03fWyaqZzCO/1WIOoY1/x3R7+kzithb8rd8/1+NkJFKD4e/KWTKXO/lt3aY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

Am 19.04.22 um 22:51 schrieb Charles Mirabile:
> This patch series adds a set of drivers for operating the Sense HAT
> peripheral device. This board is an add on for the Raspberry Pi that is
> designed to connect using the GPIO connector and communicate via I2C.
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
> Changes since v8:
> 	- Fixed a few small things in the device tree bindings.
> 	I forgot to include the fact that Rob Herring had already
> 	reviewed them when I posted v8, so Krzysztof Kozlowski
> 	jumped in and offered his input. The suggestions were good
> 	so we decided to include them. Sorry for the confusion.
> 	- Corrected a typo in the description of the display driver.
> 	The format of the special file used by the driver was changed
> 	in v8 and this was described in the cover letter of the patch,
> 	but not in the actual note attached to that patch. This is now
> 	fixed.
>
> Co-developed-by: Daniel Bauman <dbauman@redhat.com>
> Signed-off-by: Daniel Bauman <dbauman@redhat.com>
> Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
> Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
> Co-developed-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
>
> Charles Mirabile (6):
>    drivers/mfd: sensehat: Add Raspberry Pi Sense HAT to simple_mfd_i2c
>    drivers/input/joystick: sensehat: Raspberry Pi Sense HAT joystick
>      driver
>    drivers/auxdisplay: sensehat: Raspberry Pi Sense HAT display driver
>    dt-bindings: mfd: sensehat: Add Raspberry Pi Sense HAT schema
>    MAINTAINERS: Add sensehat driver authors to MAINTAINERS
>    DO NOT MERGE: full sensehat device tree overlay for raspberry pi 4

since only the joystick patch has been applied, could you please send a 
rebased v10 without the joystick driver?

Please take care of the fact that Florian is the new BCM2835 maintainer.

Thanks

