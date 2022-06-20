Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF882551721
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241534AbiFTLQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241745AbiFTLQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:16:48 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4566321
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:16:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d14so6444708pjs.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HvulG20gneCBbLogqzqJr05tnntfvevjnEgSfdyAsP4=;
        b=NJazLfbXCca0HTEbMzZ3yIaUxeEZFfqysSCYrkofN82yLpIUml4EqkqC+SqCKkiDdN
         Nrr+z9hjBU5pBRDD2siMUZEi1RjQld9z5wol8h5RJEc5Z5w0LqUHMREu4VizpadFMMXF
         Y+DHv/NTBv2UFeWQK7eFeeD+oTdAkX8lx0p39nbqaDjKpOvWg9GiNVJ66IdZRfDaU3gH
         Blgh/oQGT+yB7AOgrdzRwv/cMbBzfcssKTWyLLSLjr3hqQGFVLUaNtM4qOiodQzDoSms
         4oqa3Uogwp4nH6HikDCDWK515baYS/QMwzmlxroEVYfG79rMCLkvC/C6oU3ets6RWn2I
         c7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HvulG20gneCBbLogqzqJr05tnntfvevjnEgSfdyAsP4=;
        b=bBhfoBHBZbjnhmFFO97r1h1Fl4JbQACFkyR8PMJr5plthbxAdE9vC3FZB5L51LBoM/
         tEtQdwR8RYNBVGsnWPtWUJkpdaDBe+z7q4RxvMG9wNCtj5OQ08JYhXpG/JJV/7HS1lG4
         pxxpePnXZ2IzI6KcnItBLWYgr6R9j8P86Np0oqclFWpt60ygKDKAP08lFF1CtoP1BJSR
         zU6oX/P/TqPNMANyzxskfrCL4gcthozMtLrrywaUzY9EEAeq9Ub6GSjF0IzM3gyUXwhc
         7KLmRa7kh8GeaXD3MybqAeSn0uHt/8SY6xHuXygkbdP5jFA3azwhNoVJcDhCVRVqe2U/
         28wA==
X-Gm-Message-State: AJIora9QYvrF6lvtLxqlr4wAiH3gRYAcamxF3xrK3KxWEdIMc3MPgWrZ
        JU6hMS+esy6Pyh80k8b5OQtVwQ==
X-Google-Smtp-Source: AGRyM1vjk0GU2jma/buJ6A27WgYRcxAAI5oaor9Qx76kXIzpRNSiCyhD621dj8oF22H7I6Fm2qpT+g==
X-Received: by 2002:a17:90a:d348:b0:1ec:854c:31a4 with SMTP id i8-20020a17090ad34800b001ec854c31a4mr15124609pjx.80.1655723806900;
        Mon, 20 Jun 2022 04:16:46 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x67-20020a628646000000b00522c8fa6ff3sm8886907pfd.6.2022.06.20.04.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 04:16:46 -0700 (PDT)
Message-ID: <983d503d-1cac-e568-62b3-d10c12c59383@kernel.dk>
Date:   Mon, 20 Jun 2022 05:16:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [iov_iter] 8416b73063: canonical_address#:#[##]
Content-Language: en-US
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org, lkp@intel.com
References: <20220620024749.GB3669@xsang-OptiPlex-9020>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220620024749.GB3669@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/22 8:47 PM, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: 8416b73063d19b0a1b487cb9336641b5d1dea33e ("iov_iter: import single segments iovecs as ITER_UBUF")

This one got dropped days ago.

-- 
Jens Axboe

