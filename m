Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED86346B62F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbhLGIlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbhLGIlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:41:31 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E93EC061748;
        Tue,  7 Dec 2021 00:38:01 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id c4so27797195wrd.9;
        Tue, 07 Dec 2021 00:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HfN03EH6jRdkzxqbzdL+husUCScYn8YWR0GEjsaexJQ=;
        b=SU1LiBtF7Vmw2kbRPFZMKxlaW7Wvd0fPteIARv6bABR+DP9wdANTI612x7HCDjUt+2
         mB3J1q0LBIQleCPyscGcpdrlPFn9IoYiz4nsZmf4GYqEdiEY8Cw2hjwpI1wpqfU1KoaH
         +v8GnCYWfUIpegDUJdZqo5UFlOlC4bSRMwgwLJEm+EmQ5+b57JVfU1JxdyEtUP9xlX0W
         CbGwk1pCd+0vKnlhPzSEBmWzn5qOcvDun9F52OjT/BJho2ybARzPQD3ctpYZaKi6ZRlT
         QNeSXt/pepGdGA578DLX7k5/IbagL0BicaxTbvt4KEXU2HTjJfvBZii4bQQo3280SXuA
         xQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HfN03EH6jRdkzxqbzdL+husUCScYn8YWR0GEjsaexJQ=;
        b=sm2H6B01bECGEtxFt+aNA32jiZawKVt6A9ZRRnvePvg2AE55jGrOdBZk8yydgVxLjR
         sVcYTi0V/VEzgiHccSr1yUqQZ68N1sdqJtKxBzzuGWRpPnj/y9vL5HClVvK5cEwwL/Pk
         g5ZBZhmZbE7wTcru/fsGcsH3NDKIOTv6WqkQHBx5QK0IU4uw3U1jazyx8DlGi1U7JmYg
         vC04M+Ke6qMlvJNR/tbcJXOKex6scJ6SBE+6M5Y9qoFejya8dAELKk3ueWnOXxFFCjHK
         3rPcUVWdORheMNEzQRaOrhcYxo2ozg0mmnQ77rZ9UPaOME5UicapCAvPzIOj/UKYSEx8
         gLGg==
X-Gm-Message-State: AOAM530uS+adXKGLBPj2O5uqcQQhAu5GGNMl7f7x9LwgByXvtdVSuKdB
        HcnGknviOI4Alyj1YNXD/Gs77z7j+GXqsg==
X-Google-Smtp-Source: ABdhPJyCGrPxgn5HfGAfiUv6e3AxvvcHVuO3XSqp8b4h82P41TA3JfEm4nzDaa136Axf9Qwn4+IU5g==
X-Received: by 2002:a5d:6da2:: with SMTP id u2mr48974035wrs.273.1638866279689;
        Tue, 07 Dec 2021 00:37:59 -0800 (PST)
Received: from orome.fritz.box ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id l7sm16234648wry.86.2021.12.07.00.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 00:37:58 -0800 (PST)
Date:   Tue, 7 Dec 2021 09:37:56 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tony Lindgren <tony@atomide.com>,
        Roger Quadros <rogerq@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: memory-controllers: ti,gpmc: Drop incorrect
 unevaluatedProperties
Message-ID: <Ya8dZKQJWxt5IfZh@orome.fritz.box>
References: <20211206174215.2297796-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jnZevcPpY2ZzTOjv"
Content-Disposition: inline
In-Reply-To: <20211206174215.2297796-1-robh@kernel.org>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jnZevcPpY2ZzTOjv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 06, 2021 at 11:42:15AM -0600, Rob Herring wrote:
> With 'unevaluatedProperties' support implemented, the TI GPMC example
> has a warning:
>=20
> Documentation/devicetree/bindings/mtd/ti,gpmc-onenand.example.dt.yaml: me=
mory-controller@6e000000: onenand@0,0: Unevaluated properties are not allow=
ed ('compatible', '#address-cells', '#size-cells', 'partition@0', 'partitio=
n@100000' were unexpected)
>=20
> The child node definition for GPMC is not a complete binding, so specifyi=
ng
> 'unevaluatedProperties: false' for it is not correct and should be
> dropped.
>=20
> Fixup the unnecessary 'allOf' while we're here.
>=20
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/memory-controllers/ti,gpmc.yaml      | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--jnZevcPpY2ZzTOjv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGvHWMACgkQ3SOs138+
s6H4QA/9EgPPg3VO2cn97p6mKq29CZwbV2RejnZP3ZuuxGjNobrVjjfSiaQIqeOR
CAjFxXtVjmaB6X0jhPSDNH0fRF2rAI3SHISGvEoks8utXlzEkTEcXhUIMz3s9Zym
da9RS8YQJpQcJk+fzKpOKJ+eCUMAgVSOdkkdb4QyxNIsrCRB60oQXchWVsuKHxIv
uWtPRf6Vy1gz+myQpoKC+R5i9YrulZOPLFqEKuuKIz9NZ5RHne8bWtQEy4JC3K4Z
6m84is5MzD4r8M6c1NQaNxeOACzklND0Zwkk2iiJrlbFmdO2jmxbgzAzHnNlSDNi
/If7hU9MKEOW3QZMuDA0aTVeitEa9TXG8/3fDUpsWNtOHuv71RxKMYJwPW87ln8a
/Zyx2BzqHthpIrEUDDTD97dqZQsYFNB02wDJT6ZcJEoSBiQCFfDo/GuduAowpXtp
4bsLT2YNx7G0UFbsW+H/4Dv9PBjEDyLgmTaK0jGbp+ut6AqZvUfzHhSo4OtUygZ4
vUq6ATyuGKlBSolN+zSjqQbTFg433mZ0Bi5I8HH3xwJmQVMKjm67Tf/EiDTZ8+vy
yw1zTbWdGvTOX0eLacz9C7UyyKddgYLzY/JUzwqlfddnK6dmKTgfOJi5y8FCf2G+
4QH0hXpXCnlKOtkNU3NnH0i9h9cE7OhGhNOJwj1apkWgYQxjbmE=
=czj4
-----END PGP SIGNATURE-----

--jnZevcPpY2ZzTOjv--
