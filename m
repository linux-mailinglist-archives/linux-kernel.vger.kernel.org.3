Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D2657F11E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 21:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbiGWTLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 15:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiGWTLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 15:11:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75391B7A0;
        Sat, 23 Jul 2022 12:11:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5897BB80D22;
        Sat, 23 Jul 2022 19:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B20BC341C0;
        Sat, 23 Jul 2022 19:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658603461;
        bh=fqxiXh9Tu4CxhwilohNI2ALOQw6Y+uGzGq9spdMO7fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mrwv2HM8ccI1y5s4Qhrc5+hG9RmfDRMYznnzpHtAzmFT6La+lHClCMR0qcWBbxT2V
         DkqDHALGSxN32iq8/5OAi77QqNRvWFD1wQdIWMjGhH9RDRCbGDRKX2m1pfxTkoTwVz
         u+1HhgTU1/k61fIDrZiB7J4DwvRdnLYqBZJJoqKSKsXd/Vw7LmeK3c5cXXSjeGQGOW
         HPuyDXQcMAhiXI49HYnV4WNSLJmMbxyks4/ptCnNvP1jmZrTnEtMZewOI9HaFuFTrO
         Oh2cfW8orVtFqK5PZ4QSWkbb5HNTD08RaOxZA4GNoz4th5TaT/eKEB8/fg5wXQ7u6C
         6RTI04YYtdSUw==
Date:   Sat, 23 Jul 2022 20:10:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] regulator: core: Allow for a base-load per client to
 come from dts
Message-ID: <YtxHwUe4W7+u3Lk3@sirena.org.uk>
References: <20220721182622.RFC.1.I8a64b707169cfd73d9309c5eaf5d43b8bc4db988@changeid>
 <Ytrq2rVMHqedv4+3@sirena.org.uk>
 <CAD=FV=U-qZQwRdLA8AVwYdcuj_PQEULTnhm3osFybaFmtvjmHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RZLau95uE4lyRc1T"
Content-Disposition: inline
In-Reply-To: <CAD=FV=U-qZQwRdLA8AVwYdcuj_PQEULTnhm3osFybaFmtvjmHg@mail.gmail.com>
X-Cookie: Necessity is a mother.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RZLau95uE4lyRc1T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 22, 2022 at 04:35:48PM -0700, Doug Anderson wrote:
> On Fri, Jul 22, 2022 at 11:22 AM Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Jul 21, 2022 at 06:26:44PM -0700, Douglas Anderson wrote:

> > > Specifically it should be noted that many devices don't really have a
> > > need for the low power mode of regulators. Unfortunately the current

> > What exactly do you mean by "a need for the low power mode of
> > regulators"?

> Let me try to come up with some examples. I'll assume a regulator that
> can go up to 10mA in LPM (low power mode) and 100mA in HPM (high power
> mode). Software needs to switch between LPM and HPM manually. I don't
> have great numbers, but I'll assume that the LDO is 90% power
> efficient in LPM and 40% power efficient in HPM.

I'm familiar with the broad concept of regulators having the
ability to operate in more efficient (but typically lower
quality) modes, we do have the whole infrastructure for selecting
mode based on load after all.  I'm not sure what you mean by
devices having a *need* for it though?

> I guess the thing I don't love, though, is that to get to Dmitry's
> dream of all regulators having their load specified the we have to add
> regulator_set_load() calls to all sorts of drivers across the system.
> Right now, at least in mainline, the regulator_set_load() calls are
> almost entirely relegated to Qualcomm-related drivers and for
> peripherals which are on the SoC itself.

Sure, in order to actively manage this stuff someone is going to
have to type a bunch of numbers in somewhere.  It's just a
question of where we do the typing in that case and how much of
it is required.

> Let's go back to the trackpad example, maybe looking specifically at
> "hid-over-i2c". The driver here is fairly hardware agnostic and the
> current used may not be very easy for the i2c-hid driver to specify in
> code. I suppose one answer here is: use board constraints to force
> this regulator to always use HPM (high power mode). That's fine, but
> then if we have a way to turn this device "off" and it's on a shared
> rail? Maybe then we'd want to be able to put the regulator in LPM
> mode?

