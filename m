Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F92353F4E7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 06:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiFGEU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 00:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiFGEUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 00:20:23 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2891AB0A76;
        Mon,  6 Jun 2022 21:20:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LHHFs5Ws1z4xCy;
        Tue,  7 Jun 2022 14:20:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654575617;
        bh=Y2WdGWsv6mOoqh+sUTAUjzRNcVJtT+cjOUshoz71Qvk=;
        h=Date:From:To:Cc:Subject:From;
        b=RHdn0qU2oiZINpsHeRyjS4K/JvnvqP+qMoTU/FmZoXSjbgM1RDTNdQiLuzYTGrkyU
         /vSryrxzTlNog0T69K0+FJFL5W4cuOfY4KObjKmvAKv8fZKyWPDQTZR57Iw2RKqV7A
         aj0RPtE98tX+ZPDqq5KhtBINlwX/SnVMSFVJWDwlZHhRoEQJHyDBkQuDtADgmtLV49
         ySVZpMPxPem7P+BMFls6WsyIgOJS1PCMBTszm0avj8kJ4ZHFOsXFi4B92pl+CDv6TP
         D5Jm8rfq15XGw87fdIhSoVVXwXpSMdOXumoijfbTytJjONwr3su7uIhAMaugmJ2+Ev
         Lr+kLwUanMzLg==
Date:   Tue, 7 Jun 2022 14:19:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the hwmon-staging tree
Message-ID: <20220607141958.1e31971d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ANG4hl040I3.SCS3JgKVKqh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ANG4hl040I3.SCS3JgKVKqh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hwmon-staging tree, today's linux-next build (htmldocs)
produced these warnings:

Documentation/hwmon/lt7182s.rst:2: WARNING: Explicit markup ends without a =
blank line; unexpected unindent.
Documentation/hwmon/lt7182s.rst:75: WARNING: Malformed table.
Text in column margin in table line 33.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
curr[1-2]_label         "iin[12]"
curr[1-2]_input         Measured input current
curr[1-2]_max           Maximum input current
curr[1-2]_max_alarm     Current high alarm

curr[3-4]_label         "iout[1-2]"
curr[3-4]_input         Measured output current
curr[3-4]_highest       Highest measured output current
curr[3-4]_max           Maximum output current
curr[3-4]_max_alarm     Output current high alarm

in[1-2]_label           "vin[12]"
in[1-2]_input           Measured input voltage
in[1-2]_highest         Highest measured input voltage
in[1-2]_crit            Critical maximum input voltage
in[1-2]_crit_alarm      Input voltage critical high alarm
in[1-2]_min             Minimum input voltage
in[1-2]_min_alarm       Input voltage low alarm
in[1-2]_rated_min       Rated minimum input voltage
in[1-2]_rated_max       Rated maximum input voltage
in1_reset_history       Write to reset history for all attributes

in[3-5]_label           "vmon[1-3]"
in[3-5]_input           Measured voltage on ITH1/ITH2/EXTVCC pins
                        Only available if enabled with MFR_ADC_CONTROL_LT71=
82S
                        command.

in[3-4|6-7]_label       "vout[1-2]"
in[3-4|6-7]_input       Measured output voltage
in[3-4|6-7]_highest     Highest measured output voltage
in[3-4|6-7]_lcrit       Critical minimum output voltage
in[3-4|6-7]_lcrit_alarm Output voltage critical low alarm
in[3-4|6-7]_min         Minimum output voltage
in[3-4|6-7]_max_alarm   Output voltage low alarm
in[3-4|6-7]_max         Maximum output voltage
in[3-4|6-7]_max_alarm   Output voltage high alarm
in[3-4|6-7]_crit        Critical maximum output voltage
in[3-4|6-7]_crit_alarm  Output voltage critical high alarm

power[1-2]_label        "pout[1-2]"
power[1-2]_input        Measured output power

temp1_input             Measured temperature
temp1_crit              Critical high temperature
temp1_crit_alarm        Chip temperature critical high alarm
temp1_max               Maximum temperature
temp1_max_alarm         Chip temperature high alarm
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

Introduced by commit

  3d6bcaa21fbd ("hwmon: (pmbus) Add support for Analog Devices LT7182S")



--=20
Cheers,
Stephen Rothwell

--Sig_/ANG4hl040I3.SCS3JgKVKqh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKe0e4ACgkQAVBC80lX
0GzwWggAoaAmQIsasPEyuwmGfK1HOYehykevqnWAWOnHFkMBZNHlCkR5zo1I9FEg
EUMmgASDuAiJDbrHDdq0aDGkw4wHzVrnz+TJhiBk+FcjIN7AMaCM5SXwfvwIg83g
PfxkmuThoB99xQ5IJvBUbY6AMO+0Pdzy4iT80Fo0APBuvM9dxEnbElPXoPQJKla/
ftULK+HeanQrFeSAKQUA1y76Qs9p6UF3HTGKR6Y5xcI+pVodiLgxrAPmVM3cMpVG
KyRODRM9hEgRedCNce9LBMR4dTEEWAZmje7qm2CVWafX1ar7fJjKrYFu0hbVHIBr
lEAANJloR5BR3D7jzUI9MyKCW1MLyg==
=/N/C
-----END PGP SIGNATURE-----

--Sig_/ANG4hl040I3.SCS3JgKVKqh--
