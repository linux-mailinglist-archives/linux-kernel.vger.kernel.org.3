Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD0A5A5CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiH3HUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiH3HU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:20:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDFE5004C;
        Tue, 30 Aug 2022 00:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661844028; x=1693380028;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=axUyRkQDEujGll+U4gNW9NGbIqhXvci7jUZVzKU+b8k=;
  b=XaeWYzd6ovApkXvJrbc3owRwl6Torv9LDkkSUYVU/dOhHXhSQSQuGT6e
   eK7gXiPogyOVBYU6xymhW/XaLo/5UgHIoVHV4JHie7AWlWInz3nrQsVKx
   DnDJpNlmwFHrFpZ+uxZ+eZy5MM2WmvwNwvhuWVqlJeE+J5EpMZ9Ia6Snk
   KhnUM+QW4AJvjLYNYjX1LQyg6/BVP/ufjbH2F1MuKIZKXGUVVLkCopRaC
   hfjukD293rmIc/vIAOOWDXV6TKE7p3s8l6awfYealJOUnn35bdbG3K5rJ
   kFw99rLDyDs5UOr65zqQJZ7ol4OmhTWXXQYMGIqt0ewz87VWhPV7Sykqh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="321231777"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="321231777"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 00:20:27 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="672728650"
Received: from arnesgom-mobl.ger.corp.intel.com ([10.252.54.235])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 00:20:25 -0700
Date:   Tue, 30 Aug 2022 10:20:20 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Li Zhong <floridsleeves@gmail.com>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2] drivers/tty/serial: check the return value of
 uart_port_check()
In-Reply-To: <CAMEuxRq6wn+wakYHGtnS_vSgpcw6aNOir=KyXWb12vPrOr76pA@mail.gmail.com>
Message-ID: <40e16474-99d2-2359-a545-4a437f555ec1@linux.intel.com>
References: <20220826083612.1699194-1-floridsleeves@gmail.com> <CAHp75VcdqL4wYnhEi8LrxqJktA2uDzP3a6-08suJRghX=1UZsg@mail.gmail.com> <CAMEuxRqBEMdva3qEphvuYkFLpRjp=xg7vpqQT1oqb2AgkkG2+w@mail.gmail.com> <2033d06d-10a4-5a57-d650-7541c39990ee@linux.intel.com>
 <CAMEuxRq6wn+wakYHGtnS_vSgpcw6aNOir=KyXWb12vPrOr76pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-68519279-1661842936=:1864"
Content-ID: <2edbf640-1cd7-a490-7077-b3c91cf8135f@linux.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-68519279-1661842936=:1864
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <7768bd39-e4a3-2d53-551f-1d81a45711d3@linux.intel.com>

On Mon, 29 Aug 2022, Li Zhong wrote:

> On Mon, Aug 29, 2022 at 12:09 AM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Sun, 28 Aug 2022, Li Zhong wrote:
> >
> > > On Fri, Aug 26, 2022 at 9:01 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > >
> > > > On Fri, Aug 26, 2022 at 11:38 AM Li Zhong <floridsleeves@gmail.com> wrote:
> > > > >
> > > > > uart_port_check() will return NULL pointer when state->uart_port is
> > > > > NULL. Check the return value before dereference it to avoid
> > > > > null-pointer-dereference error.
> > > >
> > > > Have you taken the locking into consideration?
> > > > If no, please do, if yes, expand your commit message to explain why
> > > > the current locking scheme doesn't prevent an error from happening.
> > > >
> > >
> > > The locking is taken into consideration but these three checks do not need to
> > > unlock in error-handling because unlock() will be called in the callers. Will
> > > add the comment in v2 patch.
> >
> > I think he meant you should indicate why the current locking doesn't cover
> > the case you're fixing, not whether this function should call unlock() or
> > not.
> >
> 
> Thanks for clarifications. The locking does not guarantee the return value of
> uart_port_check()  is not NULL.

Please put such explanation into the commit message like Andy was asking, 
thank you.

And make sure you properly mention what has changed for any new version 
of any patch you send so that Greg don't need to auto-mail you about it 
(and end up ignoring your patch).

> Actually in line 773 of this file
> (drivers/tty/serial/serial_core.c), uart_port_check() is also called in
> critical section but still there is check on whether the return value is NULL.

Existance of such a check elsewhere alone isn't enough to guarantee that 
the check is necessary (and not even that the check in that other place 
would be necessary). You need a deeper analysis than that. I'm not 
claiming its either way here, just pointing out to the direction/details 
you should consider while writing the analysis of the problem.


-- 
 i.
--8323329-68519279-1661842936=:1864--
