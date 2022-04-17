Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859475046D1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 08:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiDQGV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 02:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiDQGVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 02:21:23 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A141CFC2;
        Sat, 16 Apr 2022 23:18:47 -0700 (PDT)
Received: from [192.168.1.11] (dynamic-077-011-140-085.77.11.pool.telefonica.de [77.11.140.85])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 51CD061EA192D;
        Sun, 17 Apr 2022 08:18:44 +0200 (CEST)
Message-ID: <cb824b43-4812-f794-80dd-9ad8f7b35be0@molgen.mpg.de>
Date:   Sun, 17 Apr 2022 08:18:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] Documentation/gpu: Add entries to amdgpu glossary
Content-Language: en-US
To:     Tales Lelo da Aparecida <tales.aparecida@gmail.com>
References: <20220415195027.305019-1-tales.aparecida@gmail.com>
 <20220415195027.305019-2-tales.aparecida@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Xinhui Pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrealmeid@riseup.net
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220415195027.305019-2-tales.aparecida@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Tales,


Thank you for your patch.

Am 15.04.22 um 21:50 schrieb Tales Lelo da Aparecida:
> Add missing acronyms to the amdgppu glossary.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1939#note_1309737
> Signed-off-by: Tales Lelo da Aparecida <tales.aparecida@gmail.com>
> ---
>   Documentation/gpu/amdgpu/amdgpu-glossary.rst | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> index 859dcec6c6f9..48829d097f40 100644
> --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> @@ -8,12 +8,19 @@ we have a dedicated glossary for Display Core at
>   
>   .. glossary::
>   
> +    active_cu_number
> +      The number of CUs that are active on the system.  The number of active
> +      CUs may be less than SE * SH * CU depending on the board configuration.
> +
>       CP
>         Command Processor
>   
>       CPLIB
>         Content Protection Library
>   
> +    CU
> +      Compute unit

Capitalize the U in *unit* as seems to be done in the rest of the files?

> +
>       DFS
>         Digital Frequency Synthesizer
>   
> @@ -74,6 +81,12 @@ we have a dedicated glossary for Display Core at
>       SDMA
>         System DMA
>   
> +    SE
> +      Shader Engine
> +
> +    SH
> +      SHader array

No idea if the H should be capitalized.

> +
>       SMU
>         System Management Unit
>   


Kind regards,

Paul
