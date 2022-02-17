Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8A74B99E3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 08:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbiBQHfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 02:35:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbiBQHfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 02:35:19 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7912A22B6;
        Wed, 16 Feb 2022 23:35:02 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d27so7374590wrc.6;
        Wed, 16 Feb 2022 23:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xPL+09khBYV8RItKtpzdQuIqr8WWC0DLKqJPTa3LDKw=;
        b=po2VcBKQKTamBBBBaXEQhUyyZbCWMQux6CI+7Qrkva5Bj4pzsuE87SAnqEwNj4V1Ga
         RJOnxqn90soXyp3/xLT5xQMwiyDD+Ve/3Qi9F7SshuX43g1SusUC4tkbcxAs0F4VR8Kz
         ptxToypmbaHTKb+FOcTgd0i4CWay8lxRZViii5WI0KZjuwSU/o2e1D3BABfh1PLS16IY
         7Xdxu2sq75ARv1Ys466UjviCKYMW3CHtxLjzIA50bW7Tlv09LW4+96jN4MaeGdyNz+RV
         v7GV3HLMwrcj4o9wCIFdj4gD2MQlcwhaRbDAA6K8x+J+j2+DxDlzUKzRhlFqlXtxMZ4O
         Ah/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xPL+09khBYV8RItKtpzdQuIqr8WWC0DLKqJPTa3LDKw=;
        b=3QeaVOQoVX71X7vL1HB8Yn5Iif+HtRtnH3MU+A2W//ovAvL+kVm61+fE0kfY/ddyI0
         KQV0B7cuFLB+C19qQzPhsWdqCamZQvgO/CcAtFyxlD8Ym/IA5JbT5wp21tX+3QhD2QgJ
         H4Aox6ijx2nyb6EPIpvGu1mTpCBIvHaSJFxVLn7nYEHVHKoqKCkmeD4Alc8mvd9bfA3Y
         oO5tJW5fUeHXxWEYFbGkuVKz/Ol6i79Ba6fTufsP0K5Td70oDw1kdiwbcguDgeaRWcV+
         4WcYO/3L72cGm858s9WlbaNr548h3QKZCtGUx1bCbtu5NQhySmGfzbafibjxPPfetd9x
         tgdg==
X-Gm-Message-State: AOAM533l6PayZteaszCAgj+KbEQhgcaTNRs+CJE4y2K0mh1qBLo6vDMs
        H+YXZoIoCRTc1ytm79z0EwY=
X-Google-Smtp-Source: ABdhPJxhGgAhRLb4mOGFtIHKutI5wjGBXoSwwtqIMocgzYakd20/sX20pkYG0oJAAmM5fSBjnhp38w==
X-Received: by 2002:a5d:5221:0:b0:1d9:2680:5fb with SMTP id i1-20020a5d5221000000b001d9268005fbmr1243143wra.23.1645083300515;
        Wed, 16 Feb 2022 23:35:00 -0800 (PST)
Received: from orome (p200300e41f0a6900000000000000043a.dip0.t-ipconnect.de. [2003:e4:1f0a:6900::43a])
        by smtp.gmail.com with ESMTPSA id ba14sm15366890wrb.56.2022.02.16.23.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 23:34:59 -0800 (PST)
Date:   Thu, 17 Feb 2022 08:34:57 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.com,
        perex@perex.cz, robh+dt@kernel.org, jonathanh@nvidia.com,
        mkumard@nvidia.com, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 2/5] dt-bindings: Add Tegra234 APE support
Message-ID: <Yg36oUdUiB/H+Ngf@orome>
References: <1643373476-8538-1-git-send-email-spujar@nvidia.com>
 <1643373476-8538-3-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Bq7R2hPdkx7Mharn"
