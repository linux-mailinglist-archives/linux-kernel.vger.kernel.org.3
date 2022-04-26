Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B6F50FC3A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349657AbiDZLvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346506AbiDZLvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:51:33 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131A538DB8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 04:48:20 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.94]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MuluP-1nzscW3cgN-00rptO; Tue, 26 Apr 2022 13:48:07 +0200
Message-ID: <4719fce9-4235-f1d7-f95e-67e5a47a0968@i2se.com>
Date:   Tue, 26 Apr 2022 13:48:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v9 0/6] Raspberry Pi Sense HAT driver
Content-Language: en-US
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Charles Mirabile <cmirabil@redhat.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Serge Schneider <serge@raspberrypi.org>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        fedora-rpi@googlegroups.com, Daniel Bauman <dbauman@redhat.com>,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
References: <20220419205158.28088-1-cmirabil@redhat.com>
 <CANiq72n1gBE+tv3oAF4wjdK2jEJJmU4V=Y1CTZ1PpCEeqLbo9g@mail.gmail.com>
 <CABe3_aE-nQzZazLfxk1OnCNRF0sDqcWi6gieYSf4O4aYS_Ahog@mail.gmail.com>
 <06e0138a526f1fd9fe5b18184163c1ff98f0103b.camel@redhat.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <06e0138a526f1fd9fe5b18184163c1ff98f0103b.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:j757HjkwEM2RAj4rRTaWKm/gO6O5Oa6SilqOmn2fBevQYeQqjAE
 1uzxPs3Ps2MzPghvwU6bWqVQOGk6jjAl3iItIiXnHIorak7h9zQ71pF5hmy5BFmuvqwC1B7
 chl2Z0TwQ9ao7Fngr/SgTuYun41y1w5WH5Kqa15LyO2tiFtEpfhZni9J+8aDWThYRDYvmHI
 bENi28gwFa26BAdE2Th+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ONPCkDqewB8=:xGUiE0EPGmj80rc04tRVaj
 7MxZckTL9Te9JI5u1dCzSQh41owacI2G3dSxL3tiI8gBBwKk6ZQ1Ve11gZ0G7L3R1mVNbG+g2
 q8oaEKKOT8KMfEZFGtuugH3EoA7qSwmxNGWBO8BhAyn+cz2rqTSL7nGYPJd5Fi+Kcan75Ty+o
 8FqMlYZ/wsnOfdQIZCj6k5YW6IY9IR+AuHxkn3Z4mYZgnyG0xY/lDMR6itneivUT2LrKKdgRn
 OcDZTwGcdp4OK/k+TOAQmdJhX9E2N10FSaPCx6utNXWXP+6ekizlfTB/Qdg9HRCJOmgLuVmev
 rm8EROuVF3dBMk7ao247+pgxY+48ZqRfekgAgofcdOlLGfPpGVEZiqWCbNHdqMdojPAcXIJ6c
 hlsFYx+Lk0D700zdGB9ilUNOW2BzDaBJmVYNbo+z40fY55rU5PgyiLI8mPkpxJLass8fMF9DO
 yRNrN2DAaXpc0uW8uP0p9eHXqy6l/DKfHg1Y+Hx4gKQR3Ak2ORNsy8RkHZIBJ6PhuVq06H0Kh
 SWKFNtCICLiLNpTCHNqOv/8W8ZhHNRCgUrAol0h/FPJxLWqnWrxrNLuVc7XvemTHFldgsamnC
 y5D4iXzFB4kz9Hk5EzvpMKVSsRkE1RuCt0RonOv/MaxV+qw5KchNcdpXKYR0ExIu0YACwMq6d
 DWIN/L//xz8A8S6624g0wVrS7oBcwXnuoI0Gw2rRkrRh4YMD//6og4XtqPNvmVqSGmelmiTks
 CI7tJQ/Xy4k8GxNZ
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 26.04.22 um 12:18 schrieb Nicolas Saenz Julienne:
> Hi Charles, Miguel,
>
> On Mon, 2022-04-25 at 19:34 -0400, Charles Mirabile wrote:
>> Hi Miguel—
>>
>> Thanks for your help in reviewing this patch. I think all of the feedback is cleared up.
>>
>> I am not sure which tree this should go into, but maybe the Raspberry Pi tree maintained
>> by Nicolas Saenz Julienne (git://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-
>> rpi.git)? What do you think? Thanks!
> Since there is no code dependency between the different drivers/patches I
> suggest for each patch to go through its respective maintainer tree. Also, if
> we were to move the whole series through as single tree, it's important to have
> ACKs from all the subsystem maintainers.
Yes, we still need a Ack of Rob for the device tree bindings. Please 
give him the common 2 weeks for a review.
>
> I'll do a last review during the week.
>
> Regards,
>
