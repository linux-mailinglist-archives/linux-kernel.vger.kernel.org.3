Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E363F585E71
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 12:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbiGaKXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 06:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiGaKXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 06:23:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0551E0D7
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 03:23:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4A1BE200F7;
        Sun, 31 Jul 2022 10:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659262997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tykpLoyOia3V8EDL3U7MVIivhcWeU1JBo2GEe36PrpQ=;
        b=OjTKhADSCU9ky8l0w53NifVa01VnMvizPwjQevtlKb026gcdrIYZUEeRvWlg+Zq0/DVRbV
        OVTwSUsUDnjDcmTFcv9fdqtqvIEAt97xtVXoA7vqvOVbVEa4jkWM4ZrbEDCjkgMNtll/qt
        GSBAKPJ1eJXWiBTbOuO0rfcj5/R8QFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659262997;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tykpLoyOia3V8EDL3U7MVIivhcWeU1JBo2GEe36PrpQ=;
        b=rO0Zdi4C0TnUpZskgADx8YXB544plwebMlcGoO6ged0TiLw2pzPXzcxT9M+GoS4hpA7EFW
        W3oWfK+BWKWYNdBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E85913754;
        Sun, 31 Jul 2022 10:23:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Dw47DxVY5mL2OAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 31 Jul 2022 10:23:17 +0000
Date:   Sun, 31 Jul 2022 12:23:12 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for 5.19
Message-ID: <YuZYELRWE77M09c2@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple more last minute x86 urgent fixes for 5.19.

Thx.

---

The following changes since commit e0dccc3b76fb35bb257b4118367a883073d7390e:

  Linux 5.19-rc8 (2022-07-24 13:26:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.19

for you to fetch changes up to ea304a8b89fd0d6cf94ee30cb139dc23d9f1a62f:

  docs/kernel-parameters: Update descriptions for "mitigations=" param with retbleed (2022-07-29 20:47:07 +0200)

----------------------------------------------------------------
- Update the mitigations= kernel param documentation

- Check the IBPB feature flag before enabling IBPB in firmware calls
because cloud vendors' fantasy when it comes to creating guest
configurations is unlimited

- Unexport sev_es_ghcb_hv_call() before 5.19 releases now that HyperV
doesn't need it anymore

- Remove dead CONFIG_* items

----------------------------------------------------------------
Borislav Petkov (1):
      Revert "x86/sev: Expose sev_es_ghcb_hv_call() for use by HyperV"

Eiichi Tsukata (1):
      docs/kernel-parameters: Update descriptions for "mitigations=" param with retbleed

Lukas Bulwahn (1):
      x86/configs: Update configs in x86_debug.config

Thadeu Lima de Souza Cascardo (1):
      x86/bugs: Do not enable IBPB at firmware entry when IBPB is not available

 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 arch/x86/include/asm/sev.h                      |  7 +------
 arch/x86/kernel/cpu/bugs.c                      |  1 +
 arch/x86/kernel/sev-shared.c                    | 25 +++++++++----------------
 arch/x86/kernel/sev.c                           | 17 ++++++++---------
 kernel/configs/x86_debug.config                 |  3 +--
 6 files changed, 22 insertions(+), 33 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
