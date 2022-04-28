Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F4E5136EF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348408AbiD1OfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348411AbiD1OfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:35:12 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BD8AC050;
        Thu, 28 Apr 2022 07:31:55 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w4so7017253wrg.12;
        Thu, 28 Apr 2022 07:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tD4ZnsNL95O06h7hL8VE5RqbrsySI03OuKEhpsr3NBY=;
        b=T+0wHxCSRyNbX5rV4CtSy8rx/AxW9OuTOoR+B8TOkzQDkyBO00HtWPeIdS0i/QQoQY
         fIOOa1kMzZHo6F3oa7uC6jQ0ftswxFXMMRDXjYRe/5G6cMR0cdzvurS6yCzzuL0zOW4R
         sRUOm+yBXzHomPvNlmik9KNG0ss9dhB/FJMBT5eETe9swWXH1w/J0Bm4lpnK/htqZk1d
         IbA8C5RxGwvzzexMidvpK3rtw5yXJ7m6JKRGGyGLO9hVS6TShXtrfwhOiPix+/RbkMY/
         TjIMGw5wiW2CRSMf4WuzZgFSykB+1wyg8udCjw7tQIi8gi6Bet16IGF7lTYPsEkHmR6d
         0NyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tD4ZnsNL95O06h7hL8VE5RqbrsySI03OuKEhpsr3NBY=;
        b=fUIS/7R/hTJ2qBcqv8CBL3FgtmDx8PVNF+KbNXDse1lHNiCOkE80WEIvQdpxM+tBx6
         8vxSDeUQNXoOhMq2w5QGsEylpMqHlppT1EnSI8Vlblnrw+CERug0KVzMz/yPkLY3mg6+
         d9hzDj3eV8ULPE13iWBWQG9HMC4sctcZMPMrF/uFxij8J21cW9nI6q6rWyCo7OQERd1j
         ///kuYOOvsgqiiQAmfQsaQvCnHe33CKdbBBQPkPpCeB3pdlS/mm9hLS06wHG73CWy6ob
         W+8HPT+TfYYpT8c9JTT6TNrpPazJDdDP69PZLHvG5Ehb3GrBe3q6l7mJmjzic6XQmb/t
         DvwA==
X-Gm-Message-State: AOAM531NIqpTamL7iBHafHuLtzRJrddOo9aaOgsTD3vu2MolXiV7TlEg
        wCSkgHcqtl2aLc1trDAy1XA=
X-Google-Smtp-Source: ABdhPJy94FFHTeKN1GK8czEcKl+i8gHZfXgzH0KKXwxLGWfDljbzaXXWHbYxQGcmuRPZvQYQIodsRw==
X-Received: by 2002:a5d:42c8:0:b0:20a:d91f:87b5 with SMTP id t8-20020a5d42c8000000b0020ad91f87b5mr18368195wrr.301.1651156313725;
        Thu, 28 Apr 2022 07:31:53 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c3b9000b0039411b2e96fsm1581283wms.30.2022.04.28.07.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 07:31:52 -0700 (PDT)
Date:   Thu, 28 Apr 2022 16:31:50 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v2 3/4] drm/nvdla: Add register head file of NVDLA
Message-ID: <YmqlVmYX3q74hMWT@orome>
References: <20220426060808.78225-1-cai.huoqing@linux.dev>
 <20220426060808.78225-4-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xAWah0BCLTf7+aCW"
Content-Disposition: inline
In-Reply-To: <20220426060808.78225-4-cai.huoqing@linux.dev>
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


--xAWah0BCLTf7+aCW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 26, 2022 at 02:08:00PM +0800, Cai Huoqing wrote:
> The NVIDIA Deep Learning Accelerator (NVDLA) is an open source IP
> which is integrated into NVIDIA Jetson AGX Xavier,
> so add register head file of this accelerator.
>=20
> Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> ---
>  drivers/gpu/drm/nvdla/nvdla_reg.h | 6411 +++++++++++++++++++++++++++++
>  1 file changed, 6411 insertions(+)
>  create mode 100644 drivers/gpu/drm/nvdla/nvdla_reg.h

You probably want to change the ordering of the patches a little because
this new header file is already being used in patch 2. With the current
ordering you'll break the build between patches 2 and 3. The same will
likely happen with patch 4 because I'm assuming (haven't looked yet)
that the UAPI structures are getting used in the driver code as well.

