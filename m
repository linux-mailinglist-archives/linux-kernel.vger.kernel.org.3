Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCAA54D023
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357457AbiFORis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357714AbiFORi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:38:28 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744494EF64
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:38:24 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y6so6418169pfr.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=22zeewW4sEoB0cO7GZq273RhVevaidC9oEMqtJPIOcA=;
        b=fyQcXiWihs3wW86AlQuSc7QncxlLbaWs5IpIy8umK9NqO7imfn3tecS0OwrIJt+jnW
         ISeLFzirGZzzu0JXe6rhU0k6ja7ten41+s8JZhWl+424fS3T4m0TXMYr593bAYjuVett
         wnI6VGxjxvsD633uShSsoPkoTiQ44r6lF91O/pRJcPTW+8plxysi0mIXGrBEGkHY8LtD
         58xK0WzvcYogkhntFkmGxpyf8wZGYk+sbGC9+iNoUUFdx4/GH/UuMwOoIFnuo2KZJt2J
         mICzAUeWwPe+uqJn3hslkXEIIWFPZvobcw0icDLLHimwIqcS/Ttjb8+7d4HRYXzjYP4L
         tcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=22zeewW4sEoB0cO7GZq273RhVevaidC9oEMqtJPIOcA=;
        b=2lg0WQw7cGOLUCdh55WX6lqdqbL74gcpE9+/QgmDan3DvOF/9VBwiLY9bNlcAFUqF2
         jRVuaeuzehmrUlv1d6bgBnc0ej+xFJMbsV4Hgr+Qk9JtwX84aWTtqZNzN4+C3ci9resE
         tYz2vUp72DmACxN2pyaFWpnagGpCGwFFm3RtYiYIHztjGbbvkpdkEJ7DoOSECDJm4mwg
         GojNZecpsn9VXPR0WsM2ERgOA38VLObljMkE2VRJT4rRRwLFKMpvSx/DbLiLmovuLev9
         VSwTgmZzVabhkQYGnLVwbL+meP9yx4HDs/D/J97UCCXHzwe/m2xFy1E+OGI9RYvu7OJm
         2Npw==
X-Gm-Message-State: AJIora9VXoDkCkPP5PVNcknCbTtTvdYCzztdiGLq08ACzN2EKFqL50mh
        9wd/7p6aXsOytj7wp26wDmvWWg==
X-Google-Smtp-Source: AGRyM1sk4JeSCSi7DyRhbPq9t77Fl+0Z+dJ4yTEMMJAqAJzHYMKAEQM5wXHqgC26Qj4UTAbQdg+gmA==
X-Received: by 2002:a63:86c3:0:b0:3fd:9c06:ee37 with SMTP id x186-20020a6386c3000000b003fd9c06ee37mr754736pgd.357.1655314703596;
        Wed, 15 Jun 2022 10:38:23 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id l7-20020a170903120700b001620eb3a2d6sm9637778plh.203.2022.06.15.10.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 10:38:23 -0700 (PDT)
Message-ID: <2b448c7d-d27a-ff9a-f00d-149a71880360@linaro.org>
Date:   Wed, 15 Jun 2022 10:38:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] dt-bindings: arm64: Add BCM6813 SoC
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     anand.gore@broadcom.com, f.fainelli@gmail.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        samyon.furman@broadcom.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        kursad.oney@broadcom.com, philippe.reynes@softathome.com,
        tomer.yacoby@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220610001534.14275-1-william.zhang@broadcom.com>
 <20220610001534.14275-2-william.zhang@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220610001534.14275-2-william.zhang@broadcom.com>
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

On 09/06/2022 17:15, William Zhang wrote:
> Add BCM6813 SoC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
