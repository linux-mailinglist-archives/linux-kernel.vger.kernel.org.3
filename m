Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A779B5A0FD5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240513AbiHYMCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239703AbiHYMCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:02:38 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C038E4CF
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:02:36 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id s8so1733461ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=o6731Xg3uO5AI5x1e5LBWQaIC7OQDL55NoHUUcojApI=;
        b=P/0dLvrSbYllUSKNvLcVaTp/7rEj9xNoOXS9wBI5Pz3SHQCDQECfMJpzwQA2h8/QX8
         rndTmAuJxXOT4pF861scjFqx4+O9kfdK6sofBbQSun3MwD/bWYzOhUGqSI6by6n2Khpn
         HFT44xpkDWe+xGpDMu/Cx8/77trn3yIRZc06MTeaghRZXgzCaMM1RpwMkte53I+fwKYA
         XuJdMt2PPS0VN1lwevlr3f5eG88M7srNyMO9aZYVoRYLx7fYe2lBbF0cim+jK9hctwYB
         ZXuDcxJ1oCiJ5sxZFGvuXBoOPVnp5yMGYxgLJ4DEEeWusz3Z6pcFaA2dPatQS1Du19Xg
         NVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=o6731Xg3uO5AI5x1e5LBWQaIC7OQDL55NoHUUcojApI=;
        b=LlUosomiUyGmDZJ1oHxOaF9wA2Ri3U+7Ym5JBL+4tN3O/UJE9CxghdMQ2w2l7rKeiM
         XyBlwXbpgXU9tNZFT63AgzJ3gOJ6pEwwbQacQZVKqCj3AmSuxURuQMSZ6yBRm3EChzqj
         gV5+a23owi+u8hDX1Ebl/c+hLeJhqjSbuZ5HSnNM1lZucnEWnSF+SWHbeBxIU4Q/S+bE
         WorARuQZV6mOcstDCCvqeJVIjEKxWWmZ+lZsbw6LHIxDjqOlv7TmlLX/H0G0UhSg9iUH
         VtZ1YkjhGIM70PrlZgRdoKJy/DndHTX3CJvQMZO50UdW5da4lF9MG+cC2n0W+LBoGDA+
         oFtw==
X-Gm-Message-State: ACgBeo375MpU2nKkLVkihp82MssMpdkxI+Tv9bf0x6Up+CP6BnmNozFl
        MwPuk7Hyn5PNFZ4L69GcPl/dZA==
X-Google-Smtp-Source: AA6agR55GD5od73dv0g9JiBl5UZUqTJtQdGJesoeHaC6tznWWEUcvvev13E7N+dsDBjpXhVKDLAZxw==
X-Received: by 2002:a2e:9515:0:b0:261:b705:9909 with SMTP id f21-20020a2e9515000000b00261b7059909mr980260ljh.508.1661428954598;
        Thu, 25 Aug 2022 05:02:34 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id g9-20020a19ac09000000b0048aef1abb06sm471094lfc.69.2022.08.25.05.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 05:02:33 -0700 (PDT)
Message-ID: <debf4f0f-7d94-4fe3-c1a4-9e986e113c9d@linaro.org>
Date:   Thu, 25 Aug 2022 15:02:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] arm64: dts: meson-s4: include meson-s4-gpio.h
Content-Language: en-US
To:     Huqiang Qin <huqiang.qin@amlogic.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, narmstrong@baylibre.com,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220825115154.2150323-1-huqiang.qin@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220825115154.2150323-1-huqiang.qin@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2022 14:51, Huqiang Qin wrote:
> Add the included meson-s4-gpio.h in the meson-s4.dtsi
> 

Why? We can see what you did here, but commit msg should explain why you
do it...

Best regards,
Krzysztof
