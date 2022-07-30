Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECE0585A8B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 15:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiG3NNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 09:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbiG3NM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 09:12:59 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8724615A0A;
        Sat, 30 Jul 2022 06:12:57 -0700 (PDT)
Date:   Sat, 30 Jul 2022 21:12:35 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1659186775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q38RJUhn9dbppGBkcF33/s/m8/eyOb95WDu7MLC++5s=;
        b=oiaF8bwsZc2QrELYuw4dyt3fd1azGXn+Y31CtCH6xWLRqRUMaR1XdQWB1+VDViWFJKtcRh
        q+dnkfK6uk8lHgNzQ/IoWbKZHFPQJT8A7zGXPDPOOgD+11+64i77TYtdZQwVqakawiTqkr
        YlDDtyI10QcfaMEJrM7keEub39Ye8dU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Wu XiangCheng <wu.xiangcheng@linux.dev>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 1/5] maintainer-pgp-guide: use key terminology
 consistent with upstream
Message-ID: <YuUuQ9shkkY7gco4@bobwxc.mipc>
References: <20220727-docs-pgp-guide-v1-0-c48fb06cb9af@linuxfoundation.org>
 <20220727-docs-pgp-guide-v1-1-c48fb06cb9af@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2sDGTIi8ecJO0e6Z"
Content-Disposition: inline
In-Reply-To: <20220727-docs-pgp-guide-v1-1-c48fb06cb9af@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2sDGTIi8ecJO0e6Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

=E8=AF=9D=E8=AF=B4 Konstantin Ryabitsev =E4=BA=8E 2022-07-28 (=E5=9B=9B) 16=
:57:04 -0400 =E6=9B=B0=E8=BF=87=EF=BC=9A
> GnuPG does not use the word "master key" when referring to the subkey
> marked with the "certification" capability. Our use of this term was not
> only inconsistent, but also misleading, because in real life "master
> keys" are able to open multiple locks made for different keys, while PGP
> Certify key has no such capability.

They use "primary key" in their interface and document.

For example in their .po file:

msgid "Note: The public primary key and all its subkeys will be deleted.\n"
msgid "using subkey %s instead of primary key %s\n"

Also in gnupg/doc/gpg.texi:

By specifying the key to export using a key ID or a fingerprint
suffixed with an exclamation mark (!), a specific subkey or the
primary key can be exported.  This does not even require that the key
has the authentication capability flag set.

Using the new word?

>=20
> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
>=20
> diff --git a/Documentation/process/maintainer-pgp-guide.rst b/Documentati=
on/process/maintainer-pgp-guide.rst
> index 29e7d7b1cd44..cdd108f50fe7 100644
> --- a/Documentation/process/maintainer-pgp-guide.rst
> +++ b/Documentation/process/maintainer-pgp-guide.rst
[...]
> +
> +Understanding PGP Subkeys
> +-------------------------
> +
> +A PGP key rarely consists of a single keypair -- usually it is a
> +collection of independent subkeys that can be used for different
> +purposes based on their capabilities, assigned at their creation time.
> +PGP defined four capabilities that a key can have:
> +
> +- **[S]** keys can be used for signing
> +- **[E]** keys can be used for encryption
> +- **[A]** keys can be used for authentication
> +- **[C]** keys can be used for certifying other keys
> +
> +The **[C]** (certification) key is often called the "master" key, but

Maybe "The key carrying the **[C]**" is better, match the following
description. As your said, gpg always create a [SC] key by default.

> +this terminology is misleading because it implies that the Certify key
> +can be used in place of any of other subkey on the same chain (like a
> +physical "master key" would). For this reason, this guide will refer to
> +it as "the Certify key" to avoid any ambiguity.
> +
> +It is critical to fully understand the following:
> +
> +1. All subkeys are fully independent from each other. If you lose a
> +   private subkey, it cannot be restored or recreated from any other
> +   private key on your chain.
> +2. With the exception of the Certify key, there can be multiple subkeys
> +   with identical capabilities (e.g. you can have 2 valid encryption
> +   subkeys, 3 valid signing subkeys, but only one valid certification
> +   subkey). All subkeys are fully independent -- a message encrypted to
> +   one **[E]** subkey cannot be decrypted with any other **[E]** subkey
> +   you may also have.
> +3. A single subkey may have multiple capabilities (e.g. your **[C]** key
> +   can also be your **[S]** key).

Reminding the limit of algorithms' capabilities by the way?
Like: As long as under the algorithm's capabilities.

> +
> +The key carrying the **[C]** (certify) capability is the only key that
> +can be used to indicate relationship with other keys. Only the **[C]**
> +key can be used to:
> =20
>  - add or revoke other keys (subkeys) with S/E/A capabilities
>  - add, change or revoke identities (uids) associated with the key
> @@ -180,7 +190,7 @@ relationship with other keys. Only the **[C]** key ca=
n be used to:
> =20
>  By default, GnuPG creates the following when generating new keys:
> =20
> -- A master key carrying both Certify and Sign capabilities (**[SC]**)
> +- One subkey carrying both Certify and Sign capabilities (**[SC]**)

I suggest to use "primary key" here. Gnupg use it in their doc, and it is
really shown differently when typing --list-keys.

>  - A separate subkey with the Encryption capability (**[E]**)
> =20
>  If you used the default parameters when generating your key, then that
[...]

--=20
Thanks,
Wu XiangCheng=20
0x32684A40BCA7AEA7


--2sDGTIi8ecJO0e6Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEERbo3U5kJpaCtFl1PtlsoEiKCsIUFAmLlLjMACgkQtlsoEiKC
sIWHAAv/ZAIbv7OYc29TGzAHJgafx3/hl3STUxE/P0YjFc/PeqN/pajS1Rw3p504
o6H06Cu6GtNc5p9pH9FMvmYXozb3+3QTOkbDiKZA7KgApnWWSg2+lr+nBq/Iwzb+
eJtdTZA0t7veS4n0/awU3bpQ4DhyKjR/05YK8wa3Xv+CBV6OGaSguzCGTcwb8MSr
aayk5vo0Z4RAXWckVTo9zA31yfMyxMLO7JVhfTZZQWYVV9DeWi72U3f0X8ncLz0n
9ggc7N//w/K1l6x61AcRvfHeIuNrRJDASZQ4ib5w3NG4EmcA1nDPSQAWE+pK0haY
G+rnXKDfxHGzKBQV3LK8SrEwP9gFJGgxn/vbyGUBHRSRCkGXgiUKVEf5y86JQAsw
2rMhF3IXsC0bEtyWZhmGKWfXCeuaYx5GePhNXaPYeewiefvX7uL3GTsTTbIeXDVf
aD8lIjIpc5qKgY0oI9oWSGMedS8wyhWgYvvOpn0oVYY0eTB3PAfhxNqA0Rw4MpWT
X8VMJD0x
=gUlN
-----END PGP SIGNATURE-----

--2sDGTIi8ecJO0e6Z--
