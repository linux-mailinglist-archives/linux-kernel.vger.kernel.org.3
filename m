Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B366570071
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiGKL1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiGKL0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:26:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F326C112;
        Mon, 11 Jul 2022 04:02:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54E216146B;
        Mon, 11 Jul 2022 11:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979AEC34115;
        Mon, 11 Jul 2022 11:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657537369;
        bh=nRNWLW8OQIEFwIoD+M6iF1eixxA3yYEYZT/DiaBf2RU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lJpaqWKHRhoCrmfiFiPEGJkh/lHscsEPsTDLKnRsPmdQo1u7Ki1e78Potjb1PgeK9
         OUMAzRLzu1viE0kdloTZqZQWyvCSzzLJMvIpbk5Qe218RepvMbmvkyIBgzdssl5uaN
         DqP5FgWdiCPOyeqYswNcvzVRHIG58G6e1Fd8uAOKgzju+fLKwU1v8snylz8Z+/9nQt
         MiLVTq+i4LXYNlVwNltLc9dl2OE0l1g9wNM7j45j+PNZPM481AzJd9Mq69ejk5E/wH
         SYKku9muhEyiogd42+w1GCAaAvWliIoHTLLVmCrGtcR3HqQCI2e+YVQGW3SOPxBr5V
         13SM66KrXApaA==
Date:   Mon, 11 Jul 2022 12:02:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        khilman@baylibre.com, abailon@baylibre.com, amitk@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v1 29/33] regulator/drivers/max8976: Switch to new of
 thermal API
Message-ID: <YswDVLI+xQJGfYHF@sirena.org.uk>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
 <20220710212423.681301-30-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8sgAUUax1IxvX064"
Content-Disposition: inline
In-Reply-To: <20220710212423.681301-30-daniel.lezcano@linexp.org>
X-Cookie: I am NOMAD!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8sgAUUax1IxvX064
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 10, 2022 at 11:24:19PM +0200, Daniel Lezcano wrote:
> The thermal OF code has a new API allowing to migrate the OF
> initialization to a simpler approach.

You've not copied me on the rest of the series so I've no idea what's
going on with dependencies.  When sending a patch series it is important
to ensure that all the various maintainers understand what the
relationship between the patches as the expecation is that there will be
interdependencies.  Either copy everyone on the whole series or at least
copy them on the cover letter and explain what's going on.  If there are
no strong interdependencies then it's generally simplest to just send
the patches separately to avoid any possible confusion.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--8sgAUUax1IxvX064
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLMA1MACgkQJNaLcl1U
h9B9mwf/ZF6F+Eu87eb/iJexuzXFuMw1OHmqcA0Kz42wBRqDHtyM48dA2NbwRf2g
HIR5qa+JhSdULEAm8x73YjqENHPF4c6HcebJ3v64OAVcPwKIh+01InrFhRiiswdB
uY5FQNLw7vYXBBoqt+cEi0+AQS7nrWKjV0o7LKoHpECeCAFeZ7Hw5r3VNYn4iJYq
T8IMlrnBBrN6wR/aCu/PCwNILOQV9FgVOEeiLNDqfUOCngf41xBd3k89B0qgIjY/
mRcHLspG1164lo3i9g5nhwrfA3z8Rc7qwplo5AMPxf9JFmHu/26rYiKO9P/47frx
l9Zw2ZgKH8Dh308THwmRCfVvI+ZSWA==
=D1On
-----END PGP SIGNATURE-----

--8sgAUUax1IxvX064--
