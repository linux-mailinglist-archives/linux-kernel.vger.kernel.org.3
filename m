Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A019D59B55D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 18:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiHUQN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 12:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiHUQN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 12:13:26 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070E62DD9;
        Sun, 21 Aug 2022 09:13:25 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-333a4a5d495so234733017b3.10;
        Sun, 21 Aug 2022 09:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4jWg3pa8oTEiXPQ4lpu76iaATY92QDHZb7IidOt0SyI=;
        b=Hyw9U2ZJCY3p7yK7rox0xxNjkaiTWB1F5GdXRAPnPf2MWoFkGV6ORCHDkO1941iuSO
         +/PnnYHK4rHyGhNkl/nJRgpcFb3KvTnGapYMU1YUOuZFrv8qA3fWIMMKf3kTaAhrPA25
         auDQ2JtJP6oEcHceFMLGuuGg9zKj72qg7b4gMfo6u45suzU/ocu4ZR+trx63fBK7VCI3
         K5WHgDi13KbTv61zvYAPbtJ9oxrhQhMBmBge6ZuxZuwzkJHv8tB+U0XtezStcgVSc5+3
         YokCyHA/0qKvkvmLNKNB7L3S+Ht7xUi89861BIianntbkHP69pFUWsYoHLhFNhz9aIWv
         uWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4jWg3pa8oTEiXPQ4lpu76iaATY92QDHZb7IidOt0SyI=;
        b=znP3KWaPIhj7Za0LvoV4gfoc+Rb+vT0i6LsMGgV13rdLcyi+xPf98Y09SE6Iex3QeA
         vfFFtAmy9b7CinHuXrL04W7gAqLuprqR93KsViyqgkLbrc3mgLiqsufGoQBAEhYQIIq/
         xUAH1yvo9eTuE1NN0ao9O19dkcnJzArszHxObqq9/DZvCKb8Djt6jclag78c1lW5ZY+A
         zfCR6JHkxRScfLVbNwN81TIYgp0t/qpO0UBbaPqAWeexYZAS2vWtSqvffquBJ2sr1mo7
         DCCkqN6gDJ5WImG/rTmaHt4nM81/PqGf5eX8ItyJxyhhKZPNJ7lKrsz9QLS/58AYJZ1x
         sxXA==
X-Gm-Message-State: ACgBeo0RoNLlbPm6dVNMFwqq7eFnMBRBeMJcJQ9x/i/xIUmRmj6AgOcR
        msEK7VmGAbQ4LmCJ74s/Nu2wpz+0L6LbEfw5QNY=
X-Google-Smtp-Source: AA6agR6p921NJbFG9woz8lz8NnF5oqa7HuAlDjs784eoChdosYBnVJWRG9lGJIGcdKLbM+FeEsFNg0dcrrNBcmMPAqE=
X-Received: by 2002:a81:d543:0:b0:325:2240:ce5 with SMTP id
 l3-20020a81d543000000b0032522400ce5mr16442058ywj.210.1661098404182; Sun, 21
 Aug 2022 09:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220821153546.7358-1-wangjianli@cdjrlc.com>
In-Reply-To: <20220821153546.7358-1-wangjianli@cdjrlc.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 21 Aug 2022 18:13:13 +0200
Message-ID: <CAFBinCCb-t2+F=EFBYc6QhPa8bL8SaXDcUBAQbW+WE9P0N=cHg@mail.gmail.com>
Subject: Re: [PATCH] clk/meson: fix repeated words in comments
To:     wangjianli <wangjianli@cdjrlc.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, narmstrong@baylibre.com,
        jbrunet@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

Hello,

On Sun, Aug 21, 2022 at 5:37 PM wangjianli <wangjianli@cdjrlc.com> wrote:
>
>  Delete the redundant word 'by'.
>
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>  arch/x86/tools/relocs.c        | 2 +-
>  drivers/clk/meson/clk-regmap.h | 2 +-
The clk-regmap.h change is fine but it needs to be separated from the
x86 change.
Can you please send an updated patch?


Thank you and best regards,
Martin
