Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5C94AF893
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238356AbiBIRfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbiBIRfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:35:05 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74348C0613C9;
        Wed,  9 Feb 2022 09:35:07 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id i17so5561764lfg.11;
        Wed, 09 Feb 2022 09:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8NIjqqLl8Q8d9yGDh9LTnBdmuxZgRMGqN0071eUrnzg=;
        b=bgJPEUrvi/HTcJB2kr8J3TQqHRG6Xl82Im5VYrsuLLpEjt3Fyvx66kc7NebndQEIuZ
         a4nNGkJWiwFRfgfTKzasa2Qb7cW+Sbi1iZNyynsWjfgpoKl3sSyCOPC4FPPou0VD6PES
         e0R1D6ufDztwl74jVU24v8KI4H52gBaHBAqWfHMCTMfqyjVw9qEJDvFU7/Ndnvu14wHa
         BZgr/fmERCdAfHHiXtQMS7+/7ZA+/F+hr748c0+XSk+k/hsLuz6mXibDQFJha29KZkzb
         0ar42ni1u2Z4enA7Tr/ulznj9Fxz85LLkgjYRATISjB2wb7o7vdbYX71vvp0MKb4EJBh
         cn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8NIjqqLl8Q8d9yGDh9LTnBdmuxZgRMGqN0071eUrnzg=;
        b=LGYV10doOeEzL92YrF8plEZ9Yc5xYMR0CEH4gyQ8zDgKt+LfxqwvdqJZYrPoWLtMxR
         I+v0lYzjaNBP6BbHn82dERfGrc0WyN66lfn5RA0cfekArqc5aW01lvyRLG3rJ9XEgHsz
         3xuL5hFScNU/Ln/p0tgjRZoHiZ3/LN+mcgZHBHhJFPZp7qcH3jfw8x6uLySyeUJPDmyZ
         2vusvRg/8xm2+8GXN6ELEQXwJQ77Lafj5Bq1obflL995rJ/Xd8cpQ9NquZcT/Ikt3gqK
         ghs0WVkMjjoF/c9dZbLMY+5gPA7fbv4LPnjimhcu37EKw+jMC56rLIEeV1jBsTuTI/F3
         lUjA==
X-Gm-Message-State: AOAM533C60WAew1s4UGdUGqqooE1erPqgtmz4JOdNnvZFwzsS5rAwiTM
        Q4Vma4jpYRTcwC6B2Vgu8dpoOb1epufH8Q==
X-Google-Smtp-Source: ABdhPJwE5Y+59qnObPBcVWqGD0RYLvE4fzpJxuV4YvPqdSwZMNvhqL65ykklDYjFLEOMG0iUKrsyDA==
X-Received: by 2002:ac2:598e:: with SMTP id w14mr2271364lfn.218.1644428105714;
        Wed, 09 Feb 2022 09:35:05 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id w11sm2451132lfr.201.2022.02.09.09.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 09:35:04 -0800 (PST)
Date:   Wed, 9 Feb 2022 18:35:01 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kartik <kkartik@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com, digetx@gmail.com, smangipudi@nvidia.com,
        pshete@nvidia.com
Subject: Re: [PATCH] soc/tegra: fuse: update nvmem cell list
Message-ID: <YgP7RRy/PTuXZlw8@orome>
References: <1638791565-3137-1-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wlDecwlbAShuVnde"
Content-Disposition: inline
In-Reply-To: <1638791565-3137-1-git-send-email-kkartik@nvidia.com>
User-Agent: Mutt/2.1.5 (31b18ae9) (2021-12-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wlDecwlbAShuVnde
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 06, 2021 at 05:22:45PM +0530, Kartik wrote:
> From: kartik <kkartik@nvidia.com>
>=20
> Update tegra_fuse_cells with below entries:
>  - gcplex-config-fuse:
>      Configuration bits for GPU, used to enable/disable write protected
>      region used for storing GPU firmware.
>  - pdi0:
>      Unique per chip public identifier.
>  - pdi1:
>      Unique per chip public identifier.
>=20
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> Signed-off-by: kartik <kkartik@nvidia.com>
> ---
>  drivers/soc/tegra/fuse/fuse-tegra.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--wlDecwlbAShuVnde
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmID+0MACgkQ3SOs138+
s6FazA/+N8CLS2hBOqfp79hXy4cX5pQLIfdyWqOXE+8QAMy9+PMKYpPUFXqOFIGp
7FVv1ymK5dmjp4NgNhDxiVUZEllhFmtNX8Is8P9S5HgQnOg6oT5AiWs9jvt1tB62
NlhcpWc9vaiDDFLl3kEyfQIz9tCDkq2KU/yH0TrlPQ2jzGtT4D8WspMdtZrHIL24
yIrZAXjooimuNTDgf7+pRBQMwpY7m+F/+IO+xtdU2vQzoNeGHaXm5pcn2xEyAGCm
Hi51o+2+kuEBcr0DH3tSSJmxVgn0KVxZ/IsZ59FmKsoOwr/5OXf0EQRo2lPT4F1X
rY15hESZSM4TDdS6QKtGZHfJ5tZzMFI5dEUkV1QjZsDQQnpCH5DChzOfnfwcKGG1
NvHQ8rwkULn5WDfSBwFy5UWXah0kJDQ/9ocI3Fo0I0g5YeL1nmfEFN6IlY61sQbQ
Cyu9OvyUeurOyRBqwyU9PVlDAdAvKHV4XHQdoDLirdk3AYocJPZGONzMc4wLm86O
BkzhiFAjg5W5oRX3PehmkwyzGHiHXb62YB87k7jo/wBymIKp5azQ70rd/fNYjcCm
go6BJ5N1c9OjCRC3/K3otGTaa8V/H5rUtHBEv+QtZpjEaj6WFcMtb9BClljtFUb5
UX7YMMGox3lxmtUPc/enBEiUmw+gLfbpaC4+UAZwTMNxli6jhcE=
=0yLe
-----END PGP SIGNATURE-----

--wlDecwlbAShuVnde--
