Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0648D56BF92
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238828AbiGHQPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237995AbiGHQPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:15:31 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3EE76EB4;
        Fri,  8 Jul 2022 09:15:30 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id va17so2080186ejb.0;
        Fri, 08 Jul 2022 09:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SLM5PUwTV31o0kHfGXDzIJFVkz9EnZxECRqe7Eh0GBQ=;
        b=QOVATOOfBLjHUxfN9QCROHwRyowlMCkwTO0uRvQYtkT7889uWXuqssJomf8UYieCOH
         rOsyd0Qs1SZpcSisQbGXueVwVgpGfeIgniy7d4JTgKGCnFm7IXyjd34VQ8VDwgnbI34I
         tHJqi8SnqOf99qKxi7g2sH1R2ZdV1jDmrdRdiHfQVHu3QeplkH6iZ5HP68HWKdebByl0
         O08Wy+WH9jN4t84EPDCmr3iqRzhuv21trCJcNgcfVJj4T5sfTdnLpGFnmBHxNXUliXpO
         97leioUbrmBwxj9sQK+4jjq3jyuNI6lPxHF5G/FeleG3IBhxIY5hhbZ6hKHPf11Zo7D5
         CKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SLM5PUwTV31o0kHfGXDzIJFVkz9EnZxECRqe7Eh0GBQ=;
        b=3R7/a/Ot+yDPAJRXyc+EZk1jIcejeUyZaVf8EwHlpUd79NnJu6Iy6VJyHO6XR/8526
         7uLMfF1WeAa4iQBpNPMrCTJmkqclFr3WJIkW/7wOJD6HxqmoUPtmSdJLqBhTmwHMnj6x
         cU3fEgtTvdIhpj/k9XW/4zzyaDMJ3hBAWAtivFJDsgzbJxA9CQ6KsekSv/U7p71s5mIv
         MyyIZddL4+H7MTYjepB+qDDidN2dhs2Uuy2jzvWJqqAgx4+Zv9ficJKeV1diZJk68jwm
         CVXGOgT104tz+0OEjQi8X8tveVwQIXplI1FDqH1+P8wBgSFdGkbAif0Vfh2IA4lE62b8
         SVdg==
X-Gm-Message-State: AJIora8tlBKbV1Qj3SaKOQAcv9wIVNtqJAx/vYpavWznRnNJzO4VTy84
        DVsRi7T17hInFcwT/oOGD0o=
X-Google-Smtp-Source: AGRyM1sUnIACkJ+dK6objElcohl7xX5z6IIBO2igjeYRXpiLZCRqJ+I7upZxDk5p8T2cnAhMP/w6wA==
X-Received: by 2002:a17:906:9b09:b0:72b:d70:32a6 with SMTP id eo9-20020a1709069b0900b0072b0d7032a6mr4248571ejc.723.1657296928940;
        Fri, 08 Jul 2022 09:15:28 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id cn22-20020a0564020cb600b0043a896048basm6071727edb.85.2022.07.08.09.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:15:28 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     samuel@sholland.org, Roman Stratiienko <r.stratiienko@gmail.com>
Cc:     peron.clem@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        mripard@kernel.org, wens@csie.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Roman Stratiienko <r.stratiienko@gmail.com>
Subject: Re: [PATCH v3] clk: sunxi-ng: sun50i: h6: Modify GPU clock configuration to support DFS
Date:   Fri, 08 Jul 2022 18:15:27 +0200
Message-ID: <1930698.8hb0ThOEGa@kista>
In-Reply-To: <20220705075226.359475-1-r.stratiienko@gmail.com>
References: <20220705075226.359475-1-r.stratiienko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 05. julij 2022 ob 09:52:26 CEST je Roman Stratiienko napisal(a):
> Using simple bash script it was discovered that not all CCU registers
> can be safely used for DFS, e.g.:
> 
>     while true
>     do
>         devmem 0x3001030 4 0xb0003e02
>         devmem 0x3001030 4 0xb0001e02
>     done
> 
> Script above changes the GPU_PLL multiplier register value. While the
> script is running, the user should interact with the user interface.
> 
> Using this method the following results were obtained:
> | Register  | Name           | Bits  | Values | Result |
> | --        | --             | --    | --     | --     |
> | 0x3001030 | GPU_PLL.MULT   | 15..8 | 20-62  | OK     |
> | 0x3001030 | GPU_PLL.INDIV  |     1 | 0-1    | OK     |
> | 0x3001030 | GPU_PLL.OUTDIV |     0 | 0-1    | FAIL   |
> | 0x3001670 | GPU_CLK.DIV    |  3..0 | ANY    | FAIL   |
> 
> DVFS started to work seamlessly once dividers which caused the
> glitches were set to fixed values.
> 
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> 

Applied, thanks!

Best regards,
Jernej


