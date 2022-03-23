Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B19A4E5A91
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 22:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344878AbiCWVWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 17:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241081AbiCWVWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:22:30 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF335FDD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 14:20:59 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bg10so5432642ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 14:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=58oFgw+aSJKbmcVcBo8WJoE16fYK1EVOuFObJ6dRxLE=;
        b=E/euJg1O6WdvDAGao/Ysl1hYIzJqoY1BQobkcH3juoZC8UfixEm9MeHVqh3TPwhQE7
         AuwgdU7hITXRZX63oGEzlU8bvgd6wr2tnGaVSGCU9mpHf+iogW5jbqRftYiVetOjyZrN
         lusdVvRAMlH08NouLi3fBd6vcsV1MwFE0O62eN/OgfnWonVpvCnfcJzpwMFlHfW1Jzjz
         SyPPmxVFTep5V0qKFyrQ0wRdGAbCx/11vZ3IwlVIYa/csynGUgK1vPxZ+kIAM+WATT5s
         kN7oH2Ke3aRG3l6Wu8EvrMnI3fjPiHuOakjtuexVDonrVEYx23irntaDnEEZN+eg/5I8
         SIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=58oFgw+aSJKbmcVcBo8WJoE16fYK1EVOuFObJ6dRxLE=;
        b=syEkaB/drg7jq0B9nb6Zj4uQ0uCxO4+kmIrawJLHlfU+xRclet66EhDT5sNi5c8T9N
         fmk0hfDu3briPfbf4NosMEIKiR+vY1IAYJf68D2F5IxOrBcqbgUjI7cnI2tMXqsrphfD
         M/NJaqlZOTueew7fMA3Kfn4h8YjSsb0pdIl+Mm/BLR20B8qD0no+vyhXpwbiWmLlF1BO
         kKawiwn6cGP5BsKvQ/ujWj61+nzCmfUSsmsJ8O6yeKiD2bmude2dRXrEhjCgDaF6yPvT
         /ZPhT03SBYxATP5oK643viQtq27Rpz/7TkDrQ8XvBs9gB6OZrVn7fc3XfDf3GBDQ9zeM
         1Adg==
X-Gm-Message-State: AOAM532UJelKemiw9l+a/1+xFAjGNLoqmDozQpJK1gXeMjdT2P+N4o4v
        MnDo+jaelI+jUV+3VX9HOkePyPq5hpaV5E2vhfOAqg==
X-Google-Smtp-Source: ABdhPJzaCrJBL3DfPHCEbeIi+Uh/TeD+CQXGI0FEOYWafjGQBn/JTTZgPoLjrSoKM/jhJ5e3oN6nJBVLP1x+lee/gYQ=
X-Received: by 2002:a17:907:c018:b0:6df:e31b:d912 with SMTP id
 ss24-20020a170907c01800b006dfe31bd912mr2271911ejc.196.1648070458265; Wed, 23
 Mar 2022 14:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220224192036.2388302-1-dlatypov@google.com>
In-Reply-To: <20220224192036.2388302-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Mar 2022 17:20:46 -0400
Message-ID: <CAFd5g47Q9Z-YmqVSdHFwcXwPmLGq6QmjC+XanVMqXNrhBa_c3Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kunit: tool: readability tweaks in KernelCI json
 generation logic
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 2:20 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Use a more idiomatic check that a list is non-empty (`if mylist:`) and
> simplify the function body by dedenting and using a dict to map between
> the kunit TestStatus enum => KernelCI json status string.
>
> The dict hopefully makes it less likely to have bugs like commit
> 9a6bb30a8830 ("kunit: tool: fix --json output for skipped tests").
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
