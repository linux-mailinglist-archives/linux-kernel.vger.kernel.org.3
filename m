Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCCF596DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbiHQLk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239164AbiHQLkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:40:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3451983BE6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:40:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17D35614CD
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 11:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0B1C433D6;
        Wed, 17 Aug 2022 11:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660736406;
        bh=tAxziLgNC85rss5KjanACgubW2VS9uSuhJ+/ML74THM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T3/KpFtv7iQZzL5njKxRzaLCeNS0h0F8QbbeFHdB76IWFap4SuB6RJ6+95NgoGCtT
         nWzhlj/TKBLcLHowUnIGscBFxs4B2DelluDdqjOpdqkAWDiVEVlqLCoyRz2HTgiqTA
         NSo0RJMVk37dyrAr/SQcxfq6O9BmhbUVB+DRG1ToQMgd1SEZfckt+4xZuUAn2drCD/
         sHf0rYN/Z+d40QQe5Gx3H1cUQNEcEy4LiQeeT2nC+PLq6tX5IMNzAQB5LPJMvwtLl1
         SRhExETaUY9G2LH0oZ4LICLBXIM85XESWzCO4EUneFt6Wmt7Ja1iMPN+JqoBV4Mstj
         BcT3VpSuWJYgA==
Date:   Wed, 17 Aug 2022 12:40:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Liao, Bard" <bard.liao@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/4] ASoC/soundwire: log actual PING status on resume
 issues
Message-ID: <YvzTkQ7fkQlecTVe@sirena.org.uk>
References: <20220714011043.46059-1-yung-chuan.liao@linux.intel.com>
 <YtTzZ4iA0xt68euH@matsya>
 <DM6PR11MB40745C1283CFCC3F5D41FAC9FF6A9@DM6PR11MB4074.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q+ljVR5GQz+Wtprg"
Content-Disposition: inline
In-Reply-To: <DM6PR11MB40745C1283CFCC3F5D41FAC9FF6A9@DM6PR11MB4074.namprd11.prod.outlook.com>
X-Cookie: Use extra care when cleaning on stairs.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q+ljVR5GQz+Wtprg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 17, 2022 at 06:48:56AM +0000, Liao, Bard wrote:

> > > This series just adds a basic read directly from the PING frames to help
> > > confirm if yes/no the device regain sync.

> > > The change is mainly on soundwire. @Mark, Could you ack the ASoC patch
> > > if it looks good to you?

> > The series lgtm, feel free to merge thru ASoC tree with:

> > Acked-By: Vinod Koul <vkoul@kernel.org>

> Both of you are acked.
> Can this series be merged now?

I guess I'll apply it - given that it's mainly a Soundwire change I
would have expected it to go via Soundwire as you'd suggested.

--q+ljVR5GQz+Wtprg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL805AACgkQJNaLcl1U
h9AiSgf/XBVdYlzcxr231NjGvtIDApKXvygvvaqq/W1JkjymmWieaaDh7HP26Iy/
BZLvAxyC7e7zRVScXKeAtyghwzMeqKIFUH1hVazY4hKPUoiD8wD2QKstxnmpiicU
m0b5McQwRGvqmk2dmK9XPlCr9j9zERI4wsepRY2z6YrfFOfPbz6z+84aMVN5/j/p
fs9XVcafVEo9v6lbp2t7y138TFjPL2Wkh3ODPHRKFRupT5ZBAF0R25gePvwD8g9/
RVmFWTwyUgyoiuDuXAmcJkonHVaaewyBx4GEE5lSIFP+W0YbtLkgxme02gaGgMve
hNY1iDBUTORh9H92CGKFNKMGZny4iQ==
=GC7F
-----END PGP SIGNATURE-----

--q+ljVR5GQz+Wtprg--
