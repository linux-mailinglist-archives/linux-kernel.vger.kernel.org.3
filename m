Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDAE4E45A4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbiCVSE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbiCVSE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:04:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C707D27FF3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:03:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C35B61598
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A011BC340EC;
        Tue, 22 Mar 2022 18:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1647972208;
        bh=JepXhyBM4YkrDIIDiB6RK46iKWYiIOJmy0G7v9Gj2JA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=teHk6e41BseqZqEAeCsO//cd2Wk7j1qrfQSkeFxnDh676HK8rpTDF0+3EPbLuLPC+
         jc/pqf7ZtToJkpqKkGR2E6h1fLKKZYLY6Pb/hhqPQGo3zCHHSPKhe8RxX8I2MfjflL
         qbDj8hlf+rxagZxw5ApLSZRgCUK6FwZTP1qdjSek=
Date:   Tue, 22 Mar 2022 11:03:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sean Anderson <seanga2@gmail.com>
Cc:     Yinan Zhang <zhangyinan2019@email.szu.edu.cn>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/vm/page_owner_sort.c: add switch between culling
 by stacktrace and txt
Message-Id: <20220322110327.eb9df4333d25eda837d80a85@linux-foundation.org>
In-Reply-To: <0f3fca6a-cd9d-a5f7-2eda-3e3a9ceae564@gmail.com>
References: <20211129145658.2491-1-zhangyinan2019@email.szu.edu.cn>
        <f0a8099b-3c60-3e34-078a-be3c1280ca61@gmail.com>
        <20220321133825.6f003c62381edbab361a8d96@linux-foundation.org>
        <623932d3.1c69fb81.e3278.ab09SMTPIN_ADDED_BROKEN@mx.google.com>
        <0f3fca6a-cd9d-a5f7-2eda-3e3a9ceae564@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2022 23:55:29 -0400 Sean Anderson <seanga2@gmail.com> wrote:

> On 3/21/22 10:22 PM, Yinan Zhang wrote:
> > I replied to the email a few months ago. Did you receive it?
> 
> The patch was applied anyway. Anything in this subsystem gets
> applied within a day or two regardless of feedback. Personally,
> I'm not motivated to review anything because of that.
> 

The feedback wasn't ignored, as you're seeing here.

If the feedback appears to be non-fatal I'll hold onto the patch with
an expectation that the feedback will be addressed and we can move
forward with an updated version of the code.

