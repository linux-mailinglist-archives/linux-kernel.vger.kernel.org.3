Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E63F465357
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242165AbhLAQwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239013AbhLAQwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:52:37 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C84C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 08:49:16 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id iq11so18448704pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 08:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J9zLhnerl9/c5Kx9p+6qzaa+YyIwXDDfpjHgjaBHjcI=;
        b=b9Lk3R00ZKhuNE14r6RJgickUjr+YD8Tr/yjQFtoYXpR0fg3jeRzSBYLAF80GXDXwx
         9sADEbfBdJod6kZ2im1ICZTvDi4mX7hoajDn4IAipUS6H9MJ5P7Nq4scMO3mggzHg09a
         TS393ZUWkX4qaWIui3fyx9zpS/G65RsFAgkabXx8GYEPbVaYEycmKdNL6+NXnNvc2w5i
         kFLcEWaNDqpQygfkY4UwKlmdI5srruOwjRwVFZQll5qTR5ocayhKDRQvE1s4KqtTFPSX
         HhICr9VzMOaKqquC4zbMu94wCX2PQQKC1IN7jhCzguatxsu54JekYbQrZrgtwlCzgAZ7
         1dBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=J9zLhnerl9/c5Kx9p+6qzaa+YyIwXDDfpjHgjaBHjcI=;
        b=y6fi8S7NZMOjrPH5JBVte7sCPvy7AcW9b8QYGNbqHhGKiGPVEi979m+uHePVPZURU7
         kBNC8ueRif6wL3syjVybeFgYPaygVFCy7Td5UtvQS43W2q06KaCu+YNuZIgxdEBK979w
         qsY5cn45EfakYvnmxdsDkBFSJPlY+g14nO2wfQ2uN8Fmd0KjzEgQP4/G5hkQR9cvBwZT
         xNNPRVl3zBTnNsmjG4yX0OcDYpZrMUvl086n5tJPqmBKPpY7kfEl3e7lnt4ZozDC02QW
         nZaF6GA5DXdqEVZBKb4fH5DwNDGvobsSSpFjo5u7rRoRuygeUzMi8nJSUQd58va0lK7y
         pvJw==
X-Gm-Message-State: AOAM533P9Je4aTrEKg3eBCcqTkcbLQ9rYvaX12J7RzKNiHro9Mg7yiU6
        WYm6cWC1z+1kJoOVY6G/ymyDgtgVnyE=
X-Google-Smtp-Source: ABdhPJzmyTMxFt5/ryOt435Ffm8uobfSQHC7wUdI0fT6IPkcIP2gF80XMqMfgHje/3Fba7o7t5NeOQ==
X-Received: by 2002:a17:90a:657:: with SMTP id q23mr8758038pje.21.1638377356306;
        Wed, 01 Dec 2021 08:49:16 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id b4sm379797pfl.60.2021.12.01.08.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 08:49:15 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 1 Dec 2021 06:49:14 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        frederic@kernel.org
Subject: Re: [PATCH] workqueue: Upgrade queue_work_on() comment
Message-ID: <YaenioAmp10YJLrm@slm.duckdns.org>
References: <20211201010030.GA3071988@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201010030.GA3071988@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 05:00:30PM -0800, Paul E. McKenney wrote:
> The current queue_work_on() docbook comment says that the caller must
> ensure that the specified CPU can't go away, but does not spell out the
> consequences, which turn out to be quite mild.  Therefore expand this
> comment to explicitly say that the penalty for failing to nail down the
> specified CPU is that the workqueue handler might find itself executing
> on some other CPU.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Applied to wq/for-5.16-fixes.

Thanks.

-- 
tejun
