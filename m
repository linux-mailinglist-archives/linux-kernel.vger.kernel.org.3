Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF49E5A3843
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 17:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbiH0PIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 11:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbiH0PIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 11:08:40 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DE218B22;
        Sat, 27 Aug 2022 08:08:40 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8851C2CD;
        Sat, 27 Aug 2022 15:08:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8851C2CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1661612919; bh=++78R52/4uBzkgUJP30cx1lrN32jhH4WSmTjghSQ3jI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XjWFeZIVvVJjvv98cPpG496VVasWypMrasvuYfWferT2kmPKfe9kdiPc2bl7CTz1I
         RZndxkZ3bOZe5dpvZeGREltBqnIj2O7IibkEAf9eX3DIsEjWvxQi4uBkZFtgrB4Di4
         Kjbw/FfxbCQ8bcCTtanWPVZP5WC6YzIDWjzZr146P4pzprEQmgyw+GeFcYMhE7HZlx
         e+kF/gCUKSqrLfBqFUHTYDRnnlKnHw3ROi5K1O2nLCaUQxHGOO3EMc2jND+frh4cBE
         +/gVNVaXmXwxyc6A10TX2ugFVePTvsntqKt6ZdHkrl8j/EKWCUVi2osOL25kDFWmZa
         N/gDsjyr8dJKQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, sfr@canb.auug.org.au,
        bagasdotme@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH net-next v2] docs/conf.py: add function attribute
 '__fix_address' to conf.py
In-Reply-To: <CADxym3av1mU3LzVzJ65B4RHispPU+W5CBz5K6jp6bHZn5fr15g@mail.gmail.com>
References: <20220826160150.834639-1-imagedong@tencent.com>
 <20220826135839.39c7711f@kernel.org> <874jxyu32m.fsf@meer.lwn.net>
 <87zgfqsld6.fsf@meer.lwn.net> <20220826152711.6756e510@kernel.org>
 <87v8qesk0i.fsf@meer.lwn.net>
 <CADxym3av1mU3LzVzJ65B4RHispPU+W5CBz5K6jp6bHZn5fr15g@mail.gmail.com>
Date:   Sat, 27 Aug 2022 09:08:38 -0600
Message-ID: <87ilmdsozt.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Menglong Dong <menglong8.dong@gmail.com> writes:

> Thanks to both of you! Seems I don't need to repost this patch
> with netdev@ CCed?

No need, it's all taken care of.

Thanks,

jon
