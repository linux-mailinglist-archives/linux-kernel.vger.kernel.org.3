Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E564520D5C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 07:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbiEJF6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 01:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiEJF5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 01:57:48 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBC5224A6D;
        Mon,  9 May 2022 22:53:49 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CBB235C006F;
        Tue, 10 May 2022 01:53:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 10 May 2022 01:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-transfer-encoding:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1652162025; x=1652248425; bh=UqqeRMS++PzTUoENYIQlHrxmX
        YanHi9usrhTSkqWRBY=; b=Fu5cIkJEtzgBvV4/XqoZGzxI90Syy2eSStFQG1Bmq
        Qzq44qis4oBKK2+44MGfoT6zBG6iuJojCb9ybGYa/X0Fd7wSElE4XRd10wKPRs7e
        hgcvXNoNSmtzgJKAfbBtMElDOT90E7i8ZaxIBTB0BJ1p1OxaWTGpWnyoXfWfdoig
        v5JwOom18HqfihBQaBs07kKWXJsqznNkms+5qGr7lnnjt0Rv4WKqZY1ALCPE3qI/
        yGXKoUuwtYgsNnGnUAMtKLOleMEPe5UeKpffnO6dIWL591ktA3+OlrdTuJhZXp0m
        k+3mPuIPvMCyuv1IQYUQVqTlz2httcefLpnfpFxWDGPcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1652162025; x=1652248425; bh=UqqeRMS++PzTU
        oENYIQlHrxmXYanHi9usrhTSkqWRBY=; b=UNhVoXCIlaYSssxxJzv6+gTP356lr
        Csm5VdK7uurne8gjADzemSPIgvtaCwsX1FnCjOEp9wJJ01+pvQTyzw6swj9hBm5e
        cy5Wag2OIi7CDRmQiZloVmbYMGYbyGI4ybtqBdLjiw7P52vN2ceC4IIoNfEox06K
        AhtG2y/AP8xJ5eceuv8OMO5mXYknc5JH/reD5GY/jIbO6SXIChJNM4hnszow95Mu
        A3es01Y1zA/qbaWa+fJ3s7YGEp8fsRi6u0PRpyQE13rLgKNQchtx8P51KqXV+mfc
        n01FF91bK6IShsyjj6LUjWwc9svBLo7MoM7Vao+pwMnW47TmZyS9aZDNw==
X-ME-Sender: <xms:6P15YkrgxmXL_bXGwWaviRm6XMrjlcrEGve3UktMb3qDyOWmAUlQQA>
    <xme:6P15YqoXXjsH1mhaSUmAo7NmhlzgdAZdWW6iTxC68WM-y23AT6nuBQxIN87lVOYC0
    o26TOUlt7PVw-D5QP8>
X-ME-Received: <xmr:6P15YpMnawRru0JeWelMLekRPpbjZr4ov6wddhSKU6xp3Qq0HZi6f7hdVP4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeflohhs
    hhcuvfhrihhplhgvthhtuceojhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgheqne
    cuggftrfgrthhtvghrnhepgeeihfevvdeklefggfejjeeugfduudeggffhjeehkeegheel
    tddujeffjeekheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgh
X-ME-Proxy: <xmx:6P15Yr5XlWFiPj7CElVzyH11o3VZ_PStgxAdue3cQ9JFb6bMNDIQBg>
    <xmx:6P15Yj7U1pxqEu9m3udW9TVyeeMicQbdOEYiPoTkPJHdB-P4BtAR-A>
    <xmx:6P15YriuNrhSSJ4-FJxKRUHsGVzrMhlxgebD2OHXvogbusUlZ4rP8w>
    <xmx:6f15YjpPFIJVuv2qe1NIoT3pZ-4kd4TVf1sNI3LTismj8jORQoLtJg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 May 2022 01:53:42 -0400 (EDT)
Date:   Mon, 9 May 2022 22:53:41 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Gaelan Steele <gbs@canishe.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wu XiangCheng <bobwxc@email.cn>, Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Yuki Okushi <jtitor@2k36.org>, Wei Liu <wei.liu@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, Julian Merkle <me@jvmerkle.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v6 18/23] docs: add Rust documentation
Message-ID: <Ynn95Sv91TzD4HdT@localhost>
References: <20220507052451.12890-1-ojeda@kernel.org>
 <20220507052451.12890-19-ojeda@kernel.org>
 <875ymecp6f.fsf@meer.lwn.net>
 <0716311E-FD5A-489A-A17D-C427C1A0EE4E@canishe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0716311E-FD5A-489A-A17D-C427C1A0EE4E@canishe.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 08:14:54PM -0700, Gaelan Steele wrote:
> 
> 
> > On May 9, 2022, at 3:32 PM, Jonathan Corbet <corbet@lwn.net> wrote:
> > 
> >> +It is convenient to instruct editors/IDEs to format while typing,
> >> +when saving or at commit time. However, if for some reason reformatting
> >> +the entire kernel Rust sources is needed at some point, the following can be
> >> +run::
> >> +
> >> +	make LLVM=1 rustfmt
> > 
> > I will ask whether we want this, though. Why would anybody want to
> > mass-reformat the entire body of kernel code? This seems like something
> > that would generate an endless stream of "helpful" patches and a lot of
> > churn.
> 
> That would only happen if the code diverged from rustfmt’s output in the
> first place. Generally, in Rust projects, the source tree is always kept
> formatted with rustfmt - so running `make LLVM=1 rustfmt` would only
> ever touch code that you’d just changed. 

Exactly. This is convenient for the same reason doing a project-wide
`cargo fmt` is useful in Rust projects: you can do all your editing,
then format your code before committing.
