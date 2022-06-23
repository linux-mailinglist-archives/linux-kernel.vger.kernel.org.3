Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BC5557E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiFWOsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiFWOr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:47:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064B8B4B9;
        Thu, 23 Jun 2022 07:47:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE5D3B82426;
        Thu, 23 Jun 2022 14:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D57CC341D3;
        Thu, 23 Jun 2022 14:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655995676;
        bh=cVW/kgQpXJWCmFWawpulENWZ9nuTYJwKw90J2PcvUho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WwvRRPERU7/n1H9x83+cRvjgAYhmsAkEqz32DJNqc1/MQ0fkJP7Jel7G11snM/vEN
         ++VccnxAVGMQ4qQO3599ZkiW2xPghx5zi3e6MJxDdWRXCbvrIgWTnPkj6BEfar8nT7
         Qm+YRYznpVQQm7ifdWEIPs77wgd0kpIMHXldr/Dr22RNOPFK06yHLdydHROs/WmLd9
         fG42R2XYnq3MuJkc1uYumA3127YhPbnU8sDuE2UW4+uI64eMJZhoSQtf3qswU7nOZv
         yA8l1g2bcvzXdQJqSceOIS4kqq2bbOpT+UoaxMiXpuv3xqQTs80GKw3+rzn6TdwNKF
         xBzFCn6mk1pZA==
Date:   Thu, 23 Jun 2022 15:47:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: fsi: Increase timeout and ensure status is checked
Message-ID: <YrR9GJFANKvbx8Vy@sirena.org.uk>
References: <20220623140547.71762-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M67xyN3jrJNiPOtR"
Content-Disposition: inline
In-Reply-To: <20220623140547.71762-1-eajames@linux.ibm.com>
X-Cookie: Honi soit la vache qui rit.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M67xyN3jrJNiPOtR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 23, 2022 at 09:05:47AM -0500, Eddie James wrote:
> Only timeout after at least one iteration of checking the
> status registers. In addition, increase the transfer timeout
> to 1 second.

For bonus fun points the timeout could be based off the expected time
taken for the transfer to complete.

--M67xyN3jrJNiPOtR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK0fRcACgkQJNaLcl1U
h9CGFAf/T6DCZY56eE7eLZc1a5MLOluTdugRinBQMf6Wmmv5A0TpJ/BnWMXziFAg
P7JQLMnytObw+DkvFpt9Gu50uEByyyE0tQhPKPi2l0tbW/ZQ+FOCGpZSbERDd9j7
VbiDhy58/ytVd85Dv3mLMLRi2njonmm5PfP1SsIVbX403EW6KhxiWnj9DomRkX/a
KIZ5iIoltOLm6J2xtr1JkiGx7N94Fs2d1HfRUsbj2uo0oUcy6kwdSWNd0nKj8jBO
bN4NFidN3RVZFBgG5/HH5yttviNeDuGG2+9bG/6WQy0Xhlo1RwiL9bzc7HPwVRhU
y2RALLof9gHCxBDDGpsJb6oxom3AJg==
=YBjI
-----END PGP SIGNATURE-----

--M67xyN3jrJNiPOtR--
