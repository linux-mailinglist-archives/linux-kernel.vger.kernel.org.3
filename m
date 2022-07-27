Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9D25832CC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 21:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbiG0TDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 15:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbiG0TCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 15:02:43 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D7A10D6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 11:18:10 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 982905C0156;
        Wed, 27 Jul 2022 14:18:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Jul 2022 14:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1658945889; x=1659032289; bh=qIWv+ZMtF2
        lt0YMNEhnDHuA6uaYCrHAWKeY3aG5HYac=; b=bbkvSchrtgoiEmiUyW+gU6LRiA
        cwth1Swzn5uiGk0d6GYSbxGzJFbonJlgGXYlhfy7RmayejCE2GZ+YuxmiJ6SHpta
        INE7qCmHLhx7gUWt9RULcYoXNUnRK/mL628UH7g5sZv3I56lVyG9z5Ay2BOLx4GJ
        b6YSsPABvzgavQLs7FGnqKULr39OLAN66pNjyYIIfw3+8ZMVJhYm3XhaEZifKl7J
        t9Lic3Jt1xGF8X6gtPEorC2oJjLzAqQJmtYE4wphuhmVDDJM99uaUQ1o8xk3rMmn
        qynUjB7EQBOft7liFmV5uiT//2sNdA8h/QlHPCk5ACZJUqCqsaiMBqm+I5rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658945889; x=1659032289; bh=qIWv+ZMtF2lt0YMNEhnDHuA6uaYC
        rHAWKeY3aG5HYac=; b=sHaFahFVqjrOvnXYD16N4CO7W2Jjk+pJIgmKRg+tuF+p
        /lWhDoFM8bQvJ+S024rYP0bAXqa4CS9xNbCphJLvJf2uWjnKA/fg7baehYZqQZoK
        gzyJidGRPXmzAeeUXMHM4+S/CbFgOe6GUcv8HE2uai2/KSX8/ZizuhFv9LCZFiLZ
        uqm0Ulk5pc3AHJ6zs6gg1ElGkVWVDxNrc627GiGMcEabxvTTHFKWiVeF6FjaOIUg
        ca+fiyAu0hhVwNyCMkuNhhbqBKH2AYIQt+fZHqfqEz6hAyyuXs4G6sQrr+9+bsH7
        HUQLs3QVZlcV/zzuuU7lJm8i7KwzPdmxskCqiciuBg==
X-ME-Sender: <xms:YIHhYuO3eQEQ3S9If2f44cZL-sUM-DQZUjMb9GuZpFZXQswF6POmdw>
    <xme:YIHhYs9ZQ6N55PoF7BjMitgrUQGEjtpIPDiEokd1ShdgR4YiLSmLXFm3_l7XifUi4
    U4E3qvCpA2avhFntjc>
X-ME-Received: <xmr:YIHhYlSPkUo0rp9wLAbleT2t1zTz3IAi8sJc0Quw4MM55x7JlqyH1cf9eD2fpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduvddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigt
    hhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtf
    frrghtthgvrhhnpeelveduteeghfehkeeukefhudfftefhheetfedthfevgfetleevvddu
    veetueefheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhi
    iiiirg
X-ME-Proxy: <xmx:YIHhYuvqEsUH3OMS9bPDTPf61bZY5nlXdLUKxM1OG6wvO6yp5I_gKg>
    <xmx:YIHhYmfsBH_X9patdG0S3g7xcbGlU9IB8GaZiA-xI_BBuU33TcF9gA>
    <xmx:YIHhYi3OV0O2O2Ch2WKwLLQk8rLjUIYKKRkozH_IIoNrDTsbRTpWNg>
    <xmx:YYHhYm7siNzULX3n7xYEVm4F-USHQLJZaISwJarwoXu4nVd0TQaJlQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Jul 2022 14:18:07 -0400 (EDT)
Date:   Wed, 27 Jul 2022 12:18:06 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: __fatal_signal_pending() should also check
 PF_EXITING
Message-ID: <YuGBXnqb5rPwAlYk@tycho.pizza>
References: <Ys2PwTS0qFmGNFqy@netflix>
 <20220713175305.1327649-1-tycho@tycho.pizza>
 <20220720150328.GA30749@mail.hallyn.com>
 <YthsgqAZYnwHZLn+@tycho.pizza>
 <20220721015459.GA4297@mail.hallyn.com>
 <YuFdUj5X4qckC/6g@tycho.pizza>
 <20220727175538.GC18822@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727175538.GC18822@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 07:55:39PM +0200, Oleg Nesterov wrote:
> On 07/27, Tycho Andersen wrote:
> >
> > Hi all,
> >
> > On Wed, Jul 20, 2022 at 08:54:59PM -0500, Serge E. Hallyn wrote:
> > > Oh - I didn't either - checking the sigkill in shared signals *seems*
> > > legit if they can be put there - but since you posted the new patch I
> > > assumed his reasoning was clear to you.  I know Eric's busy, cc:ing Oleg
> > > for his interpretation too.
> >
> > Any thoughts on this?
> 
> Cough... I don't know what can I say except I personally dislike this
> patch no matter what ;)
> 
> And I do not understand how can this patch help. OK, a single-threaded
> PF_EXITING task sleeps in TASK_KILLABLE. send_signal_locked() won't
> wake it up anyway?
> 
> I must have missed something.

What do you think of the patch in
https://lore.kernel.org/all/YsyHMVLuT5U6mm+I@netflix/ ? Hopefully that
has an explanation that makes more sense.

Tycho
