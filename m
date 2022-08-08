Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7730B58C9BC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbiHHNsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiHHNs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:48:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD2263A5
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 06:48:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A08CC6069F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08E9C433D6;
        Mon,  8 Aug 2022 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659966508;
        bh=X0HV5fhPXLUm7NKTXFMV95hb8lBSLoQ/OJXqnQiMfK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oRGo0mtjC6m1kP8UNXbybRa2Un2g7srfKYkfWbpIqWQ4Jl3ohLQSnSGtNgy+AS5se
         Zlr61V1czlqDFVdSn68EcckmBlpgZckNbv3edSxNw0LQWm9pmasiPNwVVr7khs12rW
         fZ2Q9qZMTlJojiRf5JUvWqmZO4vViPO+LCGN1wWBnItnBYBK1csV8cK05RZFF/KW8+
         qy7OGGgsXL/UKpvKRGfCdhWabGXh1gwGKP/wOL9/K3pvKF021bhh9dXR/AxoSatir1
         +1zRiAEM5HKUuwTZQ9E55wwVR45pWUqKEYrSEipItiBL6bYXpgqXijI4lpyTlfVMjH
         A2bwvOd+qI1QA==
Date:   Mon, 8 Aug 2022 14:48:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/5] regmap: mmio: Don't unprepare attached clock
Message-ID: <YvEUJ12TmgRaR4Ub@sirena.org.uk>
References: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com>
 <YvEKgkhRWCKtXdD4@sirena.org.uk>
 <CAHp75VeeZAgKdZhJffNouFh26rwGzmqGuJX7bcObSVV+dFS-tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZxuxQCJ31s+QoHqV"
Content-Disposition: inline
In-Reply-To: <CAHp75VeeZAgKdZhJffNouFh26rwGzmqGuJX7bcObSVV+dFS-tA@mail.gmail.com>
X-Cookie: Flee at once, all is discovered.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZxuxQCJ31s+QoHqV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 08, 2022 at 03:41:48PM +0200, Andy Shevchenko wrote:
> On Mon, Aug 8, 2022 at 3:19 PM Mark Brown <broonie@kernel.org> wrote:

> > regmap_mmio_attach_clk() prepares the clock that's passed in, we should
> > undo that when detaching otherwise we're leaking a prepare (as we do in
> > the explicit detach).

> Why do we allow the user to avoid explicit detach? What is the point
> of having that API in the case we take care of it?

I think just for symmetry so it's obvious that error handling is
happening if people want it to be.

--ZxuxQCJ31s+QoHqV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLxFCYACgkQJNaLcl1U
h9BdvQf+OJJbTrFaHiI8cc4lrDovCbKsQ559BIfDzBz+m8Kt7j/yaQHHzcjBBn0c
0HyvJKLRNDSwcM/sKIxMWSOxqNH9qi7edMnqJd+tKwjUJZOtJfGuDjNoT3eaYNuL
TBpCMPhH4mAyipt1NkcwnGKLELyKQJ7ltiiLtSlqTOmQ9DUA6P342nbdVyvGmxM0
aZ9gmhjZ9gKi51kcsjtjCnwNKwq6TIaJENDBvwLn75WlPhTgQBWyx2ALHU/6ER0y
q+IC8cTebkB6MA9oH+6fbFNy7WXdkCj1uA910lAyPg/SqyuVsY9r2csro8IMuGR1
70bd5D1V7CAyBlcZMwaLDDiISTIYww==
=e58/
-----END PGP SIGNATURE-----

--ZxuxQCJ31s+QoHqV--
