Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D47F46D60F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbhLHOwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbhLHOwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:52:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E353C061746;
        Wed,  8 Dec 2021 06:48:32 -0800 (PST)
Date:   Wed, 8 Dec 2021 15:48:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638974909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qtWRead05hSnhf1TWBaKHwSo0tRXaJsGd5xhhRb2fWY=;
        b=ATd3hA5UkSaE0GR/AaIJP1SYLTMM081RkUs2lObd4CV5kQ/wKMsot4RXFZgm9Xfafp7QCA
        5mjGzkH7Pxg7NKUt0NmqgZsBUJzqc9C87K946VRpP4EQzkjOYHUZ+boC6kKYNP+kPUeCs9
        prfabs1XfToaUVkSptDAYIMAFL+HGb1Vxet8GCNiehe8f4RxTlV6nMDFXdpGLhlk829Eju
        U/0V/ddgU5hfTnsQYf/54yGqFH4QtrK9oAt9tgUy3Gh7igAzVtNKRYpqnEzN7IlyhiyvV/
        af9B7fIV2e2ueujVFm6GQHN6DHtiSUg8bPqfUwfV3P5UrP8gSPNAnkd4zV/7xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638974909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qtWRead05hSnhf1TWBaKHwSo0tRXaJsGd5xhhRb2fWY=;
        b=32zEQj91hd+clAMRFKsI50xY6ZMokRDpsb1sc76LoYc1rPWxJ2RF2wdLfM6XQnWnqj8AXA
        q3nULV/uSCVC7ZCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Luis Goncalves <lgoncalv@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>, carnil@debian.org
Subject: Re: [ANNOUNCE] 5.10.83-rt58
Message-ID: <20211208144828.y2e2d4h3yincjyqg@linutronix.de>
References: <YalDQe/lyXqAxB0K@uudg.org>
 <20211207201712.7yqbksbba3zgu7u3@linutronix.de>
 <20211207152049.1013e1ce@gandalf.local.home>
 <20211207205628.auc54rwl4duuisah@linutronix.de>
 <20211207160203.30206456@gandalf.local.home>
 <CAD8J--9V7KxJrT==vnoawWXpp9Ur_-o2Fhm_ebNd4-hH8ncfPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD8J--9V7KxJrT==vnoawWXpp9Ur_-o2Fhm_ebNd4-hH8ncfPg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-08 10:14:41 [-0300], Luis Goncalves wrote:
> Yes, I am really sorry that escaped my review. I focused on testing
> the code and missed something that obvious.
> 
> Sorry for the confusion I caused.
> 
> Steven, Sebastian, would it be worth a v5.10.83-rt59 with the patch
> subjects fixed?

No, I don't think that it is worth it. Please correct it for the next
release.
I'm not sure if there is a need for the base version in the patch tag.

> Thanks for spotting that,
> Luis

Sebastian
