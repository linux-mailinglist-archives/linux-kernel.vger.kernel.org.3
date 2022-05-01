Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D78516421
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 13:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346177AbiEALct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 07:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235899AbiEALcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 07:32:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E1F6D1BB
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 04:29:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E62971F37D;
        Sun,  1 May 2022 11:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651404560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zKT9F8/I0qwSyr/p9qZPAd2Tr0LsPyIOrr+54K49E64=;
        b=Oy2EXmrPVPsN588Lev3i1o5rHZtmhdq+KK5dcOd2wjmLYJEbxOwFkmHgwK4d3Zham34iYz
        5aocZJImesKGPFR0j097AnXpTfjasKZoMK8yMbpJuqKzBdDNTAm6b/GyI+lultYT6MRzQk
        7D988k8kxRQs9or+7AWLg4jG/RQ8VW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651404560;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zKT9F8/I0qwSyr/p9qZPAd2Tr0LsPyIOrr+54K49E64=;
        b=f9rQ8AqEOqIkhUuLFs29J+sQlQChhKul+0EU8hKjgm79ZeTxgq1OMGl+njcXtyHqB9+nBz
        QaLRk59HcSmVGMAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE36E13AE0;
        Sun,  1 May 2022 11:29:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aWpOMhBvbmLFLAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 01 May 2022 11:29:20 +0000
Date:   Sun, 1 May 2022 13:29:17 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for 5.18
Message-ID: <Ym5vDU6KFdzYaTAo@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single irq/urgent fix for 5.18.

Thx.

---

The following changes since commit af2d861d4cd2a4da5137f795ee3509e6f944a25b:

  Linux 5.18-rc4 (2022-04-24 14:51:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.18_rc5

for you to fetch changes up to c7d2f89fea26c84d5accc55d9976dd7e5305e63a:

  bus: fsl-mc-msi: Fix MSI descriptor mutex lock for msi_first_desc() (2022-04-27 19:42:32 +0200)

----------------------------------------------------------------
- Fix locking when accessing device MSI descriptors

----------------------------------------------------------------
Shin'ichiro Kawasaki (1):
      bus: fsl-mc-msi: Fix MSI descriptor mutex lock for msi_first_desc()

 drivers/bus/fsl-mc/fsl-mc-msi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
