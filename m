Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05E0513825
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240431AbiD1PXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiD1PXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:23:09 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABDCAFB2F;
        Thu, 28 Apr 2022 08:19:54 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id j6so10198634ejc.13;
        Thu, 28 Apr 2022 08:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qS0RYEubj/WEr+tBfiyT1mscJrdXnWl5GKBmmuMBcCc=;
        b=o7gGmN1K53qTHzZPZiZUP82W+AEVP8i01imwcRltNcX5PTXUy++fSzThNEJUwIWH+t
         nO5IPCD40xJtBMIxfrH0LZ1ToxqMW3mQVx/Wbua1/udsEiyRxifK0A48RSBjZbxGi80y
         TIQ2fWQOMRJV64I0ymp1EzgFylizXkv7TW8c0YINfkY5AW2/57TLmq36GzPLQwgaIFfG
         HbOZ+Jv98cYZ7i7vFBmz/GnzMGfM2LAM7HzBF0Icto7SxE4M8aUaSK2O979dc5A7SqJ+
         dpjmB3V/gQ0YDTonel66eIWmjAUHCPX1UIsljRbkPLqRiyRr85npkuhG0H7jn66uIf9+
         LG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qS0RYEubj/WEr+tBfiyT1mscJrdXnWl5GKBmmuMBcCc=;
        b=kpclssOIdCMdjYSp8/I4ktErNU7cRXZ2he/rXEunsLKXgkE1NziQ8Mq5hmN/THZ1xx
         voo008xG48Wo8fdCke7+ugI1gfgX4LFTGqjGLE+i2T04J4N6aePY4JLkDMLLR5stJ8/P
         HIHZkBIxg/OtKzhZCS/GnerKGKlJ5AFkuQbmJQkf+mdcNcL+ag8qHPqAEKloRIVMiFyx
         0J6shu7bGXZ/T3HsXW/lqdVfw89fBfl5bTBbTT/aSNjwIMwZk4+GQx73L9zaCnZ8hydb
         Myc43luyQijjkH9ReYWZOWocHUuH8hlp4hyHrbPM6ivpIFUg6shJ3NtsqBe9H0/iaSxt
         laoQ==
X-Gm-Message-State: AOAM5307t+1JpbXh4CCTNlL+kJqo6l974nHNLZBojg4yN9buYJOvGAtz
        yYIpNjd1YhmUwHL6WVGzFps=
X-Google-Smtp-Source: ABdhPJy107+0PxRUcY57JeQXLnVh3ZgSwQ9hDo5Ig9/OMcKPwYWANWxK0XlKKHqHHr2jEYKdy/mFZw==
X-Received: by 2002:a17:907:6284:b0:6e0:f895:15a with SMTP id nd4-20020a170907628400b006e0f895015amr32459790ejc.713.1651159192359;
        Thu, 28 Apr 2022 08:19:52 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id ao9-20020a170907358900b006f3995f0fe0sm107256ejc.6.2022.04.28.08.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 08:19:51 -0700 (PDT)
Date:   Thu, 28 Apr 2022 17:19:49 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v2 2/4] drm/nvdla: Add driver support for NVDLA
Message-ID: <YmqwlbLcFgTDUpkX@orome>
References: <20220426060808.78225-1-cai.huoqing@linux.dev>
 <20220426060808.78225-3-cai.huoqing@linux.dev>
 <YmqwNVoTZZFaIM9S@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xJwzd/BOTwcSuCe5"
Content-Disposition: inline
In-Reply-To: <YmqwNVoTZZFaIM9S@orome>
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


