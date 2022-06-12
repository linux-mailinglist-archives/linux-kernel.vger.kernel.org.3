Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABB3547C0D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 22:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbiFLUpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 16:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbiFLUpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 16:45:50 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192A73ED0D;
        Sun, 12 Jun 2022 13:45:50 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id kq6so7519086ejb.11;
        Sun, 12 Jun 2022 13:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SRFzNbjk4H9hinoFoNd44twu7qtxWwrffjJnSc0bRew=;
        b=BZKpQ5ELLmQbihzDjfblTFbGC2I+T9gJ8arG1w0VMdKbXAAnnmiZ+iW+R2L02PTW2M
         mv90XlufKHVTD3JAk2wYcdFjAm4E3CtGP3ozMzcH0OLSRbVXdsMrpM3bPIskZ4s4xD9L
         CDRbrSiAYvxTvTUktVRCyl9t3RUZZ6p3DgUNj9NyYzrsbMMmtpB0+66IUPJhy9QwIvmk
         XMIhDOIU1LFXAA9RGHDAftRrxJ+CtA2vN+RBrw9vhMcwFs/klut9qdhhmTBGOhS0xroS
         wlM07nP7dOmcsxj7XgonqdpPp/HBI9sn6v3ySEYCmhaMJvFjsyLuETT5dlmAEgpiNW0+
         7/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SRFzNbjk4H9hinoFoNd44twu7qtxWwrffjJnSc0bRew=;
        b=LvMzfqJKf9m0mIdtgjjGidAIZ1DkgcVkMyoTSlCtuAHIboy43JrmBRd7u9pCx99mMv
         QN294ORAk/VFZmYbmtuqRrGz6G+UIuz/5MtGXTB6VWJ6CyS+vZ3xAjVsOT0QQAdl5Q2y
         p5yvYb4NoSkf96VMQMmUSdhvF6UqBRtOrJZHHABmZExQy7k7y8gBlU/5fMQarXWCOCZ0
         R05O2c7opMxz7KiZI/iKKR8BfgFfy14VRSswK3C5SqQ7018k/ALCSEAZ7Xbekrdxm4sx
         +/OGkSTaF0//IQALNhoaCFCF4uxCdouABTMrVt+9iTnO9haMrCVyhoIgUzPQzFLx6yCL
         VrIg==
X-Gm-Message-State: AOAM533likDBeYKmOlJEwOre2Xuq+QSYb8j5C3wN5onruI19Coea6jxN
        XXvQpptLlNolXrkReqVMYic=
X-Google-Smtp-Source: ABdhPJx6y4Mf6UyjG5YD0LqHnRbLlOFbtWpwQxxW3P7Rj517zNQkICgGS1aQFRPvGfRCchZ84/w1cw==
X-Received: by 2002:a17:907:1b05:b0:6f0:18d8:7be0 with SMTP id mp5-20020a1709071b0500b006f018d87be0mr49697018ejc.561.1655066748399;
        Sun, 12 Jun 2022 13:45:48 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id f22-20020a170906139600b006fec3b2e4f3sm2849499ejc.205.2022.06.12.13.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 13:45:47 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/2] ARM: dts: sunxi: Use constants for RTC clock indexes
Date:   Sun, 12 Jun 2022 22:45:47 +0200
Message-ID: <5831557.lOV4Wx5bFT@kista>
In-Reply-To: <20220607012438.18183-1-samuel@sholland.org>
References: <20220607012438.18183-1-samuel@sholland.org>
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

Dne torek, 07. junij 2022 ob 03:24:37 CEST je Samuel Holland napisal(a):
> The binding header provides descriptive names for the RTC clock indexes,
> since the indexes were arbitrarily chosen by the binding, not by the
> hardware. Let's use the names, so the meaning is clearer.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


