Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01325162D5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343895AbiEAIjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245759AbiEAIjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:39:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C5D23BF0
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 01:35:40 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z19so13510861edx.9
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 01:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aIqmgxixDtXOUkI/I5OewoiyRqWtHUTBMJ5v/u+HUuY=;
        b=JfwcoTIFy4WoSFgE2SGOD8GqCu56/D9Xav1uYHP/i6+3cT5qaBALWVkWxjXEFalLRc
         DVAUpr4gcmJE6SL/ZeC3QsbZbJw4cw7WWSTgIUbhG71BD90S35fcCeiDyDlBGfx42O9A
         V1OBeMPoUh5xAf3WYTgJHfj6lACSimHk+6j3y+qP9sqgYPXUE2MpVL74jpgQpn4IUuNJ
         T7PfAr245bcZwiYXPgDgG9rMS9ru5yV+e6pGHhoZAvZdq6j2cgxJCZauzvVp6DhaThPF
         oFNIQHjcpkYVdIrooY6KKLN/aGpjrbqVM7TDQSKRTUEIvybVtM1MRwdR6pW+oaqcouOD
         QObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aIqmgxixDtXOUkI/I5OewoiyRqWtHUTBMJ5v/u+HUuY=;
        b=wKs/36fCKNsN/wtoF+oT9VoTlrfdQxwKamuIfluNDsPIRu5nQPAyiaikzPVzO2py3l
         VAo2zoMFpmUXgM1SIix8xl6t4NMfMEgd7trb5fmxBk/ZW44iv3jk+AWd2XnDn2vLOe30
         BT6+T1vPVppGL37ka1oKjETLDo0caQ1Yqh5R8i2VAHdD0hPk7QcS8DQEV9wg/T79jN/T
         S/PmDDjR/2Fzx2h/VUbJ53m4hOUjiZfxY6n4LIyg8Pj0S4bwxmXmIqjdg5w6v+Ff/U/d
         D1jA6L4Z/1Hn4o4Wi3NkfZlzfL+tzat1EtiZhSOtDB0x9NLZt4iFVf+kzRPm0egFLvqr
         Yrkw==
X-Gm-Message-State: AOAM533AW74xKTjOAyIqHkyR1/cR0p0L6PwhtWhoz0ZAjOHCtl9bEq7z
        lbXOW1vhXOSVkZOFJZtBLFNuTw==
X-Google-Smtp-Source: ABdhPJylfwK0glNKSnIVlYLA4HhIhjbdV2qs4QLOfJ7O9bw3yVd5hG4s5oG3fU6A/OmM6DScT50VWA==
X-Received: by 2002:a05:6402:ea8:b0:41d:78ca:b929 with SMTP id h40-20020a0564020ea800b0041d78cab929mr7734320eda.289.1651394138628;
        Sun, 01 May 2022 01:35:38 -0700 (PDT)
Received: from [192.168.0.182] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gv8-20020a1709072bc800b006f3ef214e5csm2384774ejc.194.2022.05.01.01.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 01:35:38 -0700 (PDT)
Message-ID: <0b66148a-c65f-2acf-9751-ae931778ad45@linaro.org>
Date:   Sun, 1 May 2022 10:35:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] clk: hisilicon: add CRG driver Hi3521a SoC
Content-Language: en-US
To:     "Marty E. Plummer" <hanetzer@startmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220501051020.2432338-1-hanetzer@startmail.com>
 <20220501051020.2432338-2-hanetzer@startmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220501051020.2432338-2-hanetzer@startmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2022 07:10, Marty E. Plummer wrote:
> Add CRG driver for Hi3521A SoC. CRG (Clock and Reset Generator) module
> generates clock and reset signals used by other module blocks on SoC.
> 
>
(...)

> +		return;
> +
> +	hisi_clk_register_mux(hi3521a_sysctrl_mux_clks,
> +				ARRAY_SIZE(hi3521a_sysctrl_mux_clks),
> +				clk_data);
> +}
> +CLK_OF_DECLARE(hi3521a_sysctrl, "hisilicon,hi3521a-sysctrl", hi3521a_sysctrl_init);
Missing bindings.

Best regards,
Krzysztof
