Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27A3492350
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbiARJyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:54:50 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:35145 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiARJyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:54:44 -0500
Received: by gandalf.ozlabs.org (Postfix, from userid 1007)
        id 4JdPJL4zlrz4y4f; Tue, 18 Jan 2022 20:54:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gibson.dropbear.id.au; s=201602; t=1642499682;
        bh=L1hoXLKSt9NYoRIokSIHmsMSKaw3iQXotaq7cViNDlk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JudBKURJAoPy9mwLb6bHrziztFyT4oOfyVSNj7Ud3Cxe5+xNAiG7rL/jxdq/3+a6I
         mTZi2IXAHhmxpVKFHX17e4yvjY6wDhTqp9Zdf0bBoOAgULmYcmjzuEpR2CVFNDnXxt
         va7pW+emhaK2+0B29tzJs/yoRgMlTW5sVVo4hhJA=
Date:   Tue, 18 Jan 2022 20:54:35 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Anmar Oueja <anmar.oueja@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: Re: [PATCH 1/1] of: unittest: rename overlay source files from .dts
 to .dtso
Message-ID: <YeaOW8oTBykIGXgD@yekko.fritz.box>
References: <YK70Xsl1oXeEQpWZ@yekko>
 <CAMuHMdWdb2s08a=axC+m88gARSA3enOBnczsN59XL2F9yHXXYA@mail.gmail.com>
 <YLBnX4PeK51YwUJB@yekko>
 <CAMuHMdXPn9FHr41xmihuuzNNNKvY-50yAwY4HyuyVo6qBn=Z1w@mail.gmail.com>
 <CAMuHMdWeL3DOXY3xcPOBW2WDDGW3PxgSM8didt7J1KxSm1ivJg@mail.gmail.com>
 <CAMuHMdWXXoS9mmX9VWRQyXfmsy8YROgpLZ-xB7zthEdPdM2u4A@mail.gmail.com>
 <CAMuHMdVWkSnki8VQDaYRzJ8yu8xtEKpXyfQppTtw3wXDQPmYzw@mail.gmail.com>
 <d4b7ce06-23e7-1c60-cc0c-b6aea07e0a1a@gmail.com>
 <CAL_JsqKTckMABk6cM8d=boZcHyLdcqYmbzfKDjAHdCXoCPSDtg@mail.gmail.com>
 <CAMuHMdU4oUKaGxmaPiC=cX0XpHG3KXhr+4MywEfeQ8sq-EG18A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Hi1arQejJwPEf6tt"
Content-Disposition: inline
In-Reply-To: <CAMuHMdU4oUKaGxmaPiC=cX0XpHG3KXhr+4MywEfeQ8sq-EG18A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Hi1arQejJwPEf6tt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 14, 2022 at 10:25:03AM +0100, Geert Uytterhoeven wrote:
> Hi Rob,
>=20
> On Fri, Jan 14, 2022 at 3:10 AM Rob Herring <robh@kernel.org> wrote:
> > On Thu, Jan 6, 2022 at 11:23 AM Frank Rowand <frowand.list@gmail.com> w=
rote:
> > > Patient Geert has pinged again.
> >
> > If it's not a patch to be reviewed, then I'm not going to see it most
> > likely. I don't read the DT list regularly...
>=20
> Fair enough...
>=20
> > > If I remember correctly you guys were not thrilled with this idea, but
> > > also did not seem strongly against it.  Are you willing to go along
> > > with .dtso for overlay source files?  If so, I will revive this patch
> > > series.
> > >
> > > David, if you are against supporting .dtso in the dtc compiler then
> > > the kernel can still support it through make rules.

TBH, I barely remember the earlier discussion.  I am more or less
indifferent on .dtso.

> > I'm not really interested in diverging from dtc. I'd suggest moving
> > the discussion to dtc list and/or devicetree-spec if you want to get
> > more attention on this.
>=20
> What needs to be supported in the dtc compiler?
> The fallback passed to guess_input_format() is "dts".
> So this has been working out-of-the-box since forever?

Right.  I usually like to supply -I and -O to dtc explicitly, in which
case the extensions basically irrelevant.

I suppose we could also issue warnings if the /plugin/ tag doesn't
match the file extension.

