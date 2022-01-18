Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD471491F42
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 07:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240405AbiARGFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 01:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240271AbiARGF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 01:05:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B5EC061574;
        Mon, 17 Jan 2022 22:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=eoZNNask/Lw/yitqaxtVE+tSGqFAUnX7/q3GVb7Dbkk=; b=FUe8jaHypBa+8PUDFZCpXfh7tj
        kEnBSOi/+YWvCKqQrAi5w5kswL5NgvgTqVZgLqkIpGRFeiOF6kamDb3IGlP35pHUjiCsinGbs2ObE
        ivZsdF73clZ0B3L5H1hyUuiLcUcF2ucGbtkdZkTt7wrSHTutSncSAg+1U/L1DdVv6zSnZQ6n5Cdwh
        LaxvYevwFdHKmosE/1WACsOXMuU+vxjNTKAqFPurFCxcsCu5yQFMfrWnZVOvqxMBP+xGelNH/HMOj
        knl6Gyy0zLcCaaS96a0SNHaS78n/ykjt2WS5Mof2bXouCzoW7/3gMqhBq2v1B/xclzjcd9eJYxXGq
        xKYWXCxQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9hcS-008yII-TF; Tue, 18 Jan 2022 06:05:25 +0000
Message-ID: <7f4e454c-5f79-7fd7-2866-8db682cc656b@infradead.org>
Date:   Mon, 17 Jan 2022 22:05:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next] Documentation: fix firewire.rst ABI file path error
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20220118010517.20826-1-rdunlap@infradead.org>
 <dc527b05-2b65-cf88-c174-6fec6d458de4@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <dc527b05-2b65-cf88-c174-6fec6d458de4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/17/22 20:08, Akira Yokosawa wrote:
> On Mon, 17 Jan 2022 17:05:17 -0800,
> Randy Dunlap wrote:
>> Adjust the path of the ABI files for firewire.rst to prevent a
>> documentation build error. Prevents this problem:
>>
>> Sphinx parallel build error:
>> docutils.utils.SystemMessage: /work/lnx/next/linux-next-20220117/Documentation/driver-api/firewire.rst:22: (SEVERE/4) Problems with "include" directive path:
>> InputError: [Errno 2] No such file or directory: '../Documentation/driver-api/ABI/stable/firewire-cdev'.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> ---
>> I don't see what is causing this problem...
> 
> Randy, did you run "make SPHINXDIRS=driver-api htmldocs"?

Yes.
Does that cause a problem when just "make htmldocs" does not?

thanks.

> I remember seeing similar errors with v5.14 or v5.15.
> So I don't think this is a new issue.
> 
> Without "SPHINXDIRS=driver-api", I don't get this error on -next.
> 
> I didn't report it at the time as I was not sure it was expected
> or not.
> 
>         Thanks, Akira
> 
>>
>>  Documentation/driver-api/firewire.rst |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> --- linux-next-20220117.orig/Documentation/driver-api/firewire.rst
>> +++ linux-next-20220117/Documentation/driver-api/firewire.rst
>> @@ -19,7 +19,7 @@ of kernel interfaces is available via ex
>>  Firewire char device data structures
>>  ====================================
>>  
>> -.. include:: /ABI/stable/firewire-cdev
>> +.. include:: ../ABI/stable/firewire-cdev
>>      :literal:
>>  
>>  .. kernel-doc:: include/uapi/linux/firewire-cdev.h
>> @@ -28,7 +28,7 @@ Firewire char device data structures
>>  Firewire device probing and sysfs interfaces
>>  ============================================
>>  
>> -.. include:: /ABI/stable/sysfs-bus-firewire
>> +.. include:: ../ABI/stable/sysfs-bus-firewire
>>      :literal:
>>  
>>  .. kernel-doc:: drivers/firewire/core-device.c
> 

-- 
~Randy
