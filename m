Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC804B13C2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244975AbiBJRBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:01:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244961AbiBJRBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:01:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C141B89;
        Thu, 10 Feb 2022 09:01:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B26FBB80B3E;
        Thu, 10 Feb 2022 17:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0775FC004E1;
        Thu, 10 Feb 2022 17:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644512493;
        bh=dv8aF6C+GpjjTzgF2q94YYdskfAMx96/Yaio7oQdjSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L2NbbYc9nlGxg/OOydkY8/SJ1fKXxnnmqPCjXZ4QEhxybGmhQTyfzAPIXrbQnDVvB
         4fwk7UNdKNeoefi2pVp0hZls52/EGlAqOZe7QAg+tsGyrt776KURFyCIqIdVC9sftX
         U8QbU/oHhHAJsXcKJaSllNFkld8Y8nNNnv89o6eu6rOlNi4fpXdOZSekKgkqv75vXb
         QENLvKjG9+DG+bkvBNpMpH9Lh9hFopctqD7tAclhzY2gMen49Btuu3EyM5neuu/rFb
         C9bzr37P2AfDAaQp9YyKANPBuPVvErryFZVRB1oQy7mdKPuwbi3AX+YoP1OCf3QCeF
         nYWVQ/V/nygIA==
Date:   Thu, 10 Feb 2022 17:01:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] regulator: dt-bindings: maxim,max77802: convert
 to dtschema
Message-ID: <YgVE5ZbklXqydzPf@sirena.org.uk>
References: <20220111175430.224421-1-krzysztof.kozlowski@canonical.com>
 <20220111175430.224421-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N+hlmUmxXfoo8vu9"
Content-Disposition: inline
In-Reply-To: <20220111175430.224421-2-krzysztof.kozlowski@canonical.com>
X-Cookie: Only God can make random selections.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N+hlmUmxXfoo8vu9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 11, 2022 at 06:54:28PM +0100, Krzysztof Kozlowski wrote:
> Convert the regulators of Maxim MAX77802 PMIC to DT schema format.

Acked-by: Mark Brown <broonie@kernel.org>

--N+hlmUmxXfoo8vu9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIFROQACgkQJNaLcl1U
h9DyoQgAgWMPe3ubHmt4vj20NFCjCgnjSgWU62e9KuzM9G0r2pTydGBpVGyLZJJa
xpI3k7qTE0oStMFYM42UhsvZKidUxaLyFikbkzBQTxz6tGkyVPBPNSjDHcSnc8mh
3y4tctjaBc4uN2bzGBh05IioiZp8EhqAoRD8qfmPfGqPQ1sLiFYWUm9AMOkcs/Mc
sDIHXSYgcVPUqWRcMYGIWA1sghsbyT0q84TCcEeXQXYPUOWvbtnAoGR+8fN7m2mO
IWMshO0jnYC04/VlrOECepT/ZUyv848M8X4fUHFvknGTgtk8C2cO1BPL0iJVJYAS
aZqE1ZCogc/Bc44S+Is29CvrfBkLTA==
=k8AS
-----END PGP SIGNATURE-----

--N+hlmUmxXfoo8vu9--
