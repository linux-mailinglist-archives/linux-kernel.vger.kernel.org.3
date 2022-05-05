Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CC951B848
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 08:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiEEG7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 02:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbiEEG7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 02:59:45 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2825377EF;
        Wed,  4 May 2022 23:56:06 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id kd11so2426566qvb.2;
        Wed, 04 May 2022 23:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H63lRZ0aFf3Uo76l2TVh/QJRDaMCJkmpdWde3tg+LhI=;
        b=cPwm6ZXgyQ2cTIJMEtRRARC53JUjs1pmcu4OQyZmKC14uK3I3TtMS3XmgZQ1NeQwIG
         pnQT5gbnwFJ5BoL+DRu9crcxsbh6lV17HFODuZEUVwW89faDbUQeILJYgd8aQJGfy0YT
         AGk/qi7epfw7Q7QaTnWfS0weLdCIE426hroSacPM0nLy0gAEofrW4VYfcUOioJzXIM7A
         Vn6cypN7m7yGl0pgD9nTd2uGHX+erc6B33oWi60OEZ7dvREJ/wpil89J/QCLEPNtABCK
         OSWRXwjn81oELKmTkcDJBkRJBLF3JoIZqO4mIuEiLeu5Lpnaz597JBMp4h54ArKcobUK
         +8Wg==
X-Gm-Message-State: AOAM53121veNiKmaW9JqgyyvHOwM3eDUMOzM27vPdgUAzI0HGOntX0Uo
        7ove0PJssLHpWWppXgHRwiQqC9+lV2xv2w==
X-Google-Smtp-Source: ABdhPJz1y9lRi4pNrieAI7o05QV3pJBfPjr3R/eTdXcGA44dXsGlJJQsq5OS/haoiOH+f/0ZDNxwbg==
X-Received: by 2002:a0c:e409:0:b0:45a:8a6e:c771 with SMTP id o9-20020a0ce409000000b0045a8a6ec771mr15624117qvl.123.1651733765729;
        Wed, 04 May 2022 23:56:05 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id l14-20020ac84a8e000000b002f39b99f68dsm417304qtq.39.2022.05.04.23.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 23:56:05 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2ef5380669cso38504037b3.9;
        Wed, 04 May 2022 23:56:05 -0700 (PDT)
X-Received: by 2002:a81:913:0:b0:2f7:c833:f304 with SMTP id
 19-20020a810913000000b002f7c833f304mr23117982ywj.283.1651733765108; Wed, 04
 May 2022 23:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220504142333.8844-1-guozhengkui@vivo.com>
In-Reply-To: <20220504142333.8844-1-guozhengkui@vivo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 5 May 2022 08:55:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW=V=92VnD2sPpuXwJ1CAj-swC10vcSssLArbrPULs4-A@mail.gmail.com>
Message-ID: <CAMuHMdW=V=92VnD2sPpuXwJ1CAj-swC10vcSssLArbrPULs4-A@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: rzg2l: remove repeated data
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zhengkui_guo@outlook.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo,

On Wed, May 4, 2022 at 4:24 PM Guo Zhengkui <guozhengkui@vivo.com> wrote:
> Remove a repeated CPG_SIPLL5_CLK1_REFDIV_WEN.
>
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -601,9 +601,8 @@ static int rzg2l_cpg_sipll5_set_rate(struct clk_hw *hw,
>
>         /* Output clock setting 1 */
>         writel(CPG_SIPLL5_CLK1_POSTDIV1_WEN | CPG_SIPLL5_CLK1_REFDIV_WEN |
> -              CPG_SIPLL5_CLK1_REFDIV_WEN  | (params.pl5_postdiv1 << 0) |

This is not correct: one of the CPG_SIPLL5_CLK1_REFDIV_WENs
should have been CPG_SIPLL5_CLK1_POSTDIV2_WEN.

> -              (params.pl5_postdiv2 << 4) | (params.pl5_refdiv << 8),
> -              priv->base + CPG_SIPLL5_CLK1);
> +              (params.pl5_postdiv1 << 0) | (params.pl5_postdiv2 << 4) |
> +              (params.pl5_refdiv << 8), priv->base + CPG_SIPLL5_CLK1);
>
>         /* Output clock setting, SSCG modulation value setting 3 */
>         writel((params.pl5_fracin << 8), priv->base + CPG_SIPLL5_CLK3);


So I'm going for Wan's fix instead
https://lore.kernel.org/r/20220504142058.18704-1-wanjiabing@vivo.com/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
