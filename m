Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D465477955
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhLPQis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhLPQir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:38:47 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B17DC061574;
        Thu, 16 Dec 2021 08:38:47 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id o13so45169010wrs.12;
        Thu, 16 Dec 2021 08:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EP3xb+L2xQ/6dsIM4CEwcEiPmw14nHoll6jOIGKWqPA=;
        b=TzPuFWV24wtWEhXxZJK40D4ieK3a7qzqWSIapU1CFCnakNH5USfJdAE69OCM6lgAjh
         sdjugSHia6pAzbLfDz+vlcAX3fcfvOQm+RsGHiHPu8uuOiGPZpswMq7Z2ZOmcq0mI5OA
         4DfJtIPbSKCSZQnP/sh7rmVH2Lx4SV0WAVN6mmcNVl7xL/qa3zupA4/PlKPB0r//vLps
         X1L5EjaRQhoOF6neQwkdmFfFL/ekhPyaWwrj1DLc3kif9epgfJWqhZ5sMRdPpOCuKbJb
         zyC6H/pJseZK965PTe01kdvlfGg/AuQyDxPADhBYoT0kUQEeSd2vflz+tXhNyQ54GBqS
         O6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EP3xb+L2xQ/6dsIM4CEwcEiPmw14nHoll6jOIGKWqPA=;
        b=hURW4Tx/sFC/Xdm7bIzrGunqqHtNjllkP1J6UMy4WGZvnwvU16AO/30ahKD5b+uUZU
         BskD1cHGsd05nSN754PQfV7G7vRPxsqSvGp/eIxWyWwIuog6T8x19D4cBmdGoNOfXtdk
         7bP0nfRGQfBBZp24WjzW/aWniFu6a7wYvwOwF2CZYtThp2S0L9W9Sf2t+bHBYh0YDr0U
         KjcMXwe6ICrBmvA/INBs1jTgvQ2L2oFC2eGx2IzKM9X21d09SNSIuwHWybacmT2dHTsu
         4hM3GTSwVZVAHJJkRWbBMuiVGmhhbQ26xdGYW80Bbjb7sPdNV9JMSQLoTSsXn/qazxTC
         uwSA==
X-Gm-Message-State: AOAM5301xpRgZE0phX09CsZEz2u94pp4aatlq7bpXDNWUIkTrF3b95d5
        ok+UDFk5xa/2x/NrbXYxwJAtLqfFSXiGaA==
X-Google-Smtp-Source: ABdhPJxSn97MDh2IXVe4MI7nWPHDfEm3gKt2P6E6PmGP9AT9pQEnrTpqaClaoo+RYs2k+5XaAQitdg==
X-Received: by 2002:a5d:4575:: with SMTP id a21mr9850468wrc.193.1639672725778;
        Thu, 16 Dec 2021 08:38:45 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id z11sm5402253wmf.9.2021.12.16.08.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 08:38:44 -0800 (PST)
Date:   Thu, 16 Dec 2021 17:38:41 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jonathanh@nvidia.com,
        robh+dt@kernel.org, bbasu@nvidia.com, vsethi@nvidia.com,
        jsequeira@nvidia.com
Subject: Re: [Patch Resend v1 5/8] dt-bindings: arm: tegra: Add NVIDIA
 Tegra234 CBB2.0 binding
Message-ID: <YbtrkcMMwjipgkZf@orome>
References: <20211209172206.17778-1-sumitg@nvidia.com>
 <20211209172206.17778-6-sumitg@nvidia.com>
 <YbsjZDc8tt3fMUQt@orome>
 <321bfcdf-2aa3-0d0a-2096-972b5cf0297a@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JSShQrnBNGx5c7H6"
