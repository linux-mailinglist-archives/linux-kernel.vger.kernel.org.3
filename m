Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB494C3080
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbiBXP4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbiBXP4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:56:49 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584DA1C60DB;
        Thu, 24 Feb 2022 07:56:18 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id d23so4593807lfv.13;
        Thu, 24 Feb 2022 07:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jxgwod+cjKF0cMAJ2EBnyYhyhK2ZuDAR5dbHn7cZPXk=;
        b=e0C8B4o5e6PB8M5l1Tjy3WOI8+vIpkflzmaFjVAKz6E2CsUYjN+xl60dDhP14Q0/Aq
         cY9LS+LKkU7QOP7gKmyHlAGCf+4a4wnoe/EpWa4wkcKycWvp4CqDWdTU2NOk7OvMDqny
         2s7J3iVZIWz19QbkIwQnbZdf5x7DpB+im6Ihh9bVekOYbvuOdlLu0sUapKXdYiYCQd3e
         F7TSvUKDm1DI5U4LeGP9MNobObTORkZil13+1X02okcnFgmhwrEh0Bu+JDUhY/aiMxZV
         wRknmwdz1LWjBPVG4MY/Ky1Rcgv+iWyWR/8pCNPsIRxr/ZTOeUlSwf9yt/DsN4BNV/nN
         mZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jxgwod+cjKF0cMAJ2EBnyYhyhK2ZuDAR5dbHn7cZPXk=;
        b=kb8GMgRKTNLCNFX+1PNh1DpyKFeFkwQQ3Kub/yVh3csWg8pCuUt3vGFmoyRFX7pGXm
         NVIxXOCooaAjp5xrRkdP+eq2zKrgIFltWrFIebdwdxsFlK8u+s8VYiHiHZc+2OWijrZL
         uywMypISnBkcaYjRjR3e5pd5kI3B7VPe7XGcS4BFmAVjxff9yjvH3HI5RYXMQ+gNDhGc
         KPRvXi+XG4dm/Jd7tlAnD0g2lwTh4lRw4486c7tnzauwWSTBuAuTAiwfvMxGtPWRwHWd
         zVrP6E38pr81H6EUES5OfCGw7GtwUuv8bxIM8j5IjH/AkievIMF/mLhDdsMpxiPZ7KGF
         t8Pw==
X-Gm-Message-State: AOAM532KwStynrie8DJ79069a0zfJS5cMMnpVQVCQE67UUqygYKcocoh
        Y/ImyExuEfPyon8p7qqVP/Q=
X-Google-Smtp-Source: ABdhPJzaXZ8qcjNBoF7BIApIIdH26xRybKIPiTiVeuInTO23K+HAxK1nPPGw0ctm0nVZ1ijP5CbvgA==
X-Received: by 2002:a05:6512:3f17:b0:43d:8e7f:29f8 with SMTP id y23-20020a0565123f1700b0043d8e7f29f8mr2099730lfa.609.1645718176505;
        Thu, 24 Feb 2022 07:56:16 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id f39sm233996lfv.302.2022.02.24.07.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 07:56:15 -0800 (PST)
Date:   Thu, 24 Feb 2022 16:56:12 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Robert Eckelmann <longnoserob@gmail.com>,
        Agneli <poczt@protonmail.ch>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] NVIDIA Tegra ARM32 device-tree improvements for
 5.18
Message-ID: <YheqnF1CgQTNgRs5@orome>
References: <20220207212826.10307-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TpGEX/9APYzb/M4O"
Content-Disposition: inline
In-Reply-To: <20220207212826.10307-1-digetx@gmail.com>
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


--TpGEX/9APYzb/M4O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 08, 2022 at 12:28:22AM +0300, Dmitry Osipenko wrote:
> Here are couple minor DT improvements and enabling of HDMI audio on
> Asus TF101 tablet.
>=20
> Dmitry Osipenko (3):
>   ARM: tegra: asus-tf101: Enable S/PDIF and HDMI audio
>   ARM: tegra: tf700t: Rename DSI node
>   ARM: tegra: paz00: Add MMC aliases
>=20
> Svyatoslav Ryhel (1):
>   ARM: tegra: transformer: Drop reg-shift for Tegra HS UART

Applied all four patches, thanks.

Thierry

--TpGEX/9APYzb/M4O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXqpoACgkQ3SOs138+
s6EJYhAApMCT89bKrNdY5f5zz04hJj8rlGJ86IyOYP+JVq1micAqhS1mOX/3fFBQ
zU34ZBzlv/H4B7cxnUHm4//mm74c7KoLo3TtQxhOyAFOEtqgtkYm7xhlBBG4sWTO
JHYfSnYk+Ljiok1tVXG1tjcTBSNe3nUPAJevgVSVWvqx7h6FwKvfx0/3CW7yRyYz
xLrjj426ORsnK061VVrSC3Oz7Ngf/W152xp+whvc398adDRzoRxa3gG8imfGuT46
jAeY3AdvOagw8ps9egLFYqHe2gz0/SCW18AYEA4bggrbh9mo9Pc2k6Eccz4jOyTO
0sTk85Pvb4monlnNYXHFBRMxO2X7Yzx173nlsp6f10paDAbROCP4NCjSCQV+KAiv
VhMVpeRRO5s8GbXKCJQCK7cdL6roOZmX7H33EQUAbf7A1VLYdqjn725cGWy72NZk
TolbrF9RFGXCODRYNTfH57njAR9WGD8+AkwQtynLADfS+TUpBwq+XsyNk0JVjYWg
+ZPbHqfeFDhLgTnzOLrmJfd1zGmd+QCZpLE6VhykQj6ykhnXhzzYE5sdsk79xfC+
fkTk0YbXXp1Uj8LqmnNxuM8bOnQFHJLXN/gGTDMLlX35XMx4Q4u863tV0jUSEF8E
iITccdHwwouoyX/eZUjEWoqjs023VkDTAUszuC7jzKwDv/++kAU=
=PN3i
-----END PGP SIGNATURE-----

--TpGEX/9APYzb/M4O--
