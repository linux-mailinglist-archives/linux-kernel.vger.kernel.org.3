Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32FC50BC30
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449648AbiDVP5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbiDVP5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:57:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532DF237CE;
        Fri, 22 Apr 2022 08:54:48 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x17so15014465lfa.10;
        Fri, 22 Apr 2022 08:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lks2EMkJckKXXGPYQAgtI2m89X51SNXNx9xbd5ZHWuQ=;
        b=RCNN9kyQCGrAsGwyCpavddgEtmbY9NeuE4Ot7kXpayx0n+zJI3lsI2t2ZO2EJFl5c2
         sHK53YgOIlt6ckp0cZbPr6vfAmIMg7odXi4ueWZepSa/bSJPEUEYU2tmbuOMgYTh8QWN
         dD8qYrjW5nH4I9/XgVeFtd9GutaSlGxrewRSxVwS4EaJJfilF6Qsl+4kPxuxsyOQ3DT7
         XEZlBoNHQ5u86W+Wq0TO2e3QXnGrzD75ca8cb7JE78OFFhDiWzVvQtCO+BmHhyrRZ0qu
         qHeedafEFUp4Qw/bXtmYn0jCL4Hx8yEJmkQj2kSqKiQbNqKjRtJHB+v8OZcXnp20B01T
         0/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lks2EMkJckKXXGPYQAgtI2m89X51SNXNx9xbd5ZHWuQ=;
        b=3HsOo9PPWykQoAxyA8zmsUyjrlHFECvLud50tzg4mOPb2RvZ2Sx9pUbu7RnGFnFUwe
         lXkpz6CjuR4vrgfqCBJdXV+he1C4jWQ7PSLelM2JN4vVEcyrIOKcANg0okipqyuGWi1i
         3rR/XSxKvmRVLHdPkxVJQWJoK3Zvdd9oCy7FOxyKvj2Q5NHPv9uGUjGOZ3y9ogIbKumf
         77AyiFM1fvQC5uKe7vA67VIeZUBSOBxjSgJQhzl9RPQ6kDgtHumJHCETKLJH59hTMipy
         XinbljZCUvcReKWdduOyCEWOUJ538Kb3tErxJw0O9z+5NEx2zl/9qxPofQA3A1gWFG5s
         GamA==
X-Gm-Message-State: AOAM531yPW+l4Bhrdf10y/7kXnKqKwve9Rx/k4kPm9TUe30dyHoByYuC
        9ELHRNI/j0lgajFZxA1TakuziVMJsK8=
X-Google-Smtp-Source: ABdhPJzr+3Gb2AIG7O7wrQYBlHeGFDGlNWyVADyEhW/hlpfcokuiZn9eYXUjmLhKsBDzcqhS2x/4CQ==
X-Received: by 2002:a05:6512:3d14:b0:46b:81d9:b9ee with SMTP id d20-20020a0565123d1400b0046b81d9b9eemr3542774lfv.109.1650642886407;
        Fri, 22 Apr 2022 08:54:46 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id f4-20020a193804000000b00471a32f8f72sm264901lfa.229.2022.04.22.08.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 08:54:45 -0700 (PDT)
Date:   Fri, 22 Apr 2022 17:54:42 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     paul@crapouillou.net, robh+dt@kernel.org,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: timer: Add PWM compatible for X1000
 SoC
Message-ID: <YmLPwtJYRE+qI2oJ@orome>
References: <20220224234133.15708-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wslXXE2EBCJbUgwQ"
Content-Disposition: inline
In-Reply-To: <20220224234133.15708-1-aidanmacdonald.0x0@gmail.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wslXXE2EBCJbUgwQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 24, 2022 at 11:41:33PM +0000, Aidan MacDonald wrote:
> The PWM hardware on the X1000 SoC is almost identical to other
> Ingenic SoCs, so it can be used with only minor driver changes.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
> It seems Thierry picked up the driver patch separately (thanks for
> that) so here's the DTS changes on their own. Would've uploaded a
> v2 sooner but I was busy the past couple weeks and couldn't spend
> any time on kernel stuff. I guess this isn't a v2 per se, but for
> completeness:
>=20
> v1: https://lore.kernel.org/linux-mips/20220209231141.20184-1-aidanmacdon=
ald.0x0@gmail.com/
>=20
>  Documentation/devicetree/bindings/timer/ingenic,tcu.yaml | 1 +
>  1 file changed, 1 insertion(+)

Looks like I also somehow ended up applying this snippet, though
possibly from the earlier patch.

Thierry

--wslXXE2EBCJbUgwQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJiz8IACgkQ3SOs138+
s6G8TA//aNfTdXlORXO6PccUeVulC2D1QRHujiQBe2dGOgoilLVkRc49K8fHizPf
sOQ3ALFaibR6O1A9WjO0DuIQ//l/gt9NlTsuhFzklL8wkn6wy+lPEeUWpEyks+f2
aly8o9m7zYBNhIDcB3M+t9DQ5YhrU5MlQRwDutupWSs7ayW2PrWJEsl7OoL2pjLM
Y2M4JkcGD43WoYQsAuJxn+ZKYWC7pT7PeaO3sQpt9+/UzzFP9NWbSubVpfESNSE+
38vmuytaEZtlLsnwPUJcf5xR99DmyEfIFcrlnxHGY1l9AnpVbAKGygtTE4l++Xrp
LrIPob/y6eBC6J0BnOQ2hNBMNxxs6kL5smFgGPw+YlB1kBsYNLpG6RUBxsF6dv1k
t0kVKYuiSojMF682A5ga1KUHPqL/FXAFpqT4HrciqHN8AHymaR50K6kMIybSNn6P
gUxHr4hPDsaqmDDfyrnUyle+UbmCnP9TuHsikNj1LMgFXT7K58BYpM3uisLDlPap
IMxQS5JizTulZ1Db+u4B0hgRk2vA0u320XGbP8Wf2wlvqxRaGSfFgDNo6WSzA3mz
C4Ip+2eUjXpmAv5Ly91KYRvcOLWQ42glDhlNbAS6u/bEus8jN2isum9fXv6ctNeB
caeel3DG+SZIAAs04/lEtTK2L65SyjLOXkw4QyBfegt/qMF6Tfs=
=SaPD
-----END PGP SIGNATURE-----

--wslXXE2EBCJbUgwQ--
