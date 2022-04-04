Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B974F2036
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240572AbiDDXXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiDDXXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:23:34 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F97DFF5;
        Mon,  4 Apr 2022 16:21:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KXRcD4Stzz4xLV;
        Tue,  5 Apr 2022 09:21:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649114492;
        bh=MY427EV4TykIb97qggYDrKCBVLfkh+9Z8g8F7Adt0rE=;
        h=Date:From:To:Cc:Subject:From;
        b=EREP2yaCjchbRSNh/F4XwBx97BkzxeBrJZxvpHtfo8QNr3wCkY0mhn5saeQChOX+5
         ocFWVNmS0aLOPTdPy2p7d/DtiXlmfhZdkOAPCPbRPokpXqO4NzPMbWIJvtnAjUiacG
         NG+EUmZmXaQDA9aqVodxoroiV0sGFXotK8bk1h2kLUJQT13FQMAiQYmDko752Ia0M7
         BHvKxulPicj/4tfnM+bufdZYAFXfjC3vam2rpguAFlUi1W785IKUsoP3/3sDSRkYyb
         89e1UooN13vxIOZ3pjlKgzhkiDgModtcwXlCWCu9fJy80B7Xy/hVCMGzx2ppY2CwW/
         9oiyAJLHcwnEg==
Date:   Tue, 5 Apr 2022 09:21:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the asm-generic tree with the
 samsung-krzk-fixes tree
Message-ID: <20220405092131.03382f2a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Al0AjQUwqWxIhq9_Pn4G1HH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Al0AjQUwqWxIhq9_Pn4G1HH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the asm-generic tree got a conflict in:

  Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.ya=
ml

between commit:

  8a1e6bb3f78f ("dt-bindings: update Krzysztof Kozlowski's email")

from the samsung-krzk-fixes tree and commit:

  1c4b5ecb7ea1 ("remove the h8300 architecture")

from the asm-generic tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Al0AjQUwqWxIhq9_Pn4G1HH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJLfXsACgkQAVBC80lX
0GyUiQgAi1coCI7JhU0DcA5jy/AG5E1wGJrdBa0t6v4sYuRGQcxvfdf2remO0tlN
zZNjw4mBrzY8fKeaD1YuAnGd4+zBgUS4rXvpS5DTryO/WxQmqGkO7D6yt0ckwgBW
xUXk//PNwAHLYutmkzlef+8Q2PCZ9cx6+sHMZTfaMWq7Ikb2r5kZDHAASKu53+lp
3AAfBBNs7tTU2foR9um3IBfPTeqkTXPuiCFPKdhclhtdhEIMauXUoqwyuoR2otqW
mtALhRZyTUJIQxwswafaj8w61sbpczaQhRYlFOaEXTUruLiemo2c9h6p4Xqatu7e
VtLpLygug+pmsN22539fx/36XJ3i6w==
=R4Lv
-----END PGP SIGNATURE-----

--Sig_/Al0AjQUwqWxIhq9_Pn4G1HH--