> > Also, keep in mind that extensions also affect MIME types which
> > someone was also asking about recently.
>=20
> You mean "MIME type of Devicetree Blobs and Sources"[1]?
> According to [2](2022-01-13), none of that has happened.
>=20
> [1] https://www.spinics.net/lists/devicetree-spec/msg00938.html
> [2] https://www.iana.org/assignments/media-types/media-types.xhtml
>=20
> > > On 1/6/22 3:00 AM, Geert Uytterhoeven wrote:
> > > > On Tue, Aug 24, 2021 at 11:20 AM Geert Uytterhoeven
> > > > <geert@linux-m68k.org> wrote:
> > > >> On Tue, Jun 22, 2021 at 11:44 AM Geert Uytterhoeven
> > > >> <geert@linux-m68k.org> wrote:
> > > >>> On Sat, May 29, 2021 at 12:16 PM Geert Uytterhoeven
> > > >>> <geert@linux-m68k.org> wrote:
> > > >>>> On Sat, May 29, 2021 at 7:16 AM David Gibson
> > > >>>> <david@gibson.dropbear.id.au> wrote:
> > > >>>>> On Thu, May 27, 2021 at 09:21:05AM +0200, Geert Uytterhoeven wr=
ote:
> > > >>>>> 65;6401;1c> On Thu, May 27, 2021 at 3:48 AM David Gibson
> > > >>>>>> <david@gibson.dropbear.id.au> wrote:
> > > >>>>>>> On Wed, May 26, 2021 at 04:21:48PM -0500, Frank Rowand wrote:
> > > >>>>>>>> On 5/26/21 1:11 AM, Viresh Kumar wrote:
> > > >>>>>>>>> On 22-04-21, 13:54, Frank Rowand wrote:
> > > >>>>>>>>>> On 4/22/21 3:44 AM, Geert Uytterhoeven wrote:
> > > >>>>>>>>>>> On Mon, Mar 29, 2021 at 9:23 PM Frank Rowand <frowand.lis=
t@gmail.com> wrote:
> > > >>>>>>>>>>>> On 3/27/21 12:40 PM, Rob Herring wrote:
> > > >>>>>>>>>>>>> On Wed, Mar 24, 2021 at 05:37:13PM -0500, frowand.list@=
gmail.com wrote:
> > > >>>>>>>>>>>>>> From: Frank Rowand <frank.rowand@sony.com>
> > > >>>>>>>>>>>>>>
> > > >>>>>>>>>>>>>> Add Makefile rule to build .dtbo.o assembly file from =
overlay .dtso
> > > >>>>>>>>>>>>>> source file.
> > > >>>>>>>>>>>>>>
> > > >>>>>>>>>>>>>> Rename unittest .dts overlay source files to use .dtso=
 suffix.
> > > >>>>>>>>>>>>>
> > > >>>>>>>>>>>>> I'm pretty lukewarm on .dtso...
> > > >>>>>>>>>>>>
> > > >>>>>>>>>>>> I was originally also, but I'm warming up to it.
> > > >>>>>>>>>>>
> > > >>>>>>>>>>> What's the status of this?
> > > >>>>>>>>>>
> > > >>>>>>>>>> I was planning to resend on top of the upcoming -rc1.
> > > >>>>>>>>>
> > > >>>>>>>>> Ping.
> > > >>>>>>>>>
> > > >>>>>>>>
> > > >>>>>>>> Thanks for the prod...
> > > >>>>>>>>
> > > >>>>>>>> The .dtso convention was added to the dtc compiler, then a p=
atch was
> > > >>>>>>>> accepted to revert one mention of .dtso ,though there still =
remains
> > > >>>>>>>> two location where .dtbo is still recognized (guess_type_by_=
name() in
> > > >>>>>>>> dtc and the help text of the fdtoverlay program).
> > > >>>>>>>>
> > > >>>>>>>> It seems that the general .dtso and .dtbo were not popular, =
so I'm
> > > >>>>>>>> going to drop this patch instead of continuing to try to get=
 it
> > > >>>>>>>> accepted.
> > > >>>>>>>
> > > >>>>>>> AFAICT .dtbo is moderately well established, and I think it's=
 a good
