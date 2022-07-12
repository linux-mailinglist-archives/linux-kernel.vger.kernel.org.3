Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25E8571B64
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbiGLNe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiGLNew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:34:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F528B6548;
        Tue, 12 Jul 2022 06:34:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30225B818CF;
        Tue, 12 Jul 2022 13:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B09DC3411C;
        Tue, 12 Jul 2022 13:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657632888;
        bh=TzSrHp9qbWk1PEN/Ge7xLC+/VqfKPUI5qGy6UMlXEVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h9CcWF5uxJP3KiWUPaf4dhtFm2R7qzTJIV6Ml1eVK6BV90ztxrTzwJDDLKqGmL32r
         Wnk9ehRZzC+8Hs+9sqP/hTbdGbczNhSWz0ACmoSuNZKLK7lRxJNSDf/fTW1GLYv2+V
         o7kcNk6GWxva/MKEHzfhfAUguBMVJa0X42KqR5e5LbKsXt29VJXYp/VfiLCR5odTqe
         PfMU0OxEviY5b5kbiN5I/X3Twubzq51Jel+6rmdjahkEMqxJY8fyKbk6EwwRYXWfBz
         +ne+/DlBvbIgZqG06lrenhrDlpy4uCxdMxS1q/PvyACG03jCKxv0ZSDVm4tGxgtH/9
         qFI/VP+wBKZqw==
Date:   Tue, 12 Jul 2022 14:34:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk, ardb@kernel.org,
        will@kernel.org, mark.rutland@arm.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, arnd@arndb.de, linus.walleij@linaro.org,
        rostedt@goodmis.org, nick.hawkins@hpe.com, john@phrozen.org,
        mhiramat@kernel.org, ast@kernel.org, linyujun809@huawei.com,
        ndesaulniers@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/5] ARM: stacktrace: Make stack walk callback consistent
 with generic code
Message-ID: <Ys14cMm0n6EqS/cQ@sirena.org.uk>
References: <20220712021527.109921-1-lihuafei1@huawei.com>
 <20220712021527.109921-5-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wJNTOJ4UzKV4TahT"
Content-Disposition: inline
In-Reply-To: <20220712021527.109921-5-lihuafei1@huawei.com>
X-Cookie: I like your SNOOPY POSTER!!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wJNTOJ4UzKV4TahT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 12, 2022 at 10:15:26AM +0800, Li Huafei wrote:

> In order to use generic arch_stack_walk() code, make stack walk callback
> consistent with it.

It might be useful to say what the changes are here, if nothing else
that makes it easier to review and confirm that the changes are doing
what you intend them to.  See my conversion for arm64 for an example.
The actual changes here seem OK though

Reviewed-by: Mark Brown <broonie@kernel.org>

--wJNTOJ4UzKV4TahT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLNeHAACgkQJNaLcl1U
h9CN+Af/dZr0LAvp9hTnwJeNYmr/aG/PNwbUty4XnpklzdDW+VL06Jr1GLl8G7l5
tZ1G3me8EcBHDe25iRucUYOcOEgoXaLl/lRYvCj81jFDNlHwHExWMCvVYtk/ujVP
+QJs3lhgZKbpIi8Q7YZC2FOPnNFZpy7gzIXFR7ut4wb3hZA2ILULMrp1ydUaHyfd
RgZ5EEgs8blIFeKFQh7XTYfPaNBi0SKjdkvxe2xUPKE0Z4wm5Cb3+VyHvQqeVUYo
rY503r6I1IA9tc0p6w4mImr3tzB0mLTAoc/Enp6RkUy9ZqvC02af+VMFowAhUoHW
e6JFVBF8TSBy6ktGerF0GB4lcjQvyA==
=6EAy
-----END PGP SIGNATURE-----

--wJNTOJ4UzKV4TahT--