Content-Disposition: inline
In-Reply-To: <1643373476-8538-3-git-send-email-spujar@nvidia.com>
User-Agent: Mutt/2.2 (7160e05a) (2022-02-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bq7R2hPdkx7Mharn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 28, 2022 at 06:07:53PM +0530, Sameer Pujar wrote:
> Add clocks, power-domain and memory bindings to support APE subsystem
> on Tegra234.
>=20
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  include/dt-bindings/clock/tegra234-clock.h     | 74 ++++++++++++++++++++=
+++++-
>  include/dt-bindings/memory/tegra234-mc.h       |  7 +++
>  include/dt-bindings/power/tegra234-powergate.h |  9 ++++
>  3 files changed, 89 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/power/tegra234-powergate.h
[...]
> diff --git a/include/dt-bindings/memory/tegra234-mc.h b/include/dt-bindin=
gs/memory/tegra234-mc.h
> index 2662f70..444e62d 100644
> --- a/include/dt-bindings/memory/tegra234-mc.h
> +++ b/include/dt-bindings/memory/tegra234-mc.h
> @@ -1,4 +1,5 @@
>  /* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/* Copyright (c) 2018-2022, NVIDIA CORPORATION. All rights reserved. */
> =20
>  #ifndef DT_BINDINGS_MEMORY_TEGRA234_MC_H
>  #define DT_BINDINGS_MEMORY_TEGRA234_MC_H
> @@ -7,6 +8,8 @@
>  #define TEGRA234_SID_INVALID		0x00
>  #define TEGRA234_SID_PASSTHROUGH	0x7f
> =20
> +/* NISO0 stream IDs */
> +#define TEGRA234_SID_APE	0x02
> =20
>  /* NISO1 stream IDs */
>  #define TEGRA234_SID_SDMMC4	0x02
> @@ -20,6 +23,10 @@
>  #define TEGRA234_MEMORY_CLIENT_SDMMCRAB 0x63
>  /* sdmmcd memory write client */
>  #define TEGRA234_MEMORY_CLIENT_SDMMCWAB 0x67
> +/* Audio Processing (APE) engine read clients */
> +#define TEGRA234_MEMORY_CLIENT_APER 0x7a
> +/* Audio Processing (APE) engine write clients */
> +#define TEGRA234_MEMORY_CLIENT_APEW 0x7b
>  /* BPMP read client */
>  #define TEGRA234_MEMORY_CLIENT_BPMPR 0x93
>  /* BPMP write client */

This usually needs to be accompanied by a corresponding addition to the
memory controller driver. Unfortunately it seems like the changes
targetted at v5.17-rc1 never made it upstream, so I've queued them up
again for v5.18-rc1. They should show up in today's linux-next. When
they do, can you please follow up with a patch to the memory controller
driver that adds the various registers for these clients?

Thanks,
Thierry

--Bq7R2hPdkx7Mharn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIN+p4ACgkQ3SOs138+
s6HXzg/+Pt32PqWtDsespPZuvsrN9+Q2VO1sd3mIrkZIHBZFTPHrIEo0LSpJFuwB
4cjq/re93NRotAh3oOc9UbEhXLCq7sGMpUqFMiwvASLqLOJ+O1EJnokqyqrxXXlm
T407gBsg/+95avKFbgoOCC+D+5nK48HziZL1BLyFBj2jRbkFH08uPcHRWcj25kPh
ANh1sejoM+GIa7t6dARwh0jX5QdZCErIM7jCL2uHKH5dJawCclfNNv1qsMTqIol/
F17NEcLjtC3XrZ00JB6akE2r8iLdga0PO8QyE8c1REWTvwD3KFqkKorw9Tup5/u/
i0JzJi0dsf6yTT/IAPjMUOU2HlEmmbgHWkvBw4MaLJYlefq5/XQQgEXpcKYcPo0Y
y1C9XWyNfRbdn8yM6JLP5LHo8UdvNV1mZFZf+LMoQ3VbIcl9sbPRgvP7Sc8LoT61
1tDmq3yW9ViRj9XHdvlhDGt2yipDTEG9LLn6XwpxcOpWHAa/UuSLtEzF362YLvZ9
mZXAewuzIGWzOHxKT9h3F8rSr6J8Ep8pS2M4i1YyQwIS+CWhIdL5Q6OdU0QS6aaO
po2J0PR8FQ1PZaLnikMHz1/potg/8+SzmKrUI3HuJSNa2ImpDdU8+msJJLtimjLh
4U6UwCfQXuGhttj/rv3S4F/TTBlFhXV00TY2J6Ow4AAZ1R36raM=
=udsN
-----END PGP SIGNATURE-----

--Bq7R2hPdkx7Mharn--
