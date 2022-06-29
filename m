Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F254560704
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiF2RJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiF2RJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:09:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE80B1A05E;
        Wed, 29 Jun 2022 10:09:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DE72B82603;
        Wed, 29 Jun 2022 17:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D836C341C8;
        Wed, 29 Jun 2022 17:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656522588;
        bh=4bJvFFx7ZcxPoQfjBr9hzR8NIRYqurDvP08BnkCGIfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SO91+wnwTa89hRSXSoTp79ezg57zJGwf8HGqcEEn7epijpLCS8vAZnSLxA1x8CO1Q
         aqCGDCX5pkN23N6MvilsV0Q6lrH9TJpR0IDCuqxqyjp3eqXRg0x6v6B0v6AxlNDSHj
         69szh3v2AH/ZCtAN4xlDy0tkGdKPEHhFc3AbwR5f0LEAn5y0b8tc1oghqnIexY+GtR
         nBnPKxStD/oTzMF6q8w00jjgjYZAh1F8L5Bw1b+10G5oOiB8RDRpfL3GM9sFmGeDEC
         DllLL4qEZueiq4lG8pEqsgbgsovUv20WBC10MWYX9hbuEuaCNhspurOOu/oQebSZ+Y
         PqGWCfgpLCtXg==
Date:   Wed, 29 Jun 2022 18:09:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc:     linux-spi@vger.kernel.org, Pratyush Yadav <p.yadav@ti.com>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ian Woloschin <ian.woloschin@akamai.com>,
        Ian Woloschin <iwolosch@akamai.com>
Subject: Re: [PATCH v3 2/2] spi: aspeed: Fix division by zero
Message-ID: <YryHVsrqNlhdwKzq@sirena.org.uk>
References: <20220622161617.3719096-1-clg@kaod.org>
 <20220622161617.3719096-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mK7klt+5JZlbXfIT"
Content-Disposition: inline
In-Reply-To: <20220622161617.3719096-3-clg@kaod.org>
X-Cookie: Victory or defeat!
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mK7klt+5JZlbXfIT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 22, 2022 at 06:16:17PM +0200, C=E9dric Le Goater wrote:

> Fixes: 54613fc6659b ("spi: aspeed: Add support for direct mapping")

This commit isn't in mainline.

--mK7klt+5JZlbXfIT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK8h1UACgkQJNaLcl1U
h9AVewf/WQAmOe0+ScAYOGgcQEmnOEp4TS1cWQo0BAxd7OgZqLodwQqLfeM2CaMK
SXelE3kPHJunj/B2YC11bTbsgi8nvoA03dS6BXF8i2LPRzQq7+294VdOgkdap5ei
WA7lqQRSDAyaA4hAAJQqKSSM2zT9RYoXlVUXf/VUXX7KyLhMBjFuO2MuioX6Pzxg
VCcwaTnaximxm/beko5YUoaDgiixxbSA6L5yLAXckzD7OZ7xDhXllZSfd5A9/xe8
o9JRYNo8tutfLxLjCwBK0qRLgu9cPy++YF4qX8HfdayxRE1GXd23BH4GK0+8EhNe
vxvDGPtY4UV7LSZAFXFDociwrctE8A==
=Ag5J
-----END PGP SIGNATURE-----

--mK7klt+5JZlbXfIT--
