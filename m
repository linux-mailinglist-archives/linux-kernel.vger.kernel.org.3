Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A82590A57
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 04:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbiHLCkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 22:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbiHLCkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 22:40:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 215A8A263E
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 19:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660271999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rP+d+T5F3TAwnpBUpQyvERGjk1JOZEsX/wHajp2q8q4=;
        b=iLqYCHfvEFvcmG2fUVckaCbvdMImZCitZLE8+HBSfNAuMdH8ZmxtBnBkNp38DAD5mhfWHj
        lvPB4zSG5tdKC/w0IboU37tFBistIgprGKgLGVhZwnp28rx7jNhraVMrEX3b7ivzsssaDM
        xlZ6BVp2JljpqD9CdPvsIupZjoSIAqA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-JA6So7n0NEOUUmPydRS68Q-1; Thu, 11 Aug 2022 22:39:56 -0400
X-MC-Unique: JA6So7n0NEOUUmPydRS68Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1316E85A58F;
        Fri, 12 Aug 2022 02:39:55 +0000 (UTC)
Received: from localhost (ovpn-12-97.pek2.redhat.com [10.72.12.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2205B492C3B;
        Fri, 12 Aug 2022 02:39:53 +0000 (UTC)
Date:   Fri, 12 Aug 2022 10:39:50 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Zhang Boyang <zhangboyang.id@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next@vger.kernel.org, song@kernel.org, wei.liu@kernel.org,
        jszhang@kernel.org, chenhuacai@kernel.org, guoren@kernel.org,
        xiang@kernel.org, chao@kernel.org, ming.lei@redhat.com,
        longman@redhat.com, wqu@suse.com, yhs@fb.com, haoluo@google.com,
        decui@microsoft.com, siyanteng@loongson.cn, dyoung@redhat.com
Subject: Re: [RESEND] Please consider name next Linux release "I love Linux"
 (Re: Linux 5.19)
Message-ID: <20220812023950.GF373960@MiWiFi-R3L-srv>
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
 <61d77412-af1a-5b00-9754-f156b1c63a74@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61d77412-af1a-5b00-9754-f156b1c63a74@gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boyang,

On 08/11/22 at 10:02pm, Zhang Boyang wrote:
> Hi,
> 
> On 2022/8/1 05:43, Linus Torvalds wrote:
> > (*) I'll likely call it 6.0 since I'm starting to worry about getting
> > confused by big numbers again.
> 
> Could you please consider name the next Linux release (5.20 or 6.0) "I love
> linux" ? The number "5.20" is a wordplay in Chinese, which means "I love
> you" [1], thus "Linux 5.20" can be read as "I love Linux" in Chinese.
> 
> Even if next kernel version is 6.0, I think it's probably a good idea for
> both Chinese-speakers and non-Chinese speakers to express our love to Linux
> Kernel.

Interesting idea, LOL.

Yes, 520 means 'I love you' in chinese since it has the similar pronunciation
with '我爱你'. I even don't remember since when May 20th becomes another
holiday similar to Valentine's day in China. While I have complicated feeling
about 520. It means on each May 20th, I also need prepare gift for my wife. I
am not a romantic person, preparing gift to lover is always a torture to me.
So almost each May 20th day, Valentine's day, double seventh festival which is
a traditional Valentine's day, I will become nervous, and it ends up
with a satisfactory gift, or a bunch of flower and a digital red envelope with
520￥ and then complainment and blame in next two weeks.

So, for naming next release as '5.20', I will vote for it w/o hesitance. No need
to prepare gift, and can express our love to Linux kernel, it sounds
awesome. 

Meanwhile, I would remind people to take it easy. Whether the suggestion
is accepted or not, it doesn't impact the fact that linux may have
become part of our life, not just our work, considering many kernel developers
are workoing form home. But if you have boasted to your girlfriend
or wife, and want to take this as a gift to her, you should try harder to
convince Linus.

Thanks
Baoquan

> 
> The name of Linux kernel release has a long history of play-on-words [2].
> For example, 5.15 is named "Trick or Treat" and 5.17 is named "Superb Owl".
> 
> [1] https://en.wikipedia.org/wiki/Chinese_Internet_slang
> 
> [2] https://en.wikipedia.org/wiki/Linux_kernel_version_history
> 
> Thanks and regards,
> Zhang Boyang
> 

