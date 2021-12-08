Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B058746DEC6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 23:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241000AbhLHXD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 18:03:27 -0500
Received: from mail-pj1-f46.google.com ([209.85.216.46]:34596 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240729AbhLHXD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 18:03:26 -0500
Received: by mail-pj1-f46.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so4893565pjb.1;
        Wed, 08 Dec 2021 14:59:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7lUQRqweKeMiFosOOSe3Fkngs2maTghHnb/E/B7/xHc=;
        b=PerpDaCme8ai/f+szB8h7o6w4WYgfh/O8Q3IzxGttQ1s9ON4lhZLOT1T1+1AaDhtRp
         1Lbnjv2NBVz4mAgot6Mr6PdAQ8ZfkjfUYm25jWdDXDUe2LHgLwV8Sljc1l51Yhq6k9op
         vxbOVc9l1DFgOUl+RLGCwjtq05dT8YlcgnDUu4/myV4nXXeXD1sxUBJpm7cttYLd1XPP
         cVQa9ukEfRCuhLX9zNUHlkPkIRIqbsQiA0rwigNKh83pkJsKQJpb0yeojHI0SRligcTI
         AWrjjyZaM5JlYF7b3AysS51+WiAh7e5VWyAkqpLFt7tN1KAUciiUwNk2/4nZa2LSI1wX
         o2Kw==
X-Gm-Message-State: AOAM533kkRxLB71psDCGPcv8Y6fZZRAef3XFpDOVXOXE7TXy+z+1P8kq
        /CSN8M8nSaK6r1qIMBMbWvU=
X-Google-Smtp-Source: ABdhPJydR/005NsaekppzKyVoRvAikrLCJBOO01sSVi56aX9BXHj7oZSMSduTbDSMhnZm5BbWHrTZw==
X-Received: by 2002:a17:902:b210:b0:143:789a:7418 with SMTP id t16-20020a170902b21000b00143789a7418mr62680540plr.38.1639004393588;
        Wed, 08 Dec 2021 14:59:53 -0800 (PST)
Received: from ?IPv6:2620:0:1000:2514:2f89:deb4:72f3:8a11? ([2620:0:1000:2514:2f89:deb4:72f3:8a11])
        by smtp.gmail.com with ESMTPSA id lr6sm3965507pjb.0.2021.12.08.14.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 14:59:53 -0800 (PST)
Subject: Re: [PATCH v2 6/8] docs: sysfs-block: document virt_boundary_mask
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20211208005640.102814-1-ebiggers@kernel.org>
 <20211208005640.102814-7-ebiggers@kernel.org>
 <13462e59-82f3-d6fc-a84e-2cf3083e0cc7@acm.org> <YbEz4pq2xMfAufwJ@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ac1cefeb-d0f1-3cfc-ffb4-e5ac37b46bcf@acm.org>
Date:   Wed, 8 Dec 2021 14:59:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbEz4pq2xMfAufwJ@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/21 2:38 PM, Eric Biggers wrote:
> Sure, I meant for it to be talking about the memory addresses.  How about this:
> 
> 		[RO] This file shows the I/O segment memory alignment mask for
> 		the block device.  I/O requests to this device will be split
> 		between segments wherever either the memory address of the end
> 		of the previous segment or the memory address of the beginning
> 		of the current segment is not aligned to virt_boundary_mask + 1
> 		bytes.

That also sounds good to me.

Thanks,

Bart.
