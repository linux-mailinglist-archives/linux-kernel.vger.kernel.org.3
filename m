Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8D051A017
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350114AbiEDM77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349930AbiEDM74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:59:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCBB3B023;
        Wed,  4 May 2022 05:56:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 881F4B824B2;
        Wed,  4 May 2022 12:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D48C385AF;
        Wed,  4 May 2022 12:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651668978;
        bh=gdxj5YVJJXTcWteagPD81sMBdc9Aq1VtB4tSVNICDTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j4hq9cpxhq7G29FUlZFS8TbG6vfR1K8u5AaC8crxTXMBO8geP2iXkvV5HrxQhV7C2
         OYV9YCzCTcqQOzl7h21grCFKxuXr81cupttv+s7iGkul7dU+ttNGGKFCzgPUFmyhgM
         +bPU0LKLn51pn4zYmtEdLgXViWNUnbBPMkKLyv1rWojkcr5RB8qSizIzF1yzkPmeVY
         JNr3D1amGpASDewu/l9N74CqKXGtuB4AyKI5BX3joIAqmkLDDY02po6BxuqSFqDkWn
         JQq5VEkE2gBeQzUM0VErYAHoufbIIR/8PLdurA9AugZmb6avbELzkkWOQs7wgfqqAN
         O2AETqevLiLdQ==
Date:   Wed, 4 May 2022 13:56:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH 0/6] regulator: core: Add support for external outputs
Message-ID: <YnJ37QysSaa+gAps@sirena.org.uk>
References: <20220504065041.6718-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w/VS4GgcCdfjbUlx"
Content-Disposition: inline
In-Reply-To: <20220504065041.6718-1-zev@bewilderbeest.net>
X-Cookie: Your present plans will be successful.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w/VS4GgcCdfjbUlx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 03, 2022 at 11:50:35PM -0700, Zev Weiss wrote:

> The DT bindings changes (patches 1 and 2) consist of a boolean
> regulator property to mark it as supplying an external output, and a
> reg-external-output binding to act as a downstream device representing
> that output.  The redundancy between the two maybe isn't entirely
> ideal, but it was the cleanest approach I've been able to come up with
> so far in terms of working with the regulator subsystem; I'm certainly
> open to suggestions for better ways of going about this.

Nothing in the series articulates what the purpose of the redundancy is
- your description of this is a consumer, why would the regulator itself
care what's connected to it?

--w/VS4GgcCdfjbUlx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJyd+wACgkQJNaLcl1U
h9BkfQf8C9n7pk9sOlU770h8zAnMrgTZX6YUlmWUCZ20GO3OG+Y9Ufo6DjYIFFMP
/23xU738nEL1GCU0/vktgE+r09jGXVQNtAXZRILLt2CxulR7Pe2ojiCmxHAOc5Dv
bBwKwPk+N5L+9dvMQeTQDuLjfTrdbabEE6yEEfv5xu9cqjG2phSuqjvaIS6GA2Nj
g9AP/t2UHV34bc2xeGRhLdJGcsu02FVjXxP/DPnofadK+p6YwiHBOd6MCxMrpoty
iKwdy6ruqlM4NURMVpi89+pcwimfcH7M/XiXd6YnV53HAwx6Fsbd7zlk9QyRKxx4
BOFFM9X5TWf7//qC2U+sIqn35dco7w==
=dy9O
-----END PGP SIGNATURE-----

--w/VS4GgcCdfjbUlx--
