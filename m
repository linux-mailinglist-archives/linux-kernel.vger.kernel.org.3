Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B589D4792C1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239866AbhLQRXF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Dec 2021 12:23:05 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:57571 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239847AbhLQRXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:23:03 -0500
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id DAD12200008;
        Fri, 17 Dec 2021 17:23:00 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 0/6] serial: mvebu-uart: Support for higher baudrates
In-Reply-To: <20211103214209.azo2z3z4gy7aj5hu@pali>
References: <20210930095838.28145-1-pali@kernel.org>
 <20211103214209.azo2z3z4gy7aj5hu@pali>
Date:   Fri, 17 Dec 2021 18:23:00 +0100
Message-ID: <87ee6bm9hn.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pali,

> On Thursday 30 September 2021 11:58:32 Pali Rohár wrote:
>> This patch series add support for baudrates higher than 230400 on
>> Marvell Armada 37xx boards.
>
> Stephen, Gregory, are there any issues with this patch series?

I am not found of these changes but let's apply it as I didn't take time
to do a better review.

However I can't apply the dt part if the driver is not merged.

Gregory

> If not, could you take them?
>
>> Changes in v7:
>> * fixed lint errors in yaml binding file
>> 
>> Changes in v6:
>> * fixed yaml binding file and dts files
>> 
>> Changes in v5:
>> * fixed yaml binding file
>> 
>> Changes in v4:
>> * converted armada3700-uart-clock documentation to YAML
>> * split documentation changes into two commits:
>>   - first which adds clock documentation
>>   - second which updates UART documentation
>> 
>> Changes in v3:
>> v3 is rebased on top of Linus master branch and all already applied patches
>> were dropped. There are no changes in patches itself since v2.
>> 
>> Pali Rohár (6):
>>   math64: New DIV_U64_ROUND_CLOSEST helper
>>   serial: mvebu-uart: implement UART clock driver for configuring UART
>>     base clock
>>   dt-bindings: mvebu-uart: document DT bindings for
>>     marvell,armada-3700-uart-clock
>>   dt-bindings: mvebu-uart: update information about UART clock
>>   arm64: dts: marvell: armada-37xx: add device node for UART clock and
>>     use it
>>   serial: mvebu-uart: implement support for baudrates higher than 230400
>> 
>>  .../clock/marvell,armada-3700-uart-clock.yaml |  59 ++
>>  .../devicetree/bindings/serial/mvebu-uart.txt |   9 +-
>>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  14 +-
>>  drivers/tty/serial/Kconfig                    |   1 +
>>  drivers/tty/serial/mvebu-uart.c               | 592 +++++++++++++++++-
>>  include/linux/math64.h                        |  13 +
>>  6 files changed, 667 insertions(+), 21 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml
>> 
>> -- 
>> 2.20.1
>> 

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
