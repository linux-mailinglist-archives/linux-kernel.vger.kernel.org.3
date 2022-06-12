Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C697547C0F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 22:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbiFLUqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 16:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiFLUqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 16:46:50 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7AB3EBA8;
        Sun, 12 Jun 2022 13:46:49 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 25so4803296edw.8;
        Sun, 12 Jun 2022 13:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9vE83gxpyTneK+LRJDQvXwXYVpKO1rEjKB2avFmWvo=;
        b=LX189vhcJf8uU37VD5uJlBNUQBi4p9Ybnyg8EZHoPDKHgwOdHOVT3oLFwxHP9RfuI2
         pPb6NYt4GZYRmYabk0FQyDRqZxKu8CVF6PJKukcX8V6IKqk2386Wv8bK7W6n+QpDZxju
         W2UGWibVGzB0ESKBNb7+3rtzaz/U3mR91Dp0y1XVq4WjvB8o9Q92OSJXQugqeitdxF4f
         o7PI1ZVkhgKS5FIY4sAE8eI2LQtTgxrbhemDuPvuSpKEXlhiCvbZXtht8diSlfPCyw7k
         Ai/XcaCJPwpeuZTR3CcQxwJB9SzB58oIzgvu8GIZwrt7FfgEWMRVDfC3VG8cTCTdJ2WC
         Ka7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9vE83gxpyTneK+LRJDQvXwXYVpKO1rEjKB2avFmWvo=;
        b=1rIWRhG1RPDZtXnDCXh+c43S08fT7nVd0g+Y8n1b/wj73K9TCu0Gi/VrvMjIPieh9R
         26imaVzGQ8k5aSqSvHDcVa9KbbSlyYeMBOFTrUc9CM6g9bPHhTvvYL1/Zfrv2Adx/m/F
         qh1Gp+gBnog1ymsmgD4oW+9dAZ1QfRbQl9v2FSFIvb4TESRskMrW/F7Kwr4BIDhh/0vi
         qsD5cXGdBCoXCeYLLajabZ9GhQQYLtZSLUBBrOp6U6Ggk85aJ52E03Y2QCoWcbjiPmkN
         L0T/xinIW/r6QTOx3He/NVvwoqFtxS+r+lcqfvInlD1UcVCQMxZEd12a+tHEp7eB3ThQ
         YYgw==
X-Gm-Message-State: AOAM532jldUm8RjRj5Fqusp78CcGV0xjFZwfjpSfG8NPSVTLillnyT3T
        4OWGR9ZItg+kBmbSptban90=
X-Google-Smtp-Source: ABdhPJz2Oqg/ips414g+9+3tLBNFwYAQfZqjW/LD/v8Mo66Tjc8UpScE7eZstv4jG9D4XGB12cZLKw==
X-Received: by 2002:a50:ed12:0:b0:42d:d1d3:493c with SMTP id j18-20020a50ed12000000b0042dd1d3493cmr61108810eds.174.1655066808534;
        Sun, 12 Jun 2022 13:46:48 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id jx28-20020a170907761c00b0071160715917sm2855419ejc.223.2022.06.12.13.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 13:46:48 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: Use constants for RTC clock indexes
Date:   Sun, 12 Jun 2022 22:46:47 +0200
Message-ID: <4405631.LvFx2qVVIh@kista>
In-Reply-To: <20220607012438.18183-2-samuel@sholland.org>
References: <20220607012438.18183-1-samuel@sholland.org> <20220607012438.18183-2-samuel@sholland.org>
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

Dne torek, 07. junij 2022 ob 03:24:38 CEST je Samuel Holland napisal(a):
> The binding header provides descriptive names for the RTC clock indexes,
> since the indexes were arbitrarily chosen by the binding, not by the
> hardware. Let's use the names, so the meaning is clearer.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


