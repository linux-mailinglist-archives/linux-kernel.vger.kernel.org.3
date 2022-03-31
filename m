Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FB34ED714
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbiCaJhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiCaJhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:37:03 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C49B6E67;
        Thu, 31 Mar 2022 02:35:13 -0700 (PDT)
Received: from mail-lj1-f182.google.com ([209.85.208.182]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQ8OG-1nMZWF0sMa-00LzwN; Thu, 31 Mar 2022 11:35:07 +0200
Received: by mail-lj1-f182.google.com with SMTP id a30so23743420ljq.13;
        Thu, 31 Mar 2022 02:34:53 -0700 (PDT)
X-Gm-Message-State: AOAM530f4YF5XRzdcJZz402Q2dO5W10j2CxRXZsoZgbvCJBBidfnMn6p
        1/KYMOMILw6hB8QXWn2cZtkHJnXJoUV7wKUaAgk=
X-Google-Smtp-Source: ABdhPJzlZAknllrYU3sqw0DcJDBqe9QGu2EJFIsGG1Jj93+/mwICYSZMvQMKUcZsQpnc8rRysI1G9CixKr24DtuSHyk=
X-Received: by 2002:a5d:66ca:0:b0:203:fb72:a223 with SMTP id
 k10-20020a5d66ca000000b00203fb72a223mr3263936wrw.12.1648717194942; Thu, 31
 Mar 2022 01:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648714851.git.qinjian@cqplus1.com> <840bf90d4e7ba05fe621cd94101b912162311e41.1648714851.git.qinjian@cqplus1.com>
In-Reply-To: <840bf90d4e7ba05fe621cd94101b912162311e41.1648714851.git.qinjian@cqplus1.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 31 Mar 2022 10:59:39 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3dRs=-XdK-Y3eHFJEkXTaCzRCm-YAdiUw_DRUcqHd02w@mail.gmail.com>
Message-ID: <CAK8P3a3dRs=-XdK-Y3eHFJEkXTaCzRCm-YAdiUw_DRUcqHd02w@mail.gmail.com>
Subject: Re: [PATCH v12 3/9] reset: Add Sunplus SP7021 reset driver
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:DfVrS+Ox3XDkFmwPTS20wXa+Ha4o0WcqDgVOIs5eqt6GtEcCbV4
 nVfLllx+NhIBJMi+iAS6nOOJnMJgeRUWFmoA78qsG/2IMxdgB6CLF1H4ThsMyWdah56Ez7o
 xstqnj8bqlfUOm7qLAGIDf4PRPpE38lAGL4LV594mvE9kbDmV2SDoDp548u7bSvM8jutdyG
 VFAtU62bbD8LFqYhadCEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FV5ioI8hUa4=:znyj7Kx4BQT2vh6lX9KmcC
 sNW827kSRUWc46nsYmbPySZLiqAWcaUkI+s2Aq6fEkAbQxz4j+nMvz9CMJqUfBSql5zP4DkAt
 GGgr9uOMfD19Ug0nWtRZfVTEwyIhjFTp1GA31VwZH7QVVD4kWNpg9OmNqLsrsnRCKTy3k4/FK
 PVpx1kJOeOjrb9m2k+Rn2Ojv94nlqF9P3x1YXq8pnvVF376OHXp3F/3BVDjwWSLchQ8ueAC2P
 7qNMsvpmaMk4xgounFDRXZiXIVS2KlGDEi42FT2nCnlQB4Nlfk4upRt/lGxayc9o71pMX4gAH
 FpWbjO7Y7QTqNhX+tqOuN6t0s76uxaQ6L3StFz7BCOMYGtQUj/jBbFdMUH7WIOXjNSDMgxRJE
 7w50I5+7HJcNvL2ZCOMAZkGb039Z0RfxzYiYmltgDwaBZ6RkG2TJRMg91Gu6Cg81DCNV7LLeU
 j0+1Tj+8hyOEbFa6Rb2C+dwaYSdK5o6L0oN9hll/cPdXmMwM4uPSHJlovHne5SGRaWMvEyV8m
 0C1TYearppaLDLIKnGcTKUeZQJdR6YjLtuBQmgrVCsFcMgBuL2lluYcEVWkHgCOV7ttmxXxVR
 //Kf/FYPztV7yZzihClLMjTWM8dtCPWABmkRt0MGuLASm5Sdim1EL75NBi67EqUgEdR0wABlv
 yltpRZRFHLA8AvJ/a+E7nMMatzJfDSKUXI0FvaAws23GvxHU22feBZfsOhOkwSS7PUeK6nBH3
 Rx1OWysCLKAxzHqX/rnTbCr/v93JgHRdpyiG4I7T6jgFAdlMWloErUhWGiQ/CE9iDDEjoZ8Nr
 ntDk+5ap+gcdrpy1quaeNo9ZBqgygG4Rtpn0HZeoL8yq4usTjKqMIMAhgez9xSZlnJUrjgw/L
 8a7bYeruMKWgEFiycr5W1KN94LzzatCkATA4HRO9XjN/3PxTW4aZ03G4MhzFm89tpkgZp95bL
 uVh24r6nz3LzBpTNhi41ZqKvC1KBowA4qgTZYJBzkLTxizR/NtZKImc7SJT5yLxH4G/H5dWmh
 546zOzkj1zLITvc3jevwBVOK/eVbiIadOXZiMKqkJd8ZHLr6q8dI3EsnXM/G9j6FLv0jFb3N0
 kMWMwFswDzW+iB30qz4j3ev3DpjkZ0IXD0FNjv3jHz5xHMWk5R/SitdSUU8YzBlSIbG3iIKGJ
 klnZ/eIZHEE0crf5RKWtDk9c2HqLSWBQP+m9R5NEoRvRpBECI73Nc+ZrRZejySv5tz7FT9GD9
 b9sajQXc2wbVoKkb6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 10:29 AM Qin Jian <qinjian@cqplus1.com> wrote:
> +
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/reboot.h>
> +

As commented on the binding header -- it looks again like you are not actually
relying  on the header here, so it's almost certainly not needed.

         Arnd
