Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED0D49CC7B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242223AbiAZOiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:38:19 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:46619 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235584AbiAZOiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:38:18 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 6DD8B3200D98;
        Wed, 26 Jan 2022 09:38:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 26 Jan 2022 09:38:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; bh=vntiIBiB94gPAqm1i6BqXy0anQqXEM
        zvI40bvzT6DfY=; b=HhTIEmEm3mcJ5PQ5UMHHm4E9F0atCEWgal/p1BJJH6kAtu
        2ia9h5ustybJAsgX1W5Ot4OqNiD2L1+Aq9bOGSdwp4aKiWrw1cz8i8df2GaSJTyg
        KSFG+m7HtZobgRS3feHY94Jh5f8cuwM8bmAW+CnS3C2hFRX/2+GBYSx3PK4MNRu3
        x5dxdXYWLZUOppwqPxk1IdRigiY3s//bHEVy3held5JBKAx2Q0T3gtXC2mInE2oH
        1Nao5wstvaczk1FtcDjYzowFCzDxz1CTCBdUjiL/y3h880pUQI8BVuWoWWFkxY9Y
        NRxClbFhxmgn4Z8QNI4GNlag0q1T9CtEKNdFENLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=vntiIBiB94gPAqm1i
        6BqXy0anQqXEMzvI40bvzT6DfY=; b=LS1qPngBvH9CDi9zK8epOAKF3M6clk7v+
        LmzSpxKk4/XD0FpHldJvgezapzkaiyE92glhzf1tRKbRoh0imv1QWop7SYG2QTZ+
        OC0UeeXKHIfB9ucuaas9kjtTZnzmEcpIliajM3WluHEYXIzhbhx3JNLzXiRPIcwY
        rnIcGBMdNfyvhYyQry4bSvxxD/MFzWSVmMRBVWb8++FA3a3nom9MEXROmzlui1gq
        bL45b9O7n5t1Ph1tQvvc/KbHc/Q/sBQWRSRbv+AZLTGEHWefIeDQQ8mqXdm2Sto7
        7Ao75yz2tG0NURPKCb6YH5XUmoa14nJFbS7PvpOzldrGzf4KUVZZw==
X-ME-Sender: <xms:2FzxYXYOYicuXKhMUx8Bx7tid_g2Z47DHP1nhRWwq90hOQ_23LCc0w>
    <xme:2FzxYWZIfM5glrWe75x9oPhtFJHvnrWKfdlftewhnkgFoIB6Pkm1ZBdQJp4gPd2uw
    3jnZekpnzfYIh11YDA>
X-ME-Received: <xmr:2FzxYZ_PXr37MynCXqjoMDxQdKkItBuuZfnKZNgtl4yN-qLkfI7b_k3ae3FevNgLl8OivZ6LSqC1nQB7b_s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfedugdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepmfhlrghushcu
    lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
    hrnheptdetieekjeffvefgjeekueehjedtlefhffefudfgiedvfeelkeetiefgudejheet
    necuffhomhgrihhnpehnvhhmvgigphhrvghsshdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdr
    ughk
X-ME-Proxy: <xmx:2FzxYdqsXl0JkrBluIeU_aZN45VYSNS8j3XjRuksX9uIHqMXsK-pgQ>
    <xmx:2FzxYSo513Hi-7k9ffCA2wo-Y69l5rfvHNgVdfUYzKl700UjUVhXxw>
    <xmx:2FzxYTSvnXXuyGfoDHrhUxprLsKcc5RasepS6UkU2RqaC4ePxsomVg>
    <xmx:2VzxYefdbL43SUJ5_SrRutAYMyf6e-8uHc5Fq-VsOUeyVcopbj9F8Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jan 2022 09:38:15 -0500 (EST)
Date:   Wed, 26 Jan 2022 15:38:13 +0100
From:   Klaus Jensen <its@irrelevant.dk>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, colyli@suse.de, arnd@arndb.de
Subject: Re: [RFC 0/7] 64-bit data integrity field support
Message-ID: <YfFc1f2MoSQzyxZ4@apples>
References: <20220124160107.1683901-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vd57dnmutxBObqid"
Content-Disposition: inline
In-Reply-To: <20220124160107.1683901-1-kbusch@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vd57dnmutxBObqid
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 24 08:01, Keith Busch wrote:
> The NVM Express protocol added enhancements to the data integrity field
> formats beyond the T10 defined protection information. A detailed
> description of the new formats can be found in the NVMe's NVM Command
> Set Specification, section 5.2, available at:
>=20
>   https://nvmexpress.org/wp-content/uploads/NVM-Command-Set-Specification=
-1.0b-2021.12.18-Ratified.pdf
>=20
> This series implements one possible new format: the CRC64 guard with
> 48-bit reference tags. This does not add support for the variable
> "storage tag" field.
>=20
> The NVMe CRC64 parameters (from Rocksoft) were not implemented in the
> kernel, so a software implementation is included in this series based on
> the generated table. This series does not include any possible hardware
> excelleration (ex: x86's pclmulqdq), so it's not very high performant
> right now.
>=20

Hi Keith,

Tested this on QEMU and (assuming we didnt implement the same bugs) it
looks good functionally for separate metadata. However, it should also
be able to support PRACT (i.e. pi strip/insert device-side) if
nvme_ns_has_pi() is updated to also match on the 16 byte pi tuple. I
made it work by just hitting it with a hammer and changing the
comparison to hard-coded 16 bytes, but it should of course handle both
cases.

Naveen and I will post the emulated implementation (that certainly isnt
very high performant either) on qemu-block ASAP if others are interested
in giving this a spin without having hardware available.

--vd57dnmutxBObqid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmHxXNIACgkQTeGvMW1P
DentcAf/W/roVVj60nLr0claSmtY5JLuq/07TsbgeykeS04Yr9AWpPp79Yvwnus/
sEZAxGWyDdn+J5CdJJ3YYG0xt6J1ET+i6JWTw7jG8Mx4dzKU+MjhT7IosuavGieg
L5xs02jpT3+l+aBNOlSspom8WaN8EcxPOKRKzF4Ew0kwtta10XoMfU4W9ceuSp62
GbNWKqnpyoCyQeVW5/AOZQ9/58V84So0roA0Vj4joICOVyofj7VDYSespsI8+y4y
CtYSypgpp/3GdJ8YaKcuNN7Z1k18GUb6sYBSbRNeCknh9FHsAMVkcoC6yKUXA8tD
p0sG5s5m+F1HeG0lKi6Y+0/T6q8nzw==
=DnBV
-----END PGP SIGNATURE-----

--vd57dnmutxBObqid--
