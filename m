Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6BC464992
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347861AbhLAI2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 03:28:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36794 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235384AbhLAI2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638347081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fkzPDiWFZ0xPHB730aPwxoy6RLUvNRKztlsGB8SnQLU=;
        b=ASel7VGykXtUFO7cl9/BqWR2v8Kh9whxNgtFyfpZNFPooFkVDmZHZ6E2wGjSh7KwUXN/1O
        OMnmrGKljHzURqB3sIQE+dbuRfJWZCJUdmvPKFx1+t2lutx+ENsNrN24qxw4dzOwIdJSl0
        516BeNXhdSVoI9AT/RJNpaRAC6GuslE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-8PezGaGyPCuTL_YmrTCbbg-1; Wed, 01 Dec 2021 03:24:40 -0500
X-MC-Unique: 8PezGaGyPCuTL_YmrTCbbg-1
Received: by mail-wm1-f72.google.com with SMTP id ay34-20020a05600c1e2200b00337fd217772so522575wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 00:24:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=fkzPDiWFZ0xPHB730aPwxoy6RLUvNRKztlsGB8SnQLU=;
        b=tzGyVgEAp3U1uabFvDD1YFWqDYx72JbQkwHH5XskYBGAeEJT8xGNoOkYtCpWFoclue
         5kaJjIQQsU4jj/cI8qgf4nS5DEx3X1TsUg7JlGOKDtY9ic8eo58QURuBC0lntKPHUtos
         /Ygm/syK/NItCEoD6ArPEcJ+mTTPzsBPqJZjZKIxuYBgnr0rastQAWIytPqFDb4WUPiW
         kyXYEofvIYOLoumi6AHQqYS2CFtToauole9bjkJPANHBTm29wxTMcYpZNH6ltAbPwYZv
         yYcaU3hhIHWqZ2o72BQ3/tTDnOPPcGPfLb1yLG5pq+M4QCQ6JF/B3gyaHamal2yiLdG8
         QF7Q==
X-Gm-Message-State: AOAM530np0pRJiCRSMIwat6Q5/3UmRI/TYPw/7SsD2TxPoKbwCDevObO
        TUKJ1dOtofViikBxV58oQ5G2e3fNKwl+GyCk9zD5QebSDOkWQ1GjojIF7meAMjxRerna2aSjx0R
        hUjRHT4PYllgFC1Li6X7GyPex
X-Received: by 2002:a05:600c:4ec7:: with SMTP id g7mr5186346wmq.138.1638347078778;
        Wed, 01 Dec 2021 00:24:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxL7t5c38ZspM03DxqSzGkOrDykj7ybqwhfbHfItmliidB3NvPI6hvo5nRFdkz+zbZAl2dzrw==
X-Received: by 2002:a05:600c:4ec7:: with SMTP id g7mr5186333wmq.138.1638347078608;
        Wed, 01 Dec 2021 00:24:38 -0800 (PST)
Received: from [192.168.3.132] (p5b0c65f1.dip0.t-ipconnect.de. [91.12.101.241])
        by smtp.gmail.com with ESMTPSA id u23sm268279wmc.7.2021.12.01.00.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 00:24:38 -0800 (PST)
Message-ID: <7afa01ef-9048-4636-6059-efed7fadc452@redhat.com>
Date:   Wed, 1 Dec 2021 09:24:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 0/2] virtio-mem: prepare for granularity smaller than
 MAX_ORDER - 1
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Gavin Shan <gshan@redhat.com>,
        Hui Zhu <teawater@gmail.com>, Eric Ren <renzhengeek@gmail.com>,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
References: <20211126134209.17332-1-david@redhat.com>
 <20211130185612-mutt-send-email-mst@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211130185612-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.12.21 00:56, Michael S. Tsirkin wrote:
> On Fri, Nov 26, 2021 at 02:42:07PM +0100, David Hildenbrand wrote:
>> The virtio-mem driver currently supports logical hot(un)plug in
>> MAX_ORDER - 1 granularity (4MiB on x86-64) or bigger. We want to support
>> pageblock granularity (2MiB on x86-64), to make hot(un)plug even more
>> flexible, and to improve hotunplug when using ZONE_NORMAL.
>>
>> With pageblock granularity, we then have a granularity comparable to
>> hugepage ballooning. Further, there are ideas to increase MAX_ORDER, so
>> we really want to decouple it from MAX_ORDER.
>>
>> While ZONE_MOVABLE should mostly work already, alloc_contig_range() still
>> needs work to be able to properly handle pageblock granularity on
>> ZONE_NORMAL. This support is in the works [1], so let's prepare
>> virtio-mem for supporting smaller granularity than MAX_ORDER - 1.
> 
> is there value to merging this seprately? or should this just
> be part of that patchset?
> 

The value would be to give it additional testing ahead of time. But we
could just carry it along. Whatever you prefer. (I'd suggest merging it
right away)

-- 
Thanks,

David / dhildenb

