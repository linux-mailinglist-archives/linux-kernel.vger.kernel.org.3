Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A593B54E767
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbiFPQgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiFPQgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:36:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75D12018A;
        Thu, 16 Jun 2022 09:36:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C24061321;
        Thu, 16 Jun 2022 16:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88016C34114;
        Thu, 16 Jun 2022 16:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655397399;
        bh=4bBttLeEIwKrz4DRXfq17+e2lCYP8BZEDmlEuYZcq0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O2cYv2qd6jc/9qBcilbSyxtV8W6f7oCo9I6lSpr+pLzQ3KFS+8iiXWqTv821K4rL/
         vCRtyGk1eDVTFS6uVeTpFX7z1kLn8VlQPdZE29cHwL/xYsW+S8v4k4RiPIyO4UJtEh
         28ui/h46YBebZtro+Jv8J51z1n7Zpk3WqfS/1nrOEmx7a1+yrgc87pSnG5HS81PfXY
         3mtCpeMJ2f2K3X3DmNLhzwHQBhBiG2zJ21eZVH4V52nko91bnfMAAbr5vBKRKHPdw7
         naNsvhlgIYH61BPUurUEE0jYgadZxHyqec+sLwsNC9LJCfFwVH3a0yvMuam3K+5Lo9
         T1XTIV7qTh+9Q==
Date:   Thu, 16 Jun 2022 17:36:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, Jason@zx2c4.com,
        linux-xfs@vger.kernel.org, urezki@gmail.com, joe@perches.com,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        willy@infradead.org
Subject: Re: [PATCH] usercopy: use unsigned long instead of uintptr_t
Message-ID: <YqtcEnD3f8KrGfIZ@sirena.org.uk>
References: <20220616143617.449094-1-Jason@zx2c4.com>
 <165539694985.1107767.16603574353239972239.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Tb/+ssbSziytONKl"
Content-Disposition: inline
In-Reply-To: <165539694985.1107767.16603574353239972239.b4-ty@chromium.org>
X-Cookie: Pass with care.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Tb/+ssbSziytONKl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 16, 2022 at 09:29:12AM -0700, Kees Cook wrote:

> Given Linus's confirmation: applied to for-next/hardening, thanks! I
> do note, however, that we have almost 1700 uses of uintptr_t in the
> kernel. Perhaps we need to add a section to the CodingStyle doc?

checkpatch too.

--Tb/+ssbSziytONKl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKrXBEACgkQJNaLcl1U
h9DsGQf/agnYcZJzmyyvrdJhNgIHMLJGc23uAFrdPZmjZSTg6Os0hMz791GpS37j
MERQ+fyUISX3EiwrP/6O1lwNeGjmy0OmS5uiv4naFkbCLhb43Ezg0Rh7VtnwWeON
zIBbdK8C1HGQLpBZ85Egn45aVAE8KptFPhEuNoXrTwzaJ6UOpXBsTjn3kit0ISlH
Hmi+RCovff+W2FVgaVLOjn2NVQBmyEi0e7E55mjf+aWd0N2ZJGyb1nKtWB5GVFW6
JXSTAJbi2ZaiSll80jw9vM2drADebwxWjHcRQyukLTUgG9vGhg+1W3A2rZtYM1ZD
rcElvH8xc/LtO6pzC/1eeQCbSOlrDw==
=XYsA
-----END PGP SIGNATURE-----

--Tb/+ssbSziytONKl--
