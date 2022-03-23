Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57AC4E5493
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbiCWOxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236610AbiCWOxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:53:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939AD7D01F;
        Wed, 23 Mar 2022 07:51:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3983E61776;
        Wed, 23 Mar 2022 14:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF768C340E8;
        Wed, 23 Mar 2022 14:51:46 +0000 (UTC)
Date:   Wed, 23 Mar 2022 10:51:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH] tracing: Have trace event string test handle zero
 length strings
Message-ID: <20220323105145.4550b3b7@gandalf.local.home>
In-Reply-To: <Yjsyt/6OeFSRsmcq@bfoster>
References: <20220323103912.097ad3a8@gandalf.local.home>
        <Yjsyt/6OeFSRsmcq@bfoster>
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

On Wed, 23 Mar 2022 10:46:15 -0400
Brian Foster <bfoster@redhat.com> wrote:

> FWIW:
> 
> Tested-by: Brian Foster <bfoster@redhat.com>

Thanks, I'll add this tag.

-- Steve
