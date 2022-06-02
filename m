Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D3C53BC90
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 18:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbiFBQbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbiFBQbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:31:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3762B12DC;
        Thu,  2 Jun 2022 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=SQwGGc1qc4tP2TEm97x+HMLFr9XNhA6Mh+1eNWVjw4Q=; b=GCN2C7TdI5FtNsMs/mm90IOO8q
        M4hakPoawHzgfPq7fokh+zr4az63lrFZ5ZSj5D8N8XMCwoCZ0cRP9zY+Q1aVMCsc6UTM/iiNPMbss
        2wkO2LKsZsn2Nhe/vBcCWI7yhJNhyskghWP7pz2swA5emKO6m+QefsS6SOvxSv8gV7XrdKqA/3n+y
        yTSJNugrZDo1/SxrQECgiusMDEUg6l7mGD9kL5L3RQkfwBT262PumDrGCB9v2vwmayKWqtnR8L0yZ
        X5+5By2omiXIUnUVj8mZ5D8a0e1q7Ww45PCyFNmcb19Tu+dqqQVuaJimDRZJS8EJ01vKW46D0zX5C
        zlCrLpAQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwnjM-0049l3-SR; Thu, 02 Jun 2022 16:31:29 +0000
Message-ID: <47a68855-4547-49dd-d7eb-8ef83630552c@infradead.org>
Date:   Thu, 2 Jun 2022 09:31:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5] crc-itu-t: Fix typo in CRC ITU-T polynom comment
Content-Language: en-US
To:     Roger Knecht <roger@norberthealth.com>
Cc:     linux-kernel@vger.kernel.org, Ivo van Doorn <IvDoorn@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org,
        Kristian Hoegsberg <krh@redhat.com>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        akpm@linux-foundation.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <20220521124745.8747-1-roger@norberthealth.com>
 <a728cf17-4866-1151-0740-56b06257c917@infradead.org>
 <CAO_iFwrHcSWJm17fL-Q83DZ5i1xr+_dkEjh5Yt3Hxso0VtnzZw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAO_iFwrHcSWJm17fL-Q83DZ5i1xr+_dkEjh5Yt3Hxso0VtnzZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/22 07:24, Roger Knecht wrote:
> On Sat, May 21, 2022 at 5:44 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>> I don't know which maintainer will merge this since no one is Cc:ed on it.
>> You will probably need to choose some maintainer to send the patch to.
>>
>> But let's add the people who merged the header file in the first place
>> for their comments/review. (done)
> 
> Thanks Randy.
> 
> The CRC implementation seems to be unmaintained (no entry in the
> MAINTAINER file).
> Any idea which maintainer I can send the patch to?

Yes, the 2 people who signed off on its merger are not active AFAICT.

> The kernel doc mentions Andrew Morton as last resort (added to CC):
>> You should always copy the appropriate subsystem maintainer(s) on any patch to
>> code that they maintain; look through the MAINTAINERS file and the source code
>> revision history to see who those maintainers are. The script scripts/get_maintainer.pl
>> can be very useful at this step. If you cannot find a maintainer for the subsystem you
>> are working on, Andrew Morton (akpm@linux-foundation.org) serves as a maintainer
>> of last resort.
> source: https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Yes, Andrew can merge it.
Or possibly Jason (also Cc-ed).

thanks.

-- 
~Randy
