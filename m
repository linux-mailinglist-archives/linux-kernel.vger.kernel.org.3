Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B285A86FF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiHaTwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiHaTwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:52:03 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4142E3410
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:52:02 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b44so19765283edf.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=YAe10oouJcIvJsSCvWW0rg9AtsdW0wN2bIOcL+HwZ5k=;
        b=Xx/BUA8bRfDFHZD/fwuwPxb2xiZyT4HS6/BVH9bkm3qj9W0Szo9SaxvBNq4USdR8qS
         c7So32dIB2SbdCwO0A1GNIYhzPW5yYBVP4Iq05PK2ApeC/IMECvLziX0Em8Le/NyigMg
         OAgJAB8WufgMWnQM54xrwZV9zsUzuj6c/9VSSggvVMCpmKAG+x5iaMX5AyutWdYL9IrF
         OfUxWNqJ2MPfiHML+Sah9HReEa3N6w2PQ2ssjJe+RYBR5DqMPHE+/Y6yybedDQsTgeGN
         V+xDbHbFrA2jHVBNarNmLUA4QNYsVrF1VcYOG7AUtr640RxfK6ZINbxGdDofM5cDw6R2
         Ofhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YAe10oouJcIvJsSCvWW0rg9AtsdW0wN2bIOcL+HwZ5k=;
        b=TIzThPukdUVhfjSqR8xYqbEFtDCp4FzTGluM/OPzoQqZ4QI4JToKNL5gMoGVhlHlci
         +ov9oG6cTcvycxRwlUFHt8sSFQUh++KENJKcOUx6oy3GktCjnDvT3GMECTyMVMlOslLs
         xqKwzqFDHSRkKAIZ94m9o0jmZSY1yb3VT1G4+wUukVcM6PJlD8ugkQeZH7gnvj7qUOMF
         FJ8JyZolYKLFLWtVzGvRoUvXacoNOiyrqWPZrOCZbLcFt+hf7xuIHyEij8x414O1OdYf
         QKsyCtdBBAY6CwR3eh2J6uUFMHbqQqD9plLdpn0eJ8sgNR89OQK4jJVVN15tE+cSer/y
         M/Fw==
X-Gm-Message-State: ACgBeo3h6Jm6uGDmwqMQ3cx6FWGN+X/Kt7WcXH9x6rCnSDm1uuzBTnRR
        /BkjK/jpZSVygwxZP1aFUYqjVtRN9phIC0SJRLqkYQ==
X-Google-Smtp-Source: AA6agR7Kxmmmd125uoqokPtWEeztFpiN95cjdZyPUX8C6nrUF20VKaX8M4mzvmwAo4PtYV/wUFVTrl4zJTHn9cgDCvU=
X-Received: by 2002:aa7:d292:0:b0:447:f99d:8b9b with SMTP id
 w18-20020aa7d292000000b00447f99d8b9bmr20874914edq.29.1661975520953; Wed, 31
 Aug 2022 12:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220831005739.42648-1-yuanjilin@cdjrlc.com>
In-Reply-To: <20220831005739.42648-1-yuanjilin@cdjrlc.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 31 Aug 2022 21:51:50 +0200
Message-ID: <CAMRc=Mch2vkggdN42MSA-QzerP-wsryoxYio1Qxj_WsS58+hcw@mail.gmail.com>
Subject: Re: [PATCH] ARM: davinci: fix repeated words in comments
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 2:57 AM Jilin Yuan <yuanjilin@cdjrlc.com> wrote:
>
> Delete the redundant word 'the'.
>
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  arch/arm/mach-davinci/board-dm365-evm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
> index d8c6c360818b..cca709236ade 100644
> --- a/arch/arm/mach-davinci/board-dm365-evm.c
> +++ b/arch/arm/mach-davinci/board-dm365-evm.c
> @@ -528,7 +528,7 @@ static struct vpbe_enc_mode_info dm365evm_enc_preset_timing[] = {
>
>  /*
>   * The outputs available from VPBE + ecnoders. Keep the
> - * the order same as that of encoders. First those from venc followed by that
> + * order same as that of encoders. First those from venc followed by that
>   * from encoders. Index in the output refers to index on a particular
>   * encoder.Driver uses this index to pass it to encoder when it supports more
>   * than one output. Application uses index of the array to set an output.
> --
> 2.36.1
>

Applied, thanks!

Bart
