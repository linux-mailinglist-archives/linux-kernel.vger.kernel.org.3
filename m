Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7E85330B1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240395AbiEXSxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbiEXSxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:53:33 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0925717A
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 11:53:32 -0700 (PDT)
Received: from zn.tnic (p200300ea974657c6329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:57c6:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A95611EC018C;
        Tue, 24 May 2022 20:53:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653418410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=L+h3UKyWWnoWjDM17Xq17DXvoEcksEZK8jMMUUjJIJo=;
        b=iILqcsjsyohGDsLHdYAdXhY6+J3iyUMzuRWXKoAk9JkYmSDj2LjkQ0QqPzT8nz4MNFUJnD
        GB6cDtzuTLijHYtTOZGOKQZF2nD8vLxjh6fFpUXkKXrV31xVB3wu+aNCkz8mONeYTtVJWE
        xuF42zQYtYxg9loyh3qxDq59+FQu4gc=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/3] x86/microcode: Drop old interface and default-disable late loading
Date:   Tue, 24 May 2022 20:53:21 +0200
Message-Id: <20220524185324.28395-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Totally untested, just sending out as a RFC first. This is something
Peter and I talked about recently and think it makes sense.

Borislav Petkov (3):
  x86/microcode: Rip out the OLD_INTERFACE
  x86/microcode: Default-disable late loading
  x86/microcode: Taint and warn on late loading

 arch/x86/Kconfig                     |  15 ++--
 arch/x86/kernel/cpu/common.c         |   2 +
 arch/x86/kernel/cpu/microcode/core.c | 111 +++------------------------
 3 files changed, 19 insertions(+), 109 deletions(-)

-- 
2.35.1

