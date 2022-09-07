Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25E85B1003
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 00:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiIGWtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 18:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiIGWtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 18:49:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4315E13D2C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 15:49:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECA12B81F53
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 22:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0099DC433C1;
        Wed,  7 Sep 2022 22:49:34 +0000 (UTC)
Date:   Wed, 7 Sep 2022 18:50:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     "Christian A. Ehrhardt" <lk@c--e.de>, linux-kernel@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] kprobes: prohibit probes in gate area
Message-ID: <20220907185015.6dd88b43@gandalf.local.home>
In-Reply-To: <20220908073217.7ee9ecd48766507329fbcac2@kernel.org>
References: <20220907200917.654103-1-lk@c--e.de>
        <20220908073217.7ee9ecd48766507329fbcac2@kernel.org>
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

On Thu, 8 Sep 2022 07:32:17 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Good catch! kprobes should not probe vsyscall area.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Cc: stable@vger.kernel.org

Thanks, I can pull it into my next push to Linus.

-- Steve
