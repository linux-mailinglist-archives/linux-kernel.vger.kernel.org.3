Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A381586637
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiHAIUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiHAIUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:20:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A433AB00
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:19:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 297F24D64D;
        Mon,  1 Aug 2022 08:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659341998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yw8LN/ZUC3MgYxOwtXkZp9fdLu7xLtMPzByEWvf2VLU=;
        b=XdWAvEJfrMQbYToxZeYJw75jbi7USTWw3Es/XknOsA65j3WhLQZJ3HEdA6U1+s3AqgDbXE
        WqY1p5aKbJk8j0Wfc4GLj1PavurvRWotIDkiNglQiaTf8JhrkvQRwAt/000pfPrSMkOsbW
        JhQeLwV31y1k7OdpRMxPBp978A4VVB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659341998;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yw8LN/ZUC3MgYxOwtXkZp9fdLu7xLtMPzByEWvf2VLU=;
        b=tmECEFmPI6Av1obXV2XB9EFdvW8sxJTKRe+eqOqQRSR+NgkJ1MiAjLPH+d3xhe4/YAxDLf
        bwn5iOtBOmR8FWBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CF8B13A72;
        Mon,  1 Aug 2022 08:19:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I/wLB66M52JFJgAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 01 Aug 2022 08:19:58 +0000
Date:   Mon, 1 Aug 2022 10:19:52 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ras/core for v6.0
Message-ID: <YueMqE3muQn3rebB@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

tip pull requests won't contain a lot this time around, thanks
Retbleed...

Please pull a single RAS change for 6.0.

Thx.

---

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.0_rc1

for you to fetch changes up to 891e465a1bd8798d5f97c3afb99393f123817fef:

  x86/mce: Check whether writes to MCA_STATUS are getting ignored (2022-06-28 12:08:10 +0200)

----------------------------------------------------------------
- Probe whether hardware error injection (direct MSR writes) is possible
when injecting errors on AMD platforms. In some cases, the platform
could prohibit those.

----------------------------------------------------------------
Smita Koralahalli (1):
      x86/mce: Check whether writes to MCA_STATUS are getting ignored

 arch/x86/kernel/cpu/mce/inject.c   | 47 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/internal.h |  2 +-
 2 files changed, 48 insertions(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
