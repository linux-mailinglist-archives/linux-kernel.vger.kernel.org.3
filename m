Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B067511DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243470AbiD0QyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243415AbiD0Qx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:53:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C5D43236D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=up+7K7g3RZ5HWiJMS7CKYP5oo+B8bzi8wBADoM+J4Mk=; b=L0bhrH6AvVQxQbRpvYlQNg3Pug
        ajJq/j7QhDlutG9+HE80te3ZBHdH9KwGn5eUwyMQliZQQLYPcgIY4y/+du0w7V4FdY+X2rdlvwBoN
        +1ZB9jv78EJRdjuKNS0bWTEU4MrdkUJZEt9CDtfOiMflQoD2tdK9t32ttiah3JLPmwtUvilrhJvKo
        /WRMq20wGqnDKY++cDz7MiytRdhFsDMYccHq1XHwVIHN4IeoTmab6hrd5hOpXdwTXoa+DoQhqqz1H
        SxNolN1KSophz7q1gciSOQnc+mmHgdO5zCgqnkX89NV/ihr4JawG4A1Q5CCD38GpWfUOmzIy93jK2
        XjKeKyyg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njkry-0096rL-9h; Wed, 27 Apr 2022 16:50:26 +0000
Message-ID: <5fec414a-fa12-6c14-3c36-486959aa04ef@infradead.org>
Date:   Wed, 27 Apr 2022 09:50:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] block: remove last remaining traces of IDE
 documentation
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Phillip Potter <phil@philpotter.co.uk>
References: <20220427132436.12795-1-paul.gortmaker@windriver.com>
 <20220427132436.12795-4-paul.gortmaker@windriver.com>
 <87wnfaa8ce.fsf@meer.lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87wnfaa8ce.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/22 07:50, Jonathan Corbet wrote:
> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
> 
>> The last traces of the IDE driver went away in commit b7fb14d3ac63
>> ("ide: remove the legacy ide driver") but it left behind some traces
>> of old documentation.  This removes/updates anything with a reference
>> to ide-cd or ide-tape appropriately.
>>
>> Cc: Jens Axboe <axboe@kernel.dk>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Phillip Potter <phil@philpotter.co.uk>
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> ---
>>  .../admin-guide/kernel-parameters.txt         |  21 -
>>  Documentation/cdrom/ide-cd.rst                | 538 ------------------
>>  Documentation/cdrom/index.rst                 |   1 -
>>  Documentation/filesystems/proc.rst            |  92 +--
>>  Documentation/ide/ChangeLog.ide-cd.1994-2004  | 268 ---------
>>  .../ide/ChangeLog.ide-floppy.1996-2002        |  63 --
>>  .../ide/ChangeLog.ide-tape.1995-2002          | 257 ---------
>>  Documentation/ide/changelogs.rst              |  17 -
>>  Documentation/ide/ide-tape.rst                |  68 ---
>>  Documentation/ide/ide.rst                     | 265 ---------
>>  Documentation/ide/index.rst                   |  21 -
>>  Documentation/ide/warm-plug-howto.rst         |  18 -
>>  drivers/block/pktcdvd.c                       |   2 +-
>>  13 files changed, 8 insertions(+), 1623 deletions(-)
>>  delete mode 100644 Documentation/cdrom/ide-cd.rst
>>  delete mode 100644 Documentation/ide/ChangeLog.ide-cd.1994-2004
>>  delete mode 100644 Documentation/ide/ChangeLog.ide-floppy.1996-2002
>>  delete mode 100644 Documentation/ide/ChangeLog.ide-tape.1995-2002
>>  delete mode 100644 Documentation/ide/changelogs.rst
>>  delete mode 100644 Documentation/ide/ide-tape.rst
>>  delete mode 100644 Documentation/ide/ide.rst
>>  delete mode 100644 Documentation/ide/index.rst
>>  delete mode 100644 Documentation/ide/warm-plug-howto.rst
> 
> The Documentation/ide part of this is already dealt with in docs-next;
> obviously there was more to do, though :)

Yes -- thanks.

I have also sent a patch for the admin-guide/kernel-parameters.txt part
of this on 2022 Apr 23:
https://lore.kernel.org/linux-doc/20220424033701.7988-1-rdunlap@infradead.org/T/#u


-- 
~Randy
