Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410E95987B2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343984AbiHRPn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244743AbiHRPnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:43:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A028F26AC4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:43:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E911B821DE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 15:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AC1C433C1;
        Thu, 18 Aug 2022 15:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660837430;
        bh=PwDWnl8jsSFSU2ydLgqZWVtZxs2IzrpY5IiDLBGjrsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P8oG8vgMTQQI2q3UyHsBX3OjWZ9DD3sWabJ53ySQOu7UkAMnqvsId927LwleRhmVd
         qiJrsrHTmaQVk2jPmz28cImprPLxfE9U4hBuzaxbgttMy4dJwEq5fbZoLY6qJJyjo6
         McUO2FtVH8Bqb6bNqCNqOo2xixaxhwg2YBv3goxn0eD5hckEsT95uRCqfrFeTeQaWl
         OuLUfS5aRS6v0/kD+WGkTsZThxR805HRJ8Vs41YuM92X/AYWC0AkPM389QzgnvytHU
         /ZN9FT9krrJxMS90gTvhffExWlm1b8hSZquJNn7I7mRo5kSVcSId8ElT7tGZk3YrLC
         f3oU+IpCFT5Kw==
Date:   Thu, 18 Aug 2022 16:43:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux@rasmusvillemoes.dk>" <linux@rasmusvillemoes.dk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] regmap: introduce value tracing for regmap bulk
 operations
Message-ID: <Yv5eMcmNOmyLmd++@sirena.org.uk>
References: <20220816181451.5628-1-ddrokosov@sberdevices.ru>
 <20220818121515.6azkxyqetnunwsc6@CAB-WSD-L081021.sigma.sbrf.ru>
 <87mtc1wtjz.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yXgvcwPzZDoaKgt3"
Content-Disposition: inline
In-Reply-To: <87mtc1wtjz.wl-maz@kernel.org>
X-Cookie: Logic is the chastity belt of the mind!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yXgvcwPzZDoaKgt3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 18, 2022 at 02:49:20PM +0100, Marc Zyngier wrote:

> I don't care much about regmap as a MMIO backend, but it strikes me as
> odd that you end up with multiple ways of logging the same stuff (with
> a memcpy in the middle of it).

> Why can't this be done with a small amount of trace post-processing?

At the minute we don't put the actual data for the bulk transfers into
the trace so the information simply isn't there.

--yXgvcwPzZDoaKgt3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL+XjAACgkQJNaLcl1U
h9Azwgf+OQrTlWEKH+gPInBDTTWcBUE/irY6Xk1piglxtw2ua09tM6HTWJLE/Ybx
JdLIpYISG2yBr/VZnjI7jx53J5B+SH/k9y1KlU0bPSlGQNR0WC/rs6Ydv2BVqZHN
dgFUvzhoBOmg5BI88LRfL6Pr9LN9GZmYRkK5XAyH3OQbyZlRX4KRcGHv2H9hl75k
K7dXU/PlDUGCBfUPIfJ8/yq/MuWNZsLcjSwNnU7JFWojCCLImg6NY/yflzMePwCw
JBTWoRQ+CDnP4ouJBdwSWxs6DjeZ+7isG9pPe1DNTIiVHVWNKntBmZIdMiP5rPYC
xu4uYTdCjZRvVjDi+fFgeza9mO3x4A==
=sCie
-----END PGP SIGNATURE-----

--yXgvcwPzZDoaKgt3--
