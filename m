Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96C9537876
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbiE3Jy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbiE3Jyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:54:55 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D816470379
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:54:53 -0700 (PDT)
Received: from [192.168.1.107] ([37.4.249.170]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MzR0i-1nZWsg40rQ-00vMSe; Mon, 30 May 2022 11:54:15 +0200
Message-ID: <69590289-58ef-d32b-0459-36fa00627605@i2se.com>
Date:   Mon, 30 May 2022 11:54:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: vchiq: Performance regression since 5.18-rc1
Content-Language: en-US
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Phil Elwell <phil@raspberrypi.com>, regressions@lists.linux.dev
References: <77d6d498-7dd9-03eb-60f2-d7e682bb1b20@i2se.com>
 <YoszE8lQ9VcofLtX@linutronix.de> <Yo41ggMvkI1B9TeM@fuller.cnet>
From:   Stefan Wahren <stefan.wahren@i2se.com>
In-Reply-To: <Yo41ggMvkI1B9TeM@fuller.cnet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:r+ADtDFbqXY818140nc+F8gIG28Nz1VhevBnDdrLMd7MaSkBizD
 KdE2mmQyEo9EeZHtC63h/WwzVF3428nDz1BAOLgF5h94I6QCW1dBI4uLM5m8rUd8h5Obkst
 3muxmf2kTrb3Yko5a9KehM+mTxjOk5CQyB8ytfNwQ1hyirAmQzQQ6mP5p94Ho1omDIWCscW
 WkKK8A0KhsEPpUqCMcR0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SzBOm+0D5lQ=:PK2pxYWDZLNiPfO51WKBNJ
 Ejdp9ND3c3zYyp16XAqUKBdSCt0xTNQY0hVMtVLDVw56LbOV3AVn2eiGoe/d1t2utOq8XCpkk
 OWmi0vCbmj9f1Zjbkh6UB+KvXg5uMpK9VmZKroctg79AGc+hGnH9EFrfg0LeQC2p5RoasZFgW
 rGzoAmggL+O/FrIGNcv5AhVuYYrzN0CHWfB2jTEOhreGKIkGe9K6m4ZfEK91ucsrUziHHOC87
 hKdRRJzBwVaYeXbY0LvZczSnEFJMkeUvNmdijsorT9mdIPGpzulJ1+t88P8QpvEJdyP9INRKQ
 6ZkbNjH1TQI01L6eHWj+2eDevbxSiVz7OmV0EyzCGlUPf87yoLADUnoJ4keniScVoR9JNHtFv
 NWsxh8WX4YxsAhmCiW9fX1cmVLRU4Y/EpTvyOJ5Ot0C3VVfLXR/I/rd8smSrKBX+7TLS/ZgaI
 LTt3fOlUivQRTJZQBc9AyVQqVNGNy/ysPBh/Wk4FQLcq2TIOWB21+hxV0SUNU8ymeqQkGyOTL
 pF5Hlu1EFilpUXVpiP8k2Qw6Tuig9vpqNhRcQfeQVtHvDtKW/QgK8E1Sgw7jTn70I3pSSSts7
 z0/4Orb9/e7xEUEG62PcRZ0WVdRYRy88UjUiVQzRDtsBn1atUOztuQA3OdeR24EngTCZ1kESQ
 0cuMQDvKF0TMaj3uxntqFzs/+xsNOThX6+dJIosDtVn2QLLGN1sU+oh4u/iqs+ooXVQjJ/92e
 pmYUXlPyPkJg947cspMt+O5AiDvqyd1Q6AOghKpD9fMuCm8tYNlNUOSUe4U=
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,
hi Sebastian,

Am 25.05.22 um 15:56 schrieb Marcelo Tosatti:
> On Mon, May 23, 2022 at 09:09:07AM +0200, Sebastian Andrzej Siewior wrote:
>> On 2022-05-22 01:22:00 [+0200], Stefan Wahren wrote:
>>> Hi,
>> Hi,
>>
>>> while testing the staging/vc04_services/interface/vchiq_arm driver with my
>>> Raspberry Pi 3 B+ (multi_v7_defconfig) i noticed a huge performance
>>> regression since [ff042f4a9b050895a42cae893cc01fa2ca81b95c] mm:
>>> lru_cache_disable: replace work queue synchronization with synchronize_rcu
>>>
>>> Usually i run "vchiq_test -f 1" to see the driver is still working [1].
>> What about
>> 	https://lore.kernel.org/all/YmrWK%2FKoU1zrAxPI@fuller.cnet/
>>
>> Sebastian
> Stefan,
>
> Can you please try the patch above ?

this patch fixes the regression. Great

Best regards

>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
