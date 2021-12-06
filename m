Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C42469645
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243823AbhLFNJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:09:02 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53606 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbhLFNJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:09:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7498421B40;
        Mon,  6 Dec 2021 13:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638795931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=seNcCVmeKjbuPvrYBKoc8yqPAgK6xtZS/e04+RONdyQ=;
        b=gv8BtY7lhi1h6/ghlaI9FyA47oIzeGMuyuzzrPZSWAyCnBCRZEMYROlsPn7fbTGEs2F9wg
        dBDEk4aAaJ/6RJTIT9yaXY5B3hUV3rsT+TTdH2Z3yMiIa8luuzqJ1n1k/e4WGsZY4TQ13T
        cS5BL0l5pDz+EMTcPHb4SuPb/jX8a8Y=
Received: from suse.cz (unknown [10.163.24.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 80EDAA3B8B;
        Mon,  6 Dec 2021 13:05:30 +0000 (UTC)
Date:   Mon, 6 Dec 2021 14:05:30 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] vsprintf: Use non-atomic bitmap API when applicable
Message-ID: <Ya4Kmsu3rO8o0gGb@alley>
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

The patch has been committed into printk/linux.git, branch for-5.17.

Best Regards,
Petr
