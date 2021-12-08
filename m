Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF0846DAA8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238503AbhLHSEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:04:48 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:39650 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbhLHSEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:04:45 -0500
Received: by mail-pl1-f170.google.com with SMTP id z6so2037662plk.6;
        Wed, 08 Dec 2021 10:01:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VYwIdPbXqoC3VUlE+dykVHDfu7/qH13P4YyQqv994k8=;
        b=g5v1npGG5wthz4l3XhB/Df72E6Q/mUpWz9cfiIeqsO20RXqDqf4I/I9RhKDmLOHN2B
         yPJVCGm+b8NJA7vcWzKr/ww28hIZjJc6AOEqILZPwsq3AEYTvGk6kpT3zWRNAViGS0RP
         mQzppJj5FV4POBgF50LcyrfvylMs/qLF2qTQr2Og2XQMfFdoPWFj/Vrb6EmFZTZzZRfo
         v7BHaKG2yrGqq/8CCr6qwLLZYEfyDJyAsFQFoSJPWa5fHJ/YOHh4pjQ2fjIFCGUPnHz5
         9UCJlGPTWI4sygCTUMnSwoI5Kg1WtoltG5caA24yNj0Zty2WScKNc1WLdm7caT6jme6D
         2apg==
X-Gm-Message-State: AOAM5302Tlp+RZ+I9TsKW+raLYrpcHzmzQSOfqkuvZFJeOChF6fYAWtN
        iHEMOhHn2cg1HMMfSPV1Koo=
X-Google-Smtp-Source: ABdhPJyWdTR1kukLPFUc0+bEuKxPPtofXhY2WCTKmse6N7kuXe3PckkHVGq6KGpHI2ncIc/5oy7tsA==
X-Received: by 2002:a17:902:e550:b0:142:2673:d873 with SMTP id n16-20020a170902e55000b001422673d873mr61255635plf.5.1638986472328;
        Wed, 08 Dec 2021 10:01:12 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:18af:8865:db7e:6769])
        by smtp.gmail.com with ESMTPSA id pg13sm3577873pjb.8.2021.12.08.10.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 10:01:11 -0800 (PST)
Subject: Re: [PATCH v2 5/8] docs: sysfs-block: document stable_writes
To:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20211208005640.102814-1-ebiggers@kernel.org>
 <20211208005640.102814-6-ebiggers@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7d9f9469-5347-780a-c560-77fca6e7008b@acm.org>
Date:   Wed, 8 Dec 2021 10:01:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211208005640.102814-6-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 4:56 PM, Eric Biggers wrote:
> +What:		/sys/block/<disk>/queue/stable_writes
> +Date:		September 2020
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RW] If the device requires that memory must not be modified
> +		while it is being written out to disk, this file will contain
> +		'1'.  Otherwise it will contain '0'.  This file is writable for
> +		testing purposes.

Hmm ... doesn't this attribute apply to the process of transferring data from
host memory to the device instead of to writing to the disk? Whether data goes
to the storage device cache or to the storage medium itself depends on attributes
like FUA.

Thanks,

Bart.
