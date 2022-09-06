Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CED5AF71A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiIFVlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIFVlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:41:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454BA8671E;
        Tue,  6 Sep 2022 14:41:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D56F06132D;
        Tue,  6 Sep 2022 21:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEFCC433C1;
        Tue,  6 Sep 2022 21:41:01 +0000 (UTC)
Date:   Tue, 6 Sep 2022 17:41:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arun Easi <aeasi@marvell.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Nilesh Javali <njavali@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: [EXT] build failure of next-20220906 due to 8bfc149ba24c
 ("scsi: qla2xxx: Enhance driver tracing with separate tunable and more")
Message-ID: <20220906174140.41b46a5f@gandalf.local.home>
In-Reply-To: <e9f5eb5e-3830-d19b-dcb0-05f7a36fcb2d@marvell.com>
References: <YxdZ/9XOsWilvVSd@debian>
        <44fe9ca0-e1d7-1e4f-9fd8-0f48a84dca72@marvell.com>
        <CADVatmMsYk+tgJDASx2uoskLzY=b4m7SNo+3R6SXT=0vEnu+vA@mail.gmail.com>
        <20220906170346.52c3f592@gandalf.local.home>
        <e9f5eb5e-3830-d19b-dcb0-05f7a36fcb2d@marvell.com>
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

On Tue, 6 Sep 2022 14:26:31 -0700
Arun Easi <aeasi@marvell.com> wrote:

> Steve, I was thinking both the fixes stay at least for a short 
> term the one in qla2xxx to avoid tree dependencies.
> 
> Since, the qla_def.h change goes as:
> 
> +#ifndef CONFIG_TRACING
> +#ifndef trace_array_get_by_name
> 
> ..it should co-exist when the "#define trace_array_get_by_name" gets 
> merged in include/linux/trace.h. BTW, I will send out the changes to 
> trace.h today.
> 
> Other alternatives/suggestions welcome.

I doubt I'll have anything that conflicts with an update to
include/linux/trace.h, as it is seldom modified.

Just sent a patch out that updates that file and I'll review it, and then
you can push it through your tree.

-- Steve
