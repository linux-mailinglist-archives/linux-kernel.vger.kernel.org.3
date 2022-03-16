Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AD04DAD21
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354791AbiCPJEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbiCPJD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:03:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7907A652D1;
        Wed, 16 Mar 2022 02:02:45 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0E74D1EC0559;
        Wed, 16 Mar 2022 10:02:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647421360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cNVs3xEveSi/MGIuYUf5dSaXySYKdj1WMoxoR9xRyYk=;
        b=JgHIekcSA2BHkJVlO2ogfSTfeNCuzLL4D5S/0duQXGgGlFuky8PAAXv/xPx7um+lae25Aj
        4xtSkSHBN5ySDE6Z0Vu0xOS/BXNNe1uOXLfDR2RCrJktwGRL0U/hGDEDGOkcFAN0DEAQ7i
        lvgVXfk187EBt1FbQrId/vCn7sKS60U=
Date:   Wed, 16 Mar 2022 10:02:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     X86 ML <x86@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: drop entry to removed file in EXEC & BINFMT
 API
Message-ID: <YjGnq9q48FL5a34Q@zn.tnic>
References: <20220316050828.17255-1-lukas.bulwahn@gmail.com>
 <YjGWPh6MSLqeL47e@zn.tnic>
 <CAKXUXMzcAFv2FmU7L8HHA4Sp9uehqW_gfez7qVfsf1O6PsnwtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKXUXMzcAFv2FmU7L8HHA4Sp9uehqW_gfez7qVfsf1O6PsnwtA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 09:12:54AM +0100, Lukas Bulwahn wrote:
> I guess then you can squash my one-line patch into your patch, and

Right.

> then we put all this into the closet and wait for another day where
> this feature can be removed.

Yeah, I wouldn't hold my breath. Everytime I attempt this, someone
crawls out of the woodwork with a use case.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
