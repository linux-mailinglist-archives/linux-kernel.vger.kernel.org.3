Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087D756B9FD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbiGHMoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 08:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238347AbiGHMoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 08:44:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B242D1FF;
        Fri,  8 Jul 2022 05:44:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8472EB8263A;
        Fri,  8 Jul 2022 12:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E64C341C6;
        Fri,  8 Jul 2022 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657284249;
        bh=BxRFS74/wPXVWhnRUFG6v6MJTHoa+rf4xlBesuE0Hd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9fd+19FkzNtAqLhIan/U6Be0K9sXFROEBzEgAQTXsaN6Lbn1onla82CqFYdNyH5T
         8RLJy844UNDQmodz/TfLMrq70GztnZ2dq2VZOIiUe6Vy9mIHHG2uGibLGYYcvFxplw
         VuccJADL5kwO9Uu1O1mnOl+CQAHYBjGEDczHF8ucFoKQ72vKNtGplq7yRC9/tEoVtA
         UXcb933U6Xa55bR1sG9YxzP3NEGM5utMyv+d76gxq+AimHs/P17hEVUzISYQdWZ6pp
         BRjQ60Jb/TrQ+FqD1RIA6V4XFyHzYZf8deFPSDIe2unCLn4xNb2tXiS7vPveWuMEui
         vsovH2uBwfU2g==
Date:   Fri, 8 Jul 2022 13:44:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     paul@crapouillou.net, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/11] ASoC: jz4740-i2s: Handle independent FIFO flush
 bits
Message-ID: <YsgmkBpk4JBTkjPz@sirena.org.uk>
References: <20220708104304.51415-1-aidanmacdonald.0x0@gmail.com>
 <20220708104304.51415-5-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iMtDllGA45iC7Bq8"
Content-Disposition: inline
In-Reply-To: <20220708104304.51415-5-aidanmacdonald.0x0@gmail.com>
X-Cookie: Baby On Board.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iMtDllGA45iC7Bq8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 08, 2022 at 11:42:57AM +0100, Aidan MacDonald wrote:
> On the JZ4740, there is a single bit that flushes (empties) both
> the transmit and receive FIFO. Later SoCs have independent flush
> bits for each FIFO, which allows us to flush the right FIFO when
> starting up a stream.
>=20
> This also fixes a bug: since we were only setting the JZ4740's
> flush bit, which corresponds to the TX FIFO flush bit on other
> SoCs, other SoCs were not having their RX FIFO flushed at all.
>=20
> Fixes: 967beb2e8777 ("ASoC: jz4740: Add jz4780 support")

Fixes should generally be at the start of a patch series so they don't
end up depending on other patches needlessly.

--iMtDllGA45iC7Bq8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLIJo8ACgkQJNaLcl1U
h9B9kgf8CT0MfwU8RkShIGj7UdUEyFOhRfUqIEDavq/R9O1q1FvEygiH0xnSn2G7
YZ0Vez4b0jAt0eRtXGfW87yw5YoX0J489Gb4Cwd1OOHXd1AfN5v6mOuYxccuPzVb
q+tuMq7GCNZCVbqcCgHR+FaBLgbP/3YYLontc0Dl0tx0M6nqGs1/6u2IEY5kv2Gl
f3sP5jb1Q1b8LIyUnF2uLz0GV++dCt0vsQ70Ji6bPyE6dVVTEH8Cf0GVvIsOo4SU
2BjTqZoppM2ZVOhyyZ90au6bjKjrL8frjl7AmRdKTuguAzhi6Q6OHGLrj+Z1ztIb
CCwyurB2OTlUhERrjDewaqU468jK9Q==
=lFdd
-----END PGP SIGNATURE-----

--iMtDllGA45iC7Bq8--
