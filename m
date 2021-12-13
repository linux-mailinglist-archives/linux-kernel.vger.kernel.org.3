Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8E44733B7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241779AbhLMSMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241489AbhLMSMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:12:44 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77B5C061574;
        Mon, 13 Dec 2021 10:12:43 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u17so11734174plg.9;
        Mon, 13 Dec 2021 10:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u0ZO5JNvqSiBr1Gz4xtJA4SS1i/fXSTFkbeq5Cx27ng=;
        b=Gt0GqgJY2L29P7aI/85Q+Ze3nCh9Wex/Sk+1PpD07cGxKQWV/jXdliEWfftL5WMNBn
         vWqC2xhhTLM861YeNbvtUYOBKwFM6qtcja9lpVvu33wpfQwrP2SKPPqgiBpRTCgf0rBF
         kELoiDBW/A0w6vxkiG++zPLLBu3sSMEqGUV/W88C6yrcLVbxIgQ515r2eWm7wcV0k7iW
         j9pognslXsdQMSHgGUtxnz5fmdaSORW4QajwoYfyJcmHjuP8E41znbj92qPfKlkCWl7d
         L5RBdJkaWa5RdmPw3CpOOVhfExg2Sn8UeOsuLsyhX2/EjE6Eg1XeZydTQDaWYerPuqND
         OA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u0ZO5JNvqSiBr1Gz4xtJA4SS1i/fXSTFkbeq5Cx27ng=;
        b=Xgee228QAl8nMkbXJbR7Gzt82jopCvLr1AOBC8QZciTwYLtFJJJz2DhUJMTmDgOQco
         wEMswPPlVU5ZPMuF+PISD37q24oexUnS4WitQUscW9luoWY8E9LM6EY/4RPjgQyPRx60
         PXBjZXseVhGXER9lXJlYp3FlLBc6HW/lKrjY+T3Liw3Y6nF9WmoYeImIn/BiV1RDx507
         YARqxqeyfmRs7PRTwnTDY2E+hqlyI5F1jd6vIUA1AkaRJk2s+t+m7y+XNubyprs8GeCh
         kbbXA4YdAnrkDIsJ3+csxehThMTdjXldkUoNMMlE+D3PgEbhUGnvkJlNOdTeG/GArTYu
         DihQ==
X-Gm-Message-State: AOAM530pWbNMjqTM/d3y2hxKfhRHFcP7jigCUGhrUrqk+Iosv5b12Sjv
        NdTrIALKtu6kwNp7fO1lkqaPyYcTEhc=
X-Google-Smtp-Source: ABdhPJxgQPoTrHihd4oCjP/iXlWAJIQKycxrzp0sBWaGpDPvPv+Cj2TaTgRm7aP291CZRzVz/pPR7g==
X-Received: by 2002:a17:903:2344:b0:142:25b4:76c1 with SMTP id c4-20020a170903234400b0014225b476c1mr98519066plh.43.1639419163018;
        Mon, 13 Dec 2021 10:12:43 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id y11sm12697567pfg.204.2021.12.13.10.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 10:12:42 -0800 (PST)
Subject: Re: [PATCH v2 1/1] of: unittest: fix warning on PowerPC frame size
 warning
To:     Jim Quinlan <jim2101024@gmail.com>, Christoph Hellwig <hch@lst.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20211210184636.7273-1-jim2101024@gmail.com>
 <20211210184636.7273-2-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3322403d-78e8-6d83-d466-f48bd723cbf4@gmail.com>
Date:   Mon, 13 Dec 2021 10:12:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211210184636.7273-2-jim2101024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 10:46 AM, Jim Quinlan wrote:
> The struct device variable "dev_bogus" was triggering this warning
> on a PowerPC build:
> 
>     drivers/of/unittest.c: In function 'of_unittest_dma_ranges_one.constprop':
>     [...] >> The frame size of 1424 bytes is larger than 1024 bytes
>              [-Wframe-larger-than=]
> 
> This variable is now dynamically allocated.
> 
> Fixes: e0d072782c734 ("dma-mapping: introduce DMA range map, supplanting dma_pfn_offset")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
