Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9945651FEEA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbiEIN6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236657AbiEIN6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:58:49 -0400
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEED1DE571;
        Mon,  9 May 2022 06:54:54 -0700 (PDT)
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 71EF221114;
        Mon,  9 May 2022 13:54:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 55AAE2002C;
        Mon,  9 May 2022 13:54:52 +0000 (UTC)
Message-ID: <5e44ef1302b722d3bf7fafe55111e76f7173e6be.camel@perches.com>
Subject: Re: [PATCH] staging: drivers: hid: hid-asus.c: Optimized input
 logic for keys
From:   Joe Perches <joe@perches.com>
To:     Johan Boger <jb@ip.fi>, jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 09 May 2022 06:54:51 -0700
In-Reply-To: <20220509100258.24764-1-jb@ip.fi>
References: <20220509100258.24764-1-jb@ip.fi>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: uikmp1cmopecb6ysxgrm8uthrk5qbnkd
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 55AAE2002C
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19siEZ6i90BjYKhTg3/vNQyMSOLpCRnlsQ=
X-HE-Tag: 1652104492-339497
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-09 at 12:02 +0200, Johan Boger wrote:
> Instead of calling asus_map_key_clear() function in each case,
> we now set a temporary value and clear it after default.
> Patch was checked by checkpatch and adjusted accordingly.

This patch subject is not correct.  This is not a staging patch.

Your commit message is also incomplete as this is modifying comments,
changing whitespace, and changing brace styles.

and IMO:

Either use a single line case style like:

	case foo: statement; break;

or use a multiple line case style like:

	case foo:
		statement;
		break;

but please do not use a mixed case one line and statement; break;
on another like:

	case foo:
		statement; break;

Please remember checkpatch is only a guide, it's not the last word
on style where every message it emits requires an actual code change.

btw: there are _many_ single line case uses in the kernel

$ git grep  -P 'case\s+\w+\s*:\s*\w+' -- '*.[ch]' | wc -l
7581



