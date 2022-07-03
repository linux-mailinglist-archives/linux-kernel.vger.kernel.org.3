Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F148C564457
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 06:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbiGCEBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 00:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbiGCEAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 00:00:01 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2EBDF3A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 20:58:02 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-10be0d7476aso1956578fac.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 20:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2MMLIS8cAzDkNpWsQPp28lmw+anecb/WoThsjFIeK5U=;
        b=WC+Ziy8/Bob0X16uWX/xImZvcvjq/l5b2fLhePlorXloxVoLzhP3UfZYPi/EsxS4CY
         jvRSKawiROUD8vmi3EEDS9HzFkY9bEXXam/n3xI42qz8xqepvAj6VuaTSHooDccdZviT
         dDQNJOKnTxqE4mJVgoqw2+qnnklYeBIshRDiCNPzPJoABD0eoTuw3EUwWJA2urCA7Tqi
         XJIrcrXOZJ2BC0hYOr2cPB7o2Zn9yVb76CPOPCL3W6n1s225DPmtygqle64sB1Icktrm
         Fp1k7YSHCZa2VQah5XNB5hwFsSKZUjd6xNw8GeCKHU2Wmb5Cm+p67JnpNuj0rWN4PGvO
         iufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2MMLIS8cAzDkNpWsQPp28lmw+anecb/WoThsjFIeK5U=;
        b=ApDOPDvtNYi68jZzOiZ7t7Pf1qvk1ASxAKdjuhQ9ZWidzvC7b+okomxwgQR6v4+BDT
         yT5Uf+1nEQlX5mnp/+nO9XipwtXxpLQ5YqoOuZoKniqUgt98fLxuDxcSKCPZomy+lG/S
         xJ2HXYL0JsOjBePLz9nvt/EfWf/87PuXGZ7KyggV0ssbCA5eLBeMgci8aRFmrYfEujek
         3sBsIZ0ta8UXNU5AqgH9/BkmdEfNsgngw3DG/fyBIdV1yB07vlVHEOTdXN+vOq8EovMU
         GSD//aAWR3uq8gkqiHK+aB62ZgYx2JK+gMcxs//qlo10if24k/CSUKfyunlmxVmxWNsG
         UHaA==
X-Gm-Message-State: AJIora8aR1Xz380Ipjz9f+5uZ0WkrMCx8keXeVFJn5xUmiZcmVdu3Fmq
        B75KjtdoTYth3I1c4VUIRGwlIw==
X-Google-Smtp-Source: AGRyM1sn7duHueqga+9gh3H0h8NQssXx6Jmy2XwnG3kA8FZFLOTpmcvtxRBieqIvLpype8hON72xnA==
X-Received: by 2002:a05:6870:c598:b0:108:b7e2:ac8 with SMTP id ba24-20020a056870c59800b00108b7e20ac8mr14382014oab.1.1656820681778;
        Sat, 02 Jul 2022 20:58:01 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 25-20020aca0f19000000b0032e5d0b5d5fsm12965910oip.58.2022.07.02.20.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 20:58:01 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 0/3] arm64: dts: qcom: Get rid of some warnings
Date:   Sat,  2 Jul 2022 22:56:54 -0500
Message-Id: <165682055970.445910.6231160279000811511.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220606065035.553533-1-vkoul@kernel.org>
References: <20220606065035.553533-1-vkoul@kernel.org>
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

On Mon, 6 Jun 2022 12:20:32 +0530, Vinod Koul wrote:
> This attempts to make W=1 free from warnings for all SM* dts files.
> 
> Bunch of these are releated to node not having valid unit address and being
> present under soc node. So moving it out fixed that. Interconnect node was
> simple rename to remove unit address which was not really valid for these
> nodes.
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: sm8450: rename interconnect nodes
      commit: 12cfafe7b78876133474f4b3e44e0464a94f61b0
[2/3] arm64: dts: qcom: sm8350: Move qup-opp-tables out of soc node
      commit: e2eedde448a9be6202fd9965aef29d4b6607ee67
[3/3] arm64: dts: qcom: sm8250: Move qup-opp-table out of soc node
      commit: 191c85b852c122e9282797ae3ce2a36083f1e9a9

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
