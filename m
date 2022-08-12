Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B837C590C00
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 08:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237215AbiHLGb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 02:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHLGbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 02:31:24 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B8F6EF3B;
        Thu, 11 Aug 2022 23:31:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VM0V5ZR_1660285871;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VM0V5ZR_1660285871)
          by smtp.aliyun-inc.com;
          Fri, 12 Aug 2022 14:31:13 +0800
Date:   Fri, 12 Aug 2022 14:31:11 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Huacai Chen <chenhuacai@kernel.org>, Baoquan He <bhe@redhat.com>,
        Zhang Boyang <zhangboyang.id@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>, song@kernel.org,
        wei.liu@kernel.org, jszhang@kernel.org,
        Guo Ren <guoren@kernel.org>, xiang@kernel.org, chao@kernel.org,
        ming.lei@redhat.com, Waiman Long <longman@redhat.com>,
        wqu@suse.com, yhs@fb.com, haoluo@google.com, decui@microsoft.com,
        Yanteng Si <siyanteng@loongson.cn>,
        Dave Young <dyoung@redhat.com>
Subject: Re: [RESEND] Please consider name next Linux release "I love Linux"
 (Re: Linux 5.19)
Message-ID: <YvXzr11YP6uwzT0n@B-P7TQMD6M-0146.local>
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
 <61d77412-af1a-5b00-9754-f156b1c63a74@gmail.com>
 <20220812023950.GF373960@MiWiFi-R3L-srv>
 <CAAhV-H7tCsyyNgDJWE5qDCXadF+V6k3GtZtf_yLVj6BZiPND2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H7tCsyyNgDJWE5qDCXadF+V6k3GtZtf_yLVj6BZiPND2Q@mail.gmail.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 11:28:12AM +0800, Huacai Chen wrote:
> Hi, all,
> 
> On Fri, Aug 12, 2022 at 10:40 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > Hi Boyang,
> >
> > On 08/11/22 at 10:02pm, Zhang Boyang wrote:
> > > Hi,
> > >
> > > On 2022/8/1 05:43, Linus Torvalds wrote:
> > > > (*) I'll likely call it 6.0 since I'm starting to worry about getting
> > > > confused by big numbers again.
> > >
> > > Could you please consider name the next Linux release (5.20 or 6.0) "I love
> > > linux" ? The number "5.20" is a wordplay in Chinese, which means "I love
> > > you" [1], thus "Linux 5.20" can be read as "I love Linux" in Chinese.
> > >
> > > Even if next kernel version is 6.0, I think it's probably a good idea for
> > > both Chinese-speakers and non-Chinese speakers to express our love to Linux
> > > Kernel.
> >
> > Interesting idea, LOL.
> >
> > Yes, 520 means 'I love you' in chinese since it has the similar pronunciation
> > with '我爱你'. I even don't remember since when May 20th becomes another
> > holiday similar to Valentine's day in China. While I have complicated feeling
> > about 520. It means on each May 20th, I also need prepare gift for my wife. I
> > am not a romantic person, preparing gift to lover is always a torture to me.
> > So almost each May 20th day, Valentine's day, double seventh festival which is
> > a traditional Valentine's day, I will become nervous, and it ends up
> > with a satisfactory gift, or a bunch of flower and a digital red envelope with
> > 520￥ and then complainment and blame in next two weeks.
> >
> > So, for naming next release as '5.20', I will vote for it w/o hesitance. No need
> > to prepare gift, and can express our love to Linux kernel, it sounds
> > awesome.
> >
> > Meanwhile, I would remind people to take it easy. Whether the suggestion
> > is accepted or not, it doesn't impact the fact that linux may have
> > become part of our life, not just our work, considering many kernel developers
> > are workoing form home. But if you have boasted to your girlfriend
> > or wife, and want to take this as a gift to her, you should try harder to
> > convince Linus.
> >
> > Thanks
> > Baoquan
> Frankly, I agree with Boyang and Baoquan. :)

+1, I'm fine with either approach.  If there is a 5.20 version, that is
fine.

The traditional Valentine's day of China is `Qixi Festival` which is the seventh
day of the seventh lunisolar month on the Chinese lunisolar calendar [1].

There are also other somewhat special days in China such as `Programmer day`
(Oct, 24 each year), yet I'm not sure if anyone out of China heard of it.

Personally I think 521 (yi vs ni) sounds more similar to "我爱你" in Mandarin
Chinese and who knows how many special days for couples -- since I'm single. ;)

[1] https://en.wikipedia.org/wiki/Qixi_Festival

Thanks,
Gao Xiang 

> 
> Huacai
> >
> > >
> > > The name of Linux kernel release has a long history of play-on-words [2].
> > > For example, 5.15 is named "Trick or Treat" and 5.17 is named "Superb Owl".
> > >
> > > [1] https://en.wikipedia.org/wiki/Chinese_Internet_slang
> > >
> > > [2] https://en.wikipedia.org/wiki/Linux_kernel_version_history
> > >
> > > Thanks and regards,
> > > Zhang Boyang
> > >
> >
