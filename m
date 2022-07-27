Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC9A582BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbiG0Qhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238574AbiG0Qfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:35:55 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329484F696;
        Wed, 27 Jul 2022 09:28:00 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b26so25270064wrc.2;
        Wed, 27 Jul 2022 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kfkoj4fNNraT0/nQVLzO6vYNRTJCIdKopXSEcy8gVDM=;
        b=q3H37dDZW+3bOfULAfYuQJm8ZxzHjx0rixk1dhrWM5nbo4TbK8CBATCD7xIksSB0Lg
         ouKAl16bl1ZbP/Uv73EZvnVZ8l5rAfrwU6dpPPqvk9bXxunonxcqefStjmYB0beCWs8+
         SIRHGrlLRYuwvIgkUyk0zFktGzSZRpdDgzpUyTx/Ntp+K9UHF55kDzpDbLmEh9MRJKXL
         RYSkyw6OQli3pZLECvucTltLlry9TD/aqJuLSSTzvXJcGTBELmhY/W0C2p+aIXg/6HuG
         SKFp/RTBtmi4w6/qwnZr8glMe2nthiP7h4mcGxA18xD67A5PvYt+UHYsxPPiv11wEOC2
         Nm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kfkoj4fNNraT0/nQVLzO6vYNRTJCIdKopXSEcy8gVDM=;
        b=aFQBKk/mjgxuxzCcXnWGeWaSKvUJY+hSJk3JQY0vLybANqoOXPEBLt7htsV6AQQ/Ux
         UlceXbHXSebsIcCYTBNFVUm7bTWnWn4YJwm34R8JPjeLbf/FH1IefVNg+bmtfv2b0Prr
         d/LiJvtBPWNOnEDfZV63KJfZfV6UHyVXEp79n1HIz0+Tspj9uWBkE4LYjE4sQoFi3hiQ
         UCa83c6dNeiRcpElcnWX4+FvP+UOI16oZnLbmsAmxRxzEBjpzIrlZg3TF4sLRbmmcWDM
         pquveQbdJRRIXtecvtuBbr8hgAgGXGnSaoUKNw2rQFF0o6j95z8Gg5VE/tJVMWsyO9NP
         BItg==
X-Gm-Message-State: AJIora+VhHXKYvNsRLkoESuhzIhqcohVQymHSpZ6OMPM0W5MoE5D8GtJ
        SKmS6wuJZWAWzcQizQXy0cE=
X-Google-Smtp-Source: AGRyM1tGzrPKCky6a6fSRf3hKGzV7CyhtQhIjfR3kqAZAEygm9jlnBVaaOUd5JATDO60ztoTTN6kVg==
X-Received: by 2002:a1c:e90c:0:b0:3a1:7527:cd3c with SMTP id q12-20020a1ce90c000000b003a17527cd3cmr3631590wmc.91.1658939278035;
        Wed, 27 Jul 2022 09:27:58 -0700 (PDT)
Received: from elementary ([94.73.33.57])
        by smtp.gmail.com with ESMTPSA id m16-20020adffa10000000b0020e6ce4dabdsm17551020wrr.103.2022.07.27.09.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:27:57 -0700 (PDT)
Date:   Wed, 27 Jul 2022 18:27:55 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Stefan Hansson <newbie13xd@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Ping Cheng <ping.cheng@wacom.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Regression likely in hid_uclogic driver breaks Huion
 Inspiroy H640 drawing tablet
Message-ID: <20220727162755.GA3839@elementary>
References: <9e16d503-2203-57ed-d6af-61fea0c3e10b@gmail.com>
 <nycvar.YFH.7.76.2207231339500.19850@cbobk.fhfr.pm>
 <20220724114849.GA32182@elementary>
 <20220725224841.GA75640@elementary>
 <3f2e0a49-38a8-417e-1bb0-9a9f28371240@gmail.com>
 <20220726214858.GA3202@elementary>
 <8a35df7d-a6cc-63e9-b207-6fbed05e32e5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a35df7d-a6cc-63e9-b207-6fbed05e32e5@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 10:56:33PM -0400, Stefan Hansson wrote:
> Hi!
> 
> > > Thanks for looking into this! Bisecting has been slow on my end
> > > unfortunately. I built today's linux-next (20220726) with your proposed
> > > patch below and my drawing tablet curiously still does not work as expected.
> > > The stylus works a couple of times, but eventually stops working (unlike
> > > prior where it always seemed to only work once). Do I need both your revert
> > > and this diff for it to work properly?
> > 
> > You are right, I just tested for a while with the diff applied (without
> > reverting the commit causing the issue) and after putting the pen in
> > and out proximity a fair amount of times (> 100) it stopped working.
> 
> This part is peculiar to me. When I said "a couple of times", I really meant
> a couple of times. For me, this issue reproduces after maybe 10 times at
> most. I have never been able to do it for anything close to 100 times. I
> wonder what's up with this disparity?

We are most likely doing something different. Anyway, the important bit
is that with the current code present 5.18 the bug is easy to reproduce
in order to test fixes.

Jose
