Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34044F9925
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbiDHPPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237417AbiDHPOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:14:47 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C5E100A79
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 08:12:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id q26so10399357edc.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 08:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XX2KXCol/cB+F9F2M6wlzFqK3IJlqDqtRBrRFqCr29Y=;
        b=xmZp2V8/SWQoUosFHxYo5+Zv/mSOMGKBwKZmvMSMHnsAA6Lzmak2UdaU2ffkf0qICk
         CdtxzrJa64VXnINoRbhednGfkz1nzzejp09cDA/CuPQPIDKKjv7vQAWa4Q7WuALe+WcE
         8p8ICxJ+91iX59qks9YZvD97YYWeOiUKFOJ0+5xDRZdLs+bQfbK29uo+UnGnTjQxdfV3
         qoYR4R0XPvi2KM7FmnS5BAtuwYiPIEsVzGxgShawQv7p78jGuvy/dayt2hHFeHxZV3hG
         OqC0G+BBI3ZmiAP06mS1eAI2qKgC2rFABCwbJJtedNvj16SY/cXqhVZHXXJi1sBZLmbD
         +5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XX2KXCol/cB+F9F2M6wlzFqK3IJlqDqtRBrRFqCr29Y=;
        b=CM8pljjO+n3e8AH8LQCpSOvVnfCZycxrp0wOls1eX6zEUl8Cgew0nzRKbyi9QyOoP/
         9hVrjj2pS+UdVYHS64FLAZUatavyaqOne4ft7Cv68j48ogafUKexD4lRFInVBA/NjIqD
         C3AjqED9wj+nyfr78JhwIoBzF81O8P7SDRk5NDpDBliKL4rNN5z1N6j9y1yPMdqoqSUS
         ypVoNhne/tLsvkQoOXs0NsOOp/RglJqZltWL1LzoOhymEM/1J/wcceMf0ddcl/y9bExu
         8+y/+a0f4nHL1xar6F6pGJuoUnnpidzOByILdfQiHtOaARPsVnhnlq74H04N/nAiGTBQ
         uKBw==
X-Gm-Message-State: AOAM5316wY1g1B579AA7teAHm2E8igKKJwaGdumDDbsYMbIb2WPrYRRW
        lX6M8VZIiC7RjW7Le4hJ7alHBg==
X-Google-Smtp-Source: ABdhPJyyk6UanMuslV4A5Fs+9kw8DBweVAWH39SlZJfK/DvSvceiUMZFRxlsbK/sPjGHa4B4qMXAYg==
X-Received: by 2002:a05:6402:3693:b0:41c:dd5a:e8ca with SMTP id ej19-20020a056402369300b0041cdd5ae8camr19645323edb.225.1649430762007;
        Fri, 08 Apr 2022 08:12:42 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id b20-20020a1709063f9400b006e12836e07fsm8774030ejj.154.2022.04.08.08.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 08:12:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: memory: renesas,rpc-if: Document R-Car H3/M3/E3 support
Date:   Fri,  8 Apr 2022 17:12:37 +0200
Message-Id: <164943075366.672946.10621467910167215562.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <3784b6cb76a008fb56d6cb4ba228d78c77e710fa.1648546583.git.geert+renesas@glider.be>
References: <3784b6cb76a008fb56d6cb4ba228d78c77e710fa.1648546583.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2022 11:38:03 +0200, Geert Uytterhoeven wrote:
> Document support for the SPI Multi I/O Bus Controller (RPC-IF) in the
> R-Car H3, M3-W, M3-W+, M3-N, and E3 SoCs.
> 
> 

Applied, thanks!

[1/1] dt-bindings: memory: renesas,rpc-if: Document R-Car H3/M3/E3 support
      commit: 8f0e3af81711bf72b9c6138b0138bdc330d8c388

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
