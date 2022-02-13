Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B364B3B52
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 13:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbiBMMaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 07:30:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiBMMaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 07:30:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2C05AEEB
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 04:30:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AA6611F384;
        Sun, 13 Feb 2022 12:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644755407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fo8DZTzkjuoK9bwoLJdDkwJu7xediYMa1BLc0VWxyDk=;
        b=RiipnAdPb0/DSkwy/2jAg/UCzMpu5qR0YVpKC+T3nu6ry0aIoY3XI0m0wgXliZQ32McyG3
        W19UaUX/amYBPRdrRHT2EgojJp1z6ZWvJ2MfR39Hx7G6u9NZhkovqZbblu6sQG3PcK+qAn
        bEaiDVO2ZitE6yIsWwJ+1T8ClUm09KQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644755407;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fo8DZTzkjuoK9bwoLJdDkwJu7xediYMa1BLc0VWxyDk=;
        b=QeAw2cPV//kfuiY/AaZ0WxBYNxtuMbdyuPDpCiTmAx5W3cTLuYTQawaOwqNjsKRMwFlKVC
        hontsn0DC3Hxd7CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 948691331A;
        Sun, 13 Feb 2022 12:30:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id S2G2Is/5CGIRPwAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 13 Feb 2022 12:30:07 +0000
Date:   Sun, 13 Feb 2022 13:30:13 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for 5.17-rc4
Message-ID: <Ygj51dBiTt3KCCzK@zn.tnic>
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

please pull a single urgent perf fix for 5.17.

Thx.

---

The following changes since commit 1d9093457b243061a9bba23543c38726e864a643:

  perf/x86/intel/pt: Fix crash with stop filters in single-range mode (2022-02-02 13:11:40 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.17_rc4

for you to fetch changes up to 5f4e5ce638e6a490b976ade4a40017b40abb2da0:

  perf: Fix list corruption in perf_cgroup_switch() (2022-02-06 22:37:27 +0100)

----------------------------------------------------------------
- Prevent cgroup event list corruption when switching events

----------------------------------------------------------------
Song Liu (1):
      perf: Fix list corruption in perf_cgroup_switch()

 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
