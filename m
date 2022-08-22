Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E2059CA50
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiHVUqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiHVUqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:46:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC823C8D8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:46:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AA59612F0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 20:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762CBC433C1;
        Mon, 22 Aug 2022 20:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1661201175;
        bh=SghH8Nrp72EYmNHkfS2Su+N3acNErB/MMeXnCWr0FWw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w/5S5yHvqLe4rn4+8QrvpzAI8sHdrqWkI2wYwQyV6HoFz31bKOb8b9QtSEQA3Xs43
         3jJIjOEnEMrCa51TkWHkzF83bQz0Gbw5c1uwHyFyp8Oc93w75x/i9R14g/JPMnRcys
         5FN2XzO6r7VEcj6FK5X3Ocei/rti8QXp7VLYRoaw=
Date:   Mon, 22 Aug 2022 13:46:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH] compat: update linux/compat.h and kernel/sys_ni.c
Message-Id: <20220822134614.aeb6f3ce279ded4559037de1@linux-foundation.org>
In-Reply-To: <20220822194310.31796-1-rdunlap@infradead.org>
References: <20220822194310.31796-1-rdunlap@infradead.org>
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

On Mon, 22 Aug 2022 12:43:10 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> Add conditional syscalls entries in kernel/sys_ni.c
> for any syscalls that are arch- or config-dependent.

What is the reason for this?  What effects does it have?
