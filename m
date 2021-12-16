Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36DA477044
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbhLPLaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhLPLau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:30:50 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D68CC061574;
        Thu, 16 Dec 2021 03:30:49 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p18so18674895wmq.5;
        Thu, 16 Dec 2021 03:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kkKYFdWW6UCJzSdQqJXxaaYA3bsQkl9FlH/GOA+i1Yc=;
        b=UoOLDVzd2Z7MeM0G4GorBmBwofg4ukS3hyY1S1lsoXvl16VQqDJwISRk3xaJbP/5AK
         IJfXaSMlAbZVtIW8GDpmhPi3fs5uyXxDTyXGg51BHCeGmBNwsEGqtWNBZRkrF2vedRBc
         gOFchM7VSi5Vj1dekR70jIfvyq5DKZfbUx94LReShDVIsG6Bm5r7jdCRJle7YUH2PbGd
         5k+Fh5oC2KUh2UcwvyuR4u2XeDwxgL5CLqEzvc8kvO/9XzQ5GF7pxKFWkykdtkRI1Elf
         T/LlmZ9mNGarHGy/C6qLZfBXh7ETHhWPq4woQZp3zL0rZLVxpDtCsvL2J6rktrtKZe37
         gQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kkKYFdWW6UCJzSdQqJXxaaYA3bsQkl9FlH/GOA+i1Yc=;
        b=F/q9l4DR/AgCx9+Jb5wQHmj8yIOc9s2pPgaA2bnkOqsYXa0c33ozxgMDme+Kd2igLR
         UQKdJEBy/KRaNPQ9xUjhv/aSx1zZ9aP6F1/x3WVvcTd+Bxux2pWGf2SFXtu+UCixyqGT
         UlqtGNb0peU9m8LHo7EOm392D3v2suazHdWaISXffWCnMWuLYhO+FGI6Y8cT5mOI7yH+
         NURZSTg/r/W75D38ZAx4YMr/naw7AXzL5NyDLAE73nm5HUyFTV83dHJ/TSR1Ta1xXoVA
         zLP9xH/INYP0ru8GINT884gfFiI45jQmIcsNGFrF/YzIzwtZgk7r/t9O+eO51NELvowU
         4NoA==
X-Gm-Message-State: AOAM533Aj47/4Xm1uMUhcAZ74nZEQAXKjWTAeKkETJiE2u7X5qdnJev/
        mYUc1mFlUKotGyXWo7WVxE8=
X-Google-Smtp-Source: ABdhPJx63rpTL/bdCiuPeeXe27cBb+BoXyDlOVw2g7opXpmXsbzI1Ulj9Ru3/UsvVRsRHarz4wrntA==
X-Received: by 2002:a05:600c:3d94:: with SMTP id bi20mr4551005wmb.71.1639654247975;
        Thu, 16 Dec 2021 03:30:47 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id c11sm1156319wmq.48.2021.12.16.03.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 03:30:47 -0800 (PST)
Date:   Thu, 16 Dec 2021 12:30:44 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jonathanh@nvidia.com,
        robh+dt@kernel.org, bbasu@nvidia.com, vsethi@nvidia.com,
        jsequeira@nvidia.com
Subject: Re: [Patch Resend v1 5/8] dt-bindings: arm: tegra: Add NVIDIA
 Tegra234 CBB2.0 binding
Message-ID: <YbsjZDc8tt3fMUQt@orome>
References: <20211209172206.17778-1-sumitg@nvidia.com>
 <20211209172206.17778-6-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kDnqfaHImAnj07sS"
