Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE59493780
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346503AbiASJmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:42:11 -0500
Received: from relay039.a.hostedemail.com ([64.99.140.39]:59750 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235918AbiASJmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:42:10 -0500
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 2A45160D46;
        Wed, 19 Jan 2022 09:42:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id E581160011;
        Wed, 19 Jan 2022 09:41:52 +0000 (UTC)
Message-ID: <a70570a10026203b544e930eb6dbcf6ad0abb2ad.camel@perches.com>
Subject: Re: [RESEND][PATCH] checkpatch: make sure fix-up patches have Fixes
 tag
From:   Joe Perches <joe@perches.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org
Date:   Wed, 19 Jan 2022 01:42:07 -0800
In-Reply-To: <20220119074609.4162747-1-senozhatsky@chromium.org>
References: <20220119074609.4162747-1-senozhatsky@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E581160011
X-Spam-Status: No, score=-3.46
X-Stat-Signature: pq91pwppiwszaru1nja6fbhn5nzr3pa1
X-Rspamd-Server: rspamout06
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/muev3J1Q3SckGCYJZ2STxKt8yI1QIKsU=
X-HE-Tag: 1642585312-887275
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-01-19 at 16:46 +0900, Sergey Senozhatsky wrote:
> If a patch contains "commit hash (commit name)", in other words
> if the patch fixes some particular commit, then require "Fixes:"
> tag.

I do not like this patch as many commits merely reference a
previous patch and do not actually fix anything.


