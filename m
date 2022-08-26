Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6475A2B57
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239937AbiHZPfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiHZPfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:35:15 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68B411834
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1661528104;
        bh=Q24fXdYBNEceQhIyDpe9CNWOscXknyIfXHOgij1vNW0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=MIqIYmsMgPRsnNpSAUzYANyHWT0SO7JBOni/f8FkRaqiJSWpCqQMU2gOXBgmW5JKP
         NNBIgo55M0KcYtQ6Zg4Jd4Ih3QJe43sZKaD5krnH2DxDHNl/1DkU2mzrLDqXoloon3
         2YZ/BdYDsxyyfe4RdY9DdvKj9bnnxB975xPloWJY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from gecko ([46.223.150.91]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ma0Pm-1oxPKy2uZg-00W6MZ; Fri, 26
 Aug 2022 17:29:24 +0200
Date:   Fri, 26 Aug 2022 15:29:13 +0000
From:   Lukas Straub <lukasstraub2@web.de>
To:     linux-um <linux-um@lists.infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] um: Fix compiler warnings on x86
Message-ID: <20220826152913.017387dc@gecko>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3rXaueXT.MEP0yFjLDtrM6n";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Provags-ID: V03:K1:Uh5t3S8wNVbUbUVq4E22mbSCpFPXWP4E7OzZI0DA+FIedZP8r4Q
 UDk/tbHplnODEmWKMCRM0D0ZGDU6xoG2tsJRTiKJaKRFjrb70ATf+fq29XYGhrtv1RC5nMP
 EcQoxOkQYPJnpdAuy+02eSN29jl17TNjU6e6Or/AlkVYTATX8LfP1oiR6A82W/xJMxJcn08
 SzF374fFkcIUUGtrs0QmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FYP46OiKKSQ=:FXRL6THooh5GI326CEMawC
 kldvw/dOKTYGdSQfVI783W0Qc+ilXD34ecmozfu0nPkLv7qP1AfMGSumhlP7aDaUOb/YDDR5L
 1UIMGT1vbIWKwVwKVbPaRtR5TREMGKbBFU7aUQnj0pCKddL+ruFyh/j/8ZdHOvBtauuWCMJ1E
 RYcrM7T75WtJvyC3IBEiR02JBZe5F+O9X7fQ/u196ULNTSgbGBVBIr0X26vI3jrb/A7JfGDNm
 Q/f4PWDubVf137GMCiqyDEagLBfXOLAjHtZlHg8Xh9HM+kZkbHZSbCllUerUGAEJ03QZY5bBQ
 J8urOBsRyTMw4FpNIXQUIZJbMQHHjvqoANIE9PYSWcHHhFrPRR57KUK5vchoRjw0aQ4ndDRIe
 S9doKuCA8Oj1hv0RDTY277nTfI5sbV5XrUz2+IiUPlg5KyM6NO9/YjcrSAuI7bdGUKfS99Aug
 KdtfVMR3RsphvER4NDuP42NniirvhHtqU6NYEY8Ngr84eqy9g6mSEtolN9OUjDIsjGlsN/uyO
 7nF2Jkeo7RfDtdDTVGu0hZA1+7BNcjuzf+1tn2RhiE5QX3GdijThDEz81AD43w4kNp9+IU3rV
 BvsOcnxE4Zx7mqxQkgXJ0XKyOusl84W29HNSWoLw7WYB1BXS9sIWEUEVqxceUyuZITz6DMACd
 7UPBeJO0M3boQpO6bb09+iZVwyke4C3EBrNC8SIMN/6vq9/hrqZ4+py2npfkqm7EAo/TQLHiE
 5uO2rjqN2C/EW9TuHYs9s9S2SjTfWU3mCOC7De0XR4XkACownoMoJxppGb5aWtZRHqSWuUdFw
 Q2CM6uDiFp+VKFL5++t7iICZOglk+PQKkUCgFRhBalFa6TNKOmBkw4SBKEtSiycEo7te/SbpE
 wMQtmpp9ucSouiNq+Jh2n7IocOBQ02baWrlnuWAVYrk03CvxQYbavdOrYe2APn5Ye6zKuC+dn
 VEzQ3KJxLYbZj6HoebcYMI2OGA3xnS8xKTiF3DPN+TPnQ1oO3/aM7a7coRTl7Hy2pLSO3SjmK
 ojNHUigiDqMIVyHrUx5NfVdgOOE+brACaTGhiznY95buc5u/HJRdQSo6V1OExb1ERWtU4ko/W
 I6i7of7oHlL3FteegagMp4rPX4qpQMYRgAQdte0MHV+EH8A3WUBVBXnQQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3rXaueXT.MEP0yFjLDtrM6n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Everyone,
These patches fix some compiler errors on x86. I tested quickly without any
userspace and it booted fine.

Regards,
Lukas Straub

Lukas Straub (2):
  um: Cleanup syscall_handler_t cast in syscalls_32.h
  um: Cleanup compiler warning in arch/x86/um/tls_32.c

 arch/x86/um/shared/sysdep/syscalls_32.h | 5 ++---
 arch/x86/um/tls_32.c                    | 6 ------
 2 files changed, 2 insertions(+), 9 deletions(-)

--=20
2.37.2

--Sig_/3rXaueXT.MEP0yFjLDtrM6n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmMI5skACgkQNasLKJxd
slgT9BAArDpe55Yrw6Mn1PIH9dHA7KTH/Aisf7A5bAeQqyD7RtUWMFu31o+pcyja
iqnAOtX4nan1Y43/wbPnxdhODcMKVIQvLoC59y34Ey9IVeI0YgAvEhhwAWKAs9zq
WksBjh/MI8vpiwlouvb7RlDdxw4cc9mC0C7yI1SW57Glb7+1n/dQ8STR2V2lq9Yy
DXoCZmq/96+Lcr6mKRIfwg1HtfC1EptLWiMnkWfJDUc2xWumyOzhK7oat1ZZ7tq3
e8h19DjHPYAdJHpLxDtYTMngYNFJ9WWDWqfPIt0grZ07R8jGjzIaIamsTHyGx4lB
C1UQH9w7qf5qCcve3yTKqthNsngnQMcgvgJK5+KsQTtTXisHgjMjMe59LzdwBVwk
TItcTuh471hUMMlfCY/YJvYQ+b9I7qe6NmuFnv+P3/1QtVczNYKNHX/5kLJEJGja
FwV71YufTGdi1VPNlqFdo5hACNeN7FA5KmpZXaP+/fCaOODuDjHs1fdZoXdt830Q
1Wvp76emYObal8bgTj7i7TmC0/xAiakcIRZIh4+j8JRJWXe14E4J+QtjES/XhaQ3
Dauh5SGD2nbiBSUhVF1y8JhAwrkOOJrenPWIukIac0vOZwg5PNi36gRUYGUBVch6
Bw1qdyj2O1QiE1Y2rmcpUIwFfNk/KvKOmDeLrUINOu9N7In6KtM=
=tTlB
-----END PGP SIGNATURE-----

--Sig_/3rXaueXT.MEP0yFjLDtrM6n--
