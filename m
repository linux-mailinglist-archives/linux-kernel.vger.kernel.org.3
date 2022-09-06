Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89195AF0E1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbiIFQoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiIFQnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:43:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490C262C0;
        Tue,  6 Sep 2022 09:21:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B5BC614AA;
        Tue,  6 Sep 2022 16:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70F9C433C1;
        Tue,  6 Sep 2022 16:21:14 +0000 (UTC)
Date:   Tue, 6 Sep 2022 12:21:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arun Easi <aeasi@marvell.com>
Cc:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Nilesh Javali <njavali@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-next@vger.kernel.org>
Subject: Re: [EXT] build failure of next-20220906 due to 8bfc149ba24c
 ("scsi: qla2xxx: Enhance driver tracing with separate tunable and more")
Message-ID: <20220906122153.2756a601@gandalf.local.home>
In-Reply-To: <44fe9ca0-e1d7-1e4f-9fd8-0f48a84dca72@marvell.com>
References: <YxdZ/9XOsWilvVSd@debian>
        <44fe9ca0-e1d7-1e4f-9fd8-0f48a84dca72@marvell.com>
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

On Tue, 6 Sep 2022 09:05:38 -0700
Arun Easi <aeasi@marvell.com> wrote:

> This looks like is happening due to CONFIG_TRACING not being enabled (same 
> as what kernel test bot reported). Could you try out the fix attached?
> 
> @Steven, please see the patch attached. Do you think the fix belongs 
> better in linux/trace.h ?

Yes, of course. Feel free to send me a patch.

Thanks!

-- Steve
