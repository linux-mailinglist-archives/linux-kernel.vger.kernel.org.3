Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FC457B84F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 16:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240795AbiGTOSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 10:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiGTOSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:18:15 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DBC48E9D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:18:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w12so23908400edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kY5NXuVRIUWTuJ5MVqWNBJE2O9k9GvcLpJVA74STiM8=;
        b=Z7NZKCK7n6PrzO9l+4mzRHijFxlXOgNhJAgooIPRN8PpLhXoINiOJFLilpD+uvtzNR
         NF98WROGAbdeGQ7RtmmQyMDgBdmXKmqz5KYDJ75KCCaAcBzWkYIxQz8UdYqPsUGm/hLi
         BXe7+mZZoIVlRGMznAVQnJvNuFqga/ofAzvkbaI0K7eMGLfgju3xWtZI5OI1NO3XQ8fy
         rpJpCI/Os+xalZaM89w2lImMyv5iy8/i+I+TE1A8FgPTrjtzxFf5CZJoeQirwdKrQFH2
         3qp+V0yaaFAr4bdGzw4oksCPJsPpoqwsdvSRA7zLfSJa80asKCM1dIRX6aOMFpdV1TtY
         7y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kY5NXuVRIUWTuJ5MVqWNBJE2O9k9GvcLpJVA74STiM8=;
        b=8FdM2U8RPNUFSFeEA8qrr3OYYSZilhZ8B59Q3X9oxaK8XWw7nX97xVpwWuBM0P6r5e
         9ck7MlEoikNE5t33IHvGv7vZdT5nWg38dK9J2X11lDD4vZmR4H26C8ZQpXbsL9zGAwdx
         LjT9lA7xEzJjN0mQnTUblxBr+C6gNW4Fy49pULQPLSz7XC7vZ/rppmfGeGfBV+B3Qf7P
         RlVrIiFvswOacSesAxlm/AvfTISroa08pu4ynE8qwTvzjf+zfQ3LIaLecr1dw3xbledf
         MywFyNCwXvd8A3v+uSH9UGC0fipD0UbB37X7FA5Skjt22/kgKD7dA4QwBM3pKZ1bNwcs
         Spdw==
X-Gm-Message-State: AJIora8WBhZQfOzWRiveEiOPDBfDMpP0OKPS7TIdgUoPiKBKIeRF9mnG
        +LH0SNVrEXiYZ5+RpyS6RHjL31OJtYLNI26aP5Fx5w==
X-Google-Smtp-Source: AGRyM1seq8V68eQ1spRcaPOxDg4pZ79DR9Mtbn1Kgh6VFNBQ8YxXXoX27706kr8dsf7FclKqWeXN0wbBs3G2Qj3jP1o=
X-Received: by 2002:a05:6402:358d:b0:43a:c600:a678 with SMTP id
 y13-20020a056402358d00b0043ac600a678mr51341972edc.219.1658326693391; Wed, 20
 Jul 2022 07:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220715015925.12569-1-rdunlap@infradead.org>
In-Reply-To: <20220715015925.12569-1-rdunlap@infradead.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 20 Jul 2022 08:18:02 -0600
Message-ID: <CANLsYkwUDcTo9bDxVibqX2XbxjigO6ST0CjhHTt1F0=1JdghzA@mail.gmail.com>
Subject: Re: [PATCH] coresight: trbe: fix Kconfig "its" grammar
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy - I'll pick this up for the next cycle.

Thanks,
Mathieu

On Thu, 14 Jul 2022 at 19:59, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Use the possessive "its" instead of the contraction "it's"
> where appropriate.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/hwtracing/coresight/Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -193,10 +193,10 @@ config CORESIGHT_TRBE
>         depends on ARM64 && CORESIGHT_SOURCE_ETM4X
>         help
>           This driver provides support for percpu Trace Buffer Extension (TRBE).
> -         TRBE always needs to be used along with it's corresponding percpu ETE
> +         TRBE always needs to be used along with its corresponding percpu ETE
>           component. ETE generates trace data which is then captured with TRBE.
>           Unlike traditional sink devices, TRBE is a CPU feature accessible via
> -         system registers. But it's explicit dependency with trace unit (ETE)
> +         system registers. But its explicit dependency with trace unit (ETE)
>           requires it to be plugged in as a coresight sink device.
>
>           To compile this driver as a module, choose M here: the module will be
