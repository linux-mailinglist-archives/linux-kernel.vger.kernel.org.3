Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8083468422
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346407AbhLDKpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:45:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55924 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhLDKpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:45:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EDBB60AC6
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 10:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1379C341C2;
        Sat,  4 Dec 2021 10:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638614546;
        bh=uK8NAcUM9jyIb43R3lQXsqK6c1WdhuVGW9+5gLN3Ris=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tC4Gok7BlKwxT8gDdXNZ7rsTim4+RIU/TQ2IlPyTCuCrRxmLBbgEuZEsS6OOF2Auw
         ImEolYePLx+NG2jX3U92NgTr72u9JmdOg4mvOtJptKCe3SRQQo3e+74c1unp/HIvCq
         xOEpHxTdQlTCj2kz3YBvMDHSg/GfaqtCCxoZwb0U=
Date:   Sat, 4 Dec 2021 11:42:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ameer Hamza <amhamza.mgc@gmail.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: fixed coverity warning by moving pr_warn outside
 lock
Message-ID: <YatGEIrn2OM3mAss@kroah.com>
References: <20211203205041.115331-1-amhamza.mgc@gmail.com>
 <YasfXUW1rNrj3Mgo@kroah.com>
 <CANAWnNyyBR3EEtT=SecqGQsc+tnJi6GiqrW0xkqRn5jrV7CpDA@mail.gmail.com>
 <YasuMNXHlJEKNSwX@kroah.com>
 <20211204103419.GA13093@hamza-OptiPlex-7040>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211204103419.GA13093@hamza-OptiPlex-7040>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2021 at 03:34:19PM +0500, Ameer Hamza wrote:
> On Sat, Dec 04, 2021 at 10:00:32AM +0100, Greg KH wrote:
> > A: http://en.wikipedia.org/wiki/Top_post
> > Q: Were do I find info about this thing called top-posting?
> > A: Because it messes up the order in which people normally read text.
> > Q: Why is top-posting such a bad thing?
> > A: Top-posting.
> > Q: What is the most annoying thing in e-mail?
> > 
> > A: No.
> > Q: Should I include quotations after my reply?
> > 
> > http://daringfireball.net/2007/07/on_top
> Thank you so much sharing the useful post as I have just started my open source journey very recently
> 
> > 
> > On Sat, Dec 04, 2021 at 01:50:44PM +0500, Ameer Hamza wrote:
> > > Thank you Greg for your response. The link to Coverity warning:
> > > https://scan5.coverity.com/reports.htm#v56991/p10063/fileInstanceId=204668511&defectInstanceId=52305699&mergedDefectId=1494148
> > 
> > That link does not seem to be public.  What project are you looking at?
> Its Linux project under coverity scan and CID for this warning is 1494148

Ah, yeah, coverity is being crazy here.  Watch out for that, it is a
VERY difficult tool to use if you are not experienced with kernel
development.

good luck!

greg k-h
