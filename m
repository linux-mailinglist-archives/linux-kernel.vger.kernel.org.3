Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C68059F188
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 04:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiHXCyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 22:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHXCyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 22:54:15 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E4879A64;
        Tue, 23 Aug 2022 19:54:13 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 20so14477947plo.10;
        Tue, 23 Aug 2022 19:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=xjHGR01bg2kpVPYi+pXOo5QWorjBYLZotbDze1gfyao=;
        b=UVvnJyreL/MJV4n2DPY7uiwpOIi4ygmz66hYehADwS62vbFMrKivI7MbsWg+beb5Dg
         NoKITJca50UqRTaz4ECwOBE46LbFOOUPcyhLDNlD32UdyrwnISfvEuEoL1hoj6ZH6bMj
         kU+alCujyfUdJ9tEfmBwAyuYv9bUbv+2QjQbkhPRK+EnC4Ont6RdArgtCkiQSh1FWgX5
         mY1pn7IPN5kxjjGPiSWSVaXnJBLcvFWhIgVsjGRryHQEVlXeXCrrNw3rHO13+Fk8qgun
         Llb956xjHtDmq4qpUtFk+SB/dAxv+BZwsz3+3u5dPNsHdwRdmpaaF4hKK1jxBt8IdKDH
         P8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=xjHGR01bg2kpVPYi+pXOo5QWorjBYLZotbDze1gfyao=;
        b=xciyNX+HJH71tuEXzAt7hZrL9WGTmqOkfcOD6oxqSWOBWyzpgNrM5PBv9qpQsV7hKX
         Oa/u4xJVHVlTdnAzcP2MB0I/YSFI2XCIsEAmvieBvt9P7S8QsvKPq3n10dOdgfoeWE4y
         xH9TA3Vkk74l3V2OpK2/UdQ5nUhIN/Ak3YmFzDPLnuJUDBLqIABzxXF1bpZHMmvt65EB
         1T/kH1xmlqVPons9YvO9Ki2DoYifnx6S0HjAOzu/nyMsx2wZMCADPS1Uro8rG587lvt1
         5ds1meoxcoO7PERZrIL3jBYBUmIgrfpHiaQMyhdr2Y8NUZZJueLpYIZrk/SdFgpFGUSJ
         /wZw==
X-Gm-Message-State: ACgBeo0z6qFksN+XpiQBmM3DNLjR4R/debBAwkYLo+cb5r4fEv5cmH7P
        +UMWyFJ1UH/VhjHoX1NSXo8=
X-Google-Smtp-Source: AA6agR4Oy1S3Di/3UUDS7ZkR050xgMIAIBJGXHSup7WBfvP6N1gEGmcgDQb8eZL0ymoy6vfWOhrKng==
X-Received: by 2002:a17:90b:17d0:b0:1fb:5bbc:917c with SMTP id me16-20020a17090b17d000b001fb5bbc917cmr6224052pjb.109.1661309653296;
        Tue, 23 Aug 2022 19:54:13 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-13.three.co.id. [180.214.232.13])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902f54c00b0016ee328fd61sm1795122plf.198.2022.08.23.19.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 19:54:12 -0700 (PDT)
Message-ID: <fc054b1c-b3c8-f627-d4c1-d916a2d286ca@gmail.com>
Date:   Wed, 24 Aug 2022 09:54:04 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 2/2] coresight: etm4x: docs: Add documentation for
 'ts_source' sysfs interface
Content-Language: en-US
To:     James Clark <james.clark@arm.com>, suzuki.poulose@arm.com,
        coresight@lists.linaro.org, mathieu.poirier@linaro.org
Cc:     mike.leach@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, german.gomez@arm.com,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <20220823160650.455823-1-james.clark@arm.com>
 <20220823160650.455823-3-james.clark@arm.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220823160650.455823-3-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/22 23:06, James Clark wrote:
> +:Example:
> +    ``$> cat ts_source``
> +
> +    ``$> 1``
> +

Shouldn't literal code block be used instead for example snippet
above?

-- 
An old man doll... just what I always wanted! - Clara
