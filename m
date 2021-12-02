Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5844668A6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359757AbhLBQx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:53:56 -0500
Received: from netrider.rowland.org ([192.131.102.5]:38921 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1359744AbhLBQxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:53:54 -0500
Received: (qmail 393529 invoked by uid 1000); 2 Dec 2021 11:50:30 -0500
Date:   Thu, 2 Dec 2021 11:50:30 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM: runtime: Allow rpm_resume() to succeed when runtime
 PM is disabled
Message-ID: <Yaj5Vur0fTFXvhwE@rowland.harvard.edu>
References: <20211026222626.39222-1-ulf.hansson@linaro.org>
 <CAPDyKFrFdt_U7By_bqk4DBHxCBLpDe00aRb6P6BmwR4MYM2OmQ@mail.gmail.com>
 <CAJZ5v0i6WPVCf4pf9uTx5vjutw0cbD+omL_FNtw6DrxYDhyYEA@mail.gmail.com>
 <5794197.lOV4Wx5bFT@kreacher>
 <CAPDyKFrPC=8cAKGWQ4cDEcD934gi-012CWXu+uh-B_pqX+0RYQ@mail.gmail.com>
 <CAJZ5v0ijRK0sYoJ6_WyqrhQfYKxEf4jCSjK4T5CbQsYPXaB=Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ijRK0sYoJ6_WyqrhQfYKxEf4jCSjK4T5CbQsYPXaB=Nw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 05:18:26PM +0100, Rafael J. Wysocki wrote:
> On Thu, Dec 2, 2021 at 12:29 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Alright, this sounds reasonable to me. I have also looked at the code
> > below and it looks good to me.
> >
> > Do you intend to post a formal patch? In any case, feel free to add my
> > reviewed-by tag.
> 
> I will, thank you!

Don't forget to check for spelling errors (I noticed one in the first version of 
the patch you posted).  And please include a documentation update.

On the whole, the idea seems like a good improvement.

Alan Stern
