Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC9746C6D4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbhLGVof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 16:44:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20925 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230374AbhLGVoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638913263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nGmI7kQNWbEvmiA/4SAjJ2qlBrwJRawfyO5CFs01+o8=;
        b=AMjXZtoF17P2hRrrauEt7k9pLgTyXQVDtRTOBltMx9uP6+zbKHWYx2FKucLvXc3WyRuBLA
        e18FF6Bvm59l+jPscVfAHN4Um06TDheRue3RVydtALtn6KtYJkJpKO/zfijg71aGIwgwwi
        0p490dNIszoRIZie2wpNbZdjV0ThwkE=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-xsvM8zwIOoOLZZys9gihZw-1; Tue, 07 Dec 2021 16:41:02 -0500
X-MC-Unique: xsvM8zwIOoOLZZys9gihZw-1
Received: by mail-io1-f69.google.com with SMTP id 85-20020a6b0258000000b005ed47a95f03so753802ioc.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 13:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nGmI7kQNWbEvmiA/4SAjJ2qlBrwJRawfyO5CFs01+o8=;
        b=q0wdJEmVtWTOO/ked8CVHaZQxdh+BNfWiR8/fgzwf7bq/x7JP91VExsrVRlIu1V2vG
         YVMpy3tW27L6GvAU4tBbnp2KEmkJhqhRP+ydideBULQM8Sc6w9oL9d6DkJC2Ie8SjHQG
         yBcgd2OICBuoZObF73nCNRG3R16Qnnph8LY832EPmbcwGNQIeZd4XRkw2dNTeev/AjzD
         n8qsQo7FljBpmJvk2EnctVrYj31dojOP8y4H01OaRHgTLA+J4UiCac9+7DVSSMioncZp
         lIrfklnafcF3havxaA927ksWk4K7dRzzJKWTTzHYeCGWdZmnAMYi710AAszFqYngqvFX
         fc/g==
X-Gm-Message-State: AOAM533wsI78JefkOHhPhoFYvx0c53SPPtaLPWDsftE4l/r2qOoJB1HE
        wQ2hJO8leJtApRNr/3kNMiEFfqJNG2xxgNyY8shEO7c2kdDOuBmYXoQrotEAkMXqqXo2b8N6fL5
        MDpyCu2MxHjdb+2fEvLshEPzH
X-Received: by 2002:a92:cf45:: with SMTP id c5mr2425564ilr.251.1638913261643;
        Tue, 07 Dec 2021 13:41:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwyqM/PzhfSjpY1htyvNIqqhuJr09WYEY8Im1t+31spDfvEcGYCirMt4dgyvgcJNfQWEWYJYQ==
X-Received: by 2002:a92:cf45:: with SMTP id c5mr2425496ilr.251.1638913261131;
        Tue, 07 Dec 2021 13:41:01 -0800 (PST)
Received: from ?IPV6:2601:280:4400:a2e0:7336:512c:930d:4f0e? ([2601:280:4400:a2e0:7336:512c:930d:4f0e])
        by smtp.gmail.com with ESMTPSA id y8sm594581ilp.46.2021.12.07.13.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 13:41:00 -0800 (PST)
Message-ID: <8951b82b-d95b-5e22-9846-c78a330f57b7@redhat.com>
Date:   Tue, 7 Dec 2021 16:40:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH 2/2] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        ktkhai@virtuozzo.com, shy828301@gmail.com, guro@fb.com,
        vbabka@suse.cz, vdavydov.dev@gmail.com, raquini@redhat.com
References: <20211206033338.743270-1-npache@redhat.com>
 <20211206033338.743270-3-npache@redhat.com> <Ya3WcYKcej8XEI0W@dhcp22.suse.cz>
 <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <d9d14beb-ee20-7ebb-e007-fbf58fb28535@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/21 05:45, David Hildenbrand wrote:
>> This doesn't seen complete. Slab shrinkers are used in the reclaim
>> context. Previously offline nodes could be onlined later and this would
>> lead to NULL ptr because there is no hook to allocate new shrinker
>> infos. This would be also really impractical because this would have to
>> update all existing memcgs...
> 
> Instead of going through the trouble of updating...
> 
> ...  maybe just keep for_each_node() and check if the target node is
> offline. If it's offline, just allocate from the first online node.
> After all, we're not using __GFP_THISNODE, so there are no guarantees
> either way ...

Thanks for your reviews David :)

Yes, I believe this would be a viable solution. At this point it looks like our
short term solution would be something along this line. Long term we would want
to either allocate all pgdats (which will waste memory) or update the memcgs
with the appropriate node information once a node is onlined. Im currently
working a solution that does the latter.

