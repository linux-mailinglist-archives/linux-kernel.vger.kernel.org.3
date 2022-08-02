Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D3A587521
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbiHBBmu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 Aug 2022 21:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiHBBms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:42:48 -0400
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A9E17E37
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 18:42:47 -0700 (PDT)
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay03.hostedemail.com (Postfix) with ESMTP id 62968A0D0C;
        Tue,  2 Aug 2022 01:42:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 0C36B30;
        Tue,  2 Aug 2022 01:42:44 +0000 (UTC)
Message-ID: <b43b3babb8aea836add289245c640688bec87829.camel@perches.com>
Subject: Re: [PATCH -next] f2fs: Replace kmalloc() with f2fs_kmalloc
From:   Joe Perches <joe@perches.com>
To:     Christoph Hellwig <hch@infradead.org>, studentxswpy@163.com
Cc:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Hacash Robot <hacashRobot@santino.com>
Date:   Mon, 01 Aug 2022 18:42:44 -0700
In-Reply-To: <YugaBtQcoR4XhXiQ@infradead.org>
References: <20220801092202.3134668-1-studentxswpy@163.com>
         <YugaBtQcoR4XhXiQ@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: wdqedbwedqttrydjhn48w4z4t5k69399
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 0C36B30
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18zQ27Sw8bVrVJiHLv86TbextMAqxUL208=
X-HE-Tag: 1659404564-617352
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-08-01 at 11:23 -0700, Christoph Hellwig wrote:
> On Mon, Aug 01, 2022 at 05:22:02PM +0800, studentxswpy@163.com wrote:
> > From: Xie Shaowen <studentxswpy@163.com>
> > 
> > replace kmalloc with f2fs_kmalloc to keep f2fs code consistency.
> 
> For that removing f2fs_kmalloc entirely would be way better.

Dunno, maybe doubtful as there's a specific "fault injector" test
built around f2fs_<foo>alloc. (CONFIG_F2FS_FAULT_INJECTION)

For a student lesson, it would significantly better to compile any
patch, especially to avoid broken patches, before submitting them.