--xJwzd/BOTwcSuCe5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 28, 2022 at 05:18:13PM +0200, Thierry Reding wrote:
> On Tue, Apr 26, 2022 at 02:07:59PM +0800, Cai Huoqing wrote:
> [...]
> > diff --git a/drivers/gpu/drm/nvdla/nvdla_drv.c b/drivers/gpu/drm/nvdla/=
nvdla_drv.c
>=20
> I'll look at this from an architectural level and leave it to other
> experts to review the more technical things.
>=20
> [...]
> > +static struct nvdla_config nvdla_config_os_initial =3D {
> > +	.atom_size =3D 32,
> > +	.bdma_enable =3D true,
> > +	.rubik_enable =3D true,
> > +	.weight_compress_support =3D true,
> > +};
> > +
> > +static struct nvdla_config nvdla_config_small =3D {
> > +	//.atom_size =3D 8,
> > +	.atom_size =3D 32,  // nv_large config
> > +	.bdma_enable =3D false,
> > +	.rubik_enable =3D false,
> > +	.weight_compress_support =3D false,
> > +};
> > +
> [...]
> > +static union nvdla_operation_container operation_desc[NVDLA_OP_NUM][NV=
DLA_NUM_GROUPS];
> > +static union nvdla_surface_container surface_desc[NVDLA_OP_NUM][NVDLA_=
NUM_GROUPS];
> > +
> > +static struct nvdla_task_desc global_task;
> > +
> > +static struct nvdla_engine engine =3D {
> > +	.processors[NVDLA_OP_BDMA] =3D {
> > +		.name =3D "BDMA",
> > +		.op_type =3D NVDLA_OP_BDMA,
> > +		.program =3D nvdla_bdma_program,
> > +		.enable =3D nvdla_bdma_enable,
> > +		.set_producer =3D nvdla_bdma_set_producer,
> > +		.is_ready =3D nvdla_bdma_is_ready,
> > +		.dump_config =3D nvdla_bdma_dump_config,
> > +		.rdma_check =3D nvdla_bdma_rdma_check,
> > +		.consumer_ptr =3D 0,
> > +		.roi_index =3D 0,
> > +		.group_status =3D 0,
> > +		.rdma_status =3D 0,
> > +		.last_group =3D 1,
> > +		.groups[0] =3D {
> > +			.id =3D 0,
> > +			.rdma_id =3D 0,
> > +			.active =3D 0,
> > +			.events =3D 0,
> > +			.roi_index =3D 0,
> > +			.is_rdma_needed =3D 0,
> > +			.lut_index =3D -1,
> > +			.operation_desc =3D &operation_desc[NVDLA_OP_BDMA][0],
> > +			.surface_desc =3D &surface_desc[NVDLA_OP_BDMA][0],
> > +		},
> > +		.groups[1] =3D {
> > +			.id =3D 1,
> > +			.rdma_id =3D 0,
> > +			.active =3D 0,
> > +			.events =3D 0,
> > +			.roi_index =3D 0,
> > +			.is_rdma_needed =3D 0,
> > +			.lut_index =3D -1,
> > +			.operation_desc =3D &operation_desc[NVDLA_OP_BDMA][1],
> > +			.surface_desc =3D &surface_desc[NVDLA_OP_BDMA][1],
> > +		},
> > +	},
> > +	.processors[NVDLA_OP_CONV] =3D {
> > +		.name =3D "Convolution",
> > +		.op_type =3D NVDLA_OP_CONV,
> > +		.program =3D nvdla_conv_program,
> > +		.enable =3D nvdla_conv_enable,
> > +		.set_producer =3D nvdla_conv_set_producer,
> > +		.is_ready =3D nvdla_conv_is_ready,
> > +		.dump_config =3D nvdla_conv_dump_config,
> > +		.rdma_check =3D nvdla_conv_rdma_check,
> > +		.consumer_ptr =3D 0,
> > +		.roi_index =3D 0,
> > +		.group_status =3D 0,
> > +		.rdma_status =3D 0,
> > +		.last_group =3D 1,
> > +		.groups[0] =3D {
> > +			.id =3D 0,
> > +			.rdma_id =3D 0,
> > +			.active =3D 0,
> > +			.events =3D 0,
> > +			.roi_index =3D 0,
> > +			.is_rdma_needed =3D 0,
> > +			.lut_index =3D -1,
> > +			.operation_desc =3D &operation_desc[NVDLA_OP_CONV][0],
> > +			.surface_desc =3D &surface_desc[NVDLA_OP_CONV][0],
> > +		},
> > +		.groups[1] =3D {
> > +			.id =3D 1,
> > +			.rdma_id =3D 0,
> > +			.active =3D 0,
> > +			.events =3D 0,
> > +			.roi_index =3D 0,
> > +			.is_rdma_needed =3D 0,
> > +			.lut_index =3D -1,
> > +			.operation_desc =3D &operation_desc[NVDLA_OP_CONV][1],
> > +			.surface_desc =3D &surface_desc[NVDLA_OP_CONV][1],
> > +		},
> > +	},
> > +	.processors[NVDLA_OP_SDP] =3D {
> > +		.name =3D "SDP",
> > +		.op_type =3D NVDLA_OP_SDP,
> > +		.program =3D nvdla_sdp_program,
> > +		.enable =3D nvdla_sdp_enable,
> > +		.set_producer =3D nvdla_sdp_set_producer,
> > +		.is_ready =3D nvdla_sdp_is_ready,
> > +		.dump_config =3D nvdla_sdp_dump_config,
> > +		.rdma_check =3D nvdla_sdp_rdma_check,
> > +		.consumer_ptr =3D 0,
> > +		.roi_index =3D 0,
> > +		.group_status =3D 0,
> > +		.rdma_status =3D 0,
> > +		.last_group =3D 1,
> > +		.groups[0] =3D {
> > +			.id =3D 0,
> > +			.rdma_id =3D 0,
> > +			.active =3D 0,
> > +			.events =3D 0,
> > +			.roi_index =3D 0,
> > +			.is_rdma_needed =3D 0,
> > +			.lut_index =3D -1,
> > +			.operation_desc =3D &operation_desc[NVDLA_OP_SDP][0],
> > +			.surface_desc =3D &surface_desc[NVDLA_OP_SDP][0],
> > +		},
> > +		.groups[1] =3D {
> > +			.id =3D 1,
> > +			.rdma_id =3D 0,
> > +			.active =3D 0,
> > +			.events =3D 0,
> > +			.roi_index =3D 0,
> > +			.is_rdma_needed =3D 0,
> > +			.lut_index =3D -1,
> > +			.operation_desc =3D &operation_desc[NVDLA_OP_SDP][1],
> > +			.surface_desc =3D &surface_desc[NVDLA_OP_SDP][1],
> > +		},
> > +	},
> > +	.processors[NVDLA_OP_PDP] =3D {
> > +		.name =3D "PDP",
> > +		.op_type =3D NVDLA_OP_PDP,
> > +		.program =3D nvdla_pdp_program,
> > +		.enable =3D nvdla_pdp_enable,
> > +		.set_producer =3D nvdla_pdp_set_producer,
> > +		.is_ready =3D nvdla_pdp_is_ready,
> > +		.dump_config =3D nvdla_pdp_dump_config,
> > +		.rdma_check =3D nvdla_pdp_rdma_check,
> > +		.consumer_ptr =3D 0,
> > +		.roi_index =3D 0,
> > +		.group_status =3D 0,
> > +		.rdma_status =3D 0,
> > +		.last_group =3D 1,
> > +		.groups[0] =3D {
> > +			.id =3D 0,
> > +			.rdma_id =3D 0,
> > +			.active =3D 0,
> > +			.events =3D 0,
> > +			.roi_index =3D 0,
> > +			.is_rdma_needed =3D 0,
> > +			.lut_index =3D -1,
> > +			.operation_desc =3D &operation_desc[NVDLA_OP_PDP][0],
> > +			.surface_desc =3D &surface_desc[NVDLA_OP_PDP][0],
> > +		},
> > +		.groups[1] =3D {
> > +			.id =3D 1,
> > +			.rdma_id =3D 0,
> > +			.active =3D 0,
> > +			.events =3D 0,
> > +			.roi_index =3D 0,
> > +			.is_rdma_needed =3D 0,
> > +			.lut_index =3D -1,
> > +			.operation_desc =3D &operation_desc[NVDLA_OP_PDP][1],
> > +			.surface_desc =3D &surface_desc[NVDLA_OP_PDP][1],
> > +		},
> > +	},
> > +	.processors[NVDLA_OP_CDP] =3D {
> > +		.name =3D "CDP",
> > +		.op_type =3D NVDLA_OP_CDP,
> > +		.program =3D nvdla_cdp_program,
> > +		.enable =3D nvdla_cdp_enable,
> > +		.set_producer =3D nvdla_cdp_set_producer,
> > +		.is_ready =3D nvdla_cdp_is_ready,
> > +		.dump_config =3D nvdla_cdp_dump_config,
> > +		.rdma_check =3D nvdla_cdp_rdma_check,
> > +		.consumer_ptr =3D 0,
> > +		.roi_index =3D 0,
> > +		.group_status =3D 0,
> > +		.rdma_status =3D 0,
> > +		.last_group =3D 1,
> > +		.groups[0] =3D {
> > +			.id =3D 0,
> > +			.rdma_id =3D 0,
> > +			.active =3D 0,
> > +			.events =3D 0,
> > +			.roi_index =3D 0,
> > +			.is_rdma_needed =3D 0,
> > +			.lut_index =3D -1,
> > +			.operation_desc =3D &operation_desc[NVDLA_OP_CDP][0],
> > +			.surface_desc =3D &surface_desc[NVDLA_OP_CDP][0],
> > +		},
> > +		.groups[1] =3D {
> > +			.id =3D 1,
> > +			.rdma_id =3D 0,
> > +			.active =3D 0,
> > +			.events =3D 0,
> > +			.roi_index =3D 0,
> > +			.is_rdma_needed =3D 0,
> > +			.lut_index =3D -1,
> > +			.operation_desc =3D &operation_desc[NVDLA_OP_CDP][1],
> > +			.surface_desc =3D &surface_desc[NVDLA_OP_CDP][1],
> > +		},
> > +	},
> > +
> > +	.processors[NVDLA_OP_RUBIK] =3D {
> > +		.name =3D "RUBIK",
> > +		.op_type =3D NVDLA_OP_RUBIK,
> > +		.program =3D nvdla_rubik_program,
> > +		.enable =3D nvdla_rubik_enable,
> > +		.set_producer =3D nvdla_rubik_set_producer,
> > +		.is_ready =3D nvdla_rubik_is_ready,
> > +		.dump_config =3D nvdla_rubik_dump_config,
> > +		.rdma_check =3D nvdla_rubik_rdma_check,
> > +		.consumer_ptr =3D 0,
> > +		.roi_index =3D 0,
> > +		.group_status =3D 0,
> > +		.rdma_status =3D 0,
> > +		.last_group =3D 1,
> > +		.groups[0] =3D {
> > +			.id =3D 0,
> > +			.rdma_id =3D 0,
> > +			.active =3D 0,
> > +			.events =3D 0,
> > +			.roi_index =3D 0,
> > +			.is_rdma_needed =3D 0,
> > +			.lut_index =3D -1,
> > +			.operation_desc =3D &operation_desc[NVDLA_OP_RUBIK][0],
> > +			.surface_desc =3D &surface_desc[NVDLA_OP_RUBIK][0],
> > +		},
> > +		.groups[1] =3D {
> > +			.id =3D 1,
> > +			.rdma_id =3D 0,
> > +			.active =3D 0,
> > +			.events =3D 0,
> > +			.roi_index =3D 0,
> > +			.is_rdma_needed =3D 0,
> > +			.lut_index =3D -1,
> > +			.operation_desc =3D &operation_desc[NVDLA_OP_RUBIK][1],
> > +			.surface_desc =3D &surface_desc[NVDLA_OP_RUBIK][1],
> > +		},
> > +	},
> > +
> > +};
>=20
> These global variables aren't going to work because Tegra234 (Tegra194's
> successor) has two instances of NVDLA.

