Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096ED4E99D8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243941AbiC1Oir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243937AbiC1Oim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:38:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26925F8E5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:37:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E3C5B80E72
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 14:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20443C3410F;
        Mon, 28 Mar 2022 14:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648478218;
        bh=EgjhJsyfkkEmUwALQVxv6IQFR/KBuoTskugCKopKgXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RERJOIKfE2LQJGNsr6kyhFC4xIrnvt1E+P65PpeeP3K9FPXU88STjITT6B2Wqiyq5
         o/cWLYL/EH0oy+pC/LuhaPAGeCPIHMTU8d8GUPEIW39cXLtxCsqKlPN6EvSXv+k2wL
         lT4WEdmi0CVuGAot8WnZPI0GOuG0JGhvasMegPbRG1wsT6lHeNbA4UDJ7MagFKSkaq
         NmMT3HO3Vs/h9yOvbnVyEbqoG1m/3jlkvhd0i5Eh/PpRolz+6gSrBify2AhiLFgdFR
         yiwd91l4M4QTsTTyEm+rTDNEpAycg5X+90sOEPteeXcdxSqbBNmUEzjWHSgUfrVPEh
         262znetyLZ3WQ==
Date:   Mon, 28 Mar 2022 15:36:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Jonathan Bakker <xc-racer2@live.ca>,
        Liam Girdwood <lgirdwood@gmail.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regulator: wm8994: Add an off-on delay for WM8994
 variant
Message-ID: <YkHIBXixM1rERxqg@sirena.org.uk>
References: <YkDpozx+ZmSWwwH0@sirena.org.uk>
 <CY4PR04MB056771CFB80DC447C30D5A31CB1D9@CY4PR04MB0567.namprd04.prod.outlook.com>
 <20220328131132.GI38351@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g9xa4Sd2B6kwk7yI"
Content-Disposition: inline
In-Reply-To: <20220328131132.GI38351@ediswmail.ad.cirrus.com>
X-Cookie: What hath Bob wrought?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g9xa4Sd2B6kwk7yI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 28, 2022 at 01:11:32PM +0000, Charles Keepax wrote:

> Part of me wonders if we should just apply it to 1811 and 8958
> anyway, I suspect they have the same IP for the LDO and its just
> the datasheets never got updated. I had a go chasing the apps guys
> here but we are a little short on people who remember details of
> these parts. So I guess we trust the datasheets for now, unless
> you have any strong feelings, Mark?

With something like this the on/off time may be a requirement of the
thing being powered rather than the regulator, the device might see
enough power loss to confuse state but not trip the power on reset.

--g9xa4Sd2B6kwk7yI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJByAUACgkQJNaLcl1U
h9ChTAf/fQvhW8hgxhxvYQzcr6WQ1K5jWew2gfT/kPx8rceOZwGEitwYx02uVDZS
3XTkN7D4u7iwDszYE3NFJuamW/yPYSW7l+w9sFHOh0kk6rmrUXVWFGdPC5jEzujI
stnGaBxBgR7f2hq0CljzxtKbOcL0yaYmEHtLv728JZvF8zGZNj9xfb1in0dG4y8u
PPE27+SDmoJhJ1ufWS2/15rzt/LLcqRhieGmpPVeCO7/0wYI5eR4WK5RFr1o+MAc
pVs1iNvp1qe0JHMf8ra+5Dhzh4uo4fH1SUsFmgLAu0Zsa/WUC5M5Cx4EHYHao4OE
IZr2w+hUcXW3UxS49Uvrh+FNhaJh/w==
=2dYE
-----END PGP SIGNATURE-----

--g9xa4Sd2B6kwk7yI--
