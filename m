Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6B257A6EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbiGSTG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiGSTG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:06:57 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9CF459A6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:06:54 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id v15so14770246ljc.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9WfrLbUEqD/K/zLHgjn6G5Y0RngZ8vESJI2/UYnNV7E=;
        b=v1nwr78efPyraVZ2DwS98J0DltQ1UscXD7wMW7QjGELEOpHEK2NCuG0mZBWWFX6XBI
         RTfFG0xW0b55eYZd5RaHcxYL6Tu2itgBl9SUuJiwPZk3v6556XH/ghhWdtJ2FK+6c1+l
         yTGljbECEZ1ER5ZtGxxfxGXAvXApLNxmmMTMn5AZZQFwFDev0KBKhKVr61hDa1wsMX0d
         8Ziyxp7QX1YBs3hdUsufEaJpkJFxCVdk0dqkFyqNwwPcCMhbb88sKK+scOo6rNr+sh7e
         GMyy5crraDP321z7Wc7vF/GIM/rABhkOn6UNDBbhvtcul7xCNxQOWY2k5i0nFYSC4t+e
         9C8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9WfrLbUEqD/K/zLHgjn6G5Y0RngZ8vESJI2/UYnNV7E=;
        b=ohfzY6VrEjWNMXQohqqTTrdlHc3PPX1m1svYdI6LgfGQEwNxBQsvrCECzPk4v8TdEN
         UgWLHGSUcvfsw5kUJwRoiz1DJ+AFWnc1dFY1RCIasUSeKlhA7Dee52WAVZeZ/EEVgN0m
         IBY1GJdq2dl8pwxEyLNhAIZ/jPhK/Tc3LC7ef0HvvAbJU6NB9vTkOW4QuwHJ/zlMuOqC
         VQUGFwwH28gjXE9C7skVAWmWIuhYiX+DMwGEAX2jrJBUQJIr85w43rQ2VtGIMPl4sSNY
         QC/YsTc4s+zGl2H9mmRai9U1FmbWw+2Enq5s0qtWbzhscYTtjc9xqL1cK23J3g9Fh7dw
         eaRQ==
X-Gm-Message-State: AJIora9Vmh+ckamAQ425lBlsd/+QyRyR00/hYvaxu6pGB3i3RoQoRx57
        7zeWzseT5qHESMD9jqNCjUBRQw==
X-Google-Smtp-Source: AGRyM1tGeJGJh+uAPPtV8Qqf9ByBy718LdrQMLH9679mpCCFVMLEV0hpolvAWrhAUuU2b39gEfhXWw==
X-Received: by 2002:a05:651c:1a1f:b0:25d:af55:1a2b with SMTP id by31-20020a05651c1a1f00b0025daf551a2bmr7207399ljb.49.1658257612333;
        Tue, 19 Jul 2022 12:06:52 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id f5-20020a05651c03c500b0025a724f2935sm2827767ljp.137.2022.07.19.12.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 12:06:51 -0700 (PDT)
Message-ID: <af797d43-f1f8-6ef9-4570-5c048aac9733@linaro.org>
Date:   Tue, 19 Jul 2022 21:06:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v2] ARM: dts: Add TS-7553-V2 support
Content-Language: en-US
To:     kris@embeddedTS.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mark Featherston <mark@embeddedTS.com>
References: <20220713221233.8486-1-kris@embeddedTS.com>
 <55dccabb-41e9-dc45-f404-c333f5472e75@linaro.org>
 <1657833995.2979.1.camel@embeddedTS.com>
 <eb993f8d-e72f-aba3-e7a4-1bbd2ac00f6c@linaro.org>
 <1657907657.2829.1.camel@embeddedTS.com>
 <add23ad7-2539-cef3-8684-10ec8e680483@linaro.org>
 <1658252354.3157.1.camel@embeddedTS.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1658252354.3157.1.camel@embeddedTS.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 19:39, Kris Bahnsen wrote:
> 
> e.g. looking at commits of imx6ul-*
> "ARM: dts:" is used for a number of initial devicetree commits
> "ARM: dts: imx6ul: <board>:" is used a few times
> "ARM: dts: imx6ul-<board>:" is also used a few times
> 
> For initial commits of a devicetree, or modifications of a devicetree,
> what is the preferred pattern moving forward?

The last two, although also these appear:
ARM: dts: imx:
ARM: dts: fsl:
I don't have a clear answer which is the best, but the point is to have
proper subarch prefix.


Best regards,
Krzysztof
