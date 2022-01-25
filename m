Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5638349AC50
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245358AbiAYGVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:21:41 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57196 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244269AbiAYGSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 01:18:23 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1280221997;
        Tue, 25 Jan 2022 06:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643091502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=okVdD3yXH7+EfR/ObVe5yV4UjeKzNbRn/qqr4s3wyKU=;
        b=M4QhN/qEuhm28gnXfRnLcVlKnsZWajHT5wNfgxX36DKuDFgv17pPKjClihfZIDllxFE8oV
        1hd5QjX84LL6vwDYPpCGyXmHAfqwWQBKA7qrcBq5hdR7hIJ6ftfhdrtYsiHSTB5/xkC9Fu
        y+nEdFceiMJsIeVSGmd0kLN30dDsjp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643091502;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=okVdD3yXH7+EfR/ObVe5yV4UjeKzNbRn/qqr4s3wyKU=;
        b=Y7mRw/syuRqFPLTMRviaAOOdbjesn5TCtBm/jZsGvSjtAq2i+VlEzQX/sDC22Axj4wYPwZ
        OI0HvjWu0oFM/dBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 048C713D7C;
        Tue, 25 Jan 2022 06:18:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 07HhAC6W72HidAAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 25 Jan 2022 06:18:22 +0000
MIME-Version: 1.0
Date:   Tue, 25 Jan 2022 07:18:21 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm, hwpoison: remove obsolete comment
In-Reply-To: <20220125025601.3054511-1-naoya.horiguchi@linux.dev>
References: <20220125025601.3054511-1-naoya.horiguchi@linux.dev>
User-Agent: Roundcube Webmail
Message-ID: <e952b85b5511fa23be3141466be0f4e2@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-25 03:56, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> With the introduction of mf_mutex, most of memory error handling
> process is mutually exclusive, so the in-line comment about
> subtlety about double-checking PageHWPoison is no more correct.
> So remove it.
> 
> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs
