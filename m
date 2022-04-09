Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F844FA952
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242515AbiDIPjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiDIPjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:39:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465DC59A6F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 08:37:40 -0700 (PDT)
Received: from zn.tnic (p200300ea9715615c329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:615c:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D946C1EC03AD;
        Sat,  9 Apr 2022 17:37:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649518654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iWkUS759CeYqZYE0NNp3/jTJ+O6z3Tw+oaxPAnsM1W8=;
        b=qnzejolS7TMJRg0ftWfIOms48lJwurM2ZGf2zJER5k7MivS+yrlF1AUnVmn4bf/HMzVugV
        uFOX+d7/hVih1eVEXpdgpq4Krr5F6CRPF9F2zL+UzTiHKJWyLwjBEAsKbY1XdStYQD/347
        xX9KtU3k/BvP4oHyr0YGvichyOO2C5M=
Date:   Sat, 9 Apr 2022 17:37:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Non Null <ayz.out@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: Request: Regarding the phasing out of "a.out support" in Linux
 Kernels
Message-ID: <YlGoOXoBaW8i1xrt@zn.tnic>
References: <CADt9uBkMkrywjSo_jyUJtS85ATTQtRTVXPRsRVUKZpujYo9SUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADt9uBkMkrywjSo_jyUJtS85ATTQtRTVXPRsRVUKZpujYo9SUQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 04:02:23PM +0100, Non Null wrote:
> But I still wanted to ask that it remain active in 5.18's full release
> while announced that it would be inactive/turned off by default in the
> future 5.19 & 5.20 releases (5.20 being the last that would have it as
> inactive before full removal of related code) if LTS

That is the plan - it will be removed in 5.19.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
