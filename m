Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A245250CD23
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 21:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbiDWTFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 15:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiDWTFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 15:05:53 -0400
Received: from relay.hostedemail.com (relay.hostedemail.com [64.99.140.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DC11C6C9E
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 12:02:56 -0700 (PDT)
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id 200C11215B1;
        Sat, 23 Apr 2022 19:02:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 5BE202002A;
        Sat, 23 Apr 2022 19:02:54 +0000 (UTC)
Message-ID: <97899995717e1ebd12f97c5df2b8e37ba6f6aa7b.camel@perches.com>
Subject: Re: [PATCH] scripts: get_maintainer: add an option to format for
 command line
From:   Joe Perches <joe@perches.com>
To:     Ian Cowan <ian@linux.cowan.aero>
Cc:     linux-kernel@vger.kernel.org
Date:   Sat, 23 Apr 2022 12:02:53 -0700
In-Reply-To: <20220423185552.126453-1-ian@linux.cowan.aero>
References: <20220423185552.126453-1-ian@linux.cowan.aero>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: zj3ezcznfoidoznrh4eyo6armekew6ha
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 5BE202002A
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/w1MIXMcbCKzYmRFcU+v3W+K6L4HNWCHY=
X-HE-Tag: 1650740574-447406
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-04-23 at 14:55 -0400, Ian Cowan wrote:
> This adds the option to return the list of maintainers in the format for
> sending via command line, specifically targeted for `git send-email`.
> This will add a `--to` tag before the first email and a `--cc` tag for
> each following email. The option can be toggled by using the
> `--cl-format` flag when calling the get_maintainer script.
> 
> The new addition is disabled by default and will only print (even if
> enabled) if there are maintainers to return. This will prevent the
> script from trying to generate a formatted line without any maintainers
> and also allow the user to visually verify that the outputted line contains
> the correct maintainers and lists (by verifying the roles).

nack.

get_maintainers does not need to be the be-all/end-all script
for every purpose.

Try adding wrapper scripts instead.

I use something like this:

https://lore.kernel.org/lkml/1473862411.32273.25.camel@perches.com/


