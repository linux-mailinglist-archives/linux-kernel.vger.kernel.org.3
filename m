Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE9F4EB82E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 04:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241935AbiC3CHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 22:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbiC3CH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 22:07:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF2C1081BE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 19:05:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FDFE613E9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D11FC340ED;
        Wed, 30 Mar 2022 02:05:13 +0000 (UTC)
Date:   Tue, 29 Mar 2022 22:05:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] MAINTAINERS: Enlarge coverage of TRACING inside
 architectures
Message-ID: <20220329220511.62977a6c@gandalf.local.home>
In-Reply-To: <e8338c0ad0e73991cbd8f31c215b16ea4efe212d.1648189904.git.christophe.leroy@csgroup.eu>
References: <e8338c0ad0e73991cbd8f31c215b16ea4efe212d.1648189904.git.christophe.leroy@csgroup.eu>
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

On Fri, 25 Mar 2022 07:32:21 +0100
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Most architectures have ftrace related stuff in arch/*/kernel/ftrace.c
> but powerpc has it spread in multiple files located in
> arch/powerpc/kernel/trace/
> In several architectures, there are also additional files containing
> 'ftrace' as part of the name but with some prefix or suffix.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
