Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BA94A76F2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346301AbiBBRiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiBBRiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:38:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55A8C061714;
        Wed,  2 Feb 2022 09:38:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60EE361804;
        Wed,  2 Feb 2022 17:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1576C004E1;
        Wed,  2 Feb 2022 17:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643823498;
        bh=WU6rtXHrBKcJ3aF7ubteBTU1Exh+OedBgo1tPLIffbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KKZ7HPdziFaAdwuEZrJ/56Nj30WYCon8p+UxQoIvNnLEI5l/3JVhjiqzhNn8RIFic
         y/OEjFnzffHmbcXnhxePLYKr/0UGgZxAfUznNnjbuL03ugv0uDBc6bcUYvE3doHQk4
         NzWLEL1jVP5XTyYP0I6gH2MW3YhJQFVsXAl301CefdQgNWLnfD/V5ofbh7ZDPh9UTd
         VHy4ow6efnar64nDQERjA/J+iiBKr9Jdsfj9zWBqQSfMU3J9NS9Phd6D4b+/r6mZ/u
         nxgSpXL14vuEvOdMOPkkfydTzVGgY1mYoLky5MHDUS3ptTE5tz6bcqMVmCV/u99rEC
         M8gY1wa24Cy3g==
Date:   Wed, 2 Feb 2022 17:38:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     David Collins <quic_collinsd@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
Subject: Re: [RESEND PATCH 1/2] dt-bindings: firmware: arm,scmi: define
 support for name based regulators
Message-ID: <YfrBharI91QYkPR1@sirena.org.uk>
References: <cover.1643069954.git.quic_collinsd@quicinc.com>
 <fcd130891cc1d52cb09b8bfc866ab7ef1ce3b2a1.1643069954.git.quic_collinsd@quicinc.com>
 <YfREsxeSSX2pbALf@sirena.org.uk>
 <8355035c-6d90-adfd-c4e1-7bb37a2d8055@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Aktlpu2Xc2RO6PBN"
Content-Disposition: inline
In-Reply-To: <8355035c-6d90-adfd-c4e1-7bb37a2d8055@quicinc.com>
X-Cookie: Quack!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Aktlpu2Xc2RO6PBN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 28, 2022 at 03:09:30PM -0800, David Collins wrote:
> On 1/28/22 11:32 AM, Mark Brown wrote:
> > On Mon, Jan 24, 2022 at 04:27:35PM -0800, David Collins wrote:

> >> Name based SCMI regulator specification helps ensure that an SCMI
> >> agent doesn't need to be aware of the numbering scheme used for

> > What is a "SCMI agent" in this context?  This is changing how the DT
> > bindings are specified, at some point things are going to need to be
> > hard coded.

> The system layout that this patch is targeted for consists of an SCMI
> platform implemented in software in the primary Linux OS on the
> application processor and an SCMI agent in a guest VM (also running
> Linux).  This provides paravirtualized regulator control to the guest VM
> where full virtualization is not supported.

> During the course of development of these software images, it may be
> necessary to add or reorder the set of SCMI voltage domains (regulators)
> implemented on the platform side.  If the voltage domains are only
> identified and matched based on the ID number, then it is easy for the
> platform and agent to get out of sync.

> Using the voltage domain name instead of ID number for identification
> and matching provides robust assurance of correct regulator usage in the
> face of domains being added, removed, or reordered on the platform side.

This seems like a scenario where the DT should be being generated at
runtime along with the virtualisation of the platform?  TBH a setup
where this is an issue feels like it's asking for trouble.

> >> +              regulator-name: true

> > This is abusing the existing regulator-name property which is there to
> > allow a human readable descriptive string to be attached to a regulator.
> > It should have no effect other than being included in diagnostic output.

> Would you be ok with a new DT property being added in place of
> "regulator-name" in this patch which serves the same matching purpose
> (perhaps "arm,scmi-domain-name")?

Yes, it needs to be a new property.

--Aktlpu2Xc2RO6PBN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH6wYQACgkQJNaLcl1U
h9Cu6gf+PkDue7hkAIscCHLGlbrpGEvu+xm7jY61TBjbLsEt5YL6OwPD3t5qH8zx
5H5wzWtOMJeqX5AuD8isuaWBvVptpaSKJx+aR296WJmps2yUN+UFlCxBNSyCV2XS
wje1j3is1uv+hZCTS8Rb1rPJSErAQSpOhtyndFSVSJT5XNlaRXSjN0Pl/qZzw+Bd
PfnVkJ3vKAZ68nxJD51ygXEzGGqywHwKhrMVRqqpa7dXM19nucHgHDvlA3iFv/mG
qg2PqOEQstaUAXqyMtfXWQcsgKDGKys8yC0qxpq35KVy6RecoCh0EY9RCrD6OO+4
c8OIAiYhicboqwG1OBgmrMp2+KFDvg==
=wOub
-----END PGP SIGNATURE-----

--Aktlpu2Xc2RO6PBN--
