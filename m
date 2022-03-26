Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31544E846A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 22:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbiCZVbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 17:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiCZVbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 17:31:40 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101FC15FCC;
        Sat, 26 Mar 2022 14:30:03 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id h1so12927695edj.1;
        Sat, 26 Mar 2022 14:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7H//OQ3peeZo6cFkBAqd2bvidUOeWSddr0qVAjJHEkk=;
        b=ToKx5GFSWbdebqWwDP5bXXXoseEHeeq+9zfq1GCuStROox2Wq1AXIH7Vpbc31ZtVlW
         1hTI1gSW2PCcMVFwUkW12Vi89+YE0gFQ0Sxk6FooqIkC3gDu2Qc64v6jltJaUDRJ2zs1
         BLD7pw1DN+Og6ClNX1low0b1vP/rOHGnA9xo5S7ie9oPUETvqRVictrWqIfxZ+EA3RCV
         VP9jzqGQSwOBevMTU0oZMfPj4DEtpaYrSTZSptgWAEgG+7i2hHuMC0yXDwwq/N+shnKU
         8aCRsa0iz9JW/9BcBVUhUjWlhwu4M5zBG/NSVj1Tts+ZYjgdUiN3qNpFo0Zk444j5bIl
         tatw==
X-Gm-Message-State: AOAM530jjYx8xC8PJ3gHB+EC9+0hFM3U8+f/CnyDzMTqa34lFWTIkAJk
        7gzEUDy0L81Y1Aujrxot5GE=
X-Google-Smtp-Source: ABdhPJwdup7W+e8oCpUfyH1DfPFRegqIKYsj2TkC1DZLAN5hn9CCubKrNb7IkbBYOsLudYhnXw3P3Q==
X-Received: by 2002:aa7:d58e:0:b0:419:c121:ea33 with SMTP id r14-20020aa7d58e000000b00419c121ea33mr5846197edq.256.1648330201522;
        Sat, 26 Mar 2022 14:30:01 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id pk9-20020a170906d7a900b006e05b7ce40csm3864675ejb.221.2022.03.26.14.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 14:30:00 -0700 (PDT)
Message-ID: <a6d8ab4e-c863-1dce-249b-e3971cdaf930@kernel.org>
Date:   Sat, 26 Mar 2022 22:29:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/2] dt-bindings: clock: convert
 rockchip,rk3288-cru.txt to YAML
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220326120942.24008-1-jbx6244@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220326120942.24008-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2022 13:09, Johan Jonker wrote:
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
>  .../bindings/clock/rockchip,rk3288-cru.txt    | 67 ---------------
>  .../bindings/clock/rockchip,rk3288-cru.yaml   | 83 +++++++++++++++++++
>  2 files changed, 83 insertions(+), 67 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3288-cru.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
