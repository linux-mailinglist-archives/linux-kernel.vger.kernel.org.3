Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05935A5F42
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiH3JWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbiH3JW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:22:28 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32598DAB94
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=raRrzqkFd5CCKbO1PqyENGyR/Paq
        rg3GUAkUnfiaKVY=; b=o4pY/p89of4Z9kZjGKWzR1se1BrpRSwLTMalK3/1pMsi
        /Uka8NagLQKjE+baPvpOPlR/zfEp0STX83+opezh808e6k0SLO3NR3oPd0R+GJo1
        f8zdCJ8MdanOMEI25GZtdf6e0FYXZ9gHecWLlXQnHmUJTJPNEghqTZrvCGbxwVQ=
Received: (qmail 206937 invoked from network); 30 Aug 2022 11:21:34 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Aug 2022 11:21:34 +0200
X-UD-Smtp-Session: l3s3148p1@Hdru53HnSOEgAwDPXyz6AKlRFcsoQyrD
Date:   Tue, 30 Aug 2022 11:21:31 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: renesas,sh-msiof: Add generic Gen4 and r8a779f0
 support
Message-ID: <Yw3Wm9D+9zGWlB67@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220824094327.33685-1-wsa+renesas@sang-engineering.com>
 <20220824094327.33685-2-wsa+renesas@sang-engineering.com>
 <Yw3WDjj7MzQjG8z6@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aN4JroXIk+/N7WnL"
Content-Disposition: inline
In-Reply-To: <Yw3WDjj7MzQjG8z6@sirena.org.uk>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aN4JroXIk+/N7WnL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Not sure why you didn't CC me on the cover letter for this?

After I got cover-letters rejected because of too much CC (but the
paaches itself went through), I wrote a script to only include lists on
cover-letters.


--aN4JroXIk+/N7WnL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmMN1pgACgkQFA3kzBSg
KbbgFA//fOHFmDXO68iU9/1UB0k32jeyyDrI/QMTjfFC+7epXC+1idRY/zgCbImk
6KB6svozIc9YYxE4V0TULP48BapFUXZe07AGHzIxnDvS5iqk1flgX3FsBDBpxmXh
dbcndvtoBQUR2Fl3IkLN0EXctpS7hgufjzU4yXV8ZPOL8JFfavlzgt8EEPGDWKjW
+Jrkd42Xi3FJxa5KwrEhGwd3Z/hrscyN+piYml/2FPJy34WYRE0BdTuVddOpLrux
IneoxKohhQzmdv/RWEvB5m80dtoDClyXXB4gLVi5qEunpsTIlmgVnY5nbhZSlPBG
ro/n9LPmbsxfRpMWmMf13Io2Y9w4BPrmKviv1w/M+TqMTHGva4hlKMKWPM53lAEb
199PA4+fyQV77IfWTwSaaRPq4nri6CS0E2Q9B56t87BNN9sEujP3BE5oxXOG9ZpG
+D5chboxigCW0EvWSB8VdA4QjwXYNpvDCTsUz1f5COOfmqaENLF2sQZC8K7zzky0
qbS0TdkxjElH9+QM7+ukolQHpF4eZ0BjNNBA8g/6sEr5WqgOWFlybLwqoyhx0SvD
mPqHQ92hu0pdZruE9o1DyxoKZymZ8D6xVd8zHbGIv4mq1qMRzqIIpQ728Dfairw8
dqId01OI0N4bS8lmufHOblfctjAIDIif1EAcRt6Ojvl2cM4W0TE=
=QidM
-----END PGP SIGNATURE-----

--aN4JroXIk+/N7WnL--