> I guess this is really the place where being able to specify loads in
> the device tree really seems like the right fit. We've got generic
> (non-Qualcomm) components that perhaps are probable and handled by a
> generic driver, but they're powered by these regulators where software
> needs to change between HPM and LPM. It feels clean to specify the
> load of the i2c-hid trackpad in a given board's device tree.

Does this need actually exist or is this just a we built it so we
must use it thing?  There's a lot of power microoptimisation that
goes on and sometimes it's hard to tell how much power is saved
relative to the power consumed managing the feature.

To the extent this is needed it does smell a bit like "these
regulators should default to setting their load to 0 when
disabled" or something more along those lines TBH, some of your
previous comments suggested that the per device loads being
specified in a lot of the driver are just random values intended
to trigger a specific behaviour in the regulator but forced to be
done in terms of a load due to the firmware inteface that's
available on these platforms having an interface in those terms.
It didn't sound like they were actual specified/measured physical
values for the on-SoC stuff, some of the panel drivers do look
like they have plausuble numbers from datasheets though.

It might even make sense to have the regulator drivers implement
the mode interface, that's possibly more useful to work with here
even if it's not what the interfaces say, it does feel like
practicaly how people are working with this stuff.  There's
obviously issues there if anyone *does* work usefully with loads
and how that integrates, though I think in this day and age the
need for active management outside of super idle states is
typically minimal.  As a first pass you could just disable the
DRMS stuff if mode setting permission is enabled, I suspect
that'd work fine in these cases.  Or just model the modes as a
vote for "add X to the load" if they're set.

> Sorry for the bad naming. Originally I was thinking that the dts would
> specify the minimum current but as I thought about it more it felt
> like it made more sense to specify the current that should be used for
> a dumb driver (one that doesn't know anything about loads).

> Doing an array would make sense. Like:

> vdda-phy-load-names =3D "default", "off", "..."
> vdda-phy-loads =3D <21800>, <500>, <...>;

> Where "default" would be the load by default when enabled, "off" when
> disabled off (if it's a shared rail it could conceivably draw power
> even after regulator_disable()). Others states could be selected
> manually.

I would talk in terms of active and idle but yes.

> All snarkiness aside, though, I'm just trying to point out that
> there's no definitive line to cross. No black and white. Anything we
> put in dts from "assigned-clock-rates" to voltage ranges to whatever

I see one of two things happening here.  Like I was saying above
my best guess is that a lot of the time we're just going to be
putting random values in the DT that are purely intended to
trigger a specific behaviour in the regulator in which case we
should probably just say what we're trying to accomplish rather
than adding in a pile of inaccurate data which might cause us
trouble later.  The other option is that something is actively
managing the load while things are active (which I'm not
immediately able to find any evidence of upstream) in which case
potentially things will likely vary with SoC integration so the
above binding becomes a bit more reasonable, but then you
absolutely have to have some code in the drivers.

> > What's big push to put this in DT rather than just make the code pattern
> > easier to use?  I'm not totally against it but I'm having a hard time
> > getting enthusiastic about it.

> It's nothing make or break and mostly it's just been kicking around in
> the back of my head for the last few years. Mostly I gave a shot at
> implementing something in response to your comment [1] where you said:
> "You could add a way to specify constant base loads in DT on either a
> per regulator or per consumer basis." ;-)

I was tending more towards the per regulator end of things there
TBH, and the more I think about it the more likely it is that the
underlying intent (or at least practical effect) is the mode
setting thing.

> > I think the underlying thing here (and the reason you're seeing this a
> > lot with Qualcomm device specifically) is that Qualcomm have a firmware
> > interface to specify loads and wanted to implement selection of a low
> > power mode when things are idle in the way that Linux does with the
> > get_optimum_mode() interface.  Either they actually have some systems
> > where they were able to select different modes when things are running
> > or they don't have the thing we have where they discount loads from
> > consumers that have removed their enable vote, either way for those
> > platforms what's going on currently does seem like a sensible way of
> > setting things up.
>=20
> I guess I'm a tad less charitable than you are. From what I've seen of
> Qualcomm, there seems to be an in-house checklist that they have to go
> through before landing code. Drivers have to pass the checklist. I
> think it contains things like:

=2E..

> * All regulators should be configured to be able to run in high power
> mode and low power mode. You should always configure a load on them.
> It doesn't matter if you never use low power mode in practice.

I think this one kind of falls out of the way they've set up
their firmware interfaces - having abstraced away modes in favour
of currents there's not the expressiveness to do much else unless
you jump around things at the AP level.  Unfortunately you then
run into the dual problems that typically nobody's actually doing
the fine grained power measurements and the amount you can save
with active management when the device is running is not worth
the power consumed doing that active management anyway.  The use
of currents isn't even a bad choice here, it's really hard to
abstract modes without using currents.

Some of this stuff is also going to be old stylistic things that
aren't causing enough of a problem to get in the way (eg, the
_set_load() calls are going to take hardly any time to implement,
you can write a lot of them before it's more work than deciding
not to bother) and were probably much more useful in the past.

