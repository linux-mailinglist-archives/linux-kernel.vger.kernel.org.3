Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AEE53CDEE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344310AbiFCRPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240019AbiFCRPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:15:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E0D35A8A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 10:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 270C561A8A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 17:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAD1C385B8;
        Fri,  3 Jun 2022 17:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1654276528;
        bh=Ro6h75RLaAJ+PRoGe3VS1NhNTY6ZXMdHX4HXddy0Er8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OP4xP97sY7Cm/c3luexApT/Vsfu+/AiXS3yETWkQ3KaBj2LsTi/4wnnGR2fv2Idtp
         kRP0LW581hJkOhELk+cMkqFDNs6USbJdVwrwZMYpEVcWmRFtU02TZhZxNqezVwjLPB
         NxWvPWgtw2ZLNi+mWFMo2mBO3VeHj9CYg9Aqviho=
Date:   Fri, 3 Jun 2022 10:15:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] rbtree: Replace kernel.h with the necessary
 inclusions
Message-Id: <20220603101527.39a069809dd8c0b72920fca4@linux-foundation.org>
In-Reply-To: <20220603171012.48880-1-andriy.shevchenko@linux.intel.com>
References: <20220603171012.48880-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Jun 2022 20:10:12 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> When kernel.h is used in the headers it adds a lot into dependency hell,
> especially when there are circular dependencies are involved.
> 
> Replace kernel.h inclusion with the list of what is really being used.

There are surely thousands of files we could do this with.  Is this the
start of a lifelong project, or is there something special about
rbtree.h?

