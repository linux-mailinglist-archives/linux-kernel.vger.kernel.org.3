Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF095AD09D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbiIEKuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbiIEKuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:50:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8CA37F8C;
        Mon,  5 Sep 2022 03:50:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 253FA61204;
        Mon,  5 Sep 2022 10:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B41C433D6;
        Mon,  5 Sep 2022 10:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662375007;
        bh=EHQgT2kna3Y6eAhTy7QPh0JlRWLoWfGXHdpd7U9Gk2k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OhOa07d5RlhmT0uPQNb6xaT8bs6d+oL81i+K/vmlkALy8jPqlA4Gx1vu7f4XKPkOV
         6uaCYaX12LjiYiFJ83haOqlirDe8aphygfiHSEuXFCpye2tcZiG8mw6yIbuJ1BAEMZ
         46OQu2jHuh1LA544FHM9B24e3vQn+HKPN9fp5BTkb17iqVp3T92q+lX+LYWmyv+E6Y
         65MX3lm08BOObx3xU91itMG0fu0cwIaL1ZGoS7PCdviaBVasXgx/6M8ZSHBX7nzd2u
         MVearoIBzk/n0AcFwG9aYc8XEQsxS0BTcXwqLPxjcHjecYjpQ9FVlAEkSjAStceQCZ
         h+uLMoMZhnj1g==
Message-ID: <e4d7bbed-019a-a522-f8bb-86e610190171@kernel.org>
Date:   Mon, 5 Sep 2022 12:50:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 4/4] mfd: Samsung: Add Samsung sysmgr driver
Content-Language: en-US
To:     Jesper Nilsson <Jesper.Nilsson@axis.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "dj76.yang@samsung.com" <dj76.yang@samsung.com>,
        Lars Persson <Lars.Persson@axis.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "javierm@redhat.com" <javierm@redhat.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Wangseok Lee <wangseok.lee@samsung.com>
References: <CGME20220713045746epcms1p302c6643d12ed505d24298e1edb5889ec@epcms1p3>
 <20220713045746epcms1p302c6643d12ed505d24298e1edb5889ec@epcms1p3>
 <f0ab0036-54eb-f0e4-3169-740e7fca9c65@linaro.org>
 <20220901122013.GU22198@axis.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220901122013.GU22198@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2022 14:20, Jesper Nilsson wrote:
> Hi,
> 
> 
> Thanks for your comments Krzysztof and sorry for being late in replying, I'll
> try to fill in the blanks for some of the issues below.
> 
> 
> The ARTPEC-8 is derived from a Samsung design, but built to order for Axis, so
> long term responsibility will fall to Axis (me and Lars primarily).

Sure, yet still the code looked quite generic, not Artpec specific. At
least as far as I remember, because it was long time ago since I
commented on this. This looked like generic driver, so not really tied
to SoC platform, so it deserves even merging with existing similar drivers.

It is very likely that Samsung will re-use this bloc for several other
customers wanting FPGA, so it should not be made specific to Artpec.
Naming "samsung xxx" is okay (if it cannot be merged to existing FPGA
manager driver), but then make it a separate maintainer entry, add you
(Axis/Artpec folks), me and maybe someone from Samsung as maintainers.

> The ARTPEC-6 and ARTPEC-7 were built by an other vendor and are quite different
> not to mention that they are 32-bit ARMs, compared to ARM 64-bit for the ARTPEC-8.
> 
> 
> The driver in this patchset is derived from the drivers/mfd/altera-sysmgr.c and
> solves the same problem, in where the SoC system controller IP is a collection
> of registers that controls quite a lot of different peripheral functions (from
> PCIe and Ethernet to PWM) and is reachable only through SMC calls. I think the
> naming of the software was set as samsung-sysmgr since it is not Axis design at
> all, but (to my knowledge) only existing in ARTPEC-8 as yet. I can't recall why
> the mfd driver route was selected, but it could be that the earlier
> implementation was more complex and used both smc and direct mmio writes.
> 
> The users of this system manager would initially be the ARTPEC-8 DWC EQoS and
> ARTPEC-8 DWC PCIe drivers sent in other patch-sets.

The patchset did not contain or reference (if I remember correctly) any
 users of exposed public API, so it cannot be accepted. One cannot add
API and not use it. With users and description of the problem the driver
is solving, it's different case... but the patchset lacked both.

> I believe a possible alternative to solve the system manager problem is to open
> code the SMC calls directly from the drivers in question, quite a lot of
> drivers seem to do this, notably a specific altera driver
> (drivers/edac/altera_edac.c) even though it also has a reference to the above
> mentioned altera-sysmgr regmap... :-)
> 
> Does that seem reasonable?

Exposing SMC firmware pieces with dedicated firmware driver is already
practiced, although I don't know whether it is recommended or not. The
driver however did not expose it and instead rather was creating unused,
undocumented loophole (at least that was my impression... but again -
long time ago).

Several drivers are using ARM SMC calls, so using this would be probably
OK. If ARM SMC calls work in this case - use it and most problems are gone.

Recently Apple M1 SMC driver is being upstreamed and I did not see any
objections to its concept.

> 
> Thanks for your patience and excuses for the top-posting.
> 
> /Jesper

Best regards,
Krzysztof
