Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9AA4F0641
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 22:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353495AbiDBUtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 16:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352856AbiDBUtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 16:49:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B554A8C7D5;
        Sat,  2 Apr 2022 13:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648932432;
        bh=33Yw4Gr8uTso9ZT+73CinX5k3Nib7sctQo71Bc/koLo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=MRdU13rdbITSO4LQXr7A996BmBDdkHUSqHtikDYKy7nEidt9/Oq3zB3He/ctUo75Q
         jZ9O6hU6hWhhxOEihKdkQjBRY0VkFdhV1w9OkQP1ArnbOb1TtRc7CGBJZ9tSwsyP40
         4aLWwHzVgQcaf7Tp8U5ne0CJnEMJjqhzmL3CjCHM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.149.42]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQvD5-1nPWUR0OOd-00O05l; Sat, 02
 Apr 2022 22:47:12 +0200
Message-ID: <5f75fa65-e3ac-1e34-c0a0-f8bb67fe0c0f@gmx.de>
Date:   Sat, 2 Apr 2022 22:47:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] video: fbdev: Prepare cleanup of powerpc's asm/prom.h
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <68d44009feb802c58b855ade3ac9109496b9d0e5.1648833426.git.christophe.leroy@csgroup.eu>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <68d44009feb802c58b855ade3ac9109496b9d0e5.1648833426.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S7rwhg9Q78UruNB9u5sQHP7UAQw4aCUv1pohR3rhZlQTS9k5SQP
 D2l49Plnlc5GDSqNO+ZMx/V5jA6H7OPB0ycCOBT7V0wHOQP+hVoxeQ5D+XV7tkPBcTyyhIg
 85FX2VyYr5HLvC3fNKhThZNQTWMIT93axKb7sjmordKPq2X3Y+czb6TE6l9KUDmVSIceQFC
 eDTKU5UAOq97LZ4u4hssA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2ivjbFhQd8s=:2IpmC61fm+26zzF5o9FqAS
 ZXcJ/GQW6/8FxmYYQbujOBosPepHs4JVnRYlOBtwvbKOs8Xq/3t5nR9sFaWFPvPsDMennTAzi
 XYc1LTuvA6UHNqQgtPao4hWUPcUk6l0BEWaLya5y9yubJYenIa3sVqQWXKdslpzYra0Hz6sI6
 ndvi+6CZsJPSKghLYomzSH3i5+qggNIhWWRpvuiwpY6ock2c8kjKcyu0rU2sRr2MMVGOBD7H3
 BoLVO3of8D5Q9Ys4BU443rRBv7FsfxcMlOMC4B1quU61PJJJfif/pEIb/xxt9JDqII3EzTinn
 j5829mZKHw1/bK/XSKr5vj7lrGoTg7YHiZDZOjwt8cLNedQJ7Wrx2iksHRf4ahQKcmIXZ7HhI
 +dVG3+cF9L3H3vjStHaHtKFsinwt1aN1tWCK/4jYrCTxLvFffgGE64ltFfcCxzwyBvXodaaCy
 s2jqvtHe2TeSYVl9FzKD9WtEryOlr2HvBCCiKFTobIJfNE67zl+kZSNJxpTk612rZVfSpw8yN
 o4+vfLCHbOKTWxauWuoqiBqm1lNIxKsxPNqFjcV+JdqjxK0YSekPfi/5i9JukCgeKFJ9EH+h6
 ZT0JTVXWQDtbaz7MBtoFuRCtoNXZO8CXjVMmOej1LHiUyntIDc+c5XRZ/jflSo5/QJGrbBNQk
 +74ROC3bt884DnyeMmTxnszKmynmB5wZqGxAUneTznCuhaad9JTrDEuJH8fRsPmVrCyKe/4FM
 7tLc2agcPdpAmNO1N09EWmWVIVSWbLU4WJr2Z3aRF5wyPX1vcZe1bsDfLdoYMzdQcXPAANeTU
 s1MF5Af7zjoCRpdBQcrBMDWnSO1U/dm/ZEkMo12yagMfLwB9EOVRJBuqsNY6cSv1juX2GgWZE
 gnvtdqd+9SKFUxXKW70MYrcJmsA+8QGmMH2fe0jCNJgp7RR3MRM31Rzz1UbrQal6WIKMLa/u8
 aNNytOw5wUAIqORCiu70AObv6Yc3dsLU32VXZ7IuaU/Yn6kfgSzj5mkmTs1PkN3+F0ccM2rSA
 iPwxFu6Re5euRDUKOfj1OsZ48V0VySc4gvnYVroVHGUeAfMBSx5u68THaKEZWkUVbpCnxT31H
 t3087aQ3cAu4rY=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/22 12:22, Christophe Leroy wrote:
> powerpc's asm/prom.h brings some headers that it doesn't
> need itself.
>
> In order to clean it up, first add missing headers in
> users of asm/prom.h
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

applied to fbdev tree.
Thanks!

Helge

