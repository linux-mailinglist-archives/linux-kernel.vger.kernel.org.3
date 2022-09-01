Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7725A8A5C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiIABMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiIABMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:12:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2626C11C179
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:12:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso536533wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=oiRKibOWnwcDr9MycfE0W4welp6qByX+iDD5DjNb+M8=;
        b=neSWI5SrQVJX2N0BbmSZyD5btOBzGyzzq9dar/Rs/7HVXdqflXxQVTzZW4tz/x68yg
         r+AHr/uCx+rIWgEfog9OtwRSD5jt1ThIhg0oeWbCr+6h2bshtUaWJFCguJRnGsHxtCS/
         PVBmHnKRmocIlDNChnjM8tr/3sDYKVaX7fc1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=oiRKibOWnwcDr9MycfE0W4welp6qByX+iDD5DjNb+M8=;
        b=XqXOsOYKD/vL/+NkltPdhH265aVrIya+dRRgKzUEqf8XJFEYf/W0xbO5huyWIpKElY
         6QmypzNzGpURqmIQja5DzKLuQfqNB/QVkRj2X1QP07QVQYZ8TlspzOgjfh80ks0c/ntd
         wEfFYA+WU8lILIWQYVccOZHaGCZzwP77ekHl9BKrkoXvqfQ7KO71kx+0H8KOKsT19+G3
         eSUomS3IU/xqEz7CaIaNVk4NGeEdXMfaBP7tBAZt4MwYcxxclmgXXt+TbQa80uO98Q2b
         oDCuBJWxBNOMM3nEMTaHsrjt+mcYu2acLZ50xB5NLmOFUnWhngoe6E4vO+tfLeUcoQ67
         hHpQ==
X-Gm-Message-State: ACgBeo0Tec1kuPijrRlGKCgsNUrRgoC33HcsbOUFb25rUBJS/4jOnQes
        IH78dry0HyJSDSQnuYcvqdYko2Yjq6lZINJfeFXbspF3nO4=
X-Google-Smtp-Source: AA6agR5GatofRchhs7w0hTPqWcUW7vhKebjxJj5Hfk40e0mwziDDMVQLZapn8Hj+iaDsM8K/3zxb/1M/PJhxuPFZUUY=
X-Received: by 2002:a05:600c:3b10:b0:3a5:3357:ecf4 with SMTP id
 m16-20020a05600c3b1000b003a53357ecf4mr3457812wms.193.1661994718395; Wed, 31
 Aug 2022 18:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220831013359.1807905-1-jwerner@chromium.org>
 <20220831013359.1807905-5-jwerner@chromium.org> <63c350a0-2393-208b-4fab-94db050407c2@linaro.org>
In-Reply-To: <63c350a0-2393-208b-4fab-94db050407c2@linaro.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Wed, 31 Aug 2022 18:11:46 -0700
Message-ID: <CAODwPW-9njhmjf1jEYsm68-StqciovgXo8VFBYksrdmqDJGC7g@mail.gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: memory: Add jedec,lpddrX-channel binding
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +description:
> > +  An LPDDR channel is a completely independent set of LPDDR pins (DQ, CA, CS,
> > +  CK, etc.) that connect one or more LPDDR chips to a host system. The main
> > +  purpose of this node is to overall LPDDR topology of the system, including the
> > +  amount of individual LPDDR chips and the ranks per chip.
>
> "channel" in this context confuses me a bit, because usually everyone is
> talking about DDR controller channels, not memory channels. I think this
> actually maps to a DDR controller channel?

I'm not really sure what you mean by "memory channel" here (that would
be different from the DDR controller channel)? According to my
understanding there's only one kind of "channel" in the context of
main memory, that's the DDR controller channel (i.e. each separate
complete set of DDR pins coming out of the controller, as I tried to
explain in the description).

> > +    lpddr-channel1 {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +      compatible = "jedec,lpddr4-channel";
> > +      io-width = <32>;
>
> I wonder now, how does it exactly work - channel is 32 bits, two ranks
> each with 32 bit IO bus. Your description said that:
>
> total_ram = (rank0 + rank1) * (channel_width / chip_width)
> so for this case: (4+2)*(32/32) = 6 Mbit
>
> If channel io-width = <64>, then memories are stacked in parallel and
> according to your description total RAM would be: (4+2)*(64/32) = 12 Mbit
> I wonder why stacking memories in parallel increases their size?

Well, stacking in parallel just means you have more of them? In the
original example, you have a single LPDDR chip with two ranks, one
4Gbit rank and one 2Gbit rank. That chip is directly hooked up to the
LPDDR controller and that's the only chip you have, so you have 4+2 =
6Gbit total memory in the system.

In your next example, the LPDDR controller has a 64 bit wide channel,
but you're still using that same 6Gbit LPDDR chip that only has 32 DQ
pins. The only way to fill out that 64 bit channel with this kind of
chip is to have two of them in parallel (one connected to DQ[0:31] and
one connected to DQ[32:63]). So we infer from the mismatch in io-width
that we have two chips. Each chip still has 6Gbit of memory, so the
total system would have 12Gbit.
