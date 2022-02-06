Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258554AAF0D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 12:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbiBFLw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 06:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbiBFLu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 06:50:59 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F9CC06173B;
        Sun,  6 Feb 2022 03:50:56 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id u6so21567960lfm.10;
        Sun, 06 Feb 2022 03:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ddvwfI/0puG+LxDMpBDC1FpAIohJD35ROlNV6EzMLcw=;
        b=LP4NeybH5iWWwW8jEAM6tfywfIVLSFdjGxB4CL9Bg93laThKtMBfQ0rNAdY7z6kC5X
         1f0vCb7qyEcQHMwkdZgaqW03dp+oqCa3KRVvDd8yculv/L2M5PW79oUlgGo5CwdWVZhI
         DzCowKepLwPsYT9HBHGRcqPkGZARFd19MrlHrDxGwzDmnBIwGPDVA9UeibeGZX7Y9z89
         yt+Dt6bfcgWWpA46CkdEGEL35hPHZvbP4uswyVIh/rmSvrBrwHnZFw8SVMfu/EvwT46/
         2aX8TXLusGcQFI/0VTEAnzRtW2GZwPO0Yx+OTmP2ZZmqTgsaa0foW1zEbTxMpPLipxLc
         ioRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ddvwfI/0puG+LxDMpBDC1FpAIohJD35ROlNV6EzMLcw=;
        b=hg7pB5DYCturZSKk8QQuXqolxcdGkxEpOalz2cn//ZGRnmb8NlV10DbhCUOLbrgP/d
         qEs6JcXxQm+B8DLfdwC0GpvoCYbPliWP8nYIdx5xafPakkpTO7w0LlMEQWWVORjDDbWo
         ffT22+Atg/OEey0trzrEjIUw2ufTE5mORWgL6vDSKA7ZVNl1A0mdsY8xe0CURDDgqSr/
         VUlwp7/wtYV7qZhc1kyTNaXabGb8ZFD+4McU7o0EAHn/VBg9t/G9fMhoQWe4er+tmqTc
         TtQu2eeg6C8ywRAHrpgqyZRTseTzZfG3G9c2oJdoBKSXNW3Gw2GAlYFbZ7N+ZX643Dli
         +kqQ==
X-Gm-Message-State: AOAM532bUFiXqUjkdiXufD9MJaONb0WMkdqLA8hnXXLzS7Gs0J4yrlEH
        mzU6YE0yEkRs7ZCxDbhzLLM=
X-Google-Smtp-Source: ABdhPJy5xP8xtD/0txgbkVzOr/KXkFDGbfL1w+r2NPk7p7JvqsZySG8wmluJjO7SnHGVsYhQtPjeNQ==
X-Received: by 2002:a05:6512:3256:: with SMTP id c22mr5005130lfr.574.1644148255218;
        Sun, 06 Feb 2022 03:50:55 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id z20sm1168392ljn.92.2022.02.06.03.50.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 03:50:54 -0800 (PST)
Message-ID: <30a9395f-cf49-6f51-fb0c-8162b5a42bf7@gmail.com>
Date:   Sun, 6 Feb 2022 14:50:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/5] dt-bindings: memory: lpddr3-timings: convert to
 dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220205120043.8337-1-krzysztof.kozlowski@canonical.com>
 <20220205120043.8337-5-krzysztof.kozlowski@canonical.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220205120043.8337-5-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

05.02.2022 15:00, Krzysztof Kozlowski пишет:
> Convert the LPDDR3 memory timings bindings to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../ddr/jedec,lpddr3-timings.yaml             | 153 ++++++++++++++++++
>  .../memory-controllers/ddr/jedec,lpddr3.yaml  |   5 +-
>  .../memory-controllers/ddr/lpddr3-timings.txt |  58 -------
>  3 files changed, 155 insertions(+), 61 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3-timings.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/lpddr3-timings.txt

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