> > > >>>>>>> convention, since it matters whether a blob is an overlay or =
base
> > > >>>>>>> tree, and it's not trivial to tell which is which.
> > > >>>>>>
> > > >>>>>> Indeed.
> > > >>>>>>
> > > >>>>>>> .dtso is much more recent,
> > > >>>>>>
> > > >>>>>> Is it?
> > > >>>>>
> > > >>>>> Well, I wouldn't bet money on it, I just seem to remember encou=
ntering
> > > >>>>> .dtbo for some time before .dtso was mentioned.
> > > >>>>>
> > > >>>>>> The oldest reference I could find is from May 2015:
> > > >>>>>> "[PATCH/RFC] kbuild: Create a rule for building device tree ov=
erlay objects"
> > > >>>>>> https://lore.kernel.org/linux-devicetree/1431431816-24612-1-gi=
t-send-email-geert+renesas@glider.be/
> > > >>>>>
> > > >>>>> Hm, I think .dtbo is even older than that, but again, I wouldn'=
t swear
> > > >>>>> to it.
> > > >>>>
> > > >>>> Sure. My work is based on Pantelis' work for BeagleBoard capes.
> > > >>>> His code (from 2013?) used .dtbo and .dts:
> > > >>>>
> > > >>>>     overlay/v3.10/merge:firmware/Makefile:$(obj)/%.dtbo: $(obj)/=
%.dts
> > > >>>> | $(objtree)/$(obj)/$$(dir %)
> > > >>>>
> > > >>>> So I might be the one who introduced .dtso...
> > > >>>>
> > > >>>>>> I have always used dtbo/dtso in my published overlays branches,
> > > >>>>>> referred from https://elinux.org/R-Car/DT-Overlays, and used by
> > > >>>>>> various people.
> > > >>>>>>
> > > >>>>>>> and I think there's much less value to it.
> > > >>>>>>
> > > >>>>>> IMHO the same reasoning as for dtb vs. dtbo applies to dts vs.=
 dtso.
> > > >>>>>> It matters if the resulting blob will be an overlay or base tr=
ee,
> > > >>>>>> as the blob will have to be called .dtb or .dtbo.
> > > >>>>>> As dtc outputs to stdout by default, the caller has to provide=
 the
> > > >>>>>> output filename, and thus needs to know.
> > > >>>>>> Even if dtc would name the output file based on the presence of
> > > >>>>>> "/plugin/" in the input file, the build system still needs to =
know
> > > >>>>>> for dependency tracking.
> > > >>>>>
> > > >>>>> Hm, fair point.  I was thinking of the the /plugin/ tag as the
> > > >>>>> distinction, whereas dtb is binary and the distinction isn't ev=
en
> > > >>>>> marked in the header.  But you're right that even readable text=
 labels
> > > >>>>> inside the file don't really help make(1).  So, I retract that
> > > >>>>> assertion.
> > > >>>>
> > > >>>> Thanks!
> > > >>>>
> > > >>>>>> We also do have .dts vs. .dtsi.
> > > >>>
> > > >>> In the mean time, we're at rc7 again?
> > > >>
> > > >> That was v5.13-rc7. Now we're at v5.14-rc7...
> > > >>
> > > >> Will we live with the inability to e.g. let make distinguish betwe=
en
> > > >> DT includes and overlays forever?
> > > >
> > > > I guess this is not gonna happen, so I'll convert all my overlays
> > > > from .dtso to .dts....
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Hi1arQejJwPEf6tt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoULxWu4/Ws0dB+XtgypY4gEwYSIFAmHmjlEACgkQgypY4gEw
YSKeaxAAo+C+x62VKrdYdNn4rOXy2DrFCNWOnGu3l0R8SgchN1v7IhAlJIjYeeLU
w7ZDkqxxeWo1hN4i+VDRa1svCxbem6wvXqW62ongXKUJi82hVkZjdeCfgtyLFTH8
KISlv8wy8+d9jDP8XC7UGIP7uG3vLnOjlrHLPBlHYuzCTUWYin68ike8cBoXsg4D
DePxVfH8oEJvkT57r7Vq7RVx98PekJsLWppENBTMy7ioKPbTbsrP/5M7hprFAE22
3xvr7F1Gj5/kqoysUk9xup4L0WGR0lnraUJUfWeO7Y4a7zjhqtyoa6Z6HGwfxTTG
f6B/V2Gd0MnBEXrDPT2l+yKI9bHYt9dII1dsrcZjw/9P2EycYAehAbZDben9aOay
oo6jwCL6nJj0vALiB1N+Wwu6CohLSkqhgxvbLEuSuyA7HWzv2NWDQTD365r6BPUY
Ye8BmTuRgGuMmEpPLGj9+iqBpH7wkzGSuu4muYeGVyB7EF3JryhI9rYVNQW9QOgQ
k03k25mSAl1l/jop203NJkGLaNnAQIZeYCXuoKHEwtU9JeSdR0V8aNhFiyoZ11m0
hK9dn/lHL3iU87l5qB30SdNi1TTeVPkC5dH3QRxw+AxWgOYnF/+GvttbeLB5dWS6
bcTpQenWpYj04VRTsKr0Zla7biEkQ1CX7VMkAmSCTN9j6j8jXrI=
=1e33
-----END PGP SIGNATURE-----

--Hi1arQejJwPEf6tt--
