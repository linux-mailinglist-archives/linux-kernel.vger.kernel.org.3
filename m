Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F96A4D7058
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 19:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiCLSNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 13:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiCLSNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 13:13:41 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964FC1DF847;
        Sat, 12 Mar 2022 10:12:35 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 25so16333234ljv.10;
        Sat, 12 Mar 2022 10:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=k2rzdAvd062YWQZphahXNpHBoTUA0G/kUu5FJsmYidI=;
        b=cLIch6UNGEWBwpXkAfGnrMnkGP8hmmnuf7HiuH+uAu625SU0QmoGlc2SVrOSwdtHHB
         Ow2OyVUaeaCPY96YSOm8M/19K6KTez6AWn/3d/zmgIar9rkof3FPKnm87lO8kwKM2+1b
         3dX/gghLidF9HFV9HA0dXTkHfSUl/emasVYkGBa1cGvsdyxcncX44/2QpeLKqMLtYM/n
         XVvI3R378Ml+kG+Udza0rBX+dQPpqIuyderqiQEZniZbeF54vps152YPilKfdRClGtCi
         +cDeXVjFwu8Q7m3gLbXHxzTrBZXLNfwWgOyNtQU1Fpf00ssSL7uReonjyQonkmPSXM34
         Y7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=k2rzdAvd062YWQZphahXNpHBoTUA0G/kUu5FJsmYidI=;
        b=pNA80S4loR1jLbS6iYDYoiBF9f1LtcGJ9cOwMflI/xsDpMYj69HxeSu/kf593RnaPW
         zO2y3j//fj0ui2cHNvkO++uW4mky9QWsW+qF5ei4h2jpcxhbzFFFQEGtubD09hv3bASD
         mIPD68eTjruGjfZ4ba5XFYl24PWnXbEslebp+wd0TfiXpJXAByKADFEooGrHXu0qPu0L
         Ks4FS3gMEgxFRtCHlUks9gkZ210UcPvoSfR5LhnGpJSH+Azz4nSFMEUmAbKbO+vYxB00
         CfWXGfJaqMWRr1STciM/GzHJ1NT9N92A0xdmTYP09Hz2FMxNjTm5CkCdgBKPUNwB5Vps
         pEOg==
X-Gm-Message-State: AOAM531Vroghesi9rERdOlot7xLFmS7eSXMsLBhXV9hJKSRERsQ+tSIO
        E+k1FaKEc/1wuhRGStf60t4=
X-Google-Smtp-Source: ABdhPJxKzGvN1o8WcEOhsd6BTrlU/Lny5O/iTIWdGCHtEoNj9ujCnMKIsvOKhUi0uhP9YsrKpfM9og==
X-Received: by 2002:a2e:2d0a:0:b0:248:7c35:28b4 with SMTP id t10-20020a2e2d0a000000b002487c3528b4mr8155470ljt.175.1647108753844;
        Sat, 12 Mar 2022 10:12:33 -0800 (PST)
Received: from [192.168.2.145] (109-252-136-171.dynamic.spd-mgts.ru. [109.252.136.171])
        by smtp.googlemail.com with ESMTPSA id g19-20020a2e3913000000b00247dea5b468sm2571838lja.115.2022.03.12.10.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 10:12:33 -0800 (PST)
Message-ID: <45e5f833-b492-30df-a1ed-108e05a2b465@gmail.com>
Date:   Sat, 12 Mar 2022 21:12:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 3/9] gpu: host1x: Add context device management code
Content-Language: en-US
To:     cyndis@kapsi.fi, thierry.reding@gmail.com, jonathanh@nvidia.com,
        joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mikko Perttunen <mperttunen@nvidia.com>
References: <20220301161455.4037062-1-cyndis@kapsi.fi>
 <20220301161455.4037062-4-cyndis@kapsi.fi>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220301161455.4037062-4-cyndis@kapsi.fi>
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

01.03.2022 19:14, cyndis@kapsi.fi пишет:
> +/* host1x context devices */
> +
> +struct host1x_context {
> +	struct host1x *host;
> +
> +	refcount_t ref;
> +	struct pid *owner;
> +
> +	struct device dev;
> +	u64 dma_mask;
> +	u32 stream_id;
> +};

I'm still not very happy about the "context" names. For example here
it's only about the "memory context", then why not to name struct as
host1x_memory_context or host1x_memctx?

It's not good to use generic names for a special things, it hurts
readability of the code. It's important to choose good names.
