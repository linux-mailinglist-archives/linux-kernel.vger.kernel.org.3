Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1554FBC84
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346226AbiDKMzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiDKMzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:55:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E062C1573E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:53:35 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b19so22833042wrh.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H2Wa14/be/MapqwdEwUDQHMWBsanYigO3XT2Lr6Swoc=;
        b=K++AZqOu12JXzZwEh27ZnzSiLauYhZ429z4DGGxRxtltLvCIIPB8hbzu20nV3Lf5IE
         i50tR2SmPpo3vAyoivozenYAKfWdUATC1wpCrn14O4F/6thnVXiLB/4Eergew46a7BlP
         lA1KhCgyXEtoi/0rmgyS7Aco5A3slPKfo5bhMEooe72KmRbJfBcm73Jd8YIfvHQIijJ6
         Ea1xHzXEFjb0Ym+EufbtDsAKYApeaImPJiL0Rj7GYibVhA0jpveCDpOE+u8I5tJte2cU
         fQFk96Ksyn6eLgR6UbCKb1HKxo+zjw1enMfdQVuIszqYUytCrzC9CbPKYI1xrDChKqml
         cExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H2Wa14/be/MapqwdEwUDQHMWBsanYigO3XT2Lr6Swoc=;
        b=Im+yfYQPLY3M0IeBILPkK/rcFlwPAf29yhjvlsEU8sd04tSpzc4hVA1FWx538G3nGz
         ZzIsULhp0xaFutGd9gGPFiqvuEZ7zvhlKuEQ/ayghmjVM6YuzojFKXQHo7dgledq5CFQ
         BKLLSt5AxbudBA+0r4m2CfpFzMlgZA166mwGL+LEN8JITy3M9BBy9yHK195PzMtfk+EI
         fmN+LF+QyIwg9IZg5nhDyk2zEbR2NEi1/Lw3Awvfm6uN48VTOHXRTrlX2OG7+V0aRfJ/
         IdrX9o/idp7Xn/p9XoljR8aH8KDi0BDQunYEk8zGzlWVTDop/2isN5MNwZ31CLaaSigV
         KXXA==
X-Gm-Message-State: AOAM530d3UHfK+oGVzSf6a/HhA686GMBdG9vjmsHMzoAEDAbiPIVuNd5
        6RSQXxOWmmPrVseRJtz2/S6pgAAildiLqOzI
X-Google-Smtp-Source: ABdhPJyKHLzX422TghnhzNrWqsYIgexNfpxMzJ6eMiGfRQI2foPOm76YuWIKjNXyDCksYKZV0Ft/XQ==
X-Received: by 2002:a5d:6b0b:0:b0:1ef:d826:723a with SMTP id v11-20020a5d6b0b000000b001efd826723amr25713546wrw.420.1649681614311;
        Mon, 11 Apr 2022 05:53:34 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:d1:e096:d183:1bc5])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b0038cb8b38f9fsm18613040wmq.21.2022.04.11.05.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 05:53:33 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-arm-kernel@lists.infradead.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] arm64: dts: meson: alpa sort the board Makefile
Date:   Mon, 11 Apr 2022 14:53:31 +0200
Message-Id: <164968160694.932109.7341549191882617182.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220409064257.24453-1-christianshewitt@gmail.com>
References: <20220409064257.24453-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 9 Apr 2022 06:42:57 +0000, Christian Hewitt wrote:
> Let's alpha-sort the board Makefile to keep things organised.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.19/dt64)

[1/1] arm64: dts: meson: alpa sort the board Makefile
      https://git.kernel.org/amlogic/c/456733feb0da2dbb1288b9e8f5765df163620c2c

-- 
Neil
