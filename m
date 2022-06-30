Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD5E5618F5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbiF3LVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiF3LVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:21:09 -0400
X-Greylist: delayed 14884 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Jun 2022 04:21:08 PDT
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C21B4D4DB;
        Thu, 30 Jun 2022 04:21:08 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkwl20tj04snw15cjtflt-3.rev.dnainternet.fi [IPv6:2001:14ba:4493:6f40:fec3:d72a:e447:8113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 29C531B00133;
        Thu, 30 Jun 2022 14:21:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1656588065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Om+OpDyQIreIpgpFOfELMTrYK26Uts1/YQlZSumoqGY=;
        b=SnaA2SrAlcFUGg/SXvidZlbbqCNgSW2gjlY6NS6tqhNAMzIHRzGqztn/6JWMmoZHGXTadN
        2RzsAdQfGn6D3bgEmMpghNfvrhGxGNw+Bjsx6nnDE68wFwPQVAFV9tfUGCJtiNcjIM911f
        gdSjMNIpuTggZcRMwizO8xdsqlA1PWYX6GxFPTGuj+mCDon0LLH+Uc/icxGEJwgXK3ItDl
        CGGrQ4EM+xHrYFx43Mr9AwfASoS7ez3fExc0ZiRallSxKX0PdQ/K1CKuGT1tbBNx8qgbpS
        MTGghfKY6y8FuQu0zF/pclw+0kX8O8hA7a1a7TJBEHgT1F+OqhVCnZ2xrq1Cng==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id B6F86634C92;
        Thu, 30 Jun 2022 14:21:04 +0300 (EEST)
Date:   Thu, 30 Jun 2022 14:21:04 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Jacopo Mondi <jacopo@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] media: dt-bindings: ov5693: document YAML binding
Message-ID: <Yr2HIPr7kIxbwSWB@valkosipuli.retiisi.eu>
References: <20220630074525.481790-1-tommaso.merciai@amarulasolutions.com>
 <20220630074525.481790-6-tommaso.merciai@amarulasolutions.com>
 <167f09c1-795d-1471-20f7-9f4df29355ed@linaro.org>
 <20220630090232.GC482517@tom-ThinkPad-T14s-Gen-2i>
 <Yr1pD2U2ilXXXX+Q@valkosipuli.retiisi.eu>
 <20220630091613.GD482517@tom-ThinkPad-T14s-Gen-2i>
 <Yr1xzeqW2p4jVDzS@valkosipuli.retiisi.eu>
 <20220630100957.GE482517@tom-ThinkPad-T14s-Gen-2i>
 <3fcbbea3-6c1e-723b-cc20-9a2454d2ad50@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fcbbea3-6c1e-723b-cc20-9a2454d2ad50@gmail.com>
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1656588065; a=rsa-sha256;
        cv=none;
        b=cPE27uwKRoSffOPugyb1uwBnp6w0kqwIb7+9yYeIsU0UhiOWmvvD4s9PIpQME9XXMO6EfF
        uoIc5GDa89opn9fukNg5rl+sRP7R+uG+pTr6ymEigLvg9s1TfQDO18uLZ6AXmrxHePVIVj
        x2FAdT+RQSClh33UzcJZ7ROETGwe3G6yoFfeSgmXaesZTkMnJ5e8/V/UziF4uxF0ZtuDFs
        IT81cHwRkmavKA84MIuwggQn7UcgewDcSpiW5ztX32ez79ao6bNxJrIBsrX9hv+v0V0TWX
        rg8ko0+7r0/WAISfJnhCKe9dm/f+FQhu2qYHfZ+ahEGPwCZGm5cEI+y3VnqD8g==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1656588065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Om+OpDyQIreIpgpFOfELMTrYK26Uts1/YQlZSumoqGY=;
        b=n2JLrjCkL64bsUUwBhhWV7QrkhvGOuaA5maQ5wIyeqVFw9iOAl8EYqUJji1e9wmZ2bbV8T
        S6vK7B42YSJz08ds7DLQEHZ4Z21xfotnoZWqIGJNCrnY7VjV0na0tk73HKJy741rMHperM
        PGaUf80MX2pC8ZTBC2Jg/Jq5+AZ/nf/rK+G2zkqM5pV9J9lEUZP8J7AeX9qIJCEcg+GAMm
        88NhCymnuTaSDkeInvwZMiEGoCh4Mmn+2bUugNKK6M7/kncaJbzHl1oQqDBSuW6Yr2Jnq2
        yHIdybJp9AAVq94wqRVFZ7UU/lwyEuRQPHnhfk6/JVe37aVKZ/m6YcG9qyJGyg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 11:15:40AM +0100, Daniel Scally wrote:
> Hello
> 
> On 30/06/2022 11:09, Tommaso Merciai wrote:
> > Hi Sakari,
> >
> > On Thu, Jun 30, 2022 at 12:50:05PM +0300, Sakari Ailus wrote:
> >> Hi Tommaso,
> >>
> >> On Thu, Jun 30, 2022 at 11:16:13AM +0200, Tommaso Merciai wrote:
> >>> Hi Sakari,
> >>>
> >>> On Thu, Jun 30, 2022 at 12:12:47PM +0300, Sakari Ailus wrote:
> >>>> On Thu, Jun 30, 2022 at 11:02:32AM +0200, Tommaso Merciai wrote:
> >>>>> On Thu, Jun 30, 2022 at 10:07:19AM +0200, Krzysztof Kozlowski wrote:
> >>>>>> On 30/06/2022 09:45, Tommaso Merciai wrote:
> >>>>>>> Add documentation of device tree in YAML schema for the OV5693
> >>>>>>> CMOS image sensor from Omnivision
> >>>>>>>
> >>>>>>> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> >>>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>>>>> Reviewed-by: Sakari Ailus <sakari.ailus@iki.fi>
> >>>>>> How Sakari's tag appeared here? There was no email from him.
> >>>>> Sakari made me some review on v2, but I think he forgot to add the mailing
> >>>>> list in cc. ( I suppose :) )
> >>>>>
> >>>>> Let me know if I need to remove this.
> >>>> You're only supposed to put these tags into patches if you get them in
> >>>> written form as part of the review, signalling acceptance of the patch in
> >>>> various forms. Just commenting a patch does not imply this.
> >>>>
> >>>> Please also see Documentation/process/submitting-patches.rst for more
> >>>> information on how to use the tags.
> >>> Thanks for sharing this. My bad.
> >>> I remove your tags.
> >> The patches themselves seem fine. I'd just drop the 4th patch or at least
> >> come up with a better name for ov5693_hwcfg() --- you're acquiring
> >> resources there, and that generally fits well for probe. The code is fine
> >> already.
> > Then we don't need v5 with your reviewed tags removed?
> >
> > I think the patch4 is needed to add dts support properly.
> > Also this contains devm_clk_get_optional fix suggested by Jacopo and
> > support for ACPI-based platforms that specify the clock frequency by
> > using the "clock-frequency" property instead of specifying a clock
> > provider reference.
> 
> 
> I agree patch 4 in some form is needed - I didn't do the clock handling
> particularly well in this driver, and though it's ostensibly an ACPI
> driver it wouldn't actually work with a "normal" ACPI, but just with the
> cio2-bridge-repaired style. So the changes to the clock handling logic
> are welcome and needed I think. whether it needs to go into a separate
> function I don't particularly mind either way.

Yes, the clock handling needs to be changed. But I'd keep it in probe.

-- 
Sakari Ailus
