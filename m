Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365A456425E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 21:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiGBTJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 15:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGBTJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 15:09:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AA3CE2D;
        Sat,  2 Jul 2022 12:09:21 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id pk21so9710180ejb.2;
        Sat, 02 Jul 2022 12:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z2CBJFGxLvkBWOdkPZxjACJXbe1IwaVXsAKYM/pk24g=;
        b=dEFwEOfX45v0//GviVpjqq5IWtx1JSow/BIplvzXFHhJDfZVVZRwAFvjWMcuWljiDE
         bY+mTufXRkY7HH/dmnUuqGxr4HTgrkmRR7CvEloZ3FosKcWTQs4XDmZigJTificdrYnJ
         JdIHy5wLklKm5bHEkS6oKE4/tRCOPylZVN+Z92nKXuhZOUMJGN6JBQ8D+5Xsq+g8JYA0
         FQAe3S0k/gZaI6Mly8W7ievBowHsieYDcnMcbbWsiasG90nkH52eWQasLnrSi228YPr3
         c3cDBa9FxD7oFI/CMURip9xEpkFC7frMszXR/ulRdW2hEf7Z3Pnkqy300qkkPuixqd7Q
         YmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z2CBJFGxLvkBWOdkPZxjACJXbe1IwaVXsAKYM/pk24g=;
        b=2GoC07Hr74F6HT45xvtTqHg/9107x/QfVeJKLL12HU5gsC5S+uy+Eqq0UAUyOHaQ23
         tazvIce/bxT7kXEcUiVksUfg6gTDp6vMcHIj/OWi42f9zCCkS9gW+CMRIzMoPjqOescX
         teraR3sfPSkNPKk3FE/zm0xNJjv2mCqZTvV5LGA3TT1wUec83CDAvKp+A2yYm8GLhrVy
         xPqvHezOVep3OHB9Dvd+DiZB1wC9TdqbLsDCCjdaJPydgj0rvXOQ0k27m6QCgKBhg7GU
         1dC9qnNq4vloZ9BZeKsvZ5E5+6BR9/l2Qu1GOSfIRmX//CGFNQRkpun1kPTEMWC5cEmI
         Fkig==
X-Gm-Message-State: AJIora9gvEFpvupPUIoLkST3jvMXHXkJxwuU7ESrTanLgtdbDFqSo0sr
        RK+tHrDYOxzfV0DJGp2pYzY=
X-Google-Smtp-Source: AGRyM1uESLTbCkv6TAJWwQQ356i4TjdJ29Qc9KY9qG4xOoR5XnMumEy1l97XJOs4eG+Cz96I//bGkQ==
X-Received: by 2002:a17:906:cc47:b0:72a:95bf:2749 with SMTP id mm7-20020a170906cc4700b0072a95bf2749mr6742877ejb.204.1656788960222;
        Sat, 02 Jul 2022 12:09:20 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id a27-20020a170906275b00b00722e57fa051sm12076348ejd.90.2022.07.02.12.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 12:09:19 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/2] clk: sunxi: Limit legacy clocks to 32-bit ARM
Date:   Sat, 02 Jul 2022 21:09:18 +0200
Message-ID: <8956393.CDJkKcVGEf@jernej-laptop>
In-Reply-To: <20220702190135.51744-1-samuel@sholland.org>
References: <20220702190135.51744-1-samuel@sholland.org>
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

Dne sobota, 02. julij 2022 ob 21:01:34 CEST je Samuel Holland napisal(a):
> The sunxi legacy clocks were never compatible with any 64-bit SoC,
> so there is no point in building them as part of a 64-bit ARM kernel.
> They make even less sense being built in to a 64-bit RISC-V kernel.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


