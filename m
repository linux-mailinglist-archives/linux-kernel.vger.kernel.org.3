Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4CA4EBEC9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245387AbiC3Kcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242585AbiC3Kcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:32:33 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC69929C8B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 03:30:47 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1BEAB1EC0304;
        Wed, 30 Mar 2022 12:30:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648636242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=98fI96XE73aivmk0QMDzyHxZATBVyf2sm2QP/E2rY9M=;
        b=Xl8vt9eTE7Qhv6o7xLPM4NxloFsInikFk7mjc2xnt208zLZAuJkJn/lVhczpEljI2rO9LP
        34/wITZuvJYCRPR8nMeJBuqt8tj0uODhxb24BGoW5SxI+mztn742AC4Jb3i+4U6NV2ZYN6
        Dnpj5p/NDsi7JPdJRWoakgmLlfscb98=
Date:   Wed, 30 Mar 2022 12:30:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: 9def39be4e96 ("x86: Support compiling out human-friendly processor
 feature names")
Message-ID: <YkQxVM4PZMrLs9z1@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Josh,

I'm assuming the commit in subject was part of the tinyconfig effort and
I'm also assuming that effort is long gone now.

So, can I rip out that config item and get rid of a lot of ifdeffery
we're sporting because of it?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
