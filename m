Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3454A4F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 20:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377191AbiAaTiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 14:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377171AbiAaTiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:38:04 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C45C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 11:38:03 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id d5so14923708pjk.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 11:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xzVa+kpI2P5pcrQ6q9RAyjwxclzwOqeJjWm5GlzFQtk=;
        b=lCV+OL9RHYZ/y/+aXRVJx2OIAAk0VGu75AVLXk973DnP+4Uwd6/Cj9rEh20rTDlKEi
         rj2JW+wENteqcF2sGP6/NWTC09K/TcLD2m4MBwdq+W4L9fFCtjbATklhgukmkdEfXEl/
         Suexv0Rr3NSjxuExdqiCP7gjqNX2RI0YjQG4kIkKtO9Vdw998ruMyLRQbsuI75KceBBy
         A0Orfx7aghxdVM9M7o+Cl0ZWbj48dgXwmj4IS3hODlMuREEPl+vAG8Hh4nhGGdi4tr7Z
         iBPfQVgGcEyGg/eJTSJeiTbRhnIetVgGjOU2XdmX17QwdxywBxcNVhq9nzJmrxy0qhVk
         gRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xzVa+kpI2P5pcrQ6q9RAyjwxclzwOqeJjWm5GlzFQtk=;
        b=hpymqc7jnEFbd9RHhOKqYh0eCxbZr8LNud5wnBB3ITJsuOpKT6nm0BGnZ12cMLrJxM
         11b/bfvuZQSK6WdrsCtYbDtuWMPwFhFag4qlnHRsB1bmqEZbkdcMop+kCXFXW5WIuuuH
         PxJFc46LC7gWv6ayovlZ2N4WXvHLC3LzoiYXrq1CIsQdXSv+eclK+KxeZ2hrL2ImxrCo
         kE1J9+sJfhwWcsWQ5bHy4ONBjjz3DsvXMX59tNjcOcAAimo7BKuIEnt7xGXPMVcKy6Dp
         CKtpqKD+EqhtXkzp9M6xTiuIy3Qh6ZDpM28218lUOaLvRgFZkAC9XxUUKuc1gb5Ogjqb
         vi4g==
X-Gm-Message-State: AOAM533mZ61/IDBpsQrxCnIf8avYdP/wRZqtJcDEr7rk/fchKXys/lPI
        x3Gr0QzFH5nV9kFoWX1pCz0=
X-Google-Smtp-Source: ABdhPJzxdWGPv1XAWrMDsXWHrZgoHwdcemerau22RVBNPdYWRaF6qMmCgG/0CwqjNt0cfHA8s+aI4g==
X-Received: by 2002:a17:902:ec86:: with SMTP id x6mr22630459plg.96.1643657883448;
        Mon, 31 Jan 2022 11:38:03 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id j10sm19471459pfu.93.2022.01.31.11.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 11:38:02 -0800 (PST)
Date:   Tue, 1 Feb 2022 08:37:57 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: pi433: add debugfs interface
Message-ID: <Yfg6laurUQF02TPR@mail.google.com>
References: <20220126132116.GA1951@kadam>
 <YfX+llwDWZZMz+NY@mail.google.com>
 <20220131134558.GL1951@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131134558.GL1951@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 04:45:58PM +0300, Dan Carpenter wrote:
> On Sun, Jan 30, 2022 at 03:57:26PM +1300, Paulo Miguel Almeida wrote:
> > +	dev = m->private;
> > +
> > +	mutex_lock(&dev->tx_fifo_lock);
> > +	mutex_lock(&dev->rx_lock);
> > +
> > +	// wait for on-going operations to finish
> > +	ret = wait_event_interruptible(dev->rx_wait_queue, !dev->tx_active);
> > +	if (ret)
> > +		return ret;
> 
> Drop the two mutexes before returning.
> 


thanks for taking the time for reviewing this patch.

good catch, I completely missed it. Thanks a lot!

thanks,

Paulo Almeida
