Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DDE5B0E65
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiIGUna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiIGUnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:43:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB66AF48E;
        Wed,  7 Sep 2022 13:43:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B41261A8D;
        Wed,  7 Sep 2022 20:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2C8C433C1;
        Wed,  7 Sep 2022 20:43:20 +0000 (UTC)
Date:   Wed, 7 Sep 2022 16:44:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Arun Easi <aeasi@marvell.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v2 1/1] tracing: Fix compile error in trace_array calls
 when TRACING is disabled
Message-ID: <20220907164400.759e2ee3@gandalf.local.home>
In-Reply-To: <60870376-3518-896b-7a6b-a4b9ea05264f@acm.org>
References: <20220907185745.14382-1-aeasi@marvell.com>
        <20220907185745.14382-2-aeasi@marvell.com>
        <60870376-3518-896b-7a6b-a4b9ea05264f@acm.org>
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

On Wed, 7 Sep 2022 12:27:33 -0700
Bart Van Assche <bvanassche@acm.org> wrote:

> On 9/7/22 11:57, Arun Easi wrote:
> > +#else	/* CONFIG_TRACING */
> > +static inline int register_ftrace_export(struct trace_export *export)
> > +{
> > +	return -EINVAL;
> > +}
> > +static inline int unregister_ftrace_export(struct trace_export *export)
> > +{
> > +	return 0;
> > +}  
> 
> Isn't it recommended to leave a blank line between function definitions?

Not really for stub functions in header files.

-- Steve
