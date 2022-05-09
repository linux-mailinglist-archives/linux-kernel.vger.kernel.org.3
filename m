Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A6351F941
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiEIKEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbiEIKCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:02:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C6324582
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 02:58:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e2so18647775wrh.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 02:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CfEfoqqGw0bRo/d0JE18iMI3rq6uvAH9Rco6ztKOqJQ=;
        b=SLcE8bfXln12KpyuHYQ4vSM15JktJvGl7uefrlKr0R/PeZwkyZsSXyFEesIOKMtw1L
         GhAhKFJ0DFYEE5deH/oDW2vQziS260IZ3ZF4+/ZPM/ikFrj/vjr2+t3nE5iZnAkklN25
         GJGBj1HL58JjAd3Z0r+fzG10TNMJ0DMBTi+UVDtXHZJhP556AwPJrkTdO9ecvOFgG7rI
         bObmIIQBOk77zJG61XQ6BU7mMmRGV28GhfanBpiXneXOAfcbO1OY75yyFvZwBP3zc6cS
         MqOVnG2lMHGE/TbKXw8C4nZTOfH/AMjiOCJgqnfCm0ht8DbXqE6mHTQgBi0jSLz7HhjH
         Znfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CfEfoqqGw0bRo/d0JE18iMI3rq6uvAH9Rco6ztKOqJQ=;
        b=SrdjRvOaDJIoulZV2seDoaTKjRzocLGJLoUjelt/vtKEjrhUapc0zUJjRiwJrxOC5j
         76oeXC962aQsMh0oljMgGWM4LW0ln/yuiRzNa+L+wdGLkKjftLBLGZ/KKhweAy4ogvAS
         qEKBUTVeGbQGacN+6R5mMIqmLGWmt8LHRsVCYycRO+aSUmagh3kUB5k1DqpaXnLyuNT4
         k4gbPtsOmeYrV2iTcokAjc08fVl6kcNaMz7xqKfgM+bRu18cI7KwloGcHzeqbkZkEVWI
         HIsW4x4kMlc3Kfa9LmTLOI5mWVpkiLp5Odag+HehKNLlQ05fwOKIpclTGYDOwVOQXjHu
         pPHQ==
X-Gm-Message-State: AOAM533RIjlWdFHSr85A/cu7NXvtSpcvLhDVdOT1lyhxXxOBHWcI9yNP
        NvqrCC8pXAjnlm+MHweGvr5X7g==
X-Google-Smtp-Source: ABdhPJxo+q1AWwUB+WWX9EPUzbc1C2kjMDi9FChPm/ftNxZyQYG94sMpR3NyHog4N3J0Jj47dl4hVg==
X-Received: by 2002:adf:ea12:0:b0:20a:e14b:2710 with SMTP id q18-20020adfea12000000b0020ae14b2710mr13088740wrm.81.1652090308052;
        Mon, 09 May 2022 02:58:28 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id n7-20020a05600c500700b003942a244ee1sm11929974wmr.38.2022.05.09.02.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 02:58:27 -0700 (PDT)
Message-ID: <b66cd446-d0d0-4e93-030f-a361eb7a978c@linaro.org>
Date:   Mon, 9 May 2022 11:58:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] thermal: thermal_of: fix typo on __thermal_bind_params
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>, amitk@kernel.org,
        rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220426064113.3787826-1-clabbe@baylibre.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220426064113.3787826-1-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2022 08:41, Corentin Labbe wrote:
> Add a missing s to __thermal_bind_param kernel doc comment.
> This fixes the following sparse warnings:
> drivers/thermal/thermal_of.c:50: warning: expecting prototype for struct __thermal_bind_param. Prototype was for struct __thermal_bind_params instead
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
