Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95723582BED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbiG0QkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239526AbiG0QjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:39:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC275A2F7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:28:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7CCCB821C8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 16:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86838C433D7;
        Wed, 27 Jul 2022 16:28:49 +0000 (UTC)
Date:   Wed, 27 Jul 2022 12:28:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Li Qiong <liqiong@nfschina.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        yuzhe@nfschina.com, renyu@nfschina.com, jiaming@nfschina.com
Subject: Re: [PATCH] tracing: Do PTR_ERR() after IS_ERR()
Message-ID: <20220727122847.6b00e29d@rorschach.local.home>
In-Reply-To: <20220727153519.6697-1-liqiong@nfschina.com>
References: <20220727153519.6697-1-liqiong@nfschina.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 23:35:19 +0800
Li Qiong <liqiong@nfschina.com> wrote:

> Check IS_ERR() firstly, then do PTR_ERR().

Why?

The code is fine as is.

-- Steve

