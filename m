Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1AA58ED0E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiHJNXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiHJNXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:23:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B96E2B601;
        Wed, 10 Aug 2022 06:23:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB04961373;
        Wed, 10 Aug 2022 13:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975E7C433C1;
        Wed, 10 Aug 2022 13:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660137791;
        bh=kuNflv+LVlGRoYVP2WgVIcz5hqpvWrWoxTBC7R1vsXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tFphcB8NZQsJQb23XV66rnyNs0qbvkQFV4BueYle5FvmXdXB0CtbunK/tNHyKN1h4
         UxVHVuEmg1RobuwXHWbXf1IOUqwKFsiLOqdKhCR/vHKquavbqQqqEOK3pl6dbcmx2j
         mIoGsBn2JHgbMuCCHqCJ9DMXZlIIpAWuSilP/NLWIWyp0sm8uZoKQRQROc78v8SESx
         xJSMiRcTumujAYSbcY0i2iq4evuk/1XDyWHpRX0x4A9cts7Qg4e7gExHBLbxxGcRQW
         Nrwu0+c5PZMOUJBlvBcnxT/PlRzgMeHm2SDgKYAzoYHiJM9gKRK0qIiZgzUMtvAMPW
         /hDuOGRBtJz4A==
Date:   Wed, 10 Aug 2022 14:23:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christophe.kerello@foss.st.com
Subject: Re: [PATCH v2 1/2] spi: stm32_qspi: Add transfer_one_message() spi
 callback
Message-ID: <YvOxOg0vXSGrZLfP@sirena.org.uk>
References: <20220810093215.794977-1-patrice.chotard@foss.st.com>
 <20220810093215.794977-2-patrice.chotard@foss.st.com>
 <YvOtZtrRHd4AT+j+@sirena.org.uk>
 <d41e3814-3fab-18a3-7218-d5c28eaecff8@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="au179GULwQfaFnA3"
Content-Disposition: inline
In-Reply-To: <d41e3814-3fab-18a3-7218-d5c28eaecff8@foss.st.com>
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


--au179GULwQfaFnA3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 10, 2022 at 03:15:08PM +0200, Patrice CHOTARD wrote:
> On 8/10/22 15:06, Mark Brown wrote:

> > Do we need to add something to the DT bindings to indicate that
> > parallel-memories is valid?

> You mean in the st,stm32-qspi.yaml DT binding file ? Right i think it could be preferable to add it.

Yes.  Though I'm not clear if the bindings actually want to enforce it
there, it's a device level property not a controller level one so it
might not be something where controller support gets validated.

--au179GULwQfaFnA3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLzsTkACgkQJNaLcl1U
h9Cdbwf9GfH8m3PsuOTa3pYMAN0Nk1rdYEzikCwnvXUkj8XIuLIexNhLOLUWOiBA
tdpgbrT4RPr4RShT/C2aMRKrVU+q/WFimT82mnk7VWMcYGFRNIolC3sASsuSE+7P
5lIJ94GPPAaUj6IDdDMt4f7SAD83occf53beBuBpbGvKPjHtOYeVjLmviiBlN1Fp
80vlYY/RfwhqjhKOedUShF+0KtxZeEpoaRL4bV2gM6qk5bz/+XBYNSYExXuBf9F+
KVAAejPEh45t8kaOyv+v5mlbpZXXOO66QKBB+bhafNrWtWLYS5xFYV80gt267WJu
CGlMBWb9JOZDooK5F7t8QWWs8s80/Q==
=TfEc
-----END PGP SIGNATURE-----

--au179GULwQfaFnA3--
