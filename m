Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A798C57FF07
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbiGYMdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiGYMdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:33:39 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764E919C3A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:33:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so9306984wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Snu3PItGpsnDryYdrFCgAzev9r8IwiBet2EbwHteIm0=;
        b=JLpYsCH0lGE0AEZrC+cHV3wqv/ugpGpXj9KLd6ubILRnZElRgR00Wsev2x081uKOkM
         UHTD4DXZO29WunxF+xCfa4ScVzhY3Ybk/X/1C7NYnf2L4KeGTxbWkIWgawm7EabxEDuZ
         kKX7YG+LBqJa82sRaB5cJ3frF1GnZz15D+Y7jnPKMz/XzUCF5C3n7ytZ9J8TzlETjl4j
         Bvd30xz+XDi8Ry+OLEtRHzUCpuOk0J/uOc8F+lZhMJapA+hbbb0oIBiwrzqof1zHrLcy
         6QV7tUEGH4cTwqHXzqzz+mOJ02PQOeGw0TfDiQa5QFtpB1ZwV9BhsYofRozc3Zxu/nSQ
         mWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Snu3PItGpsnDryYdrFCgAzev9r8IwiBet2EbwHteIm0=;
        b=1JVjxxtE2DmkAHBCEy1au+IRKIXTLahS1rYjVPryEMo9scv5Q0N4DWKHjfQ3avqsLP
         zpmjzWwURuyZ7Px2NaLkPqvJAFkX0D8e5m26w6kK0/peOq87iECQo7AQz38znHHKlZYU
         zEJaSODcphAByUuMX45ve/oUZ8Q8szsB3/dhe/+3RiyH95Y7AVyBG3DwcZDunD7igpaJ
         BYFRewIxQPLtjexMmFBm03jAydHkxQF8s3nfgVrjTR/oA4vza+w/XQpp/QwkgJ7VsL2F
         7F/8HwNCROCvMFfy0A2bZYmUaxgqqthcr1XlW0lSd39ULMxjhIHDx55IaIWZMsCLnTSN
         McGg==
X-Gm-Message-State: AJIora+DTJftymDPBz4SEEAY408kt8d/1Oezqg53iweIs0VR/sVJUSva
        bem+BGt2M/rivGSrwbY2PmYAmqYzDyRXWA==
X-Google-Smtp-Source: AGRyM1vd2gy0QGdxjlreclWdFot3TOoJN2SNNeQf4KPGTvl+DAvs6m/M5MmuhlDaHED0eL7VvxtKpw==
X-Received: by 2002:a05:600c:21d4:b0:3a3:150a:7ed2 with SMTP id x20-20020a05600c21d400b003a3150a7ed2mr8617581wmj.166.1658752414622;
        Mon, 25 Jul 2022 05:33:34 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:1780:8e54:dd38:6668? ([2a05:6e02:1041:c10:1780:8e54:dd38:6668])
        by smtp.googlemail.com with ESMTPSA id q184-20020a1c43c1000000b003a302fb9df7sm17639067wma.21.2022.07.25.05.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 05:33:34 -0700 (PDT)
Message-ID: <6218894a-8b85-58a3-56f7-e661f2f029ec@linaro.org>
Date:   Mon, 25 Jul 2022 14:33:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] tools: thermal: Fix typo 'the the' in comment
Content-Language: en-US
To:     Slark Xiao <slark_xiao@163.com>, amitk@kernel.org,
        rui.zhang@intel.com, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220722104047.83312-1-slark_xiao@163.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220722104047.83312-1-slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2022 12:40, Slark Xiao wrote:
> Replace 'the the' with 'the' in the comment.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
