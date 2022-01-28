Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155A24A01F6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344433AbiA1Uab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:30:31 -0500
Received: from mail-pj1-f50.google.com ([209.85.216.50]:50747 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351189AbiA1UaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:30:18 -0500
Received: by mail-pj1-f50.google.com with SMTP id o11so7457759pjf.0;
        Fri, 28 Jan 2022 12:30:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7kDjbjKyVitEmy209kyKcVMUE+iHkRi25CMkVqRErGo=;
        b=FTAo2N0sQ8ZVG+llGKLz3ElK3+lagiIcyVAkarFeNR0GWNYNB8Y1yX8eH7baQbqzcA
         6dkkClmMGDSo9+R3xj+Mon0cLtl5FAstHyzOl9m4GPd2VSQABZ2VhZZp9FtJUiWpfBgO
         5fvXCwVNig/IqrEYAVfaihmtzdospal3np/SVv9CqmCqFHpuXmDPYUauZ9Afozpu0aq4
         t3AJX4a0vYVrwj+7rb2CR+2JTjns4CebSvilqLP+s5WOTk/8qBBK8fwFLkS/bfA4HPR7
         VEtkEtwOnSOs8+s9TbcB0b5UAFyuLA5hdvnryULYvoYhr4ZwcxVENH8wn4Q4mt1zY7ha
         ijIQ==
X-Gm-Message-State: AOAM5303SIdPQMJHckwmOqUWrXl9hUny1Yspd8JQ6S2QZlYkOtoNzhVF
        TmDtJ/HuluM4Ia3FgarGh050/u9c/nntgw==
X-Google-Smtp-Source: ABdhPJywAqg9UjYB/igmGWMTiIgL4CYQ4yKWzSI3aobUwuD4U95SSUOsJHaLxGm40gQyPp2h68SACA==
X-Received: by 2002:a17:902:7242:: with SMTP id c2mr10660398pll.168.1643401816809;
        Fri, 28 Jan 2022 12:30:16 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id i17sm2620358pgv.8.2022.01.28.12.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 12:30:16 -0800 (PST)
Message-ID: <d570866d-8d2d-3d6b-e0b0-5139e7b990e4@acm.org>
Date:   Fri, 28 Jan 2022 12:30:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
Content-Language: en-US
To:     Joe Perches <joe@perches.com>, Tom Rix <trix@redhat.com>,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220127151945.1244439-1-trix@redhat.com>
 <d26d4bd8-b5e1-f4d5-b563-9bc4dd384ff8@acm.org>
 <0adde369-3fd7-3608-594c-d199cce3c936@redhat.com>
 <e3ae392a16491b9ddeb1f0b2b74fdf05628b1996.camel@perches.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e3ae392a16491b9ddeb1f0b2b74fdf05628b1996.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 11:11, Joe Perches wrote:
> On Fri, 2022-01-28 at 09:59 -0800, Tom Rix wrote:
>> On 1/28/22 9:42 AM, Bart Van Assche wrote:
>>> Isn't this the kind of patches that carries more risk than value?
> 
> Risk for whitespace style reformatting patches is quite low.

But the annoyance factor for patches that reformat an entire source file 
is very high. It forces everyone who has conflicting patches pending to 
wait until the reformatting patch went in, rebase their tree and also to 
resolve the complicated merge conflicts that are the result of the 
reformatting patch. I have already had to do this several times in the past.

Thanks,

Bart.
