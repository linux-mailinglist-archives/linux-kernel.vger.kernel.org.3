Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0A7520BD3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 05:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbiEJDTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 23:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiEJDTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 23:19:04 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8B228ABAC;
        Mon,  9 May 2022 20:15:07 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B7A573200942;
        Mon,  9 May 2022 23:15:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 09 May 2022 23:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canishe.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1652152501; x=
        1652238901; bh=Js/oWYE71aKyhQh1lChvQkRWgN+gDNge5zO1GV3PKcY=; b=t
        QZieq2rBtxznoUKnPlfNoorA/ODf0wz6ELmer95hypMgqFLW51CVRaX2gnXvBTpD
        OAnuBmtSBaiMj0qXQnuka9RFCuxiXdLH4c1cnuW0Vi2TSwRE+ArohH2/kfocp39v
        1+pCu9WxAkHWTpf9xzDywXzt54mRRgHmojuHz77pVoiuMREF6Suum9id8n5YEHZG
        JOPJlr3vSSgTnrIq8c3IGycl7G9xMlOU9hXuU3FvRJ9aEWzz0qUfhZ80Y6tMN/4M
        IEhWrxv8fWuufcinxCtsHsbbVkcAQDugKsAf4F/tG8sNyilHB+r/PYCVVsEJAYNp
        s7fe92E9kLmw94vGL6xag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1652152501; x=1652238901; bh=Js/oWYE71aKyh
        Qh1lChvQkRWgN+gDNge5zO1GV3PKcY=; b=kyWYbdbC+5u4hU2GVabZUgaAaF2Kz
        Pui9obWGO2y90I5gKYbuxsqBy7vwlm4e4VrrFs4XTWo6ZekxzeoTwtUEoNBsc52J
        a+DcycTZOjrjT8bBMEDHVujqErpIntAhDwiow2NrRgfP+IA20KrNN1WUDL9cwTKz
        z/EKnPcqXTk2jBAxPk/AUboTv8LWmpz01BCZpa2MDVlTzDcbZTUc5OfCO7SId2Qn
        iHzYPrFy2G0tFOqf0BacjePL5X6zBGuT4xpthA+OoL5VjUZySpeJdnoEKn/zZC1a
        lqvQ/5Tha3nN4NlOjI0mla+sL9ik7rkc8/7OmBgrIJhKVrR8qU3GAn0Hw==
X-ME-Sender: <xms:s9h5Yt7bAvZH0ScZOUfUCuiHZfvAtG_O3KlpwfjB6gxOvB4obd6nFw>
    <xme:s9h5Yq4tX81jHOWITqPMXdB68bzXvEYAvyzQkTUCOhoOH36tHu1RaZopbtJKfXNLH
    MrqBu1l6YwMLPcA7Q>
X-ME-Received: <xmr:s9h5YkcfWexYBqKXhM7YhscygrMLTEo_e91QvVopRev3VbdNvxy1UHJu8whGxxrDfYK41hE8mHcm5ZigCzmYnlOzx3F1YxGO0rj19IiBZxmG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpegtggfuhfgjffevgffkfhfvofesthhqmhdthhdtjeenucfhrhhomhepifgrvghl
    rghnucfuthgvvghlvgcuoehgsghssegtrghnihhshhgvrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehfeevtdeuudegfefhiefhgfdvvdetgfffueduvdehfeffteelveetkeegffev
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgsg
    hssegtrghnihhshhgvrdgtohhm
X-ME-Proxy: <xmx:s9h5YmKHY2AG9UatQV372P8S06dhgbK5-caWJhDAq63m5pJcRdmzsQ>
    <xmx:s9h5YhJ1nnx4CjXK_Q93Z-Y9PVi6E5dN2dY84nTOSxf90QxkDMK8Wg>
    <xmx:s9h5YvygJHbYO1oYbfbj1pjcPCV8kzCCwjnLS2ruJ9eUlYjf-8c_uQ>
    <xmx:tdh5Yh49GXViGiNc4l8ODx3i_WqLOTARAeS1VAXam99eOUcz0uLlvQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 May 2022 23:14:57 -0400 (EDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v6 18/23] docs: add Rust documentation
From:   Gaelan Steele <gbs@canishe.com>
In-Reply-To: <875ymecp6f.fsf@meer.lwn.net>
Date:   Mon, 9 May 2022 20:14:54 -0700
Cc:     Miguel Ojeda <ojeda@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <0716311E-FD5A-489A-A17D-C427C1A0EE4E@canishe.com>
References: <20220507052451.12890-1-ojeda@kernel.org>
 <20220507052451.12890-19-ojeda@kernel.org> <875ymecp6f.fsf@meer.lwn.net>
To:     Jonathan Corbet <corbet@lwn.net>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 9, 2022, at 3:32 PM, Jonathan Corbet <corbet@lwn.net> wrote:
>=20
>> +It is convenient to instruct editors/IDEs to format while typing,
>> +when saving or at commit time. However, if for some reason =
reformatting
>> +the entire kernel Rust sources is needed at some point, the =
following can be
>> +run::
>> +
>> +	make LLVM=3D1 rustfmt
>=20
> I will ask whether we want this, though. Why would anybody want to
> mass-reformat the entire body of kernel code? This seems like =
something
> that would generate an endless stream of "helpful" patches and a lot =
of
> churn.

That would only happen if the code diverged from rustfmt=E2=80=99s =
output in the
first place. Generally, in Rust projects, the source tree is always kept
formatted with rustfmt - so running `make LLVM=3D1 rustfmt` would only
ever touch code that you=E2=80=99d just changed.=20

Gaelan=
