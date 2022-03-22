Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6C84E360E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbiCVBng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbiCVBnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:43:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B6131527;
        Mon, 21 Mar 2022 18:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=nVKhBCI4fMEjs9snfx8gEi1XWAYrextgE1D2YFOqA+E=; b=KOTzp/ypUL84dSmnhYdBK64S3e
        cjIoXkT4/g9vCeDQ1hpbdVsWfS0il7vI5bQ30uMNd/GFbaMpcNWHgC3ktL3luZ3qBChTbP/DG+zZk
        hGR6Y5f7gZv2YxUCHy5X1oWwNrRtcDELBA1erJfr8Qqb75te3FBRcD8d/g5jupI2wrjvVKnhwtkG+
        YwvPfwzYmMVD2T0JOtB99sv+7tKCcWfjfodnRtBqAoXgxtEhBxJat9hNXhAP90vMva4qmjHTmpoKB
        Fk0X6NMFFvRJSjiweo47aZywVhCyTolZrQxtbsVQlNdwalbJHp5BU1KGAtW13hK4F5P68m4bSHpDW
        84hhJD6w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWTX4-00B9cV-TB; Tue, 22 Mar 2022 01:41:59 +0000
Message-ID: <ffe0183c-7e48-2ac7-9c69-ca87d98c442a@infradead.org>
Date:   Mon, 21 Mar 2022 18:41:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] Docs: admin/kernel-parameters: edit a few boot options
Content-Language: en-US
To:     Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-ia64@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20220321012216.23724-1-rdunlap@infradead.org>
 <87ils6hl1z.fsf@mpe.ellerman.id.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87ils6hl1z.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/22 17:45, Michael Ellerman wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
>> Clean up some of admin-guide/kernel-parameters.txt:
>>
>> a. "smt" should be "smt=" (S390)
>> b. add "smt-enabled" for POWERPC
> 
> I'd rather you didn't. It's not well tested and we ignore it entirely on
> some platforms because it causes bugs. Eventually I'd like to remove it.
> 
> If we ever get time we'd want to support the generic `nosmt` argument
> instead.

No problem. Thanks for replying.

-- 
~Randy