Other than that, not much to say about this. One note perhaps, see
below.
>=20
> diff --git a/drivers/gpu/drm/nvdla/nvdla_reg.h b/drivers/gpu/drm/nvdla/nv=
dla_reg.h
> new file mode 100644
> index 000000000000..5ca2897405bc
> --- /dev/null
> +++ b/drivers/gpu/drm/nvdla/nvdla_reg.h
> @@ -0,0 +1,6411 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> +/*
> + * Copyright (C) 2017-2018 NVIDIA CORPORATION.
> + * Copyright (C) 2022 Cai Huoqing
> + */
> +
> +#ifndef __NVDLA_REG_H_
> +#define __NVDLA_REG_H_
> +
> +// Register NVDLA_CFGROM_CFGROM_HW_VERSION_0
> +#define NVDLA_CFGROM_CFGROM_HW_VERSION_0			_MK_ADDR_CONST(0x0)
> +#define NVDLA_CFGROM_CFGROM_HW_VERSION_0_HW_VERSION_SHIFT			_MK_SHIFT_CO=
NST(0)
> +#define NVDLA_CFGROM_CFGROM_HW_VERSION_0_HW_VERSION_FIELD			_MK_FIELD_CO=
NST(0xffffffff, NVDLA_CFGROM_CFGROM_HW_VERSION_0_HW_VERSION_SHIFT)

I know that people have in the past expressed reluctance about the way
that these fields are defined. I personally don't like these very much
because they are very redundant (e.g. that CFGROM_ is duplicated for no
obvious reason). I also think those _MK_* macros are very difficult to
understand because they can be found nowhere else in the Linux sources
so people aren't used to the format. And in fact the Linux kernel has
its own set of macros to define fields.

I also realize that this would probably be a pain to change. Let me see
if I can find out how exactly those get generated, so perhaps there's a
way to get them generated into a format that more closely matches the
idioms used in Linux.

> +//
> +// ADDRESS SPACES
> +//
> +
> +#define BASE_ADDRESS_NVDLA_CFGROM	0x0
> +#define BASE_ADDRESS_NVDLA_GLB	0x1000
> +#define BASE_ADDRESS_NVDLA_MCIF	0x2000
> +#define BASE_ADDRESS_NVDLA_CDMA	0x3000
> +#define BASE_ADDRESS_NVDLA_CSC	0x4000
> +#define BASE_ADDRESS_NVDLA_CMAC_A	0x5000
> +#define BASE_ADDRESS_NVDLA_CMAC_B	0x6000
> +#define BASE_ADDRESS_NVDLA_CACC	0x7000
> +#define BASE_ADDRESS_NVDLA_SDP_RDMA	0x8000
> +#define BASE_ADDRESS_NVDLA_SDP	0x9000
> +#define BASE_ADDRESS_NVDLA_PDP_RDMA	0xa000
> +#define BASE_ADDRESS_NVDLA_PDP	0xb000
> +#define BASE_ADDRESS_NVDLA_CDP_RDMA	0xc000
> +#define BASE_ADDRESS_NVDLA_CDP	0xd000
> +#define BASE_ADDRESS_NVDLA_GEC	0xe000
> +#define BASE_ADDRESS_NVDLA_CVIF	0xf000
> +#define BASE_ADDRESS_NVDLA_BDMA	0x10000
> +#define BASE_ADDRESS_NVDLA_RBK	0x11000

I'm wondering if it might make sense to turn these into separate reg
entries in the device tree, though it might not be worth it. The one
concern I have is that these might change internally in a newer
revision, which might then make it a pain to adapt the driver to the
differing offsets.

That said, I'm not an expert on DLA, so I don't know how this has
evolved in newer chip. I'll try to track down our local experts so that
they can clarify a few things for us.

Thierry

--xAWah0BCLTf7+aCW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJqpVMACgkQ3SOs138+
s6GRSRAAuXAm9LihLpfQ1BQOnd52lgMlO8jTO5IqOlkdP3akExLaPCPBoEmc1JSR
UMgKddQ86r4PsPF26Z6o/qzPUQL1OSG7TyDYVt10Vq7OYC0FvBfamHYVQE8RW5Yo
zXMjvoWM/P0PPtFz2474Ngq4/AztVLSUHYCtDDKOM40YW1pedUWcOfbIqbutQpD+
kQf2GOM9tWT1jRVBpS9coH6guSU4HJEFXZFDZ710OtUN1ay/ZSECOYGIjRj8lGeS
XME2ppdv5t3JpA5rfgGuzUjQu0e5kB/JNJx/nVnsLlpEyWnNpXcPhSJFo7ZjBAGj
0nHtosK9pLOKiWDg35QUjUTIF7klWc9+R8Sg8W6HqyNiGg/NRlC48tj/1HR/Zjqe
ZLZa3nlEnuwaEIrnQImIkWGjWv3qaiHIC0bskYooN2dzhVZGnTXwYB58CuhoJSpo
gcwu7MKMFRZB/Mu088vwaMt/MmYsLM4lvwu8tLC3JUH0x987jNiRKjCjyOG+OPOp
0HyAOjCAmtWSEnP6rYbFeNF6JCBAS6POHV2T2pY0Q+I98dYRvRsNr+RkaDQ1S78J
xSTYE2vG83jqxcB5aYBvQMdNxkGhOVtOSz5rhrcGjcw4volYhcqWdDgjBjk5Ftgc
6RMp3F2ff71qyNjYc85qexHoksZdqIcwX6sENHTjjvd2IToNbuI=
=vU1Q
-----END PGP SIGNATURE-----

--xAWah0BCLTf7+aCW--
