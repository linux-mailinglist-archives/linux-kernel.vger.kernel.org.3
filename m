Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C47C46F38F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhLITDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:03:55 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:33581 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhLITDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:03:54 -0500
Received: by mail-pl1-f177.google.com with SMTP id y7so4642088plp.0;
        Thu, 09 Dec 2021 11:00:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y5WLCqS4oNc0B1PWaXC9NLJsjv2DgMhZyXGdTfRBzWA=;
        b=LyW0qtm5fHCIOCDe7nPNj5ZjkFLZqqwz/5bRzOoGpVBWHJn4c03s9zMoNKxOtawmtN
         ZbmFQgSkFIdXM4I/xYbhYixNXnXgrajeJ0J1RkPPdzq1Y/UePnpmKZUqRGtTorvVS0tE
         kAKTvZJpuKHSCdblRK17DP1vtkUtyNrgvKgQdZ7UVhlGo+PfE5wfXKijoj+rZ7YsMs/d
         Ojl7cqcYWzHHkh+TBq0/QF1256cnMo8RjpTrkBsHiKsYhe3VWtZu9lieJKbZkBxqZqJ+
         zTF00mBmZDCS1p9z0pGeBhfUVw514Z2M6oQhhR1tnedRc1WB0C8KdDecGPi7U54qJr++
         h5OQ==
X-Gm-Message-State: AOAM531+6PTZtOhxgakZZAXrjjHsmC0NFiAUghEfHDckpkYFxlF9aok3
        q5e9dk5sUKUzsbaNBYcxuMY=
X-Google-Smtp-Source: ABdhPJyRCWX4C0QwOJfqX18IofvfAJ4UX5G4Sj9+JeujP7WTbWENzrXr2tworBPXvHqHktjeVgu94A==
X-Received: by 2002:a17:903:22c4:b0:141:deda:a744 with SMTP id y4-20020a17090322c400b00141dedaa744mr70258352plg.25.1639076420392;
        Thu, 09 Dec 2021 11:00:20 -0800 (PST)
Received: from ?IPv6:2620:0:1000:2514:4f5b:f494:7264:b4d4? ([2620:0:1000:2514:4f5b:f494:7264:b4d4])
        by smtp.gmail.com with ESMTPSA id h8sm359669pgj.26.2021.12.09.11.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 11:00:19 -0800 (PST)
Subject: Re: [PATCH v3 1/3] block: simplify calling convention of
 elv_unregister_queue()
To:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hannes Reinecke <hare@suse.de>
References: <20211208013534.136590-1-ebiggers@kernel.org>
 <20211208013534.136590-2-ebiggers@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ddb37191-c838-2c45-6a9e-a8eb02d18e8b@acm.org>
Date:   Thu, 9 Dec 2021 11:00:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211208013534.136590-2-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 5:35 PM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Make elv_unregister_queue() a no-op if q->elevator is NULL or is not
> registered.
> 
> This simplifies the existing callers, as well as the future caller in
> the error path of blk_register_queue().
> 
> Also don't bother checking whether q is NULL, since it never is.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
