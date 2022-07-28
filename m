Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F6F583CBC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbiG1LAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbiG1K7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:59:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E7866AC3;
        Thu, 28 Jul 2022 03:59:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4CF8619F9;
        Thu, 28 Jul 2022 10:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761CEC433D6;
        Thu, 28 Jul 2022 10:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659005972;
        bh=W8zB8u+278oI2Tht4FAyuNGpeZIppdQ+WlcUV9UCJsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jW5Y/C7RYDe8wN323emUqPgme2owEznQSSBwaHbid2pZxzqc0L9J58Xjn9Bo1zpJ8
         tqg5bXhA8eJt8IQ/0FjKOCTiXjhXa6p/mXMdM4v3J88W4u8dJoDJPbUs5alkVS/QHL
         uSPilmRREd0l1NgNt2LAOl84khY3YMBKcZg+M1/zVu6z6Wy9K9iAkXsbpWKcoghaf3
         Ao/vklow/p/yHaLd1oBn4oJ2GUGXxRpRFRsfNTT+ZlPkhQobkakGPJlrdrMljHChAz
         /iG3+nwrE6wdRaZnDRXHJbTqgo3m0KJ42oQoLNbACxRAuR5emPevgEKi4pETKv9/J6
         8u/rYqDr3FW/Q==
Date:   Thu, 28 Jul 2022 11:59:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
        lgirdwood@gmail.com, eddie.huang@mediatek.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        fshao@chromium.org, sen.chu@mediatek.com, hui.liu@mediatek.com,
        allen-kh.cheng@mediatek.com, hsin-hsiung.wang@mediatek.com,
        sean.wang@mediatek.com, macpaul.lin@mediatek.com,
        wen.su@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 0/1] Mediatek MT6366 Regulator patch
Message-ID: <YuJsDI8rqkHuysIT@sirena.org.uk>
References: <20220728062749.18701-1-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EF9Dhh4p1JnapVZl"
Content-Disposition: inline
In-Reply-To: <20220728062749.18701-1-zhiyong.tao@mediatek.com>
X-Cookie: People respond to people who respond.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EF9Dhh4p1JnapVZl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 28, 2022 at 02:27:48PM +0800, Zhiyong Tao wrote:
> Add mt6366 binding documentation

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--EF9Dhh4p1JnapVZl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLibAsACgkQJNaLcl1U
h9BQDwgAgnCNhlgMGhYw7HaqbKgbrRyZJJcsqo6ZGtKsrelWYwC9Dl6BAHubd0Py
6aJjP2A36ng35571uUI8/CcvkzCh0K8ohBE2+8UgXElPMJH/7i2Lvmxwz9REshOX
gYY8sV02SitN4wj6xWsDJbRqQDKNadHtw6GSYbyR3UaY6PP9egRUFMQTU1oT10Lj
FWT6PG5LqAzzSuAGBuLN9x2u5XdLKkQzfrUC4hffFiodazOnEWncI6StFPNK3tk0
5Lw+npv2e0u5jlR53jIaZnsnkF9MlsZV7PP4odHY31xhm4bMMo0bmbGct3YG/IkL
wz6MXlA/ueBsF1SvmpRBsKRaeWGWPQ==
=9UEF
-----END PGP SIGNATURE-----

--EF9Dhh4p1JnapVZl--
