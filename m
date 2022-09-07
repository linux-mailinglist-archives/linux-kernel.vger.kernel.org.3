Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4B75B0BBC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiIGRpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiIGRpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:45:25 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A663054F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 10:45:24 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id y18so11026558qtv.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 10:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date;
        bh=5TF/7Ge8AarupLQS/YY50TBrTd0spxW1v76SnBwcGAo=;
        b=iRBDHJm0KCq8rGVHywkz8m+OQ5SjDjc8zcsG+O+2wUDPBHACKfsvyuwulMHUjpuOL+
         rp0sKd7QJDVdB56z16a2ypKlglgjcgaQJ6wVKJF0rmpjRMX2Da68NBCmppi50Eef+OD0
         gKgb9I1DDsyyOTl0+hsE0q/1N8pN1OKucN9q4PU2K8WaPN5aiejN2+PKvpDpEdfXlFSR
         uLxKG/dD2IbjT4hyR+lDA+tAF6r5f9rE/CDkkH+WeY5iIVVhMIKewq5MQdgxeAUXt4Le
         rd3wRvpOJOGklZvrPGEgB52BG32PCj5c0/ckmip2MpOoeFabL0ZzusMLP/EBXFSBBVpR
         CwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5TF/7Ge8AarupLQS/YY50TBrTd0spxW1v76SnBwcGAo=;
        b=ZnTltDxKyJhnHyWquYAw4YtyLbQDx6i/QCkuIBEdgk18/rgBEB/3kLHQ8jtsoLF2YI
         K+FaOKUHLICxTq4nAvk88XEV8JdP8iqTGMuVFTSB6GyTf4GVoYpJeMoJpjt4Z1pqY2DF
         nJWe7j9CKuOjkjZz2XcD9SWXoE8nsJYhBcMu4HozXF4xlR2wdANzU7tUBWoExTtzPnDp
         6v5/EriQ32DOPwSMpiTOn6HRuloHfkWRafVLivJbaeqhjtQqLlG6mvlpXinV5FfPt2UY
         HRuYHSebDa9gXTqWpczwj4dyb0e7oiz6lu8AtBaUIP1gX/BgXjPnxr7afM6q3V4DsKRp
         KXLw==
X-Gm-Message-State: ACgBeo3uGINa6V/eWfeQYC0buao3ENxnMtjiF+BHQ3vjq6D621GCdM9u
        4rG68pS5sJQiDyzQ4en7Crs=
X-Google-Smtp-Source: AA6agR6WiqHok6tRliCvnpHXulSKvMevKo+ZGr9+s7qVaub9L4Oen+QHpj3u4cUDpYURHKDuTQs2pg==
X-Received: by 2002:ac8:594a:0:b0:344:9e0e:cdc1 with SMTP id 10-20020ac8594a000000b003449e0ecdc1mr4411158qtz.144.1662572723386;
        Wed, 07 Sep 2022 10:45:23 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id 73-20020a370b4c000000b006bb619a6a85sm14075841qkl.48.2022.09.07.10.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 10:45:22 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8DFC427C0054;
        Wed,  7 Sep 2022 13:45:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 07 Sep 2022 13:45:22 -0400
X-ME-Sender: <xms:stgYY3n5uO-BxZxO3jSOmW-0Y2vweT5QpkbrdOGD2oOSfVq64VGHzg>
    <xme:stgYY60KZ3OYLIWrKVCN5bs8-FFyetB_0AlC6KUYSE7m0Ek9akck5daFwcKAWiqxX
    6K5kzLoBiyGTPm5Wg>
X-ME-Received: <xmr:stgYY9pRU4vSM2YTk7D_eux6SftdT8vSQSl-sLf3Tg1BQmlMWhH7RaPYjsY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedttddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:stgYY_kh3_N3Ad4NorsIKLTFeyQ4AteU7NOQ67MLPByzOQn49LHM4w>
    <xmx:stgYY13xVsoeBq_vu0DXKErcV5IKpht9NgV8MW11F9Y0d5nbi6Dxqw>
    <xmx:stgYY-vugOztKNY58mmD98DcRmfgM_PaTk4cNgWnQKuVfTIt7jAXqw>
    <xmx:stgYY_yy1Is6mgViGl2LK297ISntb9MZKXlHhhfa1R2GyGDkW2aPSA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Sep 2022 13:45:21 -0400 (EDT)
Date:   Wed, 7 Sep 2022 10:44:03 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: Re: [PATCH 2/2] objtool, kcsan: Add volatile read/write
 instrumentation to whitelist
Message-ID: <YxjYY6SJhp1PtZos@boqun-archlinux>
References: <20220907173903.2268161-1-elver@google.com>
 <20220907173903.2268161-2-elver@google.com>
 <YxjXwBXpejAP6zoy@boqun-archlinux>
 <CANpmjNN2cch+HDVUYLD27sF9E39RaFrCf++KN=ZZ7j0DH8VaDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNN2cch+HDVUYLD27sF9E39RaFrCf++KN=ZZ7j0DH8VaDw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 07:43:32PM +0200, Marco Elver wrote:
> On Wed, 7 Sept 2022 at 19:42, Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Wed, Sep 07, 2022 at 07:39:03PM +0200, Marco Elver wrote:
> > > Adds KCSAN's volatile barrier instrumentation to objtool's uaccess
> >
> > Confused. Are things like "__tsan_volatile_read4" considered as
> > "barrier" for KCSAN?
> 
> No, it's what's emitted for READ_ONCE() and WRITE_ONCE().
> 

Thanks for clarification, then I guess better to remove the word
"barrier" in the commit log?

Regards,
Boqun

> Thanks,
> -- Marco
