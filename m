Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FF755713F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 05:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiFWDDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 23:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiFWC7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 22:59:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA13E55;
        Wed, 22 Jun 2022 19:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=sIfzbNhL8TrtFD7HElGf5ZhPwJycPkd0im274TrYgOE=; b=UnLy5cTQ9sM5zeCyJZzL7KnkWc
        LhxMLklCHlYKiJrrXdupWsZKGXnFbZhYxYlgr9YBdgGDax6rz/IoYK7WIZV+rjNLdZxhrKFhr+801
        y83vdod1sbpRBgyA5iR6JfWp0JFYMzrvSjEljyj9To2MadknSDDVbgfWR64/wydYAfOSNWQ9Z2kyo
        l0DemHleTXJrCJOrjJ64mOHv3HUwlkFiikYhx/b/ryyd3u+lWw11VOuMQ7irm2/CLJc+GCLofGopK
        kCJBoK8mqZpk0gYDRVWWvJdZXNq7OIgDLYoe9UByOuqlgrsGGMBb8aC0eANBcRahGA39veVoQDwcs
        hne8NIzg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4D46-007YCQ-Es; Thu, 23 Jun 2022 02:59:30 +0000
Message-ID: <f174fa2c-40b8-af76-812f-0f3bb680b2da@infradead.org>
Date:   Wed, 22 Jun 2022 19:59:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] MIPS: Fix 2 typos
Content-Language: en-US
To:     Joe Perches <joe@perches.com>,
        Zhang Jiaming <jiaming@nfschina.com>, tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com
References: <20220622090713.24370-1-jiaming@nfschina.com>
 <d2112863-bd28-d6db-c353-1b7b94b45fcb@infradead.org>
 <37d560bc5267408eb9cc806339025418094cf5bb.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <37d560bc5267408eb9cc806339025418094cf5bb.camel@perches.com>
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



On 6/22/22 07:46, Joe Perches wrote:
> On Wed, 2022-06-22 at 07:28 -0700, Randy Dunlap wrote:
>> On 6/22/22 02:07, Zhang Jiaming wrote:
>>> Change 'modifed' to 'modified'.
>>> Change 'relys' to 'relays'.
> []
>>> diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> []
>>> @@ -282,9 +282,9 @@ union cvmx_helper_link_info __cvmx_helper_board_link_get(int ipd_port)
>>>   * support and should return the number of actual ports on the
>>>   * board.
>>>   *
>>> - * This function must be modifed for every new Octeon board.
>>> + * This function must be modified for every new Octeon board.
>>>   * Internally it uses switch statements based on the cvmx_sysinfo
>>> - * data to determine board types and revisions. It relys on the
>>
>>                                                       relies
>>
>> But it would be better to restrict this barrage (or swarm) of patches
>> to Kconfig help text problems and/or strings that are printed to users.
> 
> I believe fixing typos isn't a particular problem and is
> overall rather a good thing.

OK, I can agree with that.

> Though backporting these patches would be silly.

Ack.

-- 
~Randy
