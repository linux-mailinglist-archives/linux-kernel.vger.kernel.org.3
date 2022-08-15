Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5A3592F26
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242423AbiHOMpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242375AbiHOMpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:45:01 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2BDDEF4;
        Mon, 15 Aug 2022 05:45:00 -0700 (PDT)
Received: from mail-ed1-f51.google.com ([209.85.208.51]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N9M1q-1nKpCw31XA-015KGt; Mon, 15 Aug 2022 14:44:58 +0200
Received: by mail-ed1-f51.google.com with SMTP id o22so9407298edc.10;
        Mon, 15 Aug 2022 05:44:58 -0700 (PDT)
X-Gm-Message-State: ACgBeo0ZL3HyVV51XY9qvgKlCJbAZV/mb0R79Dd1wRATUIIHobZKgxPF
        rm6uo/bRLTRq6vNgBfSiuX5p/cw44F6cvjuxQWU=
X-Google-Smtp-Source: AA6agR7eA3AhlxYFHKmAFkHizGTNkOXtWVhcMVQAA8iaSqC4IvTBWlMin6L90DsptF/0E4etljGfIDCbfw4DPA0wvLM=
X-Received: by 2002:a05:6402:3495:b0:43d:d76e:e9ff with SMTP id
 v21-20020a056402349500b0043dd76ee9ffmr14788222edc.227.1660567498364; Mon, 15
 Aug 2022 05:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220815120334.51887-1-tony@atomide.com>
In-Reply-To: <20220815120334.51887-1-tony@atomide.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 15 Aug 2022 14:44:42 +0200
X-Gmail-Original-Message-ID: <CAK8P3a120ekWQzOLLfDF5jVHJ6XKpz5fKRrh8R-yk6S9PmoeTA@mail.gmail.com>
Message-ID: <CAK8P3a120ekWQzOLLfDF5jVHJ6XKpz5fKRrh8R-yk6S9PmoeTA@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: Fix compile test warning
To:     Tony Lindgren <tony@atomide.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xgqHpud8HikUwOPWfwCj5k7CdhO43Q2Py7Q3XXitEc9MgcabGta
 pixz/MXNNFJURqI5aS0QqwRisDi+lhRH/Px6NhP1EY/zaxE3xQNDSKnZMyAFBNdzip1QPIK
 5/UUinja6w+7tYgIPZ5AdYM8sKE5+kosbU2fwQiMxGm/Gh07Txw3blAfZWLPTReclRL0fux
 Xd+ylrDGfmWKHKYGwlMAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oE8NCrNUPdA=:+6NTaKMudK45G/JjPGvoC7
 boVOS6sCrxZMuS7FwUnP7WzjGMnJBnRFmC6IL1/M51p/fM9jzQuRk9NV98NcTsgqXiGoOnBqY
 zskEEFIEWWxK/K2b7yjxs/DllGI2N7Lcirz8mGzK/7zdcHayUKCKCf86NBZ7szAD/NCBnH11p
 6nnNikw//mrxnRu3G8dxVlLDK+LXDwzG077SP3I/dxmhjcOd+Kmpb998tiQIvc5DNiaJKpczT
 JIFxF2hRv32+JnElSgXSGNHxP4rDDevCzC1ICOjKENo5jEYUlhAHzIKy1LZokmhoQyrXLHWez
 ++mBu3KUoKRkd7aEWg6vQ5vWiC+p0RR3vS5rcOrDIaOMltYauvGbIGPGxXHM2MdmcOulgu3iP
 xPhqaOc/A8Pwt3+7iUlBdCXZqvmU5YawfHpuSZvUlNsqcxWgAdxPzs0BsfTUdqLbRfOcdiun4
 xM01xNv7jP+F4PIwnbHNho6S0qjoaeHXURzQENKGx/Q5zgHe516v3tBxybFjV86Vlw5RNSJ4i
 /St1g/S4AQ1FKd2KyzFbjCMmG4wcPw+K5H7/Cu/MlXdON5DAnfSIGQSV/sSz6LSm0NFBWXgOC
 HMHq7DxKKnD+Chlo4LArLTUGuG5aL5TssA+ziWRBxtyQx1jHSDI0cIwqL3zS471DGegstr71M
 Ycms+PEAo2s9MokgRv7AjYdTkJ8PgyLPc611wuFHu/F6gol7Z5xvEZG+x0rocG3x5guTdEgb1
 NE5J3zMxR0Yrfi9YmeDaOGam9TAo70j5A+ciAw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 2:03 PM Tony Lindgren <tony@atomide.com> wrote:
>
> We can get a warning with COMPILE_TEST enabled for omap_timer_match
> for 'omap_timer_match' defined but not used.
>
> Fixes: ab0bbef3ae0f ("clocksource/drivers/timer-ti-dm: Make timer selectable for ARCH_K3")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/clocksource/timer-ti-dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
> --- a/drivers/clocksource/timer-ti-dm.c
> +++ b/drivers/clocksource/timer-ti-dm.c
> @@ -1040,7 +1040,7 @@ static const struct dmtimer_platform_data am6_pdata = {
>         .timer_ops = &dmtimer_ops,
>  };
>
> -static const struct of_device_id omap_timer_match[] = {
> +static const __maybe_unused struct of_device_id omap_timer_match[] = {
>         {
>                 .compatible = "ti,omap2420-timer",
>         },

I think a better way to address this is to remove the of_match_ptr()
usage from the driver. The only reason to use of_match_ptr() is to save
a few bytes on machines that don't have CONFIG_OF enabled, but this
driver is not used on such machines any more.

         Arnd
