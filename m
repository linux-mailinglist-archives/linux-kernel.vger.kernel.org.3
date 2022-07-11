Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A64570825
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiGKQRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiGKQQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:16:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6557B349;
        Mon, 11 Jul 2022 09:16:56 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bk26so7649689wrb.11;
        Mon, 11 Jul 2022 09:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WiDtpz4DFzzN4CMHxk5Je+M4pMYwKJq6wnnXOHhiOp4=;
        b=OjvJkB9xrUUlbDcQeT0QOnytLggMQ/FVNEYZkP91BoKZznv4pyOz386E7GLTiUfJDg
         pkIXR+RUqirod2RS0tRZg8FQeNqhkjexd/RIdxftV6Cw+tkrA8jjXYfEsu+9YnfpfEoI
         tXM2HGvVWTcACynvqHny2QWQGp+DK2OM5sWra4cx2uOfV7/QPs6utl3QuAbLEkUwR6DL
         J+GDZMU97ldJf9bB40h5s/LR6XaLyq57xed8fQlZFRjpVeYW3y1UrtjmAOFzrLJYl53U
         UPwpPKw4g5UzMnNisAq7ie7oVzyk/h3VMeRJupCJUPzY3y57tfYuxijHXo1mmemNPupP
         Erdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WiDtpz4DFzzN4CMHxk5Je+M4pMYwKJq6wnnXOHhiOp4=;
        b=FXMAbOhFLqPyytyMc2NW7EPQRTgeU6F6fOSJCwQc0M/7x5ddSVQ4ZDuMEyqZfsdR6b
         VEIjNuGVs7sRyDxgqZpkmRjnap3HpPv6WSzMFCAmQlNaejLEGtyOzY5uGyPPGwAEaU1P
         rQ49aCWqAD1l/di4Cq6zK8AZmqtFo40bnnGEQzkCeeeMNitkTv8EYgqELzhxJtRD84fj
         BhAZF8m7/YeVRs01TtHldEoX68trguDnLMwcCE4/b1N/YtpgLJUwwa73F+rlgUms25zn
         UvRpZIkx1zBaYJcd9KBZ2wdW/+YzcblWVJWhabdboetd5yScndeeOK96Gr6ASSb3UyFv
         R+QA==
X-Gm-Message-State: AJIora+53TbQ6K8okUMoEWqU34RfLRfNBbXmum26g7nHv93B27HeCae6
        L/c32CCWcr62cG8SV1KjuBdIa54MGEYlYQ==
X-Google-Smtp-Source: AGRyM1s07wOdSzua/6J3kzaD4h+2cHPQ4Mmbi4rl+YkHoFh2ou02yEzFJjPIe7oi1TQX8sN+gMKQTg==
X-Received: by 2002:a5d:6c62:0:b0:21d:2204:1338 with SMTP id r2-20020a5d6c62000000b0021d22041338mr17271106wrz.533.1657556214245;
        Mon, 11 Jul 2022 09:16:54 -0700 (PDT)
Received: from elementary ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b0039c747a1e8fsm12283344wmp.7.2022.07.11.09.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 09:16:53 -0700 (PDT)
Date:   Mon, 11 Jul 2022 18:16:46 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, stefanberzl@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH 1/7] HID: uclogic: KUnit best practices and naming
 conventions
Message-ID: <20220711161646.GA10528@elementary>
References: <20220710175043.192901-1-jose.exposito89@gmail.com>
 <20220710175043.192901-2-jose.exposito89@gmail.com>
 <CAGS_qxpotikOpURnnx5mVtormgEbkn7xp5Hi5FScnODa5P+_fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGS_qxpotikOpURnnx5mVtormgEbkn7xp5Hi5FScnODa5P+_fg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, Jul 11, 2022 at 07:41:53AM -0700, Daniel Latypov wrote:
> On Sun, Jul 10, 2022 at 10:51 AM José Expósito
> <jose.exposito89@gmail.com> wrote:
> >
> > The KUnit documentation [1] suggests allowing build tests as a module.
> >
> > In addition, it is recommended [2] to use snake case names for
> > kunit_suite and test cases.
> 
> Test parameters don't fall under "test cases", though I see how that
> can be construed as such.
> I don't think anyone has stated any preference to standardize the naming there.
> 
> We currently have parameterized tests using spaces and punctuation, e.g.
> ok 7 - binfmt_elf
>     # Subtest: ext4_inode_test
>     1..1
>         # Subtest: inode_test_xtimestamp_decoding
>         ok 1 - 1901-12-13 Lower bound of 32bit < 0 timestamp, no extra bits
>         ok 2 - 1969-12-31 Upper bound of 32bit < 0 timestamp, no extra bits
> ...
>     ok 1 - mctp_test_fragment
>         # Subtest: mctp_test_rx_input
>         ok 1 - {1,a,8,0}
>         ok 2 - {1,a,9,0}
>         ok 3 - {2,a,8,0}
> 
> So I think the old names were more conventional.

I changed the names to be consistent with other tests I'm working on
present in "gpu/drm/tests/drm_format_helper_test.c".

My first version there used full sentences for the test cases, but, if
I remember correctly, it was suggested to use snake case.

I don't have a strong preference about using one approach or the other.
If there is not a rule, I'd prefer to be consistent with the work I'm
doing in the DRM subsystem to avoid mixing notation or refactoring
there, but I'm open to change it.

> > Change the Kconfig entry from bool to tristate and stick to the naming
> > conventions to avoid style issues with future tests.
> >
> > Link: https://docs.kernel.org/dev-tools/kunit/style.html#test-kconfig-entries  [1]
> > Link: https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html  [2]
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> 
> Everything else (renaming the suite and switching to tristate) sounds
> good to me though.
> 
> Acked-by: Daniel Latypov <dlatypov@google.com>

Thanks a lot for your review! I'll wait a couple of days before
sending v2 with the Acked-by tag just in case you or somebody else
wants to add more comments.

Best wishes,
Jose
