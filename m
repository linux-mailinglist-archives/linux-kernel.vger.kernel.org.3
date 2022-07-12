Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209AB571BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiGLOCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiGLOC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:02:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE3C2631
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:02:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED67C616CF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 14:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29559C341C8;
        Tue, 12 Jul 2022 14:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657634547;
        bh=+zN1GNGCIL6+YVEG7IbxuOhZlEY06u/BIUm+9zyo8wI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a6BSQCwxx8ttq402GPYNi4QvOmYUM+e67eYC0xleIyy6mb0YpM3YZL3DUlSS9VVzN
         ggmi9qUpPLVy90FlUcBacN7u+Rg35MhmNgoKegrQkpPym8aQJq1LHUzhqNn18e+SGL
         n4mbTvpctfRbzJbqcpYH9/6hq1WL2Ahw+L0llxNRrwc3WXBkiYkxAUHZ+vbeTTWKp6
         99e8F1NpeXe65A8XT9Lzmv2a6ttfMz6vhdkyRHqqN7SDXjikl+UDqnRecik67fLHta
         h6HHglostPy8fy863cHS9y/sE9KUW5q/Wcy/aEcM+ZbDajXo+kIRprvr4Xr/0DBsG2
         rp7HxCGIeZGiw==
Date:   Tue, 12 Jul 2022 15:02:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?iso-8859-1?Q?P=E9ter?= Ujfalusi 
        <peter.ujfalusi@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        amadeuszx.slawinski@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 1/2] lib/string_helpers: Introduce strsplit_u32()
Message-ID: <Ys1+7P5zN4irxKW3@sirena.org.uk>
References: <CAHp75VckU2ZraLJ-frjWXjUu9pFW+-XmWgTbYqUXOUNAD-1HGA@mail.gmail.com>
 <6c8e4104-2239-a188-649d-585f059cabdd@intel.com>
 <YsgjdKEtE7pMDTnZ@smile.fi.intel.com>
 <a73b3ec0-5abb-ddfd-414b-b9807f05413e@linux.intel.com>
 <CAHp75Vd4D0KF7ik+aMOwv-+bofWja_tDe4YUmihQBF+RiHZTmA@mail.gmail.com>
 <e2fe6351-f9ee-48eb-ad7f-280249f7f3f7@intel.com>
 <CAHp75VfvN-iJTpgg6JeKhOqJLhtYSieo7d7SOCBoUu-81FtSqg@mail.gmail.com>
 <c19ed4a6-6a96-b4a4-0f5a-7ca1dba925d1@intel.com>
 <YsnoH64cKCT7gndw@smile.fi.intel.com>
 <2c6a4a61-e6c8-0487-8d29-dc3fbb90bbe2@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VOtkm5XuX2adiHc/"
Content-Disposition: inline
In-Reply-To: <2c6a4a61-e6c8-0487-8d29-dc3fbb90bbe2@intel.com>
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


--VOtkm5XuX2adiHc/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 12, 2022 at 03:51:04PM +0200, Cezary Rojewski wrote:

> Please correct me if I'm wrong, but there is no guarantee that int is always
> 32bits long. What is guaranteed though, is that int holds at least -/+
> 32,767. Also, values larger than INT_MAX are allowed in the IPC payload.

Right, int is just the natural size for an integer on the platform.

--VOtkm5XuX2adiHc/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLNfuwACgkQJNaLcl1U
h9C/QQf9FtMNLt7fY7kTHfnJjxoc2xRbWmtmteMI/X1xnpa0sAS30hZrAP5o49ri
tl19bcPCbpY15Ih/BJlE7TOW358K5CxVlICUZdZ088SVbKN+tTAig9DVnCk4cjoI
53fscUp8y/saZ3R0HnDZY+KQhoh9j60bMWs3ff3ciAHx6HXVOdJ6qgKbWgsnxo5A
viX6XmKmA0tPnn69FBCHz7ooJE9R8I+Wh1oWjL02rJMrWwARzqpyt8yubvHL1tSo
4EU+DCDtCYimR9nzs1/m4jdK3J2T7FpX2NQgO1NNDmRbcAqkiu4Gd0Ek+ydaIcym
uIOTy5RjhQb41oJUTlQvfqfdQ0tsMA==
=JOe6
-----END PGP SIGNATURE-----

--VOtkm5XuX2adiHc/--
