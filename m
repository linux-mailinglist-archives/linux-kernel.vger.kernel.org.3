Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685184AC69E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356710AbiBGQ7V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Feb 2022 11:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391791AbiBGQsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:48:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AF5C0401D6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:48:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AAB861012
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 16:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82029C004E1;
        Mon,  7 Feb 2022 16:48:14 +0000 (UTC)
Date:   Mon, 7 Feb 2022 11:48:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, jk@ozlabs.org, joel@jms.id.au,
        mingo@redhat.com, alistair@popple.id.au
Subject: Re: [PATCH] fsi: Add trace events in initialization path
Message-ID: <20220207114813.3856554e@gandalf.local.home>
In-Reply-To: <20220207161640.35605-1-eajames@linux.ibm.com>
References: <20220207161640.35605-1-eajames@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Feb 2022 10:16:40 -0600
Eddie James <eajames@linux.ibm.com> wrote:

> Add definitions for trace events to show the scanning flow.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> 

From a tracing point of view, I don't see anything wrong with this patch.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
