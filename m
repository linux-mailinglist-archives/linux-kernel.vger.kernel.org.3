Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8BF568502
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiGFKQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiGFKQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:16:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4544D24964;
        Wed,  6 Jul 2022 03:16:11 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso5039350pjj.5;
        Wed, 06 Jul 2022 03:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QK6yAOncYCZ0SYjhcJGpAxsJqFI0Do4KGH7a6ONt8l8=;
        b=SsrofCUl1zt8/CayU8JWs0umya6gVRQDqQAxCYixlsBQjFDisgFNX+UxdYKsuUTwDJ
         BV0fu3ScenIdWT2FJ6YOODc5WolR4zh8SSRJ4vL3JLvrZ0OD1LuYlvAViemC8vQN3YTk
         fh+zwR1f5f1Z7BLroLG/k3Olf0hXD+mtBGs4pPqK7MLCt0etNiQJ28I6wwpi9KT/3lEl
         byF4T3IMmBGaQuv9yNZ3t681Kr/5sUS0I2YncOSYs//+NJbdmYOI7gWE6aoVigH85LxP
         gUxTqf0ilb3a8wcYPFjxvuGuCyb5DjPLuXTypFh9dUoVdnpOMFSK06gSkSN+e/XUBSaU
         hO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QK6yAOncYCZ0SYjhcJGpAxsJqFI0Do4KGH7a6ONt8l8=;
        b=E3jOjujRvthHcKvW2z0H3nc+minmhLNpA7lfXaZqnMTjM+naI4eSNnmNrTV/hoGdY2
         +Ai1Memys4jJdm7YJd8fLLlZgsJS2opfS5OUKDdQmZoZApktW2OXQ5tmLrsaDrM7MdIo
         VQrN3+22leCWKuwimLYgEvtZKRj74v2Io2ZIJ6SfFeydys7os86OB7Oa7ZG3onLJnbWH
         K0fFuvZJMcOlyhcuACVREOwpn/5X5IMtuiuUgSUCP5QT/Fl+za7WSLRSx0Inwz7gBGPd
         TPNsAzQ8XHaJAWtKGbrsZTkXD9EiuVN5K1GQ/HUny/Mt3BxYy6Ts8JhrPuVCremAFuvF
         jQpQ==
X-Gm-Message-State: AJIora8fOeEebaEWszydtyqMvEiewZqTQM7AxqILc5cwnhvj9Lwwlz2f
        QRY6a2JwgMYMIYKUnSCX0xc=
X-Google-Smtp-Source: AGRyM1tCgJrTh3VA+XqMZD3eNF0U1/bn0t9vj4baD6FNEun5NMVIeCgIVcgUpwtA+nesU5uUaQBWWQ==
X-Received: by 2002:a17:902:a586:b0:16b:e787:53f8 with SMTP id az6-20020a170902a58600b0016be78753f8mr13540092plb.163.1657102570782;
        Wed, 06 Jul 2022 03:16:10 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-25.three.co.id. [180.214.232.25])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902680700b0016bfbd99f64sm1711557plk.118.2022.07.06.03.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 03:16:09 -0700 (PDT)
Message-ID: <aa126250-9f7f-b48b-79dc-bdb8b4bf5ca9@gmail.com>
Date:   Wed, 6 Jul 2022 17:16:06 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: unable to read RDB block due to b9684a71fca793
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
References: <YsT5MGPNha1Z1i7V@debian.me> <20220706080912.GA32273@lst.de>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220706080912.GA32273@lst.de>
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

On 7/6/22 15:09, Christoph Hellwig wrote:
>> Bisecting between v5.18 and v5.19-rc5, the culprit is commit b9684a71fca793
>> ("block, loop: support partitions without scanning").
> 
> Which just restores the previous behavior of optionally allowing to
> scan for partitions on all loop devices.  So that error had been
> there before and just disappeared due to a regression.

OK.

Can partition scanning for loop devices be disabled? If so, how?

-- 
An old man doll... just what I always wanted! - Clara
