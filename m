Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D985136DE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348359AbiD1ObK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343852AbiD1ObI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:31:08 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9496953E08;
        Thu, 28 Apr 2022 07:27:51 -0700 (PDT)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id C97BAFF80C;
        Thu, 28 Apr 2022 14:27:49 +0000 (UTC)
Date:   Thu, 28 Apr 2022 16:27:48 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm
Subject: Re: [PATCHv2 1/2] doc/media api: Try to make enum usage clearer
Message-ID: <20220428142748.hsxudwkpsmalltd2@uno.localdomain>
References: <20220428105211.7106ce6a.dorota.czaplejewicz@puri.sm>
 <20220428130448.bfht2nf23n6lidsk@uno.localdomain>
 <20220428155723.456b7ff0.dorota.czaplejewicz@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y3rvmn3f2oodlhlk"
Content-Disposition: inline
In-Reply-To: <20220428155723.456b7ff0.dorota.czaplejewicz@puri.sm>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y3rvmn3f2oodlhlk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Apr 28, 2022 at 03:57:23PM +0200, Dorota Czaplejewicz wrote:
> Hello,
>
> On Thu, 28 Apr 2022 15:04:48 +0200
> Jacopo Mondi <jacopo@jmondi.org> wrote:
>
> > Hi Dorota,
> >
> >
> > On Thu, Apr 28, 2022 at 10:52:11AM +0200, Dorota Czaplejewicz wrote:
> > > Added: mbus codes must not repeat
> > > Added: no holes in the enumeration
> > > Added: enumerations per what?
> > > Added: who fills in what in calls
> > > Changed: "zero" -> "0"
> > > Changed: "given" -> "specified"
> > >
> > A more discoursive commit message would be appreciated. Just a few lines
> > before the crude list of changes:
> >
> > Something like
> >
> > "Update the documentation of ... in order to clarify etc etc"
> >
> > > Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
> > > ---
> > > Hello,
> > >
> > > this is the second attempt at updating the media documentation.
> > >
> > > Differences from previous: "selected" is now "specified", "array" is now "enumeration", and "caller" is now "application".
> >
> > Please stay in 80 cols even for parts that won't end up in the commit
> > message, it's hard to read this if you have multiple terminal windows
> > open.
>
> I can try to comply with this, but I generally don't do it
> because hard breaks are difficult to read
> on a phone or if I have multiple messages open.
> My line widths vary between 40 and 80 characters,
> and hard breaks can only cover one width, at the cost of all others.

Ok then. It seems a bit more likely for people to read patches from a
terminal rather than a phone, but.. ok.


> >
> > >
> > > No differences: I haven't used the frame intervals calls and haven't gathered practical knowledge about where docs may be insufficient, so I didn't touch its documentation.
> >
> > I think Hans required to change the documentation of that ioctl to
> > match the style of the changes you have made here, not because
> > something is missing there.
> >
> > >
> > > Regards,
> > > Dorota
> > >
> > >  .../v4l/vidioc-subdev-enum-mbus-code.rst      | 39 +++++++++++++------
> > >  1 file changed, 27 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst
> > > index 417f1a19bcc4..87572de0fd26 100644
> > > --- a/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst
> > > +++ b/Documentation/userspace-api/media/v4l/vidioc-subdev-enum-mbus-code.rst
> > > @@ -31,15 +31,29 @@ Arguments
> > >  Description
> > >  ===========
> > >
> > > -To enumerate media bus formats available at a given sub-device pad
> > > -applications initialize the ``pad``, ``which`` and ``index`` fields of
> > > -struct
> > > -:c:type:`v4l2_subdev_mbus_code_enum` and
> > > -call the :ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE` ioctl with a pointer to this
> > > -structure. Drivers fill the rest of the structure or return an ``EINVAL``
> > > -error code if either the ``pad`` or ``index`` are invalid. All media bus
> > > -formats are enumerable by beginning at index zero and incrementing by
> > > -one until ``EINVAL`` is returned.
> > > +This call is used by the application to access the enumeration of bus formats
> > > +for the selected pad.
> >
> > This is a good introductory phrase.
> >
> > > +
> > > +The enumerations are defined by the driver, and indexed using the ``index`` field
> > > +of struct :c:type:`v4l2_subdev_mbus_code_enum`.
> > > +Each value of ``pad`` corresponds to a separate enumeration.
> >
> > Isn't this a repetition of the above "enumeration of bus formats for
> > the selected pad" ? Also, the fact different mbus codes are available
> > at different pads is an intrinsic characteristics of the device
> > capabilities and of what a pad represents. Put it in this way it seems
> > it's an API requirement.
> >
> > > +Each enumeration starts with the ``index`` of 0, and
> > > +the lowest invalid index marks the end of enumeration.
> > > +
> > > +Therefore, to enumerate media bus formats available at a given sub-device pad,
> > > +initialize the ``pad``, and ``which`` fields to desired values,
> > > +and set ``index`` to 0.
> > > +Then call the :ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE` ioctl
> > > +with a pointer to this structure.
> >
> > Could these two paragraphs be just:
> >
> > To enumerate all the media bus codes available at a give sub-device pad,
> > an application set the ``index`` field to 0 and then call the
> > :ref:`VIDIOC_SUBDEV_ENUM_MBUS_CODE` ioctl with a pointer to this structure,
> > incrementing ``index`` by one until ``EINVAL`` is returned.
> >
> What I found difficult with this documentation is that it described an algorithm,
> and did not describe the basic assumption about the shape of the data.
> Here, I tried to give a quick overview of the data structure in the first paragraph.
> The second paragraph is just a description of details,
> not needed to get a high level idea of the API.
>
> > > +
> > > +A successful call will return with the ``code`` field filled in
> > > +with a mbus format value.
> >
> > Generally, I see "mbus code", not "mbus format" as far as
> > I'm aware..
> I was generally confused about the "mbus" thing the whole time I used the API.
> That's why I came up with the idea to describe what it's useful for (format),
> instead of using an abstract "code" which could mean anything.
> "mbus code" is not even searchable online much, so it's difficult to make the connection

