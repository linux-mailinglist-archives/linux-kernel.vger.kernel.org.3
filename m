Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6314F5A98EF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiIANe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbiIANeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:34:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71521C937
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:31:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6171E61F6E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 13:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E3DC43470;
        Thu,  1 Sep 2022 13:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662039117;
        bh=VgZDTCN6uXpF6cIuenTHt0f7IH6SBBbyM2a2aGID29U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sy0Yje61ngYQBQ5Duy54Hy1pEigXmYuXfoMqBgqrycRSGbDZMybM7l15VQcIvV7VM
         NsPrzKGLVplS2mKBsQrrh0jagn0rTum/TjqVoBdvRw2LtUXbGouS7nLB2jbuJe7LqR
         EKu7sMVGNR3vnybYOtrrCARHT1Wg8C7kKAHsSvc6aBPCKDttkZm3q2qzyjNIJ4fVYf
         MZnqAdg+bguUO+e9oVEM5kkk/yhEPdyfBAVnwJuV9L846zKGV8Nrv0yml5i5Njo4S2
         fy6dBRTPzR4SG+opln4LXS+YlIQLCIGW2BQ5nRX3+lxdGM9wPqdx3VzKORxGJNw+lD
         xOy4k6UxjYuMQ==
Date:   Thu, 1 Sep 2022 14:31:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 2/3] regmap: trace: Remove explicit castings
Message-ID: <YxC0SYShl14TSw2o@sirena.org.uk>
References: <20220901132336.33234-1-andriy.shevchenko@linux.intel.com>
 <20220901132336.33234-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QOnwprNmah3DD6Kj"
Content-Disposition: inline
In-Reply-To: <20220901132336.33234-2-andriy.shevchenko@linux.intel.com>
X-Cookie: This bag is recyclable.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QOnwprNmah3DD6Kj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 01, 2022 at 04:23:35PM +0300, Andy Shevchenko wrote:
> There is no need to have explicit castings to the same type the
> variables are of. Remove the explicit castings.

IIRC this was an idiom that the trace code was using for some deep magic
reason to do with some fiddly preprocessor stuff.

--QOnwprNmah3DD6Kj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMQtEgACgkQJNaLcl1U
h9B7UAf/UzDHQHXRnG/vYmFhz2WgUr2A1ucRWo/7CFSkxXN2/o90aKzBkePaG5HL
t916fRQCYG3PrsX5ZWt+m73o+336zZbZitevlrM2UrzGsZuv+zvT6KQhkmLIbAHW
e1+EXWFtItFQUmylDFfuHoG3attCtV8qmmakhuO+enSTSuBuQ4vPufUZIz7RyNlP
84wjlCQh+mZE7hiRMkU2YxVjARuQNPaF2aLgRcpwbZ19SVs3hH9dGZUKcNTL1hw9
8FDE6dNt+3IKoQQ0H3hs1IQSAt89oymYOJJMBKQYUjeYg+q+qa+CXobpg6KWkQkT
5BTKZDrCS3+j5B53p4jkkin+OEWq2Q==
=6gOI
-----END PGP SIGNATURE-----

--QOnwprNmah3DD6Kj--
