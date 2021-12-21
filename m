Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE43947C290
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239192AbhLUPPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:15:00 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36258 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239203AbhLUPO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:14:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8B28B1F3A6;
        Tue, 21 Dec 2021 15:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640099697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AnbLicSC2YsY5mQbeSydJjvdCPuwHdNzrU3R54bii60=;
        b=SEULi+Tu9l+NgIuOrtKxD/WqvCWXBYfa9npIFMs1Kq5If2l3Tjr6AmbDPo4zfwl8C8/aHK
        VFRnyy8dG2HnStSeu5Sg5qGJWkJAJ426Vh1SHpXr4KgOLDsrltsPNQDrY12GPHtGsmFLKm
        Lt+hGzJmTvUMpl4M4A9Mc0KovxS8qkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640099697;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AnbLicSC2YsY5mQbeSydJjvdCPuwHdNzrU3R54bii60=;
        b=j9/M8ZizoX4X2JspGlnMWONniNwh0YcibZUGC+XSkUHfRg6+vqk64565sD/vIWzkESQm9K
        XZyzhGiH//6eNICg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68C2A13C97;
        Tue, 21 Dec 2021 15:14:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6xJhGXHvwWFuYQAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 21 Dec 2021 15:14:57 +0000
Date:   Tue, 21 Dec 2021 16:14:58 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Carel Si <beibei.si@intel.com>
Cc:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [LKP] Re: [x86/mm/64] f154f29085:
 BUG:kernel_reboot-without-warning_in_boot_stage - clang KCOV?
Message-ID: <YcHvcpwQp/3QpF9k@zn.tnic>
References: <20211209144141.GC25654@xsang-OptiPlex-9020>
 <YbjIoewxGaodXHKF@zn.tnic>
 <20211215070012.GA26582@linux.intel.com>
 <Ybm96seTxl+pWjTX@zn.tnic>
 <009391a5-468b-2a5d-1f12-44d2e3104bd6@intel.com>
 <YbsPwyLnejLQMbTb@zn.tnic>
 <20211216115838.GA23522@linux.intel.com>
 <e48b72d4-558a-ed7c-43cd-0cb70091be11@intel.com>
 <YbyIJYzqtHPKRMFt@zn.tnic>
 <20211221143153.GA4676@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211221143153.GA4676@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 10:31:54PM +0800, Carel Si wrote:
> We tested your patch, it can fix the issue, thanks.

You mean "it does fix the issue". :-)

Thanks for testing, I'll add your Tested-by.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
