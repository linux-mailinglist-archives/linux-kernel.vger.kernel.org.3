Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44AD47203A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 06:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhLMFGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 00:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbhLMFGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 00:06:40 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0679C06173F;
        Sun, 12 Dec 2021 21:06:39 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u17so24999089wrt.3;
        Sun, 12 Dec 2021 21:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P5IB4pdkNu0+WWQCnSEEv2bjVlyIR8GRL9kcHTX2Dy8=;
        b=VPcfPUAFexAi2NUwhJHQIjV495Wl0xje6BFJXDCmxPvZXx16RcpSkEO/7z32mxoua+
         WdFVBxyA+NGBymuW5TCFmFa0fqt3CJt6NlcO5T2mGoGj+Oh/B0VcxqXGxPaQrJWG8YOq
         bI6Ia/8uc89w4n1prnK+pS7pZ+Z+6GT4H+d5QtjiAoom2pP0SVr5MyqczNMkpV/H3Tkc
         gWuwMB6xGLNiQbEro2+w5+y4PE+2DOLvP0F72Jp1STAla7qiZoBOK92tyektWLNXrVNi
         Ot29vTzttsTrEj/VmlVH4zsFcKnwcI0SAzcKIkbjE3lyZvk0+SuOAhuSgjA81ybbhqx8
         Qhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P5IB4pdkNu0+WWQCnSEEv2bjVlyIR8GRL9kcHTX2Dy8=;
        b=VLv7v70x2ok3cmqYCHzGvwT7ejkkkJsuWuAT4RYrb5HpSWiPPYv33TZ0WiFceiw4UZ
         HlNjByGMvyS9FCzY8VePKze2BECmWPhQGu9XS5TkJrlSoOteuzaBbU+kiSbSmT0bCgBN
         paGEr/IPt0exUDyUc3XSJ6ooqnNZdCq3yN52pH+FyEPeiNhaMVpjhkuaef6hohDGkK4O
         D65usD1oaoYcckKbg7fPmz1KA/02dmWA0hzm174pZ5VkW0wVOkIBkJKTHjW+Ez9Aq5Yg
         8f5p75ZIhPlMLRnMUd2iyRbng0wMQNnTcplQSwhNIy4pM+kulAtONVUlryVV50fobTyJ
         N5qA==
X-Gm-Message-State: AOAM531OKNtfptGyQHCYkwE2gLKMlwctiXPoONE6pSAa8HmqgOzEpPo5
        eGMOpdN8RipcnY+5nnk/3uI=
X-Google-Smtp-Source: ABdhPJyr0IBZ9f9fVK0bhPfLL90TngBvgJZc0HechMmfF6K2EqSld22TZIqynA8WBGj1hbJ9+9+MDQ==
X-Received: by 2002:a05:6000:1a48:: with SMTP id t8mr29317414wry.66.1639371998508;
        Sun, 12 Dec 2021 21:06:38 -0800 (PST)
Received: from ?IPv6:2003:c7:8f4e:655:5f1d:2efa:3e7e:1e2c? (p200300c78f4e06555f1d2efa3e7e1e2c.dip0.t-ipconnect.de. [2003:c7:8f4e:655:5f1d:2efa:3e7e:1e2c])
        by smtp.gmail.com with ESMTPSA id m20sm6195621wmq.11.2021.12.12.21.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 21:06:38 -0800 (PST)
Subject: Re: [PATCH v3 1/5] Docs: usb: update usb_bulk_msg receiving example
To:     Oliver Neukum <oneukum@suse.com>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, gregkh@linuxfoundation.org
References: <cover.1638771720.git.philipp.g.hortmann@gmail.com>
 <3b794ef1936eb410b60cb536e47a0a00e36611d4.1638771720.git.philipp.g.hortmann@gmail.com>
 <ec1a30b7-941c-331a-fbc1-02b907cb5788@suse.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
Message-ID: <8c11aa29-d935-94e4-9812-2c882d9e8c19@gmail.com>
Date:   Mon, 13 Dec 2021 06:06:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ec1a30b7-941c-331a-fbc1-02b907cb5788@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/21 9:55 AM, Oliver Neukum wrote:
> 
> On 06.12.21 21:57, Philipp Hortmann wrote:
>>   The :c:func:`usb_bulk_msg` function can be very useful for doing single reads
>>   or writes to a device; however, if you need to read or write constantly to
>>   a device, it is recommended to set up your own urbs and submit them to
>> -the USB subsystem.
>> +the USB subsystem. The template uses urbs for read and write.
> 
> Hi,
> 
> now that I read this, shouldn't we tell the reader why exactly the use
> of URBs is a good idea at that place?
> 
>      Regards
>          Oliver
> 

The Documentation/driver-api/usb/URB.rst does describe this well. We 
could think about a link to it.

Regards
Philipp
