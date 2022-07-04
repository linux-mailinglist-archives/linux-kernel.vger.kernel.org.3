Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74501564D88
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 08:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiGDGLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 02:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiGDGLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 02:11:07 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C488C2BCD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 23:11:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 99CC168AA6; Mon,  4 Jul 2022 08:11:03 +0200 (CEST)
Date:   Mon, 4 Jul 2022 08:11:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: __dynamic_array() of 1 in blktrace?
Message-ID: <20220704061103.GA29005@lst.de>
References: <20220701122400.5a0f367e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701122400.5a0f367e@gandalf.local.home>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 12:24:00PM -0400, Steven Rostedt wrote:
> Is this to keep backward compatibility with user space?

I think so.  This used to trace the SCSI CDB when that was still
part of the block layer.

> does it need to be a dynamic array?

I have no idea.  We can try it and see if anyone complains.
