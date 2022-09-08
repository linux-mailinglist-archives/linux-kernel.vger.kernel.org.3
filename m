Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF8F5B1E5D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiIHNQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbiIHNQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:16:27 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E849736DD9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 06:16:25 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id d15so350105qka.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=EN6OrD+swNcWW/wUukKGtS71vNoj6oAVRqW0V6ZuKEk=;
        b=CqwpNi69rThlo0cS3WTkGCN55zgJSSsauKK6O7cxA6Rk6Pmrc2LFmjV01HTW9SWfSF
         JATZmwjV8Vl911BKbTUnTq7ElUe4UAjKzWpex5RvJlEohLKlVU/GoKjvoiNzpLAfnNJN
         8OCZwK1hcQdNpu/7s9GvihTRW1FePL2ltzuMZ/YDRQZdJNs1dF4zhormnAduqQb4Vvyr
         UVGlhtpQD1jUW/8zrRUFclMk5b4FniicyOCQhZlWH01+s1PlqkcadVsZJovfCH3mQfzx
         +s8Xt665oQKlnROLalm5AbxrOKcyX4oHnlnI7QsSNPBMb6sx0jC/X15Tgc4zNFIuhM/3
         XLiQ==
X-Gm-Message-State: ACgBeo1dXm64GgpIfxJkZmbCITH3YPemPXqTZcv/QEovsk/griuyVhk3
        M5YC465ojT+G+mkT/5S/pF9UT6Mcc9KBHw==
X-Google-Smtp-Source: AA6agR5IYjoyvGDZfio/QyCBFa5badB0e51l75vte3Z1Vp9d+HPSJ2MGbIVyOyG8nHqfJGdbkkEHWg==
X-Received: by 2002:a05:620a:bc5:b0:6b6:64e9:2617 with SMTP id s5-20020a05620a0bc500b006b664e92617mr6098771qki.378.1662642984774;
        Thu, 08 Sep 2022 06:16:24 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id h26-20020ac846da000000b003450358fe82sm14080414qto.76.2022.09.08.06.16.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 06:16:24 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-324ec5a9e97so164135747b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 06:16:24 -0700 (PDT)
X-Received: by 2002:a81:758a:0:b0:345:450b:6668 with SMTP id
 q132-20020a81758a000000b00345450b6668mr7265892ywc.316.1662642984197; Thu, 08
 Sep 2022 06:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220908125735.30134-1-wangjianli@cdjrlc.com>
In-Reply-To: <20220908125735.30134-1-wangjianli@cdjrlc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 8 Sep 2022 15:16:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUwL-hWeMyrJUVCmpimputMwxpBaQKB1705HfZ_drGGAw@mail.gmail.com>
Message-ID: <CAMuHMdUwL-hWeMyrJUVCmpimputMwxpBaQKB1705HfZ_drGGAw@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: fix repeated words in comments
To:     wangjianli <wangjianli@cdjrlc.com>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Wangjianli,

On Thu, Sep 8, 2022 at 2:57 PM wangjianli <wangjianli@cdjrlc.com> wrote:
> Delete the redundant word 'in'.
>
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>

Thanks for your patch!

> --- a/arch/m68k/mac/misc.c
> +++ b/arch/m68k/mac/misc.c
> @@ -126,7 +126,7 @@ static void via_rtc_send(__u8 data)
>
>         reg = via1[vBufB] & ~(VIA1B_vRTCClk | VIA1B_vRTCData);
>
> -       /* The bits of the byte go in in MSB order */
> +       /* The bits of the byte go in MSB order */
>
>         for (i = 0 ; i < 8 ; i++) {
>                 bit = data & 0x80? 1 : 0;

The original is correct, cfr.
https://lore.kernel.org/linux-m68k/CAMuHMdVf7EOrXkUpa1E1Qx1w0Tvrt1nwRHM6B8rsGPOh=WsnyA@mail.gmail.com
https://lore.kernel.org/linux-m68k/CAMuHMdWwqKyvtxkvdng0EVFfKjz9iOjK3Dhfd+iru-j731azTw@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
