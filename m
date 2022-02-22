Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4DE4BF4C5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiBVJbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiBVJba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:31:30 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3721C15721C;
        Tue, 22 Feb 2022 01:31:04 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 58E191C0B8D; Tue, 22 Feb 2022 10:31:02 +0100 (CET)
Date:   Tue, 22 Feb 2022 10:31:01 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Jonathan McDowell <noodles@fb.com>
Cc:     "greg@kroah.com" <greg@kroah.com>,
        Dmitrii Okunev <xaionaro@fb.com>,
        "qiaowei.ren@intel.com" <qiaowei.ren@intel.com>,
        "mjg59@srcf.ucam.org" <mjg59@srcf.ucam.org>,
        "xiaoyan.zhang@intel.com" <xiaoyan.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gang.wei@intel.com" <gang.wei@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [discuss] Improve and merge a driver proposed in 2013: sysfs
 interfaces to access TXT config space
Message-ID: <20220222093101.GA23654@amd>
References: <1368465884-14779-1-git-send-email-qiaowei.ren@intel.com>
 <1368465884-14779-3-git-send-email-qiaowei.ren@intel.com>
 <20130516160311.GA12299@amd.pavel.ucw.cz>
 <4febd50da7e5007a2797e0f4c969fa5edd0bf725.camel@fb.com>
 <Yg5A4Mupue0V9diu@kroah.com>
 <20220217123753.GA21849@duo.ucw.cz>
 <0cf678e0b01bf421f3db6693a15ac4060501a80a.camel@fb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <0cf678e0b01bf421f3db6693a15ac4060501a80a.camel@fb.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2022-02-18 18:05:47, Jonathan McDowell wrote:
> On Thu, 2022-02-17 at 13:37 +0100, Pavel Machek wrote:
> > On Thu 2022-02-17 13:34:40, greg@kroah.com=A0wrote:
> > > On Thu, Feb 17, 2022 at 11:47:21AM +0000, Dmitrii Okunev wrote:
> > > > Hello!
> > > >=20
> > > > As far as I see the patch wasn't merged. And I see that this is
> > > > the only unsolved thread in the discussion:
> > > >=20
> > > > On Thu, 2013-05-16 at 18:03 +0200, Pavel Machek wrote:
> > > > > On Tue 2013-05-14 01:24:43, Qiaowei Ren wrote:
> > > > > > These interfaces are located in
> > > > > > /sys/devices/platform/intel_txt/config,
> > > > > > and including totally 37 files, providing access to Intel TXT
> > > > > > configuration registers.
> > > > >=20
> > > > > This looks like very wrong interface... equivalent of /dev/mem.
> > > >=20
> > > > As an active user of these registers I hope it will be merged, so
> > > > I would like to improve this patch (or rewrite it from scratch)
> > > > to make that happen. Otherwise one have to do hackery around
> > > > `/dev/mem`, which also creates problems with proper access
> > > > control.
> > > >=20
> > > > To be able to improve the patch, could somebody clarify why
> > > > exactly this is a "very wrong interface"?
> > > >=20
> > > > > > +What:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/sys/devices/platform/intel=
_txt/config/STS_ra
> > > > > > w
> > > > > > +Date:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0May 2013
> > > > > > +KernelVersion:=A03.9
> > > > > > +Contact:=A0=A0=A0=A0=A0=A0=A0"Qiaowei Ren" <qiaowei.ren@intel.=
com>
> > > > > > +Description:=A0=A0=A0TXT.STS is the general status register. T=
his
> > > > > > read-
> > > > > > only register
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0is used by AC mod=
ules and the MLE to get the
> > > > > > status
> > > > > > of various
> > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0Intel TXT feature=
s.
> > > > >=20
> > > > > This is not enough to allow people to understand what this
> > > > > does/should do, nor does it allow (for example) ARM people to
> > > > > implement something compatible.
> > > > >=20
> > > > > Is there specific reason why "better" interface is impossible?
> > > >=20
> > > > I would love to reuse Intel's public documentation [1] to provide
> > > > a proper description (with bit layout of the value).
> > > >=20
> > > > [1] https://cdrdv2.intel.com/v1/dl/getContent/315168
> > > >=20
> > > > > [...], nor does it allow (for example) ARM people to
> > > > > implement something compatible.
> > > >=20
> > > > Do I understand correctly that a proper documentation of the
> > > > registers solves the problem?
> > > >=20
> > > > > Is there specific reason why "better" interface is impossible?
> > > >=20
> > > > What are specific problems with the current interface?
> > >=20
> > > What do you mean by "current" here?=A0 You are referring to an email
> > > from 2013, 9 years ago.
> > >=20
> > > If you want to propose the change again, correctly update the patch
> > > and submit it that way.
> >=20
> > I don't believe taking hardware registers and exposing them 1-to-1 in
> > sysfs is the way to go.
> >=20
> > We would like same /sys interface on different hardware, and simply
> > exposing Intel's registers in /sys will not do the job.
>=20
> So, for our particular use case what we want to be able to see is the
> status of the TXT device, so when attestation fails it's possible to
> diagnose where that might have happened. At a minimum=A0details from the
> status register are folded into the first measurement, and the error
> register can provide valuable insight as to what the TXT device thinks
> failed.
>=20
> At present these details are retrieved from /dev/mem, but this is less
> than ideal and prevents the use of, say, kernel lockdown. As a result
> we'd like to export the appropriate details via sysfs. These are likely
> to be extremely security block implementation specific, so I'm not
> clear that a generic agnostic interface is appropriate to retrieve
> these details.

> Do you have the same objection to a read only set of information
> (rather than the full control offered by the initial submission)?

Might be a job for debugfs?
							Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmIUrVUACgkQMOfwapXb+vKgrQCghttXJ7nTqOcDXJPclG6dbVcv
hJsAoJGS6x8u/CYDqk2yNOu2JrH38ell
=zuhO
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