Small correction: I just recalled that even Tegra194 has two DLA
instances, so if we want both supported we'll need to get rid of those
global variables for that chip already.

Thierry

--xJwzd/BOTwcSuCe5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJqsJUACgkQ3SOs138+
s6Gpgg/9H+U035AscZ+rM3Mw++AKhE951GQ8tIbJxV6LwTW1JahCazVsrOZ/fTPL
GHMAq5XhOcoyQuolcfAyMu4F9Rb+5TiVVJTfHq0TuA3rVdYeP8czuiY6Bsch0HHM
ZU4TjTyZL2VMvECeXZfRHWQvU7FCMQ+ms8uKs6cWs5CQNSFF10Ve/FjpistPRv82
VBDJzD2UUfPA7D41OdMuaQy8z0MrTnksI+H3v50AS8PBaenF7yk0BmK5/km88X+b
dXrElDAJ1ntH8HrQyntNq+fBPoWiExdz8gXiM0PWMnW1UZRoFKraLrW3FCzl28Uy
SK5ezIatixWLdpdWfA49LxpBlKPGLoWzHGyQCrTdpFxP8rfRIpuMUtbvFfhYEkNU
N94Pb28CKyG7eWo+pg5Umc3AlWjsg8LtgC44zDYLnXymVicKHzKFs/RP0Mo6Fj6m
z+pAYZtgQnSjLqAeIUVTdrJUYgnpQ00MA3Zl1U2nJjBHZgWGyXj71fBOf4v6Ar/c
o/WoMwSbME87hEtyFzEmQGk95ed2ZlCeNACykyF9ZEPBDv1CprEzZQeDg21tM3Z1
HaZrHL1U0VFJwLnIkyFYp023OwCPQqQoXgHd3zCyOL4gp1boROMmCQYzxHxBGxeH
KJ519K56LvO/S0VRWiASqmAK2kDkfWZ15M/tR0BtDImCz4lDJ7Q=
=KfCd
-----END PGP SIGNATURE-----

--xJwzd/BOTwcSuCe5--