> ---
>  drivers/video/fbdev/aty/aty128fb.c         | 1 -
>  drivers/video/fbdev/aty/atyfb_base.c       | 1 -
>  drivers/video/fbdev/aty/radeon_pm.c        | 1 -
>  drivers/video/fbdev/aty/radeonfb.h         | 2 +-
>  drivers/video/fbdev/controlfb.c            | 3 ---
>  drivers/video/fbdev/matrox/matroxfb_base.h | 1 -
>  drivers/video/fbdev/mb862xx/mb862xxfbdrv.c | 2 ++
>  drivers/video/fbdev/platinumfb.c           | 2 +-
>  drivers/video/fbdev/valkyriefb.c           | 3 +--
>  9 files changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/at=
y/aty128fb.c
> index 6ff16d3132e5..b26c81233b6b 100644
> --- a/drivers/video/fbdev/aty/aty128fb.c
> +++ b/drivers/video/fbdev/aty/aty128fb.c
> @@ -68,7 +68,6 @@
>  #ifdef CONFIG_PPC_PMAC
>  #include <asm/machdep.h>
>  #include <asm/pmac_feature.h>
> -#include <asm/prom.h>
>  #include "../macmodes.h"
>  #endif
>
> diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/=
aty/atyfb_base.c
> index 1aef3d6ebd88..a3e6faed7745 100644
> --- a/drivers/video/fbdev/aty/atyfb_base.c
> +++ b/drivers/video/fbdev/aty/atyfb_base.c
> @@ -79,7 +79,6 @@
>
>  #ifdef __powerpc__
>  #include <asm/machdep.h>
> -#include <asm/prom.h>
>  #include "../macmodes.h"
>  #endif
>  #ifdef __sparc__
> diff --git a/drivers/video/fbdev/aty/radeon_pm.c b/drivers/video/fbdev/a=
ty/radeon_pm.c
> index b5fbd5329652..97a5972f5b1f 100644
> --- a/drivers/video/fbdev/aty/radeon_pm.c
> +++ b/drivers/video/fbdev/aty/radeon_pm.c
> @@ -22,7 +22,6 @@
>
>  #ifdef CONFIG_PPC_PMAC
>  #include <asm/machdep.h>
> -#include <asm/prom.h>
>  #include <asm/pmac_feature.h>
>  #endif
>
> diff --git a/drivers/video/fbdev/aty/radeonfb.h b/drivers/video/fbdev/at=
y/radeonfb.h
> index 93f403cbb415..91d81b576231 100644
> --- a/drivers/video/fbdev/aty/radeonfb.h
> +++ b/drivers/video/fbdev/aty/radeonfb.h
> @@ -21,7 +21,7 @@
>
>  #include <asm/io.h>
>
> -#if defined(CONFIG_PPC) || defined(CONFIG_SPARC)
> +#ifdef CONFIG_SPARC
>  #include <asm/prom.h>
>  #endif
>
> diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/contr=
olfb.c
> index bd59e7b11ed5..aba46118b208 100644
> --- a/drivers/video/fbdev/controlfb.c
> +++ b/drivers/video/fbdev/controlfb.c
> @@ -47,9 +47,6 @@
>  #include <linux/nvram.h>
>  #include <linux/adb.h>
>  #include <linux/cuda.h>
> -#ifdef CONFIG_PPC_PMAC
> -#include <asm/prom.h>
> -#endif
>  #ifdef CONFIG_BOOTX_TEXT
>  #include <asm/btext.h>
>  #endif
> diff --git a/drivers/video/fbdev/matrox/matroxfb_base.h b/drivers/video/=
fbdev/matrox/matroxfb_base.h
> index 759dee996af1..958be6805f87 100644
> --- a/drivers/video/fbdev/matrox/matroxfb_base.h
> +++ b/drivers/video/fbdev/matrox/matroxfb_base.h
> @@ -47,7 +47,6 @@
>  #include <asm/unaligned.h>
>
>  #if defined(CONFIG_PPC_PMAC)
> -#include <asm/prom.h>
>  #include "../macmodes.h"
>  #endif
>
> diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video/=
fbdev/mb862xx/mb862xxfbdrv.c
> index 63721337a377..a7508f5be343 100644
> --- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
> +++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
> @@ -18,6 +18,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/pci.h>
>  #if defined(CONFIG_OF)
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #endif
>  #include "mb862xxfb.h"
> diff --git a/drivers/video/fbdev/platinumfb.c b/drivers/video/fbdev/plat=
inumfb.c
> index ce413a9df06e..5b9e26ea6449 100644
> --- a/drivers/video/fbdev/platinumfb.c
> +++ b/drivers/video/fbdev/platinumfb.c
> @@ -30,9 +30,9 @@
>  #include <linux/fb.h>
>  #include <linux/init.h>
>  #include <linux/nvram.h>
> +#include <linux/of_address.h>
>  #include <linux/of_device.h>
>  #include <linux/of_platform.h>
> -#include <asm/prom.h>
>
>  #include "macmodes.h"
>  #include "platinumfb.h"
> diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valk=
yriefb.c
> index 8425afe37d7c..a6c9d4f26669 100644
> --- a/drivers/video/fbdev/valkyriefb.c
> +++ b/drivers/video/fbdev/valkyriefb.c
> @@ -54,10 +54,9 @@
>  #include <linux/nvram.h>
>  #include <linux/adb.h>
>  #include <linux/cuda.h>
> +#include <linux/of_address.h>
>  #ifdef CONFIG_MAC
>  #include <asm/macintosh.h>
> -#else
> -#include <asm/prom.h>
>  #endif
>
>  #include "macmodes.h"

