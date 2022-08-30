Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183C45A5E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiH3IbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiH3IbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:31:08 -0400
Received: from 7of9.schinagl.nl (7of9.connected.by.freedominter.net [185.238.129.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843C87B2B6;
        Tue, 30 Aug 2022 01:30:56 -0700 (PDT)
Received: from [10.2.12.24] (unknown [10.2.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id E4FFE186AC12;
        Tue, 30 Aug 2022 10:30:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1661848252; bh=oiFQlJQtobHEs9OmPUlyusY32kGmWaoxtESk1Cuu4ow=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=ID0cpzuLuFIU4XsfJtqGQHHrUVqItfYKy57lWb/zv6NvkqP+/Z/1YKqT7df8Qd06O
         Eix8jzGHdGQJASRF82BTy/lA9Y8frOeX9107QF1cqhH21jsyW3S2LTEn/IlhyY7qUw
         X6YkTr3WDmhfE1oc3ff4byIM469M2diGWIo9LADQ=
Message-ID: <59a3b7d9-1886-f237-8a6a-374de17da1b5@schinagl.nl>
Date:   Tue, 30 Aug 2022 10:30:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCHv2 resend] dt-bindings: leds: Expand LED_COLOR_ID
 definitions
Content-Language: nl
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Olliver Schinagl <oliver+list@schinagl.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220819152904.433514-1-oliver@schinagl.nl>
 <YwzJMAaYT/frJLaT@ada.ifak-system.com>
 <20220829151334.GA1596856-robh@kernel.org>
From:   Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <20220829151334.GA1596856-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

On 29-08-2022 17:13, Rob Herring wrote:
> On Mon, Aug 29, 2022 at 04:12:00PM +0200, Alexander Dahl wrote:
>> Hei Olliver,
>>
>> Am Fri, Aug 19, 2022 at 05:29:04PM +0200 schrieb Olliver Schinagl:
>>> In commit 853a78a7d6c7 (dt-bindings: leds: Add LED_COLOR_ID definitions,
>>> Sun Jun 9 20:19:04 2019 +0200) the most basic color definitions where
>>> added. However, there's a little more very common LED colors.
>>>
>>> While the documentation states 'add what is missing', engineers tend to
>>> be lazy and will just use what currently exists. So this patch will take
>>> (a) list from online retailers [0], [1], [2] and use the common LED colors
>>> from there, this being reasonable as this is what is currently available to
>>> purchase.
>>>
>>> Note, that LIME seems to be the modern take to 'Yellow-green' or
>>> 'Yellowish-green' from some older datasheets.
>> Just noticed you did not send this to neither linux-leds mailing list
>> nor the LED subsystem maintainer. Maybe you want to do this in v3?
> Yes, please do. If Pavel doesn't pick up v3 in a timely manor, then I
> will.
>
> Rob

Sorry to both, get_maintainers didn't pop those up!

As Krzyzstof Acked the v2, and no comments for a v3 have been proposed, 
would that be a changeless v3 just to involve all parties?

Thanks,


Olliver

