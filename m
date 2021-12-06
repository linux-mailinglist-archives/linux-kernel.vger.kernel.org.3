Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3CF46A119
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376403AbhLFQVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356504AbhLFQVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:21:05 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C59C061A83
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 08:17:35 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id t83so11642288qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 08:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R4jGu2qbmARxbGb3tgU7TY4VubezWvXJws2tBM5yACI=;
        b=JrREj+GYATn/OgLASlKoyqwkpFQIbBcn3h8+rHrduh4wsclXJZXTUaIOiYwOWV38Bd
         VJgDIV8DxO4nYZ544e8+vF3kvTIssorXg0OsQgFN2TvCzLvY9MbjarJrLOToMcG2+MW5
         5NAUNdFuVYD3tTbEvNqBbL/V1HO4qljhIylprRvGeFoooLAn7uDiIbYSFK/twWQ/SELU
         ZhA/x7vnd3tChmOF8PvB1zk0Aj2eKs4UzAjXGLjE5UddxW+Ca4HWej3cfmGoYlNq0vbc
         MbU9wLo2u+1WxT7fxR1ckb3ryYE10Xf63Q5Y+26HwxleHMIpiLiK5GuvCPsk16XGldXA
         MwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R4jGu2qbmARxbGb3tgU7TY4VubezWvXJws2tBM5yACI=;
        b=pUNxd+SG4RdmAoW5cYClV2OAmCDFanTu/F3A6AUBoLB+wCsWUhtfWFgfRbxEJ+p47g
         4eR3lt3RJpEwPIkgA8rQwxLsq8zVWEzwZLjuikWhIzKH/rEb8XprDiUgs/5m8hXc8uRN
         vN3Wac8SOYaL5LOGDSL2I5ziy5smxxlT3DQVRf+JbH9srhRnzKdMQBsKhf0EwwV+JL9a
         CmOzJEoot91l8IDqoyBZXmFrt/tCgQMOzQEgkR9bdw/C4D84q/z0iK1VOLNWT5H2/hub
         ibwsUZUiAt8QAbE4VuKdOcFrVkbCgxgg48GSpyQqoo/Yz5iMB6HormXd2Wy7UZW91Qw0
         +yEA==
X-Gm-Message-State: AOAM530laBq+nNrvYL+YDr4d6uaz9mZPzcoC7+3rL/y6ZgLz7v0mVvHa
        6765+3IywkpP0SeWwkND3EVYDg==
X-Google-Smtp-Source: ABdhPJyC7uIvfU+T7FDc6RP31Z2irw5DUroyBb38U+GlqnWKWtBwkIbAJO+Rn97S2b3rckXKDuQhJQ==
X-Received: by 2002:ae9:efd8:: with SMTP id d207mr33848579qkg.97.1638807455064;
        Mon, 06 Dec 2021 08:17:35 -0800 (PST)
Received: from localhost (rfs.netwinder.org. [206.248.184.2])
        by smtp.gmail.com with ESMTPSA id f12sm7291521qtj.93.2021.12.06.08.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 08:17:34 -0800 (PST)
Date:   Mon, 6 Dec 2021 11:17:34 -0500
From:   Ralph Siemsen <ralph.siemsen@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 char-misc.current tree
Message-ID: <20211206161734.GA4141317@maple.netwinder.org>
References: <20211206144901.63529ac9@canb.auug.org.au>
 <Ya4Tb9NUj33UdxmI@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Ya4Tb9NUj33UdxmI@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 03:43:11PM +0200, Andy Shevchenko wrote:
>On Mon, Dec 06, 2021 at 02:49:01PM +1100, Stephen Rothwell wrote:
>> Hi all,
>>
>> Today's linux-next merge of the char-misc tree got a conflict in:
>>
>>   drivers/misc/eeprom/at25.c
>>
>> between commit:
>>
>>   9a626577398c ("nvmem: eeprom: at25: fix FRAM byte_len")

This was my original patch from Nov 8th.

>>   5b557298d7d0 ("misc: at25: Make driver OF independent again")
>>   a692fc39bf90 ("misc: at25: Don't copy garbage to the at25->chip in FRAM case")
>>   58589a75bba9 ("misc: at25: Check proper value of chip length in FRAM case")
>>   51902c1212fe ("misc: at25: Use at25->chip instead of local chip everywhere in ->probe()")
>> (and probably more)

These are newer versions and some cleanups from Andy. I was not aware of 
this work going on. I'm surprised at25 is getting so much attention ;-)

>> I fixed it up (I just used the latter version) and can carry the fix as
>> necessary. This is now fixed as far as linux-next is concerned, but any
>> non trivial conflicts should be mentioned to your upstream maintainer
>> when your tree is submitted for merging.  You may also want to consider
>> cooperating with the maintainer of the conflicting tree to minimise any
>> particularly complex conflicts.
>
>The result from char-misc.current should be used as is and I guess it's
>what you have done, thanks!

Agreed - Andy's version is cleaner, and includes my fixes. I've run some 
quick tests locally and all seems to be working as expected.

Regards,
Ralph
