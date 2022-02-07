Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903A04ACBFE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 23:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244270AbiBGWVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 17:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242361AbiBGWVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:21:36 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C869C06109E;
        Mon,  7 Feb 2022 14:21:35 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id k18so9749453lji.12;
        Mon, 07 Feb 2022 14:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=dkktLNRU0zmH3cyCEBpe0WEVGWBqGQdfPJQTXBunhSM=;
        b=hc73tZIWVTZrpAaE4nYlhbUXTRHpuPeIsm/DVzNGGAtNIYKnqKJm38R3lHv/YAZZoe
         6dumvGazH/DcNklK7C/a2KYRilogiuQE67nQiwDTQXEW+h8RvnvutQUaPNDKrEtlqITV
         BQUYhHahwRfy9S+z4dGvDPbq4M4mN6v7hCchX7TuqbJVXcpp/4iu4x04EmUVEYxDQ4eT
         3SlGBwY/LeCES07hoFL1H3GGLx/WNmrpBowUEpuL8n9qkuD3pGLqmxYR/YUf4KpTIkCQ
         KHFz9BfHnfonI4We0ThJoKxWtfentbyXvGK4XE7po4M0mppcQIBhKbqokvllonrjEnfT
         ejAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=dkktLNRU0zmH3cyCEBpe0WEVGWBqGQdfPJQTXBunhSM=;
        b=Al5FH8KYAOwHAoN91hZh+X8Hqp9HJpqJuDrltfb6gcku43gyEH4Le1/BPKKwxLoIHe
         NvJdrZTafn9rKW54+R/CVxACpOWtg2EsXlZmVytgyuOi64Invq+Mt/p4yt9ejf0KBBmx
         ujAOoaHxwcE/+zhkITRHgMo/scisp0IkNp7aXe24G5wdhgWyPb1JvooEttxRl+XTYOv1
         VMZN+ictq6/kTfuq6HKFZzbGk2cn/aL/8CiHQvgXed1fbhE3s97t/8eUOIT389LFzfS7
         dAGYZ+f3vH+0ycbJ7x2kLqfAqYaMNN5DV6MC2N7EgZMcF36BGXE8eF3/YpA9MP6rXeei
         xQ5A==
X-Gm-Message-State: AOAM531QcxcTBWfK4Ur96AGF0i/+7jAzh9ibentkZ4TsQ6AFLjxPnncB
        9QzqBaN/lAcv8M6PwAKQ8ds=
X-Google-Smtp-Source: ABdhPJy0lK8u0HHeZcS4g5cUIhdkvfCDkT1m8RTeI08c9XX9m06IH6BoZaQ/qPjFO9p38tWv4GXRBQ==
X-Received: by 2002:a05:651c:17a7:: with SMTP id bn39mr960859ljb.26.1644272493832;
        Mon, 07 Feb 2022 14:21:33 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id d5sm117513lji.61.2022.02.07.14.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 14:21:33 -0800 (PST)
Message-ID: <4d1051bc-fbfa-48d8-79db-52406bc19018@gmail.com>
Date:   Tue, 8 Feb 2022 01:21:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 0/3] Support Sharp LQ101R1SX03 and HannStar HSD101PWW2
 panels
Content-Language: en-US
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>
References: <20220131181208.27101-1-digetx@gmail.com>
In-Reply-To: <20220131181208.27101-1-digetx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.01.2022 21:12, Dmitry Osipenko пишет:
> This series adds support for Sharp LQ101R1SX03 and HannStar HSD101PWW2
> display panels that are used by Asus Transformer tablets, which we're
> planning to support since 5.17 kernel.
> 
> Changelog:
> 
> v4: - Added r-b from Rob Herring that he gave to the LQ101R1SX01 DT patch
>       of v2. I missed to add it to the v3 by accident.
> 
> v3: - No changes. Re-sending for 5.18. Device-trees of devices that use
>       these panels were merged to 5.17, so we're missing the display support.
> 
> v2: - Added ack from Rob Herring to the HSD101PWW2 binding.
> 
>     - Updated LQ101R1SX01 binding, like it was suggested by Rob Herring,
>       making LQ101R1SX03 directly compatible with the LQ101R1SX01.
>       Such that ["sharp,lq101r1sx03", "sharp,lq101r1sx01"] could be
>       used in DT. This removes need to update panel driver with the new
>       compatible.
> 
>     - Improved commit message of the LQ101R1SX03 patch.
> 
>     - Added my s-o-b to all patches.
> 
> Anton Bambura (1):
>   dt-bindings: sharp,lq101r1sx01: Add compatible for LQ101R1SX03
> 
> Svyatoslav Ryhel (2):
>   dt-bindings: display: simple: Add HannStar HSD101PWW2
>   drm/panel: simple: Add support for HannStar HSD101PWW2 panel
> 
>  .../bindings/display/panel/panel-simple.yaml  |  2 ++
>  .../display/panel/sharp,lq101r1sx01.yaml      |  7 ++++-
>  drivers/gpu/drm/panel/panel-simple.c          | 28 +++++++++++++++++++
>  3 files changed, 36 insertions(+), 1 deletion(-)
> 

Sam, could you please take care of this series? Will be great to see it
in 5.18 and have the panel to light up Asus TF201 tablet, thanks in advance!
