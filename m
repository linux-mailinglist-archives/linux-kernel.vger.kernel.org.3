Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DE353EA3F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbiFFKQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbiFFKO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:14:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62E515A420;
        Mon,  6 Jun 2022 03:12:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q15so11141392wrc.11;
        Mon, 06 Jun 2022 03:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Kc9pss6M5EdVd6bDsVFlb4mRLyBK68pzKpY9UHLCNLQ=;
        b=PAsde7FE0eY245VPPyo/QV2ScdBZkyuRErqW696uwoJ7Xglgd7Vi4eX5uTqdz81P9y
         ty2d2NjBH975NDBE/zAw4mearKzN63EVJEe9t1TwxJdnqjrrQ3vdulAk8+vCSk4MnOJb
         S8L0cG4I98kMCbq0utiJxVNuFq5Ju8ijqzJB8oGpok6vXSL5J8JpZp5wNB5Hq8IaXK7U
         9GVM+jtZ4EZdKLZUeGhAu5wy/0KrekP138W1lkRMCEDAczdSi5zydgVJGxxa96dBWNw5
         fZcDOazXnTMSK8xuhAEM8YXkk+xd1nf1ZmZp6DRbTTFlDMi1QjjhMjfY1k94P+3kwWUl
         z1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Kc9pss6M5EdVd6bDsVFlb4mRLyBK68pzKpY9UHLCNLQ=;
        b=T54815JEF12I5ibGoa63UKtdyS7WJCerDReZN/kyAZCngsX6bTL3m5LtkGakeom52H
         KnIPK8uBT9c1REWzhFDAO1BL9ZY25ToDRqSDrY1b3BArpu7XmosY2qovSe3C+seBFsiz
         nHWOszK+TzN8ot2KHBy6t/B4YGBoMHr4Byds1CREMR91NZPhwerx/RqWGfSX8j9MCJDp
         agJCtAKczxrCaLaL1/MAurOpW131tE7xgTmmh1MN6dDiCP7lJnh4/+7ijWUidwkAYQvR
         Bjx8rDhTUUcDt0exisvw64UxkZpt/8ZeKzESpcPojwMDzynCfjcEcBScvDW+fFGUc1Hp
         3yeQ==
X-Gm-Message-State: AOAM5333Lb7Ra3vrh/kSZdob22RpFvN47WcUAiWU3TtpBTvbTLCEIOYn
        MVVp2O5O8IU/qaQNeAY8ZYNS+RF8xOBo8A==
X-Google-Smtp-Source: ABdhPJxfzuPe49YNxWdW/gGPul24wHOZAPedrL65hAqJIBMCmHrfWfuPReHDT2XMFXFZF2kwTBccdg==
X-Received: by 2002:adf:dd8e:0:b0:213:bbe1:ba56 with SMTP id x14-20020adfdd8e000000b00213bbe1ba56mr15223637wrl.559.1654510362390;
        Mon, 06 Jun 2022 03:12:42 -0700 (PDT)
Received: from elementary ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d4643000000b002103a7c5c91sm14484690wrs.43.2022.06.06.03.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 03:12:42 -0700 (PDT)
Date:   Mon, 6 Jun 2022 12:12:37 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com, dlatypov@google.com,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH v3 0/4] Add support for XP-PEN Deco L
Message-ID: <20220606101237.GA939277@elementary>
References: <20220531181246.190729-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220531181246.190729-1-jose.exposito89@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 31, 2022 at 08:12:42PM +0200, José Expósito wrote:
> Hello everyone,
> 
> This patchset adds support for the UGEE XP-PEN Deco L tablet.
> This device belongs to a family of tablets that must receive a chunk of
> magic data in order to be enabled (named UGEE v2 internally).
>
> [...]
>
> ---
> 
> v1 - Initial version
> https://lore.kernel.org/linux-input/20220518224702.1409327-1-jose.exposito89@gmail.com/
> 
> v2 - Fix some errors reported by the kernel test robot:
> 
>  - Add MODULE_DESCRIPTION/LICENSE/AUTHOR to hid-uclogic-rdesc-test.c
>  - Remove unused variable in uclogic_params_ugee_v2_init
>  - Add sparse __force anotation in the result of cpu_to_le16
>  - Add DISABLE_STRUCTLEAK_PLUGIN for KUnit tests
> 
> https://lore.kernel.org/linux-input/20220518224702.1409327-1-jose.exposito89@gmail.com/T/
> 
> v3 - This version:
> 
>  - Improve Kconfig message
>  - Add .kunitconfig. Thanks to Daniel Latypov for suggesting it in an
>    unrelated patch:
>    https://lore.kernel.org/dri-devel/CAGS_qxpV2SsihEdgXZ6+7N0dxLmdRANq+qE4iUZ2aNrf6vuLYg@mail.gmail.com/

As mentioned in the v3 changelog, I'm working on a DRM patch including
a few KUnit tests [1].

Some interesting highlights from the comments there:

- It looks like the maintainers prefer to include a single symbol [2]
to enable all tests in the subsystem.

Jiří, Benjamin, how would you like to handle it? Would you prefer to
have a symbol for each test (HID_UCLOGIC_KUNIT_TEST)? Or a symbol for
all tests (HID_KUNIT_TEST)?

- DISABLE_STRUCTLEAK_PLUGIN is not required [3]. I'd also need to
remove it here.

Jose

[1] https://lore.kernel.org/dri-devel/20220530102017.471865-1-jose.exposito89@gmail.com/T/
[2] https://lore.kernel.org/dri-devel/CABVgOSkCxu2xBnxwc6mO2AQaqzTbDf53PJzT2QvZNyLeumt5hg@mail.gmail.com/
[3] https://lore.kernel.org/dri-devel/CAGS_qxpFO4ixW=08ZcdcD9J1kU=B3mwoBJkPW8AKu0sKs8aKfA@mail.gmail.com/
