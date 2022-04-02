Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AED54F0568
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 20:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244981AbiDBSdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 14:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiDBSdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 14:33:07 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792A521809;
        Sat,  2 Apr 2022 11:31:14 -0700 (PDT)
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MXXhv-1nW8CN2sud-00YxDO; Sat, 02 Apr 2022 20:31:12 +0200
Received: by mail-wr1-f52.google.com with SMTP id b19so8553791wrh.11;
        Sat, 02 Apr 2022 11:31:12 -0700 (PDT)
X-Gm-Message-State: AOAM5319j6kWjF5/v3am3fkZ/D+hDKh5bbIW7eksoqUsTNPierwopnXx
        y9Z29B/ZdCL1TVrpUqLgaGkbstVX9sh7SoAXbS0=
X-Google-Smtp-Source: ABdhPJxXeRBLN1ONxP6bjTAJFl4VK2LisOlNtuuiDZwD1HmyapvUcRapW/HdMhWyARa4Q7Topnt9ATX3Riix9x+xc68=
X-Received: by 2002:a5d:66ca:0:b0:203:fb72:a223 with SMTP id
 k10-20020a5d66ca000000b00203fb72a223mr11517977wrw.12.1648924272343; Sat, 02
 Apr 2022 11:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220321165049.35985-1-sven@svenpeter.dev> <20220321165049.35985-6-sven@svenpeter.dev>
 <CAK8P3a2VgrWHerXTX4_wS8UU7fpN9-JZ5xESaWrr-WGYqGty=g@mail.gmail.com> <3166b80d-d8a6-45d5-9e3b-2f9998aca0d3@www.fastmail.com>
In-Reply-To: <3166b80d-d8a6-45d5-9e3b-2f9998aca0d3@www.fastmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 2 Apr 2022 20:30:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1=Q7JSBLOmxZxGArUx+3Ex8SjDx7Z5csms5k+_yES9zA@mail.gmail.com>
Message-ID: <CAK8P3a1=Q7JSBLOmxZxGArUx+3Ex8SjDx7Z5csms5k+_yES9zA@mail.gmail.com>
Subject: Re: [PATCH 5/9] soc: apple: Add RTKit IPC library
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        Marc Zyngier <maz@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:lvDJJbjN0pkxrwEZ0rhM+kJtjSIYljW0mLHlIlnog5Bgc8qmWA3
 9p2Ugkrag/2XVf0s68xp4q5iRmYZT3w5hIqB5AYLAUjICla2tmhSKJSi8XIRmyNsMc4yNJ9
 49SO2fwaPEgNIW7l1NLvwEhGqm4m/iH0ONCpOTX2Os5GW1UcEmN4SMNhdc+aOwwvfdGrtO8
 EtoCFsowTj/I3WEHQozbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eR2O3ZL9wiE=:dEjxpD1zZgLViDkpqbQ8Jo
 HM3ofhCIxlDCjegz8mvTSMtlThRkMmhbGG4T/S863lpLxI9oXqo+vFZfcL7dMwknQCOoSdLTQ
 ts7X7TYHgM8P1saZ++Lh0ElCSjNv63ae1cX1Ns4j3CogxHEAU7I7v0LYFIfV+q1eq6AU3QG/D
 Xnvy6ARU01j8jsDzL6cjpkJgU0VU6GZ+kBk9OZhpiO1EBCSp6o2QCCUvYPub5ahuzgFYMGKJz
 dSJyERE5R3WRlkocHABIfsrTsAHPoTsq0ROOBb2ux9nt+rjWYvWkPsmq3XxXUHkEdAQbnVxRC
 VRODgCaDZPJZfxA8+12ZSh4BumnLTf4kzcGwLTlgNGKpNiRR3Tuae0MIQc1cEE4/ey9Ua00+t
 924n+xynOeQL0Z6NMKRTgk0/4Q20TRCmKykkNQL4CQ/tDytmGzmHZV5uBP9vyYIqEauFY9P2v
 wuoDgQ2DOe9b7boAr/Cg/2gtUVmov0QZNZ+ObcgD3OJjus1QXsOeER+CxCdRCCNi9uwZyDmR+
 bzd4tD552kpGPq7p4u1qqIc1NLC9wa5F+34xdo9QqAmBg6FvreI6Yxzsltv3tBNjy5LPLiL6u
 QM/Z546molSRCb7fRz6ixTlvhL/DaivJUYAJieZgSey92ar2p0NwezsgPcRfl2YD/WsxCk9/q
 /pxioLFDv6In49wOhsOR1rMr/2TSFQCFLp6NugOX8H9sYlHolQ3YIEIBxMV3y8FNGw6k=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 2, 2022 at 2:56 PM Sven Peter <sven@svenpeter.dev> wrote:
> On Tue, Mar 22, 2022, at 14:13, Arnd Bergmann wrote:
> >> +static int apple_rtkit_worker(void *data)
> >> +{
> >> +       struct apple_rtkit *rtk = data;
> >> +       struct apple_rtkit_work work;
> >> +
> >> +       while (!kthread_should_stop()) {
> >> +               wait_event_interruptible(rtk->wq,
> >> +                                        kfifo_len(&rtk->work_fifo) > 0 ||
> >> +                                                kthread_should_stop());
> >> +
> >> +               if (kthread_should_stop())
> >> +                       break;
> >> +
> >> +               while (kfifo_out_spinlocked(&rtk->work_fifo, &work, 1,
> >> +                                           &rtk->work_lock) == 1) {
> >> +                       switch (work.type) {
> >> +                       case APPLE_RTKIT_WORK_MSG:
> >> +                               apple_rtkit_rx(rtk, &work.msg);
> >> +                               break;
> >> +                       case APPLE_RTKIT_WORK_REINIT:
> >> +                               apple_rtkit_do_reinit(rtk);
> >> +                               break;
> >> +                       }
> >> +               }
> >
> > It looks like you add quite a bit of complexity by using a custom
> > worker thread implementation. Can you explain what this is
> > needed for? Isn't this roughly the same thing that one would
> > get more easily with create_singlethread_workqueue()?
>
> I originally had just a workqueue here but I can only put
> one instance of e.g. APPLE_RTKIT_WORK_MSG onto these.
> There could however be a new incoming message while the previous
> one is still being handled and I couldn't figure out a way
> to handle that with workqueues without introducing a race.

Are you trying to avoid dynamic allocation of the messages then
and have no other place that you can embed it in?

If you kmalloc() a messages that embeds a work_struct, you can
enqueue as many of those as you want, but the allocation adds
complexity through the need for error handling etc.

I wonder if you can change the mailbox driver to use a threaded
irq handler, which I think should ensure that the callback here
is run in process context, avoiding the need to defer execution
within the rtkit driver.

         Arnd
