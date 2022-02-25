Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BB64C4584
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbiBYNLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240977AbiBYNLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:11:10 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339FF1E7A7A;
        Fri, 25 Feb 2022 05:10:38 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d17so4419640wrc.9;
        Fri, 25 Feb 2022 05:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vlA3eK5Bl/FOBxIqQr2bttZn8OYu5JXlLYnsBhtHklM=;
        b=VuBwrpJfbBOW1iuiiX8dWUcJxDuUJ+TBX4n14xRKUaMgGvkqFn1wfoGlRGk+NAh+nI
         pkIgW9A+qpvKJTJCAJb7oquP1BxIcnRuGP+HSgi4UdUWyaWdAhJ06thtfoM/Ea3yEV/B
         lJMx0sgO/HARsZgvWaDiOXJ1v4oriH5IEwwhsdK1AEkMYFN7NukdmTk6SPYCqPD+qTPD
         gDuqGncUNOF73xbNLVQhgsk7cNwabNI6FXfMyVJx+i6f0vDn5JOmcNp66PI/m0NlpYMJ
         xlFbVblvv8I3sxRKxTIK2PEWTSxdysMGovEVCdsbupdnYKWVigjFFpke/RPc/C/RFOuU
         ub/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vlA3eK5Bl/FOBxIqQr2bttZn8OYu5JXlLYnsBhtHklM=;
        b=cnHEZrrQPjXnUXdpoVVf1L/EwFVgp95pW7+QAbx4Mi8lG+8CcFk6M3Xrf9IPczC1Fa
         RvcQHtkpX/U0OuMOhwV/2xyHty9GK4nV+bDLcRBVIPs11vCIGc+IMOKNSSvGRuveemH6
         9jxetmoJElZ4M6GC6TF4hgiW8sqbpOR8ZL4/YkBZv4/C1Mg92aBbY+L/E5CHfyYVsz+Y
         YuovOl1+lXFoGhJOMRyGkiH12hcPfgD4rDnIf1wz4mzh1yFZy596mT8e7bfNfbvPkQJr
         +Ctu4RmOTPRrak0VhPw3LhAaiYoPZylGLKkjwbrR8xbKs5QR6/4SKauSh5xA+Ngfuhsx
         hvOQ==
X-Gm-Message-State: AOAM533L1Napu0S+T6K3o4NAySkTVW+v+usDcjAoxQWwF/AOfxKpU0ed
        niN0tRnqQM5VosifaQmrgOE750CGRNQ=
X-Google-Smtp-Source: ABdhPJxWUW59vdNTJb1moblRywRu740NlcfJzv3mxAcUsIBZhOfAJSixEyfk+zfOEz3FpQ69xpKccQ==
X-Received: by 2002:adf:c512:0:b0:1ed:c0bc:c228 with SMTP id q18-20020adfc512000000b001edc0bcc228mr6035477wrf.174.1645794636806;
        Fri, 25 Feb 2022 05:10:36 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id f17-20020adffcd1000000b001edbf438d83sm2296919wrs.32.2022.02.25.05.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 05:10:35 -0800 (PST)
Date:   Fri, 25 Feb 2022 14:10:34 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     trix@redhat.com
Cc:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc/tegra: bpmp: cleanup double word in comment
Message-ID: <YhjVSre39nZ4evyc@orome>
References: <20220207130951.2059795-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gaMB5m1ByvcdMX1c"
Content-Disposition: inline
In-Reply-To: <20220207130951.2059795-1-trix@redhat.com>
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


--gaMB5m1ByvcdMX1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 07, 2022 at 05:09:51AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
>=20
> Remove the second 'or'.
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  include/soc/tegra/bpmp-abi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--gaMB5m1ByvcdMX1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIY1UkACgkQ3SOs138+
s6EwSg/9EfbRbWhVM+OH+ni+mN2umIXqF2gMUQp12pZneEmDnCPlfkFFIrXrEUtV
+hB7m2uTTCHiV7kpkAjoa2bpVSMH+Iz1w/gBCjxcI4B47juEwwxMz/iaNxVE3qk2
h6hotb805FMsOKN4vyVTIIGuqv8CDQGXZM2FuWl1qjCYoYo9wlJbTzvhddPPfQLh
u9N220LGHZw3hXWZM/HA2D6LyvE1KLzZD+ulNRMchjliuToadNgSocRN+goSm1Aj
i5eqd54x+PgBaFxy4MOX3egogWh4xoeiMtmV4gvnKWyrhsBxQYJybe2tj8Q6qZa6
BU/KmYZdhsCxoWm+CXT3tECHI6+ccz5v3hv1DRCpiWgqefx6Kc512gLZUuLfN8PD
eW55wSwljECsXs3fcxkndW1sKIUT8kKtvwNRhCG/qKVD6/v9VnuiMP7j5X4U+Lmn
J9JFJUHWZu/UoEC5ToU3dWjYDrzmpPFuchYP0uIRALDq2xz7WRe8016g+GgYia10
JNKc4szSgepDNt0KJr85/DPOT3O+xM/+6XwZz9T6lhGIID33vJ6MsB/p1HmhcvNp
6ocMa964idCjlc8aNXvum8GzpzkLrShuxYLKbQ6YPffemIitiNWptF8ZUuDQrWeO
KqRbKAP4YMwrM5zeL3iDEbh8Zeon13HoxRZJ9L/P3ttNrD9m26s=
=w44Z
-----END PGP SIGNATURE-----

--gaMB5m1ByvcdMX1c--
