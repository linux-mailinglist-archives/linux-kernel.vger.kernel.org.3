Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397EA5229CF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbiEKCrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242978AbiEKCjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:39:01 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D42F20EE3B
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:39:00 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so821567pjm.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XdwUILghIFnaQ4lSsZT1htaVoKumfQMYT3jqJYosKNA=;
        b=i5c1+zS+FSpwrUaNVuDvQTY0xFvyrmvn5873w+h5Yj2cfxoceGhQ9egJQXtEAs9rxF
         SP03CINEoRY8mK7VWPjxN70Wv5Lp1yixqUYQ0YE5+e01wvqNCd4vV4fJIus9yKqpPPwD
         sFsdpKTjUbc53RxTg87IbakyNXYAVh0C7lKaGYdhBApe/5gzuj9cWFnBSyEhaKAxIF/z
         s1QVUGBuUBGmgL89jCX5tDMhFiQolH9b18S5ZRFKDPoqmKqalQ64tPXTh8vut68A3SIu
         fTcBKyVXHT2DAG+VPe4hU6VsbptPp+RlC2joZfwEqT0DlsCFYsoXfvk5kSJ+yiEGDLBt
         uErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XdwUILghIFnaQ4lSsZT1htaVoKumfQMYT3jqJYosKNA=;
        b=kQCc5OsYw2WjPMcuwYxmfGkHE+TGzlQRI+JJw5U7U7hBci74GjzFup7IgFFnONo441
         BhooNFcYqd9nzKAxP1LyDB9G81EFVjxPKpRvw0RNiK7xn+/77hgr2Vvmr+2gEy0fG+cx
         dCMxIkMcEwr4AneuTT5sALoNe85ETMouyz6Pjd6ephnhmXvm7dUJFQOjkH1Ywfu4sAXx
         9eg0RgxAEsGfuYo1YdY0u0OzhtGqFHHYtzQBWp7LQAYeQObju+uhitn8f+cHpKxK9R/c
         0PrQt4YLYMLb8h7KK7tlTehICNveDD0HvwT+ZEWl7TTEVqTlMk6sTtBKOlWZbpwH44OV
         6Xuw==
X-Gm-Message-State: AOAM532LFYKNDhAp14MhvQAv0B6pRx1a5UGpVa1TjwZ9RBZBpXDANP6C
        Z7pjqfOUZ3jVcN6fckRoRWJB0Q==
X-Google-Smtp-Source: ABdhPJxKKz513DNbIu55JU7Xrut5nX2qxvbofXieCTjFOhYRH+R7Xokop4Uj//+7mhnxyME5ZhVdKQ==
X-Received: by 2002:a17:902:d4c2:b0:15e:abd0:926f with SMTP id o2-20020a170902d4c200b0015eabd0926fmr23607731plg.129.1652236739734;
        Tue, 10 May 2022 19:38:59 -0700 (PDT)
Received: from [10.70.253.117] ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id bj10-20020a170902850a00b0015e8d4eb20fsm336783plb.89.2022.05.10.19.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 19:38:59 -0700 (PDT)
Message-ID: <41a1d78a-3446-0c94-ed8a-0c383a2c010e@bytedance.com>
Date:   Wed, 11 May 2022 10:38:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [External] Re: linux-next: manual merge of the akpm tree with the
 mm-hotfixes tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220510223530.67d9a27f@canb.auug.org.au>
 <20220510095608.41b0f63a41a5e7f76c1fa187@linux-foundation.org>
 <20220511083542.7f175f4b@canb.auug.org.au>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220511083542.7f175f4b@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/11 06:35, Stephen Rothwell wrote:
> Hi Andrew,
> 
> On Tue, 10 May 2022 09:56:08 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Tue, 10 May 2022 22:35:30 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>>> Today's linux-next merge of the akpm tree got a conflict in:
>>>
>>>   tools/testing/selftests/vm/Makefile
>>>
>>> between commit:
>>>
>>>   e33ebf536f3e ("selftests: vm: Makefile: rename TARGETS to VMTARGETS")
>>>
>>> from the mm-hotfixes tree and patch:
>>>
>>>   "kselftest/vm: override TARGETS from arguments"
>>>
>>> from the akpm tree.  
>>
>> Thanks.  Let's just drop
>> kselftest-vm-override-targets-from-arguments.patch for now - a new
>> version is in the works.
> 
> OK, done.
> 

I just pulled akpm and linux-next tree, saw that you have fixed the conflict
in the commit 526a655c5849 ("kselftest/vm: override TARGETS from arguments").

It looks good to me, so I should have nothing to do.

Thanks.
