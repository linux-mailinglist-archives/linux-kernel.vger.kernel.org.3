Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258ED57DB8B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbiGVHxX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 22 Jul 2022 03:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbiGVHxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:53:21 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD769A6AD;
        Fri, 22 Jul 2022 00:53:18 -0700 (PDT)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 6F2D7C0B39;
        Fri, 22 Jul 2022 07:53:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 5896E80013;
        Fri, 22 Jul 2022 07:53:16 +0000 (UTC)
Message-ID: <bf9c7aaae2ca014b6efde5b75015eea592519348.camel@perches.com>
Subject: Re: [PATCH] MIPS: octeon: Remove vestiges of CONFIG_CAVIUM_RESERVE32
From:   Joe Perches <joe@perches.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        David Daney <david.daney@cavium.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 22 Jul 2022 00:53:15 -0700
In-Reply-To: <6878a4d0-a12d-ae8c-f5b1-08147203cd7d@nokia.com>
References: <997c0cdbd57752252d87129185a973c7d42e491f.camel@perches.com>
         <6878a4d0-a12d-ae8c-f5b1-08147203cd7d@nokia.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: ei7cwbkqae1rpph8o7gxye4wnuk1tzjx
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5896E80013
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+smh2uOrsIJDJmilS5WuOIY898ZufzWe0=
X-HE-Tag: 1658476396-942418
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-07-21 at 14:19 +0200, Alexander Sverdlin wrote:
> Hello Joe!
> 
> On 13/07/2021 19:49, Joe Perches wrote:
> > The config option CAVIUM_RESERVE32 is not used.
> 
> We use it. Does it make sense that I submit a revert and a patch adding the option to Kconfig?

yes.

