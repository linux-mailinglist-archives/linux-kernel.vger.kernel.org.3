Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24495276BB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 11:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbiEOJu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 05:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbiEOJuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 05:50:54 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB0E2EA15
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 02:50:51 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t25so21271310lfg.7
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 02:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=shicjTKBtrtuDcaN2NsbxhwfQnbe4P6u6jZjTty+jvI=;
        b=P4NpdP8gMX4y3C6YTYYB9Nre+Yy7M1p6asm/4EkODj179NE84yTYgfBRBKmG8Z7SA0
         +ua4WeNEU0y+fUYbcz1fsVq6rVZkM9D+ElBVUTpacF2Rgfh2f5pXnwHtUQSlb3EVGCKh
         7UthSL65O/YTpmLBRbVWkLaIb118nbb/DK9CESGDMIL1Kc5H3hUtl/54+KL6dHmx2oiI
         ZZhDJRQDk3A0HxN1FemJc8XmsRjhBSLMWWuV4zvea5C4vtaNOrfwhG5mPykKNCW2y44x
         OcEOqIUkJHeWiDivadQf0ROtZnh6CsTtQ105UIGXWmQyk37RZiIIyzpjYrgEODD/9Ox2
         uMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=shicjTKBtrtuDcaN2NsbxhwfQnbe4P6u6jZjTty+jvI=;
        b=hDt70zDXAe3ZT7PIrS0xBfgwo77wA+N1Xu40ReYfqHgM+Dc28aG1vuTR2CA+5NrF9T
         TYTqxkbqSF0DxGR/OYuATa0/dI8Ngf6BYPIdBB4+dmgsGcpj1uxMn2jMGmLu+GsaBXEp
         jso/caiKFPwNBJBFi/YMICtoeEkXLq8dTGdTBT51t0bUP6cUlBTWSVQPOminZPIzP576
         oEnU9RS+s9d4aLNOe2vwfvaMOSij5JsX5WSbqEJIHo59WjKqv5tnRN/iiq5ioqkRnemC
         Vy7NwBi4qc21vS/7iU4CyKkZKFlb2jRy2a3pdls7fZ8ZWRYxTylYzSfhqXkccdwqRu7b
         v++Q==
X-Gm-Message-State: AOAM533YFo4T8BndRqwiwPLicJi1guen0Ijc38faEx+kiZ7ednKtt+xg
        Jwj9qqhrN7ZoyG87NQ34mFEoHg==
X-Google-Smtp-Source: ABdhPJwOLry/chcSZ6wRRTHJAPGCWa4sZSHfMWq3GnThJ/DjNvArBBCY0ab9VZbRJdVQtzEcryDExA==
X-Received: by 2002:a05:6512:3993:b0:473:1953:59 with SMTP id j19-20020a056512399300b0047319530059mr9067511lfu.269.1652608249643;
        Sun, 15 May 2022 02:50:49 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d21-20020a2e96d5000000b0024f3d1daec7sm1129326ljj.79.2022.05.15.02.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 02:50:49 -0700 (PDT)
Message-ID: <fab8d2b5-7c1f-4047-8b51-f78358a77d01@linaro.org>
Date:   Sun, 15 May 2022 11:50:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHv2 2/6] thermal: exynos: Reorder the gpu clock
 initialization for exynos5420 SoC
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220515064126.1424-1-linux.amoon@gmail.com>
 <20220515064126.1424-3-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220515064126.1424-3-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2022 08:41, Anand Moon wrote:
> Reorder the tmu_gpu clock initialization for exynos5422 SoC.

Some more thoughts: where is the GPU here? This is a TMU driver... In
subject you also describe GPU.

My comments about unusual code order from [1] were not answered.

https://lore.kernel.org/lkml/CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com/T/#m3edd1fa357eb3e921e51eb09e2e32d68496332eb

Please respond/address to all comments before resending.

Best regards,
Krzysztof
