Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC74F466A7C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357563AbhLBTgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:36:11 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:45927 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbhLBTgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:36:10 -0500
Received: by mail-pg1-f171.google.com with SMTP id 133so719316pgc.12;
        Thu, 02 Dec 2021 11:32:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CuO9SlAMyySc2N7/ycy5VD46Nz+8cG+KHA0nnkbmkHc=;
        b=T0Da/RnwA5q6xNMFJx73ePeDRsWsnmeCnH/DWkxxLz+MNDuGjZyU7piUq1KFZBRZaz
         LJm7ENMiV1jwSey+BXuNAFFVrnFzs6qVgYYKPTNh0AbQd3PYmbkj1Qt1tSeA5apKfUmH
         9LM41+zXybxG+JLYTWN6ZUcFehBcjOv05Sh3kFuabS1+V0H03/axWUZTs5r4K6ui2cW4
         KsoSXfVvjfBlyl7XG8FL829L5hdDxjS/L9xFR8GVGmSst5g8F05qOdsTc8D/usT4rNoO
         hlHh9h72qYa3SrL7a1Rzx+pnHZQNtHcPm4xHnvbbVynhE5oY+8WINX1A5RK6H87nDpY6
         0lOg==
X-Gm-Message-State: AOAM530dhG3QE6O2dubf6FX8ixrxCUe0v+v6gAXT8KNyz5LCtbwxDvh0
        9tplpNDwvVSMhsUwjFzdIXWafRgTufo=
X-Google-Smtp-Source: ABdhPJybkg0jKh/Q6ZJqyLfjyFgX8JgM9tzmXPG2O7rRG6t2vjJ5+cthEcId8+b+3rzJLlcKtHqafw==
X-Received: by 2002:a63:5c05:: with SMTP id q5mr892811pgb.599.1638473566667;
        Thu, 02 Dec 2021 11:32:46 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:fac5:b2eb:ef0d:f30b])
        by smtp.gmail.com with ESMTPSA id f15sm561950pfe.171.2021.12.02.11.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 11:32:45 -0800 (PST)
Subject: Re: [PATCH 0/7] docs: consolidate sysfs-block into Documentation/ABI/
To:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20211201084524.25660-1-ebiggers@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <0bf11301-4085-f4a1-eeed-c65d0e5563b4@acm.org>
Date:   Thu, 2 Dec 2021 11:32:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201084524.25660-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 12:45 AM, Eric Biggers wrote:
> This series consolidates the documentation for /sys/block/<disk>/queue/
> into Documentation/ABI/, where it is supposed to go (as per Greg KH:
> https://lore.kernel.org/r/YaXXpEAwVGTLjp1e@kroah.com).
> 
> This series also updates MAINTAINERS to associate the block
> documentation with the block layer.
> 
> This series applies to linux-block/for-next.
> 
> Eric Biggers (7):
>    docs: sysfs-block: sort alphabetically
>    docs: sysfs-block: add contact for nomerges
>    docs: sysfs-block: fill in missing documentation from queue-sysfs.rst
>    docs: sysfs-block: document stable_writes
>    docs: sysfs-block: document virt_boundary_mask
>    docs: block: remove queue-sysfs.rst
>    MAINTAINERS: add entries for block layer documentation
> 
>   Documentation/ABI/testing/sysfs-block | 766 ++++++++++++++++++--------
>   Documentation/block/index.rst         |   1 -
>   Documentation/block/queue-sysfs.rst   | 321 -----------
>   MAINTAINERS                           |   2 +
>   4 files changed, 545 insertions(+), 545 deletions(-)
>   delete mode 100644 Documentation/block/queue-sysfs.rst

How about adding a patch that moves Documentation/ABI/testing/sysfs-block
to Documentation/ABI/stable/sysfs-block? The block layer sysfs ABI is used
widely by user space software and is considered stable.

Thanks,

Bart.
