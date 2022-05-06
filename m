Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8646151E021
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 22:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442840AbiEFUbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 16:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350446AbiEFUbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 16:31:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ADF6A057
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 13:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=czAlBvzGbZIiieZ5UZZ63q2z8wPsspdCeY3abw324QU=; b=ZCoAnbkwYBTgxOM2i5+SxhF0oT
        FjXaIuDh2A5i3qdLrLLaVeBi4fAYf2XUkvVjf5Fqqng9Wd2mzAFGxjhKxiYVynmSFrM9OkeOsnec+
        Q040G62RwaJ+WAyvWAZKeByECdQXYXST4ApnbByxHL0G2UFCofCqm8rsiCpLTosfwtDRfr/oJD9Ps
        r9rhes/DokrlBWml28xl5hr8ZUfrB/ENFIgdn8+DOOchjK52C7UlEjk7j//pVLJXsrtXj85CeX88/
        Nxv+OIpOxEUvrntlU3lvVhM2/byLSiLycG6qFQBWkx7GByOshunAw+WRBvIH13g3Wt0AuRLk+JNo5
        8cLzFr+g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nn4Xl-00BlIL-1g; Fri, 06 May 2022 20:27:17 +0000
Message-ID: <056303ce-1837-4d1e-a9fb-3e20e3686d59@infradead.org>
Date:   Fri, 6 May 2022 13:27:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/3] block: remove last remaining traces of IDE
 documentation
Content-Language: en-US
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
References: <20220427132436.12795-1-paul.gortmaker@windriver.com>
 <20220427132436.12795-4-paul.gortmaker@windriver.com>
 <87wnfaa8ce.fsf@meer.lwn.net> <20220427165917.GE12977@windriver.com>
 <YmsmnGb3JNjH54Xb@equinox> <20220506153241.GH12977@windriver.com>
 <YnVgxEcRTQPu/DHE@equinox> <20220506202434.GJ12977@windriver.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220506202434.GJ12977@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/6/22 13:24, Paul Gortmaker wrote:
> [Re: [PATCH 3/3] block: remove last remaining traces of IDE documentation] On 06/05/2022 (Fri 18:54) Phillip Potter wrote:
> 
>> On Fri, May 06, 2022 at 11:32:41AM -0400, Paul Gortmaker wrote:
> 
> [...]
> 
>>> Are you working off linux-next?  If not, what is your baseline and what
>>> are you running and what do you see?  For example, the commands below:
>>>
>>> The ecb86 that I sent in this e-mail still applies on linux-next of
>>> today which contains Jens next as you can see:
>>>
>>
>> I was yes, the point I was trying to make (poorly) is that your patch
>> conflicts with Randy's patch which itself is not yet in linux-next, as
>> normally I send everything together at the start of the merge window to
>> Jens, as I don't have my own kernel.org tree yet, and usually I only get
>> one or two patches in a cycle anyway.
>>
>> This is not your fault, you couldn't have been expected to know this in
>> retrospect, and I should probably look into getting my own tree/GPG key
>> sorted to alleviate this problem in future.
>>
>> In the meantime, if you're comfortable with the idea, I can just resolve
>> the conflict myself when I send the patches onto Jens this time and
>> include patch 3/3 pre-fixed up. Merge window will be fairly soon anyway.
> 
> Sure, go ahead - just fix up things so all the last bits are gone; don't
> even worry about patch attribution; I don't care about that.

Thank for the cleanups, Paul.

-- 
~Randy
