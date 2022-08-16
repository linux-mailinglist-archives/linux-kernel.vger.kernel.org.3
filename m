Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4772D59589B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbiHPKjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbiHPKit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:38:49 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BF92B27A;
        Tue, 16 Aug 2022 02:21:06 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8D2305C00A0;
        Tue, 16 Aug 2022 05:21:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 16 Aug 2022 05:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1660641664; x=1660728064; bh=OhMgZX7auI
        gkuBlZmd1o5pXnydvmuutKuznb643+nMc=; b=xfxXIimP3vKiA76KqsYsv4Bkat
        kSxGJqmiXPRBmc8729AnI4/OqKgSI5WloA2b27nl/Y0B9iQRu4UVWqdwYjLPSmbh
        X4tAZDPKXkD0RyBq7fm069/5aceGNkl1HMXJhJ1BN9wghNhyHNx89INwVJl3ldzU
        NscFrG/Ja+weLLcvQU4hOJxUu4+8ApiKoxB7J4+f/Tdz0cquvNLGU/VedpgfrG75
        lQIlpqNdEONfxa3Z18WBL/9VQjUcHJADXHvZLYIetxqIw88GEDl11eMJdV3r3iRa
        a/jmbb4OFAh4+GW068nhEEv10nXtqzH0/rBpf5WI2j1q9x2HWAjDnP3xGeMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660641664; x=1660728064; bh=OhMgZX7auIgkuBlZmd1o5pXnydvm
        uutKuznb643+nMc=; b=NRYAcG7uxWwgU7F3BWUESvVCTM7SP5pGEFkQjOorYyYu
        FHLDot5AzJo260CjVoA/KpJH3h9ZrcJj9sdgn/leIrm1AAINVmJ5UCZXt001H+WJ
        I/67P8234bFJm8XrfYNJwF7CF4BrJlCfSwOgW0/Xwp8iL0SBoo5bDtWgL01Wu//C
        qEC3HXOpUXGWozg9MXvwf+K5/mHXGGvc2kywwVXPuuGPvto1NhAJIzyq0YryfEVR
        KQvyCtxKlGc5SNezdDlai+AuGpgTSouuHLHPgbdDGtefEoW1HxUvow4pAjdAXFCY
        q2gZf+HjpMVJkS1p9Mv5v42mefDkIBMm6OCBmqEBNA==
X-ME-Sender: <xms:gGH7YsMIAa2ZAO31iEYHDCkOKDZzQkEPIzP6en-_q6FnT7mnC9vDNg>
    <xme:gGH7Yi8JCg1Y1SbrzdhrkirkPQnRCJjo2aldeDEcjEYwAYscD4G7Zuibou4tXUo8D
    fkw4dkY3WwdCA>
X-ME-Received: <xmr:gGH7YjR7OsJMGgznXdW2UiaSNoWZ3YHE1v3r8Ny1ASZ8tL2AuASgNQ7-nj6AI7vJzj9L0kzLGpjzhPO4wUVmR9Jy8db6uO29>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehgedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:gGH7YkuZai49G-Wdcq-XoV26iwjsouwhdkKXs7FSOBa0A7Jn6klz0g>
    <xmx:gGH7YkdrhCBj4b30ZzAhenBVddm6p4Il4i_v57Dxj_TTzrqUXDX_Qg>
    <xmx:gGH7Yo0THskVFE2VOQ7H49GxUJXdRfGIf09ODhMtxm5qyM8qtc_GHw>
    <xmx:gGH7YlVdCBeqKhfGkBNvVfd2FqJHBetDDsKCsgwZM0Adqqyv244nCg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Aug 2022 05:21:03 -0400 (EDT)
Date:   Tue, 16 Aug 2022 11:21:01 +0200
From:   Greg KH <greg@kroah.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de, linux-api@vger.kernel.org,
        f.fainelli@gmail.com
Subject: Re: [PATCH v4] MIPS: Expose prid and globalnumber to sysfs
Message-ID: <YvthfQUfv0TiO/bK@kroah.com>
References: <20220816091258.9571-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816091258.9571-1-jiaxun.yang@flygoat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 09:12:58AM +0000, Jiaxun Yang wrote:
> Some application would like to know precise model and rev of processor
> to do errata workaround or optimization.
> 
> Expose them in sysfs as:
> /sys/devices/system/cpu/cpuX/regs/identification/prid
> /sys/devices/system/cpu/cpuX/regs/identification/globalnumber
> 
> Reusing AArch64 CPU registers directory.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v2: Drop static qualifier for kobj (gregkh)
> v3: Use kzalloc to allocate struct cpuregs.
>     note: When Greg mentioned about static I was thinking about
>     static qualifier of percpu variable. After reading documents
>     again it turns out kobjs should be allocated at runtime. Arm64's
>     cpuinfo kobj is also on a percpu variable... I guess that was a
>     intentional use?
> v4: Properly handle err of kobj creation. (gregkh)

Nothing was fixed :(

Again, please read the documentation for the kobject calls you are
making as it explains how to properly handle errors being returned from
them, and what you need to call if that happens.

thanks,

greg k-h
