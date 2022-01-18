Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EAC491F64
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 07:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242405AbiARGar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 01:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242067AbiARGaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 01:30:46 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42378C061574;
        Mon, 17 Jan 2022 22:30:45 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id i129so12198014pfe.13;
        Mon, 17 Jan 2022 22:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=puR5SlEubwt4sazby7Wq1fF3SMfeLRCW6QTLiIzfIS8=;
        b=jdWbTxFWkpre4bkU5birsLpFrmAGTf21N79B0j6R+EDDkxyYxWRf40EoHY3fNGRDiv
         95sogh/bbK53f2gkwKuTqyPGSX5cJw9aWHjnafy90uOFDilttAJRujyU495vtv9KnxgT
         fXT0Ha3YMivnprFmf6YrLGq3PFYMtZfbT9sV7zr0/psXO5eNM+3+rsLu7zJCVR3RAWUW
         i2bl99E+YkqjdtSFUE9BCAIh4ut3QM7aiX6RA8exrrc0KOjCoptvnYEzTN0xz0NG9FRD
         qkvQN/JQ9Xwu3zJk//xUQjLyiWoYv8s9eZS9Q0dWPynuyNXQK5VkzlI13jBJsoZFsxGa
         k3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=puR5SlEubwt4sazby7Wq1fF3SMfeLRCW6QTLiIzfIS8=;
        b=D++jaLkQZpm3pRWKa2MfTnVg40p0LKuGRji7HsnSn+UGODvAu/poYe9WXcviR4yzcu
         mKwECF0xAJ4/vUoxneKlP1pQDIFb/9l7dLkKhN15zIW/uSazhBE+KK8MuXAuoapKT1j5
         6QNJyIQKqGPOYiaS16WcgOnjIqe7LFyH534CDPvaWVXBX8vdHKhd8e5hTK9rkZVtje5u
         Klj/mAAYSquS0VUjwY1s9PXPqQghyUHHUMlSKttCe06VfgkJbMgbTLt18OnkN5eaL5OO
         rDzUoQ5Cqb07A62c26wLOiWU7gncMP/K6g3qkX0GlK0A8LCSN1oZd3/sKkcb+8C1heqe
         hYrA==
X-Gm-Message-State: AOAM532qiwL02xGHUPhzfmODKmxr18BZNwHpx9neuRy71PoK4hurCdRa
        lrsP1zODJXI1GctyPDQYTiw=
X-Google-Smtp-Source: ABdhPJwl13FOFiVUlcfO7BXRcmB9EQEtPHzyCybbBoDR6iBDximWcnlOalHpVjj60GjwrZfcAQs+dQ==
X-Received: by 2002:a63:8f02:: with SMTP id n2mr22635745pgd.270.1642487444842;
        Mon, 17 Jan 2022 22:30:44 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id om7sm1331122pjb.47.2022.01.17.22.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 22:30:44 -0800 (PST)
Subject: Re: [PATCH -next] Documentation: fix firewire.rst ABI file path error
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20220118010517.20826-1-rdunlap@infradead.org>
 <dc527b05-2b65-cf88-c174-6fec6d458de4@gmail.com>
 <7f4e454c-5f79-7fd7-2866-8db682cc656b@infradead.org>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <99e1e781-0761-2d47-954f-f75aac6e5049@gmail.com>
Date:   Tue, 18 Jan 2022 15:30:40 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <7f4e454c-5f79-7fd7-2866-8db682cc656b@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+Cc: Takashi)
On Mon, 17 Jan 2022 22:05:21 -0800,
Randy Dunlap wrote:
> 
> On 1/17/22 20:08, Akira Yokosawa wrote:
>> On Mon, 17 Jan 2022 17:05:17 -0800,
>> Randy Dunlap wrote:
>>> Adjust the path of the ABI files for firewire.rst to prevent a
>>> documentation build error. Prevents this problem:
>>>
>>> Sphinx parallel build error:
>>> docutils.utils.SystemMessage: /work/lnx/next/linux-next-20220117/Documentation/driver-api/firewire.rst:22: (SEVERE/4) Problems with "include" directive path:
>>> InputError: [Errno 2] No such file or directory: '../Documentation/driver-api/ABI/stable/firewire-cdev'.
>>>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Cc: linux-doc@vger.kernel.org
>>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>>> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>>> ---
>>> I don't see what is causing this problem...
>>
>> Randy, did you run "make SPHINXDIRS=driver-api htmldocs"?
> 
> Yes.
> Does that cause a problem when just "make htmldocs" does not?

No, that should not cause such a problem.

https://docutils.sourceforge.io/docs/ref/rst/directives.html#include
says (emphasis by me):

    The "include" directive reads a text file. The directive argument
    is the path to the file to be included, *relative* to the document
    containing the directive. 

So I think your patch is the right fix.
You might like to add:

Fixes: 2f4830ef96d2 ("FireWire: add driver-api Introduction section")

And please feel free to add:

Tested-by: Akira Yokosawa <akiyks@gmail.com>

        Thanks, Akira

> 
> thanks.
> 
>> I remember seeing similar errors with v5.14 or v5.15.
>> So I don't think this is a new issue.
>>
>> Without "SPHINXDIRS=driver-api", I don't get this error on -next.
>>
>> I didn't report it at the time as I was not sure it was expected
>> or not.
>>
>>         Thanks, Akira
>>
>>>
>>>  Documentation/driver-api/firewire.rst |    4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> --- linux-next-20220117.orig/Documentation/driver-api/firewire.rst
>>> +++ linux-next-20220117/Documentation/driver-api/firewire.rst
>>> @@ -19,7 +19,7 @@ of kernel interfaces is available via ex
>>>  Firewire char device data structures
>>>  ====================================
>>>  
>>> -.. include:: /ABI/stable/firewire-cdev
>>> +.. include:: ../ABI/stable/firewire-cdev
>>>      :literal:
>>>  
>>>  .. kernel-doc:: include/uapi/linux/firewire-cdev.h
>>> @@ -28,7 +28,7 @@ Firewire char device data structures
>>>  Firewire device probing and sysfs interfaces
>>>  ============================================
>>>  
>>> -.. include:: /ABI/stable/sysfs-bus-firewire
>>> +.. include:: ../ABI/stable/sysfs-bus-firewire
>>>      :literal:
>>>  
>>>  .. kernel-doc:: drivers/firewire/core-device.c
>>
> 
