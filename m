Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804F158677A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiHAK3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiHAK2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:28:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B94019C00;
        Mon,  1 Aug 2022 03:28:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 114A4139F;
        Mon,  1 Aug 2022 03:28:43 -0700 (PDT)
Received: from bogus (unknown [10.57.11.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4978D3F67D;
        Mon,  1 Aug 2022 03:28:41 -0700 (PDT)
Date:   Mon, 1 Aug 2022 11:28:38 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mailbox: arm,mhu: Make secure interrupt
 optional
Message-ID: <20220801102838.u3hcziiwts7bpxt2@bogus>
References: <20220728190810.1290857-1-robh@kernel.org>
 <CABb+yY2jV7c8oX7=F=nocfvGrOMHJAYov7zS2nT0=qFoNyoxJQ@mail.gmail.com>
 <CABb+yY0JzztBB+giBu+RCt-dzgwYWF32sCR3WKKP9U5K9UvhxA@mail.gmail.com>
 <20220729111051.5me4vklrzskvsj4w@bogus>
 <CAL_JsqLwk+=CeDWqXzhrVESzhJnNjOjyR-TtisKGgjMUi7TivQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLwk+=CeDWqXzhrVESzhJnNjOjyR-TtisKGgjMUi7TivQ@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 05:17:26PM -0600, Rob Herring wrote:
> On Fri, Jul 29, 2022 at 5:10 AM Sudeep Holla <sudeep.holla@arm.com> wrote:

[...]

> >
> > No this doesn't work IMO. Yes standalone everything looks fine, but you can
> > insert a module requesting this channel and bring down the system. So I am
> > not for this change.
>
> Not having the interrupt listed in DT doesn't prevent that. Is this
> security by obscurity?
>

I agree, as I mentioned in the other thread, if we had a way to mark that
channel as used elsewhere or disabled or unavailable, it would have been
great.

> I don't really care which way this is fixed though.

Understood.

> I just want the warning gone. We've all got better things to worry about.

Agreed.

> The DT not having the interrupt has been that way for years (presumably)
> and the kernel never needs the interrupt, so the schema should reflect
> reality.

I prefer this approach.

> On the flip side, considering it *can* be present already, there's not
> really much argument for not having it.
>

Can't disagree/argue that 😄.

--
Regards,
Sudeep
