Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB7557C69B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiGUIks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiGUIk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:40:28 -0400
X-Greylist: delayed 418 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Jul 2022 01:40:27 PDT
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B455D3718C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:40:27 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-160-236.tukw.qwest.net [174.21.160.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 2D1C6368;
        Thu, 21 Jul 2022 01:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1658392409;
        bh=JTCX2RPG9UJuRluX0zfDraxLCvMLDl+tZnvWVUgS2W8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EFRhza/ucYPcmdZg9HdiNyv1g8I84hZvm8xkIF+gCp9e3e06hgT5W2q5YPjsgCPBI
         Ngzjfq3o58VMd0WcSvRUbyVVdHSDiwDXqwn2RrrJD+JfiY+mxhJDVsfpY2CH+G7Erw
         5nNvPoqusCMnd/bq7bt4DLEBL7GZsLIv6DDEzrQY=
Date:   Thu, 21 Jul 2022 01:33:20 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: regulator: add bindings for
 output-supply
Message-ID: <YtkPUOh5XiQyGLxw@hatter.bewilderbeest.net>
References: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
 <20220707081826.953449-3-Naresh.Solanki@9elements.com>
 <20220714141041.GB2229197-robh@kernel.org>
 <YtAkwcwXaQqZV75d@sirena.org.uk>
 <CAL_JsqKu_HCDoPBTcVdVV2JyD_8p3+cbrNC0u6VrK85vWZmt3Q@mail.gmail.com>
 <YtArbh4a40cACRMt@sirena.org.uk>
 <CAL_Jsq+KRyE3i3CkPKopGgFvL+h0pT3R-d3aZNgVmKyiTy3gjw@mail.gmail.com>
 <YtA8KOLDIsEH+okf@sirena.org.uk>
 <CAL_JsqKCByvNASAxRWV3bcjFSBjXZUQf0Xvv_dCZ0z1CRCcOKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAL_JsqKCByvNASAxRWV3bcjFSBjXZUQf0Xvv_dCZ0z1CRCcOKA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 09:59:48AM PDT, Rob Herring wrote:
>+Zev
>
>On Thu, Jul 14, 2022 at 9:54 AM Mark Brown <broonie@kernel.org> wrote:
>>
>> On Thu, Jul 14, 2022 at 09:07:49AM -0600, Rob Herring wrote:
>> > On Thu, Jul 14, 2022 at 8:43 AM Mark Brown <broonie@kernel.org> wrote:
>>
>> > > Consider for example a BMC (IIRC that's what their specific product is),
>> > > a bench supply or some automated test equipment.  Part of the function
>> > > for these systems is to provide power to other systems which would be
>> > > represented as a root or wall supply in the description of the system
>> > > that actually uses the supply if it were described using DT.
>>
>> > Didn't someone else have a similar use recently? Controlling some
>> > supply external to the system. I can't seem to find it now.
>>
>> IIRC that was an earlier iteration of the same thing - it's been round
>> the houses a bit.  extcon seemed like it might be a home since these are
>> external connections from the system but in the end people didn't think
>> it looked like a good fit.
>
>Found it:
>
>v1: https://lore.kernel.org/all/20220504065252.6955-2-zev@bewilderbeest.net/
>v2: https://lore.kernel.org/all/20220505232557.10936-1-zev@bewilderbeest.net/
>
>v2 was the using extcon version. v1 looks pretty similar to this one
>though anything that's just a compatible plus supplies would.
>
>But AFAICT these 2 submissions are completely independent.
>

Thanks for looping me in here Rob, I hadn't been aware of this series.

Naresh, I'd appreciate it if you could CC me on any subsequent 
iterations; as linked above I've made some sporadic attempts at getting 
support for this functionality merged, and am certainly interested in 
any other efforts on that front.

A question for Mark though -- in one of my earliest stabs at this I 
floated the idea of using reg-userspace-consumer for it, but was told in 
no uncertain terms that that driver was for testing only and should 
under no circumstances ever be instantiated in a production system.  Has 
the thinking on its usage changed in the last year or so such that this 
approach was deemed okay?


Thanks,
Zev

