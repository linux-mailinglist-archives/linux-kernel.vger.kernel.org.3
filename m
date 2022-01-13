Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDE248D69D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 12:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbiAMLUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 06:20:23 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:47277 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiAMLUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:20:22 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N2SXX-1mCjSV338B-013yxE; Thu, 13 Jan 2022 12:20:20 +0100
Received: by mail-wm1-f47.google.com with SMTP id ay4-20020a05600c1e0400b0034a81a94607so2488708wmb.1;
        Thu, 13 Jan 2022 03:20:20 -0800 (PST)
X-Gm-Message-State: AOAM530ZUNvVZ7v3DgwwxvVBEMCg5ftkEc1Ga480UQ1u5snX5f1OcgZ+
        S+ZeCkfLOC63cdqFzuTlfdbRihtAUxth7HfSx6U=
X-Google-Smtp-Source: ABdhPJzc+YWQKWgHQz627kY0icPW47/qifAMQSYtSw7uxTMVG6lGTcteHKgUAX26mjUInXkbLOo/ZppB1T0DT3bTVSA=
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr3348456wmj.35.1642072820372;
 Thu, 13 Jan 2022 03:20:20 -0800 (PST)
MIME-Version: 1.0
References: <20220113103559.2577216-1-laurent@vivier.eu> <20220113103559.2577216-4-laurent@vivier.eu>
In-Reply-To: <20220113103559.2577216-4-laurent@vivier.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 Jan 2022 12:20:04 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2_cJi9+SNi9gK6+5kpBo4wmVw4hz42Bq_jm1+s6AvENQ@mail.gmail.com>
Message-ID: <CAK8P3a2_cJi9+SNi9gK6+5kpBo4wmVw4hz42Bq_jm1+s6AvENQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] m68k: virt: Remove LEGACY_TIMER_TICK
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qAg0ebihRKhfLRFwkGnRm1Hge256vkv04FuE3CCOiDb9cQnNrw9
 FVy67Y1+DEVshG9pJi16DjVj2BFjWmBz5zsOAIabU5iAG0p+mN0PKPyr+1rOvLK3uPFOZzG
 NSPiejE/4tuf7/hApo59xZBJsdgw4XR1N6ljempV31uUCBhoNW97HlOzDCG+nzuG7C+6dIB
 kJ5PuBfT48s860/CQ1Ptg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:M5k5OP322+M=:e1fYGXNdMpgBppM6bNPWV9
 LGI8OEeyjcH9/OIrbslhvmOzd3uEZ4tIO1rk3XF5UX/RjsB4dGdcrlKlu528WZUw/oo7Z+hRE
 fKk61OYznODoISGl4JI4O8+DDVceV7pVsTHGYs+xMPDRlRYte6FCae+HMV8TM0shqfRloghsf
 kdVMuhs7s9kJHL3OSOzQvdzT9Yd2sl4WCD/shg90O9/ZaiQ+vIPnSfYz5v+FA3oq1fzEtipVr
 WIxP3npVtu0CyAb3acuQme8HwBlihJ1fayB5GA4ADwSf+zllk/CV8IPvuUHM5ycgD2YzH5L4j
 wjxbWcnCUc2+QVzJBrFtfPfI601FcmztUHWu4RR5kCgF6/5IwsQE0qX73d81qRZUsZ0k15WGE
 PD5y5y13dxmv62HUeSwE7Tckt/FWH4itUk71/LT8AfY48zBNaVaj3SFR4lu6M2a3OjvEaZ+6Q
 /OKMRCzeshchpZwbj2ZVOeOazmzup3g6U8aNj1GP+socplv+M/rmtZF8KQ1mAA4sd94kqG+jg
 nO84WqrzaguiyPyctVuMwSyIeQdNn5IPvKp3kFNaV/PAxzTIqqQ6B53hqNseHuoWShMb1ArBb
 eRALmOyExeuVQMDoUZcST2Lu08jlcW5bWCkHcGeb95yQ1I+VwBJl9Tm8397CA/ZZfLdVX2Aei
 ExqZsEA3+RBp2p2ep7LPg5CX3b0u35usByawKNZi+kGpc/VDsqcaCY+ie64Lwrihw0Hl3HYA1
 iYRdXNNofMbgaLczFuJR0ooh3ZF7+9sy8StlbrT1xRovfrOhN/8AtA5AiSUIwIOgqDj/+WvwU
 aDjj+lptyoT2aBj2YzJWGRsRLwPGlAw7WGrPnYjzJ8CytZtfNs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 11:35 AM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Move virt machine to generic clockevents.
>
> cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

The change looks good, but it appears that you only just add the legacy code
in the same series, and it would be easier to just add the correct version
first.

> diff --git a/arch/m68k/virt/timer.c b/arch/m68k/virt/timer.c
> index 843bf6ed7e1a..767b01f75abb 100644
> --- a/arch/m68k/virt/timer.c
> +++ b/arch/m68k/virt/timer.c

How about moving the entire file to drivers/clocksource/timer-goldfish.c?
It shouldn't even be architecture specific any more at this point. It probably
still is in practice, but that could be addressed when another architecture
wants to share the implementation.

         Arnd
