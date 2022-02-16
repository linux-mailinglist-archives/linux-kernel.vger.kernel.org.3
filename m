Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AD24B8C9E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbiBPPic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:38:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbiBPPiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:38:24 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF392905A5;
        Wed, 16 Feb 2022 07:38:12 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j7so4550137lfu.6;
        Wed, 16 Feb 2022 07:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KEZW6e1efTcHXRh6WOqzjxq0RuH5M2wijF9L7JfBlb0=;
        b=lhN+u6rCCCWeY4ErTHiQQ6smARxvoXiYx0KnB3kfEJ3IZU3/hgmvYlLFI0Crpeuot/
         6BrnFa3COa5yYAJ4z20etbqs4O1PKRaapkD8cnnyzYIuEoatIloGsTlV1iHoHJPdQzBD
         lxnvDtGjYRzXv3vUNjrhHSV3c7PmEmFKocPXj4InLNACCszd8VosHmj7teIm8vpCkMwD
         yBYpKiF4BaUYX2eh69aJCBf1raHfbKBGZUpjLH+UWOHuA0nVFod2F+yq7ZqkmfuJRJTj
         xKKQbnC4rjbtgQTczAmKh4CvYwolLOo4AH96vGDlhRVaGZRoDJ/NwLyyS9UIAjPuYNRR
         qq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KEZW6e1efTcHXRh6WOqzjxq0RuH5M2wijF9L7JfBlb0=;
        b=Dq6SXpnJe0QvkW/lRdv6XNnTMdv+MO6lttirdtNdyW5UjT7akXmY8417IaNs1JLnFy
         5nxXAWV/oeiTcBqfmH87FJVR/vdxjQ2MY30qcpzYcKjlR9r4FBlifQkklLhbbgzNxzTG
         Q90Ums/Yaj8d6K7hNYqDHZD3aXuvrXJCedETdruvJQTyWulk6yBRYc/kVS87a/v2leKA
         /zOIJpDTedub0dtHKO0cgQ2d1jTNOnnG50sydcUUTd8vfmqghVpKjHmL07nVRCIsNcGl
         plpcAh2L4zDZzJazErsG1JD070556XlqQO3FWdMb6eVD581j0+cJlDBX3JX/auLCPDDu
         pF9g==
X-Gm-Message-State: AOAM532Ee1QkJ6ni/31FlN3qOusb0BXc6Ywki3MK3q6BF9vtiYMy2QPR
        e1YA3Ye5tRjrDJW3NJXDbbk=
X-Google-Smtp-Source: ABdhPJy/8UaiZCs8aRsOZbhjlEMUIkuuB6Q8CB3lu4EIBCLwC41YZqHErg43fwrB4s3utLb+2nPfvg==
X-Received: by 2002:a05:6512:32c9:b0:442:4c65:57c6 with SMTP id f9-20020a05651232c900b004424c6557c6mr2426546lfg.78.1645025890452;
        Wed, 16 Feb 2022 07:38:10 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id b19sm1301187lfs.223.2022.02.16.07.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 07:38:09 -0800 (PST)
Date:   Wed, 16 Feb 2022 16:38:06 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mohan Kumar <mkumard@nvidia.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        tiwai@suse.com, jonathanh@nvidia.com, spujar@nvidia.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] dt-bindings: Add HDA support for Tegra234
Message-ID: <Yg0aXq+T5/xsBHRG@orome>
References: <20220216092240.26464-1-mkumard@nvidia.com>
 <20220216092240.26464-5-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+4Gj+4mVOCOhh+mX"
Content-Disposition: inline
In-Reply-To: <20220216092240.26464-5-mkumard@nvidia.com>
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


--+4Gj+4mVOCOhh+mX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 16, 2022 at 02:52:38PM +0530, Mohan Kumar wrote:
> Add hda clocks, memory ,power and reset binding entries
> for Tegra234.
>=20
> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
> ---
>  include/dt-bindings/clock/tegra234-clock.h     | 4 ++++
>  include/dt-bindings/memory/tegra234-mc.h       | 6 ++++++
>  include/dt-bindings/power/tegra234-powergate.h | 9 +++++++++
>  include/dt-bindings/reset/tegra234-reset.h     | 2 ++
>  4 files changed, 21 insertions(+)
>  create mode 100644 include/dt-bindings/power/tegra234-powergate.h

Actually it looks like I may need to pick this up as well to satisfy the
dependency from patch 6.

Takashi, any objections if I pick up patches 4 and 6 and you take the
remainder through your tree? I don't think there are any dependencies on
this patch 4 from patches 1-3 and 5.

Thierry

--+4Gj+4mVOCOhh+mX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmINGlsACgkQ3SOs138+
s6HwFQ//U3U4yJDxSV+WNOZgkjXYMfeYpULlv/UKfF7HswB9bjOLVnwZag74fYqs
zuqArJbCjA3LcGKj1b1RVfXS2KRylkpuwlhHlTww/LbIdUoHqmheUkr450inewar
Xq25pRt1Yf4TiXzR2T4dXaZ+tTlahYb3jgkQJY+6ycgFVyfzoAG7nqxF65w3OFac
lkLLWsKkMANW9pkBIIkNLQ2TJGoeFRJTri9TXxdzzT9WBhanehytDpdGJXKDWouP
UT8ClHH7KsxG+Yl50BSPi7Aqq5Dr0y1M/H58EFiHo4bmbsDtLuLsCOuDIb2tdYE8
UPOwM2zj8nk/6cL+a7Sr0WfrJFbajqVuBk6Lmo7lah8sfmyRY4dJcpE5+lZ8BQCS
Xjp6yrjfsg0Nwt6PBs9X8aZ3znYvHzhJEe/jvcEYwh7L4SmUVphJORkKwyjgQjaC
CX0Sz+9lDO/a2p1D7oSgIj189kzwKb2qpY0U3hiwlID9rDn8UOQIWjxSmjf4SuzV
RvMA/Jer8s/I4P6No5nWHW0nVaJU8n02NDKmfBMT4UoQIvMjX+6qCXlF9CP6QXxY
euBJJjl7wKnYmwET9Y7wuj56mE3pORSOHmn0Yy/m1rufU1IwXnCuKA3HPe4W72IG
PPZG+qEQSZBAadRU51bonsKhZBd9ntGU5nLz7iuIuVrgqnQZICI=
=c4FP
-----END PGP SIGNATURE-----

--+4Gj+4mVOCOhh+mX--
