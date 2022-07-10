Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280E656D0EC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 21:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiGJTBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 15:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGJTA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 15:00:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB1F1209F;
        Sun, 10 Jul 2022 12:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657479632;
        bh=sCSJ/3wMz9Ep+Xj8Zv8+zmOj46t7Ut4p8C/KOgxn8Lw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=iiLODPJBMSk7T1waGk9XUerCKe4Q5K57VDASXRxJuP+vVVDW3MusQT/aSHOFEjCPZ
         3FRr88EYWHvSv3b0AFznmyamti/NCiIyvsXhDYfdoBT3LEwWIsgQKBfWafE5meo/AH
         h5i2kOVXtoXd0SIieJn5ALuUa6yLOhiqOXH0h4HY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.69] ([46.223.3.243]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHXFx-1oNWL32qtV-00DVZJ; Sun, 10
 Jul 2022 21:00:32 +0200
Message-ID: <af8bf241-68c3-02fc-b2f2-6eba20c01b9a@gmx.de>
Date:   Sun, 10 Jul 2022 21:00:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 0/8] Fixes and cleanup for RS485
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vz@mleia.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220710164442.2958979-1-LinoSanfilippo@gmx.de>
 <YssdxGoKAt5Rx2DK@smile.fi.intel.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <YssdxGoKAt5Rx2DK@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rhow1ZI4HAGg0yjWz4+Yj+2OdGHERP8XRPn6pA9qX0TY1msUymX
 NHQDwK1kFqDQ8KktsBSzgTIxYsMdjLxx+/yW6tmPJUWyG5aKI1YTKFmxCrDnqAmrIk89ai1
 tDo4ck0qW41vG+oT1zxpfDQCuTh0NwOEBMbDUeUiWzGaXZRGJSEAnofMbnh1tqUeHPQXcAR
 YvVim4ZcHNkeP8HvNOrHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z7qMOxIUZko=:aDp/fR3ni8Y4/P9UB0ZdcO
 qZ2mBdamnTOe9fWJoSj8srdeKCST+QBYohPPXPpDUcLB3I7YyVd1RwUrz/o8MRvak7ogf5t8G
 ICOtHyRn3yLDQ2HJHb8Ft0zQ7fwbgtI8r9WXUHNJnILhJ/TZO5frRYuzSryvYOiAdav3TOPds
 1rG4feXlkUM1OWDbRVt8HO5OdP33p24Xm3HvaXQgd0ezUR4O6FNySLprl4l2iWKB7/qHkV7cK
 /BA7CLqxmsX/aHuuU134sPVg6EWoP9tOwUntTzu7dUXaElfq05K+aMACDPz4ZBZu27sjjRfGq
 /5w+4aULq+bJbhLh7sdpdCCXDQ/VFaloyzhlckooDehXybm9hyEv8Zizsesrx0Whf1jKWXypj
 YzGUvqx78JUU5tbfAZ6B8WepTENBLMt/Rrgd3BwXiG5Cq1EM4auJBoHl1RDM7/i7Uasa+joIx
 VvbA/h08n5kCFR5dBJgwiIbjmquo1CHmUhvlN3d6+lxC61gA85hrjfaqEU83wLk2QVvrhYeum
 3X7D6ZLb+Htj6f0iz25XSzgIQf7wW1k6EwspdzCDjQu8bcVr+eYInk8iT7+jpJf6fl6RwivoL
 XuP73IMUa/+GFS9hay8/iMpEuamNJpPld5EL3iDdi5d9P4/bMRILqL0b2PyxKn2JiavfvAOg+
 3wxlA37y3uzbPK5QEnb2KDrm1yoKC4fQeZlgX5tAoB6PzhYJUR7FIAj+8qww5feLUdy2+WAHg
 b32oIcv2QEePA6dy1pbuo6tf8sedYPr7ZDaI3nSmK8M1/xv+3mt55F61iwSHluerxj+1p6EyY
 87AM3h1zN/Aqu4nqKm+rxaB1k9rV54LED3WFkDmNN4At3Kmw9M3LVNcojZfBjNVTJFjrC5c7J
 d19y//bxvxyFCuDzRK7sRLe0rGtC69xyh/vECVLM4Fzc8AL4kwxCzheLYkGv4maDpBVEIS27M
 Jd9gzMviqIwm4ZIkNUw4kLtgaeSm9ns6iAyo/qyBGY1wkF6tsnSkpXRUSnE4OomGdADBhuu4Z
 5xLCicZItpeHF7twMIM8ezm0gB2W+8OLvbQTdVQPJqRYThhyFQhL9UddX1GF4x35z5tM1T7q7
 z0kY5zpAj4PYtP9GNbcbkvvvaKfhbuD5vt3nZyNXMlMa6q/qdW3o4Ns7C3k6aw2pL3KHDSuWZ
 AB01MQP1eAhQhQj96jL9bhK+TW+3xbiW51JUeXAOrtAYye6heKzbVQWF18exAmlfwc8oGTKhy
 Ov50isTYNpQEbZvQyQI0MX/DNw+r3MPx9D8EomfK9VYeTU2hkvNy5xYbzO4T8E8PcdYy01Npr
 Gk0oKlAIavHKlU+houKiaNHdUjclfw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10.07.22 20:43, Andy Shevchenko wrote:
> On Sun, Jul 10, 2022 at 06:44:34PM +0200, Lino Sanfilippo wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> The following series includes cleanup and fixes around RS485 in the ser=
ial
>> core and uart drivers:
>>
>> Patch 1: ar933x: Fix check for RS485 support
>> Patch 2: Remove superfluous code in ar933x.
>> Patch 3: Set the rs485 termination GPIO in the serial core. This is nee=
ded
>> 	 since if the gpio is only accessible in sleepable context. It also
>> 	 is a further step to make the RS485 handling more generic.
>> Patch 4: Move sanitizing of RS485 delays into an own function. This is =
in
>> 	 preparation of patch 4.
>> Patch 5: Sanitize RS485 delays read from device tree.
>> Patch 6: Correct RS485 delays in binding documentation.
>> Patch 7: Remove redundant code in 8250_dwlib.
>> Patch 8: Remove redundant code in 8250-lpc18xx.
>
>> Changes in v4:
>> - fixed logical error found by
>> - capitalize "uart" and "gpio" in commit messages
>
> Please, avoid sending sequential version of the series more often than o=
nce per
> a few days, recommended interval is one week.
>

sorry, this was due to the error found by the kernel test robot. I was not=
 sure
if to wait, resend with the same version number or send the next version.
I guess waiting a few days would have been the best option. Will do so nex=
t
time.

Regards,
Lino
