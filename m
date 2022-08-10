Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AE858ED7F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiHJNlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiHJNkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:40:45 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DED3055E;
        Wed, 10 Aug 2022 06:40:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CEAC8CE1BFC;
        Wed, 10 Aug 2022 13:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A988C433D6;
        Wed, 10 Aug 2022 13:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660138840;
        bh=wLk5bRUV/7zoq0ykHRoJu6VMP/9stZ4NhAOjcjRvdhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UfTKxEyXYWHbIKp5OFyPWVgJ4+pDpCPoy1i/b/7uwS+iC7Pcj4Pq52DfHnt1BfWC4
         0wY8qwELzASM7xo0DpkVnjcaQVVNlfU0T/NgL3yaEYQj+cbrdvpVWw1WUGNOxrnD2z
         OmB0S3VZn0165sjNrC04uOHXcoezAPz/2kO/FpybOXoHUSq4ZMxe5zlB7R0nrsH3HY
         RyPAV+dsSlxcl6MYa6oxCmnEOJqEb6OOSpjOOFZKPSPK+f5oVytfFbVJ671+FfDmDZ
         shJb6IrXXf7YrqiZhN3x+UQFfzgAfgU9lJUJRiVoYTS5uE//bquI1OtdtFY8ltiNu3
         kP8v7xEHOrcCw==
Date:   Wed, 10 Aug 2022 14:40:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christophe.kerello@foss.st.com
Subject: Re: [PATCH v2 1/2] spi: stm32_qspi: Add transfer_one_message() spi
 callback
Message-ID: <YvO1U7VB7WQv0oKR@sirena.org.uk>
References: <20220810093215.794977-1-patrice.chotard@foss.st.com>
 <20220810093215.794977-2-patrice.chotard@foss.st.com>
 <YvOtZtrRHd4AT+j+@sirena.org.uk>
 <d41e3814-3fab-18a3-7218-d5c28eaecff8@foss.st.com>
 <YvOxOg0vXSGrZLfP@sirena.org.uk>
 <38200a6f-fdc1-fa94-7bc6-91ca528235ed@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="21y0RXUsptdj3o80"
Content-Disposition: inline
In-Reply-To: <38200a6f-fdc1-fa94-7bc6-91ca528235ed@foss.st.com>
X-Cookie: First pull up, then pull down.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--21y0RXUsptdj3o80
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 10, 2022 at 03:31:59PM +0200, Patrice CHOTARD wrote:
> On 8/10/22 15:23, Mark Brown wrote:
> > On Wed, Aug 10, 2022 at 03:15:08PM +0200, Patrice CHOTARD wrote:

> > Yes.  Though I'm not clear if the bindings actually want to enforce it
> > there, it's a device level property not a controller level one so it
> > might not be something where controller support gets validated.

> Ah yes, i see, parallel-memories should not be used in our qspi controller node.
> So i can't reuse parallel-memories for my purpose.

> So i need to add a new proprietary property at controller level as done in the v1 ?

Can't the controller figure this out by looking at the properties of the
connected devices?  You'd need to just return an error if we ever
triggered transfer_one_message() on a device that can't support the
operation.

--21y0RXUsptdj3o80
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLztVIACgkQJNaLcl1U
h9B5Nwf+LqqU0x5SAVtWEAkovEh2F95cA6yjgmiKu5b4XJoJIIkHIi8Hym6frbxI
/Dr2p4xqVytxvWo3HeH1mc/utjZ2nogSlwgODbdIsIW9pCVdZqdIckw/Bxc7u4nF
/sqKHA8I8UwKqgFNeEAJtLRSOvm55KPe8UrjjFXgxB3yEFLrm0jgS9ULBXNpv9Mf
W7+hbsbmtgOhkHeh9qpWExwBx/y//jLxQ8h/D0UT9F2A2TgiXMaKUeX8du0Z+PLr
HD2BB2+vm3Bq/YprTBNGp/zyFdg/ESuWfhlmG041cW0CxPKFTGcr9Oz2qEtV8TYY
fhc72oFs7Ylf8lrTOVN1FuQ+cH6GPg==
=f5sp
-----END PGP SIGNATURE-----

--21y0RXUsptdj3o80--
