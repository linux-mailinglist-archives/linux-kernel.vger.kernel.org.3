Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD1F4BA046
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbiBQMiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:38:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiBQMiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:38:10 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7041763E4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 04:37:55 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 560071C0B7F; Thu, 17 Feb 2022 13:37:54 +0100 (CET)
Date:   Thu, 17 Feb 2022 13:37:53 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     "greg@kroah.com" <greg@kroah.com>
Cc:     Dmitrii Okunev <xaionaro@fb.com>,
        "qiaowei.ren@intel.com" <qiaowei.ren@intel.com>,
        "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>,
        "xiaoyan.zhang@intel.com" <xiaoyan.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "gang.wei@intel.com" <gang.wei@intel.com>,
        Jonathan McDowell <noodles@fb.com>
Subject: Re: [discuss] Improve and merge a driver proposed in 2013: sysfs
 interfaces to access TXT config space
Message-ID: <20220217123753.GA21849@duo.ucw.cz>
References: <1368465884-14779-1-git-send-email-qiaowei.ren@intel.com>
 <1368465884-14779-3-git-send-email-qiaowei.ren@intel.com>
 <20130516160311.GA12299@amd.pavel.ucw.cz>
 <4febd50da7e5007a2797e0f4c969fa5edd0bf725.camel@fb.com>
 <Yg5A4Mupue0V9diu@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <Yg5A4Mupue0V9diu@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2022-02-17 13:34:40, greg@kroah.com wrote:
> On Thu, Feb 17, 2022 at 11:47:21AM +0000, Dmitrii Okunev wrote:
> > Hello!
> >=20
> > As far as I see the patch wasn't merged. And I see that this is the
> > only unsolved thread in the discussion:
> >=20
> > On Thu, 2013-05-16 at 18:03 +0200, Pavel Machek wrote:
> > > On Tue 2013-05-14 01:24:43, Qiaowei Ren wrote:
> > > > These interfaces are located in
> > > > /sys/devices/platform/intel_txt/config,
> > > > and including totally 37 files, providing access to Intel TXT
> > > > configuration registers.
> > >=20
> > > This looks like very wrong interface... equivalent of /dev/mem.
> >=20
> > As an active user of these registers I hope it will be merged, so I
> > would like to improve this patch (or rewrite it from scratch) to make
> > that happen. Otherwise one have to do hackery around `/dev/mem`, which
> > also creates problems with proper access control.
> >=20
> > To be able to improve the patch, could somebody clarify why exactly
> > this is a "very wrong interface"?
> >=20
> > > > +What:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/sys/devices/platform/intel_txt=
/config/STS_raw
> > > > +Date:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0May 2013
> > > > +KernelVersion:=A03.9
> > > > +Contact:=A0=A0=A0=A0=A0=A0=A0"Qiaowei Ren" <qiaowei.ren@intel.com>
> > > > +Description:=A0=A0=A0TXT.STS is the general status register. This =
read-
> > > > only register
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0is used by AC modules=
 and the MLE to get the status
> > > > of various
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0Intel TXT features.
> > >=20
> > > This is not enough to allow people to understand what this
> > > does/should
> > > do, nor does it allow (for example) ARM people to implement something
> > > compatible.
> > >=20
> > > Is there specific reason why "better" interface is impossible?
> >=20
> > I would love to reuse Intel's public documentation [1] to provide a
> > proper description (with bit layout of the value).
> >=20
> > [1] https://cdrdv2.intel.com/v1/dl/getContent/315168
> >=20
> > > [...], nor does it allow (for example) ARM people to
> > > implement something compatible.
> >=20
> > Do I understand correctly that a proper documentation of the registers
> > solves the problem?
> >=20
> > > Is there specific reason why "better" interface is impossible?
> >=20
> > What are specific problems with the current interface?
>=20
> What do you mean by "current" here?  You are referring to an email from
> 2013, 9 years ago.
>=20
> If you want to propose the change again, correctly update the patch and
> submit it that way.

I don't believe taking hardware registers and exposing them 1-to-1 in
sysfs is the way to go.

We would like same /sys interface on different hardware, and simply
exposing Intel's registers in /sys will not do the job.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYg5BoQAKCRAw5/Bqldv6
8v8ZAJ9vk4nE8zle4p8F69BdZK6tEpWlMgCgkM9md972WOtlpOLWKKys15Jc9CI=
=2mYc
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
