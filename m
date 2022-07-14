Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBA9575656
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbiGNUZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiGNUZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:25:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27D71E3E4;
        Thu, 14 Jul 2022 13:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BE8A6222E;
        Thu, 14 Jul 2022 20:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F839C34115;
        Thu, 14 Jul 2022 20:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657830346;
        bh=FhIKhIYhRK71ucJvwaPwDTehtabRlgM5Sr6TUUsrpgY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FzCWQTznCPdsJxZOTczXvJx5TTOzK27deQ7SBg4/OtI1DglpOHA9o7H4JFkBlqMCE
         FDTDIbvd/RmSnELUw01L4uXNaSzRH8LvHanOUuEOi148ruZU4UYOjh/LOulyfP5mQf
         pwBxx/lYri9z6BZQR9xei5jDYNo/Emaip0Ow3ygDbn2G5UQbm/lhKpX7aPyIkDBR64
         1hPDguOHVh88XzLpzBmbe0n4Lgco/7ofBOumLRKK2Dz+xuhuzNZVZvbtAeOcuAvPz0
         xoxbOMhS93UctLq+Sc4aQlH/vzLa7jatULlm8RkSWBQ97n8mfOdxjGOBN+X5IUisdh
         bLFxwzd9ZWIEQ==
Date:   Thu, 14 Jul 2022 22:25:41 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: LED Maintainership
Message-ID: <20220714222541.232eadfb@thinkpad>
In-Reply-To: <YtAIm+X2XchcSkFX@google.com>
References: <Ys/kruf8DE4ISo8M@google.com>
        <20220714112326.GA16407@duo.ucw.cz>
        <YtAIm+X2XchcSkFX@google.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2022 13:14:19 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> On Thu, 14 Jul 2022, Pavel Machek wrote:
>=20
> > Hi!
> >  =20
> > > Not sure what's going on behind the scenes, but it looks as though the
> > > LED subsystem has been left unmaintained for at least 2 months now. =
=20
> >  =20
> > > Does anyone have any objection to me stepping in as temporary
> > > maintainer until the situation is resolved? =20
> >=20
> > Yes, I'm a bit busy and would not mind help.
> >=20
> > There's a lot of easy stuff in the LED -- drivers not introducing new
> > APIs -- and some quite tricky stuff -- userland API leaves... a lot to
> > be desired, and we are in the middle of defining multicolor API.
> >=20
> > I wanted to ask Marek (in cc now) if he would be interested in
> > helping. He knows the APIs / issues, and actually has multicolor LEDs
> > he cares about. Marek, are you interested?
> >=20
> > If Marek is not interested, yes, help with the driver stuff would be
> > welcome. =20
>=20
> No problem.  The offer still stands.
>=20
> I guess Marek and I aren't mutually exclusive either.
>=20
> Any harm in us both helping out (if Marek is also interested that is)?

Hello Lee, Pavel,

I am interested, but unfortunately I won't have much time for reviewing
patches until september.

=46rom september, I would be open to co-maintaining.

Marek
