Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00304F647C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbiDFPvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236646AbiDFPuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:50:01 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8D72CCB0D;
        Wed,  6 Apr 2022 06:08:52 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d29so3105668wra.10;
        Wed, 06 Apr 2022 06:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EzPicKvhciEAshSHE/waFTsLkuf/DuXzcy4ZuAGYnOQ=;
        b=ZYv5p3MjHvI8UrhE6y/d5AJOhKKDQVlCHSNdip8u3z4CcvBJcKQ8oD6c1RWTeExkK1
         v4cjRoN/i0pYgQkZfJlLDo2EfdJDgFu7rGHeRogFVEfkgRN4Z4oCKOOUJCf50s0uRjjS
         LlOeu0sDQkrNbfcjpleVjhFwDblFIE3EP22lt9x1QV9I9/t9Btk9oGzNXLS3Jwm5Wb88
         oFe0tO+M2YWSYPnNhCnxARmvOCqYhrwHblygkyDSZJsJO/t8OxGg+vSUfNs3ev1RdwpA
         a4eWqeh0gjhTzsUs1gIE1GYYiz59nAenynDYpUlIwXrmMgY1Uukv8orchLBAQ2QGPzVc
         5jvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EzPicKvhciEAshSHE/waFTsLkuf/DuXzcy4ZuAGYnOQ=;
        b=76dFYriHvVvlGiZm5dZP6G0T4lR8XsXCCTgHlDybu5+NuIoKVzE/B1gH8cybGkyb4C
         nCT1dp97/LTzz0r+JzFhgpDO6ASS8yuEAvHEedo2glOnWEI6qHEvWxHYJAAVuhZmiTBx
         mtSvlevSkOI3yf27hG+w/3CTgl0vwOOVXC4yZZX9hRPantb5N8/Y4fRMsZjoEYwWE2qy
         k9UgwNNxj4lnmFUdzg/q9VC8Tmb5DCKUf3jnc0gFS7zcY+zf5wib2WLdujM55YN/cYkE
         8CQntxTkLKlD5gb7qYSMNXROSdpOeGAtUrjf+ow4wrhDRitnDbvKqy2Iijs5chjCSSrl
         O0ZQ==
X-Gm-Message-State: AOAM533pDugwQ2LTWvTyd7nfBVLbrYJljrBZPSO+/iENn4oqOYkqc4Om
        xaLRsAdEmEHjAJoYoa4YzzYGIaiOPfY=
X-Google-Smtp-Source: ABdhPJx0Yr5teJaPktbkGEyUw2tv218TFtm8lcAFMNVMPKfCxv/8tvYndt0yGBd8nPkC8ru6DeBr6Q==
X-Received: by 2002:adf:fb0b:0:b0:205:dfbd:8601 with SMTP id c11-20020adffb0b000000b00205dfbd8601mr6302576wrr.527.1649250525257;
        Wed, 06 Apr 2022 06:08:45 -0700 (PDT)
Received: from orome (pd9e518f7.dip0.t-ipconnect.de. [217.229.24.247])
        by smtp.gmail.com with ESMTPSA id v18-20020adfc5d2000000b0020589b76704sm15184511wrg.70.2022.04.06.06.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 06:08:44 -0700 (PDT)
Date:   Wed, 6 Apr 2022 15:08:42 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH] gpu: host1x: fix a kernel-doc warning
Message-ID: <Yk2Q2kcgrECbhAi4@orome>
References: <20220403225354.2492-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9J87IkycnimcbG86"
Content-Disposition: inline
In-Reply-To: <20220403225354.2492-1-rdunlap@infradead.org>
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


--9J87IkycnimcbG86
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 03, 2022 at 03:53:54PM -0700, Randy Dunlap wrote:
> Add @cache description to eliminate a kernel-doc warning.
>=20
> include/linux/host1x.h:104: warning: Function parameter or member 'cache'=
 not described in 'host1x_client'
>=20
> Fixes: 1f39b1dfa53c ("drm/tegra: Implement buffer object cache")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: linux-tegra@vger.kernel.org
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> ---
>  include/linux/host1x.h |    1 +
>  1 file changed, 1 insertion(+)
>=20

Applied, thanks.

Thierry

--9J87IkycnimcbG86
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJNkNoACgkQ3SOs138+
s6GQ7A//U1t+rjKiIEIQmxmnfruDLVKJ+IOn6D45CGb52JfwVSCEK+1JC5Z3V7+a
owzbWNXmCh33rHIf4wiXGZYmlkXcyjYCowBMDGsUejA+eVlQzo8H2eiNfovPkBFB
M+UY1gB0T1KbzEpDO5i9a1tBfy22P38pV19sxN8EKkq0pwdFXKwwQ3xMw+SC0e7L
jDrWqJgp4pg1H10+GlHM8ipHOhCx0QNcYae9T1vTsToa56gmOWadGnHqUHUhb1ES
KjnpZg08XPq3fcw/AEzir4SZqfgx8O7MJYGofzZOnXoztNoH9ytiiPDfY5CeQy2a
ExDOgXX+hckf0rr2uIJWvqxklDAt1QkIaT7+68MMh/kuzEwNdmyXBcOzggrD+IlQ
xk56pa5abrdxWgb9p6E4CKyjvTAJ+puc30jbaZLG6T1Deh+92dBJlMyLDVcaprqQ
spqZjMe7uqEfR32Wm9b4K59HdTiacvBTfUbTgmdRazHlTJ9KOQpL+xtnU9KqhMmu
h/ahj7DYwXSkt26G1z5rPcJ6cp8tO1pjHcZSaIWxfXJbzYQ/EikyYn4p2YTEPBak
kOkev2jc09VAKLUxn5NA3TK5lwHRu42IBRaNWn8odtvjDTWFYwSDSr+KOIX1gy3X
aRKKkrkteE1wpYeWhVxv+B5CJiOs73jXDsoPtlwZKA35Xtu5SuY=
=xxNp
-----END PGP SIGNATURE-----

--9J87IkycnimcbG86--
