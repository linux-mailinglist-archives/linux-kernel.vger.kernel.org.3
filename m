Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13B046836E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 10:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384376AbhLDJEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 04:04:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49232 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354761AbhLDJED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 04:04:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69C8F60DD8
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 09:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DC3C341C0;
        Sat,  4 Dec 2021 09:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638608437;
        bh=h/zpQrO/E2cPY6/AXZk2zsMPe9CYqo6/SLtTqkx6tkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OmszMhdIxopPTR/nTbQFmrFNLTzFad3eCzKgtNEhW2922qqxehUmA2NXSQA9RpGrJ
         SDaiMwFW+QAoc/M4Owfx0HzyLtlS8mcwOgrE9m7muzpdxfSL7910YW+2Yom/7xqoxN
         mhyjF/hGAPPYWUVzDCPuXCSOhmt9eE8WDLgC99+w=
Date:   Sat, 4 Dec 2021 10:00:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ameer Hamza <amhamza.mgc@gmail.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: fixed coverity warning by moving pr_warn outside
 lock
Message-ID: <YasuMNXHlJEKNSwX@kroah.com>
References: <20211203205041.115331-1-amhamza.mgc@gmail.com>
 <YasfXUW1rNrj3Mgo@kroah.com>
 <CANAWnNyyBR3EEtT=SecqGQsc+tnJi6GiqrW0xkqRn5jrV7CpDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANAWnNyyBR3EEtT=SecqGQsc+tnJi6GiqrW0xkqRn5jrV7CpDA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Sat, Dec 04, 2021 at 01:50:44PM +0500, Ameer Hamza wrote:
> Thank you Greg for your response. The link to Coverity warning:
> https://scan5.coverity.com/reports.htm#v56991/p10063/fileInstanceId=204668511&defectInstanceId=52305699&mergedDefectId=1494148

That link does not seem to be public.  What project are you looking at?

> I have seen similar warnings if the print operation is used inside a lock,
> i.e., Coverity speculates a possible deadlock scenario, which might be a
> false positive because internal printk implementation uses a separate lock.

When dealing with Coverity, it is up to you to determine if what it says
is actually true before sending out patches for it, due to the HUGE
number of false-positives it spits out.

thanks,

greg k-h
