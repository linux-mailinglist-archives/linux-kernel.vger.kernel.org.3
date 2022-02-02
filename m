Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5561E4A6CE7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 09:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244904AbiBBI0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 03:26:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54774 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbiBBI0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 03:26:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B63D3B8302F;
        Wed,  2 Feb 2022 08:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99E6C004E1;
        Wed,  2 Feb 2022 08:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643790360;
        bh=xrV4cjsjCXxwl2JL84Csa7GD6T5ZwxgoSFYH2ZIgt7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uf8I6VQtKPuLrhZKYeERQZIPR8SQZiRToFXyCBn3ykziJSc7xO93xTwtb/jyCmSb7
         JiFQg06R1rWbdVJE6UfcCEAFT0AXmDytZCXwX6gUizA0dtu2nDopBaW9gzgK78D8TV
         OxXQeGeF1/64N1PqgaqZYgZSROdwLxbMqVkVdvSY=
Date:   Wed, 2 Feb 2022 09:25:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Wagner <wagi@monom.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [ANNOUNCE] 4.4.301-rt231
Message-ID: <YfpAFdoZ/t74kt7H@kroah.com>
References: <164373149744.25521.668105457088547829@beryllium.lan>
 <da5b0bc4-0980-5193-cb65-c1b06e46574b@monom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da5b0bc4-0980-5193-cb65-c1b06e46574b@monom.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 08:56:36AM +0100, Daniel Wagner wrote:
> On 01.02.22 17:14, Daniel Wagner wrote:
> > Hello RT-list!
> > 
> > I'm pleased to announce the 4.4.301-rt231 stable release.
> > 
> > This is just an update to the latest and last 4.4.x stable
> > release. There are no RT specific changes.
> > 
> > With this release there wont be any updates for this branch in
> > stable-rt tree. I understand Pavel Machek is continuing to maintaining
> > the v4.4-rt branch under the CIP umbrella:
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-cip-rt
> > 
> 
> It seems Greg is still updating v4.4.y. I'll do another update, when 4.4.y
> gets an update
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=linux-4.4.y

I will do one more release, probably in a day or so, and then it is
dead.  Run away!!!  :)
