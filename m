Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C222A481D4D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 15:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbhL3O42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 09:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhL3O41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 09:56:27 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B88CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 06:56:27 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id l16so6325746plg.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 06:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vFH2S9/SPFr2cX1fts6IlFx6h2kNtoUhgIhOm/pvEmo=;
        b=ZhOgUPC5bUoJql5Fx6nUGX8tiaPdbiaZtsNX4d5bE11o2G3EDLSDI7rneXlL4y3YSf
         MrNiE7Ij09mrIpYRvqX67erSi7zw/Y3mSgVqXgtxuZuBqaDPRfuGSeTxeUq+P1DUO7r8
         D9cLJ5ILgpWxroWr4avTZMlhDDtKFXusKEp3WfhQM8m95tKNDdJXoKG2/NUMjykcIHMj
         TVqqDlKfOlhvBUoynlO0gBg9sTN+Ui8JcWmBS5kgrGV6M1WmjVlYsw7FDB1xQGvHMGeA
         c9V4htvvHk5nS+Vh0kkAINQe/PJ4U/BjrJMueEMxazyxFkM8uUjV9iOAR/O54MBbtS0l
         EfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vFH2S9/SPFr2cX1fts6IlFx6h2kNtoUhgIhOm/pvEmo=;
        b=Zd3nEZV4HYc041rFz9e6Vd5i83jCyJm99MhaXCz12ceKt8NFp8W4sN/Kk8eWdAjcDD
         YKyveSnxIsY6MAwprPhmUX4Hn8TnmqbtpusU0mlgdYCEQ0pmzvOXgd49Q+YjzT0I+iBs
         UJfMh4SHfTZhgbvH7sPzemyeTps7Z5a126esWsrWhk+uABMdNWdRCweRRHwNW5ifAtQn
         8aQARO74+dI+fhoLMZNgUXbTbQTfDB8J7IcA2aFFQvB/lGnmx663zZGi7b8N3tPUeIhC
         BZ4SboBSW0758+TqhIwyOYbMDlZFKm2UIbEnjNZ1eCwxGZJVV2eVrvAmqLubRHA46fxB
         zkig==
X-Gm-Message-State: AOAM531ecyAo7CASpvbrpME0c2StVC2L2eISFQbKVHtlGASUlvzHLPOH
        XCNNSTAxLz42LTOnbg0odK0=
X-Google-Smtp-Source: ABdhPJwGhDfFBamhxu7nFxp8gB31M2zkqBL/XEgelVha8hrRSjl/80nfntIqPOHySsRY5vIqSkXC5w==
X-Received: by 2002:a17:90b:3b4d:: with SMTP id ot13mr38984562pjb.196.1640876186671;
        Thu, 30 Dec 2021 06:56:26 -0800 (PST)
Received: from localhost.localdomain (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id s207sm23518792pgs.74.2021.12.30.06.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 06:56:26 -0800 (PST)
Date:   Fri, 31 Dec 2021 03:56:21 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     realwakka@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: pi433: add comment to rx_lock mutex
 definition
Message-ID: <20211230145621.GA3236@localhost.localdomain>
References: <20211222215615.GA9361@localhost.localdomain>
 <Yc2QYUcIAV2SY9JU@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yc2QYUcIAV2SY9JU@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 11:56:33AM +0100, Greg KH wrote:
> On Thu, Dec 23, 2021 at 10:56:15AM +1300, Paulo Miguel Almeida wrote:
> > +	/*
> > +	 * rx_lock is used to avoid race-conditions that can be triggered from userspace.
> > +	 *
> > +	 * For instance, if a program in userspace is reading the char device
> > +	 * allocated in this module then another program won't be able to change RX
> > +	 * configuration of the RF69 hardware module via ioctl and vice versa.
> > +	 *
> > +	 * utilization summary:
> > +	 *  - pi433_read: blocks are read until rx read something (up to the buffer size)
> > +	 *  - pi433_ioctl: during pending read request, change of config not allowed
> > +	 */
> 
> This is nice, but way too specific, and will quickly get out-of-date.
> 
> How about something simple like:
> 	/* Protects all rx_* variable accesses */
> 
I see your point. I will send a new version of this patch with your
sugestion. Thanks for guidance.

thanks,

Paulo A.
