Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3D947BCFB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbhLUJhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:37:35 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34288 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236423AbhLUJhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:37:34 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 35DE8212CA;
        Tue, 21 Dec 2021 09:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640079453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tCgtK9DHkpvc2J2vK1/fmontyepwG1iVH4niDlQBmHw=;
        b=fiOCw5J4LEwgEmgBvr/0QHY5qs/CMNf6JsHhInHjvwrzjLB6OoS3gLAbCKMXV6gQlvYNP0
        dCflP0d6PXcrWL3tA1ZNN0DRp+BRkmE8na+AIN3+FXvTGEExYZsh7opS9Ztq6jWmOIBzl5
        WW9YAWLU4GyZB2BKi0KvOuPt08J9E1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640079453;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tCgtK9DHkpvc2J2vK1/fmontyepwG1iVH4niDlQBmHw=;
        b=4vIQ26bnxNPxq5fuYJnbi4PCNTusiz0yFzRXNMGwXYPHH5HPauQihTrSbzX6guRBewhCX2
        PBAvFYDcWWsxQoCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C369413A5F;
        Tue, 21 Dec 2021 09:37:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h/dMLFygwWFVRwAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 21 Dec 2021 09:37:32 +0000
Date:   Tue, 21 Dec 2021 10:37:30 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/hwpoison: clear MF_COUNT_INCREASED before
 retrying get_any_page()
Message-ID: <20211221093730.GA14602@linux>
References: <20211221074908.3910286-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221074908.3910286-1-liushixin2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 03:49:08PM +0800, Liu Shixin wrote:
> Hulk Robot reported a panic in put_page_testzero() when testing madvise()
> with MADV_SOFT_OFFLINE. The BUG() is triggered when retrying get_any_page().
> This is because we keep MF_COUNT_INCREASED flag in second try but the refcnt
> is not increased.
> 
[...]
> 
> Fixes: b94e02822deb ("mm,hwpoison: try to narrow window race for free pages")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs
