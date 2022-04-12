Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218934FCC93
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241104AbiDLCom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbiDLCok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:44:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01696405;
        Mon, 11 Apr 2022 19:42:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kcqkh2W4Xz4xL3;
        Tue, 12 Apr 2022 12:42:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649731341;
        bh=wujwRAot37JL55MqU+GtyATZfJeL2yNw42zsycqJ4n0=;
        h=Date:From:To:Cc:Subject:From;
        b=cr5zEH04ZKqQORY0HXV8RNUSFgk/z8rTTHfXxmIpQheASB/rsTAiYrrb5DLwIu+IK
         awuQCazO/CyqNeaiyZuciAQzgp7vg9pip4spL61TVD6f/bFVF/axL9hRxfzeMSMeZ2
         44UsNGxGwm8/JGfYhzci1pozZb4hE5u1W/XuWK+B5Mw5GsYpFX9TQBQ7UXxIFeX+8/
         m2dBSigy2JIyQyi+EnkQNyxjhavHWcaT1jcPaclHx3b0XmqXUVipy4PMJSQMsL0HSg
         i2Kwbl1Wjf1QPORBBxyzpezOhJDDzUNO5MJ2rJw51UtL/iGlVyhcQj/iK1R8ueIJw/
         ztK/Tm1dAxJ9A==
Date:   Tue, 12 Apr 2022 12:42:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>
Subject: linux-next: manual merge of the dmaengine tree with the
 dmaengine-fixes tree
Message-ID: <20220412124219.3738092c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+L_ahD.uv0hKb8zaYfb/47Q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+L_ahD.uv0hKb8zaYfb/47Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the dmaengine tree got a conflict in:

  drivers/dma/mediatek/mtk-hsdma.c

between commit:

  5cfde5b82f05 ("dmaengine: mediatek: mtk-hsdma: Use platform_get_irq() to =
get the interrupt")

from the dmaengine-fixes tree and commit:

  bb40bb695ec8 ("dmaengine: mediatek: mtk-hsdma: Use platform_get_irq() to =
get the interrupt")

from the dmaengine tree.

I fixed it up (I arbitrarily used the former) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/+L_ahD.uv0hKb8zaYfb/47Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJU5wsACgkQAVBC80lX
0GyOBwf/Y4EtwwwUQSxKpHDu1iDabPAT00CPndUhMwf5YCXUR++so8RHYW7EzUc+
uqQuAg9tByMQgr0hD1v0gHdzFoMUoPLils6C5iptUeJczBWTd+Lj/I8misoGEezE
xJtHX3DAWvWp0mBf+Mgv4J5PPZQArx0xV6I0pUl6Tl+2WYll5eUypnxRKkU62LM8
ooMBJ5WpuMNIIIPJIVqNbYxcM8D7QAymhPT7o00EOB8hQlCYBxwS3uIpV6H7zDo4
/MmquDkByGRlHPZjVaVue7pkyeW/Qtv73Rg2beHSAsg31NRh2UJgMKK/fUqXNtcf
9fOz6rB0P5/17ETGwM7lgz2K0CAjVA==
=78uY
-----END PGP SIGNATURE-----

--Sig_/+L_ahD.uv0hKb8zaYfb/47Q--