Content-Disposition: inline
In-Reply-To: <20211209172206.17778-6-sumitg@nvidia.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kDnqfaHImAnj07sS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 09, 2021 at 10:52:03PM +0530, Sumit Gupta wrote:
> Add device-tree binding documentation to represent CBB2.0 (Control
> Backbone) error handling driver. The driver prints debug information
> about failed transaction on receiving interrupt from CBB2.0.
>=20
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../arm/tegra/nvidia,tegra234-cbb.yaml        | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,te=
gra234-cbb.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-=
cbb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.=
yaml
> new file mode 100644
> index 000000000000..ad8177255e6c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: "http://devicetree.org/schemas/arm/tegra/tegra23_cbb.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: NVIDIA Tegra CBB2.0 Error handling driver device tree bindings
> +
> +maintainers:
> +  - Sumit Gupta <sumitg@nvidia.com>
> +
> +description: |+
> +  Control Backbone (CBB) comprises of the physical path from an
> +  initiator to a target's register configuration space.
> +  CBB2.0 consists of multiple sub-blocks connected to each other
> +  to create a topology.
> +  Tegra234 SOC has different fabrics based on CBB2.0 architecture
> +  which include cluster fabrics BPMP, AON, PSC, SCE, RCE, DCE, FSI
> +  and "CBB central fabric".
> +
> +  In CBB2.0, each initiator which can issue transactions connects to
> +  a Root Master Node (MN) before it connects to any other element of
> +  the fabric. Each Root MN contains a Error Monitor (EM) which detects
> +  and logs error. Interrupts from various EM blocks are collated by
> +  Error Notifier (EN) which is per fabric and presents a single
> +  interrupt from fabric to the SOC interrupt controller.
> +
> +  The driver handles errors from CBB due to illegal register accesses
> +  and prints debug information about failed transaction on receiving
> +  the interrupt from EN. Debug information includes Error Code, Error
> +  Description, MasterID, Fabric, SlaveID, Address, Cache, Protection,
> +  Security Group etc on receiving error notification.
> +
> +  If the Error Response Disable (ERD) is set/enabled for an initiator,
> +  then SError or Data abort exception error response is masked and an
> +  interrupt is used for reporting errors due to illegal accesses from
> +  that initiator. The value returned on read failures is '0xFFFFFFFF'
> +  for compatibility with PCIE.
> +
> +properties:
> +  $nodename:
> +    pattern: "^[a-f]+-en@[0-9a-f]+$"
> +
> +  compatible:
> +    enum:
> +      - nvidia,tegra234-aon-fabric
> +      - nvidia,tegra234-bpmp-fabric
> +      - nvidia,tegra234-cbb-fabric
> +      - nvidia,tegra234-dce-fabric
> +      - nvidia,tegra234-rce-fabric
> +      - nvidia,tegra234-sce-fabric
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    items:
> +      - description: secure interrupt from error notifier.
> +
> +  nvidia,err-notifier-base:
> +    description: address of error notifier inside a fabric.
> +
> +  nvidia,off-mask-erd:
> +    description: offset of register having ERD bit.

I was wondering about these two properties. Do we really need them? I
see that they are set on a per-SoC basic and they only differ between
the various fabrics. If they don't need to be configured on a per-board
basis, then I don't think we need to specify these explicitly. Instead I
think we could derive them from the compatible string.

Thierry

--kDnqfaHImAnj07sS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG7I2EACgkQ3SOs138+
s6G0RQ//QsTrAYxPZSsjpqcT32TaiYNtCdwarmMkxl8hueLKxMW5Lp9Kbd500Nyg
hMrIJxrN0P/iBx14FLBs/Oik8x91ADhLst+gcsOH23ibM0nk2CcokcT29mBnsLTe
E2ADcNbLO6H1795RKde/KjgkfEHS/6bdRwk555/WMZSKJyUwVIn15+HY+9hrBcXj
Elu77lebBY5ac4xI/UCxbHZk1nMBBznpLDdDbCnvmtnRX4jZ3IQML6/8VgIiauOU
TJwSIwgrUmxFfJJAIzHf4ijNXcKItar3NpA68vFuQGqJVccC00wemYUa4P+2HFMy
Je1PbtGORUPBidYzv0GDSeLwKM7HqHXFOaKgGw8RHj4X5HOlMlrUXeUn1dXD3aDC
Kv+VlogVhkoZRpMJm/4u0BWdW+pDgDiwDFHQXo7o6H/lx8MSu6eQa2svNhKiSw17
Byn1O+A3m5SyrMmmtzkrwYNp1v5PZphPkq2FpdPwoODUhrblTv08OrQ7Oy30hwH1
O/9QDKwRXceNDVumcQWmc18/amLI3fK0qeoCmoI1Q/tkS0rQo9B7/tO4knF1jScS
NW1vzGS6YmZzSMH26UVzLHr1y41Ihzw0Si2jyqH7YDZyV1grnZbe42pYoZ93dhsy
MoaiOqHxCW+d4NMgS/Tc4q0kE4Nr1hrwmn9Fp2RpQ57qigZjBEU=
=brHz
-----END PGP SIGNATURE-----

--kDnqfaHImAnj07sS--
