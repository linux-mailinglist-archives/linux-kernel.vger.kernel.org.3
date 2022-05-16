Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B97528366
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243257AbiEPLin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbiEPLih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:38:37 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB8BDF51;
        Mon, 16 May 2022 04:38:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1y1j3rRPz4xLR;
        Mon, 16 May 2022 21:38:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652701114;
        bh=6qoSVynq4MVKfKPbP+m+b4Bp3oJILzONMsKFVTcS53o=;
        h=Date:From:To:Cc:Subject:From;
        b=tVt7UJMDVPobYRHZW1BSfALegVEx9iMPvI8KRfpk6CVRDyCs9zIFlC8bgazv4/x7+
         VYtjaaTobidfO4e34iCJPTTLfpRAPO+m87uCJ+W20wiAPYeIwqlur0dT3w88OZHrfp
         XVBbTJ/IzT5DMwXaLsgykrbn1B2GVCHOZPlnGblIDqK8EjnWYt9gT6HzG8+8U1wofn
         UXqxv5rE2m5joyEq5+igtrV0fQwnfwYBrg7eECsrqLSLalH5hm6VxF2IypYa9P76KG
         QLibS7gXy0rQ5kOeMBAg0JvStbmTNOkj00EdcIqITkXAnI9gjdFNAwkuR4uCmHmiZw
         J15QjlXsPwdqQ==
Date:   Mon, 16 May 2022 21:38:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the chrome-platform tree
Message-ID: <20220516213832.19127535@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/scABjfy2Hvip=ZH1ZW4XzCZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/scABjfy2Hvip=ZH1ZW4XzCZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the chrome-platform tree, today's linux-next build
(htmldocs) produced this warning:

Documentation/ABI/testing/sysfs-driver-chromeos-acpi:2: WARNING: Unexpected=
 indentation.
Documentation/ABI/testing/sysfs-driver-chromeos-acpi:11: WARNING: Unexpecte=
d indentation.
Documentation/ABI/testing/sysfs-driver-chromeos-acpi:22: WARNING: Unexpecte=
d indentation.
Documentation/ABI/testing/sysfs-driver-chromeos-acpi:56: WARNING: Unexpecte=
d indentation.

Introduced by commit

  0a4cad9c11ad ("platform/chrome: Add ChromeOS ACPI device driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/scABjfy2Hvip=ZH1ZW4XzCZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKCN7gACgkQAVBC80lX
0GzpZQgAjHbunM+QHoLVIZ+ARIgKZY2CLTFmXdIJlcjKQ206bc7fXAe7YNt9Z30c
CHiRcUDJEGp9eqTD1py7p2SI2FPrvXIHJEphBemaeo+hYLCDnmCXYsCTVuIN/NeY
xuOYcpEOIt+4lFLVjmSKTsKdfFyDqM2dFQTE3ShGpaQUEoU21yNKk9W4ueNe9Hsa
g6/TD9miiXOXTN42Zew+raVmjl1LfposwxMZzsSANDVxo8m+fyDiiC1AaEE+gNHG
cGIro10TFMr4tFp28eMiDv3Zcmd/Kr5rVatSweYBJ0srLdGMNaWnqcCHldNislGq
LWgSjr/ZUxAneYUROCMFVtZl9Lq+wA==
=e8yP
-----END PGP SIGNATURE-----

--Sig_/scABjfy2Hvip=ZH1ZW4XzCZ--
