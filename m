Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB859568CBA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiGFP1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiGFP1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:27:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A36C29;
        Wed,  6 Jul 2022 08:27:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C9DE6CE1FF3;
        Wed,  6 Jul 2022 15:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A993EC3411C;
        Wed,  6 Jul 2022 15:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657121263;
        bh=pzDkkZF4zwiLIMVduMcEQXRah9THlaVSc9/xibzqO6w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kpKrtpkIIHrOr2yO/+Ok6rPw50lR92dFVr8RjKtD2T3XE+XGs/yh7qem2hvYYkmpI
         UYgJ4/LStRM9ZAd7ddEWAQJciintk4J0HXlmt2OFiJUKUntODyKVo+iCnkmMs3iHaO
         7PAb8GuIuMeZD8q+bUQ15EhFFGxccev3QjgTqnv6eUgm5LnJ2AqbonImE2NjGvMCYt
         mf1x1iKNjrTz/WGwKtxfbZUy/16HBne7F6rG91NFN+mAZLy31B4rIyieH5EZweRWRA
         Lc65a1XiU62XXny+RW1NWHdO8gk8MZNktBpLuhv7eJDXGUZ1+xyqyvBgkXHe3x69+2
         AHUtumixbliug==
Date:   Wed, 6 Jul 2022 17:27:32 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] [RFT] dt-bindings: leds: Add
 cznic,turris1x-leds.yaml binding
Message-ID: <20220706172732.6228d180@thinkpad>
In-Reply-To: <20220706111912.hz2mx4dc35lgq6l5@pali>
References: <20220705000448.14337-1-pali@kernel.org>
        <20220705155929.25565-1-pali@kernel.org>
        <20220706131507.353f0bed@thinkpad>
        <20220706111912.hz2mx4dc35lgq6l5@pali>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2022 13:19:12 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> On Wednesday 06 July 2022 13:15:07 Marek Beh=C3=BAn wrote:
> > On Tue,  5 Jul 2022 17:59:28 +0200
> > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> >  =20
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/leds/common.h>
> > > +
> > > +    cpld@3,0 { =20
> >=20
> > The generic node name should be just "bus". That it is a CPLD
> > implementation should come from compatible string. =20
>=20
> Sorry, I do not understand why "bus". Why other memory chips are named
> e.g. "nand" or "nor" and not "bus" too?

As far as I understand this is because that is the preferred name for
busses and this is a bus, since there is also the simple-bus compatible.

> By this logic should not be _every_ node called just "bus"? Hm... and=20
> are names needed at all then?

:-)

The schema
  https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/si=
mple-bus.yaml
allows for different names (soc|axi|ahb|*-bus) to avoid warnings on
existing old dts files.

The preferred way is to not have the implementation in nodename,
similar to how we use 'switch' instead of 'mv88e6xxx', or
'ethernet-phy' instead of 'mv88e151x', or 'led-controller', ...

I wasn't there when people started requesting for this to be that way,
but I guess it makes some sense to make it more readable and less
redundant (the generic name in nodename and the implementation in
compatible string...).

Marek
