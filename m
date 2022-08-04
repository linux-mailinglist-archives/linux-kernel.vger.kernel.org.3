Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B08589BB9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 14:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbiHDMd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 08:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiHDMd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 08:33:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB742A94B;
        Thu,  4 Aug 2022 05:33:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41CE96179D;
        Thu,  4 Aug 2022 12:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36C2C433D6;
        Thu,  4 Aug 2022 12:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659616434;
        bh=8SuHDb9ldyOejkCTtg8K1MzKyXw/w7bAOZcYAvMVlbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ujEldJmAKJJ051UD0X8lgTOV8k8RGcT5VtyAsnRoCYJKEs2HsW/c4p5Uf9FhniyhV
         zH2q/ahKazSqZ27wzhvydhv9Kvv6qDVj5qQbBq49+/4hg9va9gmS1uuwlJyNGsNxNs
         E6NCIlW6eqvIU2SBIOigPGJJnQtiwim3RC8GqFU8eLEgJ0OpVv0AKe/RdL9oJXirpz
         SF8qCdyN9acwRW62Qx8gvh4NICiwgahw7NP+rnFDmb5ixSMzpzKpPbEF/IzkP09JU8
         nTOvGC+nU9hlwFiBJeSoy1Fy1VlZAN6MecVjDcy4o8Rw33WSS7DI9OdclaQz9bhwCx
         ROm5tzhYBmGgA==
Date:   Thu, 4 Aug 2022 13:33:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the input tree
Message-ID: <Yuu8rmJ1VsGPakqF@sirena.org.uk>
References: <20220801214434.2058469-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cxmyPe+BYZ7Sbk4V"
Content-Disposition: inline
In-Reply-To: <20220801214434.2058469-1-broonie@kernel.org>
X-Cookie: Did I say 2?  I lied.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cxmyPe+BYZ7Sbk4V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 01, 2022 at 10:44:34PM +0100, broonie@kernel.org wrote:
> Hi all,
>=20
> After merging the hid tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>=20
> /tmp/next/build/drivers/hid/hid-nintendo.c:406:29: error: redefinition of=
 'JC_RUMBLE_ZERO_AMP_PKT_CNT'
>   406 | static const unsigned short JC_RUMBLE_ZERO_AMP_PKT_CNT =3D 5;
>       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
> /tmp/next/build/drivers/hid/hid-nintendo.c:295:29: note: previous definit=
ion of 'JC_RUMBLE_ZERO_AMP_PKT_CNT' was here
>   295 | static const unsigned short JC_RUMBLE_ZERO_AMP_PKT_CNT =3D 5;
>       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~

This error persists, I've gone back to 20220722 which seems to be the
last version.

--cxmyPe+BYZ7Sbk4V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLrvK0ACgkQJNaLcl1U
h9C5swf/Yi6THqPm0xTQfL4DuwcguA2dVQv7fCwLzRWVodZR1cxmO/QqBxFy54br
e4KZIuIoVhagZ37nIHmPBlZhblTRIe0WrpjSltvfKu2hPi2/tkiLlBKaPLDV15+W
VbDh4x5Km4YemrCtWcjRBD5eqCPxttZ2a4LZ22TcJ4arz6b5T5zTrNTvif7BbsQ4
8MQbXSy5koVUoymc2JThtNKaj9QIvKdkfo9fFZ8crIQvpaO22+iKfZTbi0ZGiK7s
+/jR/y+yzUjOedvkJHPBfuLcaO86AtB0JK2d3L8bTXGshgiGcfozkWi2hFowsxiK
+OhDA8WbDTh4PunYdNAu/FiV1Vk+3A==
=63h0
-----END PGP SIGNATURE-----

--cxmyPe+BYZ7Sbk4V--
