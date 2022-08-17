Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D20A59701B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbiHQNo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiHQNo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:44:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA3B94EEF;
        Wed, 17 Aug 2022 06:44:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FF2D61403;
        Wed, 17 Aug 2022 13:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6EBC433C1;
        Wed, 17 Aug 2022 13:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660743893;
        bh=axBECSzV/EqfT0Sn05l3MHwC6tk13jz5uq2PwFJrwcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IKByo38T17YV6cNWZZl0rJZRGDfiecze0MgLBe36G0uCpz1QXq1sDSqpLNsi0MByc
         jfx1y0Q78Ey1XCVc374+QNXBGg5S5/tj69bMDJwXwn6YIo20LVzDJEAL+ugax6C3/u
         tcdZWyMu+feSH3nrDPjzpTVUP492ynZYj13J4v86ENKCefqvRtEq53r6gyDddDb4tp
         T/wyc209XPcAFl/qCEFJDy8tVU+rPH+Cp4LYNJFnONiuGywqzTfdittKnhMjzLSZIx
         fOdI3UY9n4FDtm4D8CtTJR+NSGVrGT8HYKeQubadJY6rgNu1ZNXYNe7yCqhv6C7OV8
         8oYW1AiHSkZGA==
Date:   Wed, 17 Aug 2022 14:44:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     sanju.mehta@amd.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com, alvaro.soliverez@collabora.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: Re: [PATCH] spi: amd: Configure device speed
Message-ID: <Yvzw0GqUd9ZgxUTo@sirena.org.uk>
References: <20220817131809.312533-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6FocHUaNXur4kiU0"
Content-Disposition: inline
In-Reply-To: <20220817131809.312533-1-shreeya.patel@collabora.com>
X-Cookie: Use extra care when cleaning on stairs.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6FocHUaNXur4kiU0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 17, 2022 at 06:48:09PM +0530, Shreeya Patel wrote:

> Create mechanism to configure device clock frequency such
> that it is the closest frequency supported by the
> AMD controller.

You shouldn't use the closest, you should use a frequency which is
strictly less than the requested one - driving things too fast will
generally break but too slow is pretty much always fine.

--6FocHUaNXur4kiU0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL88M8ACgkQJNaLcl1U
h9Bw1wf/ZyAh2aIJGCThq2MRGZPYvLvL2UXlzTF0y6ANGohcz3kYFgyEg2GeTf22
YGrIH7UuqTEb+jWL7sews+gNZ04cB1AYSphvkamTlVFARillpOteigu10mX72p1i
F3NY3qJ9jPzFP+jVu/Wx8B7lROHuVJ0D9Fw4W6Bu0tfjyjsu73X6KmaVCA5XRmVt
zKZKQswcTmr5Ce/kBk+i7CbOmqnZ+eXtEUp9sFulcxFFFfdAVdDogjktFEGy4mna
bU2ougQgzHyttoXNedBN0S8ih7YjULeyr2qlbZnoXOtvOXHVjg0dpimBRYiglLn4
hG75Lu+wV/IIvp+3F35IbWGkzA44hw==
=scUh
-----END PGP SIGNATURE-----

--6FocHUaNXur4kiU0--