First result searching "mbus code" in kernel.org/doc/html/latest
https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/subdev-formats.html

Also:
https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/subdev-formats.html?highlight=media%20bus%20codes#v4l2-mbus-pixelcode

My understanding is that an mbus (media bus) format represents the
whole frame format (code, sizes, colorspace etc) while the media bus code
is the numerical value that identifies the pixel format as sent on the
bus.

Sorry was not clear from my previous comment.

> >
> > > +Repeat with increasing ``index`` until ``EINVAL`` is received.
> > > +``EINVAL`` means that either ``pad`` is invalid,
> > > +or that there are no more codes available at this pad.
> >
> > Is it necessary to add this last paragraph. Isn't it specified in the
> > error code description below ?
> >
> > EINVAL
> >     The struct
> >     :c:type:`v4l2_subdev_mbus_code_enum`
> >     ``pad`` references a non-existing pad, or the ``index`` field is out
> >     of bounds.
> >
> >
> "Out of bounds" does not say what the bounds are.
> What I wrote is in the context of the incrementing algorithm,
> which implies that hitting it means hitting the bound ("no more codes").
> > > +
> > > +The driver must not return the same value of ``code`` for different indices
> > > +at the same pad.
> >
> > This might be a good thing to specify, a little obvious maybe but it
> > doesn't hurt.
> >
> Given that I ran head first into a bug involving repeats (prompting this patch),
> I testify that nothing about it is obvious :)
> > >
> > >  Available media bus formats may depend on the current 'try' formats at
> > >  other pads of the sub-device, as well as on the current active links.
> > > @@ -57,14 +71,15 @@ information about the try formats.
> > >
> > >      * - __u32
> > >        - ``pad``
> > > -      - Pad number as reported by the media controller API.
> > > +      - Pad number as reported by the media controller API. Filled in by the application.
> > >      * - __u32
> > >        - ``index``
> > > -      - Number of the format in the enumeration, set by the application.
> > > +      - Index of the mbus code in the enumeration belonging to the given pad.
> > > +    Filled in by the application.
> >
> > These last changes are good, provided this phrase still renders correctly
> > now that you added a line break.
> >
> > >      * - __u32
> > >        - ``code``
> > >        - The media bus format code, as defined in
> > > -	:ref:`v4l2-mbus-format`.
> > > +	:ref:`v4l2-mbus-format`. Filled in by the driver.
> > >      * - __u32
> > >        - ``which``
> > >        - Media bus format codes to be enumerated, from enum
> >
> > In general there are a few good additions, but to be honest I would
> > keep the changes small for sake of consistency with the existing
> > documentation of other enumeration-related ioctls
> >
> > Thanks
> >    j
> >
> > > --
> > > 2.35.1
> > >
> >
> >
> Thanks for reviewing.
>
> --Dorota



--y3rvmn3f2oodlhlk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAmJqpGQACgkQcjQGjxah
Vjx3tA//bXCokVwCSMURyQnXN5p4aYMDuLoKwmPUuhpDu5kBYGOrjt/sGJcUhjIy
Pp7P+C/ETLnc6YYja+TJE9s0Ob27DjRjQah6ndEFAv6yEVTnn3HODHVePsoJeuCc
QHQzeLK2nBapz9TfE0H8EgO8hEqhv5IxrmVNgPpGyzNQohiyCMPSP0VnIO/+Qryz
4WarcX+HXjoijrhlqu4zA2bCELH8kuGZK4E9Y/NA8ElLpRFG6JPtnYPlkTqXtZky
NxpTlsdxO6orSDZQ9cJ9vkLK9x+UdWQV9jblxw4/xKO9DGTmIymE60DoolMJfK6B
nbY5WyfXEmEplarh55Sq0TT+7B+qYjI7Exajq/0xZwFvAfg98S1gZTs9fvE/bMWP
ILKrKsNm0FAiVgVWTPF+/sVWY0YTSrWLjV6rkPqVoMrGWRuDbSs1WE3+NPLC4/jw
IbpcaJcKjHTg7JU6WtVw11TsHjW0KN74zSIrU95W0solHoOrqqPj43P9OazTREzo
R3ZfCvF2CMCRItYHtHWZhhIyK9Cxd0CdsLaMiE95VHvOzQ7QX3XY9EI0cCYR5Hvn
UBpBl/qJXw1A+ebPCrgqSu9TLTFmLt4gNKTEcZQXhNQj1yd6F7JEHHHnc1rSJ8Fz
j1q+ZlIFXCP8VVkAZ+4rp20L/OWS4UPshBvjwhDgS2ID+/j7wz0=
=ZYO+
-----END PGP SIGNATURE-----

--y3rvmn3f2oodlhlk--
