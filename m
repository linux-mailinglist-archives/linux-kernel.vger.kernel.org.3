Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8515F4F95DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbiDHMgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbiDHMgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:36:10 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9864234203B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 05:34:07 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n8so7754964plh.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 05:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UtCrT7/OSpWOMAYO1geobq/EXsQPSfaZpg6dw1dccJA=;
        b=gPKeOsWZLKcITHew9VoVHySrY5DJP0Xoq5SL8mWQSl66apSzBVnvBRZ/oK+qhP6JKp
         tVcm2JW5DrWNtD8mif4Q1M9xG37iHT+EaQAueKg+4A/cCvT2Ui39w0MV+2DvT8n84nmw
         dKeRPqqEozhwSOi3cAcEOm21BRXqsPCZLm/2LHc/3hLxU6BbiTY8pyO2ZIpk0CUqxVqr
         7g8mFp1soYukAAbGdorkfOb9lCBvxmxJp/3S+qanUCY6Q8NqCW6IkSnk0XCtBbtIBLdP
         MJsJH3t95rv2kewA7PAOHgXl053lje1moRmLQHsXqdRVAHesPP1HtyDvHsheGCrs8WEy
         tnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UtCrT7/OSpWOMAYO1geobq/EXsQPSfaZpg6dw1dccJA=;
        b=C5Q2x+RPbIfj7RVVsujz03XKYUv6yuNdOzUQOxcOo6KkwrxIUR68rqoV3RYM5PtALI
         DH4MXV3pcfyXqjHD9+1kXqLikBG2KyBbIpljVvGCZaHH/icr8KQepHSmSaNlv3MuZ9H/
         vjqpu62u5+TT27YdqGJkj0Q1y/pfWBiVOJRu8D6H+7an6gK32rmT7tsBK5BT9Q9iKbcE
         ksw9j9IfDLV+ULMrIdO592x9jVt7OyBQKf1e0hWcemJjqOrus9olH7B0QEkmoUozE0Mj
         JY4h1WUtSpWxrT281Dx4uBk1PuQO32LTie5XZ8kJK8o3PD1XopzSW25NYdzhEBl26w0g
         oW9g==
X-Gm-Message-State: AOAM5339sAWzBxO7QwEpSw5SCJbq3Ib6U04URL7vXgtvIXB5clKi8U78
        EOTvAlo7g1M5o4/HgaxH3e+TCQ==
X-Google-Smtp-Source: ABdhPJx/pXWT+ts25J0AmcdjjobsCtLNqf+Qxas8597jmmWX3smB+JCJmjVD1xbCjKpi1LxBs/Sy8w==
X-Received: by 2002:a17:902:9009:b0:156:8b7b:8e4 with SMTP id a9-20020a170902900900b001568b7b08e4mr18757641plp.100.1649421246902;
        Fri, 08 Apr 2022 05:34:06 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id co7-20020a17090afe8700b001caa0af5f8csm11818487pjb.37.2022.04.08.05.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 05:34:06 -0700 (PDT)
Message-ID: <25390602-cfa0-dba3-bfbc-a35ed6b44bcf@kernel.dk>
Date:   Fri, 8 Apr 2022 06:34:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] cdrom: do not print info list when there is no cdrom
 device
Content-Language: en-US
To:     Enze Li <lienze@kylinos.cn>, phil@philpotter.co.uk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20220408084221.1681592-1-lienze@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220408084221.1681592-1-lienze@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/22 2:42 AM, Enze Li wrote:
> There is no need to print a list of cdrom entries with blank info when
> no cdrom device exists.  With this patch applied, we get:
> 
> ================================================
> $ cat /proc/sys/dev/cdrom/info
> CD-ROM information, Id:cdrom.c 3.20 2003/12/17
> 
> No device found.
> 
> ================================================

And what did we get before?

Will this potentially break applications that parse it?

-- 
Jens Axboe

