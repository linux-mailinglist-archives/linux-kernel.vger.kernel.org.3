Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208B85A53D0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiH2SNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 14:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiH2SNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:13:40 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE3790190;
        Mon, 29 Aug 2022 11:13:39 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id i7-20020a17090adc0700b001fd7ccbec3cso5395418pjv.0;
        Mon, 29 Aug 2022 11:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=jfFWiU561O7uKuC2cJVMX/HT/7uH4m9j1QExSkrFTSM=;
        b=DdypRuXPfkr/UW67eTRllnfaXmefE7CC1RQVpJY14/xmiC1rMZDU7rcW5OnWCSx5w8
         Vzph05zpNRr4VrNrIprDIlYlKfkon4Ym1Ahq79ExCIKJO4L3QhutSfa0Jm70SvNKf3QW
         +XYikw0N9J9CPVeueczV4gkr1peAwonyBmX7sAO37UvnVMgYoSnnX84s+vQkeWcwNilu
         k17jhjSZ4zhBefnWzSiOBp0/vX7flNG1+qINFGnUEuar3HZ5+ebSWznEA+3nCRnCtxr8
         MDojFe3mIb+izeCjM+ivcJuNkiFtxkruUXPwp+7WMVCSX2jVeKEGUQUNU4rj0DR1Uh03
         xNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=jfFWiU561O7uKuC2cJVMX/HT/7uH4m9j1QExSkrFTSM=;
        b=HeAwVUhKwOpXoSPuggujTEWGC2wzJ6c9JDmPdp1i2fe9c3KTMWWSy00VCACHpfS6QB
         pLYqafefw2Gw871J2msm4j7YCMo6f/ndu0T34csFbq+A3IkG3gIUZqtzyF/edjY42hmk
         OJHyURlsf39brRE6LkAhHst3o13A3i9gG0RKXtzd025tStfPpbl6nroXIWpFHyRCxZ1A
         RXu8/igKB8QWIHB69YSzlM10x1Z8LASfQsYwOGlZd1+rorWXxFk2ESw4I9JMLghua/3n
         j8k3ERkvb6pJNbjLAor/k1YtxgCYuo+LOt9tCcr41DWKXOTM5QV4cKej1fZBHcZQOTb7
         xd1A==
X-Gm-Message-State: ACgBeo11zYqJsdDk7hhKhl5AzP6cYMKx3BaSz+i4zodhPSB2zI8F3axZ
        2joc9KXc6UOHPesAhm7aObI=
X-Google-Smtp-Source: AA6agR6b0oQKAtOmG4Aa2PNOXvcYHKxxtirCQUq2ZUUe5hh45PHjw3p4KDcZv7VkusmNhw/ZjTDAEg==
X-Received: by 2002:a17:902:eccd:b0:172:cff9:5796 with SMTP id a13-20020a170902eccd00b00172cff95796mr17133082plh.151.1661796818826;
        Mon, 29 Aug 2022 11:13:38 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a95a:58fc:2b39:1c99])
        by smtp.gmail.com with ESMTPSA id o1-20020a17090a168100b001fa8b909ef0sm6996830pja.7.2022.08.29.11.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 11:13:38 -0700 (PDT)
Date:   Mon, 29 Aug 2022 11:13:35 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Greg Tulli <greg.iforce@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [Question] iforce_serio lockup
Message-ID: <Yw0Bz9+ukNAf2Hpk@google.com>
References: <CAKEH-64YKTnb444AZsgm0MudN=KMM_EWv8SsNUwZGh9OGm4ayA@mail.gmail.com>
 <20220828090509.2839-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828090509.2839-1-hdanton@sina.com>
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2022 at 05:05:09PM +0800, Hillf Danton wrote:
> On Fri, 29 Jul 2022 21:24:13 +0200 Greg Tulli <greg.iforce@gmail.com>
> > 
> > Chain exists of:
> > &iforce->xmit_lock --> &port_lock_key --> &serport->lock
> > 
> >  Possible unsafe locking scenario:
> > 
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(&serport->lock);
> >                                lock(&port_lock_key);
> >                                lock(&serport->lock);
> >   lock(&iforce->xmit_lock);
> > 
> > *** DEADLOCK ***
> > 
> > 2022-07-11 11:32 GMT+02:00, Greg T <greg.iforce@gmail.com>:
> > 
> > > That problem vanishes if we don't call iforce_process_packet directly
> > > from iforce_serio_irq, but from a tasklet. Is that a right approach?
> 
> Another option is to do wakeup without serport->lock held,
> given iforce->xmit_lock. Your test will provide info about the races
> that may come up due to the serport->lock.

No, I think we should use work to process the outbound buffer/queue,
as the comment in include/linux/tty_ldisc.h recommends. I believe a
single work instance in struct iforce_serio will suffice:
iforce_serio_xmit already should be able to handle concurrent
invocations, so we just need to schedule the work from
iforce_serio_write_wakeup() (and it is fine if it is already scheduled)
and let iforce_serio_xmit() do its job.

We can wait for the buffer to empty (which should take care of the work
running, but we may also do cancel_work_sync() for a good measure) in
iforce_serio_stop_io().

Thanks.

-- 
Dmitry
