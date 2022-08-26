Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14C25A27FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245256AbiHZMti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236923AbiHZMtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:49:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1F0C7F8F;
        Fri, 26 Aug 2022 05:49:33 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id d71so1294618pgc.13;
        Fri, 26 Aug 2022 05:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=GuwsaMvCwAgYPTQhMZtDxDqr9ggINpFfdVcPm87pxtQ=;
        b=m73g+IL3JFctN/+LhYBY7nIisDKX0erkmn9qLj9SmLqnWMLPUDHFP6c5g/20BnL+32
         9A+rx2fEq1SKmxNveOUbgu4S8mw28BBOO1z4B2eVXw/GSSQa+v9PL8tqb0nyfpaRxZSn
         AoTLqcvTSbgXPNjLad7GaAJaFtf2yMGmtrn5ZidLI/bKJmv7NP/InXjIbma42h4J7GUT
         p6qoRFseKEdorWbKbdJB3V6QljetgyoYjeTq9gZLJkCUV/AbhoBe7oJKhkIcP5JOuQrv
         7Izc03GWvjd0E5b+BSeOuqDLo/BusaLQQRmMXNrQuiwlh4TcvEQsm5DkYkhX5QhgqWUj
         AqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=GuwsaMvCwAgYPTQhMZtDxDqr9ggINpFfdVcPm87pxtQ=;
        b=Pv8HRv6N/1CNm5jfYhxs8IdacywWNrt5ixPP6N7+RJ8yxnomgGau0M84X/KqkBJML3
         PysAzP3rvgMNxiBqO0ySXx4chd92FCt5zdxqKGSiMfU1gc5QyNAb/An9C6i9oAiaCkUv
         QPCDAP+PPKYndGgwxBvkwiZEOd6XA3ff7lnSGg7iS3T0/DcIK4vTVJ0mJEMa1qIDRumD
         oh1sBGwDwLzvRjvFC9OLpx/IUYpeFGDQNO5/J+QK12jvF2t0lz1qm6vuUAWTuNfOc16g
         ApIxlQIx9yq8wkalsvVXGpeK5q0NiHBS1/5JWKsDKaEJzCPUAcrldT9xm1D+TznHrift
         adwA==
X-Gm-Message-State: ACgBeo3JOj2xE4QGIIdkLqyWtWeWj9DuXRSXJuJEsh21+pOIUYNuumga
        RrAwqT7yrYwF16JfjBNajcQ=
X-Google-Smtp-Source: AA6agR4FdF9mHbI/LAGkXs6/dzr1IIhdm2xbGyKqr5psK+hbtw4kFYu+w95qboO6ZJ1mEMFbV2b0Wg==
X-Received: by 2002:a63:4b62:0:b0:421:8c8b:163c with SMTP id k34-20020a634b62000000b004218c8b163cmr3043730pgl.182.1661518173132;
        Fri, 26 Aug 2022 05:49:33 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-70.three.co.id. [180.214.233.70])
        by smtp.gmail.com with ESMTPSA id 68-20020a620647000000b00537d7cc774bsm581267pfg.139.2022.08.26.05.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 05:49:32 -0700 (PDT)
Message-ID: <28a70308-a996-7d97-430b-dc18bbd8bbcc@gmail.com>
Date:   Fri, 26 Aug 2022 19:49:26 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] Add leds-qcom-lpg to leds kernel docs tree
Content-Language: en-US
To:     Akhil Raj <lf32.dev@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220826081150.1961-1-lf32.dev@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220826081150.1961-1-lf32.dev@gmail.com>
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

On 8/26/22 15:11, Akhil Raj wrote:
> Warning was within
> ./Documentation/leds/leds-qcom-lpg.rst:
> 	WARNING: document isn't included in any toctree
> 
> I have added leds-qcom-lpg to the index.rst
> 

Hi,

Mauro had already submitted the same fix at [1]. Thanks anyway.

[1]: https://lore.kernel.org/linux-doc/14865c294b60fef58f660922889775bd57ce44c2.1660829433.git.mchehab@kernel.org/

-- 
An old man doll... just what I always wanted! - Clara
