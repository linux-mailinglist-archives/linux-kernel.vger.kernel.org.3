Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAAA542D1E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiFHKUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237278AbiFHKT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:19:27 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD5947061
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 03:07:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id h23so29372147ejj.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 03:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uwozKY9IoRm2unnovWBUEXcVhf9p+HCIyh3s3hKT5vQ=;
        b=n0VfOVvrrkIOalvK8xRLNFd+esu27i0xirYjW+RFkVQgVZkWh64Mdjk79XeqZN+QCx
         JnHT3RcjJr3UaQPb6LgQ3RZk0rjuRV+faz3KnWChGXk6G9EUxkgeHDb4Qw/tf6LSNq9D
         SuVcBOGqn5ZgSCpdMmNVyJYTALMQvU2itIy+wujWAr/Y1hMKkg0xg7Pbx5JqzNFJeSvI
         oa09wBRQbWLCuTNSxXg2tg7FWkoZbnRc+p7wdumlA7HhZoXgPHvTTljGVEneASCRNrkm
         F1HUPHlWw9SHP9ATOsCLyR7lcAVMk6kMkLkIJwROq3UooMafbV6X7xialLi4KFOLeo8e
         kTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uwozKY9IoRm2unnovWBUEXcVhf9p+HCIyh3s3hKT5vQ=;
        b=4wmwfF1o4hqMPkOVomz9T+tjKkUZZ/9kUbpQ5qfuek2z69jNiU+dbj4Eq5NypDzeJa
         2J2Yl9R5uyt2FWf1/ot90WvjfYEpH6fmU7Rb3Qj7cRN8it9katfHtsxVKwPMU+JEqVbD
         p/5LYgbSWiW/eE6yth8UPyrQeeSvJDLhE71RgbXlQpoH380weKQ3JUpxMSLNLlx8kRCT
         hLm0iy1oHx4hY2PipdkOCDu/i94OD3TmIYj26i0XSUp6rCFOAqs3gj1S2ZcXieotLyIy
         /PzWgZSq6kJN6IemWvGkevaORHc5joddM5fMVZ/uxzDR8nGz8AGekkFjwzftLNFIWiMF
         rVSQ==
X-Gm-Message-State: AOAM533UhzgcYCzW8cJw+WoCGywhAhgwH1Y2WCjn5ZgiaTC92g1NB76l
        BBCftrNRjNwoHSWXm027J2cblA==
X-Google-Smtp-Source: ABdhPJzDQJRXBOzErKRVkLtw792RnQ9hYbK6BqKk+RLDWlTglkhS2dUR49w+HXT/bwY07t0Tq6uriw==
X-Received: by 2002:a17:906:9f1c:b0:711:cdda:a01f with SMTP id fy28-20020a1709069f1c00b00711cddaa01fmr14516948ejc.372.1654682827093;
        Wed, 08 Jun 2022 03:07:07 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ay25-20020a056402203900b0042cf43e1937sm12020228edb.75.2022.06.08.03.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 03:07:06 -0700 (PDT)
Message-ID: <3aa70c91-d6d7-e2eb-9c45-a1fb0a5751ca@linaro.org>
Date:   Wed, 8 Jun 2022 12:07:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 10/20] ARM: dts: nuvoton: add reset syscon property
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220608095623.22327-1-tmaimon77@gmail.com>
 <20220608095623.22327-11-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220608095623.22327-11-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2022 11:56, Tomer Maimon wrote:
> Add nuvoton,sysgcr syscon property to the reset
> node to handle the general control registers.

Wrong wrapping.

Best regards,
Krzysztof
