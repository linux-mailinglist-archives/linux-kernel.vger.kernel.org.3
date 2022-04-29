Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD57E514440
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355469AbiD2Idp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbiD2Ido (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:33:44 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052382D1EC;
        Fri, 29 Apr 2022 01:30:26 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r11-20020a05600c35cb00b0039409c1111bso3371962wmq.3;
        Fri, 29 Apr 2022 01:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pzDYNwcRZ4xAFfG5Cz0HtpoBKw3iwLWN7M+n1d0ufeI=;
        b=L8JNNIx3yL6+VPvirGGQfG5qEMQ1L62P6RU6cfo+ET1qnp9ksDOTWT3fiipiXeJgrC
         165TQypRVyR6TKKwo21ast7aeHHtC6S7D7IuG3rMeY8bGhzN+oqBqqid5VCol2ad34vG
         AJSPECgTJKJgRvMBz3C/uANTCdjeJTuWVd2Kfnf8ki104vtjdqXOhoTQ7+Q0+VzE5WmT
         +qRvOH6W4PIE/6lbuq0ttC5gfJq4EgkI6Cm2auDpFip3szwjLfsviJQMbkwpZ3w9X2L1
         ozYUQXUIdFBq6Eev+QvltiGSWL4H7de+9K2JoStuCN+B+AmqmctHxxAPuwZhdyrI6qah
         ytfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pzDYNwcRZ4xAFfG5Cz0HtpoBKw3iwLWN7M+n1d0ufeI=;
        b=1lAt07AXahIq0W1E2TtvsqFlOjp59o33yajjsCZeq25D4xFqnrQsNhFdljmXTOjVWA
         l7RO6xyLODKW+yng0HLMJEBOdystWJf8D1sq8N13g+L7jIMwaYPgBJsBTrujVoEM6GG/
         qrik0loIzkEfo0oQeZ/Q695mHIp4fvduETvFyPxBPsfsOVKaCyAmLNtswORMbihL5DSQ
         I4N/oXrZtRKb/2XHMZQeeYtrE2vVOVrzkmj0Pkkl4b8glj9xwbZJyubLEHXlV23sNs6k
         768ttRc7EnEpaGaSn5Wb6x69ZmpFedxNvTcZSEqcTz5eWN8E8zYohY/RJBQiLuT6AXmb
         GmFg==
X-Gm-Message-State: AOAM531LlghyvoFsO1vZSUhF3sxKE8VLzbIPo8+07Gf6YigK0nxTRdPI
        g3QtZmC2wzSYzekpJ7lNcTE=
X-Google-Smtp-Source: ABdhPJzqmWhXIVHuMO4icuvn+TWAjrx7f8ORX9ioFZoS1EiScf/chJ6leIztpGIQtn9jusgj1+wLhw==
X-Received: by 2002:a05:600c:a42:b0:393:d831:bf05 with SMTP id c2-20020a05600c0a4200b00393d831bf05mr2037974wmq.187.1651221024463;
        Fri, 29 Apr 2022 01:30:24 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d598a000000b0020a9493bdddsm2115152wri.40.2022.04.29.01.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 01:30:23 -0700 (PDT)
Date:   Fri, 29 Apr 2022 10:30:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ashish Mhetre <amhetre@nvidia.com>, jonathanh@nvidia.com,
        digetx@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmitry.osipenko@collabora.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, vdumpa@nvidia.com, Snikam@nvidia.com
Subject: Re: [Patch v9 1/4] memory: tegra: Add memory controller channels
 support
Message-ID: <YmuiHHcdrtI6zry9@orome>
References: <20220426073827.25506-1-amhetre@nvidia.com>
 <20220426073827.25506-2-amhetre@nvidia.com>
 <2f600411-d40e-c4e7-fd54-bd15546bf71f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="InxfpUkPYpig5M+G"
Content-Disposition: inline
In-Reply-To: <2f600411-d40e-c4e7-fd54-bd15546bf71f@linaro.org>
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


--InxfpUkPYpig5M+G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 29, 2022 at 09:11:59AM +0200, Krzysztof Kozlowski wrote:
> On 26/04/2022 09:38, Ashish Mhetre wrote:
> > From tegra186 onwards, memory controller support multiple channels.
> > Add support for mapping address spaces of these channels.
> > Add number of channels supported by tegra186, tegra194 and tegra234.
> > In case of old bindings, channels won't be present. If channels are not
> > present then print warning and continue so that backward compatibility
> > will be preserved in driver.
> > During error interrupts from memory controller, appropriate registers
> > from these channels need to be accessed for logging error info.
> >=20
> > Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> > ---
> >  drivers/memory/tegra/mc.c       |  6 ++++++
> >  drivers/memory/tegra/tegra186.c | 34 +++++++++++++++++++++++++++++++++
> >  drivers/memory/tegra/tegra194.c |  1 +
> >  drivers/memory/tegra/tegra234.c |  1 +
>=20
> This does not apply, neither on my mem-ctrl-next, nor on master.
> Probably because tegra234 is somewhere else (Thierry?). Either you send
> it without tegra234 or it goes via Thierry's tree.

Yeah, I can apply these on top of my tree and then forward the whole
batch to you or ARM SoC next week.

Thierry

--InxfpUkPYpig5M+G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJrohwACgkQ3SOs138+
s6GfSRAApRH/MkRUeG/toIfujLJ0hKvdYYF7NncuPtFa8HVN2uJv38YX5v5lokPF
z+z/AJx+70pQn17T3A+VdbJNsbIlNrMKWZi/O86p3+82MeKD8vuvXYOLa/xD1Wiy
hmObIWY9XjgAEdnZQxySa2QXJ0lcZVbKctyWWYty74AACxonyt9ovCjOWJ4rbXhc
Wwa5iq+PQ2O7t1WZD+j7ct4k+tvnq6WNa2KuANMFDQehf6AqmdVkJ1eDOrf/Mp1u
DE8cQZBJLY6HZh+ib7r3DTs6kbDxFP348QOsrnhHS64+SHQIg4CoBN/5X25TRfaZ
Qs0VJF/UVUe5hu2uRyzQx2XB3yxC9oYZxfGP8A0Nf6U4kbbb3DaAXOnpLsVLHWfM
rr3ugBy9sl6XHEhcB0l4bKHEdcPjWO1IndY+zWk5KnVqJBoI2fqjNAGQTiOnfrvY
67M2KghYQacXIga7QZ7/4B0CeMVF44/n5EpkcDOG1XifPS/RbRn5YjhURpIIyrFf
gVoydKhmPC3ymjl7dRMYJ77hMAJloBRSWZdmuUvhndJXzG2tmP7DIQv1zXVqI3TZ
Oz9oRYlaUYDTYeANA9retz6n0lJaktBp/KhZMr9KaOKofuTVnSzOywyhorSFRYN3
TB7XE9wmBgy8oK7adQULzIFX8FmTrkMGRo7hNF5Lo4l//jKwzf0=
=hOUr
-----END PGP SIGNATURE-----

--InxfpUkPYpig5M+G--
