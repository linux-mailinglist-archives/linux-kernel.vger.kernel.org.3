Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378B7465094
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbhLAO5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhLAO5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:57:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401DFC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 06:54:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06978B81FE4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 14:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305B5C53FAD;
        Wed,  1 Dec 2021 14:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638370466;
        bh=bXyQAT5h4hCjsgR9PaPidCv33iYX/V4cznCYJluOS7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fzcvb2N0Z5V/WdaQBi0d3WMIQsy7oSEdjOOkHPQlaszmnfe0R2mSRTvJHV17A70Vl
         UhA1d3ZutujJzQuf/1fAvm0hoWEpIR8nfnXOu3ojZT8to3XKOfwjh6Nby/8sBL1uZR
         TLFdTGvtKtc89G2gnup1v8Efh2XxW+GzqhCG6mtk=
Date:   Wed, 1 Dec 2021 15:54:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Trace event cgroup id fields should be u64
Message-ID: <YaeMoCGy2MXQtJ/U@kroah.com>
References: <20211201144043.557470-1-william.kucharski@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201144043.557470-1-william.kucharski@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 07:40:43AM -0700, William Kucharski wrote:
> Various trace event fields that store cgroup IDs were declared
> as ints, but cgroup_id(() returns a u64 and the conversion was
> not intended.
> 
> Also remove extraneous spaces in fields that are no longer proper C style.

Shouldn't this be 2 different patches?  When writing "also" that's a
huge hint that the patch should be split up.

So one for the bugfix, and one for the coding style change?

thanks,

greg k-h
