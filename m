Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61C35B09C8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiIGQL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiIGQL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:11:26 -0400
X-Greylist: delayed 423 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Sep 2022 09:11:19 PDT
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5075297EE6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1662566652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3JUE/u+/NFoKe+rWGkw6FQVPxkLTxldan5TWSkol0cE=;
        b=JWfIYjXP1Q8G9pb6dHdpQoVrdLS/7p7hxxq6Z5j3g5pQ8Wfs3mj9aK0l9UZAgtGY8q8NwP
        z5PcKl0+MYb+7ciTb25bGfm1oTcE6PnCla+d1F+K94qsiyu2nVVlEkkBbhC6agqN/XyOTp
        Jjgw5csVFEE0i72l4e5v229LkuCrf3E=
From:   Sven Eckelmann <sven@narfation.org>
To:     mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
        Shigeru Yoshida <syoshida@redhat.com>
Cc:     b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
        syoshida@redhat.com
Subject: Re: [PATCH] batman-adv: Fix hang up with small MTU hard-interface
Date:   Wed, 07 Sep 2022 18:04:09 +0200
Message-ID: <42632958.r4OcKK3suL@ripper>
In-Reply-To: <20220908.010037.1643964170435041362.syoshida@redhat.com>
References: <20220820032516.200446-1-syoshida@redhat.com> <20220908.010037.1643964170435041362.syoshida@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4058084.qTfXEPDQMy"; micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4058084.qTfXEPDQMy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, Shigeru Yoshida <syoshida@redhat.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, syoshida@redhat.com
Subject: Re: [PATCH] batman-adv: Fix hang up with small MTU hard-interface
Date: Wed, 07 Sep 2022 18:04:09 +0200
Message-ID: <42632958.r4OcKK3suL@ripper>
In-Reply-To: <20220908.010037.1643964170435041362.syoshida@redhat.com>
References: <20220820032516.200446-1-syoshida@redhat.com> <20220908.010037.1643964170435041362.syoshida@redhat.com>

On Wednesday, 7 September 2022 18:00:37 CEST Shigeru Yoshida wrote:
> ping?

This was applied a while ago:

https://git.open-mesh.org/linux-merge.git/commit/b1cb8a71f1eaec4eb77051590f7f561f25b15e32

Kind regards,
	Sven
--nextPart4058084.qTfXEPDQMy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmMYwPoACgkQXYcKB8Em
e0YkpxAAw93Jox1VjVWR13czWE4LUUU1/oWpo4lAGC+flzdJonm189/6WIvdk2GG
82iew4c2O+5+utYT+V/HzEG/ztw7VQxDIJTEtGSPkWpr2IU+tSOHeVoVyDysBazl
vp8djDOoCBk7IvIOHeEsAT5aMtIrctgzQYwHXDqSo7zKhNJLtZ4+lbgdRxcY4qpQ
H9Rbbm74MjUJggYN2NnCp37+y6rLnJ1E1a+LUPVnk30+4aSNUMztoZ6+tDOypT7F
voYRW9foZHeRz0wLCxbEMJK00QysMVJdufJBQapbkypJ++1eyu7mvPPzbIOan9ij
ednS7VoYvJZ/da95Rkkr+4q2JF1navvhBpcdy3pKN6XvGpz1Igwe6+v/jeiLHmG3
7MU53TBNMhYIW3dK/w+bvUcEDawjQrmGdLwIxPQPkaPFbP5sBtn+lKgBC98/GpuH
NMP+yHc86gCb9KV1EC4BL9AOzwvYrtyh2auADpfz8+OQAsuZ25S6XjP0EwM5Vv1H
+jo09KwxD1HlLTJZNxrUPjyHz3zIB1t7LUlyRuTNpK9mznsg3rCic0RkBruE4sHb
g6yGIv15WoyfyOF+8vK/nngRT15C06WYZmqIlaJjK1kB9v2JjrTf4c7PTdwmQIXn
UcxMG+EAXVXvkXCNf8kPNTGp/+3ys8yejuN0SoT/Y/eDb0a071w=
=o9GE
-----END PGP SIGNATURE-----

--nextPart4058084.qTfXEPDQMy--



