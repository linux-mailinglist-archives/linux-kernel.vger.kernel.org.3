Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A767D486804
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 17:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241471AbiAFQ5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 11:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241426AbiAFQ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 11:57:28 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51F4C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 08:57:27 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id q25so3204964edb.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 08:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LwOK/ouAJBgdJj0h8zp/aXDK2PMeip+QzMdUZ7moH6U=;
        b=YCRNre4Y3owpHVtmlq71fW7RbV/TjvObZo2YwUBKU0b+Nw1/Rvq4lisZjIt1nLegNe
         2u338gar0dqYPzKOZh95Ykb2Qxx3WbIggLkpHVeLFUErJkb9f/Yj2HHvaHTUsIZqhulv
         2HaPA1rTI2SeAu1x/bHI53B4a0Zc2O9+mQYdyJahDPYOSWFd1DB3zoV9IzlVjAh0DpMy
         1k6/Lix4K2zWgjQuiGf6S4MP9nX4RDVrz5v4i+2vTKz5Enqiud7SVYl01wk5N+0xZYjB
         GqeVHJLibtCR5RqiZRJjOHv2PGC0yGHOAA1107FMeBGyOC7674Ct/3QUO998SK96JSrT
         IVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LwOK/ouAJBgdJj0h8zp/aXDK2PMeip+QzMdUZ7moH6U=;
        b=NqYqmaS4G1AObIlC4B5r7ozy3+3Z4chw19cJEIi11/ua8f7fAkSv4lOaNeWE5sN3Kw
         z2jrbAzzkBy60n7CK4r02KeEs1qHJcPI/BymygHTCYB7N4a7RyXmjt9ktugvFXhedJNT
         m3DqNnO97kIJrDPGDXeHeE9zAYH4Zzq/EyTgR9Mk96Zrqsyea4J3pN+FBZq4jqxAB4+o
         44RahCNc9BNgyudaNCHiIe3bYOvd0jDfV63axI9Wt94aterLa/PtxZdrdeo7PisCtp41
         3UKgROMuX/gL9Jh5ngV/E3/DvmCXwVVBysIDQq/k3icy0NobiYMLxGAiMlQu2yhD7RO3
         6rzg==
X-Gm-Message-State: AOAM530GfNndKb+xvw55sSohst7NFcgf+LkGOeqQ9dZ6jlXjPpAxTs6Q
        TFJ/gwvDeGbFiXnojiTxYH9TAcJ/8VM5seaRuHg=
X-Google-Smtp-Source: ABdhPJx1x+iDvz0SE3ZCl8ZBqptMUmfv94hotBjeyCUF8g1aIfbieYePZzm6gtdO1aUm7f++WvsQB4+4c/oVKtAAQwk=
X-Received: by 2002:a17:906:4f90:: with SMTP id o16mr2860423eju.626.1641488246489;
 Thu, 06 Jan 2022 08:57:26 -0800 (PST)
MIME-Version: 1.0
References: <CAOMZO5A5H7HrCXoTAK98dkT0wEybcnuazPVxZeHvu78Nq7Qm4g@mail.gmail.com>
 <Ydbbktqvc8PXQQd0@sirena.org.uk>
In-Reply-To: <Ydbbktqvc8PXQQd0@sirena.org.uk>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 6 Jan 2022 13:57:15 -0300
Message-ID: <CAOMZO5A4292S216dPE2CwKwa6tRoWaGfXfJh6rVJTNWk8r1ZdA@mail.gmail.com>
Subject: Re: debugfs: Directory with parent 'regmap' already present!
To:     Mark Brown <broonie@kernel.org>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, Jan 6, 2022 at 9:07 AM Mark Brown <broonie@kernel.org> wrote:

> Like I said there:
>
> | (we should probably clean up the one with no device but that's not what
> | your commit does).  I think what you need to look at here is that we
> | store map->debugfs_name and don't overwrite it when the device is
> | supplied.

I added some printks to help identifying the name clash:

