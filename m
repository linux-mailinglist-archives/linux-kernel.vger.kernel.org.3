Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BC351C1DF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380367AbiEEOIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiEEOI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:08:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D3958E7C;
        Thu,  5 May 2022 07:04:49 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ks9so2534749ejb.2;
        Thu, 05 May 2022 07:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QF3zYQNHM3cpVB/0J+AwnNYh+njtzJSH9yH9Tzzj2fI=;
        b=UoRfWViLxAAQ7iuSakL2hxjXTTfTuJauDk2xj9zWAcsMWtmMZzraclLMwpRYh04yBZ
         kDb0EAxMfsf1JugEKMweggUGz9Byt7kalN1DYx4B3RL1PrIWonsyq4g63OeOmWoNfT+E
         +hsd8a4zR+rJiBdH/pBFL0WfmzwSyCGP0YIYFNbrAWEqrBqW0l9mUihrnXaKPhIScs+g
         D/m9ylehnRg55Pu4BmO2vvqXV6njgZ/NGTGFN3dh4GdONo5qD63Gpg7vQO9e2yZ4Dyd9
         /NBo0LB+Z/Ekjkan6+gOIpO8d9VDlrxrPzpcXbaWuUnsDDF5/tzPINCuYv05Zw19m/um
         uRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QF3zYQNHM3cpVB/0J+AwnNYh+njtzJSH9yH9Tzzj2fI=;
        b=0SorKG6EmHTHpEKl5Ca206NuKdbBCtkqshbWpyIjMrVTIGnEbzVIuc3iti2WocOzT1
         R3fjUTm0OyPaVBOLmWuWoSXG198EEjhWjzWC9jjdF3BUg6WB3km1H0fqDuaMoqpgmEMN
         fKl0ML2A8/Pt5UZe1/Co4WilMOeehNudvDDuCli8F1++SG3aGwdVSimXVvWw0iz/MenE
         pnBr2VTdMCDZ+O8/izQwUWEocgAwEJRrB8Y2CBNtV57uoN2/faJ78j7qJPZc9Dc9fGAs
         t763HZK8X0SzBf5uDmm9eZMeEvuzn8+ZI5QP/AKD5J8wRnDFcxsAn5UrFmxwF/9EA2Vv
         UIJA==
X-Gm-Message-State: AOAM530vEgbrtlNBMmQbjXBkiIE0SsUvduz25mhPle//GWVPrfpxbCfG
        SR2eeQNIxsXyrUrhAmVO5qm3VVHLS7A=
X-Google-Smtp-Source: ABdhPJyfvoM1YskmEx71FbKN0LJ5Au6T548KS3o+OpqceJucYgK0Rd8x4AzoJvK/cSx92YzhxIDM9A==
X-Received: by 2002:a17:907:2d27:b0:6f4:7a78:82b9 with SMTP id gs39-20020a1709072d2700b006f47a7882b9mr15189346ejc.694.1651759488225;
        Thu, 05 May 2022 07:04:48 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id de30-20020a1709069bde00b006f3ef214e77sm741779ejc.221.2022.05.05.07.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 07:04:47 -0700 (PDT)
Date:   Thu, 5 May 2022 16:04:45 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the hte tree
Message-ID: <YnPZffmJQjuU+8fI@orome>
References: <20220504165956.531c4b53@canb.auug.org.au>
 <YnIlh++OJDRrK9sz@orome>
 <05e94e6a-86d3-5d60-081a-6adb3bcafb35@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="O5mwXgebHMGAcL4s"
Content-Disposition: inline
In-Reply-To: <05e94e6a-86d3-5d60-081a-6adb3bcafb35@nvidia.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O5mwXgebHMGAcL4s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 04, 2022 at 08:17:50PM -0700, Dipen Patel wrote:
> Hi Stephen, Thierry,
>=20
> Before sending patches I compiled and tested with or without HTE
> config successfully, I used gcc arm64 cross compiler. The initial
> problem kernel boat reported (reproduce step snippet below) used clang
> as compiler and that gives typedef issue which is what hte_return_t
> is. Do you know if we have to treat it differently with clang vs gcc
> or did I miss something?

It's probably a good idea to do builds with clang at this point since
apparently it can catch some cases that GCC doesn't. There's some
documentation on how to do that here:

	https://www.kernel.org/doc/html/latest/kbuild/llvm.html

The process is quite similar to using GCC and it has the advantage that
clang ships with built-in cross-compilers, so less hassle setting things
up.

> However below failure seems like (correct me if I am wrong) Thierry
> might have changed typedef to int in one place and possibly not all
> other places.

Yes, the hte_return_t failures were my fault. Turns out due to some
dependencies not being fulfilled my test builds didn't cover gpiolib
character devices, so I didn't catch those.

I've not got a couple of configurations that I can build and a short
script that will verify that all the necessary files have been built, so
that should hopefully catch such issues in the future.

I had also pushed a fixed branch yesterday and it looks like today's
linux-next built fine for HTE, so it's now included.

Thierry

--O5mwXgebHMGAcL4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJz2XoACgkQ3SOs138+
s6HoSBAAwQs15GtRNFYlV1kr9YD8yqmVtD8o82iqw8LmgYh3ZP/4DJ1i+D3y3xJC
JmM8bd4ItK5cwrY47TNDb2m6xATCgJoMWOu7Pe+mEI6Ens00srFVuIKBMLuNXiFt
oWwD5CxOD9SYc4LUAYN58xyVszbWv5u3Ml6glQrlhid0ybyO3Mr/5LJpCUsUejth
sbf9dHzHJdTwgCy0Gw4i9L/qMX+VNYG89Q6+pmdh5PQdD67fDRh7XTJr8krt9Y8L
POfWZ3yg6mwSscepsJa4FrZlUZAjCjTVa5wp6s4PhETaQvT9yFlH57wNbTdT8WMB
UAoptDhThSoeqkVfEZcoEfRJ1p7XKaRs+XsitK7Kld7bULSgIyOKHzg32bT9Bo/r
B67X1iuwydXi2uybD6nVLG6hBgD88BfPXFgLtVSO0iLd3HfXwIB8c9FTebd/upAE
f62a2cmcfin8M4DZz+b7Pk6Mp31fYEvPMMg5xxrO7iglJpFMk0enPgTm/G8CgJ9l
Bz4ZD+w3mkephSXw1qj5cBqdxpnTG6sCkObjizT5oXF7KPlAOcogc8Jg69rwu8mh
53R6awLJIxnDE6dmS+jpE6DaHn9AiY/LJ14nSwUjIxDD3iTXEOewbS6+mQLApQBr
HietW2z/oL/9cFHBgMRMa39kYcA8QsSqZSc6ztQkwgqtoJl8c5c=
=I36G
-----END PGP SIGNATURE-----

--O5mwXgebHMGAcL4s--
