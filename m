Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8F246118E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241227AbhK2KDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:03:53 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44412 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344800AbhK2KBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:01:53 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9A589212C9;
        Mon, 29 Nov 2021 09:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638179914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XkhdkG7XW4+fHK03rqnHz/sVBzcCQWhbPjoPuh5XIEY=;
        b=FO5hsrNTdoK1utG0AENgiZPLMPeUg1JS0z8cguCO9qUxrIGFmf8FcGpVkUPKatepWvjAXH
        d11Oa4z989U7qY6leknlK9Fv3y06zp9OMALI+GdLjZ87K2m406tGVOcL9PvrDd1GhCJx0j
        pEgmRLhvMb4IILS+1O1y4nDh8TKYn94=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6D353A3B81;
        Mon, 29 Nov 2021 09:58:34 +0000 (UTC)
Date:   Mon, 29 Nov 2021 10:58:34 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] vsprintf: Use non-atomic bitmap API when applicable
Message-ID: <YaSkSnLws3zSDhJT@alley>
References: <1abf81a5e509d372393bd22041eed4ebc07ef9f7.1638023178.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1abf81a5e509d372393bd22041eed4ebc07ef9f7.1638023178.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2021-11-27 15:27:35, Christophe JAILLET wrote:
> The 'set' bitmap is local to this function. No concurrent access to it is
> possible.
> So prefer the non-atomic '__[set|clear]_bit()' function to save a few
> cycles.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Makes sense:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
