Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614BB4A5CC4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 14:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbiBANFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 08:05:22 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35526 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237005AbiBANFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:05:20 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8677321126;
        Tue,  1 Feb 2022 13:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643720718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sBxYFAJCAQX6CSJhBPxVq5QhaF2JDCYQQa8Y+JXN928=;
        b=U905hNPcdCZT92cSbu+OOe6HrWQVAz1LRe6hRxknHlbDo8Qtx02OQMB1sl6MBYeHwTS1Lq
        h1+g+4BBCDh6vHvfMIqeVLhRXh5Kkvx/05c8BrRAJHGP8M7CI+MdbI8y7OEYBCjlXor1Gf
        uMy7Ehe/MkMt1MRuo8JRQaTlVCZ+VfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643720718;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sBxYFAJCAQX6CSJhBPxVq5QhaF2JDCYQQa8Y+JXN928=;
        b=hfrGUmMkdogK/lj6hf9K/QNFAqymFLrole+umRmXdOkWUWozlzPyW3+BeyjjJs+5yM8vXx
        I8F6dwgd8Tm8sLAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 701F013D6C;
        Tue,  1 Feb 2022 13:05:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q//iGQ4w+WHvYwAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 01 Feb 2022 13:05:18 +0000
Date:   Tue, 1 Feb 2022 14:05:18 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: vmlinux.o: warning: objtool: do_machine_check()+0x5fa: call to
 memset() leaves .noinstr.text section
Message-ID: <YfkwDvHvsVL/K/qu@zn.tnic>
References: <20220119104017.31e5ecc7@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <20220119111523.71f8e9e3@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <Yeh013gIveIKdFMP@zn.tnic>
 <20220119123714.22b54d4c@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <Yeh/oEYGyg2+XYSJ@zn.tnic>
 <20220119145727.2034a180@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <YeicA7BKdstxbteX@zn.tnic>
 <20220119153218.02ee6789@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <YffQ1XJ+9YAVa163@zn.tnic>
 <20220131085611.4371c9da@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220131085611.4371c9da@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 08:56:11AM -0800, Jakub Kicinski wrote:
> CLEAN! All the warnings are gone, thank you :)

Thanks for testing. I'll run some more randconfig build tests and send
them out properly.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
