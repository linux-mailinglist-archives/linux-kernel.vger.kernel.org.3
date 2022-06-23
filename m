Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA76A558BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 01:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiFWXh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 19:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFWXh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 19:37:58 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2719863AE;
        Thu, 23 Jun 2022 16:37:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LTcB55D9yz4xD9;
        Fri, 24 Jun 2022 09:37:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656027470;
        bh=RS69F3QlsP4s5ghEtVy1HW3hfFfy/kBFDBwZxwfWOww=;
        h=Date:From:To:Cc:Subject:From;
        b=ul4eeiqhT8aH+KxVhe72o8008UNYDOCXBpyvHyf1avXmtkMpqHsfyp4wKJGrxaCdh
         dQ9xBpk22UoEuiEGLxui5LfzusFORKy8v6cO2typ8Y8UqN4v+rcjWL+aYoZTvFI0Ql
         zUsQm2GrzBnNlpQ4UP/2L+lmBeBAcxGxC8r97vbuCc8ibFYlFRO/VD59UGn8rw91lD
         +jyo6DNlFWw6zKA+up9QjUPKE21nO80gu1adJSr45f68//ZncSbAqFFkfZDLfPVrF6
         QLSXbQCTdrNHh5weeBf5+ttlNXOvoCSHiy4T/MrFLYpbByHDqDcN0Enbr0QYLY84zV
         S0B+uRlbNs0CQ==
Date:   Fri, 24 Jun 2022 09:37:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the gfs2 tree
Message-ID: <20220624093748.6b58818b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mkFceP/LHWEWvPp8pDiYt1O";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mkFceP/LHWEWvPp8pDiYt1O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  f5370b4a014e ("gfs2: Fix spelling error in comment")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/mkFceP/LHWEWvPp8pDiYt1O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK0+UwACgkQAVBC80lX
0Gx7FAgAopOsDvOZJIJb6QQm/WyVA9Vazuu1Pxn5dn1WtRuIiXMtBAqHNKml+B7S
qjyZ/FMv6OuWAkTejJjxNTYbPE36R3wQKp4Eu1xBGqs21aLxcc6YaUuUqPsR+Egk
XqV3xmta593dVbyZHjHCc4AXUpxRDVkbM3rgSJL0uHUehRm3HJ5OHrmdip47D8Br
qOYH8ZvHMQ9dIS36DiPYsB8LTOTjc154W/KUVESy6oUfwJf8DOep5xoG/PY8rwdL
rTCA5z0J7yHkRBNXPsJR96Qa8ydasOiy38b+yfFKm8y09ZGgQSjON/Aq8KYHuWdt
dLcjPPI3FvkdaxhC61gUT6otWGIroA==
=8p2O
-----END PGP SIGNATURE-----

--Sig_/mkFceP/LHWEWvPp8pDiYt1O--
