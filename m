Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D9D476A76
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhLPGiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:38:55 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:41908 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhLPGiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:38:54 -0500
Received: by mail-ed1-f42.google.com with SMTP id g14so82173860edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 22:38:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zJLV/1H1P/s/Dmcca3Ub5FFr7A4Indes8YbUaLF61jE=;
        b=Vm7QBcx1qrQkHUxBE/RIMQoPk2r9KDq0sAyV/kLnY9BeVF7fOXGT1DKcaKeuw08Q4x
         XHZRguZxyZnWFWOiZeU3Cg+iWzpgFlM1JBCXsmkBsrynoObJN9d6HsjyVA1A/JrDIgXj
         bB/aTgZqy+DxLj8ahZgcm8C+EhSwXftTwSThr0SXgxx0c8CQi7ZCTMWEC+3Xh1OxUx2d
         Oud4d8FPRv0Q7c3Nm+b5wQczeEjD0hX3KSO0KsCo7u5hNE1nRVJp7oRcH6EG+ZWIohyb
         G5G6qut5hV2oZ7sGMRI90+wfCufw+p3/ip+gJ1CjBXYxtp9dfMMo9rJKhld2dfy4n5gx
         Oklg==
X-Gm-Message-State: AOAM531QMYHO1kb94IzBqc6hrSpXZL3HIcq6S0+OReRB0MqpuJ5NhHZC
        lt/wyCDAaUcIoAxH2EblNHA=
X-Google-Smtp-Source: ABdhPJzQAybFeOQNDaD5acGwkBTwg4nW8uUdz9q33HhEk1ZLHHzWAGseAftf+avRT6Eybovkp328Dg==
X-Received: by 2002:a17:906:71cc:: with SMTP id i12mr10460820ejk.457.1639636733341;
        Wed, 15 Dec 2021 22:38:53 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id ga26sm1432037ejc.11.2021.12.15.22.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 22:38:52 -0800 (PST)
Message-ID: <8844f40f-b432-21ab-b552-f11223953537@kernel.org>
Date:   Thu, 16 Dec 2021 07:38:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [jirislaby:devel 8/33] include/linux/compiler.h:61:23: warning:
 'xmit_buf' is deprecated
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <202112160239.cdlehqr0-lkp@intel.com>
 <CANiq72kVC=xwrCEo1tCJG-ucw3T96j5EVOmmX+SNzNjan0GJkQ@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CANiq72kVC=xwrCEo1tCJG-ucw3T96j5EVOmmX+SNzNjan0GJkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16. 12. 21, 0:31, Miguel Ojeda wrote:
> On Wed, Dec 15, 2021 at 9:50 PM kernel test robot <lkp@intel.com> wrote:
>>
>>       115 |                 unsigned char   *xmit_buf __attribute__((deprecated));
> 
> `__deprecated` is not supposed to be used anymore, no?

In Linus' tree, sure. In devel trees, I see no reason why I wouldn't use 
the attribute to catch all the users :).

-- 
js
suse labs
