Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC63F4F644B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbiDFQAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbiDFQAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:00:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB018267AE2;
        Wed,  6 Apr 2022 06:29:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w18so2584119edi.13;
        Wed, 06 Apr 2022 06:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TAdeF2TjriYBubCkF56f/a4F6IzUVPXVaF374OCOr+g=;
        b=nm5+Uz3jFsJmZRbohcag7axU/fqDRUmMfmuNSmMCb3sbGQXPLqO8fa83S3FncyF0ae
         e3LKkKqYT0U2koDU3HBQdmTH6rHMrIueqhIPnWfe/rC2469rnLbYsGaiWdiBUqgwbMVu
         q4FC2eLFPBB71mB4FvSfkAX/yhItoGQmi31rHN53DGzIzn67zZJityb2HssRrEeT8ZhN
         T6NHwh7dZFCkiLGFlpT3nGpLuyvLLOUZ2flY+wYzLFObiW54fHbP3zdavPUq2jTDsFQb
         Z3cj7kDkQrgjJr+8ikAqGpZaCX9ze2eiIf/LBxeWYx/J1Iqh3jF6ZFouN+/OJUJfoCh3
         ZTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TAdeF2TjriYBubCkF56f/a4F6IzUVPXVaF374OCOr+g=;
        b=O7mdIwZSWQCqp2z6Nc+Y5pAZqqOkkZewVd5ZLC033QdUGw98v48eNkx5o+xKrPaefs
         BUOXP+jcs2eE9tKTINDXud01GwYln8SDnWDsa+VYvWwBBFLoGdObxL1wN8FrkJpJTJv4
         Eo88NGOezb05kkK0NwCTwn0WCg7PNSRE2VFOGCoX3skq7TL0nY1i2RKu3Xg6egQtcweM
         5zXO8T7rNue0fp73P2bclRWSTP+8S+uQ2/hhV0HI/N6oK/FdnDPg47ZNCE4uPk3RhPyl
         HftRKJL7Y0phSm6NqVpuI+/TC6CZLXYwJHhoYQsWs2B/SS4TWsFp3g9JuuYRFKO3xi8d
         L3Yg==
X-Gm-Message-State: AOAM532Tu4CezK3vTz5Z97swc6YgQho7jYIbdMFe77YkUdi93sWtbsRP
        tL+6vhB6TIviwfpLQX6kdAWMDEpeE2Q=
X-Google-Smtp-Source: ABdhPJyxrMLxpjO8TG9CT0XE8GKGUPikQnbv7Tsq79lgvao0RSU0reDO/ELn0YcjEDYYHC+X42cUyw==
X-Received: by 2002:a05:6402:3586:b0:419:6059:f016 with SMTP id y6-20020a056402358600b004196059f016mr8826650edc.402.1649251752205;
        Wed, 06 Apr 2022 06:29:12 -0700 (PDT)
Received: from orome (pd9e518f7.dip0.t-ipconnect.de. [217.229.24.247])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906059100b006cee1bceddasm6574320ejn.130.2022.04.06.06.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 06:29:10 -0700 (PDT)
Date:   Wed, 6 Apr 2022 15:29:09 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Aniruddha Rao <anrao@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: tegra: Update SDMMC1/3 clock source for Tegra194
Message-ID: <Yk2VpQIwzlgifZ92@orome>
References: <1647423885-2569-1-git-send-email-anrao@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yzJg/fPTiwoLiQ7o"
Content-Disposition: inline
In-Reply-To: <1647423885-2569-1-git-send-email-anrao@nvidia.com>
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


--yzJg/fPTiwoLiQ7o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 16, 2022 at 03:14:45PM +0530, Aniruddha Rao wrote:
> The default parent for SDMMC1/3 clock sources can provide maximum frequen=
cy
> of 136MHz for SDR104 mode.
> Update parent clock source for SDMMC1/SDMMC3 instances
> to increase the output clock frequency to 195MHz and improve the perf.
>=20
> Signed-off-by: Aniruddha Rao <anrao@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied, thanks.

Thierry

--yzJg/fPTiwoLiQ7o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJNlaUACgkQ3SOs138+
s6E1ZRAApPt7A4HspHmQwlsLJTZszzIlX52I3vgwqWtfK1uUqlN8Bnpqtu3xFTGO
xfTZQv2Aro0JcHb3/pF1My0qWELyH6hrTd9jIpoLjTIavra09yVRTDhaKaUhS3D0
lOBuKNcNr43jm38ZmvM5VPQe8bsz26NrYNPj/B4ku1kqv6ZtuNNSLoZD8UYgJRGa
7OVr6kXfL3LIBtCnsARm+gX6iNE43T1UQ6G+AVn1upe+u/M5G1SU+Xo6uMAd9IyY
QkutGisxSe5948t7TMvBcatWGMnhzHyGLf42Cbj8WWJFnYSQfnRHB7ay0HOmOakZ
sGSsTsnTZqNW42bGBL76dkREROokoGjMfkAmWhDNxg/ClZ93AMe1N8VSCg8yWucI
vwuQ2cOviiBfRJUnb5IEkq3DHA6lQWtU14WTEV+UA7MQawlwv7z/i6NQiIVLztkT
k6t7yaJYcOyka8Da1fecfPwVzrTXkOniyLMyxA61nTuUHhv03dAt8sJWBFKVwT1k
BuDDBkv1sRa6rpLWqAT4i+QEEUQtEw3yN/we91ldtej/bJx+kAqYVGGx+3I4pKKE
SVo/v2LutumGDfBNBE7Fem5Soqhak2YEid/9vvzpcXgkDvsu3TQ5tpNWxh/pnRKE
pAaxqBI8WXBXcyaQ+v+ViOZ7A23W3BVVHmZPDG34ZAtWG2s/zbk=
=CDQ0
-----END PGP SIGNATURE-----

--yzJg/fPTiwoLiQ7o--
