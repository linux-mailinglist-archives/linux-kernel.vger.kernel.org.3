Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CAF4AA843
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 12:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240429AbiBELHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 06:07:20 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47906 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbiBELHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 06:07:18 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CF933210E8;
        Sat,  5 Feb 2022 11:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644059237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TRWuygi4XX00RZd4Z/flt6YuzTCY1qHucKFqYYdqECk=;
        b=RuNzHPxI03EkbNLga0ROpvLhex6+EwI/f1oiH6I+PBPNN2m1UcO4YqHpF3T6uAU1Fi1OpY
        oAdus1gzFGNMLaaWStuTvZ+CvOk1qE/ebm0xEuMc1rJJUymh4ot6Dxy1vWgQWpJUgxLpcO
        /7B+kno00KLPDeif8jdtBn7BLQ0VWmw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 981B013A6D;
        Sat,  5 Feb 2022 11:07:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SfUNI2Va/mEnGgAAMHmgww
        (envelope-from <jgross@suse.com>); Sat, 05 Feb 2022 11:07:17 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.17-rc3
Date:   Sat,  5 Feb 2022 12:07:17 +0100
Message-Id: <20220205110717.16946-1-jgross@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.17a-rc3-tag

xen: branch for v5.17-rc3

It contains the following patches:

- 3 documentation fixes related to Xen
- a patch for enabling x2apic mode when available when running as
  hardware virtualized guest under Xen
- a cleanup and fix for a corner case of vcpu enumeration when running
  a paravirtualized Xen guest

Thanks.

Juergen