Content-Disposition: inline
In-Reply-To: <321bfcdf-2aa3-0d0a-2096-972b5cf0297a@nvidia.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JSShQrnBNGx5c7H6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 16, 2021 at 08:36:11PM +0530, Sumit Gupta wrote:
> Hi Thierry,
>=20
> > On Thu, Dec 09, 2021 at 10:52:03PM +0530, Sumit Gupta wrote:
> > > Add device-tree binding documentation to represent CBB2.0 (Control
> > > Backbone) error handling driver. The driver prints debug information
> > > about failed transaction on receiving interrupt from CBB2.0.
> > >=20
> > > Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
> > > ---
> > >   .../arm/tegra/nvidia,tegra234-cbb.yaml        | 80 ++++++++++++++++=
+++
> > >   1 file changed, 80 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvid=
ia,tegra234-cbb.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra=
234-cbb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-=
cbb.yaml
> > > new file mode 100644
> > > index 000000000000..ad8177255e6c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb=
=2Eyaml
> > > @@ -0,0 +1,80 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +
> > > +$id:"http://devicetree.org/schemas/arm/tegra/tegra23_cbb.yaml#"
> > > +$schema:"http://devicetree.org/meta-schemas/core.yaml#"
> > > +
> > > +title: NVIDIA Tegra CBB2.0 Error handling driver device tree bindings
> > > +
> > > +maintainers:
> > > +  - Sumit Gupta<sumitg@nvidia.com>
> > > +
> > > +description: |+
> > > +  Control Backbone (CBB) comprises of the physical path from an
> > > +  initiator to a target's register configuration space.
> > > +  CBB2.0 consists of multiple sub-blocks connected to each other
> > > +  to create a topology.
> > > +  Tegra234 SOC has different fabrics based on CBB2.0 architecture
> > > +  which include cluster fabrics BPMP, AON, PSC, SCE, RCE, DCE, FSI
> > > +  and "CBB central fabric".
> > > +
> > > +  In CBB2.0, each initiator which can issue transactions connects to
> > > +  a Root Master Node (MN) before it connects to any other element of
> > > +  the fabric. Each Root MN contains a Error Monitor (EM) which detec=
ts
> > > +  and logs error. Interrupts from various EM blocks are collated by
> > > +  Error Notifier (EN) which is per fabric and presents a single
> > > +  interrupt from fabric to the SOC interrupt controller.
> > > +
> > > +  The driver handles errors from CBB due to illegal register accesses
> > > +  and prints debug information about failed transaction on receiving
> > > +  the interrupt from EN. Debug information includes Error Code, Error
> > > +  Description, MasterID, Fabric, SlaveID, Address, Cache, Protection,
> > > +  Security Group etc on receiving error notification.
> > > +
> > > +  If the Error Response Disable (ERD) is set/enabled for an initiato=
r,
> > > +  then SError or Data abort exception error response is masked and an
> > > +  interrupt is used for reporting errors due to illegal accesses from
> > > +  that initiator. The value returned on read failures is '0xFFFFFFFF'
> > > +  for compatibility with PCIE.
> > > +
> > > +properties:
> > > +  $nodename:
> > > +    pattern: "^[a-f]+-en@[0-9a-f]+$"
> > > +
> > > +  compatible:
> > > +    enum:
> > > +      - nvidia,tegra234-aon-fabric
> > > +      - nvidia,tegra234-bpmp-fabric
> > > +      - nvidia,tegra234-cbb-fabric
> > > +      - nvidia,tegra234-dce-fabric
> > > +      - nvidia,tegra234-rce-fabric
> > > +      - nvidia,tegra234-sce-fabric
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +    items:
> > > +      - description: secure interrupt from error notifier.
> > > +
> > > +  nvidia,err-notifier-base:
> > > +    description: address of error notifier inside a fabric.
> > > +
> > > +  nvidia,off-mask-erd:
> > > +    description: offset of register having ERD bit.
> > I was wondering about these two properties. Do we really need them? I
> > see that they are set on a per-SoC basic and they only differ between
> > the various fabrics. If they don't need to be configured on a per-board
> > basis, then I don't think we need to specify these explicitly. Instead I
> > think we could derive them from the compatible string
> The CBB 2.0 based fabric's error handling driver remains same across
> different SOC's and their variants. Only these fields change.
> e.g: "off-mask-erd" value is different for T23x SOC variants.
> "err-notifier-base" also changed multiple times during simulator stage.
> So, keeping them in DT to avoid changing the driver code for different
> variants of an SOC and to change them during bring up stages with DT chan=
ge
> only.

For different SoC variants I would expect this to be implied by a new
compatible string. A hypothetical Tegra235 SoC that is largely the same
as Tegra234 but required slight changes in these values would also get a
different set of compatible strings. So the fabrics in that case would
be called:

	- nvidia,tegra235-aon-fabric
	- nvidia,tegra235-bpmp-fabric
	- nvidia,tegra235-cbb-fabric
	...

and then that new value can be derived from that new compatible string.
In general we only want to provide data in device tree if it can't be
implied from the compatible string. Most of the time that's only for
things that are somehow dependent on the board design. Data that is
fixed for a given SoC can be derived from the compatible string.

Thierry

--JSShQrnBNGx5c7H6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG7a5EACgkQ3SOs138+
s6H9rRAAs+Bg4hTGhnbQAODadcjtWiBSRBzHGhRfk/G6gN2dRh8dDSz0T36/85Cn
/jiklDbeK3M+IMlQm+vQDF+h5rOpiSP6k4EWb3HHI9fetkWmdlwi/XH16pweAfTB
gi8M70wv0GlsI7OqeDZ2ECEykO13VBnfdV+AGtEFcv3T0uYDtDa9HcBp0ZUGNne8
rTA9Qtn4qJlfbCEoES6lCxqtW8CDnuPrnomGHOs7nL5dNwT4F82ZkYT2CuXhZ4PS
JfHqia25jyf1cgvqfj+FNcNdt/X2EjBpNSqvS7g3qCDltvpeDRgz85K71ZpTeSzB
+6VN3aWK+ViAoBPmiMvPCXejvuPjZV+G9ZEkbLsWlrZA7dPtHSXE+2A7Llcd4Vgz
TR/3uydaKkyE85owW9X9ZrwrmEZ5uy8EJcS1I9v0UAMZY5hHEGTjJCltXMSLOrLQ
CIug97VshHKiZmRPKN1IqUrcBsKDrjkSeylQpoSKEgI9OyNRyQZ2iNuIf3qADg4p
td0cKYbi4x/8Ox50PDoQE9n0T6fau0QhBx/KpHYbOspcqr/AOevR9xqI7ARMnedp
Nn00MIeI1LzC2IOzin/X+f1jD43nt1tH1uPkCt8JlCz0JQeTTxX239lN3SITZRpk
mA0t3HKOIQrPGJb4Bz98mUHlo3hIzNGUD3c54h3rJWpkj9kR5FM=
=ZqLg
-----END PGP SIGNATURE-----

--JSShQrnBNGx5c7H6--
