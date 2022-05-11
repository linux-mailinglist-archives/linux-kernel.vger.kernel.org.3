Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8944524057
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347829AbiEKWgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiEKWgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:36:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDDF1FCF7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:36:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B44FBB82526
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 22:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E45C34114;
        Wed, 11 May 2022 22:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652308577;
        bh=iGqwGob0xieaSqpzSVhKd2KCpJBi2vPIuWbYJf0XuHM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ARW7VKdh4O4YQnkdv5yrHMpHqsurm9kG3S8TB4zU1xJXGgKF0qnFNpfk6LOigv2OK
         ZJW2DHWsaXKwk3aW3zYuyj5BCc/iMfMpBkDEjmrNwDYSqlwygahpyxcdrZq9Ezuxbr
         dRFHMjZaw1wfjsg/A+gTEPOlJWdq//AkGcTajxyk=
Date:   Wed, 11 May 2022 15:36:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Add config option for default panic_on_oom value
Message-Id: <20220511153616.9298d246adb1c7fea9ab453b@linux-foundation.org>
In-Reply-To: <b597cc79-0f8a-c32d-397e-0c04777e9491@linux.ibm.com>
References: <20220511183400.47940-1-eajames@linux.ibm.com>
        <20220511145648.3c421ff592df32766319ea2d@linux-foundation.org>
        <b597cc79-0f8a-c32d-397e-0c04777e9491@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 17:06:35 -0500 Eddie James <eajames@linux.ibm.com> wrote:

> 
> On 5/11/22 16:56, Andrew Morton wrote:
> > On Wed, 11 May 2022 13:34:00 -0500 Eddie James <eajames@linux.ibm.com> wrote:
> >
> >> Add the option to kconfig and set the default panic_on_value.
> > Why?  What are the use-cases and how does this benefit our users?
> 
> If a distribution (for example some embedded system distribution) wants 
> the system to always panic when OOM, they may as well configure their 
> kernel to do it by default, rather than writing to 
> /proc/sys/vm/panic_on_oom every boot. Maybe I'm missing another way to 
> do what I want here?

Presumably such a distribution would do this in initramfs initscripts
and forget about it.

What inspired the patch?  Have you seen a situation which was best
solved with this change?

