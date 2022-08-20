Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC8959AA6E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 03:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244950AbiHTBRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 21:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiHTBRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 21:17:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3807F260;
        Fri, 19 Aug 2022 18:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=AUTHFix9jNIqY9vcL1qz0lK6YNEyAaS0zQ4JNLB0z7c=; b=MZWcsFD1TYR5KoEoE0VPUvu/z1
        viJVdtxxTXoEN4JsHfyp0CEkSDqV8SsHLdr5l2CN14djt9Yj4uzJjV3Lrbo1dXHvyNGFhl1aJaCAo
        /7MYIiO6Ip9kDG34GLt9gX2D9HJkx1eFb63SogdUpn03/UTOZpiKZRj0MCkDPPUu+16xrqWD87Yrc
        bfuvYuiFlPrCv2V2OS2FveH0xo22m5IwaWX95oph76XuQXqj24QqoBwDoaWLJND8Ir8ibJsQZESzk
        Iik2guX+OQ0sFTMb5k1nK1wXV/vSUsUzuQEjJPWzqYfKGHM9EJcE/zMvJ8dRRNUdSgwCSEFjO63R5
        CbrDjhmg==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oPD6v-00EOcs-4z; Sat, 20 Aug 2022 01:17:13 +0000
Message-ID: <66a14f79-18ae-5b5c-4540-0718ff5e93d7@infradead.org>
Date:   Fri, 19 Aug 2022 18:17:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: linux-parisc compile failure in current git
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Helge Deller <deller@gmx.de>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        Meelis Roos <mroos@linux.ee>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <892b6ab7-862c-1c0a-2996-0f8408e5043d@linux.ee>
 <89515325-fc21-31da-d238-6f7a9abbf9a0@gmx.de>
 <CAK7LNATuzry1MUj-VruOVUwU_nH2xJd_2SxD_s_Z1QBb3PVnQw@mail.gmail.com>
 <5dfd81eb-c8ca-b7f5-e80e-8632767c022d@gmx.de>
 <CAK7LNATO_30uHzAe-Vsy+hgu=wwEN_aPGET4Ys78rc3=nSuJsg@mail.gmail.com>
 <YNOafsB81ZcP2r7z@ls3530>
 <f599c358-815f-088e-f2aa-b064ccb64e44@infradead.org>
 <CAK7LNAREcSW2Hn3Ty_zTVzTCLgYnFfo=ZcibE2zif1mBWp==4A@mail.gmail.com>
 <39ee0ca2-48a0-755b-605c-3ce1205b9715@gmx.de>
 <CAK7LNAQceFhO1-vupRAJy3rU+p+MK97vRuswVXvVEgF7q0akDA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAK7LNAQceFhO1-vupRAJy3rU+p+MK97vRuswVXvVEgF7q0akDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/19/22 09:41, Masahiro Yamada wrote:
> On Fri, Aug 19, 2022 at 10:56 PM Helge Deller <deller@gmx.de> wrote:
>>
>> On 8/19/22 14:45, Masahiro Yamada wrote:
>>> On Thu, Aug 18, 2022 at 5:59 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>>

>>> Is this thread related?
>>
>> What thread?

It is related to ARCH=parisc64, but I probably should have
started a new thread instead of replying here.

> This thread ("linux-parisc compile failure in current git")
> was posted more than a year ago.
> 
> If you start a new discussion,
> let's open a new thread with a proper mail subject.

Thanks.
-- 
~Randy
