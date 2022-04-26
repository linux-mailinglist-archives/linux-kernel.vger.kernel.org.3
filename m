Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1579450FBBC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349459AbiDZLNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349440AbiDZLNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:13:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041F2443F3;
        Tue, 26 Apr 2022 04:10:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC271617D8;
        Tue, 26 Apr 2022 11:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D6DC385A0;
        Tue, 26 Apr 2022 11:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650971408;
        bh=5EReWZ/S2vsSFANL3cQAeE/lPZvpLXKMlPmcAr0JfD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W/CUQl7TEVoz6fkk9iPNkCygfiVYSkElsrlK7WckrVdIG0IRj5r6th+ZW4g5nxSJD
         1v0M6tRL1mEsBLPKYY7KUc17lCUVDanDQN1fDTf9N6//NZaFFu+J/wYaG+0a3k0FTD
         dJ0D/t7IsC/EMCQtFt4D1bZXPwLJD2Ss+sBmGwNcK5PDQttza6VHn3WeEgqwaM47X3
         wqAg/EqMfBvl64fmIrEXAx4rqNzxF6jYDKUgxUXaVJngNoMjXEEwat6oa3qxv/MjJh
         1StQzVQEFRCWMGhVvS90XMd6I5WF0wROaLoDwzqQiVWMOfL/scWpAcOq9z5k3iOkK/
         CzMAES9B0wekA==
Date:   Tue, 26 Apr 2022 12:10:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <YmfTC4krVp35kg1j@sirena.org.uk>
References: <20220426183044.4f72059b@canb.auug.org.au>
 <263f190b-b618-4f88-2965-551af939652a@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6WdDUAwIbxc9kkC0"
Content-Disposition: inline
In-Reply-To: <263f190b-b618-4f88-2965-551af939652a@linux.intel.com>
X-Cookie: I'm a Lisp variable -- bind me!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6WdDUAwIbxc9kkC0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 26, 2022 at 11:00:59AM +0200, Amadeusz S=C5=82awi=C5=84ski wrot=
e:

> On the other hand I guess we can just leave X86 with COMPILE_TEST and move
> ACPI to depends on, without COMPILE_TEST.

> Mark, what do you think?

The above seems sensible.

--6WdDUAwIbxc9kkC0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJn0woACgkQJNaLcl1U
h9BGmAf/cLnJF7x4V3W8tuIeyhKEGiLvEmUFUdOYlnDiYlt2CrKmC3gMS+1tcXJE
xDecU84Udvzo70fEQIGCuywCWVUKTzz2BfZ9ptpgme7gJuz/yiUXijKmqmcOZ49U
NnzPsjUThncc4sE6GS0AKyjmOINUIU1L/c3cqz1Y0N0uY/081cOReFlpDsZcBvwg
VuUqDQv8/J4Q5eyMGFVMmIA5vqqh1DWbdZAqQUc4FRCY3UqJTkHT+W05RsSqLmAq
BTMMdpV+A7vlOhyvuoMGfWzvltidSLsawlRIrdl2UJBMPczXfBi5Tpwu1QoRkIJB
8I9dTx6DmfDJ4Vc6arwW+qaY6Kx7Xg==
=irm5
-----END PGP SIGNATURE-----

--6WdDUAwIbxc9kkC0--