[    0.274418] platform panel: Fixing up cyclic dependency with ldb
[    0.276896] ************ 1: devname is dummy
[    0.276926] ************ 2: name is iomuxc-gpr@20e0000
[    0.276951] ************ 3: Forming the final name
[    0.276979] ************ 3a: Name from map->debugfs_name
dummy-iomuxc-gpr@20e0000
[    0.277001] ************ 4: name is dummy-iomuxc-gpr@20e0000
[    0.277022] ************ 5: Final name is dummy-iomuxc-gpr@20e0000
[    0.277746] No ATAGs?
[    0.278355] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
watchpoint registers.
[    0.278469] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.282007] ********** gpr succeeded
[    0.282042] ************ 1: devname is 20e0000.pinctrl
[    0.282070] ************ 2: name is gpr
[    0.282093] ************ 3a: Name from map->debugfs_name
dummy-iomuxc-gpr@20e0000
[    0.282115] ************ 4: name is dummy-iomuxc-gpr@20e0000
[    0.282138] ************ 5: Final name is dummy-iomuxc-gpr@20e0000
[    0.282185] debugfs: Directory 'dummy-iomuxc-gpr@20e0000' with
parent 'regmap' already present!

The duplicate "dummy-iomuxc-gpr@20e0000" comes from the lack of doing
a kfree(map->debugfs_name);

Calling 'kfree(map->debugfs_name);' like this:

diff --git a/drivers/base/regmap/regmap-debugfs.c
b/drivers/base/regmap/regmap-debugfs.c
index ad684d37c2da..18f0c7223082 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -589,6 +589,7 @@ void regmap_debugfs_init(struct regmap *map)
  return;
  }
  name = map->debugfs_name;
+ kfree(map->debugfs_name);
  } else {
  name = devname;
  }
@@ -600,6 +601,7 @@ void regmap_debugfs_init(struct regmap *map)
  if (!map->debugfs_name)
  return;
  name = map->debugfs_name;
+ kfree(map->debugfs_name);
  dummy_index++;
  }

diff --git a/drivers/base/regmap/regmap-debugfs.c
b/drivers/base/regmap/regmap-debugfs.c
index ad684d37c2da..18f0c7223082 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -589,6 +589,7 @@ void regmap_debugfs_init(struct regmap *map)
  return;
  }
name = map->debugfs_name;
+ kfree(map->debugfs_name);
  } else {
  name = devname;
  }
@@ -600,6 +601,7 @@ void regmap_debugfs_init(struct regmap *map)
  if (!map->debugfs_name)
  return;
  name = map->debugfs_name;
+ kfree(map->debugfs_name);
  dummy_index++;
  }

-- 
2.25.1

makes the name clash disappear:

[    0.257135] platform 2800000.ipu: Fixing up cyclic dependency with
120000.hdmi
[    0.257460] platform 2800000.ipu: Fixing up cyclic dependency with
20e0000.iomuxc-gpr:ipu2_csi1_mux
[    0.257782] platform 2800000.ipu: Fixing up cyclic dependency with
21dc000.mipi
[    0.273536] platform panel: Fixing up cyclic dependency with ldb
[    0.276013] ************ 1: devname is dummy
[    0.276043] ************ 2: name is iomuxc-gpr@20e0000
[    0.276067] ************ 3: Forming the final name
[    0.276097] ************ 3a: Name from map->debugfs_name
dummy-iomuxc-gpr@20e0000
[    0.276119] ************ 4: name is dummy-iomuxc-gpr@20e0000
[    0.276141] ************ 5: Final name is dummy-iomuxc-gpr@20e0000
[    0.276859] No ATAGs?
[    0.277468] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
watchpoint registers.
[    0.277580] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.281122] ********** gpr succeeded
[    0.281156] ************ 1: devname is 20e0000.pinctrl
[    0.281184] ************ 2: name is gpr
[    0.281206] ************ 3a: Name from map->debugfs_name 20e0000.pinctrl
[    0.281228] ************ 4: name is 20e0000.pinctrl
[    0.281251] ************ 5: Final name is 20e0000.pinctrl
