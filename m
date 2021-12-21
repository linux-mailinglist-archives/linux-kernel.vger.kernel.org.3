Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED62847C092
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbhLUNPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhLUNPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:15:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD12C061574;
        Tue, 21 Dec 2021 05:15:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F416B816A7;
        Tue, 21 Dec 2021 13:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2517C36AE8;
        Tue, 21 Dec 2021 13:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640092549;
        bh=sk0Q9IPjJ44wyQeKhwyoUIo8aDfFP9mAvviunqg2RJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m6Ru1qA/BwMNoRmlG3JT9QXGR7mNlPURyEPBPgg7O2UVh+qO6kgbt5FD21wOiX+Bn
         NZ7W2z6fpqKzcBDwnmLpsgGey4EyfMeELoFvvqROKvH7klb6kMzwg3OxYtArZaKZP1
         RxWpgLvHHpiiPsoh+vaQOIRDhZ9CO0v2iL0aNqYVxpwJtb4TZUnPK7+TbM4SV7kfS6
         HyNbs6hoJotoxtg0Ln/agVd71oHIvWggsl3yIIgH9YEPIFuHIoZjvGbdmFePG9aDaN
         EWPywZM1HhIcAcar0Fl6PppzJSR96PwF+t/cqynz7rjo0UiUeb9mi26QjVlU7KF89J
         LmbcUT7+cUE9Q==
Date:   Tue, 21 Dec 2021 13:15:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v10 1/10] ASoC: qcom: SC7280: Update config for building
 codec dma drivers
Message-ID: <YcHTfh8ojUc1wB7W@sirena.org.uk>
References: <1639503391-10715-1-git-send-email-quic_srivasam@quicinc.com>
 <1639503391-10715-2-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9LTqFLt7kVn5dSDb"
Content-Disposition: inline
In-Reply-To: <1639503391-10715-2-git-send-email-quic_srivasam@quicinc.com>
X-Cookie: Use only as directed.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9LTqFLt7kVn5dSDb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 14, 2021 at 11:06:22PM +0530, Srinivasa Rao Mandadapu wrote:

> This patch set depends on:
>     -- sc7280 machine driver patch
>        (https://patchwork.kernel.org/project/alsa-devel/list/?series=590035&state=%2A&archive=both)

Can you please just either submit a single patch set or hold off on
submitting this until you've got the machine driver merged?  Both are
going through huge numbers of revisions so there seem to be substantial
difficulties here and having to follow web links to figure out what
patch sets you're talking about when you talk about dependencies is just
making things more complicated to manage.

--9LTqFLt7kVn5dSDb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHB034ACgkQJNaLcl1U
h9DKsgf+KSR5/R77djrkp5CPROoyS7NGtEZZ1o4SzjI1cl1P6waYki8BHEN7K1ZE
uibXZZSeqbxRzSxb/1gn86KWUP/arKBmZRBZy7VESp1jIp7sGmaI9FQaDHe3i/CQ
QnqU7nBbQvxuh2uquOOOpidfAoZ3t3bT220ZNvjT53Ck4mkqqGet7/CrigdmJkxL
cjGMHM8Ps/vDSSNCJ/2pcYotf8+FqT9sPlss4vyNFtdzgzSGVfGSyAuDl47l0QCW
VSiDU/AslHMLFcpESz9GnvKxYZW9q8YdTLgYCoQWiYUEWyXeBTKfxSEcU+N8akU6
i7C4mlIOtcD4DP8NHGgnvPLXBa/+zg==
=5IV1
-----END PGP SIGNATURE-----

--9LTqFLt7kVn5dSDb--
