Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32A750D9DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbiDYHJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiDYHJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:09:30 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A251CB09;
        Mon, 25 Apr 2022 00:06:27 -0700 (PDT)
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MfHUx-1oOYTS30uZ-00gt6P; Mon, 25 Apr 2022 09:06:25 +0200
Received: by mail-wr1-f45.google.com with SMTP id s21so4716346wrb.8;
        Mon, 25 Apr 2022 00:06:25 -0700 (PDT)
X-Gm-Message-State: AOAM530j6De+bIxCCXJz6PoFz4kd9jTf2VDFzI+BmlUb5TsDgfIf8QGj
        +X4hJfyaPcPvD1dgEq2g39AJo/Ehkkt1deanA1E=
X-Google-Smtp-Source: ABdhPJxxp6erGvmfRbmUQS+IHGGJZckdjwT0Z2vmr9ym31iDDJlb7avUOKw/eqT13DvKvO7wLaoPCBQVv9Zw+tbmHZ4=
X-Received: by 2002:a5d:6da5:0:b0:20a:8805:6988 with SMTP id
 u5-20020a5d6da5000000b0020a88056988mr12416992wrs.317.1650870385330; Mon, 25
 Apr 2022 00:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220425033355.6281-1-rdunlap@infradead.org>
In-Reply-To: <20220425033355.6281-1-rdunlap@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Apr 2022 09:06:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a12O-Qz5PTr_nMYV+aRcxav1DD1Gk_a865QOSbga4jUKQ@mail.gmail.com>
Message-ID: <CAK8P3a12O-Qz5PTr_nMYV+aRcxav1DD1Gk_a865QOSbga4jUKQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: tegra: restrict to ARCH_SUSPEND_POSSIBLE
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:24OFbOKd3D+Q/CoiL5rhaDXigIX8D4JOaRH8PjOycoIup+BGqOe
 JAMSCXB+Cpuu6iG3HXX2i785OCjpQMtnGbRT+eMCTN141xLRipFvRk0xG3RdUVJev8zlZNy
 t0vJkAN31VTtv7eTM1LK16kyYER7mt3Ts+J63rXHlhlGw48k0BVATvQthM6aNqUBfUIKJZH
 cV2Chw+ZW6r4jqPH8P25g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:px5XtvKeHGY=:2q4Hqx388DMiEkVaNipNGU
 ElnZ+ZviBDDWHRmxR3ZgP/7B7MRb/lCbI8xiAvjNIHMQdeHa8jikiqW0Y0AZZKa2A37D/gy98
 xPshJ2SxJpSRXj6B7Gjd4WA819pQZ6S30eo7u5rMpYL1rIThKMvKqD2pziMWXAyuQq3M29XNa
 YQcYpoUey4m5mytYPV0KBG9NHAxxOG2Npk02cLpb3Qa4vJ0uJSWzW5sdBBP+SFs7l4wgVLuKw
 WLCof5WVz8QlbKbpibajln/y8LXoY40y192TK2yWbQPIoAZanIIdHE75DCggfo/zxx5+TlrS/
 fQUCH13dtXE5zItTOhsPerBoQgDpRvS0Sn98QRDuc4aHn64J3QQe+cvP3nqEaXkcrXNdtaIdc
 hnzxo+ADRnIRO3HEOe2mM7249rk98seuCM+NzMBmlZjQhwJJHBdoOWgrHV3fpg+f9n9A5fQUK
 8cBNeO3sApqoIwKvBohSMcE42eZgCrx5w+Xfzuc9v/m0if265PAk954BERYchzKtC0J9TlZ57
 GFcxT1YMXAJIu3r68nZJ6nJ9ARLlrxsm0DpmBQYVbSvG7IBNAsbc/SOxlSTg0afeB/VxP5Ogf
 hC0qpwuUfVc+W2+g8cIIbByGmEhN8kHK3S9W/4Qq96q0BOcz6v+4n/RvWiG6x7gLHq8pQ/rDI
 e/Az5zecRdEzQwTme+f698ceZ4tdgtw1qKa11UGpdzBvgBsiHjX5AXF0M1dbQ+W3T1cVOFFU6
 OWWu6tzTSQJbqbzuF9mC+iCiqk866yfXc89ICFUlHGDN9dLP8cIRxzA/NFB3kIO0GJhD+mTxy
 s/rkypBS4VqfAvPtyTltf0qUVCqQ9kT5S1IkHHdH77FrKzSJKw=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 5:33 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Since 'select' does not follow any dependency chain (ARM_CPU_SUSPEND
> in this case), make ARM_TEGRA_CPUIDLE depend on ARCH_SUSPEND_POSSIBLE,
> just as ARM_CPU_SUSPEND does.
>
> Fix this kconfig warning:
>
> WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
>   Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
>   Selected by [y]:
>   - ARM_TEGRA_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_TEGRA [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]
>
> and subsequent build errors:
>
> arm-linux-gnueabi-ld: arch/arm/kernel/sleep.o: in function `__cpu_suspend':
> (.text+0x68): undefined reference to `cpu_sa110_suspend_size'
> arm-linux-gnueabi-ld: arch/arm/kernel/suspend.o: in function `__cpu_suspend_save':
> suspend.c:(.text+0x478): undefined reference to `cpu_sa110_do_suspend'
> arm-linux-gnueabi-ld: suspend.c:(.text+0x4e8): undefined reference to `cpu_sa110_do_resume'
>
> Fixes: faae6c9f2e68 ("cpuidle: tegra: Enable compile testing")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Dmitry Osipenko <digetx@gmail.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-pm@vger.kernel.org

Looks correct to me,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
