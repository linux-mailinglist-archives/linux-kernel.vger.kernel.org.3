Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1308857CDEA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiGUOmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiGUOmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:42:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D7886C08
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:42:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DEAA6200E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FACC3411E;
        Thu, 21 Jul 2022 14:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658414538;
        bh=PpnwXm3ZuUhE0qo+2U0StDRkyurCa/SzJ43F3CrCXTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uYg/9KRGJmSMJp1EMQ7FStO2WEfFJB2wq95YO8tG89hXZL2xaf6ey8FrWtv75v7l+
         HtfwaTukDYR/OBSHs8qcEhey5USVBSXAGYlnvGnCEmmX14xOeDI4qoDpkOCG24UnV+
         BYrRCB1bcroMGro3QhzItHjvJrilIfXFZKd7a66K1y73XTIsGcysAxQPz61ayA5zQc
         1e86NyzPQakngQXdDtMQ8BlqlRAlljLoO4So1ZYb2cj4L1oWfXMGAYPaKc4ZTjuYeh
         XlMv7qYh2E2npXXAkoHH0BCOPBC7ApPojl7s0WCLqVUadXoO/g3ZMXE6UBV1x89ulh
         qQnrp3w5tb4HQ==
Date:   Thu, 21 Jul 2022 15:42:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        alsa-devel@alsa-project.org, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] ASoC: Intel: avs: Mark avs_path_module_type_create() as
 noinline
Message-ID: <YtllwRY6F93uYRxz@sirena.org.uk>
References: <20220720185228.3182663-1-nathan@kernel.org>
 <c00a8b5e-6def-971a-d4f2-cd65c95fe430@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ajHU/ff5Es7EyDXb"
Content-Disposition: inline
In-Reply-To: <c00a8b5e-6def-971a-d4f2-cd65c95fe430@linux.intel.com>
X-Cookie: Exercise caution in your daily affairs.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ajHU/ff5Es7EyDXb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2022 at 02:25:20PM +0200, Amadeusz S=C5=82awi=C5=84ski wrot=
e:
> On 7/20/2022 8:52 PM, Nathan Chancellor wrote:

> > This warning is also visible with allmodconfig on other architectures.

> My first question would be what clang does differently in this configurat=
ion
> (ARM) than in all other configurations (x86, etc.) and gcc.

See above from Nathan's commit message...

--ajHU/ff5Es7EyDXb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLZZcAACgkQJNaLcl1U
h9BaqwgAhNdNCBam0uI5GOf9ZPo7T8imcXF+ulBeP3Q0Ve0ZcM5jJKpWyJY/xuKk
vKGrKJxJu9IU9AXKBppPBM1SxYIBPUCjoLBkrUYKXQyKglTbcx3Oy+lmmwxaLBoo
jpGuetXcc1czReyBzu8ySfmKkMx9S2z3O8kn8vRJ4jfF4taSE0j6gPJjMTGDdjJq
weZB3dDZGNEtWT687UK+NcY2HaMDEi/ULMN8p/Z/ZuDPlPhHUotyKBl71GMCuCD+
Fgquc2rxOUl51tNMTK9h0J3u4CtDsbi/5eC0qHdkebRdwmOhIJssiUiu2b+IEU69
Rz17RBTZkaL+qs5JW1SFAPJ57tJO2Q==
=xgGL
-----END PGP SIGNATURE-----

--ajHU/ff5Es7EyDXb--
