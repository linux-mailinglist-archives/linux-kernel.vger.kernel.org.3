Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B10A473114
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240347AbhLMQCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:02:20 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:37595 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240313AbhLMQCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:02:17 -0500
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id B91881BF20F;
        Mon, 13 Dec 2021 16:02:12 +0000 (UTC)
Cc:     michael.opdenacker@bootlin.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: at91: enable watchdog for SAMA5D3 Xplained
To:     Nicolas Ferre <nicolas.ferre@microchip.com>, robh+dt@kernel.org,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com
References: <20211209154540.6391-1-michael.opdenacker@bootlin.com>
 <9f01d0c7-b5c3-1353-8cc6-ed797e466706@microchip.com>
From:   Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <fead1c9a-ac64-4445-9c8f-e5c8fa9b406a@bootlin.com>
Date:   Mon, 13 Dec 2021 17:02:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9f01d0c7-b5c3-1353-8cc6-ed797e466706@microchip.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On 12/13/21 4:48 PM, Nicolas Ferre wrote:
> On 09/12/2021 at 16:45, Michael Opdenacker wrote:
>> Like on the SAMA5D2 and SAMA5D4 Xplained boards,
>> enable the watchdog device on the SAMA5D3 Xplained board.
>>
>> As explained on drivers/watchdog/at91sam9_wdt.c,
>> for the watchdog driver to work in Linux, you need to make sure
>> that the bootstrap / bootloader doesn't disable the watchdog,
>> as the Watchdog Timer Mode Register can be only written to once.
>>
>> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>
> Hi Michael,
>
> Thanks for your patch.
>
> Even if I understand the need for alignment with other sama5 SoCs, I'm
> not planning to take this patch to enable the watchdog by default.
>
> As you highlight, this older watchdog, compared to the ones on sama5d4
> or sama5d2, cannot be re-enabled.
> On our usual prebuilt demos and configurations, that don't have
> watchdog support by default, enabling it triggers the following errors:
> at91_wdt fffffe40.watchdog: watchdog is disabled
> at91_wdt: probe of fffffe40.watchdog failed with error -22
>
> I prefer to let the user enable the watchdog explicitly, on the whole
> chain of components for its use-case and make sure to "pet" it correctly.


Thanks for your review. I understand. It's your call anyway.
At least, this is documented through this discussion in the mailing list
archives :)
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

