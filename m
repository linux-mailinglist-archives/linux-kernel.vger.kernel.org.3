Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFA44E67B8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352245AbiCXRYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352237AbiCXRYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:24:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84F71CB20;
        Thu, 24 Mar 2022 10:23:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7406FB82335;
        Thu, 24 Mar 2022 17:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7135C340EC;
        Thu, 24 Mar 2022 17:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648142591;
        bh=Ii6N9yX0cfvtlWGYsRFUlxpmnU5DBEOXCXBEVeUK1m4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dkUjRBS0vQTUg1Sz1AEMShGyKGTmbunTXyYN4gS3PEI7v7chIhQlEh4j9L7nEnwBW
         EKYR8C3DHrHaONiYk/yFDenQDWCxLA6w24pOc5ybAZyPHJ3cnvNa0IYihNl7omVObg
         8cNRIAidGUVpmu9Qbws+svgUr0wbTc9JhBF6cI0PdxAGBm1gk+tBjOKZ4EFAqxKHhB
         Yj0QTkVK4AFTmN9JueLDEmjI44hjfzbBEEJ2aMip1SWLzb6XfWlfaHVh5jQAo2UI9x
         Tzvhc1zpzZeJTEnKATnOiybc7/c9hI5aenkYyFKvCcuHGylL5/fJHHQFhne2tJgG/l
         iW+VnVEFeutLQ==
Date:   Thu, 24 Mar 2022 17:23:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     David Collins <quic_collinsd@quicinc.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Subject: Re: [PATCH v2 0/2] regulator: scmi: add support for registering SCMI
 regulators by name
Message-ID: <Yjyo+Xk0txZs4T/Z@sirena.org.uk>
References: <cover.1647909090.git.quic_collinsd@quicinc.com>
 <Yjm1wpcMZsZJJCuy@bogus>
 <eb03037b-e7c2-ea23-0bdb-27924ed54fa7@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="81Z0hAsjzpiu2TPf"
Content-Disposition: inline
In-Reply-To: <eb03037b-e7c2-ea23-0bdb-27924ed54fa7@quicinc.com>
X-Cookie: Orders subject to approval.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--81Z0hAsjzpiu2TPf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 22, 2022 at 06:12:33PM -0700, David Collins wrote:

> Another problem is that, as with regulators, ID numbers could
> unknowingly get out of sync between the platform and the agent.  Using
> clock domain names for referencing fixes both issues.  This can be

This is just saying that the hard coded IDs that the firmware and kernel
use to communicate can get out of sync which is true no matter if those
IDs are strings or if they're numerical, either way it's an ABI which
can be broken.

> > If the IDs are correct like the names, it is guaranteed. I see this
> > ID vs name is more for some maintenance convenience because somewhere
> > something else needs to changes or moved away from existing way of
> > maintenance.

> How do you quantify an ID number to physical regulator mapping as
> "correct"?  What happens if the mapping must be changed on the SCMI
> platform side (e.g. a PMIC was added or removed, or the order that
> regulators are listed in needs to change)?  If the SCMI agent is blindly

The whole point with the numbers being an ABI is that things must never
be renumbered, just as if names are used the names can't be changed.  If
the numbering is changing that just sounds like bugs on the platform
side.  There's an implicit assumption in what you've written above that
implementation details of the firmware should affect the IDs presented
through SCMI which simply shouldn't be true, and indeed if the firmware
can assign fixed strings it can just as well assign fixed numbers.

--81Z0hAsjzpiu2TPf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmI8qPgACgkQJNaLcl1U
h9ADUgf9F+Vf4g7qBC+8QlTTVuL2G2gfodUp02z5tMeeey6bl+LR16pl2v9gT7hB
p2CJjMjVg8NZYrrhb7BwEoibIRppAy02Ehy+FRZNXpLUNtrZjskye0LqYJW2nVnv
r/XEam7moUDXHEhQWOGz8pY8PTTE66kMytsL4tWpK6ERwyHonh7kEuLRdY5s0JLT
haW0CXliardrk2R8uh3+Zk40wyq2NW+AcGrBarTE9EaJVVjg2WcPWgAnCeBXgQxw
fJ01Gyz3VeWZdk0XGD3+b8DejXOsi5ltsGRDbzZd6cusY76qGUL+XzyQMJLnYwzX
J/ksIIO1L4uR2q+DYs9zCnueo1ahmQ==
=u7Hy
-----END PGP SIGNATURE-----

--81Z0hAsjzpiu2TPf--
