Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0015844CD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 19:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiG1RRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiG1RQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:16:59 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E766D2E9;
        Thu, 28 Jul 2022 10:16:56 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z18so2974508edb.10;
        Thu, 28 Jul 2022 10:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WFtWtuh4fnkPdW4l+mTBk7hWyaNDh0oxtPhJEC+i/84=;
        b=mhUHLFc7PT3U4HYxgQFlnVqZTq1Ncla6olvQcGYF/KgGYSydW12nVxFSsvq7lHwMym
         HaqhYnRgiKoU0XaRRnzLHfxlh9CJZLyAXgREBHnHnUWbsx3CnJBimbJGNe1nm9wooQUi
         K2AbHh39RvrZUV7w6IxEc4ylqoGjYwdnUhBU5OGhrIHFzKZR56cqqA3YSNhk3tMwHIeb
         wUPyz+0PzlMocNPTCCR2TL+R1aBaA9OttKhKllwY0EsCeG0iZVAndp8RB/JQg8gUDKrJ
         zOJjExJ/alzglDemntATfSO5c0eLlJ82VTG52/V6yvRkoDFKh0KIEPaI4fW/QRhUMC4H
         s3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WFtWtuh4fnkPdW4l+mTBk7hWyaNDh0oxtPhJEC+i/84=;
        b=CsRQenISdjoc9bwboswXAjl9d1XvHBnqLj50W1VGwA1B5MV+TbHHf7CmWkjVw+cc+C
         sQhuR1h7dVMb4alQXgePIvs/Z2ZcSzlfvMIjuQKbMcgWCttHjbjsS1/rWhRqY5dTpmk3
         m+2Yu1msW6CdJh5EBp6EO+6q0lsSu3EPfldnMfZw+bRKWQGGqdOiv2ClpJjW3m/5Y4Zq
         HPDelYvMLc7iZqLSg/o4n4GqoKkxEERHhswfiwdEgk71V3ynXQ5VRPXtoeNGTJTPN3Y9
         s9MOiTy3evW7uVb+7M3WsRmq29elAye9HaKAbTVtb0w/WwPgJRtCm3X2MCRkeoiOhMA6
         EMEA==
X-Gm-Message-State: AJIora+nH3ENNVoBn+0c/MiV7qmrnoVK5y8Dfce32vm11RtRk+dkF+hO
        aoes0WNho7+3qrX+f7a2cT8XWUAmKCA=
X-Google-Smtp-Source: AGRyM1tTwXpA/Wc9we8MBkI8tLc76dxU0UXWlwM7ydG/dxXSNEoBbKsnKcvY1iuyxub7SKq6sqiVUA==
X-Received: by 2002:a05:6402:26ce:b0:43c:e187:881e with SMTP id x14-20020a05640226ce00b0043ce187881emr4212004edd.408.1659028615162;
        Thu, 28 Jul 2022 10:16:55 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id gw6-20020a170906f14600b0072b2cc08c48sm626801ejb.63.2022.07.28.10.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:16:53 -0700 (PDT)
Date:   Thu, 28 Jul 2022 19:16:52 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add include/dt-bindings/pwm to PWM SUBSYSTEM
Message-ID: <YuLEhGN6xWihUhfj@orome>
References: <20220613123319.22964-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J1595YusDGLAFwXx"
Content-Disposition: inline
In-Reply-To: <20220613123319.22964-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J1595YusDGLAFwXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 13, 2022 at 02:33:19PM +0200, Lukas Bulwahn wrote:
> Maintainers of the directory Documentation/devicetree/bindings/pwm
> are also the maintainers of the corresponding directory
> include/dt-bindings/pwm.
>=20
> Add the file entry for include/dt-bindings/pwm to the appropriate
> section in MAINTAINERS.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Thierry, Lee, please pick this MAINTAINERS addition to your section.
>=20
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--J1595YusDGLAFwXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmLixIQACgkQ3SOs138+
s6Gz4xAAvZ7zh8WZv9Il6FFdSzNueVcjcQVVpdvi8MvCni2fSe48DKgB4gzILHhQ
4Z+LmXsVHubSm700UiVMZbnRo4G05adlws4Urpr0McwkTsQIP2HHIGl1/6WgBZCe
YWUVVkgAQF5lJKTkI5qr08aKZvf9veAlsVsnJ2+ootLvY8q3bx/6BY0iVF9L/AgM
Xm3xKiL3bB+LfJJJkG8dZWilNEjnn2NCfYW93ZEVWx42dnaic/kGmX7JRSrx5yCL
8kwewFw+718wYPB4DJaPTRLsdZCtzRGexdu0SCnLr9nVfMA+Aemj1fkQvqwCWNfY
Kk27ErsjUWYa/Wk7GlgBS1Vw6mt2zTA+knpAstmC7rK+aR9l6ozCjvGvg3ojXYhx
rpzDNA7Q19KmJ0utrLORUB1DASeqakgvqyPK11w5DcZTu2ixbdJ4ckRr/yxm9ghG
NU6DbkIXVvk+Mdf5hGVAu/elSK3ACE5Z8GwJ94ubt26+B+dESKCZVA3fYA8i98Sd
OPeTqBLLiH2wH2hbqjOkYb6kUoOlwFWwKgmAeqR8o51Xmix1RJBNd3b9ZwfXMhI4
dy+2jRCNcVSDjb6LV+bjCv3TZ1pH/kXVt2iC4lxzf9pkC9ilGh1RXSv6C15ci1rN
EA+97UIhiiS/gYi957y+u0k6jlWcvkO9TKkGXSTIgUs2aWMBYBE=
=AoyE
-----END PGP SIGNATURE-----

--J1595YusDGLAFwXx--
