Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29A54C1553
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 15:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241514AbiBWOXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 09:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239615AbiBWOXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:23:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3082B18AC;
        Wed, 23 Feb 2022 06:23:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 561AAB81FE0;
        Wed, 23 Feb 2022 14:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27E3C340E7;
        Wed, 23 Feb 2022 14:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645626201;
        bh=SrO9bsrYuRt7a8bRBkavU0Z0ZAQi8lO6YTykWYTLTLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZwRlc/wbqx1ItVhhxrDoIO713Lw9EURd6cCNPGOXG6vl+ZHzdl+O9iEDA35f46rYK
         vK7tjqDaNYGarr2z/J6QLCIgddURexrZf3WW5CFRtuHm6IT9c3hR1cFAY69YCAXOkS
         6+FZLXQWIpF9SMp1fLnNaJRS6DbSYFTwSDXQOQAwcin0VqoLZyCAVTTe/hKKnJITNr
         gN/AgCeh9wQ/nUmXdyiUgnNan/IL787Arip2wVCVFEo3BRyU1mAW0mXP9b1AaTzWVX
         9VEzzuyL/Q4sYCfpqxgdRXtPV0E0r6hjhM1cJgooicQiQke44MXZaNPPdZ5o/Xx9ec
         jAadmBbA3+HaA==
Date:   Wed, 23 Feb 2022 14:23:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, kernel@axis.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: virtual: add devicetree support
Message-ID: <YhZDVGC7dPiisnI+@sirena.org.uk>
References: <20220218110604.1329024-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lWslcJViHbwM70Q/"
Content-Disposition: inline
In-Reply-To: <20220218110604.1329024-1-vincent.whitchurch@axis.com>
X-Cookie: I smell a wumpus.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lWslcJViHbwM70Q/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 18, 2022 at 12:06:03PM +0100, Vincent Whitchurch wrote:

> The reg-virt-consumer is very useful for development and testing of
> regulator drivers since it allows voltages and modes to be set from
> userspace.  However, it currently requires platform data so it cannot be
> used on modern platforms.  Add support for probing it from the
> devicetree to remedy this.

Meh, you can add a bit of code on module_init() to register a platform
device or something.

> Since this driver is only meant for testing and is a purely software
> construct, no binding documentation is added.

That's not going to stop anyone.  We should at the very least be
printing very loud warnings if anyone tries to intantiate this.

> +	if (!reg_id)
> +		reg_id = "default";
> +

Oh?

--lWslcJViHbwM70Q/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIWQ1MACgkQJNaLcl1U
h9D9rwf9EWvfPUGwP+cLGGFzy4Z+mcsPdZYQYP30JWIZwVe3K3vTEbPRkttdtl07
rDGuj7BTTUaTMZVfNBzaTYiJKR34JTG3ksTuf8OPY87vGtVx6Dy/TweYrY8/voGv
nuBM1MQRgeZN8SsOyr7ojtM7I0LlY7ZMda0cMQs3s7T4Ct2oOjPAXzJMqD2h50XL
5652wNjIeLQJ80pmkawLuinxsKWzdcyrxHJ0r0Pal7ZQ05sPHEDc3nPI90IDEaAy
Bnfdn+6qpFZ0yQz9UsXfp0Q6Ybw/hp6dYugLxjiEtzfBgUrWbJeBwomkjUiJ4COx
vjl3gwCXqq/wngpZ8k3wfQlQNrIYCw==
=Flk0
-----END PGP SIGNATURE-----

--lWslcJViHbwM70Q/--
