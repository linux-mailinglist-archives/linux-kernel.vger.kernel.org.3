Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CD64EAC83
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbiC2Lnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbiC2Lnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:43:46 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9733B972D6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 04:42:03 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i131-20020a1c3b89000000b0038ce25c870dso1086864wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 04:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fn3HErbG840xG/1DKf1d2N6ycfhrWzL++y+Zz1CDgxE=;
        b=A6EragmFzz3EYNnm8I82VYWua3eXUT9qcZVuJQFeiLO+cc5t2h+KlWVF9LPy7eCWF/
         D6KG0X5veZP48rwSL5Zra3r8CFZW53W0HFFO6XYwfGwUE3eAPS1hzsbYblKMjxt0eWfE
         8aYJxfqvdaA1M6ozoBLp8gODm8f0nKwNnq1fZLyLr8LkymQ2r43oOyKlL+aXqwDVYfPZ
         wmyVWybFtiZ9AuIkXlGA+pGgrIp2nwwHJdwBT7By+EuQqY2GBW/l+lv6ToYTOlCib84k
         cncfkrPcCRDtNjt7YA3+4+wAopwNJPY/giu2SF/OqLxsyMQUbSUaR4TdnQGBgGjjHBec
         h5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fn3HErbG840xG/1DKf1d2N6ycfhrWzL++y+Zz1CDgxE=;
        b=g1NkF9zvoHNT11VEDo7/4RoL1K6mwKhMqu7dOUuXgKJa4NSMOIWZjyWcjL11IPwQB+
         VJiU5CNSIgiIKdzwHWdP02bW8K9wKH6m7s70D93Hvaw96QagMZT656cf7+sHPO7wFrLW
         8QjODDlg3jZip0E/peGVlD9w05o8EmwSJmsD7PiVn7nfxE5JQWWtUQObKGaSnjsSpqCb
         Oa5eGQVaKn8C+kvnQ7SIJtAhmSgp7qO4SYLBCRpJICLlBqFCM8H6v2vqq793afMy54gA
         yHKR59IhDYgWezyQzwdWLeA8mDokkkMrjxeNUS53NURIjhkPLgle0sC1hty6/aA8KJCb
         RRCw==
X-Gm-Message-State: AOAM533BwLajB6xOcxI7xDY2y1hOW5rXZttPun44qS0oKN2K1bl/PHLr
        9GlrAjyj0KS/VvYZW9Thy4y/0w==
X-Google-Smtp-Source: ABdhPJzOwx9Bn0AwRaBTztslHHWpRbx/LvUGOgOn/gOyid0v0Tw2biM6UgFrN4vigQJNapEEpwX+rQ==
X-Received: by 2002:a05:600c:1d0f:b0:38c:8ff8:e703 with SMTP id l15-20020a05600c1d0f00b0038c8ff8e703mr6339433wms.202.1648554122148;
        Tue, 29 Mar 2022 04:42:02 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d47ce000000b00203e0a21c16sm17397744wrc.3.2022.03.29.04.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 04:42:01 -0700 (PDT)
Message-ID: <9e1aed7c-a702-2ee7-f3f7-f2f3e2b17e29@linaro.org>
Date:   Tue, 29 Mar 2022 13:42:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: convert rockchip,
 rk3288-cru.txt to YAML
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de,
        zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220329113657.4567-1-jbx6244@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220329113657.4567-1-jbx6244@gmail.com>
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

On 29/03/2022 13:36, Johan Jonker wrote:
> Current dts files with RK3288 'cru' nodes are manually verified.
> In order to automate this process rockchip,rk3288-cru.txt has to be
> converted to YAML.
> 
> Changed:
>   Add properties to fix notifications by clocks.yaml for example:
>     clocks
>     clock-names
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---

You missed my review tag. The changes between v1 and v2 were minor, so
please always include it in your next versions or resends.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
