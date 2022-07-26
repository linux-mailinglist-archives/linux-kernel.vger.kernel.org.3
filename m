Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BBB580AE0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 07:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiGZFnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 01:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiGZFns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 01:43:48 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6831327B02
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 22:43:46 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 2003F1E80D89;
        Tue, 26 Jul 2022 13:38:37 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MqCSzBJAsCa7; Tue, 26 Jul 2022 13:38:34 +0800 (CST)
Received: from [172.30.24.122] (unknown [180.167.10.98])
        (Authenticated sender: renyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 287861E80D49;
        Tue, 26 Jul 2022 13:38:34 +0800 (CST)
Subject: Re: [PATCH 2/3] lkdtm/perms: Check possible NULL pointer returned by
 kmalloc(),vmalloc()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     keescook@chromium.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, yuzhe@nfschina.com
References: <20220725081153.20228-1-renyu@nfschina.com>
 <Yt5XZN3CdTprfjwk@kroah.com>
 <bd13881e-6a78-8831-18a8-5b022e8648ce@nfschina.com>
 <Yt6OcTErVYiGYRXq@kroah.com>
From:   tury <renyu@nfschina.com>
Message-ID: <496e6d21-f4fc-2167-6315-c0335c452a00@nfschina.com>
Date:   Tue, 26 Jul 2022 13:43:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <Yt6OcTErVYiGYRXq@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022年07月25日 20:37, Greg KH 写道:
> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>
> A: No.
> Q: Should I include quotations after my reply?
>
> http://daringfireball.net/2007/07/on_top
>
> On Mon, Jul 25, 2022 at 05:54:15PM +0800, tury wrote:
>> When there is insufficient memory, the allocation will fail.
> And have you ever seen that happen here?  The issue is for small
> allocations, they never will fail.
>
>> the return value is void,so i think it is ok .
> Why?
Because the function lkdtm_EXEC_KMALLOC()   declaration is void,and The 
return value is not checked elsewhere.
Should I add some warning messages?
>
>> should i have changed comment to something like this ?
>>
>> As the possible alloc failure of the kmalloc() and vmalloc(),
>> the return pointer could be NULL.therefore it should be better to check it.
> Please wrap your lines properly, and use '.' correctly.
>
> thanks,
>
> greg k-h
Thank you for your help and patience,
>

