Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914D4549D71
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348788AbiFMTVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349107AbiFMTVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:21:18 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325C41CB37;
        Mon, 13 Jun 2022 10:23:08 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AB2EC381;
        Mon, 13 Jun 2022 17:23:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AB2EC381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1655140987; bh=k58hDWJfANavQFvKsrGGJcppdon+Ur4ul3J1RTm5fL0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NjSw1C6pIAC6Tha3bJMkfoZss6QYYR0CEm5g91/3GPYdVZS2eaj9FgEYMVTTTrRPO
         bsw8H+P29gvcHZCtuSpRgiNJ6J6pXM9APWdle3PaJupADTHs4ZqoOLCvMnNuNXFC4M
         E7TSEZbLhN+YWnNadbNzEmoboX8eorGlkRpfKTc5vuc5trCHooiaRN1RENI2owHmjp
         wrh4zRQm0mZ7CTanfStloZSMmpNOWvxqdb3ec2YqH1w0q08EBSAOyEwAVueRmp07T0
         QdrbTK3lm4L64k4mfCiFRyg1G5QPLln5YWGWXosMIHa5eVrNu0pwjShJ76HmOgzJ0r
         oqUgxOofFipDA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Chao Liu <chaoliu719@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Chao Yu <chao@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
Subject: Re: [PATCH v2] docs: filesystems: f2fs: fix description about
 compress ioctl
In-Reply-To: <Yqbu+BArbUNGvft9@liuchao-VM>
References: <20220613020800.3379482-1-chaoliu719@gmail.com>
 <Yqaw3VTD46PAMN8O@casper.infradead.org> <Yqbu+BArbUNGvft9@liuchao-VM>
Date:   Mon, 13 Jun 2022 11:23:07 -0600
Message-ID: <87czfc1nr8.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chao Liu <chaoliu719@gmail.com> writes:

> On Mon, Jun 13, 2022 at 04:37:01AM +0100, Matthew Wilcox wrote:
>> On Mon, Jun 13, 2022 at 10:08:00AM +0800, Chao Liu wrote:
>> > v2:
>> > - s/file size/filesize/
>>
>> Why would you change it to be wrong?
>>
>
> This is a suggestion from Chao Yu. Maybe he has some other considerations.

Sorry, I should have replied to that.  I disagree with that suggestion.
"Filesize" is not an English word, and there doesn't seem to be any
reason to use it in our docs.

<checks>

We have to occurrences now - one already in the f2fs docs.  I think we
shouldn't add more.  So my plan is to apply the first version of this
patch.  Chao Liu: is there a reason why you didn't add the Reviewed-by
from Chao Yu in the second version?  Chao Yu: is that tag still
applicable even without the "filesize" change?

Thanks,

jon
