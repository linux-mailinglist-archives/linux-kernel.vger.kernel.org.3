Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69992505EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 21:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347759AbiDRTrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 15:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241510AbiDRTq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:46:58 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F215E24BF8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:44:17 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-e5bdd14b59so5729080fac.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 12:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=rWmGGN3eFNbyG6C4vAA5Rpc6BDirEyH8qUGKkRRv6S8=;
        b=ELbjEgEXoHbw0AylxCtkrm4TA5gDV4ddY1yZLTC4sodhebYy7i2Iq4rC01GYgEZFux
         DROYmd/UX8PxRaRqMYNMxgowOrG1Bd0SWD9MOEw2hbzjGqVbVjW6LkIOoxj7zrEsJ7og
         94fssyli+ICXv57IeaRsmOjSdmgm8GR2AcjyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=rWmGGN3eFNbyG6C4vAA5Rpc6BDirEyH8qUGKkRRv6S8=;
        b=SmARu/LkyEwfCn0nLhmzAEUdJNsmbZONjsMtAjeWeH8y2k7Vq6+AfQZWW1iViTmNBD
         l+uyeLv9xEOysafAH5v7aS+Fnv/e4V6Ev9LmZbnW/HyT2FRFUj+AgzUSKQ68vYuekIaD
         aF3GS5EHU3V1ZJJ7S2wCVKPEDuDGr7fywl1t6ZiLvXD1uc5yEL8dO6hVT02+JwDsulGA
         ikXWNnIm2zw6zVLAdAuNHiAua7IXF3fF3rjVUp9IVgE0ZuKI9PoF+xX+b74ZUR6qW4Hg
         0agkx+KJvmqRN34Q2wOUkUW3RQFg4DaQ7GEtbZ5341eYDe88so1oRi7Mt4vWkVgf+tXR
         XwCA==
X-Gm-Message-State: AOAM532p1kn8stleq1uI/ZFvb0Xs/l9eg+xxWLrmQezNcnvwAdwcm43v
        7ah4Fp2SSstC/kR4OtPMcVYB4RbEKJtCDk8pFDoEaw==
X-Google-Smtp-Source: ABdhPJwrGJNGpDf85A+0m7ww69jnGF3BIsoKsONnlKr2bunRT6Y9MhKyWKXiQjCdah3pvAI1392EQj8dAnS4WUm+cfQ=
X-Received: by 2002:a05:6870:558e:b0:e1:db7c:26aa with SMTP id
 n14-20020a056870558e00b000e1db7c26aamr5070586oao.63.1650311057331; Mon, 18
 Apr 2022 12:44:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 Apr 2022 12:44:16 -0700
MIME-Version: 1.0
In-Reply-To: <20220415172238.1.I671bdf40fdfce7a35f6349fca0dc56145d4210ee@changeid>
References: <20220415172238.1.I671bdf40fdfce7a35f6349fca0dc56145d4210ee@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 18 Apr 2022 12:44:16 -0700
Message-ID: <CAE-0n53X90fG6SrixDJEOZ-G8A_ryJErd6GbUxafGzeCAyWg3g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add SAR sensors to herobrine crd
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2022-04-15 17:22:41)
> Enable the two SAR sensors of the CRD based on herobrine.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
