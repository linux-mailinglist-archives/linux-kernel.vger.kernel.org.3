Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17684472B58
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhLML2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbhLML2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:28:00 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA8EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 03:28:00 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DEC791EC01FC;
        Mon, 13 Dec 2021 12:27:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639394878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eor5lDSOEg1aErZhTqXFapEzcz+xKGH5y2pHSykQdKQ=;
        b=BPdmFufPNUm5Z6AiFKIeUiMKnFuN7CThbfJAvEMDgYISj0qJVVfR4GOwFE55kRWXCAXPQA
        iM6yvPR9vWt58Uy+Rf25vzmJGYy97fZgiVdlin61NVg7gkqmJlgkAoFllqhfYa0AmZOXxH
        gXfPgGco4h8fQnECo6Q2zdXD6k5PhLI=
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        John Dorminy <jdorminy@redhat.com>, anjaneya.chagam@intel.com,
        dan.j.williams@intel.com, Hugh Dickins <hughd@google.com>,
        "Patrick J. Volkerding" <volkerdi@gmail.com>
Subject: [PATCH 0/3] x86: Fix boot ordering issues yet again
Date:   Mon, 13 Dec 2021 12:27:54 +0100
Message-Id: <20211213112757.2612-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <YbcTgQdTpJAHAZw4@zn.tnic>
References: <YbcTgQdTpJAHAZw4@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi,

here are the three I'm going to queue this week. Thanks again to
everyone for the quick testing.

Borislav Petkov (2):
  Revert "x86/boot: Mark prepare_command_line() __init"
  Revert "x86/boot: Pull up cmdline preparation and early param parsing"

Mike Rapoport (1):
  x86/boot: Move EFI range reservation after cmdline parsing

 arch/x86/kernel/setup.c | 72 +++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 42 deletions(-)

-- 
2.29.2

