Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33D3597E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 07:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243304AbiHRFsb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 18 Aug 2022 01:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238680AbiHRFs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 01:48:28 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E492317B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 22:48:25 -0700 (PDT)
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id D6C881417FB;
        Thu, 18 Aug 2022 05:48:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id D330B20030;
        Thu, 18 Aug 2022 05:48:22 +0000 (UTC)
Message-ID: <cf4ee22c2bcfa00c7ae8f19c1ae8800f789a4f7f.camel@perches.com>
Subject: Re: [PATCH] improve the kernel quality and reduce the amount of BS
 patches
From:   Joe Perches <joe@perches.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Paul Lemmermann <thepaulodoom@thepaulodoom.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 18 Aug 2022 01:48:21 -0400
In-Reply-To: <YvxNvpF7n1VqNnbD@ZenIV>
References: <YvxF0yn07ztg9r4A@gus-fring.localdomain>
         <YvxNvpF7n1VqNnbD@ZenIV>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: D330B20030
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: z1qpfo4tgry3bp9w1nzbb8ipzn4p7bdq
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX186jvNGhNmV/LCc/lt8ollBDUsgJF5X50U=
X-HE-Tag: 1660801702-159636
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-08-17 at 03:09 +0100, Al Viro wrote:
> this idiocy has gone too far    

Al's semi-annual post?

From 2015:

https://lore.kernel.org/all/bb0fd4fc28b844ac9b63a58c9ffd24a88f7f78cc.1473875340.git.joe@perches.com/

checkpatch can be a useful tool for patches.

It can be a much more controversial tool when used on files with the
-f option for style and whitespace changes for code that is relatively
stable, obsolete, or for maintained by specific individuals.

o By default, allow checkpatch to be used with the -f|--file option
  for files in drivers/staging/
o Add an undocumented --force command line option to be used together
  with the -f|--file option to scan any file


