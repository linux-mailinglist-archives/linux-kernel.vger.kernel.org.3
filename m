Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FA356BF65
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239590AbiGHSdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 14:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239585AbiGHSdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 14:33:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6042DE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 11:33:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9ECB7B82568
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 18:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E464C341C0;
        Fri,  8 Jul 2022 18:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657305189;
        bh=JjZnUqafGkRrsiUKGbc7gJTfl7yg8X2BFMKWtjI3ppM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aUSfZ1bE3gaHMnw3DMG3ZS3v0frKJ6d7aQ2ZxpDPfG/TMc7lzTWSJPYUvnyFXdHYJ
         QKOFbvuF5JIN4UgAVyWADbPIgiiFWA8SscC59rixemBscnl7KnXZYs+4w6CpFArWhs
         9tTcydeo8AdTmHwW2atZ9sB+oXzLyRAyi+dww+X/y677m381Fc7AegysxWdXZBd2EJ
         cdc76INayEFmOsSZ8ObSvrA+dapCobbcEs0eVbQ19IA26FWvXoVbDzk6aaJ5vMGmRu
         wOEeXKQId1fQPeBCBa0QQikE6ksDHxx6od/hNoe/m39Ng4m8MebH7XxKqFzyJbR1bB
         gM6fwBCArCT/Q==
Date:   Fri, 8 Jul 2022 19:33:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: regulator: add bindings for
 output-supply
Message-ID: <Ysh4YOG1czB8gfpm@sirena.org.uk>
References: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
 <20220707081826.953449-3-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JuMWJVyYHide4JUv"
Content-Disposition: inline
In-Reply-To: <20220707081826.953449-3-Naresh.Solanki@9elements.com>
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


--JuMWJVyYHide4JUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 07, 2022 at 10:18:24AM +0200, Naresh Solanki wrote:
> Add a devicetree binding for the 9elements,output-supply driver.
> Example is also provided.

It's fine this time but in general if you're sending a patch series you
should always ensure that at least the cover letter goes to all the
relevant maintainers so that they know what's going on with
dependencies.

--JuMWJVyYHide4JUv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLIeF8ACgkQJNaLcl1U
h9DlWgf/bcNS49QAdGVXw97/3ygujRnBrNxYUXXbxTHg6pQO7IXHeXH8+dj1fVwK
+HMRIbM61XBH65km4ZPPDyn7pjp+WRdnULx1kseTw2wuwuZcbLqu5dv2e+qwwdr1
3yOWLOgyugtlkGcX71iFnHGRapffVJnFP3FiphcDCJ7ftv0r/uHCcf9RQn31WLZF
j0v58Fx36LhKMPzfZAogmvaDOk+mhTNeISSmBzjc0HQlpXeKzDFr2F4Bbxk7ep/p
yNTs/xZlbbY73gb1DMVRzywneOSXJu65gD+nO26Lb/OqbzWNeyScAy7250N4rGLy
3xiWNFFyT00m8y/AnSUgWR+Ci/c6Rg==
=FKXo
-----END PGP SIGNATURE-----

--JuMWJVyYHide4JUv--
