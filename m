Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84F35AF685
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 23:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiIFVDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 17:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiIFVDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 17:03:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78571A924A;
        Tue,  6 Sep 2022 14:03:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87DB1B81A37;
        Tue,  6 Sep 2022 21:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A29EC433C1;
        Tue,  6 Sep 2022 21:03:07 +0000 (UTC)
Date:   Tue, 6 Sep 2022 17:03:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Arun Easi <aeasi@marvell.com>, Nilesh Javali <njavali@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: [EXT] build failure of next-20220906 due to 8bfc149ba24c
 ("scsi: qla2xxx: Enhance driver tracing with separate tunable and more")
Message-ID: <20220906170346.52c3f592@gandalf.local.home>
In-Reply-To: <CADVatmMsYk+tgJDASx2uoskLzY=b4m7SNo+3R6SXT=0vEnu+vA@mail.gmail.com>
References: <YxdZ/9XOsWilvVSd@debian>
        <44fe9ca0-e1d7-1e4f-9fd8-0f48a84dca72@marvell.com>
        <CADVatmMsYk+tgJDASx2uoskLzY=b4m7SNo+3R6SXT=0vEnu+vA@mail.gmail.com>
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

On Tue, 6 Sep 2022 21:57:10 +0100
Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:

> Thanks, that fixed the build for me. The patch did not apply directly
> on next-20220906, so I had to modify it a little bit.
> 
> Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Well, the change needs to go into include/linux/trace.h though.

-- Steve

