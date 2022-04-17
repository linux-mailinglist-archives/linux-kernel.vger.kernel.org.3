Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67ADF504A04
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 01:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbiDQXOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 19:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbiDQXON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 19:14:13 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10445DE99
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 16:11:36 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id v77so23027098ybi.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 16:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d49fctPOnNktvKVCBx7OGb1D/6V9QbzUvjRB/Aya3Fw=;
        b=PvgrLvCpIWcJX5Fmqy0HGL7S9aIYSLOO7r44sPF/WLEqn/J3eGneASpONCsFipyPXo
         bab2boVkfts9LyolYotkj2R2vy4bSkRdvlc7xWuQ+2lmoU7vOL6pfHPWL1c9t66lcztz
         kfAUR1kcTzYPIqjqubZnJ2Zkv1Om5tROzl0CoBiYmBrfEBSZDJWJdWlFZaDa50PFLxcI
         uSnifeaqcf2zIw8a2afleBtl5odYwaVw0JGT3mXKb1gycnOVsKmp+6BY+lzkNFbabj/v
         tjZnbhbvKOnlfjSLIlR3/8OHaOCcoRWxsRf97ZdyuWjmczDKBe4P/schL1vQIeTQu/5a
         jgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d49fctPOnNktvKVCBx7OGb1D/6V9QbzUvjRB/Aya3Fw=;
        b=B/8AqEynOzkV1/HLqCupaUhZWX8ICOz/beHq2pIjkoprbI8cvBm5NrokUDFyAyNrbd
         ffPfSn+EMyM2//4wpP2DonMWoAUALxhcZKLf1sXKtaWZBRLwomIKTalFDkYdnlP6QhbX
         nA+BToisp/RAOhDVI77XvcNSz3QAbTyPsMDRY9QmMPxX9HwXlkKVihZBeGr2cd1W3Mj1
         7mZL9T/M1lK01R7n22mJEYxex5//IAdnY+I+w2tZHvfvvkjFQAO5xxcaM8+IOmFh1/I/
         O/lMfTJH0BnEW1yHz7WMlxoUbq4qtjf6OX61ElLaCypQytq9NNLritaHimLMLy0nIo9V
         J4YQ==
X-Gm-Message-State: AOAM532CbfsSruDvBKc5uhX3f5TPhJGePciIUjxr8HPvW6WVS5PA2fjw
        TZzkzviTByWcBBSNcawf6NiwyKG28+qIpSmW1JMvtg==
X-Google-Smtp-Source: ABdhPJybKHdYHmRyQa16ktDJn7QVX/FvRdS2SEfwOdzNGN2/MtD/TuqwrXOkX860CkHRcOXu0yhkJCcseg9KtKhvNcU=
X-Received: by 2002:a25:a12a:0:b0:644:e94e:5844 with SMTP id
 z39-20020a25a12a000000b00644e94e5844mr3135788ybh.492.1650237095312; Sun, 17
 Apr 2022 16:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220226184028.111566-1-bhupesh.sharma@linaro.org> <20220226184028.111566-3-bhupesh.sharma@linaro.org>
In-Reply-To: <20220226184028.111566-3-bhupesh.sharma@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Apr 2022 01:11:24 +0200
Message-ID: <CACRpkdY3KXJ3=ib2MCM6P6c+0GCO0DKvgcb6-Fzdrg61THR2-w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] pinctrl: qcom: sm8150: Specify PDC map
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, maz@kernel.org,
        quic_mkshah@quicinc.com, linux-gpio@vger.kernel.org,
        robh+dt@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 7:40 PM Bhupesh Sharma
<bhupesh.sharma@linaro.org> wrote:

> Specify the PDC mapping for SM8150, so that gpio interrupts are
> properly mapped to the wakeup IRQs of the PDC.
>
> Cc: Maulik Shah <quic_mkshah@quicinc.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Patch applied!

Yours,
Linus Walleij
