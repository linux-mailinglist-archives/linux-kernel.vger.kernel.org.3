Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785084A770E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346337AbiBBRoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346342AbiBBRoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:44:34 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B942C06173E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 09:44:34 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id i34so636433lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 09:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HJ2cXah5dml6V7C4miubQx4zN0urdzlLJvAL9WrOwNU=;
        b=q1TOPLuuujSJcAdH0DQf2yy4R9RRliqPtPrQKQXA+cCLdYmzv42jYXxwujMHwldAu1
         XwftJfjiBqxrXAuW0M+O9CnHwDoQK23HzYYXstMvhD6qgTxHf9rfuMOQEDPCC+XV+XSs
         9zITT45eaSoVOnOwYy1sScIIXNvT3TqB5zl4A3oS2sP1PQcKltFwtxrRreWBxZISf9lX
         3c4bjF96n1gUufCxtysKpIQX3re68c36WTwVOHcrFQhm2TgTN3zLDsMimGE5G8amHD6s
         I2QVatXoGnDzhOn782ao+CuBPmH9BgK6dpZ3hZ+CKSqQ9Ivtv1XOOSXRrKGaEKHbxYov
         ac2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HJ2cXah5dml6V7C4miubQx4zN0urdzlLJvAL9WrOwNU=;
        b=5TO0Q+kyizmxDMVYnjYxTHDl979YCUKGQVWF+UKACnGDkYWpxlwfe6KjdyqmR/PdrC
         W9aQ+ixt2+YmMzXEt92o7UvLuPZs0/ozwRlRxKRA/OwTD2vX8DCTIfmY8NK58TMvLuDK
         NXKRlGxHHQP10uPIsoNep9Wj2UxtnVUlr9+/zqrXsXU4xl/QzP6MjeV3QD7Ff0OhtUpb
         19UVFBordKM4l39Ci8ZcoaaQAQ34hYRzcszHRyF4282eVPQOnhiELwdFawy4MOD0ma2S
         eELAN6zj+Ls+X/KeapSvFwvPBGlaMFila9VBWiFYjSEeqp3A7u+2yzEmQXRoR/kjl3yk
         pH4w==
X-Gm-Message-State: AOAM532de1lHFSVMvuexk3+YWIp440hwieu5NYw2wWT/pcrmi1a2SW5k
        sGlSzd+MDUtmqFC2r4CdVeM=
X-Google-Smtp-Source: ABdhPJx5MJU2U/RvMx0LZf40bTFKTVtts30t71TgILH626bxivr/8mJ1/7LwGjjV/vZAzlAvP11UNg==
X-Received: by 2002:a05:6512:150d:: with SMTP id bq13mr1217085lfb.611.1643823872669;
        Wed, 02 Feb 2022 09:44:32 -0800 (PST)
Received: from grain.localdomain ([5.18.251.97])
        by smtp.gmail.com with ESMTPSA id r14sm4654700lfr.129.2022.02.02.09.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 09:44:31 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id A2E725A0020; Wed,  2 Feb 2022 20:44:29 +0300 (MSK)
Date:   Wed, 2 Feb 2022 20:44:29 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Jason Andryuk <jandryuk@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] kcmp: Comment get_file_raw_ptr() RCU usage
Message-ID: <YfrC/fQvQ1nkIJNJ@grain>
References: <20220202151734.10418-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202151734.10418-1-jandryuk@gmail.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 10:17:34AM -0500, Jason Andryuk wrote:
> This usage of RCU appears wrong since the pointer is passed outside the
> RCU region.  However, it is not dereferenced, so it is "okay".  Leave a
> comment for the next reader.
> 
> Without a reference, these comparisons are racy, but even with their use
> inside an RCU region, the result could go stale.
> 
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> ---
> I was looking for examples of task_lookup_fd_rcu()/files_lookup_fd_rcu()
> and found this.  It differed from the example given in
> Documentation/filesystems/files.rst, so I was initially confused.  A
> comment seemed appropriate to avoid confusion.
> 
>  kernel/kcmp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/kcmp.c b/kernel/kcmp.c
> index 5353edfad8e1..4fb23f242e0f 100644
> --- a/kernel/kcmp.c
> +++ b/kernel/kcmp.c
> @@ -63,6 +63,9 @@ get_file_raw_ptr(struct task_struct *task, unsigned int idx)
>  {
>  	struct file *file;
>  
> +	/* This RCU locking is only present to silence warnings.  The pointer
> +	 * value is only used for comparison and not dereferenced, so it is
> +	 * acceptable. */
>  	rcu_read_lock();
>  	file = task_lookup_fd_rcu(task, idx);
>  	rcu_read_unlock();

They are not wrong, this is just such a bit weird semantics where
we fetch the pointers and strictly speaking map them into numbers
set to compare. But I agree that such tricks might confuse. How about

	/*
	 * Fetching file pointers inside RCU read-lock section
	 * and reuse them as plain numbers is done in a sake
	 * of speed. But make sure never dereference them after.
	 */

?
