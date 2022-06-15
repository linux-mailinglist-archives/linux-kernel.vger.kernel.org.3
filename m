Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E78454D0DD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358353AbiFOSZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241899AbiFOSZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:25:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88A4725588;
        Wed, 15 Jun 2022 11:25:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6638D153B;
        Wed, 15 Jun 2022 11:25:00 -0700 (PDT)
Received: from [10.57.82.209] (unknown [10.57.82.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9B243F73B;
        Wed, 15 Jun 2022 11:24:55 -0700 (PDT)
Message-ID: <dacd4a2d-a2b9-d2c2-4d47-f030dd01ee25@arm.com>
Date:   Wed, 15 Jun 2022 19:24:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 0/5] power: domain: Add driver for a PM domain provider
 which controls
Content-Language: en-GB
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "max.oss.09@gmail.com" <max.oss.09@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>
Cc:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "broonie@kernel.org" <broonie@kernel.org>
References: <20220609150851.23084-1-max.oss.09@gmail.com>
 <20220613191549.GA4092455-robh@kernel.org>
 <CAMuHMdU+aOw_D3SR6714U_i5WhE8S-FCLdPJaf_+Fncz4aH8VA@mail.gmail.com>
 <CAEHkU3VVM0zUsaKMUGeSzfbLmVJW6rqXGLv7TqaLTEQeXEVkUA@mail.gmail.com>
 <12e3bb72-af2d-653f-b342-c6b4d6a1f292@linaro.org>
 <ddbeba186bf662348e8594f322f750cf89326a66.camel@toradex.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ddbeba186bf662348e8594f322f750cf89326a66.camel@toradex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-15 18:31, Marcel Ziswiler wrote:
> Hi
> 
> On Wed, 2022-06-15 at 10:15 -0700, Krzysztof Kozlowski wrote:
>> On 15/06/2022 09:10, Max Krummenacher wrote:
>>> Hi
>>>
>>> On Tue, Jun 14, 2022 at 9:22 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>>
>>>> Hi Rob,
>>>>
>>>> On Mon, Jun 13, 2022 at 9:15 PM Rob Herring <robh@kernel.org> wrote:
>>>>> On Thu, Jun 09, 2022 at 05:08:46PM +0200, Max Krummenacher wrote:
>>>>>> From: Max Krummenacher <max.krummenacher@toradex.com>
>>>>>>
>>>>>> its power enable by using a regulator.
>>>>>>
>>>>>> The currently implemented PM domain providers are all specific to
>>>>>> a particular system on chip.
>>>>>
>>>>> Yes, power domains tend to be specific to an SoC... 'power-domains' is
>>>>> supposed to be power islands in a chip. Linux 'PM domains' can be
>>>>> anything...
>>>
>>> I don't see why such power islands should be restricted to a SoC. You can
>>> build the exact same idea on a PCB or even more modular designs.
>>
>> In the SoC these power islands are more-or-less defined. These are real
>> regions gated by some control knob.
>>
>> Calling few devices on a board "power domain" does not make it a power
>> domain. There is no grouping, there is no control knob.
>>
>> Aren't you now re-implementing regulator supplies? How is this different
>> than existing supplies?
> 
> I believe the biggest difference between power-domains and regulator-supplies lays in the former being driver
> agnostic while the later is driver specific. Meaning with power-domains one can just add such arbitrary
> structure to the device tree without any further driver specific changes/handling required. While with
> regulator-supplies each and every driver actually needs to have driver specific handling thereof added. Or do I
> miss anything?
> 
> We are really trying to model something where a single GPIO pin (via a GPIO regulator or whatever) can control
> power to a variety of on-board peripherals. And, of course, we envision runtime PM actually making use of it
> e.g. when doing suspend/resume.

FWIW, this really seems to beg the question of PM support in the drivers 
for those peripherals. If they'll need to be modified to add 
suspend/resume routines anyway, then adding a handful more lines to 
control a supply regulator at the same time shouldn't be too big a deal. 
Conversely, I'd be surprised if they *did* have PM support if there 
wasn't already some way to make use of it.

Multiple consumers sharing a voltage rail provided by a single regulator 
is so standard and well-supported that it barely seems worth pointing 
out, but for the avoidance of doubt I shall. Adding a new non-standard 
way to hide a specific subset of regulator functionality behind behind a 
magic driver because it seems like slightly less work than handling it 
the well-known established way sounds like a great recipe for technical 
debt and future compatibility headaches. What if down the line you end 
up with a situation where if device A is suspended, devices B and C are 
happy to save some power by running the "domain" at a lower voltage? Do 
we stubbornly start duplicating more of the regulator framework in the 
magic power domain driver, or is that the point where we have to switch 
all the consumers to explicit supplies, and get to regret having "saved" 
that effort in the first place...

Cheers,
Robin.
