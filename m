Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59F6510FD4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 06:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356497AbiD0EMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 00:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbiD0EMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 00:12:13 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AF1110560
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 21:09:04 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id c7so133302iob.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 21:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6f36O0QfVX8IlBdQOhsxrWReQb4S+7f88KwV9S0It40=;
        b=N6qGDC7jTI3ZHySeAbNs7R5B/unxbGHaxK9xCAThCqyyXgNe+ys/iA048vxOUTamBv
         Z7dVtuJ9cCCrTAQJlQUbZnyZIrIhAlMsXuxy7l1F5zV7uvUpbeNu1ldgBkrJb9CYXlbE
         KQVix72qIhbZWrQ0VQB7MUOUFEHk4GwOmjJF6qHx9AkVhP71xhp6tRfZZWKy0H2pE0V6
         ENghb21FD04Z4mMOXb/fWGEeKUDR8PdQ4Siyx42smwFTSFi+7G+X3GPcXhvWgOPSfsrM
         j1SKgz/8EJ6dponGeqhfEtMjXyGb7w7485Y/7iZac0Pw7oKKm+H9vYTbvwyN/dK0Ul1Z
         QReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6f36O0QfVX8IlBdQOhsxrWReQb4S+7f88KwV9S0It40=;
        b=u5SQUZbQLbOWcEbHxa6dzEMIwvLEUGYYPTBXbl6xfrCLAKUsW9vlsrcVFEcjfrPFKz
         oObQlNFUqR4DfPF7LfMujWrd0bCY3W96Ud13YqGCrSNeY8vLv/uzXvf6hD8HLd/Hc2Uu
         Uct6oaP00jnu/iJbQS3tf8wZTw1mMVRMkD8TCcBEgJZRxm2GeYqmJT5zivNO6FPB2NSr
         sN7tY88c92YvxF2ibbCs3w9wxk/ev7i/47y4F+0wLN655wgfCQRWQ6xQ3i+wcj9n/2H3
         Mf4eE7lem2M611l6ce6flSZ9HtBok4rLzGQgDyEGkYDw0Zs1//Ckrm2dk+ftOW9ii7j7
         MnTg==
X-Gm-Message-State: AOAM533ZDLPXAwRw2ur136y3KjUohuOwkT2jHAoXwYBFTmLfqJS7Xg1N
        v+ISMmr93wfe0B1plgxkN1XyiroyrIY2tR3eoQw=
X-Google-Smtp-Source: ABdhPJziikf+Dc+EUmvR67PeUKxcfPVaZH9t3OpvHJrqgH9YgQp6zkLEP8chzKQzRODK8F5LkUlMB10dFWiv8nSzmHs=
X-Received: by 2002:a05:6602:398b:b0:657:ab5a:ce2a with SMTP id
 bw11-20020a056602398b00b00657ab5ace2amr2222241iob.78.1651032543590; Tue, 26
 Apr 2022 21:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220425111232.23182-1-linmiaohe@huawei.com> <20220425111232.23182-4-linmiaohe@huawei.com>
 <20220425140711.0c1898862fc817135bbbc56e@linux-foundation.org>
 <6b74e6f3799032d4f12bae0d97a453dc85d03028.camel@intel.com> <5a108252-4eb8-e353-da3d-a96b8799fadf@huawei.com>
In-Reply-To: <5a108252-4eb8-e353-da3d-a96b8799fadf@huawei.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 27 Apr 2022 13:08:52 +0900
Message-ID: <CAAmzW4NV9_LiGsN3Qn3uv19ZLFn9zZ3hdLFy1HOgbec5Or0Ccw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] mm/vmscan: activate swap-backed executable folios
 after first usage
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Hellwig <hch@lst.de>,
        Oscar Salvador <osalvador@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

2022=EB=85=84 4=EC=9B=94 26=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 3:58, M=
iaohe Lin <linmiaohe@huawei.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 2022/4/26 10:02, ying.huang@intel.com wrote:
> > On Mon, 2022-04-25 at 14:07 -0700, Andrew Morton wrote:
> >> On Mon, 25 Apr 2022 19:12:29 +0800 Miaohe Lin <linmiaohe@huawei.com> w=
rote:
> >>
> >>> We should activate swap-backed executable folios (e.g. tmpfs) after f=
irst
> >>> usage so that executable code gets yet better chance to stay in memor=
y.

Missing activation for swap-backed executable page is the intended operatio=
n.
So, I disagree with this patch until some numbers are provided.
See following discussion.

https://lore.kernel.org/all/20200316161208.GB67986@cmpxchg.org/T/#u

Thanks.
