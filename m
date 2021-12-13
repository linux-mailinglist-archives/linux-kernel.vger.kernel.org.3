Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1329A473177
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240632AbhLMQSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbhLMQSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:18:38 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47F4C061574;
        Mon, 13 Dec 2021 08:18:37 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d24so28097748wra.0;
        Mon, 13 Dec 2021 08:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oQPyuQLpND71l7suKmhwrsvoNDRo5Wjy5yxFpoQZX1E=;
        b=gjRjsiKDjfzW4bDqTcSpPJtcMSt35R03NudJ3vzQh35BOGWEvS/BwFb9+fEyXmYtyp
         n4CP43vQzLpufuQq6NdOjd7eTfNr1a/WttrU26H0oZvPMSYCwMJzCaAVNF69P9VIxkn1
         lFR/kaIb8IoQ+B+e3uFayt98sIrXvGhdTGV/jc6YO7gaCAdmTlUl92hYAQv7lgrrW8Zv
         Sm+nhuB1MNTgsTMiPLXNebYTdGIMjgFvOHWkC8kRAwtnNvRNWkQk2gSZmhnro1q8e0AO
         g3Nw4gbBDzzXwMqAmm/S6vrxUmiM2O8sQuLER202I0M7NKueCGV+bIPgBesIBs36LCx/
         9p+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oQPyuQLpND71l7suKmhwrsvoNDRo5Wjy5yxFpoQZX1E=;
        b=I0qG7dD8z+TngGTbTBUw7GL7mgbeuw6kKVIm8IdkeH+YiJRs2AKdBUa+gX58+zjftK
         r53bphof3Ht8UUXCzLrHB4pTqXbT+bZQnLSJ/kFyRs9JdeLNSXodypjKd2KVFluL442D
         ZKP5jbSvfPk8ZXpjSYqjBakfvvtjpDHY3PdInNgRm5xREKnJfz6+kga/m903S9EBLzsg
         9+GoyFO6mxWFg4m3GDW/lv7w5TD51Mhkr/371x8JpWOOaTB1Av97YI8vbZqgNvjdheZD
         tlBYQ/5bXBgUZkZ9I4JHez0NxGx0I6FNYIThGweVlFq5cZ6ZrHSxlroma0Gz4dQV95yU
         LeKQ==
X-Gm-Message-State: AOAM530GP4haXay6Qv9mAXwRN8jU6FIz6ZubyYnGirc76zQVZZIyg2kj
        SBzM1pIaynnRS6fqgFbZi/ODV51fyg5OVA==
X-Google-Smtp-Source: ABdhPJy0cKYquORCgTFd1afg6QMsyH+BQo/YlOq25gz9aeCcX9ZxkyT/3BmjvXPwbVa93jfXDY2sUg==
X-Received: by 2002:a05:6000:82:: with SMTP id m2mr32555663wrx.202.1639412316416;
        Mon, 13 Dec 2021 08:18:36 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id k187sm7906201wme.0.2021.12.13.08.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:18:35 -0800 (PST)
Date:   Mon, 13 Dec 2021 17:18:32 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: memory: tegra: Document
 #interconnect-cells property
Message-ID: <YbdyWPyAaEArYRLr@orome>
References: <20211210164741.881161-1-thierry.reding@gmail.com>
 <20211210164741.881161-2-thierry.reding@gmail.com>
 <77efa5e3-f6bd-9892-8bf2-427b4709329f@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y6eq2A1+AIlolWWy"
Content-Disposition: inline
In-Reply-To: <77efa5e3-f6bd-9892-8bf2-427b4709329f@canonical.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y6eq2A1+AIlolWWy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 12, 2021 at 07:50:25PM +0100, Krzysztof Kozlowski wrote:
> On 10/12/2021 17:47, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > The #interconnect-cells properties are required to hook up memory
> > clients to the MC/EMC in interconnects properties. Add a description for
> > these properties.
> >=20
> > Also, allow multiple reg and interrupt entries required by Tegra194 and
> > later.
>=20
> I think number of interrupts is fixed and you do not change them for
> newer SoC, so the message is a little bit not precise. Also the subject
> does not it the patch - maybe something like - "adjust properties for
> Tegra196"?

Yeah, I forgot to update the commit message after making the changes in
v2. I'll send out v3 with an updated commit message.

Thanks,
Thierry

--Y6eq2A1+AIlolWWy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG3clgACgkQ3SOs138+
s6EzfhAAhLH1Fq1EmY5ciyU6rg9kTgmPxvXlB/UCffEidJ5MVFyAi/2xzy3QPw6E
2381MPgaca8p3N8Wr/TwnGWeupCF1a/VgrnFzu81Z17eM0wyw9vsKhnqEd3M+D4p
PdSuW/muYKsw/Ht+dCeH+udyJhc8do/QBc/zkISG3wYQM2nz4fH2Fx//6ORWw7fm
UhW01k0IdDKNInqM40yEC88kfc8XAlngSyBvIdqKgKvxnc2PJoRuvIXH4f7/GA3M
evmHvSNt5WPofevp/4A6/eq7u+VAxnsFjdEplJixjPG0X8fJeK8O9S/ctbMTsR3v
VP4sdeqV4Z1/nph1EktHdWxkR4QKzsgwOXORM/H3Nc2xG6FDVDrZDeufMKCbSFfB
VLe7lF0paE+DRo/7SzSShKYWN2xCP+D+Gmia2crFksIwnYhCVLE2GWuZOABeKLiv
kr4R9QRGSsVcd96x9j9cD4Sm9QS6RNfqawFLbEp9WoJ0Qjnti43OAr4Dc4BBmd+3
1nSs9TfYzfcBetvsM2to0bEDb+0ouFFnL2AiO3/ppVHE05Jg+tDKFHDUSHRRLqAA
wMa7Ijf0p3ws5o+ENr7S8k72GEpmGMv1Tx2YYj8gatRGarUmH2ZZFIJFb3QLkzVj
JMawnXBic/ncEaWQeLdtgjJmvbJ6R9TFWbScnmW/Xg9GrkPKL2Q=
=q1u+
-----END PGP SIGNATURE-----

--Y6eq2A1+AIlolWWy--
