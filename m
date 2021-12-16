Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B65047802C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 23:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbhLPWxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 17:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhLPWxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 17:53:37 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5838C061574;
        Thu, 16 Dec 2021 14:53:37 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 70C6A740;
        Thu, 16 Dec 2021 22:53:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 70C6A740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1639695217; bh=NXX/Lz87ap+4ILofsJe99zKcovJCoPqQXL8CAuKOyb4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PK05iQ/ApujTC8PKEUMIWI/pVWRhUdMyk9tueHxP1MMTKS1iuXhCk0QPd5vn3MWJn
         0BMfXOAUhuYoq+DRx6RSUyXXjbznFHuAF4G2ye2UhLEW8U/+W6bqsUZQU3xgRxt9Ez
         e/IgWU8lXPxj+h+xCO3VyeR0DBT3LADQyccBt6nnzVYn2KkV1jrUVvwIMAbXfIYPw6
         cLTnoReMj6QuhIO7V2zzXOCAQjDaCOwMeOmyc6a40v6rOu5XCBoECQBlqlYP+4boU/
         P/IglGYjx0LK5G/0q7wp77XCU58gz8+GLSgzExnPgyD5mbgm7T2jhD7wpUmhCYjgGk
         7oOXk3s2NOExQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Anssi Hannula <anssi.hannula@iki.fi>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] docs/vm: clarify overcommit amount sysctl behavior
In-Reply-To: <f964967d-dd47-f509-33c3-abd6f8593710@redhat.com>
References: <20211211194159.3137362-1-anssi.hannula@iki.fi>
 <YbUkdvFBayRwV6ax@casper.infradead.org>
 <f964967d-dd47-f509-33c3-abd6f8593710@redhat.com>
Date:   Thu, 16 Dec 2021 15:53:36 -0700
Message-ID: <8735msduvj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 11.12.21 23:21, Matthew Wilcox wrote:
>> On Sat, Dec 11, 2021 at 09:41:59PM +0200, Anssi Hannula wrote:
>>> Documentation/vm/overcommit-accounting.rst says that the overcommit
>>> amount can be set via vm.overcommit_ratio and vm.overcommit_kbytes.
>>>
>>> Add a clarification that those only take effect in overcommit handling
>>> mode 2 ("Don't overcommit"), i.e. they do not act as an "additional"
>>> limit that is always enforced.
>>>
>>> Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
>>> ---
>> 
>> Simple and clear improvement, IMO.  Cc'ing linux-mm to get more eyes on
>> it.
>
> As I had the same idea to just make this clearer in the context of
> advanced documentation for virtio-mem, so I approve :)
>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Applied, thanks.

jon
