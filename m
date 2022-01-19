Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD71A493FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355437AbiASSee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:34:34 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44612 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245537AbiASSec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:34:32 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 71DC62113A;
        Wed, 19 Jan 2022 18:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642617271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r+0vAbx5GuJjaZYlHTitLUHipZQeqHiPz3K2vzp3o+E=;
        b=a0//ltEUSSBJXoAamSJxck4h0jVSYVBKKnRl1a9HlCVwpRDkQJrA3cNUHJoLS1Ymbp5wND
        +KOqbS5CJXxV+gkfx5ImEn4HYv8EhTEPfKEyg9Ou2Zk4yOe/rMDWxU77INRXYM4aMTXQSn
        o8TwuX1meXFa3NJqxOMcbtDtaeN4AxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642617271;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r+0vAbx5GuJjaZYlHTitLUHipZQeqHiPz3K2vzp3o+E=;
        b=75UXJTYoKHyeqwAB9ciP/aDKdQRAPocg+ruzSL5TzouzUauMxpa8F67lKr4KywCXmEOx3K
        bAEBa5cMEAAq3PAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5568013B2B;
        Wed, 19 Jan 2022 18:34:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ylhfFLdZ6GFxXQAAMHmgww
        (envelope-from <bp@suse.de>); Wed, 19 Jan 2022 18:34:31 +0000
Date:   Wed, 19 Jan 2022 19:34:24 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: vmlinux.o: warning: objtool: do_machine_check()+0x5fa: call to
 memset() leaves .noinstr.text section
Message-ID: <YehZsGAqgd3tJyDV@zn.tnic>
References: <202110261614.Bt8EM6Nj-lkp@intel.com>
 <YXe7AnMmiWXk36NC@zn.tnic>
 <20220119102250.7e20b3df@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220119102250.7e20b3df@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 10:22:50AM -0800, Jakub Kicinski wrote:
> I was hoping that 5.17 would fix this but I just merged Linus's tree
> with netdev today and the warnings are still there :(

Hmm, weird. The set which is supposed to address this got merged last
week:

7e740ae63504 ("Merge tag 'ras_core_for_v5.17_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

How exactly can I reproduce what you're seeing?

I need to merge which commit into which branch and then use which
.config to reproduce?

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
