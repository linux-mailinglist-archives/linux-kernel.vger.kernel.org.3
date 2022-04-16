Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BFA503456
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiDPFuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 01:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiDPFu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 01:50:29 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490AF2980B;
        Fri, 15 Apr 2022 22:47:59 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id be5so8529188plb.13;
        Fri, 15 Apr 2022 22:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=hZc9zcmo/JWKOyzC5RRU+RQ67f92+BjrAId5apbjxx4=;
        b=BTmnZpEXjDVfSLT1f+xWT1/xn6sYOGBXR8vnDdrxz72m3mLd5ZTISc8FjWEHxbnZ0Q
         kJ7JUbXOpyyCJhdDcNb1py4wsDmm7KpjIfQP6GR8yEcaOYKFQYFO+2vWcNvXpiZKLMr3
         q/e6QdW02QmpwPIlnbLe3oX4WWCYdm2n/JyeS+GEd0Hp93xNjUuUpiis8JhOFyd2SMFN
         ay7peWdqRl0rrxVRxMOEZ+V2dJeDYrI9zRG6DJgh5g+qK1wueWuxmR5pDbJZt8lPtBd3
         j/RdN9aum+gG4YDDb8b+7ttaSuryetMAh4wDVL2BAlRjdQfCShj0B6C35DBcPCbMdm1W
         78DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hZc9zcmo/JWKOyzC5RRU+RQ67f92+BjrAId5apbjxx4=;
        b=ZCYEcWVq1QJCzJtf46ffc7a5sNloUyWrGNKfpQZhzlnGXrHsKrdDxLf5mXCfqDtYSb
         WzvP7WpnM1JD27gOFZYk+NrmrCaiEDh2uOCT1Hk+i2J+tls/PPRsvRe4oeX/2Rl5MMET
         XlL1gUQEWyVK9VUlfvfvh4z5pCU7sDp/AHhPu2dqzzo+eYPDK7smA+hx++bR0begwnJy
         oFJM2iEuClewcGqVA6btIENUMaEXMDWzgdai4xXkS7OLUg+4AuX2EF9MosYgRvs9wr0B
         YVvIPi5YtZG4OvC9g+M/iIIHkxVQyPzMv0IGEJW3l4COPjgLHJMC98iNtf4Ra9SORVpf
         Zk9g==
X-Gm-Message-State: AOAM533Fx8CMs3oLwNo88HERuBQSO8/Yi7HH42twRSyNEFNIPq7hzmXF
        pebFiMcs68qeqDM1WR81z9E=
X-Google-Smtp-Source: ABdhPJzdHPNlkXPAZkSmp1NrPiHL6M/Utpy+7qlfUa98UuKLz8IjuFuaODr3HigacXCm/YRRaKqAOw==
X-Received: by 2002:a17:90b:3889:b0:1c7:a31f:2a50 with SMTP id mu9-20020a17090b388900b001c7a31f2a50mr7764499pjb.193.1650088078753;
        Fri, 15 Apr 2022 22:47:58 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-90.three.co.id. [180.214.233.90])
        by smtp.gmail.com with ESMTPSA id u22-20020a17090a891600b001cd498dc152sm7993070pjn.2.2022.04.15.22.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 22:47:58 -0700 (PDT)
Message-ID: <4f4c8441-a144-6c2d-0f8b-b598905c2f3d@gmail.com>
Date:   Sat, 16 Apr 2022 12:47:52 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] MAINTAINERS: add docs entry to AMDGPU
Content-Language: en-US
To:     Tales Lelo da Aparecida <tales.aparecida@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrealmeid@riseup.net
References: <20220415195027.305019-1-tales.aparecida@gmail.com>
 <20220415195027.305019-3-tales.aparecida@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220415195027.305019-3-tales.aparecida@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/22 02:50, Tales Lelo da Aparecida wrote:
> To make sure maintainers of amdgpu drivers are aware of any changes
>  in their documentation, add its entry to MAINTAINERS.
> 

Did you mean the Documentation/gpu/amdgpu/ is maintained by dri-devel?

-- 
An old man doll... just what I always wanted! - Clara
