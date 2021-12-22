Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611CE47D19B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244827AbhLVMZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhLVMY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:24:56 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2F7C061574;
        Wed, 22 Dec 2021 04:24:55 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JJsw14tPVz4xbd;
        Wed, 22 Dec 2021 23:24:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1640175890;
        bh=+LiFbgFxbh9eyCXtizRHoiQaCQLWjq2bCGh9L4+NPl8=;
        h=Date:From:To:Cc:Subject:From;
        b=J6ImuDlP9Sy6MLKVWCJlzOo/c0Xz5ijE4p9bElArmyO7GUw1RKTsAtDNyPxSENOua
         gpciME9wGfdjGUzX7x9I6iI1RFbgOD4Ps85BWkrRw+GjhZ/JDngJYw1zAiA+db7Ape
         L08FdSdXtuM1sIAL9wZY60QoUheImHBl6t4jshK1Br8HM0GNtAIx4CMKxe7gmdH2eT
         bNp7iwxA+B3krayx1V3w5rLQ6KJHhLAzFIMYkchG4B04x07OGJHe6TdRevbqvpekmt
         Ievdownc37BMhKy+ghY2rm5f0mmGSwgDYCc0ZsvXhTg+ywnceXVw5dSojsAO70PjK/
         gJcgl6BuBnahg==
Date:   Wed, 22 Dec 2021 23:24:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the devicetree-fixes tree
Message-ID: <20211222232448.012801f5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oI0/x0C7T.Tqj7y/KLEoHyM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oI0/x0C7T.Tqj7y/KLEoHyM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the devicetree-fixes tree, today's linux-next build
(htmldocs) produced this warning:

drivers/of/fdt.c:980: warning: Excess function parameter 'node' description=
 in 'early_init_dt_check_for_usable_mem_range'

Introduced by commit

  c227aa898001 ("of: fdt: Aggregate the processing of "linux,usable-memory-=
range"")

--=20
Cheers,
Stephen Rothwell

--Sig_/oI0/x0C7T.Tqj7y/KLEoHyM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHDGRAACgkQAVBC80lX
0Gw5tQf/RDKo1Ga31Ox1oD3/Vyh59PFXg/+4E3NEwoKGkZg5QHcyvOgyvruLVPZC
jlsw4ylYI4/fZtfNAKsm+NDEa3HuPMvGv4eraw70EeLmlB+d46goHFZT9DJeOqv+
vGPp/GKtCV0tM7l1ca8sxd9iL3SzN0UnSdNvjWVlzEGTAEQCvOh7rEq5TlT9OKEK
wzSmSOXASRzCPNtPNj64hwjKZQwJ/s2DR5dqK40SKIz1vqaVN5BuZigxCiyxaB3C
WQAUn1Ai9VjwnFDVwnCC6c1MrG7nXIBhNAAzoXIuRdCvmMMOEaz7UVUofNbCset8
5aVjIn7qCGwX+aykhXto6O7tRx01Jw==
=BD00
-----END PGP SIGNATURE-----

--Sig_/oI0/x0C7T.Tqj7y/KLEoHyM--
