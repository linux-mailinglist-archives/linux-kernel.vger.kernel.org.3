Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1FA533BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbiEYLal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238902AbiEYLad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:30:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF18B9EB6B
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 04:30:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C28C615AF
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1E4C385B8;
        Wed, 25 May 2022 11:30:29 +0000 (UTC)
Date:   Wed, 25 May 2022 07:30:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        lkp@intel.com
Subject: Re: [PATCH] ftrace/fgraph: fix increased missing-prototypes
 warnings
Message-ID: <20220525073028.3533ac5c@gandalf.local.home>
In-Reply-To: <Yo3paLdqS7oJ/ueL@arm.com>
References: <20220506032737.23375-1-zhouchengming@bytedance.com>
        <20220524191718.5d906700@gandalf.local.home>
        <Yo3paLdqS7oJ/ueL@arm.com>
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

On Wed, 25 May 2022 09:31:36 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> > The change this fixes was merged into the ARM tree and I do not have that
> > code, so I can not apply this.  
> 
> Ah, I missed this patch. The commit mentioned is in mainline now but I'm
> happy to add it to the arm64 tree and send before -rc1.

Please do, thanks.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
