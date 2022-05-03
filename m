Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4995E5184A2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbiECM72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbiECM7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:59:24 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7C8326D0
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 05:55:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z19so19707848edx.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 05:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=mMhey8pni6QqzQ242qILhQnwRMabY16pK52zsz9eB/k=;
        b=iHAvYsOJEFkfcg/Ij63vRaMi7aJOdqKVyEkYTrT/s7HlmEK4jVfh9rhD5CzSzV5tED
         0835v64va435HBfAieoTknlELEsvf9m5fV81taqBf3gVSVxnKTpsi53FJXRscXwvHia7
         j1jdDOv+cyX9aWZC7MS6eDBPEoLP0oMn9iDZFkOfs/cAcfFV7qc62cJ3Br7LAVJ3H8Y0
         j4QqIu1iUDNTKu98I38LvG/ZaEkVNF5cWUL8R2T30GGcwFwewB17c3MMizuzpShu23WG
         czkUsPqRufdqNwH4+hNaloqAdQzJfntG9wBeAwsG+NclUov2nJTUp2vD6/UxT0meknw2
         iJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mMhey8pni6QqzQ242qILhQnwRMabY16pK52zsz9eB/k=;
        b=pO7HP0xzo8DZBJROql4mqSmbkSRkjO1gcgeA7DisTPKa27hxAQqer03BMlpsxp1vZ2
         ya6pD1O8rXnDhg+yjiNJFNYFYhVgrlGhvfMWBdPoUzRr4AFH2bSJFRV+k82UFlk/9JAG
         auRkPwXqB1lFhOyjXUi5h6YxDeoA0GIvd7fSN6Y1vwEODh7EbCUaIgAP9TOyskIIWRXl
         JHXywSSiup+IKulpxq/omFADNxfSgS4OE4tF53ZNDXRTxfsDaU9jrncYqwqGBRM+9pvs
         Msps0wrL4JSeaAFFn8qVQ01wFrDoWzkW0aMPl9BX05h1ECa8GkZCka3hEy1qummU7WM3
         mc1g==
X-Gm-Message-State: AOAM531R8xorcZWVWY+aGBbsekRJfXJTbGh0zIxTXAOIpD5lVfGYDqeL
        C9zrncfywvuYdlAsRh4xsKqZwQ==
X-Google-Smtp-Source: ABdhPJyAU0MDDN/YwoUn70zHdSSqdI//oZLA8t2/fo/LzttGVG4x9Vi3NiHmUyYds5e9CdE20DFAaA==
X-Received: by 2002:a50:ee11:0:b0:425:b5b3:a48d with SMTP id g17-20020a50ee11000000b00425b5b3a48dmr18111581eds.246.1651582550044;
        Tue, 03 May 2022 05:55:50 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id de55-20020a1709069bf700b006f3ef214e74sm4604047ejc.218.2022.05.03.05.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 05:55:49 -0700 (PDT)
Message-ID: <896ea19b-6dc1-a635-0dd6-c7f9494487e8@linaro.org>
Date:   Tue, 3 May 2022 14:55:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64: dts: intel: add device tree for n6000
Content-Language: en-US
To:     matthew.gerlach@linux.intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dinguyen@vger.kernel.org,
        robh+dt@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20220502165818.4002157-1-matthew.gerlach@linux.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220502165818.4002157-1-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2022 18:58, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add a device tree for the n6000 instantiation of Agilex
> Hard Processor System (HPS).

Please also use scripts/get_maintainer.pl to get the addresses. You
cc-ed here several wrong emails, so no one would pick up this patch.

Actually only my email is correct (except lists)...

Best regards,
Krzysztof
