Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA2F5250E0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiELPHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355404AbiELPHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:07:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4549149A8C;
        Thu, 12 May 2022 08:07:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A8AEB828B1;
        Thu, 12 May 2022 15:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE97C385B8;
        Thu, 12 May 2022 15:07:26 +0000 (UTC)
Date:   Thu, 12 May 2022 11:07:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     agordeev@linux.ibm.com, aou@eecs.berkeley.edu,
        borntraeger@linux.ibm.com, bp@alien8.de,
        dave.hansen@linux.intel.com, gor@linux.ibm.com, hca@linux.ibm.com,
        hpa@zytor.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux@armlinux.org.uk,
        mingo@redhat.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
        svens@linux.ibm.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH] kernel: Ftrace seems to have functions to improve
 performance through optimization
Message-ID: <20220512110725.22e69e3c@gandalf.local.home>
In-Reply-To: <20220512144533.58085-1-kunyu@nfschina.com>
References: <20220512101229.7886a798@gandalf.local.home>
        <20220512144533.58085-1-kunyu@nfschina.com>
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

On Thu, 12 May 2022 22:45:32 +0800
Li kunyu <kunyu@nfschina.com> wrote:

> I'm glad you're willing to reply to me. 
> My current English level is limited, and I may not describe it correctly. 
> I consider that these functions may not be modified in a short time,
> which may bring advantages in function performance. I could only submit
> it by inquiry.

The performance improvement is negligible, and not worth the churn (changes
to the code). And if that is the reason for the change, it is not worth
adding it.

Now if the reason for the change is to clean up the code to remove
something that is not used, then it may be something to add if it is not
too intrusive.

-- Steve

