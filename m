Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C16C472A53
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbhLMKim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243976AbhLMKiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:38:23 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08704C04C896;
        Mon, 13 Dec 2021 02:24:56 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o13so26085794wrs.12;
        Mon, 13 Dec 2021 02:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lps8zlY0plffu89oo+ZuKtBVR2UFB4mYLL1XQcOR5SA=;
        b=Za7I3FFfxdMWiq9GbGcKIbeq0brDgYen8LmJIsEVOpyPpHwYZbppF3xfqtlIfENdP1
         jHzUFwVAP2of3Xe4rLtkWRMId6pLI74v5FjBEJhPFD2Qe3miPuN6o+ncw3dknYNTDqMQ
         wi42NVQiYAJAWQuwYkLNh0hK3QsTiXETLvNGR0EhwzmqH4c74hCm5xpFWWJMJYXIQTGT
         BYc3zFYCdPn8GMYWHCfq2KJLnwt2dEmjvKUfVgKQT2HwZ3pO9WkLRmLq19EdRyHkAMrM
         fL4N8RW+umwAa887wcZi43Se2SgJtZuq1L7bW2zIXPKWZgkAjcr0R4miICMkPdiQ/sVh
         cxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lps8zlY0plffu89oo+ZuKtBVR2UFB4mYLL1XQcOR5SA=;
        b=whCIDkFaj4gYg5jFIpKMmN/dS1Sx/G9OJj85S8El46UnnFGIiHLl59m6pDLi45oofD
         tXEoRs4c+7nCVSdE6TpH+IPXngA+JSrP/JzzWIkdmwWikt2N/7cbzNokjmXsTUOqzZvx
         bG2E+DUbDdAtQUlF9Kno22DO6UYodfJL0tHxebNXnkmfagGVFKgCiMP0ZUfuSalzVvI7
         bQZoamgsJUh8aFQLD3tkKvgCJHtnFfXWXD08ydx8whQVMQ7Imt3LeZTLuENaE9B+4MlS
         8jZWuAvxrxXCxWRu6lSFgQcL+IzhyQDOmNfkkm/lP2QG0+09LSaT3d09xvR1G2ytL2uY
         pcTg==
X-Gm-Message-State: AOAM531GWe77MkSSYFtxZYi9Q3NSC2SApsMqhLtIVNmlY+sdDTFCioTl
        gSHJuxrLLLuT20RQTmwQZ3o=
X-Google-Smtp-Source: ABdhPJwFcQlQB6qp/Z8EgEGC4clwRl8Lug9EUHupaG/P+GoEeE207ABb2BWX1xTZnxDob1Ye9DojIQ==
X-Received: by 2002:a5d:5643:: with SMTP id j3mr31204212wrw.138.1639391094112;
        Mon, 13 Dec 2021 02:24:54 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id o3sm7170098wms.10.2021.12.13.02.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 02:24:53 -0800 (PST)
Date:   Mon, 13 Dec 2021 11:24:50 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     digetx@gmail.com, jckuo@nvidia.com, jonathanh@nvidia.com,
        kishon@ti.com, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
        vkoul@kernel.org
Subject: Re: [PATCH v2] phy: tegra: xusb: Fix return value of
 tegra_xusb_find_port_node function
Message-ID: <YbcfcpkwxCkeGP3f@orome>
References: <942f943c-9ec8-9887-aa6d-4d133821beca@gmail.com>
 <20211213020507.1458-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="W2swrXWGj6l4aaDV"
Content-Disposition: inline
In-Reply-To: <20211213020507.1458-1-linmq006@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W2swrXWGj6l4aaDV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 13, 2021 at 02:05:07AM +0000, Miaoqian Lin wrote:
> callers of tegra_xusb_find_port_node() function only do NULL checking for
> the return value. return NULL instead of ERR_PTR(-ENOMEM) to keep
> consistent.
>=20
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/phy/tegra/xusb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--W2swrXWGj6l4aaDV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG3H3IACgkQ3SOs138+
s6HJrw/+PwLmkXa7Ame0lq2zyamq1ugkXKFFAabK3ZHFV8Epsuyl4tT+FKNn2ShM
y7Dy/Vqh6SVtb4CXBFc25tI4SyfoH1uRALMdFc8CqUyPGhN4HXOOIPRrikUyeWyg
xROkHn5Fnjf3vdkBat3vwVEHZiu++AZTMz97GOsNP25lwMIEmw/sGw9KBFt+cCTV
S8g/ihfq8fncGHOIO7soGncJyjZPQhWB/R7mur7A5eSelfj+OKW+BqeZUwhI167C
+yvONyxgtB8EZmNWGnw5jrV384n0hw6kOJGR9G4tsZRV9kVWGL7vTGcdiAZiDB/v
GIZGGdzNiCKFSp9di9nj8lkvl28YGJrgQgg7VfT1MF5KfDZCW0dohgq+KrrBPw4N
/IxAVEvF8rYmuESrL4UuPS8KVjAhjN0DlvtJvWoBumq3rhx0FsD5OpuZik1daN8c
/eXWcxlvAZZZSYyyiNMIxTIPDixHxj3s2J9/9zTfDpNZYuShOBR2t43wYTiCUbfr
HRIyaUO73BHbOU1wUeutEO4IS9pqL4YU2a2bnELG5GGG6HQ1/HmdIeMWVjgeebux
LG1eqUqKSoV13LWt8ULgli4Xz3Ra+y6PJpbB1a1hsINgCmuv0PpDG2qkHS2ZKYbJ
9XiWzxcgulRpx1OzLOFkdkcfbRt/zWCCiOK1bQiJIG5mwrI3NQo=
=JIfE
-----END PGP SIGNATURE-----

--W2swrXWGj6l4aaDV--
