Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2F24A9EC4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377441AbiBDSPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376772AbiBDSPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:15:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F32C061714;
        Fri,  4 Feb 2022 10:15:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0314261BA2;
        Fri,  4 Feb 2022 18:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8359C004E1;
        Fri,  4 Feb 2022 18:15:42 +0000 (UTC)
Date:   Fri, 4 Feb 2022 13:15:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH 4/4] rtla/osnoise: Fix segmentation fault when failing
 to enable -t
Message-ID: <20220204131541.2c47be3f@gandalf.local.home>
In-Reply-To: <23e7889f-9bb4-f607-630f-6f8f0ef90d3d@kernel.org>
References: <cover.1643990447.git.bristot@kernel.org>
        <264ff7941b7551ec0b6e5862e40cf3dd593d0ff0.1643990447.git.bristot@kernel.org>
        <20220204124426.54d82ce2@gandalf.local.home>
        <23e7889f-9bb4-f607-630f-6f8f0ef90d3d@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2022 18:46:59 +0100
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
> As this is not related to the other patches, could you just ignore this one, so
> I can re-send alone?

Sure.

-- Steve
