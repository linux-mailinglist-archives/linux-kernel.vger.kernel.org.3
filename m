Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B40857BB0E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbiGTQE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiGTQE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:04:56 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7219154645;
        Wed, 20 Jul 2022 09:04:55 -0700 (PDT)
Received: from mail-yw1-f177.google.com ([209.85.128.177]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MMnnm-1nxlGj1Jvo-00IlIQ; Wed, 20 Jul 2022 18:04:53 +0200
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-31e623a4ff4so46327067b3.4;
        Wed, 20 Jul 2022 09:04:52 -0700 (PDT)
X-Gm-Message-State: AJIora9VFbjSWqE0yAW684JDbjMp6QHJOrmzEPWOvEP1V/23FEt1PodM
        9S+ZNHkMuAzkvah77BWokav2XKksCwBQDWM0vOU=
X-Google-Smtp-Source: AGRyM1tx4Q4yzO4K3vNo2v/cQDqJPZDUjiQjI2oOeyxYInCHZSpN9OszFiRCijwZHYeZeLUarfMN4D9MWqBPtxZBQ9Q=
X-Received: by 2002:a81:d93:0:b0:31c:d32d:4d76 with SMTP id
 141-20020a810d93000000b0031cd32d4d76mr44777721ywn.135.1658333091704; Wed, 20
 Jul 2022 09:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <YtgfF/jyk6WyVLZn@debian>
In-Reply-To: <YtgfF/jyk6WyVLZn@debian>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Jul 2022 18:04:35 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3-K+hfjsCnF9cK=f_nP0sq7NVWpiiaZL5PfoFKUDHLAQ@mail.gmail.com>
Message-ID: <CAK8P3a3-K+hfjsCnF9cK=f_nP0sq7NVWpiiaZL5PfoFKUDHLAQ@mail.gmail.com>
Subject: Re: build failure of next-20220720 due to undefined calls in modpost
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Julien Thierry <julien.thierry@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:mEQBt476N+DiiM9UOjZmVwHEiEnRSxKy5ASTinKn68O58S5coPK
 dynYjfkbJOuHD6Hj0zFCzAwreziMqTFjxCuuszAjbkfOF5nWjOnW7jFofOK2z20BdZG2itS
 mK3AtIdqXw41uc4jYS9pwzCStkxK1Fbf7pbCpWTIa6GQoVIx8qu/gZqrgiJzoNLdLME4nIT
 xbJI6fgzF6fQ3JGzdJAdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cO7owcCQF/g=:zLTawiKNYPmKXLnDoYFBAA
 pUOK9+//rx4YWKXhPnjzajWddpjcSZkicdjyjQpqFOJNpwGO7L5E2cb6td5jW7MZYdRAjxs9y
 OnytaDwss4KZClGJVlNRznl3i1LKhHVpEruboaYt3kshFc/y081ADbezAyUrT1lPZVp0oBTaC
 odDsl2YBwlK+2Nzq1BJZF1SAfaZ3QVRqK2kYzXe0UQB5sT6bCaWiq8eKsokugaTSZ2sl3uOtw
 RNTCSd3RNCCUiJQ590i2bQdWkprL6tPF0sohkqA3/9oIkt7TUf3zzo0fVzCRDmZ0GDcOelp8Q
 BibC/dViljZFlWEkSWz2NlLYrRAocBqC95BvRPoh82Z3cSLQa91RVMEUkRVfemSp/SGP0PFlY
 OffTLJmn44KDKhIeo4AJ7MU6md49ODbO0P1Ex2of6aXCMus9AP2UAgKYIdzD8UlHd9PDyhwwU
 Zfctn3KLzUgxYJ6S/B3AOxyFj7S448bTQS5Qv8XCyHujFB5BjLf4SCebEl8/rP6pS95vxcvfA
 baMEaWXddnfplDUvarI2bHgEZWJJ97BUUCA5eUVXuCy9Ugwgf+9ZElNMprOYZkn/p2fY50NBo
 gpW1+6vEfjcTa/VCo3CUtdAOaxdc82/oS6zF9WeCgwvcatLe/calIsdFh6XjkuV02xs973fHt
 xkpPXR592nPdTjd+TDA9tJo9S11GD38u0gbheVo2r8Kb9jm9w/X5K/X7OkTJvAieOJjkJ3GLT
 CNEoduqKTCLsJkN4RXvS9bccsxcyIDZKAG41NNxQBFy4ZPNk2O7qJBIio8Bimk8rAIXDMtu89
 Lb/z7BODrBwm+EiJM9ZGhKblZhUcXtGOuvQMulRz4s3lOnXYH0DE1QLdeMEcUfS/RfFvtuilJ
 ryVlUWT9VsUR7HQ5NNZA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 5:28 PM Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi All,
>
> Not sure if it has been reported, builds of arm64 allmodconfig
> have failed to build next-20220720 with the error:
>
> ERROR: modpost: "free_nmi" [drivers/soc/fujitsu/a64fx-diag.ko] undefined!
> ERROR: modpost: "request_nmi" [drivers/soc/fujitsu/a64fx-diag.ko] undefined!
> ERROR: modpost: "enable_nmi" [drivers/soc/fujitsu/a64fx-diag.ko] undefined!
>

Thanks a lot for the report, I had not noticed this myself. It appears
that this is
the first driver in a loadable module that uses NMIs directly. Adding
Thomas Gleixner, Marc Zyngier and Julien Thierry to Cc for the NMI
infrastructure.

There are two ways to fix this, either the driver can be made built-in only
or we export those symbols. I've applied a hotfix on top to do the Kconfig
change for the moment, see below.

It would be nice to allow this driver to be a loadable module. If
Thomas agrees to added exports, I can send a new patch
that adds the three EXPORT_SYMBOL_GPL() lines to
kernel/irq/manage.c instead.

     Arnd

8<---
commit f740949d41a7ff85aa23ce62c29d095066e5e6d4 (HEAD -> arm/drivers)
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Wed Jul 20 17:58:18 2022 +0200

    soc: a64fx-diag: disable modular build

    The NMI infrastructure cannot currently be used in loadable modules:

    ERROR: modpost: "free_nmi" [drivers/soc/fujitsu/a64fx-diag.ko] undefined!
    ERROR: modpost: "request_nmi" [drivers/soc/fujitsu/a64fx-diag.ko] undefined!
    ERROR: modpost: "enable_nmi" [drivers/soc/fujitsu/a64fx-diag.ko] undefined!

    Disable this for now to make allmodconfig build again. We may revisit
    this and export those symbols instead in the future.

    Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/soc/fujitsu/Kconfig b/drivers/soc/fujitsu/Kconfig
index 56275b44b293..987731e80612 100644
--- a/drivers/soc/fujitsu/Kconfig
+++ b/drivers/soc/fujitsu/Kconfig
@@ -2,7 +2,7 @@
 menu "fujitsu SoC drivers"

 config A64FX_DIAG
-       tristate "A64FX diag driver"
+       bool "A64FX diag driver"
        depends on ARM64
        depends on ACPI
        help
