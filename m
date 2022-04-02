Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5563D4F051A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 18:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358584AbiDBRB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 13:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358575AbiDBRBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 13:01:23 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6D91FA
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 09:59:30 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x34so6351128ede.8
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 09:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mn05wTy/NlZVsNgz6hNdV0Fxw7lJ50c59f6ciYye0FQ=;
        b=fq3SOd6MFtCnhKuLIK+XqlH/P+ltpB9Wgb2pGbPmcDnYS5rZkpXTwRVdNS9sG/WvUA
         a6jXfIbjBmddM7WxPEq54uXmuYuxnbTQAd8Do+KoU+zKRcK1la0JCeHW2Qfo+i1sfsmF
         twivpRIFYeInj73kTMZqga/jEH9wttpctNbWY/aZ+THJec1cB8oioDbGF5GhU8QEVeU+
         coJjJezqBCtpcznrhMSyJab2KfUjB2kamgercpvZTiJ39orM0+48gS9RoPecmgnaQhTK
         UUtrGruEiamfa+MkxcR8171Sgamf/qEfibR+Hj0WhcnfDZxsL1HwPoFmnv8/quPsGlJW
         7zVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mn05wTy/NlZVsNgz6hNdV0Fxw7lJ50c59f6ciYye0FQ=;
        b=Y/scWDT28TwzdRBNtxw5GQBW0RdKp+xlFKAnLE0yfWYCQidr5888m4TXThjmSLrMso
         FzzLOiG9TXIACsNAFXp//vV68OR9tUD+bC2vcOF4dh/5kTR0FvYlHxKB7HNi51+oFjCq
         JIQxNH27VAPsfXyYx/DrWk5fix4o0UOtXUXjEgrHBkJlBSNFVt7FnT088sl2eQix8W5w
         Rz9zH2VPFgjlstBuu3ANy6k9WEj3IuYPHsse1wLPys/BgkMy3ul5YGK2Ag3rK5Vp12Jq
         UB1tk1xl7QfGoAXdNvmk1vxCxXOccd37ePoCcMzxQbL2RvK+GeTS7QaNzZNltUW30G96
         bBDw==
X-Gm-Message-State: AOAM530GYY2oF0lg9+71lBO7u5azWqlrhCjrjMVbqYzFEd4HI+E82mV+
        PyCJGYPMxO+h3A3H0g8Iemi/rQ==
X-Google-Smtp-Source: ABdhPJwoAd+Eq+1ILPRp3HMI7n442Wkx1NQELFVkIpWw5zi4uUY7WVW3nNEmMZDKhp+1fvQw2oFcEw==
X-Received: by 2002:aa7:d398:0:b0:419:d011:fe8b with SMTP id x24-20020aa7d398000000b00419d011fe8bmr26354361edq.168.1648918769576;
        Sat, 02 Apr 2022 09:59:29 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id u25-20020a170906b11900b006e08588afedsm2255299ejy.132.2022.04.02.09.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 09:59:29 -0700 (PDT)
Message-ID: <969094a6-097f-1cf4-64fb-c0ae7d3d2173@linaro.org>
Date:   Sat, 2 Apr 2022 18:59:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 00/16] Convert Rockchip clk
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de,
        zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220402143636.15222-1-jbx6244@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220402143636.15222-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2022 16:36, Johan Jonker wrote:
> Combined serie of previously converted Rockchip clk bindings.
> 
> Changed V4:
>   combine dts patches
>   add more clocks

Why adding more clocks? The discussion whether to do it did not finish.

You merged all your patches into one series, but this makes impossible
to compare them with your previous submission:

  b4 diff ...
  Analyzing 20 messages in the thread

  ERROR: Could not auto-find previous revision

         Run "b4 am -T" manually, then "b4 diff -m mbx1 mbx2"


Please provide links to previous versions on lore, so we can check what
changed.

Best regards,
Krzysztof
