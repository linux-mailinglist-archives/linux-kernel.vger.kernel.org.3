Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBDB48116F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 10:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbhL2Jyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 04:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239626AbhL2Jyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 04:54:36 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E108EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 01:54:35 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id x1-20020a17090a2b0100b001b103e48cfaso14414442pjc.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 01:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:organization:subject:in-reply-to
         :content-transfer-encoding;
        bh=rL3NsdE5zJYwZ5gnMhTjsKd+XhECyW7B+4rA8dAJ3nk=;
        b=eFEcQ+0sSfqP9ogfMbHE/6Te+nJXnRPOiQjMzvKjwKso0EmlV/jFpjsrfg0MxvEZcN
         Qn7VPsqznkZIGPThgeFGbUBVhDDqoIYPzwMHTFuWiEmzjezLhaHKIQrWuVNnspRXcD/c
         Ve+hbl7cOX35UkN8InsVBnS0ISTqIgcmdx+n8TzaLyEh9U0AfZXYDMBmO//oKxYoRX9W
         X1d7z2s9KFQD9VJ1WsDfOEhkmoehnqUEZA4SB4XRWAQCfmaGPL77Jk8aSyMFCRNzHBTA
         3Y0xs/1CNl6Al0qLRfV3PK4KqpzrWJdqPb8jFUCcKcOjMRQmWYHiir2S2w3ESSjWeCWq
         SZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=rL3NsdE5zJYwZ5gnMhTjsKd+XhECyW7B+4rA8dAJ3nk=;
        b=rdbEDOWmoy6ucHxQoQjMOXuSazX9mIVYSAJx1Nt74D0ksHNkYzlz6ziFkVmya0P8y8
         3ErL+EoQrL6in+OXfEormsvlNEYTUwYv1C62hG7K9ffK7b/KlHCsmAsUJ8f+9hGNipLR
         fOmezm+hvp/iWTvy2iN3CnjMBghDKtpm0ZMUlCYHgrjZs075AGOFoJOdWZGy+afSm/d5
         oRJn+DLUYSZ+BfxcWtDhCZnisFNJjybhRC0yMioJzIQhACiQR0XR/EkBSxyl0A+x9cfE
         JUt8C2X6TkVOE4FxoeGcB6ZpRl5crLDLbxDNgmLi6u+ycw9wO6VsibPvov60ZcJ/xu4V
         PuVA==
X-Gm-Message-State: AOAM533mgbNq4cujA5qkRwem7qetcVM9E5Lxy2sNSPYq8Vy/FFh3Akb9
        30w8j1fHjVpD8Ncm9cCeAJY=
X-Google-Smtp-Source: ABdhPJygvOIy5yOnH435RHRidcTtdSTK5jQN/MRq3hCyBUhZsoQRkT/ZrndX+rGsWBmW68TYe/+dKg==
X-Received: by 2002:a17:902:b718:b0:143:72b7:409e with SMTP id d24-20020a170902b71800b0014372b7409emr25973914pls.28.1640771675386;
        Wed, 29 Dec 2021 01:54:35 -0800 (PST)
Received: from [192.168.255.10] ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id s14sm23411929pfk.171.2021.12.29.01.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Dec 2021 01:54:34 -0800 (PST)
Message-ID: <9c8d02ff-74a6-b8ba-c19b-9ee20da9af12@gmail.com>
Date:   Wed, 29 Dec 2021 17:54:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Content-Language: en-US
To:     Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
References: <20211210210229.2991238-1-eranian@google.com>
 <20211210210229.2991238-4-eranian@google.com>
From:   Like Xu <like.xu.linux@gmail.com>
Organization: Tencent
Subject: Re: [PATCH v4 03/14] perf/x86/amd: add AMD Fam19h Branch Sampling
 support
In-Reply-To: <20211210210229.2991238-4-eranian@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephane,

On 11/12/2021 5:02 am, Stephane Eranian wrote:
> + * The BRS counter could be any counter, but there is no constraint on Fam19h,
> + * therefore all counters are equal and thus we pick the first one: PMC0

Are you assuming that no other counters can be enabled (guaranteed by the
patched perf context) when BRS is enabled ? Otherwise the hard-coding of
PMC0 may destroy scheduling freedom. Can we relax this condition?

Thanks,
Like Xu
