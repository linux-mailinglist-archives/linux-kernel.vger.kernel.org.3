Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CCB561770
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbiF3KQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiF3KQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:16:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD3E4504C;
        Thu, 30 Jun 2022 03:16:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFC9BB8295A;
        Thu, 30 Jun 2022 10:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0464C34115;
        Thu, 30 Jun 2022 10:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656584168;
        bh=jcZKWVt2cjtK89lhBmxZ8YIRJjZNI/FPZusa5VlI/N0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GO1V87FLObd07KNLLcwvaWddzRv1K4pv7OXda6p+Tcr3NU92e8x7ep8SESYToljbI
         +sJmDbECw2nWGMMgYuuEoT2mPCaFbckKYLDtd01KZxwKNSnvfO+ZwFxjl6oTwQXXr3
         ZEOXyEXlCrFQx0ra5Hix83+sN5+7ITnBUE3hzjLEBgWTnGDI1FDEjLe1MFckz3JDqv
         e6rBZLnCs/X3NwpJkbQsVGk5GqUn7svZPK/MBctvWcT8j+CdxAH0EQwaaJC3rP/Mn0
         s3YoB8Nf4fK7Rw5OeoQmZMkKLdHP5xrnFiAYzzCr0oq7K8Jgz4WTk7ThKeuGCSPS5e
         rN4NwhQMjLfGg==
Date:   Thu, 30 Jun 2022 11:16:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: delete a semicolon
Message-ID: <Yr1348gai+/fwvfd@sirena.org.uk>
References: <20220630020347.7148-1-kunyu@nfschina.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eFiyZ/QO4UMV0jds"
Content-Disposition: inline
In-Reply-To: <20220630020347.7148-1-kunyu@nfschina.com>
X-Cookie: Today is what happened to yesterday.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eFiyZ/QO4UMV0jds
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 30, 2022 at 10:03:47AM +0800, Li kunyu wrote:
> extra semicolons could be deleted.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--eFiyZ/QO4UMV0jds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK9d+IACgkQJNaLcl1U
h9DF7Qf8CAYvofkRcK5v5MvU90SRuDZNQcjuoWbLJ9bGdMBpQRcmMqGmFj1+aP/G
zXcMRgWG8gFi/MHnzncM8sRVIcubHZZtsNEJ7sAoCqtEwMbCYk3GrW+wgA4gToFa
sRWySXtIF/sxBXWuDyEWa/ck2G0LzRJHUZzpr1DsPP6mqe00ICHmRLSgXIMIcpIJ
Xb7uwh1hBKxvBDDkLOEh00deNY/ZgyqWvcFPPXu+DmaN+4D2zHo6il4S9iOonN5M
cR1PsG2fR5QMTEYsXaAGRYbRdK77LSiGPWYo2nNeTwy9Z/CgLVRlK+4++JojcGsW
wjsHxT8Rs8paU1+HCuWYf9qq9E5K8w==
=PsW0
-----END PGP SIGNATURE-----

--eFiyZ/QO4UMV0jds--
