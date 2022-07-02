Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C352564249
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 21:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiGBTDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 15:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiGBTDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 15:03:18 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3565FF1;
        Sat,  2 Jul 2022 12:03:17 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z41so6740255ede.1;
        Sat, 02 Jul 2022 12:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8UoRIKt+MdEo0nGrpYkHOpyeyu1MYRbMg4sefqGC+RM=;
        b=mtsg3MSK3J7Ilz/+4IHNU3HRqnOz5iVV3E77wemlJRCDVk4MPdPDW5Ile2bdwZkHWv
         grrcYuVF6D6IcHGJd4c/UKe91eoX1+w0lJ9qM7fJiOy4AlffBXVW5g3O79yCV/8mMR8R
         IWZEjOrq3lYyt7QSkaCscZJfBr3T21JaQcbjFmN4RZPTwtNfVSBOUG4g/HWk7m+4s5kv
         a0p7MHPQHEbdp7GtMdcbcTdOeeakfEoxdZVoCHmj3v2aDox+yv6sDaiklwBy6BY5W3/b
         tjHB7C6MvvIoum++4AbrChfPse3iY/tEZr8+92tf6QLSkLMQah2tCQUw2SjJ3urdwHcJ
         tSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8UoRIKt+MdEo0nGrpYkHOpyeyu1MYRbMg4sefqGC+RM=;
        b=dY1mreHozUMQ1I4apWoOp6CgmrSfhTJjAInkt1r+LSgyQSSKo0GbotbDuMixXM79IK
         UOhnQvx6TfHPaVsX7iQxd3ra8KzxvGZf2E5WX3Sq9QGhVpa0QrrWsY9FNNPmOnRoHJWE
         k9/+b388Ich0CeiqOlvJHVirfZz2HodSlGLib42xpdkAhCc36Qd7JU/kC1rwwu4psyzm
         PEOJGJK/6CZsR7SB9gaZSwI2eH5vwSWWRjgMQXCz5OxLok3Ij5KadvKo4pns5jFRPxMU
         kVu/2NvrTwFw4uRFzpoZu32CofJ0uCh9YENV5sCcuQvTsCfWHN8tHPWVPCfLbYOG35gh
         s9+w==
X-Gm-Message-State: AJIora/gTm/JFqv/dQeB5MV8TIHwRjFK9HtFnc08DKR6wpquL4kYRs7+
        OTzc/323WYiJ/WCeKTE8au8=
X-Google-Smtp-Source: AGRyM1tt1qh/Z1d0og/MUS7fqcR831lmUGX2KsGpkE7Yu8O61Sq+1UGGbg9LqLlFSosuNNxst2cCMg==
X-Received: by 2002:a05:6402:104a:b0:435:c7cd:11dc with SMTP id e10-20020a056402104a00b00435c7cd11dcmr27200063edu.335.1656788595913;
        Sat, 02 Jul 2022 12:03:15 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id w20-20020aa7dcd4000000b0042dc882c823sm17049659edu.70.2022.07.02.12.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 12:03:15 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] arm64: dts: allwinner: a64: orangepi-win: Fix LED node name
Date:   Sat, 02 Jul 2022 21:03:14 +0200
Message-ID: <21517512.EfDdHjke4D@jernej-laptop>
In-Reply-To: <20220702132816.46456-1-samuel@sholland.org>
References: <20220702132816.46456-1-samuel@sholland.org>
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

Dne sobota, 02. julij 2022 ob 15:28:15 CEST je Samuel Holland napisal(a):
> "status" does not match any pattern in the gpio-leds binding. Rename the
> node to the preferred pattern. This fixes a `make dtbs_check` error.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


