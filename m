Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FADD5643CE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 05:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiGCD5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 23:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiGCD5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 23:57:03 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAA2B1E4
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 20:57:02 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so8767361fac.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 20:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qDb/1N5zpqr9xZng215zT4M8Xzp1EhvldHx4QoOpCZ0=;
        b=FPBwIBQinMKOGLKxeAohMB9V0597+hB6PEPgGvLFX6BlEm/GePPpCVbaEzi0vO0juD
         Ek4KJ0zxtNXHmHQLmR1fRcH76xZbUv1GWeX6VjMhCz5+VUQB/gCUkAYXPU0JigqwcOEC
         BqfInsKt+KXQvBOGGh0/1aKs+fZfjvkL/QUGk9idWCBuKG9pUXeklkh3d7kDwN6Th1IJ
         NFt0vPjWPug789FkTKfQ7UfqlpyAThHLVdLhsIgsp9wo0SVe/imk7Djr9AfjLheN+pAq
         sZ9emcoAFRLiW59niXXWianCUtpDsZHcPekBJwGPV4KSbIPvNSo59M/ChD7DyDaiAXAf
         73NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qDb/1N5zpqr9xZng215zT4M8Xzp1EhvldHx4QoOpCZ0=;
        b=0Izw97RXLNaMl9dC8WITlsb+9N3il9l9R4pwP4+Gv6a74H+TNsZrD46jLz4eNAjpQr
         A8UF0FKZuLMNs98r9PVOCm9FSliXA9LiHuima8p2iHWIvKaZ9TCBMeIImIQbq+ggkdFz
         tDXX7olDzvWX/4sRjZ/EccIBsUjnTTQ30k+lXZ29sS/iyA89h5mytImPqsB4rLV4hoNU
         eIFNCfZRFp5X6MLsywImH/gxkq0RIpqkdSHDb025OX/nDYvLWG9M6yagLZGBG1ekp/0Y
         Rf4rWWcZJNGZWxlg5VwAGD4yBaztQh3upCW+gUeXpf8L02OV5qkuvjUkF4/zvNZEL+SF
         82JQ==
X-Gm-Message-State: AJIora89CZmLnkTOL3WjiEewgha3WM+c+/8BVw4dulRytD0b0LINTUy1
        x5EkCt31ZliouBem9IZNaL1Y4Q==
X-Google-Smtp-Source: AGRyM1tquMf88SNyzNudD5NbUyjNeErwwVOPH28XjSSqWIaQhSKly1LDRrOqbiswMj04kCpOw9Si1g==
X-Received: by 2002:a05:6870:c598:b0:108:b7e2:ac8 with SMTP id ba24-20020a056870c59800b00108b7e20ac8mr14380414oab.1.1656820619995;
        Sat, 02 Jul 2022 20:56:59 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 25-20020aca0f19000000b0032e5d0b5d5fsm12965910oip.58.2022.07.02.20.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 20:56:59 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Ansuel Smith <ansuelsmth@gmail.com>
Subject: Re: [PATCH v2 0/2] PXO fixes for ipq8064 dtsi
Date:   Sat,  2 Jul 2022 22:55:56 -0500
Message-Id: <165682055967.445910.7019272591811059456.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220430055118.1947-1-ansuelsmth@gmail.com>
References: <20220430055118.1947-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Apr 2022 07:51:16 +0200, Ansuel Smith wrote:
> This small series is a fix for a long lasting error present in ipq8064
> dtsi. At times the kpss-gcc driver was defined in the dts with
> <&gcc PXO_SRC> a pxo clock. While PXO_SRC exist in the includes, the gcc
> driver never expose it and if a driver try to actually use it the result
> is a kernel panic even before any log is init.
> 
> To prepare for correct conversion of the different krait drivers to
> parent data and to reflect what is defined in the Documentation with
> actual driver and dts implementation, fix this error by using the now
> defined pxo_board fixed clock.
> 
> [...]

Applied, thanks!

[1/2] ARM: dts: qcom: replace gcc PXO with pxo_board fixed clock
      commit: eb9e93937756a05787977875830c0dc482cb57e0
[2/2] ARM: dts: qcom: add syscon and cxo/pxo clock to gcc node for ipq8064
      (no commit info)

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
