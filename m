Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A88C5154CE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 21:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380371AbiD2Tna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 15:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236736AbiD2Tn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 15:43:27 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1668A270B
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 12:40:06 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p12so15803274lfs.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 12:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mwwKTzefmTJKE4K4xtYs5yV3nVraWz0ZikLnWGl59aE=;
        b=lFm3iQKYv+iXNQnPNgYbCjemLYCoLZ+6q3E1x5ZMCZD5yY5Lk3h4X7aYbN3drSWwRq
         CZR+ejaRvWTyJYhdfolC2BRIb3vwePu/AuaOIJBvbr/O8vgAUGwbvcXCgL2qQbuKN9Yt
         D6BhohHanWNoi3TeFJqIOyOcbGaZiW03aJle0blhFeqHz8o2E4TtUDsM/rLXL4UJyaUz
         sb2pclaEe80ffX92ViuVUvI5/jBhF5n9FySGqMvkJ8P/K5MPg0degFfETklPUxnLkw6m
         Sx9KK0aVCKgguvLJQxxQwj03fos43udYhs3ZE8/xNVjOwD+tL+3uKwMGc5DeY8UCeISv
         b8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mwwKTzefmTJKE4K4xtYs5yV3nVraWz0ZikLnWGl59aE=;
        b=qcdBYyXn+IlyMepA2xWpcdqz1Xmn8ygzEmhSlfMenXBkXGQe63bKDN2nKoBc2rwlV6
         jGT40zTi+71mzB6MIt7eoavReye/lySnZOyvDjntBACJ/pRLEiO81ZWLL6AuwGtDGj3S
         z+xdAEwEu3M2jg2l4cKzk+0RAGlDVv90KbS0ZqkT8Cw1v/1LENJ4F8UhzwWKs/TGYK88
         L6JEhLtDRvoIAJ59m42SKiUZHdUmWRSvZ8aWj1CYQXPPpQgvb3WAxcJO2qxnMrbYBn+1
         mscERyNmC1GLRhCbHtdzfeYycOqRUGrXD+3NJtHDyLedNrSxsL19IjafcvrLPdeILDw0
         H76A==
X-Gm-Message-State: AOAM530zUtdcuUmxkwwH28J7ujeps0pSebghtTu7UYwNA0HWWSmgWKwr
        o4ho7JDSi7BTdL4B8eG7gYxXiaNuSGI3Mb1V
X-Google-Smtp-Source: ABdhPJwLT2ZuEsOVkBi1kQnU4XUi1G08j+m8GU1+lKJy45lTkkivaxkbrGinKlPedfjaN/CuQeBHKw==
X-Received: by 2002:ac2:4884:0:b0:472:344:1c86 with SMTP id x4-20020ac24884000000b0047203441c86mr551948lfc.628.1651261204509;
        Fri, 29 Apr 2022 12:40:04 -0700 (PDT)
Received: from [10.0.0.42] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id q14-20020ac2514e000000b0047255d211acsm7463lfd.219.2022.04.29.12.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 12:40:03 -0700 (PDT)
Message-ID: <8db28ee0-6aff-24aa-5bc1-45a639592f88@gmail.com>
Date:   Fri, 29 Apr 2022 22:46:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] ASoC: ti: davinci-mcasp: Add dma-type for bcdma
Content-Language: en-US
To:     Jai Luthra <j-luthra@ti.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20220422054001.3738-1-j-luthra@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20220422054001.3738-1-j-luthra@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/22 08:40, Jai Luthra wrote:
> From: Jayesh Choudhary <j-choudhary@ti.com>
> 
> Set DMA type for ti-bcdma controller for AM62-SK.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>  sound/soc/ti/davinci-mcasp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
> index 2c146b91fca3..377be2e2b6ee 100644
> --- a/sound/soc/ti/davinci-mcasp.c
> +++ b/sound/soc/ti/davinci-mcasp.c
> @@ -2047,6 +2047,8 @@ static int davinci_mcasp_get_dma_type(struct davinci_mcasp *mcasp)
>  		return PCM_SDMA;
>  	else if (strstr(tmp, "udmap"))
>  		return PCM_UDMA;
> +	else if (strstr(tmp, "bcdma"))
> +		return PCM_UDMA;
>  
>  	return PCM_EDMA;
>  }

-- 
Péter
