Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC656587E89
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbiHBPEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbiHBPEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:04:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D21237F4;
        Tue,  2 Aug 2022 08:04:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E144B81F2C;
        Tue,  2 Aug 2022 15:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404B0C433C1;
        Tue,  2 Aug 2022 15:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659452688;
        bh=iyTtJVEbln6OfBEVVllx/EGPV3y1Caz+SHF557VpTv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dp9q/XY4lvbNEjHTYjCxcYnlj7wSKJXBcKCh/vyk9m8CdB4UfxGV7lKtoh3vCd+SU
         cuMWfGtJ/QpArlVzqLXdj4vfTGmWSAZcHXNv7hza3qeTBHc8taBkWgGR4O+25qaHeI
         ntImp3rsukD6DwJLbLwaei0hao14DUQqtSMrX+V7ixxaX4rIJnnsyRe4WBkM/dR+jb
         puvKh1Qvh/MKZyWAfg8hmvuoe9av+F3O7tpMdq9cpdcsTX03ixs9h4XH0LbrkdJ/9F
         vdkdhSIZNEb/4SID5wBGYTH2fiIR4kMu0vRmC3C6twtE0y7QOVUuPIBeHjh0rXQCxi
         FynKhgCkmnogw==
Date:   Tue, 2 Aug 2022 16:04:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-samsung-soc@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the thermal tree
Message-ID: <Yuk9C07obs+uPQJ6@sirena.org.uk>
References: <20220801223509.3613888-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WFXrVHyTCSFT868G"
Content-Disposition: inline
In-Reply-To: <20220801223509.3613888-1-broonie@kernel.org>
X-Cookie: Stay on the trail.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WFXrVHyTCSFT868G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 01, 2022 at 11:35:09PM +0100, broonie@kernel.org wrote:

> After merging the thermal tree, today's linux-next build (x86
> allmodconfig) failed like this:

...

> I'll figure out how to handle this tomorrow since I don't expect to
> release today, I'm just droping the tree for now.

The error persists, I have used the thermal tree from 20220828 instead.

--WFXrVHyTCSFT868G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLpPQoACgkQJNaLcl1U
h9A1Twf/dizOI1Kgx43C5jAQoQzqH07HH6V5lnCkKLeiCJmN+0dGXvB2OmUiEQ0g
rHjZTnLOc7cCLkIAXKyoiNCL9fKMGfxzcYlQfBxuKInMRgO7ko6WiDw1qFde5AtO
Vryq/p8Sxn6JI1GypnU5wbwYN5zcaRxRPphmmph6oiL3XzDB+4VjVhcnj2V25TFR
G6qbXb15xUO8EosODrmHCfqrGJY4MqjPv1tW6zXKFcLTNge1XPwEC7p8b1PBoC4s
1umf5Di3RixE9WhNw9ydXJBXbYMltMr/HnUAYhQQa9ug/iHj8XcNg7D3o0A+eouM
/HPTsb2oNXlz6n2ch3GjCPWrh4kz0g==
=umee
-----END PGP SIGNATURE-----

--WFXrVHyTCSFT868G--
