Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FCE4B3B56
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 13:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbiBMMhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 07:37:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbiBMMhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 07:37:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9935AEFD
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 04:37:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 54320210EE;
        Sun, 13 Feb 2022 12:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644755831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9czmSGPY3nPWptFPCkPuWs1wn6iugfKjUHNktEIIfn0=;
        b=0vH+7crR/bFQJyUOfn4hDkvNJUhLKPHKaMlk++G0Kli1kd81vhiWpoOGC4S5kTk7tkpk/G
        VaLNbYaq5NIxEjl8Nw1ybtLeXdKK2urLZ+vrn9WtNYKj+je0ayn3g25dSOC92E3LhgpGwU
        FJylmxUn6g0DEKT6UMTjoAW/wuegWIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644755831;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9czmSGPY3nPWptFPCkPuWs1wn6iugfKjUHNktEIIfn0=;
        b=S3pF3WGyvxakE339AYTm9bnkabWgmisRwBgfoG11qf95d4zmSC20qPJEXwfLP9d1mypGev
        Y2KWe9nKfo4aUHCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3347B1331A;
        Sun, 13 Feb 2022 12:37:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tNEmC3f7CGLdQAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 13 Feb 2022 12:37:11 +0000
Date:   Sun, 13 Feb 2022 13:37:17 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for 5.17-rc4
Message-ID: <Ygj7feK+vdtPw6zj@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single urgent scheduling fix for 5.17.

Thx.

---

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.17_rc4

for you to fetch changes up to 13765de8148f71fa795e0a6607de37c49ea5915a:

  sched/fair: Fix fault in reweight_entity (2022-02-06 22:37:26 +0100)

----------------------------------------------------------------
- Fix a NULL-ptr dereference when recalculating a sched entity's weight

----------------------------------------------------------------
Tadeusz Struk (1):
      sched/fair: Fix fault in reweight_entity

 kernel/sched/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)
-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
