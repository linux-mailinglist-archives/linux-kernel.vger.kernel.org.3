Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9A25211E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239624AbiEJKPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbiEJKPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:15:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AA3590BE;
        Tue, 10 May 2022 03:11:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KyDMZ0xCJz4xVP;
        Tue, 10 May 2022 20:11:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652177466;
        bh=S1P4LJSs2fztXdIb1b0S40TcrFL4D63H4AM+c822BF8=;
        h=Date:From:To:Cc:Subject:From;
        b=bwSnDsoJm5hZ9+3ah40G1tHntGhP2oeF6V7amSX2u+My1FXzkmj7PtgjyztAQAwCV
         m05ZNXwHLUnjTxhsK6IU19rBpNxVdqdHwUdnlbIVnPViE8QVrPqAb9XnkWOZbZPNWS
         iCkvUDkV+lkPdSyDl0/c4NT0HhNW+0K88RWnqmvNE8Vv/vqgdc2oBZ907AX7aQvO5o
         kTvYCV6w5/2ZQ6zgfZSgr6lL9DLTTU3VF/at1P5sPrRvpg6JOBLFlUAZts5DwelN2X
         jDzQPU9CcJu3ZowY7hvgvlS5SKfexH4jJbbcwcV5sbycX2eShZV3HFNDDTlXpBKWpk
         +RoM0Uxv3HkVQ==
Date:   Tue, 10 May 2022 20:11:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the hwmon-staging tree
Message-ID: <20220510201104.06eead74@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mC4tIZTQVe.tGy_dMrElgm4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mC4tIZTQVe.tGy_dMrElgm4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hwmon-staging tree, today's linux-next build (powerpc
allyesconfig) produced this warning:

WARNING: unmet direct dependencies detected for SENSORS_NCT6775
  Depends on [n]: HWMON [=3Dy] && !PPC [=3Dy] && (ACPI_WMI [=3Dn] || ACPI_W=
MI [=3Dn]=3Dn)
  Selected by [y]:
  - SENSORS_NCT6775_I2C [=3Dy] && HWMON [=3Dy] && I2C [=3Dy]

Probably introduced by commit

  58f1d9ebfce6 ("hwmon: (nct6775) Add i2c driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/mC4tIZTQVe.tGy_dMrElgm4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ6OjgACgkQAVBC80lX
0GxRPAf8DyURQQXjkDizSLrfH1OA9CgD7Oy0jkniI5ksXAoF+uSnWaFafcjqCCoY
AfafJCklDNcEiabnFrS06ad0GZxsExsB+306PVQ8VgjvJfpi+OE3KKSc2psm3MIX
wiHHllelSeGuDDj2NqmjO2eEXe8k8MyMZd1D2qLftvT3sdTALDjxtptEWwxMXqBg
l9J9zC4yAK6FnNK4mxLOwWCUaNOsOqVpB6lfhDns5yGR/ZoO1lTUSDB6P3Vn+tGc
ZyCoVlHGuHYDnHfrqqKNVVEgrEBhJAABHKSG+yCtjHEAOwkw9ZucMWTE1t1+Jo7s
jGYcV7j5RtAH3qhFd/G/vv2LnyYl4w==
=z2Pb
-----END PGP SIGNATURE-----

--Sig_/mC4tIZTQVe.tGy_dMrElgm4--
