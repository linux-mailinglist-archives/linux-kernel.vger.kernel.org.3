Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A1C4D235D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350381AbiCHVdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiCHVdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:33:19 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BED51E6E;
        Tue,  8 Mar 2022 13:32:22 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KCpSh6fx0z4xvN;
        Wed,  9 Mar 2022 08:32:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646775141;
        bh=L/+rhb3RWjpjkabvH3qgyz3UCnZ5urb85xrQUdEpUW4=;
        h=Date:From:To:Cc:Subject:From;
        b=ulDWvwcHiiKREJ5JJIaCfP4SIg4Ju1FhoZ3jF/3nsZqG6xNlJADzcQDuYmt8WyiyT
         NnlZC11d2IQyToAyv3ya8z98r7fQvMlKGZoGHzlzyPf6zY17iPLoBi2yXGL5m+h+93
         it0+9xNRBfG03T+u0SFwEO1JaSoSQfnR7/FwSfLYKIQFRfRvF0iIsOBAy9XfBtz9lj
         P5fXWXGsWLrQajepAUtSb86ms8JJXUEmIkFJl7dhyGo4e/VDNXWeVtWw2y+06n5g0q
         AicCZ7NGUAUMCnDsiKzGtW7j0dS5w6sPK/pV6EVsXUXsyTRbKPioNLw53+It8df319
         AXX/2HR+57QvQ==
Date:   Wed, 9 Mar 2022 08:32:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        =?UTF-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the sound-asoc tree
Message-ID: <20220309083220.7cf57122@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qzMRJurkcw755A0Oi1WrU+x";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qzMRJurkcw755A0Oi1WrU+x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  fb763299bd8e ("ASoC: SOF: topology: remove redundant code")

Fixes tag

  Fixes: bdf4ad3fd01f ('ASoC: SOF: Intel: hda: assign link DMA channel at

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.  Also, please keep
the commit message tags all together at the end of the commit message.

--=20
Cheers,
Stephen Rothwell

--Sig_/qzMRJurkcw755A0Oi1WrU+x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIny2QACgkQAVBC80lX
0GyJdgf+LGDxpyKC6Ap/Xz1oFCohJ4J2keYsWHgfychzdi/wPkuth+qvKUBRzd8K
tmt2WqAYGxPqJ5JVSApLRYgo8r+vamwaBeAEiQT0CIA86HoEZCjXP6PbjfeThEAs
BxrLLrxn+R7PbqakNBcuESOKN0Yn4o6Vnw5UzD/IqdtaBVhBuPkCEYH+F1Oe6HGB
jQfMeijuRYs9X3E1DtGQNMIRRve7+tCElAYXGnapeXti9IhxvUL6dVYp/gvpBvPo
owhGWFiw+WYa4iquE3NLfcZaw2K+up4d9MkAhVUfMkknxRP6J8Ksc1VMy8+DiqLi
d0ZXbYJH86aEkMdyUgKmZZOvuFMNjg==
=Fm4N
-----END PGP SIGNATURE-----

--Sig_/qzMRJurkcw755A0Oi1WrU+x--
