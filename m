Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3858046D76A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbhLHP4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:56:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47691 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233729AbhLHP4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638978755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HHyQW9fF0kEKk/z33xdysmis1ED0dsGeVvo9lIxViIQ=;
        b=R/SQfpioVcfROP4q8XlaZkAIwNXzFAZkXhnhWz561qXyq/g8Nxavbr+tdAVS64jMFemkQD
        jPyeDmPKQVxXmqdWqZMre4KTvgoFXAkA86R0NeFTDtOt/0sM33Y735MexOxhdwzIOFbHpM
        bru4lL+/0YEhKLGe7v3hqZLxj/AZcJw=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-h8ZvVUAEOtmugX5VDwd1lQ-1; Wed, 08 Dec 2021 10:52:34 -0500
X-MC-Unique: h8ZvVUAEOtmugX5VDwd1lQ-1
Received: by mail-io1-f70.google.com with SMTP id 85-20020a6b0258000000b005ed47a95f03so3823610ioc.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 07:52:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHyQW9fF0kEKk/z33xdysmis1ED0dsGeVvo9lIxViIQ=;
        b=oOzkTdikViAe8qZVQKASTjztnxxr9GwAI3jU//iafw4VClwhd2U9PJcIwOVK4jDZft
         95oGTCV9w37Hmx/hFi3fjB4dfOPWejG1Is9QvzEhi3/twS2zavrOAaFIcxv071KgqKU/
         ub5au/N5VUilX6ZUPaNL70W2OZHB+cnsTnTnWIlTbOP6CIV3Qoib89xWd8epIwWS9vsd
         xdcG0+U8yURwvnueEqEQjHYG8fc2FVT+5K+S+M5+tGStOmoJEANvJZJZE4J9AJ7QGGJr
         K3aTvwif/Y2VUWHFEJFZPmIwINRcHwkby5HinY04DmbhFTxdL6A2fo2wRUM9NF1maAdK
         PW+Q==
X-Gm-Message-State: AOAM5307bcxeeGLTRW9hyIOw/UYeuouDy1V8Un/q4uLVv1RWKlqOtDGn
        C5kExoZI/wvO7aYFYFU5xnG82W/jreGMRvBrEnYJLKm9Nae7gSjWbXu6r85Do5o/EYoT3VxFGXe
        4elcDp75Ur/KdgYsp2IP7tLVZoNiiBTfzDbhyBjke
X-Received: by 2002:a6b:6802:: with SMTP id d2mr7823071ioc.187.1638978753211;
        Wed, 08 Dec 2021 07:52:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykGm0Ikl+9jlmjalE/ELVobVinAkM7BeoKHqD0RG+eohMy/yAukz4KADVlumMo0/DJXhlnEaJJglS8IKXOOPw=
X-Received: by 2002:a6b:6802:: with SMTP id d2mr7823008ioc.187.1638978752682;
 Wed, 08 Dec 2021 07:52:32 -0800 (PST)
MIME-Version: 1.0
References: <YalDQe/lyXqAxB0K@uudg.org> <20211207201712.7yqbksbba3zgu7u3@linutronix.de>
 <20211207152049.1013e1ce@gandalf.local.home> <20211207205628.auc54rwl4duuisah@linutronix.de>
 <20211207160203.30206456@gandalf.local.home> <CAD8J--9V7KxJrT==vnoawWXpp9Ur_-o2Fhm_ebNd4-hH8ncfPg@mail.gmail.com>
 <20211208144828.y2e2d4h3yincjyqg@linutronix.de>
In-Reply-To: <20211208144828.y2e2d4h3yincjyqg@linutronix.de>
From:   Luis Goncalves <lgoncalv@redhat.com>
Date:   Wed, 8 Dec 2021 12:52:21 -0300
Message-ID: <CAD8J---yWGx46DmVUGzvpx5bQTEyYN6aie2HRPkzB71qNp5mLg@mail.gmail.com>
Subject: Re: [ANNOUNCE] 5.10.83-rt58
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>, carnil@debian.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 11:48 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2021-12-08 10:14:41 [-0300], Luis Goncalves wrote:
> > Yes, I am really sorry that escaped my review. I focused on testing
> > the code and missed something that obvious.
> >
> > Sorry for the confusion I caused.
> >
> > Steven, Sebastian, would it be worth a v5.10.83-rt59 with the patch
> > subjects fixed?
>
> No, I don't think that it is worth it. Please correct it for the next
> release.
> I'm not sure if there is a need for the base version in the patch tag.

Thank you! I will fix that for the next release.

Luis

