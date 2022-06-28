Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A6655DF6E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242031AbiF1ArT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 20:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbiF1ArS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 20:47:18 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999E9DF2D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 17:47:17 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id y77so15208304oia.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 17:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CmaV9NQoW/Fd662ZqYGgD45ASvjbDpDWdPEsvS2puqM=;
        b=gG4xBAQZG+ETFRDPO3xDVpqxjka4QuQdvw7yyaHT/XjY6P4wj/AS1Hb+LPrNQkL4q2
         kKuD0BLK2u8RhvKJ5EQ29jUmROplqkDr0gkL56nWz27d8XdfHUDCoYNoKLDmkhXBS4Vc
         uHaXZU2keHYh/KthmyM2uKWucb3YMDoLepGVIDKGhABScKuFJsulpCT8qMXw2hBdutG3
         e5cD6+Ozi0LMM1BJJYLYYcy51HPGo8v3GdCdz/hVZC3R1SWhPegp5jp8HBlwCGbn7Tea
         uBOhvTY7v867T4Nlx0rc9ClJnjCZPKr9oSR6ZSwqJzIIhOUMp76SQyXVpYadOj70pirl
         okMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CmaV9NQoW/Fd662ZqYGgD45ASvjbDpDWdPEsvS2puqM=;
        b=i3TapAhhuxBwEbghAGVJavZkAgqtalET8+pwPrb0dARgh6pLPi8zMJhDmYf2A/OW6j
         cM5fJn2qs0q+U51Tjg/S1U0RIyOvCQg42sv0Q4kPtxK0ifIgzOoItHOQ81r1mN8+w6Ht
         PdXmojwnVf/Qz2dj87Jxp9M5/bWMYNm88X9MpVeTZxVy6fX9weGSY24pvIhduicx1UcF
         uaEB32OjDk5uPRKleg5KMBg4Wa05lSWlDy+ggxfL3Fi8p4GD5FVugRFjRUH+Y+ap5j2h
         Q4H1n0AmtaK3BL/Wzd7yqe/v4/6LnV2i1l1JxF/HS4CIfvBQLwREvybkVgR8mdbObbBS
         FOKA==
X-Gm-Message-State: AJIora8+tJYwHgCBkgb3fVXGWiQne3ItyOgg+JPyyfMuO+lJPXW5dI3h
        mZyGFHdFuDXjrdVG+rTZII0pTpRgyITdY/D6PEPagepW8UfbYhGz
X-Google-Smtp-Source: AGRyM1urInjctET96oj51M0B3XZ00J8P6KIKs5gOKFT0R+ElWvC6ntuNIUQmFXbmzLc04vtCwKSOmizEMBQOA2N/MeI=
X-Received: by 2002:aca:1113:0:b0:335:6d08:31a2 with SMTP id
 19-20020aca1113000000b003356d0831a2mr5519853oir.258.1656377236924; Mon, 27
 Jun 2022 17:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220627131202.3148329-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20220627131202.3148329-1-ckeepax@opensource.cirrus.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 28 Jun 2022 06:17:05 +0530
Message-ID: <CAFqt6zaNzKioWbXrN+JqQPvy82vFqj29M36ApnjzdTV-c=6_aA@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: samsung: s3c24xx-i2s: Fix typo in DAIFMT handling
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, krzysztof.kozlowski@linaro.org,
        s.nawrocki@samsung.com, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 6:42 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> The conversion of the set_fmt callback to direct clock specification
> included a small typo, correct the affected code.

sound/soc/samsung/s3c24xx-i2s.c: In function 's3c24xx_i2s_set_fmt':
>> sound/soc/samsung/s3c24xx-i2s.c:173:14: error: 'SND_SOC_DAIFMT_BC_CFC' undeclared (first use in this function); did you mean 'SND_SOC_DAIFMT_BC_FC'?
     173 |         case SND_SOC_DAIFMT_BC_CFC:
         |              ^~~~~~~~~~~~~~~~~~~~~
         |              SND_SOC_DAIFMT_BC_FC

Adding this actual error msg from the kernel test robot will be helpful.

Reviewed-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
>
> Fixes: 0b491c7c1b25 ("ASoC: samsung: Update to use set_fmt_new callback")
> Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>
> Changes since v1:
>  - Correct fixes tag.
>
>  sound/soc/samsung/s3c24xx-i2s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
> index 4082ad7cbcc11..c1a314b86b155 100644
> --- a/sound/soc/samsung/s3c24xx-i2s.c
> +++ b/sound/soc/samsung/s3c24xx-i2s.c
> @@ -170,7 +170,7 @@ static int s3c24xx_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
>         pr_debug("hw_params r: IISMOD: %x \n", iismod);
>
>         switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
> -       case SND_SOC_DAIFMT_BC_CFC:
> +       case SND_SOC_DAIFMT_BC_FC:
>                 iismod |= S3C2410_IISMOD_SLAVE;
>                 break;
>         case SND_SOC_DAIFMT_BP_FP:
> --
> 2.30.2
>
