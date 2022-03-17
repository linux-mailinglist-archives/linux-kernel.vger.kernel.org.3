Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D0F4DC7C1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbiCQNnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiCQNnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:43:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4878418A7B3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 06:42:20 -0700 (PDT)
Received: from [127.0.0.1] (pd95ca587.dip0.t-ipconnect.de [217.92.165.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AE4D81EC064A;
        Thu, 17 Mar 2022 14:42:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647524534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E0QFWrqa7ytdU8C2RequikAjTRQgtH2XfVbposhm8Xo=;
        b=KfJgjSHk0+yK8BvhML0z0kVdPL6J8/Pq7Py2seUIGvU4O41e17xMPxVhhL0cG+hVeIcHCW
        3FqClSTsCLjISNAlXSe+ssUmvScAFuaGbxI66vTwVRtsz5xgrDzDmb3nhKN3D1rknmA5H2
        oi+QmfowajfAo2IrBGkfQM7J+C5WhOk=
Date:   Thu, 17 Mar 2022 13:42:12 +0000
From:   Boris Petkov <bp@alien8.de>
To:     Beru Shinsetsu <windowz414@gnuweeb.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_boot_install=3A_Partially_ref?= =?US-ASCII?Q?actor_the_logic_for_detecting_bootloader?=
User-Agent: K-9 Mail for Android
In-Reply-To: <7b4f98d92a57af35c927aef6c85373f8eeeab29c.camel@gnuweeb.org>
References: <20220316173221.5937-1-windowz414@gnuweeb.org> <2E28CA0C-34F2-4985-86CC-B1823AF8D747@alien8.de> <7b4f98d92a57af35c927aef6c85373f8eeeab29c.camel@gnuweeb.org>
Message-ID: <221F34C3-C3E0-4401-BEF2-422F11BF8324@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 17, 2022 1:16:26 PM UTC, Beru Shinsetsu <windowz414@gnuweeb=2Eorg>=
 wrote:
>I guess I had pure luck having this patch seen? xd

I'm not sure what you mean here??

>To be honest with you, nothing has changed _just recently_ to cause
>this error message to come up=2E

Well, I saw this on SLE15-SP4 (brand new) yesterday while I haven't seen i=
t on previous service packs=2E So this doesn't look like it has been there =
since 2007=2E I'll try to debug it when I get a chance=2E=20

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
