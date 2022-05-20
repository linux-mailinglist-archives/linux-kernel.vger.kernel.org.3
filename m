Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E409552EDAA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350040AbiETN7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbiETN7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:59:10 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750D2606F5;
        Fri, 20 May 2022 06:59:09 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso2619225wmn.4;
        Fri, 20 May 2022 06:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5eZa0fayDa4SMYx+6wD0ONhwsd4HQa9fKkyr7QWMWC0=;
        b=k3/0kKjUk2dOT1S2zRwE7evdJw41bjc5HSwOA3qxwlUVsW3pGpz6kzCA8fwMCnMl8F
         B0fRrfr/orTI94p7lfgMryAP4SVUryXMOkMac0ysGmxUqIS3AtgdjxnfdUWxzTwwLU4F
         QwveYv89kROphbeb45q0OkVL1aHAz8iqMI3YGiBCyunnRj9VOiCrurPYrccdBAjXXnSy
         MlHydGnp14eSFWb7EcP4RbFvghxvlelzoyFqCQmZ1mGfr0jXLdIZhAZAYleQ2338Lmfq
         Ur39q3bHTzkLYSq7Fs5QKWAgVngCyR6HcJrSEsVJbewa37UxlfB0ZSSADR0Iw50bFJkh
         z8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5eZa0fayDa4SMYx+6wD0ONhwsd4HQa9fKkyr7QWMWC0=;
        b=amvehbrbJA3TwEY3ofAuyjIL1CcyEEeuiD/g7caOoNwvFunsc8KERJ/pSMBwaeKzqT
         5QOIJ2ZF/718bv3hQ8ZZBKwDdYFlYuYaJOrHja0c9YEzi9KORdUDsyFigEcjhAu36aco
         BOplY8F/182Dj2E6zuYz417f3WMNClHKtQBMshXZEWY4FXUmzCYi8lQBRrbnlAk8Svjd
         36JZPbgxM/KY/eV2axhh5lBftvmcS+Tges+6/+cvCpMJuDLaZmUg3PWhkH5i5e0kcsMm
         2r3Me+kSenFQwn0bTV3u4cBDcVjIHlZekP2MZHvHpbmqHGXlJka3aZ115ubllW+lol+9
         Uu6w==
X-Gm-Message-State: AOAM533IfbZArP1SfwG7jn+GX+8CauOSUdnvds2Oqlwx37VwXGtThR7y
        s9OIDiHyO9JmXzbzJAOSBiw=
X-Google-Smtp-Source: ABdhPJxdfNjmatlz59N4VJk+ceWjvV76huhczDmDh4PbPHoFYSQaYeqedfLmGm2adCgNuDDQVJ6KvA==
X-Received: by 2002:a7b:c341:0:b0:37b:c619:c9f4 with SMTP id l1-20020a7bc341000000b0037bc619c9f4mr8915140wmj.38.1653055147828;
        Fri, 20 May 2022 06:59:07 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id d19-20020a1c7313000000b0039726196ad9sm2100611wmb.25.2022.05.20.06.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 06:59:06 -0700 (PDT)
Date:   Fri, 20 May 2022 15:59:04 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: sifive: simplify if-if to if-else
Message-ID: <YoeeqIDGD6q9AIp5@orome>
References: <20220408083007.41538-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VF2U9K2gNZBKelGd"
Content-Disposition: inline
In-Reply-To: <20220408083007.41538-1-wanjiabing@vivo.com>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VF2U9K2gNZBKelGd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 08, 2022 at 04:30:07PM +0800, Wan Jiabing wrote:
> use if and else instead of if(A) and if (!A).
>=20
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/pwm/pwm-sifive.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry

--VF2U9K2gNZBKelGd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmKHnqYACgkQ3SOs138+
s6EuehAAqLJlIb6miSHPhKIpKbfSum321qEsGFONKrUjf2saDwakaZKG0gwdIyDS
Ek3sNdMO6CRyKuTBQGHrWoD4NHarKtPCuGM/RgsR/dzcTcgWZ0006EPIWuOJbQWi
xLcqPHsEjbcHIOfpiE3FuIQBVKUng6gX2T6M8F2OXMMTbUlQObSx3U9DDhFjoXCW
BYERxGYmRBju9dLFkglwKUUBSxLPpObnRHSFRhWc9gmD9s0TaVr3HWNjReK2yzyk
HIQUavoNYC/lgvK1PPebcXdY/2Z2YKpa73MDEGNpRW7ogkBnWZcRzikWWCcK4hGv
AZ7WqqNqpiGg69WgmfoMLnvMifVMUIjYaYlo7dTcwjQRFMkX94TTBUUKLbVSwmo/
GmM8XSrnaiVSpBy/WchnnlyJvqoj0JxGbo7+qXQ9AoMuiAYTxdxc6IZnUqd7NeOy
Nawvnyv1XAoDCZdbvtssYSqSfEzUAn3qZjOhHA0sRfadoRdAnGBx3p9LVLqgRLPW
O4lRTpsTc/n7WgZMzqEUKYbBxCBysDo9DFRVFrH4NnnxaKNOTNeIorX7QvM1+3Pw
YItDly3Ihitb97JEQ8VC/eAnG3g5SUgz23SFMXCc5aAI00CoqEWyVJVQNtEh5lm2
P3c7+wkrhmJhqcCRRbmS1fw5H4qoVJq6c+tq4ajCs2abeCxaKEc=
=MadN
-----END PGP SIGNATURE-----

--VF2U9K2gNZBKelGd--
