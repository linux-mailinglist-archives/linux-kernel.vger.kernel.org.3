Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C73F4BA779
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 18:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243892AbiBQRuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 12:50:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243882AbiBQRum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:50:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44167291FBF;
        Thu, 17 Feb 2022 09:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=tZJd3tUWhWrXachupZO/hQmGz5iMArfFv79ZqSbFeZg=; b=PXx/Y/rkGTPIlS8rx5n4plDFJh
        6FvIy8xg53sE3BkpYnDgcUCjB9WHxxOWYIwO2oqrutIPV1r1nmsHf0vaJKo2gP5YOrUbyQX8YEnLE
        05eJCaUsIo/vw5cvk71xlvcf/1t8hth3+ajFXuMdsyYoDZhKSwK27vlqGqW1Ca2iWEwZ5GeYZaiiD
        gPSxwUFTYBRRSu7pxNQIDReIJpeeP8rk+UMJPzw+A96CPOplkrsF55b4P0K45UJlFcobBQuTkSD0D
        bSUy537cIyRZrxYJGgn6VYCc5H8c2zMUxd3h6cK8EiYVxmbpUvDESMtdoxUQz4szjQsy0bqzxl5v7
        xwEjal8g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKkvB-00Fods-2u; Thu, 17 Feb 2022 17:50:25 +0000
Message-ID: <f30311b5-1b30-ed79-ca66-4359a8f9586b@infradead.org>
Date:   Thu, 17 Feb 2022 09:50:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC] scripts: kernel-doc: Major kernel-doc rework
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?VG9tYXN6IFdhcm5pZcWCxYJv?= <tomasz.warniello@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220205233945.7a4d22d8@fuji.fritz.box>
 <8735ki2x62.fsf@meer.lwn.net> <20220217163247.03e37c9b@fuji.fritz.box>
 <87bkz51l2g.fsf@meer.lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87bkz51l2g.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/17/22 09:04, Jonathan Corbet wrote:
> Tomasz Warniełło <tomasz.warniello@gmail.com> writes:
> 
>> I will prepare the POD part. As for the rest, you will need a porter if you
>> decide this is the way to go. I could help with explanations if something is
>> unclear and as long as the questions come soon. The winter is almost over and
>> I need to switch to other activities like earning money.
> 
> Understood.
> 
>> I understand. I didn't know there was a rewrite. I'm not into Python, but
>> if you could post a link, I'd take a look out of curiosity.
>>
>> If the community prefers Python, what can I say about this? Their choice.
> 
> This is the kernel community you're talking about - saying that it
> prefers any language (except possibly C) is asking for big-time trouble
> :)
> 
> *I* prefer Python, and the Sphinx side of things is necessarily in
> Python, so I'd be happy to see kernel-doc move over.  That said, others
> certainly disagree.
> 
> Markus's work was here:
> 
>   https://lore.kernel.org/lkml/1485287564-24205-1-git-send-email-markus.heiser@darmarit.de/

I can barely modify Python script, but I think that this would be a good move overall.
Then I could learn more Python.

> At the time, we were just trying to get the RST transition done, and
> swapping out the kernel-doc script seemed like a major distraction that
> we didn't need, so this never got looked at as seriously as I would have
> liked.
> 
>> Personally, I'd rather play with translating this script to Raku (aka
>> Perl 6).
> 
> Trying to add yet another language dependency is another path to
> unhappiness, we're not going to go there.


-- 
~Randy
