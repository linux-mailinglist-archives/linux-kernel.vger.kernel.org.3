Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE4D51D28B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389699AbiEFHvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389702AbiEFHvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:51:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5F067D03
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dqV06l9hyml70u6UYDDgGXk07kcMwhP5UCiNm6H86Lc=; b=gv7CEenGPb4KIXLZVg3FkA2C+9
        G+MPvDn3sOs+kfvZs3KIgb7lVKdSejpQB+a6LWpFu1wk1Ni47tYFOuUfyH0vQExHg02D0KznoKwqc
        QSHHe489/+scSHH4fS286+Y87iA6vnp0e46TNIZdJeMTCTXA1Iay3qCwQE6s+qywPS4/Rzf+Bv0Xu
        3CfWg6zxA5XECoQUW9lpYV+xx3wAD0J8vxur5YGXQjRv0j5EfrZPoGiQSvD5Q0JKMcvii/Iao9axd
        7nkXZ43nRWZRYz+9D0rE9QPvJvzbk6WkY4wSdCAaUfVFiCoc7r0AokQvmkVB6w0jrapu+WuUh5phu
        NtfxX4Tg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmsgk-00Bbr2-Ec; Fri, 06 May 2022 07:47:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64582980E75; Fri,  6 May 2022 09:47:44 +0200 (CEST)
Date:   Fri, 6 May 2022 09:47:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jing-Ting Wu <jing-ting.wu@mediatek.com>
Cc:     tglx@linutronix.de, valentin.schneider@arm.com, bristot@redhat.com,
        wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Jonathan.JMChen@mediatek.com,
        Chris.Redpath@arm.com
Subject: Re: [Bug] Race condition between CPU hotplug off flow and
 __sched_setscheduler()
Message-ID: <20220506074744.GH2501@worktop.programming.kicks-ass.net>
References: <6013fb81cdb18892b75c796ab0e6756ee0e9cf71.camel@mediatek.com>
 <a34049745934652483e3958e0a030a45b6fcfb40.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a34049745934652483e3958e0a030a45b6fcfb40.camel@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 12:19:28PM +0800, Jing-Ting Wu wrote:
> Hi all
> Add Chris for status sync.

Please try another posting, that's eminently unreadable garbage due to
line wrapping.
