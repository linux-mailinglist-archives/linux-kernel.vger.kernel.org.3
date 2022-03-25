Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBA64E78A0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359519AbiCYQHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345725AbiCYQHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:07:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F00A1446;
        Fri, 25 Mar 2022 09:05:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B50E1B82974;
        Fri, 25 Mar 2022 16:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E02AC340E9;
        Fri, 25 Mar 2022 16:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648224355;
        bh=fhC4bXh2eJtZu7iYl9Lsy7SbOpvc29RlsKAkP1IIsdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YYKwIzD72zQ0fpu2yy34OTzoHAiZCgxuWxBtmzHfwP9Rdy1i6GYK86QKO92L7rfJs
         f5JjFXzvs+emwKp5570hEIgqs4FnIF0mBleru/8clA6L/FrxAXMN2aA9+oGbj6Zx7p
         gidU7a1Vr6yTIUzFQ7sV0UgXko2PbpWSViI0T3sj0jSQBDBb3qTPAvCuw9XliP3ceL
         4ePytYPTY6rqQGPKQ1LQtn9LpQLazGOYKi7P4TKWFCKJFpzVySD9C3TSDAYXjR2OeT
         5OFDQg/y4W0yDOIwq52ZxeuXK7yLYuoPCy55jrpRiFTqkiE3SAX7V7jXuWrE1gC3Yc
         N+KYhyMmocdQw==
Date:   Fri, 25 Mar 2022 16:05:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     ChiYuan Huang <u0084500@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] regulator: rt5759: Add support for Richtek RT5759
 DCDC converter
Message-ID: <Yj3oXuijuZY1gG9X@sirena.org.uk>
References: <1648170401-6351-1-git-send-email-u0084500@gmail.com>
 <1648170401-6351-3-git-send-email-u0084500@gmail.com>
 <d2b431f8-9197-4a42-4ee2-4e771e20e0aa@kernel.org>
 <CADiBU39RGQj1-+yK18mZf3MR78KACKqb2kAxkCFKGXKpJ6Nqxw@mail.gmail.com>
 <e4a15ceb-c013-96be-48d1-e65267400463@kernel.org>
 <CADiBU3-gwsh5v1NLUYr_ovXwpUxQqgR61f-Jpc3G-zHs_yV4uw@mail.gmail.com>
 <03999953-77c5-0272-7477-ab8a069b3671@kernel.org>
 <CADiBU38zYM1Rw2inTJ_Pu2eWKKqp2Ybb-_+JUJfxfmLNu=kYvw@mail.gmail.com>
 <cf67f944-47a7-f3b5-9d83-f0f51dc4e954@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FyeLtCK448S2Vosh"
Content-Disposition: inline
In-Reply-To: <cf67f944-47a7-f3b5-9d83-f0f51dc4e954@kernel.org>
X-Cookie: Man and wife make one fool.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FyeLtCK448S2Vosh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 25, 2022 at 04:55:25PM +0100, Krzysztof Kozlowski wrote:

> You mention board, some of_device_get_match_data() so you talk about
> runtime. maybe_unused is not about runtime. It is about build time.

> The code you sent cannot have this structure unused. If you think
> otherwise, please provide argument, but not about runtime (again). You
> can for example build it without OF and see...

If you use of_match_ptr() in the struct device (which is good practice,
didn't check if this driver does it) then that causes the ID table to be
unreferenced as of_match_ptr() compiles to NULL when !OF.

--FyeLtCK448S2Vosh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmI96F0ACgkQJNaLcl1U
h9D/CAf+NQmx/kuUdae96H9OhmXGbxXfUXbnPvenj1QKOJxlJQ6LmrI0ClU7AlPN
v7kWfVwLCL3lZmctPJVUf+XrNfn8l1EdxkQnvJ/uLamh/i7cFMToeBPhBHA7fK8H
8N7gcAEQF7AA4ZKIouGAfvIDS3wLMeihb+5+98/FmEkXZfWBMhdwwTl2YlVZrlEe
NEN0qtRjB1iTw0pqHQlHIdHe2owIwQU4vQG3v2jJ1IbLrFBrEzkBK0GxJ+E0QnXp
iUp2yvbX9ZnI9SyOQyEJRT1y8KOAHvXbp3uSKI/xT0+PqOS07fe2Mypam5BNeZ0o
AQGRgYqiwqC+Je61b002unlhRPK6Jg==
=OqSO
-----END PGP SIGNATURE-----

--FyeLtCK448S2Vosh--
