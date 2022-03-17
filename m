Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAE94DCD34
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbiCQSLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbiCQSK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:10:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D201AAA6E;
        Thu, 17 Mar 2022 11:09:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F17D61645;
        Thu, 17 Mar 2022 18:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423FBC340E9;
        Thu, 17 Mar 2022 18:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647540579;
        bh=+QvcLNYNLk8z+Trz3uCkGKDhIM9gllwONqzhspxkHyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gWB1MPFYLKL2w4IRkMzG8oZFR8/OcM+rzXWYl2UsWatYxmN/Daz8tWpi5xMNmD80l
         aRi9aUPVsGkUnzKP4FuyMB4u0P1dOrbjN1lJPEe6U9BevLhODQqntXlHA6BlvLO1R7
         K9Q2CyyCwZU0mF6m1nfHTzT9BSTpe60QtN7htFisrTJYFX4iT7jHShgGDKaNG3ApGR
         S3D/uNbFOHYzHIb8nSs1OKiG6u3NAfwNjDewJSXmFR18WTJUk65F52+x52EBx75phl
         9VjM2YR+Pp4CLCeEd5URd2kbsoHyBIWNz4r6iYCil8DIbcQakTABoqqpV8ObP30CJ9
         e5slxH9/HZlJw==
Date:   Thu, 17 Mar 2022 18:09:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Ashish Singhal <ashishsingha@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] spi: tegra210-quad: Add wait polling support
Message-ID: <YjN5XRuHU1ReFGOW@sirena.org.uk>
References: <20220317012006.15080-1-kyarlagadda@nvidia.com>
 <20220317012006.15080-3-kyarlagadda@nvidia.com>
 <391736bc-84c2-ec8b-9f04-614365953da3@nvidia.com>
 <DM4PR12MB57692EB17ABCA36E0515412EC3129@DM4PR12MB5769.namprd12.prod.outlook.com>
 <edcae0c1-a576-1560-5ecb-9dcf08d8ead3@nvidia.com>
 <7032fbfb-8899-d00b-a7fa-811e19d38ce2@nvidia.com>
 <DM4PR12MB57695F4DF462E705EC58D826C3129@DM4PR12MB5769.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vDOeRupVhPVhNhc1"
Content-Disposition: inline
In-Reply-To: <DM4PR12MB57695F4DF462E705EC58D826C3129@DM4PR12MB5769.namprd12.prod.outlook.com>
X-Cookie: What foods these morsels be!
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vDOeRupVhPVhNhc1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 17, 2022 at 06:00:25PM +0000, Krishna Yarlagadda wrote:

> > >> Wait polling still has to be selected on slave devices that can
> > >> support it.
> > >> I will add one line description for the properties in next version.

> > > I can't say I am familiar with this, but it seems that the ideal
> > > solution would be able to detect if this needs to be enabled depending
> > > on the device connected. Is that not possible?

> We cannot detect at runtime which slave supports wait polling.

How would the client device have any knowledge of how the controller
internal implementation works?  What even is a "wait state inserted by
TPM device"?  If this is something the client device is doing then it
should be something that is expressed through the generic SPI API by the
client device, if some controllers have some way of optimising this then
we can add support for that but presumably it's just something that's
generically supported by that device so we shouldn't need a DT property
for it on the device side either.

--vDOeRupVhPVhNhc1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIzeV0ACgkQJNaLcl1U
h9CKXwf+JvwR/r2buQv0cfR4FwAaEUnboaLw15RvPY50AkyFvNHI+Vkwh6HvQD86
PR7Smy8yCjrhHJOBln9tJ+/DH2IE4INXOvNrfODfRZmUspMx+U/1Rrq9MD9Om68Z
LMPSD17NwUkfU+BZlnxQ6EVu0dzBcPFESpCqcbTiOo1KxrpUsQ0bylfj8smGWmxa
xjXtr6jYLAOpdNmpIVZ7lHJW1Rncx2Wgk3Fcir1WDtjbv4PlphYaVn5isipMBTcQ
WXnYVvzvMvXduLMjpWfrwPQ8DVn8rYZvd0GvlcMMFv7u8o0h4VA2EzcLzV7BXqIy
HLpD6kWY9yKhJoO7d7Pao35pFEidtw==
=aJ6j
-----END PGP SIGNATURE-----

--vDOeRupVhPVhNhc1--
