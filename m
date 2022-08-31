Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B115A8985
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 01:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiHaXgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 19:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiHaXgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 19:36:11 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F6D726B8;
        Wed, 31 Aug 2022 16:36:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MJ0t92XLlz4x3w;
        Thu,  1 Sep 2022 09:36:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661988962;
        bh=RwfUxncKI+ag97u3lnmWaK0ZLg+CxSymvIHoZoPpZSQ=;
        h=Date:From:To:Cc:Subject:From;
        b=MCiMezri1a/XlP3JwvGREwGsnPitXKpeGKdRGDIn/Oi8MepuAV4SekqA8EilZnSoZ
         SuxySHJseBP+uDSViPiibnvpS5CJosssEAgFPsa7fCMHVOCN95Ky9I0wT2cwLoU/to
         Xbojk5MqF1Y8373Ol/X1mMHvItcTpGnLYauPrG/htpEe4hhSfQm6EAod4rojL/IkmM
         KbMXnlr4yHQXXM5kEwBkft1or/ZhkFUkiqBBrNcHIslikKrHjBjWQlRCw+/DYL5Ioy
         l5NxW5u8Sv9GLXRnvKdDuntzsKmZ7FGFALoecxyx9lj1SJnrsUcrlbnc9ZooJHvLVh
         VtTUx/nM1wurA==
Date:   Thu, 1 Sep 2022 09:35:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Jing Cai <jing.cai@mediatek.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the bluetooth tree
Message-ID: <20220901093559.5d4029fa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W636jSwfEalM++DiFhafhEj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W636jSwfEalM++DiFhafhEj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  177978b29426 ("Bluetooth: btusb: mediatek: fix WMT failure during runtime=
 suspend")

Fixes tag

  Fixes: a1c49c434e15 ("Bluetooth: btusb: Add protocol support for MediaTek

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line (or truncate them).

--=20
Cheers,
Stephen Rothwell

--Sig_/W636jSwfEalM++DiFhafhEj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMP8GAACgkQAVBC80lX
0GzfvQgAn+fX7/9xAujWPAn769WbDX6DVvw/8/wDc4cZiD19OjujP+VYJZEL4+3P
buNl9Rk7r7dYvpLlY061RehnQpmm9LyhMepogSMj8cZMfq0TkGRXQM7rONSOkCCK
lU5iugaE/DpkwnFWLKEYEdcZlKmJYO69l97jI0TRX1icV8FuynxCaozsa51TvwhS
1FkmWMLDnYSMxo7sUsgDscaVrA2sfwpXag3QoMmX1pIlGlPg3zTDDfet6Zx7cceZ
8SJBWJbR1w036oH2h+JDAEMZuwrR1wbWn4imMxtgkixGpvaAvLIhBtHXyxyhI0An
3iRJrUO0tokwq7JxGM0dF60iaGQSxg==
=b2rO
-----END PGP SIGNATURE-----

--Sig_/W636jSwfEalM++DiFhafhEj--
