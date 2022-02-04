Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7314A9DDE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377023AbiBDRmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:42:17 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58018 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbiBDRmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:42:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F06EACE23D2;
        Fri,  4 Feb 2022 17:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE5CC004E1;
        Fri,  4 Feb 2022 17:42:10 +0000 (UTC)
Date:   Fri, 4 Feb 2022 12:42:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH 3/4] rtla/trace: Error message fixup
Message-ID: <20220204124209.18b08abf@gandalf.local.home>
In-Reply-To: <361697d27431afefa64c67c323564205385c418d.1643990447.git.bristot@kernel.org>
References: <cover.1643990447.git.bristot@kernel.org>
        <361697d27431afefa64c67c323564205385c418d.1643990447.git.bristot@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Feb 2022 17:24:04 +0100
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> Use capital and change "tracer %s" to "%s tracer".
> 
> No functional change.

Technically, there is a functional change. Yes, changing output strings is
functional changes. What a non functional change would be, is moving code
around, but the logic stays the same (or adding macro helpers, and such).

I'll keep this as is, but just stating it as an FYI.

-- Steve
