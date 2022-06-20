Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A77155171E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241883AbiFTLPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241622AbiFTLPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:15:04 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157D7167D8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:14:48 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id um5so5440742ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3YSnqTYqRuc0HngtFWPh5+kNVV+S5mddHDRCwdOnK0Q=;
        b=sHfqVD9QVh6BFE86b+wXb3sr+EcPv8EmCTq887SRnIWvpaBi2tnrvqH3pfdrb9C72k
         UVSz7dQylpwxlc/9Q3nx7I3S9URKtp5lwVgnAQNKpqbvQzMn95Ay2BDX8YDdGZzNLzoS
         mVQyJIfBVpyQeBm3O1smpb5rG6XxDGm6AMwcgeWrEnEAvjxgCmxOoYKF1brDSObo1luK
         Hi93uucIiYVsCIwEFRMLkc5t8Un37ivWtKKKHlwFillSc5tJjqTkC4buXrcrnZufCRvF
         tOcpCE0p7fn3JEF7/eDX1L4D0RSnAuI0Bu1+fZRcwMxNds4oe3UVmrYyEPxp2odLL4EK
         HtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3YSnqTYqRuc0HngtFWPh5+kNVV+S5mddHDRCwdOnK0Q=;
        b=aUghUALS5PEUMc88MFjsmF32xvSKy1ZEnJVVsyrnOusKOeXVFkEscb1paSxHLoslcJ
         yRwaXArnhy/eEbp9OT7WOzLupu6yZm7pmSVprhzZdHRW+wCmP8PLFYxuL7erSoEmlO32
         42dhGfk/BktYODIDPKzG1eTH8SX6h96Vi9ALJYmEXlktLW1r2flJpRzQ013pf5LvFfgs
         RXVM4lUoAVmHzSA9dld2z2RW6hPsKURxHpayZiCe+Vlk4LbTax1DatidYWaUibDAU3s5
         sc7ZXD13sV+NFDlZ8mhWSCm4yf3a7AQfcLWiHi4XoAcBCOsVQkFiQ7rR49ezyic8J+EU
         VpbA==
X-Gm-Message-State: AJIora+VKGlbBcUbqW2+yUEf9tfj1oorHhEPg58yIvvkbJgZlfpcsrkt
        BGRkJNB2p0lhr2Ikpl26zLZ2VQ==
X-Google-Smtp-Source: AGRyM1t0aGHuhS4the+spmM02P4NTAGwl1TwS0neV2qA6YlGz1BJWmh9mn5i1N2POVtWv9Fhp0eZOg==
X-Received: by 2002:a17:906:74d1:b0:712:2293:8f41 with SMTP id z17-20020a17090674d100b0071222938f41mr20109070ejl.495.1655723686682;
        Mon, 20 Jun 2022 04:14:46 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c26-20020a170906171a00b006fed9a0eb17sm5699969eje.187.2022.06.20.04.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 04:14:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        soc@kernel.org
Subject: Re: (subset) [PATCH v3 35/40] ARM: dts: animeo: correct gpio-keys properties
Date:   Mon, 20 Jun 2022 13:14:35 +0200
Message-Id: <165572367263.35195.8304905583649336155.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005333.18491-35-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org> <20220616005333.18491-35-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 17:53:28 -0700, Krzysztof Kozlowski wrote:
> gpio-keys children do not use unit addresses.
> 
> 

Applied, thanks!

[35/40] ARM: dts: animeo: correct gpio-keys properties
        https://git.kernel.org/krzk/linux/c/91503e5a3b5aee6ac7240d1f03abe69253c14de9

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
