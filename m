Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA4957DBC5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbiGVIJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbiGVIJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:09:32 -0400
Received: from hetzy.fluff.org (test-v6.fluff.org [IPv6:2a01:4f8:222:2004::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316299B9E9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:09:31 -0700 (PDT)
Received: from ben by hetzy.fluff.org with local (Exim 4.89)
        (envelope-from <ben@fluff.org>)
        id 1oEnb1-0004YL-H3; Fri, 22 Jul 2022 09:01:15 +0100
Date:   Fri, 22 Jul 2022 09:01:15 +0100
From:   Ben Dooks <ben@fluff.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kallsyms: make arch_get_kallsym() static
Message-ID: <20220722080115.pzryb7dy2ijbp6p7@hetzy.fluff.org>
References: <20220721151040.359389-1-ben-linux@fluff.org>
 <YtlvP1toPTmv4brF@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtlvP1toPTmv4brF@infradead.org>
X-Disclaimer: These are my views alone.
X-URL:  http://www.fluff.org/
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@fluff.org
X-SA-Exim-Scanned: No (on hetzy.fluff.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 08:22:39AM -0700, Christoph Hellwig wrote:
> On Thu, Jul 21, 2022 at 04:10:40PM +0100, Ben Dooks wrote:
> > The arch_get_kallsym() function is not used anywhere in the kernel
> > now, so it should at-least be static or just be removed as there
> > are no users. Making it static fixes the following sparse warning:
> > 
> > kernel/kallsyms.c:590:12: warning: symbol 'arch_get_kallsym' was not declared. Should it be static?
> 
> It fixes the warning, but isn't exactly useful.  Please just remove it,
> get_ksymbol_arch and iter->pos_arch_end entirely instead.

Ok, probably the best. I didn't have time to do any archeaology on it
to find out if it has ever been used.

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.

