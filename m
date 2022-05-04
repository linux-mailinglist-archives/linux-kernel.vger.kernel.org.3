Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEF751A57F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353460AbiEDQ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353501AbiEDQ25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:28:57 -0400
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878411EEDC;
        Wed,  4 May 2022 09:25:18 -0700 (PDT)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id C24FF7FC20;
        Wed,  4 May 2022 16:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1651681515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uf4eGE5X5hRNqb7V6XorN5LCEocRZ06jz0PJinqpv1U=;
        b=ciqlHnm0OgJ/Uq6Dvd5+wYCx4KStv0UmKA0rwkDH7DhYZUAkKfVg0EyeBdTaR7uO2YI4hZ
        HRI7Q8x245lQP+6OQwJaYD5OYx/rUBTKg7pdPVELOk9vAxejZ1XpqKEAEY4MWoJCkR0qqZ
        OD6zI0fQljcNHxPij2ZhdbH8kLuZ7t5XY0AHNAfp+q2ktfxLeFsh8nItzBPqVjJnE5IY3E
        2ujkdv81Jt/FF9HIplAlmD/WzzOSc91bvyz7JgiowZIA8npq3wdTtvhABXePpQMEnkgLjG
        uMPfy+nMX2t7w7CDmRz+o7BBgTl3SF56Cf8p5Sgqwsf12cJwNS7sYEfogeJibg==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Moritz Duge <duge@pre-sense.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Aurelien Aptel <aaptel@suse.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
Subject: Re: Regression: CIFS umount fails since 14302ee33 with some servers
 (exit code 32)
In-Reply-To: <64a7de55-8f93-8e7a-4102-26f7d4dbe1dc@pre-sense.de>
References: <715d745d-5a85-092a-68c2-b9b1dd8ad53e@leemhuis.info>
 <5fc82f02-be3a-6bb4-0800-aaf19a782655@leemhuis.info>
 <64a7de55-8f93-8e7a-4102-26f7d4dbe1dc@pre-sense.de>
Date:   Wed, 04 May 2022 13:25:10 -0300
Message-ID: <87zgjx1d09.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moritz Duge <duge@pre-sense.de> writes:

> I'm still waiting for a reply from Paul.

The bug is currently being handled at [1].  Enzo has also asked you to
send us network traces in [2] and you haven't sent any, yet.

I'm not "Paul", BTW.

[1] https://bugzilla.opensuse.org/show_bug.cgi?id=1194945
[2] https://bugzilla.opensuse.org/show_bug.cgi?id=1194945#c13
