Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E592259531F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiHPG4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbiHPGzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:55:52 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB8FC16;
        Mon, 15 Aug 2022 19:16:19 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id jl18so150877plb.1;
        Mon, 15 Aug 2022 19:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=FUdVp34ur6filFB5ocUjWYYEU7/MFQlaJELy6CBl9Y8=;
        b=pGrPBfAPfUe769qcCTVDGtbX9Ch6Z7wpw+SscDF+XRfTR7gOSeOGx4/pM8M/zwyTxs
         eyT6FMF3CzFpOMV9gdeSu/iAs1FbKojoASQiEeqY70yMcPiLr6yAhqImNFAWOngnv4mG
         mZCCuPqUTudpuP55CySblv6EMDm80mIbSqtH5Fe+LrBgZOgj7UbXEXrlfSTf2/V7mxiv
         BUGqjIdw26zWQWD5fp8oMZjit7u4Zyr0YLFGAoGm3LCwdCWXgW6+iDbTxCCARl6CkcGn
         gDrdvwjKNTasOMdl+tEpCUFjTunbuIc1VW05piagBb9dfuP1bUprIOObBug+n6I8VmXI
         L49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=FUdVp34ur6filFB5ocUjWYYEU7/MFQlaJELy6CBl9Y8=;
        b=CMECnlGeoP9v++jaKuIjvlYFESzrvpqv+eCa+frRuHkhZZZAfF/amb+Yw2hMc4c6P3
         wks8Qdp1Gd2q6aTnbcOeTgof/xC+RX0QG8XdeZGSY0emMY2qrD3nAFwtkFZGG8uDIosT
         fr1TwxiE9vGpa4vAvsJvp+ri/WngzrwmmHHu2WNYG+7Y4EMTVaKwBuMs10tZeKGw9tKJ
         pUUX7YsNbHoUak1AW87HZWph49C/fh7xXM+vgLxjGnNc+SIjGYAiYilN4t2YYsZk5kbY
         aZSyKhNxO1a1K07z1+BBntUbMyaG4KQVEbmJhS3Vy0Frh14W1NEtwX8qjh/GFjjeuJ15
         lOjg==
X-Gm-Message-State: ACgBeo3Qj1EHBDRl6zzIB+1RGhGg7CWH+lpAfqhUHoqkWg4CK87QLPjr
        X4KU88kMLy9nWGoAJ+Kme6E=
X-Google-Smtp-Source: AA6agR4TGGZ4D+7AY1P8FcE7lzEV2lW13PDK5szsI4NZNPa4xBfLQvKl2//7lKah4PMmdjJAi6Tozw==
X-Received: by 2002:a17:903:1205:b0:171:4f8d:22a8 with SMTP id l5-20020a170903120500b001714f8d22a8mr19470780plh.11.1660616178742;
        Mon, 15 Aug 2022 19:16:18 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-16.three.co.id. [116.206.28.16])
        by smtp.gmail.com with ESMTPSA id b189-20020a62cfc6000000b0052d1275a570sm7168809pfg.64.2022.08.15.19.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 19:16:18 -0700 (PDT)
Message-ID: <7538e307-63c8-7394-c069-44ff732dae81@gmail.com>
Date:   Tue, 16 Aug 2022 09:16:10 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] docs: admin-guide/mm:
Content-Language: en-US
To:     alexlzhu@fb.com, corbet@lwn.net, bobwxc@email.cn, rppt@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com
References: <20220815183706.2508116-1-alexlzhu@fb.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220815183706.2508116-1-alexlzhu@fb.com>
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

On 8/16/22 01:37, alexlzhu@fb.com wrote:
> From: Alexander Zhu <alexlzhu@fb.com>
> 
> This commit fixes typos and grammar errors in
> Documentation/admin-guide/mm/concepts.rst.
> 

What's the full subject? The subject (and description) should be 
"Improve grammar on MM concepts documentation".

-- 
An old man doll... just what I always wanted! - Clara
