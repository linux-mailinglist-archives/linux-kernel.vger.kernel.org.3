Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DD5476C3B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbhLPIx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhLPIx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:53:58 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88388C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:53:58 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t26so6487635wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zuHdQz/z1bGX+waW3JEYSIB/zdyPyOGdaMILzn7AVeU=;
        b=gEikQ5mxHFrS7IzxE+OyQ9FYSv5Kf/JcXXN/MV/+vG6gMeY7N1OsufMvV9yejt05SF
         VWdnbu4ueBAReGotImQgOEex9xyCYevoN+jQH6PFDvBJBtEnfH6SazBe8aR9aMe84WCZ
         gPIxoS7dRE2AHEl3ppk22yPQ5dfqqQdQ/R8y1iZXDPelmu81kayXQeborMW2wrX3s6lR
         7DA44a0IpA4d2j3uLgdZ0q4ddItDszzSJSm5ogoQg3vXhd+5glJJICPzCEyvWJlK6dNH
         rz+zYOb753blMWsvTe4+LmFJI+3bDiGcnnaHuN+C1xIAyrvbRNl0Lbjb5mrRTz7vnhUb
         oq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zuHdQz/z1bGX+waW3JEYSIB/zdyPyOGdaMILzn7AVeU=;
        b=NKtEOFNCic83jRB2CWOjOz/YjQpfwNYdobxJP444njkeEZSFc5qr0LDMf9GO/BY4CC
         weQQxsSi+OPgnEq+HMGlKIWIKafUIK9Y2+PmGftqB9JBaFhcsamq0Nv51RdSZUYhLFOS
         qI04fk/Abev3vh6MbeAh9K982XvqYPYBGpJ0bmUxsZ80HvVKyjs1XN2zHVVrPhKZomRM
         760S/+9CWtA0FCJKdaOjk4dW1N8oae/hX1TzP5xXnOxSDLLUXsLD6x5OtyAf9HCSKnyW
         oSG0ur6yIT7ypd/HmYMdP3LcZix8jMrKg6yE7jM9s6rokkOAbfZhU9WY0E1lQFOfYYw7
         Z0Ig==
X-Gm-Message-State: AOAM533nPEI2q6kaaLeI6Jon1qdYflfwM7gTSmFm6R0eROGxbt7WKVeG
        0zi/mTkj5DTaUV6DZwJTZm8=
X-Google-Smtp-Source: ABdhPJwp3BTifW88zZDU6LbdmwMYSvHsNSURwVnejLkm7vfmNtvhg0HU0qUIrf076ZzxB+YENumPSg==
X-Received: by 2002:a5d:434f:: with SMTP id u15mr8387009wrr.492.1639644837026;
        Thu, 16 Dec 2021 00:53:57 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id n33sm7435943wms.46.2021.12.16.00.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 00:53:56 -0800 (PST)
Date:   Thu, 16 Dec 2021 09:53:52 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux-foundation.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        john.garry@huawei.com, linux-mm@kvack.org,
        Mikko Perttunen <mperttunen@nvidia.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 02/11] gpu: host1x: Add missing DMA API include
Message-ID: <Ybr+oM8B+yxbwAiK@orome>
References: <cover.1639157090.git.robin.murphy@arm.com>
 <cba5353b636117835512fab7646788d89db033bf.1639157090.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sSiHttHjd4ANYL++"
Content-Disposition: inline
In-Reply-To: <cba5353b636117835512fab7646788d89db033bf.1639157090.git.robin.murphy@arm.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sSiHttHjd4ANYL++
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 10, 2021 at 05:54:43PM +0000, Robin Murphy wrote:
> Host1x seems to be relying on picking up dma-mapping.h transitively from
> iova.h, which has no reason to include it in the first place. Fix the
> former issue before we totally break things by fixing the latter one.
>=20
> CC: Thierry Reding <thierry.reding@gmail.com>
> CC: Mikko Perttunen <mperttunen@nvidia.com>
> CC: dri-devel@lists.freedesktop.org
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>=20
> v2: No change
>=20
>  drivers/gpu/host1x/bus.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--sSiHttHjd4ANYL++
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG6/qAACgkQ3SOs138+
s6En1A//d/JxdmfP3y/UDoHH5rwtaLTrTkSeujiv36BK7vPY9dIVpiB/Up/FgTw0
Exwl6pOwajQybixpbZUFw5ySCyPNza1WYKPOLe+/Trv4kd2G2OMCTJK7dc7AakXR
X8vWNlyxwRvgnbtA2rV61uNaBXUjAVFLQsFIiJ0yCvt+Rn0MKXKfpvDDEVzOtsmI
e2vGdgHf2Xk4EJaPO2GQGrY2Vb3K2tJN/OHw606y4OhMrSldKzEtGpSMR39k3QW4
Isulh0KpOgzDTwUuKSID/K1tz/aYhOuE1XCnET84NU6ieuPyNGmHksaqH8KCHceF
mE1G+AAVlD5Pf82CN2hOYw1GelRZYLZ2e3i6XrESu6uAxhQZKTA15hyYNbr2ZI7v
b0S6KIhNHH90FJqbzxYGwwETk2xt0DTUIAImfWqITb8SSW6fEMh6h98vzfFig3/u
0RfZVjJ8TTe5S5COkCg/Rfp+20djtHsihBzxS/FifpUW8FGJsD3InMqxNJX0PFps
gmvusybT5Th0b2B1n3JOSitVfV/za5rfSoBDcnlDlbTDYcmTq+ufTEKi3yKyjZW/
r5StmSJaNy6QwZesRAzaYgNlnFZ4QD5ihmr9f0lUXA0nwyRGOsRS+DOTmZuX0I/c
AShLEMm79+cBTwIhugsweG/Ehr1dSmqznnHfmuA+LJlw2jBMJ7M=
=aG+K
-----END PGP SIGNATURE-----

--sSiHttHjd4ANYL++--
