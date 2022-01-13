Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E4E48DF91
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 22:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbiAMV1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 16:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbiAMV1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 16:27:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFE2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 13:27:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A452B8239F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 21:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9ADC36AE3;
        Thu, 13 Jan 2022 21:27:03 +0000 (UTC)
Date:   Thu, 13 Jan 2022 16:27:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [for-next][PATCH 05/31] tracing: Have existing
 event_command.parse() implementations use helpers
Message-ID: <20220113162702.695d34a0@gandalf.local.home>
In-Reply-To: <20220113162058.04731caf@gandalf.local.home>
References: <20220111173030.999527342@goodmis.org>
        <20220111173114.155260134@goodmis.org>
        <388b9922-4231-6e34-1305-f0b439d9d07c@kernel.org>
        <20220113162058.04731caf@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2022 16:20:58 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> I will not be adding this to this merge window.

And it appears that "tracing: Remove redundant trigger_ops params" does not
apply cleanly without this patch, so I'm dropping that one too.

-- Steve
