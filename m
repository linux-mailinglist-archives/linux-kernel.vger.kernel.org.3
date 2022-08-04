Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1447C589A28
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239392AbiHDJxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiHDJxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:53:35 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1B926AE5;
        Thu,  4 Aug 2022 02:53:34 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id w185so18902174pfb.4;
        Thu, 04 Aug 2022 02:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Yj4LnoCipKdQooHDqQkSzfPq9k+SbXM64sol04d/ofU=;
        b=qVUuazv80uczwDUpa1W45XFLKQkv6E85jaluDS0qPCqx5UqLWXVRj7NNS3iB1u5yMk
         BpAyrdAWbjN4xan/ozEhpBngVBm4vusnJrSXS6B5BtALu4Q7w0WkatMFosToCwAp0pxw
         peyWEmojG15dUtIHplxLrARzYTKP87+hpzEs+qJ1Skx6IUC8ArRBWfpqh5foE/L0KuT3
         5dl0vT47WvE/YFBfLMbib+8Ia4pPLthO02aty10gTq/7cMx0IUzGT+JIGnvuHvmlqhSG
         +z4BOs0ydQYyC+O9uk363r+pOvEqCbU9PsjpybnRv4n2q2RjbjTJIV3fBXw17xudaCYj
         TyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Yj4LnoCipKdQooHDqQkSzfPq9k+SbXM64sol04d/ofU=;
        b=ewahLd3VOGPtQ3GZMq/EPtODImi2jZTqphBuCCDYg+JCH5gVokPpOQObRCVpDdMgUZ
         rEDXp/jLA+GDqHdHEzM0xeHS6T7qcU/Tb2cHcDerozYtbX1mfGtwFns/f4GBTml2jBHK
         s1fI0aoUNEXiLsd/GcQFwT9/b+aSb24lxmcP92hBelwINzw8MLks2NsUgyjEJQdKiwNK
         mr0NMxeE9j7nsHXRNhor+MFJKynV8t3R5EHgB4GZjx+/Izh982dQ/nl4a+/lK9hrJWKB
         ctDDGc79cK+1mjFcB3VMIagU8H7XjPVcvB6S/Q0OD9FgwhaQ2AQUGmkUd0mpNO/Njezz
         l3gg==
X-Gm-Message-State: ACgBeo3FtQjUtk8qNh02MJ6yiePvxaMUoVzkNrLu2YZLHGh2Qp95MOJY
        P3QB1NLgFCVKolQTZYK8T/KQnEpiSWgQ4NuIvt8=
X-Google-Smtp-Source: AA6agR6qwy7xIi0BGj0KdaE31bzJZvJiNHMC9+UQ+P/hml7eIyhBore8DXxCh12e0tZqDO9pfcvT3sY1+E56wep5ub0=
X-Received: by 2002:a65:694f:0:b0:41c:cc1f:4440 with SMTP id
 w15-20020a65694f000000b0041ccc1f4440mr1024346pgq.318.1659606814308; Thu, 04
 Aug 2022 02:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220722102407.2205-1-peterwu.pub@gmail.com> <20220722102407.2205-13-peterwu.pub@gmail.com>
 <20220730214205.GK23307@duo.ucw.cz>
In-Reply-To: <20220730214205.GK23307@duo.ucw.cz>
From:   Alice Chen <szunichen@gmail.com>
Date:   Thu, 4 Aug 2022 17:53:22 +0800
Message-ID: <CA+hk2fbEvU2yJbowqKoozb2M0aQc9TFCaxAn++YrmEx+eWt_4w@mail.gmail.com>
Subject: Re: [PATCH v6 12/13] leds: flash: mt6370: Add MediaTek MT6370
 flashlight support
To:     Pavel Machek <pavel@ucw.cz>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de,
        andy.shevchenko@gmail.com, chiaen_wu@richtek.com,
        alice_chen@richtek.com, cy_huang@richtek.com,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> =E6=96=BC 2022=E5=B9=B47=E6=9C=8831=E6=97=A5 =
=E9=80=B1=E6=97=A5 =E6=B8=85=E6=99=A85:42=E5=AF=AB=E9=81=93=EF=BC=9A

> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2022 Richtek Technology Corp.
> > + *
> > + * Author: Alice Chen <alice_chen@richtek.com
>
> Add ">" at end of line.
>
> The series is quite big, would it be possible to submit LED changes
> in separate series?
>
Hi Pavel,

Our mfd dt-bindings depends on flash and LED dt-bindings,
but our flash and LED config depend on mfd config.
For the dependency consideration,
we think submitting them in a patch series is better.

Best Regards,
Alice
