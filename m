Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD16596FC3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239904AbiHQNUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiHQNTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:19:48 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACDA80B66
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:19:16 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w197so15350997oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dUoIS1mdB9GBw/ZLFYLwzDX1Mo+0WQ2EGSC5YGDqW7g=;
        b=fZWmBcOSgJBzrVmHoPZFx1mA/LJ+dLkAt4yaMyZb6S7bX5jo128RdCKAYBSr0ajcwp
         sb0bKXYD6EfYAsM5enNs7mHIPSR2ek67PLB1QaTnpBIpqRt8AS+Nxx8BFbxnqd+rXR6c
         ioPV720gY2YxAE1vSQPrq8j5CaV9WKIdRHqo6oohs4lo7mvmPpDoc1H8h6fdvSk7U0NO
         vcYLllNVePMfQjowT8XYtuP9ZT+z5aGIEOe/IQfV+4XwEO2pgLGAXGTb51UVJd6mjHOi
         uXAGus9T/F7StM9xGnkFIRiEOQ1JzZA+fT7b8H4upXJ5tdzdTM9DM8RTvPehc9/UDea2
         hV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dUoIS1mdB9GBw/ZLFYLwzDX1Mo+0WQ2EGSC5YGDqW7g=;
        b=B7rIkSjOWLywXQ70UBwonklXryvd19Vq7qpEDC9k33HpSIezMgvrvBqx0hqOdfiDn3
         qzAf/2dVl2jUt3aJU8g19Nr0lZylJ69FeLPDTCdH5LJjmQYhDQB1P4AUKhZGFFVXsozP
         khyY4LmXv+TvvAqurM30BPPWk5P86MCcM1ua2X4m0ne7Dbj29bCZ4ZlUFWLnTIX3X4lw
         dYpaPaxMtGFlrkngVu7fxNowijrznhvp1Nie+hXo+gU6isy8adKlBFf2ygJpD9j5ZOnM
         81Qr5DG/Wdm4PKvDlXMwROqlVxbn4WJ5jpMmABHcVCxe95zXLap5D06zl6NaMFZzrSV8
         oBdQ==
X-Gm-Message-State: ACgBeo2Y+rxlvzYXO0DtCy0LMD9n7enLk6p90M6SLtFpiF3EyKZa5Wo9
        IBM+JAoM0Ozu6RzfOBwPkdXZUHAcEyL3rCl8Il61jw==
X-Google-Smtp-Source: AA6agR5CG0lvkM1VCXUjoacKsulh2GXq9RRCuleqhHVKvQ6hx5QH5M4s5yKqbr/gC52VCvpGdkkVZTDWRDWUgOyx54s=
X-Received: by 2002:a05:6808:1d6:b0:344:93c6:ec88 with SMTP id
 x22-20020a05680801d600b0034493c6ec88mr1388766oic.2.1660742354628; Wed, 17 Aug
 2022 06:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220816020423.323820-1-shaozhengchao@huawei.com>
 <20220815201038.4321b77e@kernel.org> <694f07e3-d5ad-1bc5-1cdb-ae814b1a12f7@huawei.com>
 <20220816111305.4851a510@kernel.org>
In-Reply-To: <20220816111305.4851a510@kernel.org>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Wed, 17 Aug 2022 09:19:03 -0400
Message-ID: <CAM0EoMkcOXNfd0dyoGeqGVqN1EQ5jHr_2BuWQoLUAyudsLwdRg@mail.gmail.com>
Subject: Re: [PATCH net-next,0/3] cleanup of qdisc offload function
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     shaozhengchao <shaozhengchao@huawei.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, weiyongjun1@huawei.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 2:13 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 16 Aug 2022 11:32:03 +0800 shaozhengchao wrote:
> > On 2022/8/16 11:10, Jakub Kicinski wrote:
> > > On Tue, 16 Aug 2022 10:04:20 +0800 Zhengchao Shao wrote:
> > >> Some qdiscs don't care return value of qdisc offload function, so make
> > >> function void.
> > >
> > > How many of these patches do you have? Is there a goal you're working
> > > towards? I don't think the pure return value removals are worth the
> > > noise. They don't even save LoC:
> > >
> > >   3 files changed, 9 insertions(+), 9 deletions(-)
> >
> >       Thank you for your reply. Recently I've been studying the kernel code
> > related to qdisc, and my goal is to understand how qdisc works. If the
> > code can be optimized, I do what I can to modify the optimization. Is it
> > more appropriate to add warning to the offload return value? I look
> > forward to your reply. Thank you.
>
> Understood. Please stop sending the cleanups removing return values
> unless the patches materially improve the code.

Quoting appropriate here.
+1

cheers,
jamal
