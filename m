Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD29D4EBDF4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244974AbiC3Jqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244965AbiC3Jqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:46:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A0DCF4B9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:44:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63500B81AD3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF3FC340EE;
        Wed, 30 Mar 2022 09:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648633487;
        bh=+O7GmhC9zbSZbg2ryn355ouUgoqZbNgg5p1/K4NSEy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eZmM7mUl3ZOUIRfpcr5rDfsevyel+HX0ZXKAOveB5qk3HY6jYiz60Rw5ymYoZ+NPK
         X9MtJk+CKQy90smCRZNzyRntwBaXf2w8rLHbjAAbiCcD2ashMfBmpQqESl4c0pNiUR
         1gz2wT7hdQOGu1Xx/AKRxqbM8r+tbhYHjXQhjGLf0L/319t4AfI+t66y33xln5mk8G
         Xjvw7bRngf85e8AXB7OqNnCDjod49YnOlR627LisErxu1aQ7K4OOLfMaiyyILfoPaC
         vXaFJVwtL4Gs6IFs0rWBh0J3VI+H0/adpf53girQ0C5dyYi/Yg4EcurRHsDWn7OVl1
         WhsOuHTB4NgQA==
Date:   Wed, 30 Mar 2022 11:44:43 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: da7218: use i2c_match_id and simple i2c probe
Message-ID: <YkQmiw3ZYaRCrzIm@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Stephen Kitt <steve@sk2.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
References: <20220325171904.1223539-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uolMz3Y09fBjlBuc"
Content-Disposition: inline
In-Reply-To: <20220325171904.1223539-1-steve@sk2.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uolMz3Y09fBjlBuc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 25, 2022 at 06:19:04PM +0100, Stephen Kitt wrote:
> As part of the ongoing i2c transition to the simple probe
> ("probe_new"), this patch uses i2c_match_id to retrieve the
> driver_data for the probed device. The id parameter is thus no longer
> necessary and the simple probe can be used instead.
>=20
> This patch follows the model set by da7218_of_get_id().
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>

I think the device tables should be moved up.


--uolMz3Y09fBjlBuc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJEJosACgkQFA3kzBSg
KbZ0lBAAn67zwawbhM6pV27dEbKDduQnzCsorpdheadSv8teeoIh5s4n2NHa9AHS
/+vzYih/DBaRwwJsbB+ezLwL5KxntqqDNXCgXrgP8GrHmKcOgL/28NlDOumUOyS2
m1TmMdMrf9USWa/EAGkvIOJDCjIqp0yl+RPeK++J7korLwFHILPHaTQha/NYmVbf
A3+BAOZY3Jui7tnyjyDCdrqQ/GPx0+F5Bz+C0wsvHqnVOcLNPXCIfqZ/hYuxP0Fj
v5nr1Sx/Dxb5Yekl9IpX7HWp631Tl8IdY0+a2d3F0Q5LTnQvXOHiu8sv8WhOA3WY
dU7+Y8k5aUG84XSLnwcv1miqhdBxmiRR4XGLsbCmJV48N7v/SDvDe9mv5Nk4kUfP
khBOzr6BtQ5SMQcaW5y437qt8jSQI9NxSZRMRRGecJF+bECFI5BslpedYGRx+Kx+
XxkotQbKaQ90KLzy1nC/GHa357J4DIY5icHa1kOfVfp2l9CIo4cx1aIga46DdDC/
3pWpQLH2KwoI56bHdVZXyw/a+2UDKWlLnXXFxPgMr/JPouTkZCSWsqm74Wwu0u/W
LgSfL87q/cWZh9tSj5JRJGe0ZGSRmY5pK18nDe2W0uPqrzHwQXA4K+XC9j+/eCsQ
8IQMkYc7GXSXE17SD4DLJ0wOKnz1hnSrg20Xf5IwWzPXPB5QWO4=
=L/Dd
-----END PGP SIGNATURE-----

--uolMz3Y09fBjlBuc--
