Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F022562338
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbiF3Teg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbiF3Tef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:34:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E885840A2E;
        Thu, 30 Jun 2022 12:34:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 404ADB82CF7;
        Thu, 30 Jun 2022 19:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C204FC34115;
        Thu, 30 Jun 2022 19:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656617670;
        bh=wuKRXOfmB8SfRRAwoXNDYkZyOABp9iiRq5kh8gETWtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dUP18hM/+Z0ZRBUe7RjiwFe60fIYiNSC6bQfruGZ1cLgBrtRsa4yPDJD4a0qeyne2
         H8p3DVMlNt7MhoULUhCBI4jVTWxNDW++jS1V9zvjZrNln8Li/suhwZybIW8SAeqxkV
         6kEo+5nofDk6edE5uFCi3odOuZwh5jeEoNPu76v4Gv8lCUFQf6cPQ0UKCyxwthThZq
         /yyUSpzmq1KC0yHC6+IxCc1qSzuKCMFBurkBwdZoa2iJXjuW/0tOG4eswHDjfWUmrt
         NOVJH51XCPeaSn1oMdT+WGZOYyzsJxMhvb4IqzgqT89b8kaKoT3F7tweWXY158bWPw
         1+pZ/+BgC3yxQ==
Date:   Thu, 30 Jun 2022 20:34:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Stefan Binding <sbinding@opensource.cirrus.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-acpi@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v5 2/2] ASoC: cs35l41: Read System Name from ACPI _SUB to
 identify firmware
Message-ID: <Yr36wcXf1/bNS0a3@sirena.org.uk>
References: <20220630150135.1799535-1-sbinding@opensource.cirrus.com>
 <20220630150135.1799535-3-sbinding@opensource.cirrus.com>
 <2cc37f6d-72a7-9064-cad2-c6c6d21ede61@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6WIiVmLhV0mRmQLA"
Content-Disposition: inline
In-Reply-To: <2cc37f6d-72a7-9064-cad2-c6c6d21ede61@linux.intel.com>
X-Cookie: Today is what happened to yesterday.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6WIiVmLhV0mRmQLA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 30, 2022 at 01:35:05PM -0500, Pierre-Louis Bossart wrote:

> It's my understanding that the _SUB method is optional, not required. It
> may be wise to plan for a fallback, e.g to use DMI quirks or other
> identifiers, no?

Presumably the fallback would go into cs35l41_acpi_get_name()?

--6WIiVmLhV0mRmQLA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK9+sAACgkQJNaLcl1U
h9C/Xgf/eroOM+YAPUoAaPvxrWc9YxHojGREu1luQnq3pYAoa+AcA8+oOIMLMp/V
iEglKVXB1Lcb9j1XN9O3zFFikHyvlbsYmtZCNgbfJe6cY6ea2TllZDuDixAjtE0D
eJiL89ksDLjfEMqm4LPeCVp/CklyHDA95DJjP7KQWE1G5qNYzXuydDD7SuS1uR1W
CgR8h+r2RHtIOrYVz2zun+HgEnIdjmEscfWCBg0HE9TPndEr6ByxXIkaL0/N0CAY
t2UukWklkWH1bbhqrHCvfBq7uEGs3n8tMuaXxTP9LAaiaoDytDMUuP79zHphoxya
AUJYkR0+xevNWE1S/JCM3F2EeexGYw==
=z3ss
-----END PGP SIGNATURE-----

--6WIiVmLhV0mRmQLA--
