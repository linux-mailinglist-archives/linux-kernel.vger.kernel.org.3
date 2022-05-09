Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E461D520143
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbiEIPjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238479AbiEIPjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:39:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF373238D4B
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:35:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AB5661124
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 15:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84829C385AE;
        Mon,  9 May 2022 15:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652110514;
        bh=Mle490mRLYD1uOY6//loxrGHridIrCPCq+9Qs76hjQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QXE1HhNrLDx0R388qjxET29z813TIgsyhzSko5nVZcBSvji2X5q0e1IvCPi3/7+dA
         PCfXSxXXDzfLDaqXwclcT9XS+GScR6/21jkNWgLUeAlkcmoH5pGTK8HOwM9ib25unN
         +6ihTdH6GaDoWQqltEAjWLhsB1cRa/rF43umc10Cq1focb/CgiQYbUrAcieIZMkhGa
         DOX15CAh/SQe8dX10lch+rC9lZZNp7BLIlp2Zriq+h1oz6lDu+PhR4GCOfVeyjJ1Y3
         f+DnavUwIZ+7ODRO1VxAzzzhzGYuwq0RZi5KhrHW0v2ernel715H6oASfUBNnBX4OF
         F0LnzHuGcYoRg==
Date:   Mon, 9 May 2022 16:35:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: ARM Scalable Matrix Extension is ARMv9-A
Message-ID: <Ynk0rgKMdJuR/aB1@sirena.org.uk>
References: <df002b0ff3cb89954d5a2c39a5dd8528d45771f3.1652103603.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9jRs+tTqM5TK8W78"
Content-Disposition: inline
In-Reply-To: <df002b0ff3cb89954d5a2c39a5dd8528d45771f3.1652103603.git.geert+renesas@glider.be>
X-Cookie: Boycott meat -- suck your thumb.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9jRs+tTqM5TK8W78
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 09, 2022 at 03:40:30PM +0200, Geert Uytterhoeven wrote:
> The help text for the config option to enable support for the ARM
> Scalable Matrix Extension does not mention the specification baseline
> for this extension.  Make it clear this is an extension for the ARMv9-A
> architecture, so users know when it is safe to disable this option,
> which is enabled by default.

If this is important we should probably also do it for SVE, it was
introduced along with v8.2 but that's not called out in Kconfig.

> Fixes: a1f4ccd25cc25625 ("arm64/sme: Provide Kconfig for SME")

Fixes?

--9jRs+tTqM5TK8W78
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ5NK0ACgkQJNaLcl1U
h9DhJAf/Upz6fZRKqxjZKOspl3F2+5E4whiZVwjP2eXqebtqLUegbDGmsDbW9mac
oO2oGKs008qZc0zidMFXEsm5FbHkCq6R/h9uJ0jUQEaPw5l7r9tGSKGhWGxkOeTC
tG+5mj1sMkklYWOKGpmWrSctnExGrZmU6sba1g9fiexAQfwFFugGRi7rTtQzXy0A
iGYabJqQygbJlHhlpTQynmRNG2eHU164VnvmspJCBZ7T1IiMIj4zyjbt17tvnXhO
0INxBWkuIlN0QRLtPQ7Ia7Jitxl2bMEcGn5qQgfkwEjaqAtn9My13RLec64ToobM
6Y5XFxkSYM+cu/DYK/VYcwfvIPMVzA==
=lB4v
-----END PGP SIGNATURE-----

--9jRs+tTqM5TK8W78--
