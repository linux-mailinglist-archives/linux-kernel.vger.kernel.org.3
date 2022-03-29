Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914C54EAE38
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237177AbiC2NSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiC2NSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:18:33 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C588A639B;
        Tue, 29 Mar 2022 06:16:47 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id z128so14781290pgz.2;
        Tue, 29 Mar 2022 06:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=w3815+MGXaDijvWMYtqcYwozP7wYjHgBU5ZGj2ffCo4=;
        b=fCJ6lzlVxTfVgqckkBqb1S/nzl583ie/5M/JHaHBfoHc7by/n3+u6k/2uLuhJLX9kz
         LoYV8tw4CbW3gC0Mtsb8bSIqTaVWZ2lmdR91CGnXpYlysrL7q5o+W+kCLKV7hVIQxfSN
         4u45i720kDEBKzlXLZJ68/DJGmNfR9cYax+DosToVi7LFXoeW+otnOZ7lOul7yUgC/El
         DN56g8OmHth+8F6zsnpr+a0+GE5msp7tQiw6r2HaFCn3WA4Jq/NxiL5M7AXP8DfHgtIT
         oMLZpUOd6JUoBNj858rV7JFL5xcuLF4oaUhW1rXbl4BpjHGZ1V3+Gq35LgxMDpe2x4di
         Ei3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w3815+MGXaDijvWMYtqcYwozP7wYjHgBU5ZGj2ffCo4=;
        b=LiyMGyFokLzHc/sAMSqEyzJ+q04K2ezByfTQuIfbwxLc+j0qM3ByeFHTl04tYoQigG
         7mZMe9OKIjt0F4F/g/818e1gTMmGfaktTg/Hs9cR7oj29RD0/cTii6stAEeEHoidXmy3
         3Ad0nBes7FJ3tMNDbOEAiaDaq0TR4f6Bxxr1siQJqNnJAJpCSguTLQTL9ezlr4ryUsfz
         zAd3HFERMddZ6fzr1ivKq+XTy+IAUYELTsE/TVzg8Buu7y6TSgtfbM4m/UOK32RcX7lP
         aAXj18wmjsxlw+LZkEsMbDgG59+tN6KNWnD4FJjKZWDUK986O1V8GvVsazPqrT6H0xHr
         itAQ==
X-Gm-Message-State: AOAM532HVkcqYRRWH4VvzWZn0ij5wHGzgFYYXmCIuvVtM/fJEmRzomZk
        MJnoY9T3wHLQZJ/pNSHArzo=
X-Google-Smtp-Source: ABdhPJwj/kTm0nl1gtMSWtdIMVETbuj+vIm8n6hboEbzzsDKKNVmImwLB0nynmcYk2YzKzlK7Q4Q6Q==
X-Received: by 2002:a05:6a00:2408:b0:4f7:a8cb:9b63 with SMTP id z8-20020a056a00240800b004f7a8cb9b63mr27846870pfh.33.1648559807221;
        Tue, 29 Mar 2022 06:16:47 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-29.three.co.id. [180.214.232.29])
        by smtp.gmail.com with ESMTPSA id j16-20020a63e750000000b00373598b8cbfsm15932192pgk.74.2022.03.29.06.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 06:16:46 -0700 (PDT)
Message-ID: <db81d120-039d-f49f-9a48-c91e96777a61@gmail.com>
Date:   Tue, 29 Mar 2022 20:16:42 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 01/11] Documentation: Add HTE subsystem guide
Content-Language: en-US
To:     Dipen Patel <dipenp@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, smangipudi@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, warthog618@gmail.com,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        robh+dt@kernel.org
References: <20220329054521.14420-1-dipenp@nvidia.com>
 <20220329054521.14420-2-dipenp@nvidia.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220329054521.14420-2-dipenp@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 29/03/22 12.45, Dipen Patel wrote:
> +============================================
> +The Linux Hardware Timestamping Engine (HTE)
> +============================================
> +
> +:Author: Dipen Patel
> +

Please learn how to convey semantics with rst format, see further comments
below.

> +This document describes the API that can be used by hardware timestamping
> +engine provider and consumer drivers that want to use the hardware timestamping
> +engine (HTE) framework. Both consumers and providers must include
> +#include <linux/hte.h>.
> +

Maybe it's better to write as `... providers must ``#include <linux/hte.h>```.

> +The HTE framework APIs for the providers
> +----------------------------------------
> +
> +.. kernel-doc:: drivers/hte/hte.c
> +   :functions: devm_hte_register_chip hte_push_ts_ns
> +
> +The HTE framework APIs for the consumers
> +----------------------------------------
> +
> +.. kernel-doc:: drivers/hte/hte.c
> +   :functions: devm_of_hte_request_ts_ns hte_req_ts_by_linedata_ns hte_release_ts hte_enable_ts hte_disable_ts hte_get_clk_src_info
> +
> +The HTE framework public structures
> +-----------------------------------
> +.. kernel-doc:: include/linux/hte.h
> +
> +More on the HTE timestamp data
> +------------------------------
> +The struct hte_ts_data is used to pass timestamp details between the consumers
> +and the providers. It expresses timestamp data in nanoseconds in u64 data
> +type. For now all the HTE APIs using struct hte_ts_data require tsc to be in
> +nanoseconds. An example of the typical hte_ts_data data life cycle, for the
> +GPIO line is as follows::
> +

When we talk about name terms found in actual code (like keywords or variable
names), it is customary to enclose them inside inline code (for example,
``struct what`` or ``u64 what``).

> + - Monitors GPIO line change.
> + - Detects the state change on GPIO line.
> + - Converts timestamps in nanoseconds and stores it in tsc.
> + - Stores GPIO raw level in raw_level variable if the provider has that
> + hardware capability.
> + - Pushes this hte_ts_data object to HTE subsystem.
> + - HTE subsystem increments seq counter and invokes consumer provided callback.
> + Based on callback return value, the HTE core invokes secondary callback in
> + the thread context.
> +
> +HTE subsystem debugfs attributes
> +--------------------------------
> +HTE subsystem creates debugfs attributes at ``/sys/kernel/debug/hte/``.
> +It also creates line/signal-related debugfs attributes at
> +``/sys/kernel/debug/hte/<provider>/<label or line id>/``.
> +
> +`ts_requested`
> +		The total number of entities requested from the given provider,
> +		where entity is specified by the provider and could represent
> +		lines, GPIO, chip signals, buses etc...
> +                The attribute will be available at
> +		``/sys/kernel/debug/hte/<provider>/``.
> +
> +		Read-only value
> +
> +`total_ts`
> +		The total number of entities supported by the provider.
> +                The attribute will be available at
> +		``/sys/kernel/debug/hte/<provider>/``.
> +
> +		Read-only value
> +
> +`dropped_timestamps`
> +		The dropped timestamps for a given line.
> +                The attribute will be available at
> +		``/sys/kernel/debug/hte/<provider>/<label or line id>/``.
> +
> +		Read-only value

Since all these debugfs variables are read-only, we can say "Note that all
these values are read-only".

-- 
An old man doll... just what I always wanted! - Clara
