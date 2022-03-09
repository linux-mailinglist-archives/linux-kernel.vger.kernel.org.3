Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8C14D3764
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbiCIQvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbiCIQgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:36:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD6363D9;
        Wed,  9 Mar 2022 08:31:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF001B82259;
        Wed,  9 Mar 2022 16:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC7AC341E0;
        Wed,  9 Mar 2022 16:31:48 +0000 (UTC)
Date:   Wed, 9 Mar 2022 11:31:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org, mtosatti <mtosatti@redhat.com>
Subject: Re: Warning when exiting osnoise tracer
Message-ID: <20220309113147.7a8d59c6@gandalf.local.home>
In-Reply-To: <20220309105403.66d2b6ef@gandalf.local.home>
References: <c898d1911f7f9303b7e14726e7cc9678fbfb4a0e.camel@redhat.com>
        <eeb95928-02cf-a38c-8079-d2bbf4edb7e7@kernel.org>
        <20220309105403.66d2b6ef@gandalf.local.home>
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

On Wed, 9 Mar 2022 10:54:03 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> lot of noise to dmesg, I can easily miss warnings there. I'll add a test to
> look for Call Traces at the end of the test.

My tests now detect this :-)

I tried it out on the current kernel, and it now gives me a failure if one
of the tests trigger a WARN_ON in the kernel. Which the test that runs a
record against every tracer, including osnoise, just failed on.

-- Steve
