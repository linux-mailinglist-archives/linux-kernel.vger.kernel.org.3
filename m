Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF595AFEB2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiIGIN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiIGINs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:13:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8154FAA35F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:13:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t7so14072336wrm.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 01:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=mbkRCkxOuTpK3rCdT2NdC/a3ZTao5Ps9WmVjhIiZvls=;
        b=sk8Pm679kCWo06LlDl21EZc/HmWpPNBEeJP8bUOaaDthi1z+mVK1yZW9dP3APJWwLK
         WQSj+BRhoPO2amfmoOEJcHDCD2Peg6PSwTivvgK+aSpO+RqG4t5t8ZTdofiUUnrgr3lL
         7AkuSuz5lV2jjMSAiqbC9Gj4Mv4NzajshOOJsI4ghnoj4Eoq9jaAVqxdwNF71jB9R28O
         YcIta9ZSV4Dd9kLdjcEviBNy44QypoTufBTizlDJoTwoTlJNJRK84vKqD05TiivJSZIj
         BPCIAcqAaABlHvQGbFlBIdfcgb/dGcagQWo9r7wd+9omVp+IRAa+cWABdErD/u8IrG3G
         TOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mbkRCkxOuTpK3rCdT2NdC/a3ZTao5Ps9WmVjhIiZvls=;
        b=Pxar/2rR0Y2khty2O/zZOXu0pzDTbLEoZhSSVLCA20bVQ/PEZpVM3vk74Tgo7bGYmf
         aUEeGTuBrAPCm7kYURbO2DNjLbCE7jY9AMs77x5dr4FmUncg2viY0OowmMLfYTJya8dF
         NR6hw3ERhtUc+bkWNth2oVzri1Oz5ExpdMOqepElteIXZVIop3bwzK+9SjFiuZJCoTle
         +gSL2/O4autA42zyvrYlk8TPuix9P4EIZD4Qkt6N4Ayp48wueOT+huwTYTYJA+btcfoM
         M9pKSKj21woNoBqJT7s3hdQYev9Kgaq3Xxjz/+XBmQrQmcaUpJu79ztEbz9+kIm1EfRS
         w7MQ==
X-Gm-Message-State: ACgBeo2PcOeX6Lowo+i1iGQlseijmqo2TOIXfF0Mk+twomyl94C50wPf
        T6qKfslBmkgEGbKI9uUXohO45Q==
X-Google-Smtp-Source: AA6agR4831QEpmYjEGZLA1k1jv1O4NZM4dYSRTaEMkIMcSOZBh3MF+BHVfh5m/Rh5jmx+OZnNPjTmg==
X-Received: by 2002:a5d:48c2:0:b0:228:6226:381a with SMTP id p2-20020a5d48c2000000b002286226381amr1239472wrs.366.1662538424970;
        Wed, 07 Sep 2022 01:13:44 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id h13-20020a5d504d000000b00228dbaea941sm5194810wrt.26.2022.09.07.01.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 01:13:44 -0700 (PDT)
Message-ID: <f467244a-64c0-a938-fd88-2f014c520956@linaro.org>
Date:   Wed, 7 Sep 2022 10:13:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH] clocksource/drivers/renesas-ostm: Add support for
 RZ/V2L SoC
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220907080056.3460-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220907080056.3460-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 10:00, Lad Prabhakar wrote:
> The OSTM block is identical on Renesas RZ/G2L and RZ/V2L SoC's, so instead
> of adding dependency for each SoC's add dependency on ARCH_RZG2L. The
> ARCH_RZG2L config option is already selected by ARCH_R9A07G044 and
> ARCH_R9A07G054.
> 
> With the above change OSTM will be enabled on RZ/V2L SoC.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
