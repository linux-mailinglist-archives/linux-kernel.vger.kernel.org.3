Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B550954EF7F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 05:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379482AbiFQCkj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Jun 2022 22:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbiFQCkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 22:40:37 -0400
Received: from relay3.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87C864D18
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 19:40:36 -0700 (PDT)
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id DA6B77A0;
        Fri, 17 Jun 2022 02:40:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id C39712F;
        Fri, 17 Jun 2022 02:40:34 +0000 (UTC)
Message-ID: <e0b7573a146da0aee33b3b21c66805bedad598f3.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Fix parsing usbhid from
 scripts/get_maintainer.pl
From:   Joe Perches <joe@perches.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        benjamin.tissoires@redhat.com, jikos@kernel.org,
        open list <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 16 Jun 2022 19:40:34 -0700
In-Reply-To: <20220616183322.14861-1-mario.limonciello@amd.com>
References: <20220616183322.14861-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: C39712F
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Stat-Signature: jds7iyducmwkpgid3s7s8h8tiuk5d86b
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18HBYbHl0rcp66f2ifRDTgxqgukLRqASjg=
X-HE-Tag: 1655433634-480413
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-16 at 13:33 -0500, Mario Limonciello wrote:
> Recently trying to send a patch, I found that `./scripts/get_maintainer.pl`
> didn't want to parse the usbhid section because of too long of a line
> leading to a missing parenthesis.  To fix this, change () to [] so it can
> parse even the long line.
[]
> (to-cmd) Adding to: linux-usb@vger.kernel.org (open list:USB HID/HIDBP DRIVERS (USB KEYBOARDS, MICE, REM...) from: 'scripts/get_maintainer.pl'
> (to-cmd) Adding to: linux-input@vger.kernel.org (open list:HID CORE LAYER) from: 'scripts/get_maintainer.pl'
> (to-cmd) Adding to: linux-kernel@vger.kernel.org (open list) from: 'scripts/get_maintainer.pl'
> Unmatched () '(open list:USB HID/HIDBP DRIVERS (USB KEYBOARDS, MICE, REM...)' '' at /usr/lib/git-core/git-send-email line 546.
> error: unable to extract a valid address from: linux-usb@vger.kernel.org (open list:USB HID/HIDBP DRIVERS (USB KEYBOARDS, MICE, REM...)

And it wasn't get_maintainer, it was git send-email that found that
the specific get_maintainer output was not a 'valid' email address
with a balanced parenthesis comment.

> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -20537,7 +20537,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git
>  F:	drivers/usb/gadget/
>  F:	include/linux/usb/gadget*
>  
> -USB HID/HIDBP DRIVERS (USB KEYBOARDS, MICE, REMOTE CONTROLS, ...)
> +USB HID/HIDBP DRIVERS [USB KEYBOARDS, MICE, REMOTE CONTROLS, ...]
>  M:	Jiri Kosina <jikos@kernel.org>
>  M:	Benjamin Tissoires <benjamin.tissoires@redhat.com>
>  L:	linux-usb@vger.kernel.org

