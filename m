Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953EB4F8785
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347049AbiDGS7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbiDGS7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:59:13 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AF61F6220;
        Thu,  7 Apr 2022 11:57:13 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id m12-20020a17090b068c00b001cabe30a98dso9719591pjz.4;
        Thu, 07 Apr 2022 11:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fjfMH14nLSkMDnnKtE5L1IuBOYrAsVEJHiPn3iCRihQ=;
        b=ib+BVLZG70Qa9tNJVjW+DP7S7zG8Sz0Mu0z9Vsrm6beJZbFm2c600ddOU5xzbqi/lT
         +hVf2Y3N4NDZ1GgEqFEoRZfQutryTDtyTyvemeIik008mZmcny2Rg3a2EG/xJJ6Gooyn
         CuNQ8WyLiJ9kkHwRonfBiFYTOd/CrTL0Uqdq8cD98VgXfI0Bv/79NMmMYtI5+J5Zu8OO
         7cHddsEbzFQ7Kta6im5Bqf5MSrpe6TpB2+1cupgiXO1mMiag93EBQxn8hyM+tI+5gy78
         2IXG8fksG7aG98BqbaA1KrLWf9M5DNKrT0/7CQjah4ONAdSTb5fUs5ADOwycfrERAjOz
         7eyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fjfMH14nLSkMDnnKtE5L1IuBOYrAsVEJHiPn3iCRihQ=;
        b=PuQysnpDoFrTeHkqHwdBIR2C2hd9deiQxy/Lo+ljPb0r+AWHEfJnKuYWPdEqd5EkVq
         MZ3sPMwgGG6h/kEWSSIzPokuPFKGBnjTqBxzJnb4lyOnmFq1TVoJAm1s16Bfuz/le+wV
         naF+1Jbtu3YHGoqOLv4/COe/bhVGDQ8+eE0DWxPcBDzysSxq+UfkfZiBmhO4Z6RIAyK9
         YWuUwbxyIln6m7K57P+1XaRS+gJbt6fIdRxTe7p9LQQKHI6OfLt1j+rdz2ufaFTtBnwR
         aC/Z+6NauOugp4hjn4S3e2QE65+augP8Hge938QTqTyhRxz83lZ/e0/s6Rf+gy8inGfo
         n31w==
X-Gm-Message-State: AOAM533H3OlJvBck/qhAEmR14bteEAuX5+O+EQhiN2qqPiyFLgAY1YZr
        NxFsl5kFtRwl13V3xEEgIbk=
X-Google-Smtp-Source: ABdhPJxKiXW++JCjkgt7WZPtwFvVz0q5vSA+Rek93fe4ELbSwwkHlD5Ks3ibsfT7C03gpbp7g9h1fA==
X-Received: by 2002:a17:90b:3b89:b0:1c6:56a2:1397 with SMTP id pc9-20020a17090b3b8900b001c656a21397mr17527719pjb.239.1649357832895;
        Thu, 07 Apr 2022 11:57:12 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k11-20020a056a00168b00b004f7e1555538sm23214944pfc.190.2022.04.07.11.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 11:57:12 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: broadcom: align SPI NOR node name with dtschema
Date:   Thu,  7 Apr 2022 11:57:10 -0700
Message-Id: <20220407185710.2576287-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407143211.295271-2-krzysztof.kozlowski@linaro.org>
References: <20220407143211.295271-1-krzysztof.kozlowski@linaro.org> <20220407143211.295271-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Apr 2022 16:32:11 +0200, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> The node names should be generic and SPI NOR dtschema expects "flash".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian
