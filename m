Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30B75A08AC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiHYGNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiHYGNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:13:14 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF6C9F750
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:13:13 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id z20so18448447ljq.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=wXqYQNt6cQwwovEWaPctQuIwu12r6o/ryFEQHXvmidw=;
        b=Z8V/D1iHr+3qt3pSFcQ5ZOeH0iO4G/pHn+XoNotaIYjxtt+oIh0RJD9YL3fzn6NmF2
         keRguEOY+JCT3rPJ4clH8kP1+xBJEQvelpo2RA91EyugRKUr7jACpJxh49EkA75pYy+R
         4u1FzXdV5fEX3vnN7Uuu1Tcxfrs4J3riE0OLKIGGS8Wuio93l6VtWFG3NUMbWDRZ2XIj
         m3cArYVlka9n7JbWg2A0+Pbrvx+Afr3ku+XlfM8+eqZ6HURCFjdxteLrXE0IuPmQJzai
         lUJDfZtzcC0W0+lYdbZeAgdnRKGwUbTbD/6hq31m3HOs5yzAyK5n0yqIel30J6Tw8bSs
         OHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=wXqYQNt6cQwwovEWaPctQuIwu12r6o/ryFEQHXvmidw=;
        b=xchVJ5d14f/dmHoZquuIcFdAoWtvyLDbSr6Wcp6pAn8wvjzkO1ek2p7jlknNhyJOOX
         om+AU5gv+88nd5Rg58jeWs0vszHH6r1GMMy0i+RKSEv1/YRAkY1AS9WQp2yitkz+BEih
         LEFf5AaH154q0LHcqhHG1RZ9NiY/OaAQ/Y0RIXh8NEil5Ib/2IK//x8YO0B6Wqj2OZoR
         TW+v88uEQkEbksDmA/92VD57aLRYVt+6i4rviVyf4Jdljk46cyBBw4IRb8pYtQitqN7g
         ydq9SwEJ8O0lvQ6Bxfq2CE1zM3cHDAnirkkbctWuRkgH1coeM1rJMDGahRmHe4wXEoge
         Mmiw==
X-Gm-Message-State: ACgBeo393v/YTvcuyfK3aYOD2Vg35O6hi4YbzFgIltZNaOjJuMrAgxQ5
        o/sv5zErLuu/uo6F4LAJutxQN34si6nLq1n4Yas=
X-Google-Smtp-Source: AA6agR4m4Z9GwEQ+k4jSc0Z8Nk2/b5GFxRJY/8LmssR1LVZFSvwsKEH0v/tzq4so1SvajWcwWWcQxw==
X-Received: by 2002:a2e:9913:0:b0:261:ccfa:da6d with SMTP id v19-20020a2e9913000000b00261ccfada6dmr580559lji.269.1661407991448;
        Wed, 24 Aug 2022 23:13:11 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id p3-20020ac24ec3000000b00492b494c4e8sm301859lfr.298.2022.08.24.23.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 23:13:10 -0700 (PDT)
Message-ID: <9f293197-b4f9-c53c-ead4-08e2113d9c8d@linaro.org>
Date:   Thu, 25 Aug 2022 09:13:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: mfd: Add missing
 (unevaluated|additional)Properties on child nodes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Robert Jones <rjones@gateworks.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Ripard <mripard@kernel.org>,
        - <patches@opensource.cirrus.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Chris Zhong <zyw@rock-chips.com>,
        Zhang Qing <zhangqing@rock-chips.com>,
        Alistair Francis <alistair@alistair23.me>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Renner Berthing <kernel@esmil.dk>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20220823145649.3118479-4-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220823145649.3118479-4-robh@kernel.org>
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

On 23/08/2022 17:56, Rob Herring wrote:
> In order to ensure only documented properties are present, node schemas
> must have unevaluatedProperties or additionalProperties set to false
> (typically).
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
