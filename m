Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488655A0A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbiHYHjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiHYHjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:39:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4817AA1D50;
        Thu, 25 Aug 2022 00:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=5mnLs7Y4Gk47LvAXvC/O24OQ7FRB6zlzOuskP6v5zy4=; b=wEPrqSQy5sJountzamcVS24FEQ
        wKvk8qbmQszXnkHNSLAGAAwW/i/VCHJiUPG5BhlISz6hEGrWxTSlbEXar20E86djAeXShIK41hkYP
        HFg2SbCaSxMEQQcglVP5GSzc/YmshCbDTT+EqPhiPVbpe3f+4eiuJcOEil7CzTLTZN+KQm4K+DXpL
        mZkMl1LoRc1/h+D8dI0G9pYoqI6ia7A1yXYZASNepZcPM4OWquyPG1uPgz5OqYGkMCxJrCBcbWipk
        ZG8rPiVEPZFfJTfnUY7KIWR42jM26GzanWo9FiH8965dZ1iyPW2QXhHdiQypYeCvIjI1bm7u4YlOd
        7PWwtVtQ==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oR7Sa-009PZe-3G; Thu, 25 Aug 2022 07:39:28 +0000
Message-ID: <59ae46dd-7fa3-a48f-58cb-a7a58d4e33ab@infradead.org>
Date:   Thu, 25 Aug 2022 00:39:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] docs: Update version number from 5.x to 6.x in README.rst
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <20220824080836.23087-1-lukas.bulwahn@gmail.com>
 <d5eca4a6-8a76-02e0-2f22-645341af8c2b@infradead.org>
 <CAKXUXMwLofvhBXqzdoq_q_89jZ8THU0WX=DY+RnCo=PN7QqspA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAKXUXMwLofvhBXqzdoq_q_89jZ8THU0WX=DY+RnCo=PN7QqspA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/22 00:35, Lukas Bulwahn wrote:
> On Thu, Aug 25, 2022 at 5:24 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>
>>
>> On 8/24/22 01:08, Lukas Bulwahn wrote:
>>> A quick 'grep "5\.x" . -R' on Documentation shows that README.rst,
>>> 2.Process.rst and applying-patches.rst all mention the version number "5.x"
>>> for kernel releases.
>>>
>>> As the next release will be version 6.0, updating the version number to 6.x
>>> in README.rst seems reasonable.
>>>
>>> The description in 2.Process.rst is just a description of recent kernel
>>> releases, it was last updated in the beginning of 2020, and can be
>>> revisited at any time on a regular basis, independent of changing the
>>> version number from 5 to 6. So, there is no need to update this document
>>> now when transitioning from 5.x to 6.x numbering.
>>>
>>> The document applying-patches.rst is probably obsolete for most users
>>> anyway, a reader will sufficiently well understand the steps, even it
>>> mentions version 5 rather than version 6. So, do not update that to a
>>> version 6.x numbering scheme.
>>
>> Yeah. And I suspect that scripts/patch-kernel is even more obsolete
>> than applying-patches.rst.
>>
> 
> Randy, would you know if there are still users out there?
> Would it help to replace this script with a minimal script that only
> reports to "Please use git to obtain a recent repository. Update
> versions and apply patches with git in a controlled way.".

I have no idea, but I haven't seen any comments or references about it
in many years. I think it would be safe to remove it, at least on a
trial basis.


> If someone complains, we revert the patch. If no one complains within
> a year or two, we could consider shutting down the infrastructure
> creating those patch archives as well, and delete the documentation
> referring to that.

Yes, something like that is probably in our future.

-- 
~Randy
