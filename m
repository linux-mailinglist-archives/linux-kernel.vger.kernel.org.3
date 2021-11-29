Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238B8461AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 16:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349796AbhK2Pau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:30:50 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36022 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343500AbhK2P2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:28:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D30361565;
        Mon, 29 Nov 2021 15:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F964C53FCB;
        Mon, 29 Nov 2021 15:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638199530;
        bh=+vq3MHsDvipiLoV00ftYjxoi2wc+BhfhHKvogme1oFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uV5vwLPAc4rEds27VkcqNfeQwjNyY15b7jf8rGqViVuL2hXtNeVdD0BxBNmh6SSQc
         UCEo/QYMBFom6mVPNgcJhx3CxV9OM4X7hv4sUlzDH+qMgOAh0YGb7ZEi2teSX5gKvA
         QBn0lKi1USTNm/4slq772Pn/J4jlBufG3OVdDXrjthVdJeXOF/s1Gn/lYKYe0Wj4ZC
         URvgZpU1pw2qT26NV5MDS01eof2gcxcU1RL8FlX9JPycLEkDcuQksTxqZ+4lJr5uYH
         WfTfhlfVd1Q5iOxiIv+VK75rVrxRI0LWl43qtguGXdUjLu8T19/+Rn9mm1TQ2dxipU
         ha7XGwrUCsTWw==
Date:   Mon, 29 Nov 2021 15:25:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH v3 3/3] regulator: da9121: Add DA914x support
Message-ID: <YaTuUS4GwZ4ON7fz@sirena.org.uk>
References: <cover.1637709844.git.Adam.Ward.opensource@diasemi.com>
 <31d387d0a364eef9d5ef72f0adf6d213197a4dfb.1637709844.git.Adam.Ward.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MTFxC0I+jVmjt9gj"
Content-Disposition: inline
In-Reply-To: <31d387d0a364eef9d5ef72f0adf6d213197a4dfb.1637709844.git.Adam.Ward.opensource@diasemi.com>
X-Cookie: Pass with care.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MTFxC0I+jVmjt9gj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 23, 2021 at 11:27:58PM +0000, Adam Ward wrote:
> Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>

This doesn't build:

/mnt/kernel/drivers/regulator/da9121-regulator.c:571:8: error: 'DA9141_IDX_BUCK1' undeclared here (not in a function); did you mean 'DA9121_IDX_BUCK1'?
  571 |  .id = DA9141_IDX_BUCK1,
      |        ^~~~~~~~~~~~~~~~
      |        DA9121_IDX_BUCK1
/mnt/kernel/drivers/regulator/da9121-regulator.c:595:8: error: 'DA914X_IDX_BUCK1' undeclared here (not in a function); did you mean 'DA9121_IDX_BUCK1'?
  595 |  .id = DA914X_IDX_BUCK1,
      |        ^~~~~~~~~~~~~~~~
      |        DA9121_IDX_BUCK1
/mnt/kernel/drivers/regulator/da9121-regulator.c: In function 'da9121_check_device_type':
/mnt/kernel/drivers/regulator/da9121-regulator.c:915:55: error: 'DA914X_DEVICE_ID' undeclared (first use in this function); did you mean 'DA914x_DEVICE_ID'?
  915 |  if ((device_id != DA9121_DEVICE_ID) && (device_id != DA914X_DEVICE_ID) {
      |                                                       ^~~~~~~~~~~~~~~~
      |                                                       DA914x_DEVICE_ID
/mnt/kernel/drivers/regulator/da9121-regulator.c:915:55: note: each undeclared identifier is reported only once for each function it appears in
/mnt/kernel/drivers/regulator/da9121-regulator.c:915:72: error: expected ')' before '{' token
  915 |  if ((device_id != DA9121_DEVICE_ID) && (device_id != DA914X_DEVICE_ID) {
      |     ~                                                                  ^~
      |                                                                        )
/mnt/kernel/drivers/regulator/da9121-regulator.c:996:1: error: expected expression before '}' token
  996 | }
      | ^
/mnt/kernel/drivers/regulator/da9121-regulator.c:912:3: error: label 'error' used but not defined
  912 |   goto error;
      |   ^~~~
/mnt/kernel/drivers/regulator/da9121-regulator.c:900:7: error: unused variable 'config_match' [-Werror=unused-variable]
  900 |  bool config_match = false;
      |       ^~~~~~~~~~~~
/mnt/kernel/drivers/regulator/da9121-regulator.c:899:8: error: unused variable 'type' [-Werror=unused-variable]
  899 |  char *type;
      |        ^~~~
/mnt/kernel/drivers/regulator/da9121-regulator.c:898:18: error: unused variable 'variant_vrc' [-Werror=unused-variable]
  898 |  u8 variant_mrc, variant_vrc;
      |                  ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/da9121-regulator.c:898:5: error: unused variable 'variant_mrc' [-Werror=unused-variable]
  898 |  u8 variant_mrc, variant_vrc;
      |     ^~~~~~~~~~~
/mnt/kernel/drivers/regulator/da9121-regulator.c:996:1: error: no return statement in function returning non-void [-Werror=return-type]
  996 | }
      | ^


--MTFxC0I+jVmjt9gj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGk8OUACgkQJNaLcl1U
h9Ba3Qf/fudmMK2mcHcQWxAzzH0ya2kH1BhsxDakJuVhnEpOee/KEbpCmTQl7nBI
a4ZQmR4N4BVfmNXXXKuohSihLYZlsMFekL8SNCqscIs7Ge4AVYvOkDxfMRDshGJo
vNZ/fp59gqTVd2qQA1CTg2OsKoad0oT6sMabsN801u53ujipHkshUI9pvKS3HSL7
fVw+UKcmBd1hsON6GdkO/p86KqlIBEWojUUe9uT8V/cMjRzX7/jkfmO5Y55T0fcE
/8dB/bvR/0Kr8oDVa5ffWYwraN5JGs4iwnaMEtktkn60EmX/pypXjy4641pKtOWL
VeeT6TxeYAuoy6DM/XJoSB9Z9JCHCw==
=M8Nr
-----END PGP SIGNATURE-----

--MTFxC0I+jVmjt9gj--
