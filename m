Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E9B485930
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 20:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243537AbiAETbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 14:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiAETa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 14:30:59 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3253C061201
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 11:30:58 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id e128so394601iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 11:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DMDyVFtwDqG7zCTgnBPM/RrWzwScfQ0OQCuIiJfEtKw=;
        b=uG54arT6RqfHaPHgXk3nwdqxgRz3XKT51x0cp9cpIHnDAtHjqpq/vLdnGsGX5dL9VG
         wWYqTbSM/II/30qgOZO/ZTDB/CniH4t6V5H50ufWhSD3Sp4t6P1i2OsUgUznfKbkpSUz
         OWAA/OxZj0NyMJfUbOEkbzzKIzyXZVKsMSMjWpsFD3RrnIqVULqyb0Zj6RRGMwERk3hF
         Vk6S5vpBBP6Ir/OhepgzAL3JGVbia44TiG72J1uedmXvdHvWw8RyQ2vwT+cqEyffmLQ/
         aEQsS0BLo+NZqScB42EreMzOEbNYZ7mJGkEGlDsBKYl5fmgc+DJ4B+wQxicWQIcoKJ+S
         SaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DMDyVFtwDqG7zCTgnBPM/RrWzwScfQ0OQCuIiJfEtKw=;
        b=j/mNhBEeK0niElh6/4/7DYA2xSjtTg2rh2PjC2/9MH70ysC54HTqM5qUaX0YGkKM9s
         sRzb2HWvJWmz0z2sEwggdREqENr93odAqmJq8zTQJKTXVnXE2dzyrcGOTUXLYR+GVRAf
         GKCGs/kNMDbPIbI/8OAnnh/D1Ba/04aYWfmftlk3SLXn4Dmc4E9qXowXUxYWTfW6FKxH
         7cm1+/tzI9wX9uxs7sAUGgG00Tfq9AqO/hinbqrgeTOE8FQi+VMqhMuYQ4CMPdPCFcO6
         AnGWrUl/Rs7430EXfmAtRmYqpVX9jkh5XHEkL9aCmoMHlgWirET/fEBa2PCcceSIZiDQ
         dl6g==
X-Gm-Message-State: AOAM530ny0dOJ4T7+b70DgddjeJLj/GCXZgu1for4LvM9zZxYvo9dCOq
        QoYI5avb0Eu78H/wwk6XyapnF/rLg9WpdQ==
X-Google-Smtp-Source: ABdhPJxAjdF18pppt7QsGuUeqs5t3GeE6qeeALB1KYU5MTy/EqK6/mPlT+h5EUjSykkKLKsxA7R0vQ==
X-Received: by 2002:a5d:944a:: with SMTP id x10mr25007319ior.18.1641411058036;
        Wed, 05 Jan 2022 11:30:58 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z13sm6024551iln.43.2022.01.05.11.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 11:30:57 -0800 (PST)
Subject: Re: [PATCH] io_uring: remove unused para
To:     GuoYong Zheng <zhenggy@chinatelecom.cn>, asml.silence@gmail.com
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1641377522-1851-1-git-send-email-zhenggy@chinatelecom.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <296e66fa-e8a1-4888-92e3-6f5093c5378d@kernel.dk>
Date:   Wed, 5 Jan 2022 12:30:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1641377522-1851-1-git-send-email-zhenggy@chinatelecom.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/22 2:12 AM, GuoYong Zheng wrote:
> Para res2 is not used in __io_complete_rw, remove it.

Applied, but changed 'para' to parameter. Please just spell it out,
there's no point in being too verbose here. Also added a Fixes tag:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.17/io_uring&id=00f6e68b8d59bf006db54e3e257684f44d26195c

Thank you!

-- 
Jens Axboe

