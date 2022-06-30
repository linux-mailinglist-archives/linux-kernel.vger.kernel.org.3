Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71345615A2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiF3JGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiF3JGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:06:39 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A4C140E3;
        Thu, 30 Jun 2022 02:06:38 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k22so26255561wrd.6;
        Thu, 30 Jun 2022 02:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uJNbDyi7iYddRfY6PB4IGhLFwOJFB/6azLoIbj2eVt0=;
        b=b/lu/u0pK4Jpqu/9ZnkPm7nOsZDZg0dXb0BlFqMTBXzTi/exCgWSw3UaOpT7MbIMG+
         uaupUPe1suq67a7wwZwrStBWdTRqydR8ea7ndduFpffgVsG4lACAUZRq3R7VYrLy/ml5
         YghSpa5pKegJaxOLn6p2803CCJGnkX3ceM6v0Ohu0QAHfxNPYhrYw24EH2k1kk2+8fPp
         QXqU+U44bnKlNua7Lj2F4KHOa7l028rj6zrbw7fkyvRnXVus3vUw7w6kObt2W0/KMHAn
         izldOGZqHQiIOHAIJyz7PlEWSQfLIF6r6a+ksRGzxJSo5LuvY4CB4nU0RxZinKzgGgr4
         YddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uJNbDyi7iYddRfY6PB4IGhLFwOJFB/6azLoIbj2eVt0=;
        b=vfrgSRXKBIfX4hntYYL1P2MnkzaoF2KgKWj9YbOeX2L7GUogyVr93e8sg374wfNzf8
         DZ4T7/lDuEJ4qgfmLIIDNHbkyKVIunCXgSCoBva/boLI3CuiiqaxZ1AuSG0X7Klsb/DA
         pt5Wy4DZz9A6aSKxjy5Jq/Bcd2XZ/x8fSRIMVElbMOlJald4fW3ofCicnBNXQ6jDe2ih
         4vri9t3mw50FMLuGZhZcjL5QZSzLziajqkB1lYiqT0foMc6O8QP26hJOeKRY4YxMOhVN
         CT9C4SyLp6zcN0IvWmBmimQs7dRh3iyJRuWsQ2YnZcmYq35b+D4mX4yS6MeMhBv6CY9t
         ZeHA==
X-Gm-Message-State: AJIora+i7ryXIZqaNhCmLrBbMG0wDN6qjuIj21UcFyrGg1f1XQkRDx6/
        PL35OyBBsgB0fonnKV0Uthk=
X-Google-Smtp-Source: AGRyM1t4AvZsoA97Y8YSbTneEp69iJbnWr24L1Jebt+RK+smubYEbAguL/fq+0x6JGZ0zeDz2aT1Cg==
X-Received: by 2002:a5d:6690:0:b0:21b:970c:dc6e with SMTP id l16-20020a5d6690000000b0021b970cdc6emr7545075wru.397.1656579997014;
        Thu, 30 Jun 2022 02:06:37 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id v4-20020a7bcb44000000b0039746638d6esm5719809wmj.33.2022.06.30.02.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 02:06:36 -0700 (PDT)
Date:   Thu, 30 Jun 2022 11:06:34 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kartik <kkartik@nvidia.com>
Cc:     jassisinghbrar@gmail.com, devicetree@vger.kernel.org,
        jonathanh@nvidia.com, krzk+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH 0/3] Add 128-bit support mailbox for Tegra234 chips
Message-ID: <Yr1nmhtOTPej5NDv@orome>
References: <1649921757-16919-1-git-send-email-kkartik@nvidia.com>
 <1656528987-29280-1-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WwmdHsM7OFkf6Idy"
Content-Disposition: inline
In-Reply-To: <1656528987-29280-1-git-send-email-kkartik@nvidia.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WwmdHsM7OFkf6Idy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 30, 2022 at 12:26:27AM +0530, Kartik wrote:
> On 14/04/2022 13:05 +530, Kartik Wrote:
> > This series of patches adds support for 128-bit shared mailbox found
> > on Tegra234 chips. It also introduce tegra_hsp_sm_ops to abstract
> > send & receive APIs for 32-bit and 128-bit shared mailboxes.
> >=20
> > Kartik (3):
> >   mailbox: tegra-hsp: Add tegra_hsp_sm_ops
> >   dt-bindings: tegra186-hsp: add type for shared mailboxes
> >   mailbox: tegra-hsp: Add 128-bit shared mailbox support
> >=20
> >  .../bindings/mailbox/nvidia,tegra186-hsp.yaml |   9 ++
> >  drivers/mailbox/tegra-hsp.c                   | 149 ++++++++++++++----
> >  include/dt-bindings/mailbox/tegra186-hsp.h    |   5 +
> >  3 files changed, 134 insertions(+), 29 deletions(-)
>=20
> Hi Jassi,
>=20
> Any comments on this from the mailbox side?

I noticed that Jassi pulled this in for v5.19-rc1, so I think this is
all good now.

Thierry

--WwmdHsM7OFkf6Idy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmK9Z5oACgkQ3SOs138+
s6Gudg/8DgII93awSrn0zPqHH4iVbdt7+bNw3RWZl57m85wwEsIiTZ65eThqtwiB
GPn2Ee5Tm6EVMOCfngLSdMOiW29xnNyqUynLR1xWKVkEvZejAs1T3mOZ5T/HNSn3
+Ky4iA9lOxM10VdKQS4nMDpN4eRq0Ync/2UGrgl/V7NUcSTWLdZ2gnbYBiDlDLZS
OSOVP1c6yrdGHLl5ngl1FRjaJyK3IS4YtoegdF8pM3zLnZokgiwxRCoXzy7sT4Z1
z30/u78QzsXcm1hXbprrPP0V0MmfHWJOIkAKJNhFN2hVXXU/9pgLvc94HuPO4Pb4
IvUPBITMdgA0C7/5hj0X0ZekRpaqBM5vRG9xjwCjQNs7nUV1Zty1ayTh9GLLJKbL
eHUtnRf4qZiM+37UyG7LwZhC/6coo0xiwDj4edBGcPVPL3/JwSWKDlScuyHj4yH6
tVXPXGIjTD8KC4U9P5tJBLHWkpAjFLqeyNr6Ylzzs7RUh0DMRxqMIcrpZUtMSJ2z
TFYpy4VnG5F8rdixwH8M9zxHypSRhFwT53dDUtumeLXR7+p6CRp5qICbKMzUsq0i
zPQzyf7vvLSomEFXsHIfzmgw7qnWWB3ozct8yOIJw7eyjwJ5ShdpgzgqaphtRo1K
oRe2ZlXrADaM2x8jV0EASgOlUpLIpHDmJEoGgm4izkiBp8jxB/g=
=goh4
-----END PGP SIGNATURE-----

--WwmdHsM7OFkf6Idy--
