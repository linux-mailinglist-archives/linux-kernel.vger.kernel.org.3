Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED304C4B9A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243458AbiBYRGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238530AbiBYRF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:05:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AFE1FEFB4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:05:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AD9BB8329E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 17:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174FDC340E7;
        Fri, 25 Feb 2022 17:05:20 +0000 (UTC)
Date:   Fri, 25 Feb 2022 12:05:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] tracing: Have traceon and traceoff trigger honor the
 instance
Message-ID: <20220225120459.738858e9@gandalf.local.home>
In-Reply-To: <d3004368d5784e3c2a40e3229d3618a88924b11e.camel@kernel.org>
References: <20220223223837.14f94ec3@rorschach.local.home>
        <d3004368d5784e3c2a40e3229d3618a88924b11e.camel@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022 11:00:18 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> Looks good,
> 
> Reviewed-by: Tom Zanussi <zanussi@kernel.org>

Thanks.

Oo, I was just about to send my pull request. It's not too late to add
this tag ;-)

-- Steve
