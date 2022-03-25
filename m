Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005854E7BBC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiCYUTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiCYUTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:19:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13FC5716D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:18:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FA1861D01
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 20:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3187C2BBE4;
        Fri, 25 Mar 2022 20:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1648239495;
        bh=A+G3xllm1G1zfdvj667BokkC3bPhF/9IHvB1FulEseM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hQROyjrrSFZoy7Yfh6vgpn5ckS0YJJ0umg72yTYzKGIV1DINoQywfDVHiNAkwRb2h
         R3JZMNLGflx9UW4nRxfu5ZFNf1dGB550TpLN9NG14YBePZaPbIIt1aigiEf3uY8cK1
         Mcl6HR9Sr5aVd9DC6aRqUjyWiTC63QM9fTkXJ0Es=
Date:   Fri, 25 Mar 2022 13:18:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jonathan Lassoff <jof@thejof.com>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] Add FAT messages to printk index
Message-Id: <20220325131814.7664f1d43c07b091548be2bf@linux-foundation.org>
In-Reply-To: <20220324021957.20173-1-jof@thejof.com>
References: <20220324021957.20173-1-jof@thejof.com>
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

On Thu, 24 Mar 2022 02:19:58 +0000 Jonathan Lassoff <jof@thejof.com> wrote:

> In order for end users to quickly react to new issues that come up in
> production, it is proving useful to leverage the printk indexing system. This
> printk index enables kernel developers to use calls to printk() with changable
> ad-hoc format strings, while still enabling end users to detect changes and
> develop a semi-stable interface for detecting and parsing these messages.
> 
> So that detailed FAT messages are captured by this printk index, this patch
> wraps fat_msg with a macro.

It would be nice to see some before-and-after sample output to help
reviewers understand this proposal.

> Reported-by: kernel test robot <lkp@intel.com>

We'll need a Signed-off-by: for this, please. 
Documentation/process/submitting-patches.rst describes this.

