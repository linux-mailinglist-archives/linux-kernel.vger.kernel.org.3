Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2B44CBB97
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbiCCKmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiCCKmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:42:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E937111E3D2;
        Thu,  3 Mar 2022 02:41:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1D1DB82467;
        Thu,  3 Mar 2022 10:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042BEC004E1;
        Thu,  3 Mar 2022 10:41:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fXZ/TAG/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646304075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kpi2ggBMqpkgTKrHO8zFwhQlKDt8cDqLL+uADYbJkFw=;
        b=fXZ/TAG/R70HCQfSXHa9EmGz7TeBBluFgHaGXfH7hgkJcP8cchmV94YqDgR0+89DtKCv2t
        7SFHDKQy9vw0egnrfwFwxIAAwiKJ+sHioOnU7+5oYyz+Qh7MC6vtqGCbXJRGGX4FiaaInT
        NtNERqGIiZlL3+1wKvphvuNa7vx04OU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3040dfd0 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 3 Mar 2022 10:41:15 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id g1so9332688ybe.4;
        Thu, 03 Mar 2022 02:41:15 -0800 (PST)
X-Gm-Message-State: AOAM532dFBcYrbUOS2kQx3BGT+0w1eiyk6pWb/tYtxJYC308TE/Atbuq
        gr96MZKMRA7yIJNwclx10pm0VyKg8mU02VkQ2ic=
X-Google-Smtp-Source: ABdhPJyPEE4gCKlFoezcuhcaB7fuOrbEaAT8Kipld7pwixBTKllT3UjtYnzw8zojJixj7/zAXTuM05vpAR6vVZwaKwM=
X-Received: by 2002:a5b:6cf:0:b0:61e:1371:3cda with SMTP id
 r15-20020a5b06cf000000b0061e13713cdamr33199674ybq.235.1646304074230; Thu, 03
 Mar 2022 02:41:14 -0800 (PST)
MIME-Version: 1.0
References: <20220303190450.18626eea@canb.auug.org.au>
In-Reply-To: <20220303190450.18626eea@canb.auug.org.au>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 3 Mar 2022 11:41:03 +0100
X-Gmail-Original-Message-ID: <CAHmME9qTWSsa8Rjf+rS+hgWiTQTZOtU83TvPUE3uBYvRN9Xb1w@mail.gmail.com>
Message-ID: <CAHmME9qTWSsa8Rjf+rS+hgWiTQTZOtU83TvPUE3uBYvRN9Xb1w@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the random tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thanks for the report. My CI barked at me about this too this morning.
Seems like a surprising circularity in arm64's headers that maybe
should be fixed. But either way, I'll go with your forward declaration
approach.

Regards,
Jason
