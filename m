Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E5D5A5B74
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 08:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiH3GHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 02:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiH3GHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 02:07:21 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31BC6D555
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 23:07:19 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id k22so10221967ljg.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 23:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=MgD+CcrxhUAa/0fFJT7FHzXyl73Gya7dSzTsUuvpwgg=;
        b=DdhNonNX7+lkBJlpWoa2tHbq3Qp1L5LDqggwjPJZtBvj1lq4SVGkXJetqwzCrt4IXW
         TgU4BS2gG5SGF36eD4F6PsT/Eg92NjsKxLbrYM2EUK/w6kUTt7VFXFpBNn8zOC/gniif
         BwtrFAul9rZxGx3vHb7s5G6Kv2b/E0v64MjssUnQTggE13xVEaSQuar5EYiugj2UOu2c
         p5VXC423rXg08XZW/l2kfjXa0xJpYQedsvdT+vVJR6KxYasPAwzubefWZBFDvXYrIDJm
         8AcFQkSW/QMoeJlCE+1uPL9GQ4GfL6d5mKzzkGwrUqbbQTNLG2kFFxy59R3ZUDuECFMs
         qzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=MgD+CcrxhUAa/0fFJT7FHzXyl73Gya7dSzTsUuvpwgg=;
        b=HqoeUVPgkSGOKsQGGAkchXPWt1GQjTOFXRfJiZZe6VpJtoglKO81tocuSx6CbTI+K+
         UF5JlXwQ0nLHHTdIZb9G9p4CrU99N+rrsKeryRluyuq4uHcSfG2q8g2bdSJjRWEoZ3qj
         4oECNJq3xU9toO4rpKC9k+srTalQJzKio0mOm7FPrwmUFkxhrp97xLOrpxXBnAE3qkFR
         TFepefOxRGJryP6G7c/jyv7jvTAHXf945UbDe6UTxAl/Tzv8OSGTJEIlCAW96oUZFz3f
         lqqQkFCEtqem8K4ApogpLGTg1yxC6dLQKzP9l5bI9llpYpE0JTGVxTWPZKABzCZIqFjK
         Qq3A==
X-Gm-Message-State: ACgBeo0IpQ8WscF/aqmgO10RPrdr1TKZ6P4Hza6tPafgzjpVAxuX71U2
        Ddl19kzNUEAzcbQLw4dSOs8Wfw==
X-Google-Smtp-Source: AA6agR4bKO+Dg0ABTJUMiyCj/HX5Y9+Ke296P1duIudFy6ybDCEw1afkH7SvnMLDxUglKPxRC0tvjA==
X-Received: by 2002:a05:651c:179c:b0:261:8fbe:b729 with SMTP id bn28-20020a05651c179c00b002618fbeb729mr6578852ljb.114.1661839638346;
        Mon, 29 Aug 2022 23:07:18 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id p4-20020a2e8044000000b00261e2aab7c2sm1618414ljg.58.2022.08.29.23.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 23:07:17 -0700 (PDT)
Message-ID: <863ed3bb-1ac2-db24-488b-7f4a93da6723@linaro.org>
Date:   Tue, 30 Aug 2022 09:07:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: Add sc7180-pazquel360
Content-Language: en-US
To:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220830025438.v2.1.Ic4d4e0777115011544dbc2ab07ed4d7b408c003a@changeid>
 <20220830025438.v2.2.I3f443f24e7c3ae2a40804fa1c9007a92330d5e2a@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220830025438.v2.2.I3f443f24e7c3ae2a40804fa1c9007a92330d5e2a@changeid>
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

On 30/08/2022 05:55, Yunlong Jia wrote:
> Create first version device tree for pazquel360
> pazquel360 is convertible and the pazquel it is based on is clamshell.
> sku 20 for lte & wifi
> sku 21 for wifi only
> sku 22 for lte w/o esim & wifi
> 
> Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
> ---
> 
> Changes in v2:
> - Remove the touchscreen setting, as a follow-up patch
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

I never gave you an ack here. Don't add tags which you did not receive.
That's also not a proper place for this. Please read very thoroughly
before sending:
https://elixir.bootlin.com/linux/v5.19-rc5/source/Documentation/process/submitting-patches.rst

Best regards,
Krzysztof
