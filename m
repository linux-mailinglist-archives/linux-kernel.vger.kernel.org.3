Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54D8491D96
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 04:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345602AbiARDjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 22:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376503AbiARDce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 22:32:34 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711CDC014F27;
        Mon, 17 Jan 2022 19:08:42 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JdDHr1Dqhz4y7k;
        Tue, 18 Jan 2022 14:08:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642475320;
        bh=IEzbkjnLCSmDBFUOIpbhnHqWY1VZmR7u3ufGX8iAuu8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ECE59ixmvwezSMh82RTR/PB4nRqOfcL3KIeq7hgI8U7D5I4lW9+iVHp+dKqYiuaMp
         RNnQK8amiA6Na2s1ySWfWGDOQXle/kDYFiXKBlnnnhIA1Qa7MqrGfF8c6PF2F+rb1R
         nAvc4rtO0qZ3z4h01EiKFSoC9R086orCCBIPYHzMxgCRqhItjtzi4ZIT5vu1ht/awM
         yh35E8dF0BXqlDL2SWExe98SrTo5his7B/nZ93C0oJlNv42266GJgUd07lU2H7JevH
         VLbLDjCCIk51+z+n5yGv4OaQj0E4tfhDmeN1JNOq0fo4wciScnNYBw07xLJLprdhb8
         U3d3NWBx6IrVw==
Date:   Tue, 18 Jan 2022 14:08:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Jan 18
Message-ID: <20220118140839.121087df@canb.auug.org.au>
In-Reply-To: <20220118135924.6bae0ae0@canb.auug.org.au>
References: <20220118135924.6bae0ae0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xJxWf0YqhwkuvLA8YFQoE86";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xJxWf0YqhwkuvLA8YFQoE86
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 18 Jan 2022 13:59:24 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Changes since 20220117:

I forgot to say that there will be no linux-next release tomorrow.

--=20
Cheers,
Stephen Rothwell

--Sig_/xJxWf0YqhwkuvLA8YFQoE86
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHmLzcACgkQAVBC80lX
0GzQ0ggAjdpf5y99McaxmXCMJ7wToowh4enMCm+pt48o1R0eJjpvM2h6U8TEiADv
wIF/nA+/8LDTKxfy0+aA/Z5V2PvmisFTw57mh+3nxbSA/h5Yq9/jNtAIiIC0QlFi
2HiDuHgQ0A45kjbEP5q0xxSypY1eG9EiBQsEflDfoL9S3N/76D8JUI09xbeM9bS+
HmfmFetHmOEfKvpEycdxfXb0K63oyfJIpiH7QnBT962/FjVbmUmnfa73M+BkDe3D
y/Po2kdvgN9Jh4oJO3Yl5ewGfLH6euucPveg+/2nHteP3CemHl8gsht/dAnTqPAC
FwVX84FHUYev3iuj+ISfJbjUsNvnVQ==
=muM2
-----END PGP SIGNATURE-----

--Sig_/xJxWf0YqhwkuvLA8YFQoE86--
