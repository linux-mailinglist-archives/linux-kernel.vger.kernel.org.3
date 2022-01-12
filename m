Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC6348C283
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 11:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352625AbiALKvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 05:51:18 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:41065 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352617AbiALKvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 05:51:13 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mkn8B-1mdSvf0ao3-00mJXK for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022
 11:51:12 +0100
Received: by mail-oi1-f177.google.com with SMTP id r138so2838721oie.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 02:51:11 -0800 (PST)
X-Gm-Message-State: AOAM531MklMigwk2lgNP8sGv1kDNnpkSskNS/0TNfdRxFDz0mPw29TyS
        fq55nTDlqWQvD63XZZTZ7YLh2wQHHpc9wbVcevg=
X-Google-Smtp-Source: ABdhPJxbehyJ+UKG3ve0S1BMZRUcfxENmtnL2Wld4IkBqEWRgysmAU7BrnfjMesY0V41P6v5dm0xcpJrqvKWnlaq/Lg=
X-Received: by 2002:a05:6808:2327:: with SMTP id bn39mr4773607oib.108.1641984670830;
 Wed, 12 Jan 2022 02:51:10 -0800 (PST)
MIME-Version: 1.0
References: <1641980099-20315-1-git-send-email-anshuman.khandual@arm.com> <1641980099-20315-2-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1641980099-20315-2-git-send-email-anshuman.khandual@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Jan 2022 11:50:54 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1cDF=jEVGchU8LNBdjdtROmHHHpebOASreR=WOuZ4Z1A@mail.gmail.com>
Message-ID: <CAK8P3a1cDF=jEVGchU8LNBdjdtROmHHHpebOASreR=WOuZ4Z1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: Add Cortex-X2 CPU part definition
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:kcn6oH7FUcH/VHf7rMji7ishbRQbtgkyMxy07qI5It4WAzkHXPe
 a7pDK3FcRirPiJMnFer/hmiRDkr722vHv5Mv8nbGEk3XjVAhXkQdd8AbXuGAvW1KD4TMZp2
 yKJaQNvUuS3/Z26AzDXrLI5tlm5CjX8f3gzNuzbUO+83y4H40F2INtPHXqmEn9376Grgfwu
 dgBOEaL5z0U7OywXtJfYw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TRZwugt47t0=:9V3FSTa/ANnAkUJm5nTovO
 5rqeGPtVYnIN9qdDf29llc1cnvA9lqyYHEgEDY/NT6ihDMkyt8arbHaT7CRADSOzZ+Z/aMuqq
 YVIKqjdQTwkjq5I+SuYHIDpS8hDXCUiQ9oisk5fks8K8HeVtqpq2HkTvln8U0pBUQ/d+Ho81E
 HFDn9UGFtUuIvcmJxCkyKCu7jB87W9/keTPk6D9O0ahZ0Uh/vBqelyGt+RhctSWQljpTT/d0x
 9lfynibsIwyn6sZE881P6inKiMVt1yj0nC9zYjdhOoh0897JqkjBoLqB90QqkByRTyFKYvs8Q
 1wv4Es/GVp0B9BSh42AaMODpJqdn52qfqAzVTTJJxwZGPP6aGsBPTb+Jc3aqQtt24jbYdcN4B
 UHF38e2p6w8ZOlQp2iIdpa5pZgi/mWGP0TMVgtbmKpHSaV9t63R5byJ40XP9wng6LlHXLJsv2
 +4zh8NlYe4ClO2ke1IXqopqtNMnHuPWLCejb+H2AiiaZS1AUZs6NkWCLLIdKtdQvQq8ecJlSi
 K+AMNGvSCnjVyfTAle6ooRur3esZCe1IVv6XFnDJNZhjXczQv5LYpAkWZYii04GIV39QSfkPp
 db/SqgvPPI5mBQk4AqmbpFirAjJ3dpSYByCQm5/p/+zzsRBKrIVb5c1mwCnz0jyneDKiUcPLW
 YJbr+oGWU7ut2m/tKI5sECr70hPAnbjfj7XFXhS8g1O0dTakm8B6SktHwpF62/ImGe0faiOLJ
 jVhpa1GjJduRbHRRPo/UNLEA7qSREZjAtkyBnahF/s6Z0BHzMyjSexlQtd0lpgcRDTJ5WYmzH
 jE7rkqtW4DKFnZbA4AoHRrvVi5XlaDum4IGSWweDnOKvh3Nyno=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 10:34 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> Add the CPU Partnumbers for the new Arm designs.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/include/asm/cputype.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index 19b8441aa8f2..657eeb06c784 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -74,6 +74,7 @@
>  #define ARM_CPU_PART_NEOVERSE_N1       0xD0C
>  #define ARM_CPU_PART_CORTEX_A77                0xD0D
>  #define ARM_CPU_PART_CORTEX_A710       0xD47
> +#define ARM_CPU_PART_CORTEX_X2         0xD48
>  #define ARM_CPU_PART_NEOVERSE_N2       0xD49

No objections to the patch, but would it be possible to just add all the missing
ones here to the degree that they are known already? I don't see any entries for
Cortex-A34, Cortex-A65AE, Cortex-A78, Cortex-A78C, Cortex-A78AE,
Neoverse-E1, Neoverse-V1, Cortex-X1, Cortex-X2, Cortex-A510, Cortex-A710
and Cortex-R82 among the Arm-designed cores that can run Linux, and there
are probably others that I missed going through the list.

        Arnd
