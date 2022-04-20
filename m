Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5299150882A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378552AbiDTMeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353229AbiDTMd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:33:56 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3613FDB9;
        Wed, 20 Apr 2022 05:31:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso1874300pjj.2;
        Wed, 20 Apr 2022 05:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mVOmSvu/QkyoUDoaCks1TklFl6bhUL0cfDQZbrDtx0c=;
        b=eFrXzuQVru1SO/Jm++W8BFQ/TrnadQKCmTFewy4D+IvOJEkOyy/IxcF3Nl5lMJXZSG
         3LR1ddukzf/0l4cFRiLP9e/SNgVj754fkMk6ex6W6/GT9vhz1+XIYwEzsMA2Od0z1vEm
         fBLliE3poB2EQB3/yzUcYLHh8hrWQ86fbEOG8TWbGW8+O7t5/SKSyaFPSK7i5Zux3G/j
         cxSmXvEt+PdNYcc1iz9EJrPBlnwJ2ImTuy1mqKgDdyk8VwfcMfOz91G6Y2J2fdYGeaDN
         owWuWpmYLKEP6FZAPSeaHFrB43Nq6NqwVriNMKiAT93gO50FMc7waA3ETUalCch2m8sg
         2T8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mVOmSvu/QkyoUDoaCks1TklFl6bhUL0cfDQZbrDtx0c=;
        b=Qi09TN6oKO7pWokEcA50CdWnTuoVm2U26Z0fVOjz8XvsdbjHME34vnjLQ0hJPO9Phn
         x5teoW02kwjdOErj3eW9XY0SrqUl5CPfXxm+7AtCcTkFa17RzxkK+7uRwHGpPTouusox
         uuRr85e2M+0lf3qzK2nymvKRgtDHJyf6WyGQ42mVi/JU2TLrFtFFM2/5j1MnpHqz/FWx
         A4zZoKV/f6ky0fg3XoS9wlLQaxkY4avGdKn0KgnxA96qZM84VNOJ/2rrJsxNtxOgfe5G
         Ls0V/3xr5HYMsvYN5W8BuGBI6VbBBAKp2zDdhHqpOTCo6Zv1WKThPExU0Sa0oXts2sjo
         8reQ==
X-Gm-Message-State: AOAM533C17CcYl5ynNxp9NIToFDe9s0j2hncAuwMIfY9mfs55N1apdtB
        fYltc6pvkAWYlVYiyKaGu7NjsGjqOuARng==
X-Google-Smtp-Source: ABdhPJxIfSVgLOciGFWpy5cIRm2hHQBq9p8H/yilz0yZPsHnVLamtbYiXQo5NM1eaNGP99t3RSkGkg==
X-Received: by 2002:a17:90a:2983:b0:1cb:8d6e:e10b with SMTP id h3-20020a17090a298300b001cb8d6ee10bmr4161825pjd.208.1650457870525;
        Wed, 20 Apr 2022 05:31:10 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-76.three.co.id. [180.214.232.76])
        by smtp.gmail.com with ESMTPSA id e1-20020a056a00162100b0050a40f75a82sm18588603pfc.113.2022.04.20.05.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 05:31:09 -0700 (PDT)
Message-ID: <cbb540d1-151d-f5a0-0a24-ce2d2fba4825@gmail.com>
Date:   Wed, 20 Apr 2022 19:31:06 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] doc/vm/page_owner.rst: Fix table display confusion
Content-Language: en-US
To:     Haowen Bai <baihaowen@meizu.com>, siyanteng01@gmail.com
Cc:     alexs@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, seakeel@gmail.com,
        siyanteng@loongson.cn
References: <CAEensMzuQ0uAw8_5Xb7u1n685au=DpaJyPevGCT8GCG7xS42ow@mail.gmail.com>
 <1650424016-7225-1-git-send-email-baihaowen@meizu.com>
 <1650424016-7225-3-git-send-email-baihaowen@meizu.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <1650424016-7225-3-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/22 10:06, Haowen Bai wrote:
> After make htmldocs, the table which is made of tab will
> display all by one line. so we make a standard table for STANDARD
> FORMAT SPECIFIERS description.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  Documentation/vm/page_owner.rst | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
> 

I guess this patch can be factored into its own single-patch series,
so the zh_CN patch at [1/2] can depend on it, right?

-- 
An old man doll... just what I always wanted! - Clara
