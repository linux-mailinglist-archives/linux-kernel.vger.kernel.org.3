Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254894A49CD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349309AbiAaPEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239118AbiAaPEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:04:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF62C061714;
        Mon, 31 Jan 2022 07:04:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57BC361354;
        Mon, 31 Jan 2022 15:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5857C340E8;
        Mon, 31 Jan 2022 15:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643641470;
        bh=c9/aIQISNVasonKIg80yJ8DZ+88ghTU7a4R5TV5BYqA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OPTJsPH+qSZMU4HGxrApk5aDXgrJngzDT9NNg9Cvcc1sggkGjNaw5qFwjitt0BkM/
         W8mSWspwRga6zBOuJKsyWudlu7CkindXn5XvO26oZOnMdbUBCQbVHFlwUPOuqRBNU3
         aZLvDSLqKbYiJwdPAgeR8xGW9Sve1XPnKbDqDdkODaDeROSzl/6LKQta1M/iAsFhXw
         gmZzwaGvf7ls3eefPxSNlCZYgPFr8IsutQ9EEdUB3FW3wqQ72eOqb9gCb5VGCnhGpf
         6D0udCbX0joArdkwrbDS/OkyDVpGQmknC4fe6zQM9JGTJnFXz39rVAu+LCmZuP8t4y
         urbOrrtrHYb5g==
Received: by mail-ej1-f42.google.com with SMTP id d10so43929184eje.10;
        Mon, 31 Jan 2022 07:04:30 -0800 (PST)
X-Gm-Message-State: AOAM530qrhxbm+B9sUx6DunIOWKBdzD18RyGRPFpu1sajRJz2OBRVLXS
        +0g2VGl+FUuwu9i0aCQi57LC6N+aYNNfaK3FpQ==
X-Google-Smtp-Source: ABdhPJxCvifa8NdYiEd4LyN7DFBZmLM72HV5P4vfP2HKXZuIDTpk/LDTi+doPtRjQ8yJaV0xkntHpAIuWP+Q24LNcxE=
X-Received: by 2002:a17:907:7f1a:: with SMTP id qf26mr11560631ejc.20.1643641469027;
 Mon, 31 Jan 2022 07:04:29 -0800 (PST)
MIME-Version: 1.0
References: <20220127192643.2534941-1-frowand.list@gmail.com>
In-Reply-To: <20220127192643.2534941-1-frowand.list@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 31 Jan 2022 09:04:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLSsHJMKqOcLYR6uegghy8acLmu7iOX40gp__XVaShBUg@mail.gmail.com>
Message-ID: <CAL_JsqLSsHJMKqOcLYR6uegghy8acLmu7iOX40gp__XVaShBUg@mail.gmail.com>
Subject: Re: [PATCH 1/1] of: unittest: update text of expected warnings
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 1:26 PM <frowand.list@gmail.com> wrote:
>
> From: Frank Rowand <frank.rowand@sony.com>
>
> The text of various warning messages triggered by unittest has
> changed.  Update the text of expected warnings to match.
>
> The expected vs actual warnings are most easily seen by filtering
> the boot console messages with the of_unittest_expect program at
> https://github.com/frowand/dt_tools.git.  The filter prefixes

News to me there's such a tool. Normally, I just give up staring at
the wall of text spewed out and check failures. Can we add this tool
to the kernel tree? Then there might be some hope that I'll run it.

Rob
