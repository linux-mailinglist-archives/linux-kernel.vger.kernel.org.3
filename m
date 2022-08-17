Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3809E5970E7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239870AbiHQOXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237331AbiHQOXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:23:31 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B379121E0A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:23:30 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98b0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98b0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 211AB1EC0575;
        Wed, 17 Aug 2022 16:23:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660746205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kkwp9nwOMfFSngJeqZSWM/3SOmwqoE9dGRc62aweuuk=;
        b=LWY+02tAYGunN2wFNF33PUiBX9XcexYq1HxpTdmQumNuV3FobrTn3Hj79QO6G9CZ5xSB7V
        qrNoekk2FqQcrcNjcK+lJ/RsndFd2aiTWR2E2lJ4q1tHkSAng6JrTjTRDBsVCicoPNIiMK
        3VO1MKc+yxZ6VSeG3vxTCm0+NPhVMMM=
Date:   Wed, 17 Aug 2022 16:23:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Ashok Raj <ashok_raj@linux.intel.com>, X86 ML <x86@kernel.org>,
        Andrew Cooper <amc96@srcf.net>,
        LKML <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?=C8=98tefan?= Talpalaru <stefantalpalaru@yahoo.com>
Subject: Re: [PATCH] x86/microcode/AMD: Attempt applying on every logical
 thread
Message-ID: <Yvz53AAh+p5Db7CK@zn.tnic>
References: <20220814120026.16118-1-bp@alien8.de>
 <YvtcGEHX8eSFpALX@araj-dh-work>
 <YvuQgx698T5cgF+C@zn.tnic>
 <YvzbFXnBjNjK+UJK@araj-dh-work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvzbFXnBjNjK+UJK@araj-dh-work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 12:12:05PM +0000, Ashok Raj wrote:
> Instead of doing a complete hack,

What complete hack?!

> could we maybe revive what we attempted
> in 2019? At a minimum it will work for both architectures.
> 
> https://lore.kernel.org/lkml/1567056803-6640-1-git-send-email-ashok.raj@intel.com/

echo 2 >... - now that's a hack.

If you wanna use the kernel for testing your hw, use a local patch. Not
expose it to people and then have me debug all kind of strange lockups.

Geez.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
