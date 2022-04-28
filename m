Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA5E512857
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 02:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239523AbiD1BAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 21:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiD1BA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 21:00:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB32BE24;
        Wed, 27 Apr 2022 17:57:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kpcdx0Rq4z4xNl;
        Thu, 28 Apr 2022 10:57:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651107429;
        bh=h1sc59XXiSl9IaxPxElLuz/1EWNyid/i7vBF8OUL+zY=;
        h=Date:From:To:Cc:Subject:From;
        b=SXzBp2PhKHWbj6watTLPmcs8Ho+AuAqFReEfkoCxv5e5AIRaCNV8Oh39//E4znmQ0
         0tvXJNSDhEcm5qi4jsDd/GLSkvPZiRJS0fZfcWOxjXewpOa0SvBu4yVeIRjIMVdChv
         4sA2RoZ8J8wvbaLO+YA4CetTa56au0xil0Bp/Z6Q0DzchahKd4nsXp3checGJMSBUf
         4nQeJ3fNFSjh29LnZ6c3BOmIsSdiAtBxEusixM1Sz674Rth7yS1bFEjALVMdOolP9h
         d4+2cB8kht7BrkKnZuYFX5f0fLg8ALH+gZ68pdtzCkn/3F7oQuqlHl6eU/1tswBrN9
         Virc3FlkKngCw==
Date:   Thu, 28 Apr 2022 10:57:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the sound-asoc tree
Message-ID: <20220428105708.57aeda36@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hAGpX+9pEMV8SsrI9q7p4ai";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hAGpX+9pEMV8SsrI9q7p4ai
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  9ce170dc9c08 ("ASoC: SOF: mediatek: Fix allyesconfig build error")

Fixes tag

  Fixes: 570c14dc92d5 ("ASoC: SOF: mediatek: Add mt8186 sof fw loader and

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.  Also, please keep
all the commit message tags together at the end of the commit message.

This whole commit message was badly word wrapped :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/hAGpX+9pEMV8SsrI9q7p4ai
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJp5mQACgkQAVBC80lX
0GxMHggAkXSOhYvZQn+mu0fPpcqpekX2MqgHvBt29Dn19Oa6MQerDamFwfV4mmNi
ausYXpi0/4zQdHfmA2ND+spUr8C1sTUZmD3Bbk1jjUxWVzggvbJkvp9Tx6pUtNBR
3THjyISvfDBlKlaRUGtspyOYCGi4uzQbdDZW/8n/e/iFpbka49AXozhQ9LDjFqCe
Q5dJttLeYhOKMB+keC9BxDOe/uFNkli0k7bMwGf8p1fW9XKcqqeqekIyiEA8Exx5
0PZt3K9C+QLJ+hh4Kw8tocYHoRiwsWgOFax7yQYsWaXahFhN5QqjYXcm3Ke6p5p1
M2ZnNYllLZ7hk95tQWO0tVo54d7ckw==
=NHLg
-----END PGP SIGNATURE-----

--Sig_/hAGpX+9pEMV8SsrI9q7p4ai--
