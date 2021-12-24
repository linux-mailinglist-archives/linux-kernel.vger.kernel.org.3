Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A95247F17D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 00:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhLXXZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 18:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhLXXZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 18:25:06 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836E1C061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 15:25:06 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i22so19676148wrb.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 15:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CBWI94DnAbuhdlI8jpyRcjT77P/sUwa6Q+G0yKJaxQQ=;
        b=QMSCoNEQcDJcNrvfqRwfymcwEDL37lsh89/EIODzCg7becUZ9M0aOlPdTl0gtd1WMI
         pLN/0cB89YMdxs8I75iLYYmUn09Chq1kPZB4+FPCnFUAQyFmdisdIm+AocxFdvJ/aAax
         LAx5PvCJIpvK0Z1shGhYAUj5In85pxuN33Dpq6Xht9tH+yCCuMzeCwSYaaoVpvx6gfhP
         xfnrAgPKabnzTyAWPB9X8zRIbdnNcFft6YRLtF6TO7fgD6Yfk/UWNozB+fPPPurWV/xJ
         ac2gj465VkRf0BBDTPl4Bk4eDQlFb96SzgDpvzVM6+WAXAI0YJUTe9iNU8fgsvNzd5Ij
         emVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=CBWI94DnAbuhdlI8jpyRcjT77P/sUwa6Q+G0yKJaxQQ=;
        b=LvfQK0Xexy40c3D+RDYgO31gDYqzLjDYtknw6ePQBKG98p8bPAFDTqvvnhobe7S6M6
         ApOeG1m8USv7252sce6kbhtXPR0/u0O4TeQFyLWK8y+qnOho2hYJMhfnpdylcNwstzAp
         LJDgxgjPoRO4iq2m6MoZ3AhLmEfbU5l7VEhQQawztv3TyRjMaQM6QGP96afni/NmgMjl
         PN6rFAV+zx04bE4RacaJVJylFJEF4MN2huKu1jvDD2GWUgDyzHwW1BTWRSlzCQ/XevtM
         XJazOW6KWV0BEp1AyhHCpy8LNOtZvvO0TYGryui9Drx8f+MQYwCkR1umBewne2rOFt6I
         p7BA==
X-Gm-Message-State: AOAM5305DaU7ifKe/Sr7MQ6TCJQP1w47ZBJgjVwcqlOx9tVPljl/lxiQ
        2YYyDhaH3sfEtASnx6QSAPqikw==
X-Google-Smtp-Source: ABdhPJxo4AHSt7YwUTMDC+sX6bSs8y00mJ4xSqoQ/5X1pHjUvUNc0OnM2ORuKgSXV9zwfbGFws98qA==
X-Received: by 2002:a05:6000:168c:: with SMTP id y12mr6066606wrd.409.1640388304934;
        Fri, 24 Dec 2021 15:25:04 -0800 (PST)
Received: from smtpclient.apple (global-5-141.nat-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id o12sm9779882wrc.69.2021.12.24.15.25.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Dec 2021 15:25:04 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v1 2/2] dt-bindings: riscv: Add DT binding for RISC-V ISA
 extensions
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20211224211632.1698523-3-atishp@rivosinc.com>
Date:   Fri, 24 Dec 2021 23:25:01 +0000
Cc:     linux-kernel@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3188F71E-93A4-452E-A730-A2F393067346@jrtc27.com>
References: <20211224211632.1698523-1-atishp@rivosinc.com>
 <20211224211632.1698523-3-atishp@rivosinc.com>
To:     Atish Patra <atishp@atishpatra.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Dec 2021, at 21:16, Atish Patra <atishp@atishpatra.org> wrote:
>=20
> RISC-V ISA extensions can be single letter or multi-letter names.
> The single letter extensions are mostly base extensions and encoded in
> "riscv,isa" DT property. However, parsing the multi-letter extensions
> via the isa string is cumbersome and is not scalable.
>=20
> Add a new DT node for multi-letter extensions.
>=20
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
> Documentation/devicetree/bindings/riscv/cpus.yaml | 9 +++++++++
> 1 file changed, 9 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml =
b/Documentation/devicetree/bindings/riscv/cpus.yaml
> index aa5fb64d57eb..6c4eecf389a9 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> @@ -78,6 +78,15 @@ properties:
>       - rv64imac
>       - rv64imafdc
>=20
> +  riscv,isa-ext:
> +    description:
> +      Identifies the specific RISC-V instruction set architecture =
extensions
> +      supported by one or multiple harts. All the multi-letter =
extensions
> +      should be listed here as a boolean property. This subnode can =
be under
> +      /cpus or under individual cpu node. In case of former, it =
represent
> +      the common ISA extensions for all harts. The name of the =
boolean property
> +      must match the actual ISA extension name in all lowercase =
format.

I don=E2=80=99t see why this needs explicitly calling out, that=E2=80=99s =
true in
general of cpu node properties (3.8p4 of the Devicetree spec v0.4-rc1 /
v0.3-40-g7e1cc17), not that I like it.

Jess

