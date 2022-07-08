Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042A956BDC6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbiGHQFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238368AbiGHQFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:05:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2833376E92;
        Fri,  8 Jul 2022 09:05:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCE5E61E0C;
        Fri,  8 Jul 2022 16:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4C1C341C0;
        Fri,  8 Jul 2022 16:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657296332;
        bh=JefiE6hn4GGAi5d/hMAhgEIxdj1+a6Tc7d5lQkIB1vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cDM+Z62uOBHFET6KSRrG+a7pXjeS0FU+vp9Sd9y/be8mn5cZNNIDk6TsKQifMxRyM
         gO99IUkzAJWGYKnCBeYzLP4pwRk+iO3p7aBDJhHV+wYsV0/+ZRU81g1wtvEMo1LYuO
         ZWzrGzG/B8ze1OEhnuAJw8BroTajJHyXuCSJe/YUsmuQnNysXiV+/UEyHPrvL5RtJx
         9MWj4YcI5zS2+8cE3fVJwv22n1ApOYkKFdtyKvlHrAzbxuxNT6Bso+PwsuDbxcDPF9
         RCmw5fEjTnuQRUdWdaA7cwFpwbC+TNfL55ykF1+wiN+VVIvwOMWdUHDY1BVGOXXyDH
         dVnnmyak4BujQ==
Received: by pali.im (Postfix)
        id C3DB57D1; Fri,  8 Jul 2022 18:05:28 +0200 (CEST)
Date:   Fri, 8 Jul 2022 18:05:28 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] [RFT] dt-bindings: leds: Add
 cznic,turris1x-leds.yaml binding
Message-ID: <20220708160528.ysy4lzxfpwobfiwr@pali>
References: <20220705000448.14337-1-pali@kernel.org>
 <20220705155929.25565-1-pali@kernel.org>
 <20220706131507.353f0bed@thinkpad>
 <20220706111912.hz2mx4dc35lgq6l5@pali>
 <20220706172732.6228d180@thinkpad>
 <25b43586-eeb3-4b7b-7362-2d599aa89cf0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25b43586-eeb3-4b7b-7362-2d599aa89cf0@linaro.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 July 2022 17:36:43 Krzysztof Kozlowski wrote:
> On 06/07/2022 17:27, Marek Behún wrote:
> > On Wed, 6 Jul 2022 13:19:12 +0200
> > Pali Rohár <pali@kernel.org> wrote:
> > 
> >> On Wednesday 06 July 2022 13:15:07 Marek Behún wrote:
> >>> On Tue,  5 Jul 2022 17:59:28 +0200
> >>> Pali Rohár <pali@kernel.org> wrote:
> >>>   
> >>>> +examples:
> >>>> +  - |
> >>>> +    #include <dt-bindings/leds/common.h>
> >>>> +
> >>>> +    cpld@3,0 {  
> >>>
> >>> The generic node name should be just "bus". That it is a CPLD
> >>> implementation should come from compatible string.  
> >>
> >> Sorry, I do not understand why "bus". Why other memory chips are named
> >> e.g. "nand" or "nor" and not "bus" too?
> > 
> > As far as I understand this is because that is the preferred name for
> > busses and this is a bus, since there is also the simple-bus compatible.
> > 
> >> By this logic should not be _every_ node called just "bus"? Hm... and 
> >> are names needed at all then?
> > 
> > :-)
> > 
> > The schema
> >   https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/simple-bus.yaml
> > allows for different names (soc|axi|ahb|*-bus) to avoid warnings on
> > existing old dts files.
> > 
> > The preferred way is to not have the implementation in nodename,
> > similar to how we use 'switch' instead of 'mv88e6xxx', or
> > 'ethernet-phy' instead of 'mv88e151x', or 'led-controller', ...
> 
> Thanks Marek for detailed explanation.
> The cases above rather trigger my comments and this one here, after
> Pali's explanation, do not fit them. pld is a generic class of a device,
> so it is okay here. cpld probably as well (although one could argue that
> it is a subset of pld, so the generic name is pld, but then one would
> say fpga also should be called pld). For me it does not have to be bus,
> just don't want mv88e6xxx or any other vendor/model names. Therefore
> cpld is fine.

Exactly. cpld, fpga, nor, nand, soc... all of them are not real buses.

simple-bus here is just name invented by device tree and without which
existing kernel drivers refuse to work.

> > 
> > I wasn't there when people started requesting for this to be that way,
> > but I guess it makes some sense to make it more readable and less
> > redundant (the generic name in nodename and the implementation in
> > compatible string...).
> 
> 
> 
> 
> Best regards,
> Krzysztof
