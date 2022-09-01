Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF505A9165
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiIAH6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbiIAH60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:58:26 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B16110DAC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:58:24 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id y10so13887038ljq.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 00:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=/RjCPmDOfNfv/A2l7hq11fpbpsdvqY762PVO7MBZqtU=;
        b=bszRMH1TT25QjXwTM5jvz/8cu8MeWt0Ghdn0UXO079BLlnm/n8JQiI4R+SJ4dzr7nH
         5mEAiJg96YlB3PvPxBmCyYhtWuyCjkv2vwJoPVL9YIvd7UU8zAK4jpnpmyxb172JjRLP
         xFBfgIpFt/em5rbQrqw9R8rvW4rPB1VqcXdJflBaumnKXiPms6r2Ez8ZFKZfeLILv9N0
         uN7BSZ/WFpbWPwSX4B6YvBn2N+oafLUj+1M9UBndUTtK3jIwSCbjA5UxVh97BTh1lth5
         SjAoqhqzvZYz16nuGhvWiaTzCd84Vvv6jgm7b3tu8iZBTKUFmsLQgKqPdPEtDGGqAT+E
         Y5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=/RjCPmDOfNfv/A2l7hq11fpbpsdvqY762PVO7MBZqtU=;
        b=kTogb+vlnMSxCZvBwDt/G7Zgm8HDgQyv4kUvOn79lT+qLGskTOkofkEq7fGL0Nv1Gc
         S3UsVKCriGNI4CoCQh+e2k3S4BkxU7IAGEiYFuInf2ozemHiDLwQ4dxtmTA+vSkLvGjn
         3EdRN20pyJYovqIORutgQRlFyh29lxI+bYWHi1Eq6yPgapLrPIvBaxmRbemt0zWsEYqO
         GeifpDjguEVZEbADiYA5EvyHqAx05AXPX026FS2HGZl2/yF3YNwH2l/QombzOVWVgKk1
         Szm2XNs4ZYZBX12zfs5q0sFwt9G1ikvwWiOX8/ysmiChFNR6biNytMovoUr+HsNdKvJg
         ihyg==
X-Gm-Message-State: ACgBeo2hslwaTmanwF9PGKrLv41Zyg67i1Li6yvewJIDXHALuCCwIchH
        otGsAGdmLi3wD8uPLZsNRf7xow==
X-Google-Smtp-Source: AA6agR77i2lH7h6SAd6Yx0FPM1Fu7uQdX0zOfkJ2D2cKG1K3q7c8GirrdrNpOca7kkzWv9xIhBlIMw==
X-Received: by 2002:a05:651c:154b:b0:268:95fa:7f7a with SMTP id y11-20020a05651c154b00b0026895fa7f7amr1804824ljp.237.1662019102724;
        Thu, 01 Sep 2022 00:58:22 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id w21-20020a0565120b1500b0048af9d2d119sm2246002lfu.130.2022.09.01.00.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 00:58:22 -0700 (PDT)
Message-ID: <fb459831-e906-e59e-823b-4df72a76e823@linaro.org>
Date:   Thu, 1 Sep 2022 10:58:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/2] dt-bindings: arm: qcom: document sc7280 and evoker
 board
Content-Language: en-US
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     mka@chromium.org, dianders@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220901061336.61386-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20220901141304.2.Ief93544cd0cbfa412092f5de92de10d59a2a5b3a@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220901141304.2.Ief93544cd0cbfa412092f5de92de10d59a2a5b3a@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2022 09:13, Sheng-Liang Pan wrote:
> This adds Chromebook Evoker to the yaml.
> 
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
> ---

I think I saw this patch, but this is still v1?

Where is the changelog and numbering?

Before any posting please read carefully:
https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst

This is another set of poor submissions from Google Partners :(

Best regards,
Krzysztof