> > Other platforms don't bother, I think that's likely to be some
> > combination of not caring about anything finer grained than system
> > suspend (which especially for Android is totally fair) and modern
> > regulators being much more able to to dynamically adapt to load than
> > those the code was written for.

> Yeah. I think this comes up more in practice with Qualcomm because
> they do their own PMICs and every one of their LDOs has this setting
> for LPM / HPM. Since the setting is there I guess they decided they
> should write software to use it. I agree that it can save some power
> when used well, but I personally don't think the complexity is
> justified except in a small number of cases.

> I would hazard a guess that perhaps Qualcomm's LDOs all have this
> feature because it's probably super critical for LTE modems and they
> might as well add the feature for all the LDOs if they're adding it
> for some of them.

The underlying hardware feature is very easy to implement and a
pretty standard feature for both DCDCs and LDOs, a good number of
upstream drivers have mode support and I'd expect more devices do
but just don't have it in the driver for whatever reason (I know
some of them are reverse engineered for example) or only provide
control along with suspend modes.  It's very desirable for
performance during suspend, but as you say the benefit of
actively mananging it outside of suspend is more questionable.
Simply having a CPU cluster and the RAM active is likely to push
the savings down towards the noise.  What makes things noticable
with these Qualcomm devices is their firmware abstraction.

The more I think about this the more I think that what's
practically going on here fits better with the mode interface
than the load one, normally I'd not like doing a run around the
abstractions the underlying thing is offering but it really does
seem like someone has to bite the bullet and do that runaround
and it's probably going to be less work all round at the
regulator level.

--RZLau95uE4lyRc1T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLcR7sACgkQJNaLcl1U
h9B8pAf/cL7fBS1Ui3Gt7PZOy5vEACCuvPzkDTq5S5ajbIQOlwuYe/Ha6TEB4xgQ
ID1G3ztKYSKQwxoSdzO4Q+1J78o3BS6JrO1Mkms1jsAKbveHMSdtTFeUz3zM4rUk
/FZiP1san5kFR8wtmjFjntKZHBRTe/Jy8AKBK4SuT2jD7YB0F5NPjZuGqpEVPa9y
J2WSwmCrRHb0mpMPU8upTxZfOpbQ8ZRYR8cj1ubQKPDGppVD9KYCM1jsb+DoRZrI
D0QmHohNyc7/BiCQBLg42OiGsbn0VwbY+biOTRm62KZ9yIYiTj5BDxJz4y5L55yB
s8zhIPWPJ+uiTS2OVGcYk7cnPguWNA==
=xwJ2
-----END PGP SIGNATURE-----

--RZLau95uE4lyRc1T--
