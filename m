Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F875577209
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 00:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiGPWrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 18:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbiGPWrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 18:47:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89FD1D32F;
        Sat, 16 Jul 2022 15:47:34 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9228A6601656;
        Sat, 16 Jul 2022 23:47:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658011653;
        bh=7FNi7T4eB1twiUmJolfwgafVKwxysc+ocRSmHJ/8Jcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C/A6IMmovSxQA/bN1uCnb2RdaUj6KWy6PK558zJW4LpxT7vz3+RRbFpCmk6XFRUUM
         3Z+iT6OvwZHpq3KEYMRbMW2xTup9qJiu91J/nF5JMPe7z9RXf4N0GyMVN1YAvodmDD
         0tK/nHwUbbtFuXVqOYb00Es3mYJIl5H/6j0TBroy7e2uLbPmfABL5YUgb/vCY0HmWw
         ce3DLJ8pvxK169pwTmkYtfPPMO4TzeRH4NMkIDzFLiIdRB+9z0ZFQG8P0cA/kQ139+
         k5iUjwdCRoRa2wLv16L3DirWGaRcm3TlEbhm4NhIpHAuM2Q+KSv6VAo/KTybblfSbF
         zKF/cHR7MXQcw==
Received: by mercury (Postfix, from userid 1000)
        id 877971060428; Sun, 17 Jul 2022 00:47:31 +0200 (CEST)
Date:   Sun, 17 Jul 2022 00:47:31 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: power: reset: qcom,pshold: convert to
 dtschema
Message-ID: <20220716224731.hqfyjflj2fgavqzk@mercury.elektranox.org>
References: <20220629123804.94906-1-krzysztof.kozlowski@linaro.org>
 <20220701173601.GA1190424-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4excbmbreoxb3cwi"
Content-Disposition: inline
In-Reply-To: <20220701173601.GA1190424-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4excbmbreoxb3cwi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 01, 2022 at 11:36:01AM -0600, Rob Herring wrote:
> On Wed, 29 Jun 2022 14:38:04 +0200, Krzysztof Kozlowski wrote:
> > Convert the Qualcomm Power Supply Hold Reset bindings to DT schema.
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  .../bindings/power/reset/msm-poweroff.txt     | 17 ---------
> >  .../bindings/power/reset/qcom,pshold.yaml     | 35 +++++++++++++++++++
> >  2 files changed, 35 insertions(+), 17 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/power/reset/msm-p=
oweroff.txt
> >  create mode 100644 Documentation/devicetree/bindings/power/reset/qcom,=
pshold.yaml
> >=20
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks, queued.

-- Sebastian

--4excbmbreoxb3cwi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmLTQAMACgkQ2O7X88g7
+po3tQ/8Da5CXpld4aDEDNmR+nv3ukpVThQAEtmxKTu7nRJ3Qps4/cL0xR23QKAp
sdSzJ/cYDkqAYA5tzDMyX1B1GfrJtcT3cQwcX7OIZQflm6LusBUakO1DNr0lro0x
aBkT4HFSAZHHX7eBtPmlWgPoje06Tkxrx6m2iXsZnbbHGNtDGK5ZhC9c0Eae4Pty
2DtdRhcfF5A9XI7zVL/YYUqhAPRY+oN4iOzFaNcKxD7EHs7bTpUOlZg5uUDa+a+a
3z1y9HY8qPYuGTz2FYhwtFRoTJ+5OXIXxxe2rcnnAhJAXa+bqjctSXxstU7SuvNk
SXpu6lWoKHkkDhH08MFCPuyZNvE6Bh2txeQoXFWDJsy4WJ42Kx0getxc2XBANVKG
KxbUE7OmfAlDMAcHZySfBhlDDy6XWzur05QW8NTAKrSMk3rETGb0ct434/fBMTrQ
n6gvpcIGj+zQM0Sf3G0PBb4pwGhdOBDA7y9ujOHd7uvljx2wHwj6x0DNz9kGFKrV
c5bljIiMg2RtrrhvYmI1uIz1YgkFrczXfinwUPSQVC/iSLlKJ5UZJQxOB2/Eeacg
rqeRfkMzeMC/OB8kHOGp0l22AjISeO7G+lqeh6FcKQGp3HAan8vbkvAajs8kdN44
5ZHvFDCyr1d8A0BedTZE46MYcnVV318a7ejYB9SrJyLN0SgF2OM=
=WQkT
-----END PGP SIGNATURE-----

--4excbmbreoxb3cwi--
