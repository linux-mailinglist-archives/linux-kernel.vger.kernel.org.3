Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D8B51C417
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381381AbiEEPoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiEEPoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:44:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8D71D0D1
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 08:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CF5E61D32
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 15:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A628EC385B0
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651765222;
        bh=L8Fn2QpjvRiO3TEnhoUJuJYihx1piB1iKAyPMCvAhec=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D0b/LzZPQf5y9jWOu6bvmEQDxT9PZEEe8Q6+tWNNAcbLbusUWmm1GzdV4SEK0MCxE
         Du/gNnBnBVkCtJdAQala4tdqWquBZ/mSroFHwAM1GO6Pqxrue8Pr1mESTKlWxEFq4d
         z5MbhPJd64pTo/3NqHi1ef+dQaNcVWgAoJTDwkoxmH2aUxBy5/6mE4mtRVJ1zk9ICD
         OwWdiTBWHpuw5Dg+kf3Iac09ETfvd9eQ8+Q1yiIxsydQwd7r/SkhI388cVUcoY67hm
         iBFK8oEa5jF0hvIqu4o3ZuThJsjCnQC2o+5CesQuq9ftDJuNmmsse8RB2MGVfbrioc
         C/Eal/XeLEVJw==
Received: by mail-pj1-f50.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso4445641pjj.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 08:40:22 -0700 (PDT)
X-Gm-Message-State: AOAM532wRs/xyv8YybS2bFeEOhqTDc4Xyth/84dWTHmYqPd48K1vXJc/
        YaYUvm8jfGYfD/o+5fyWCjCF1eByLtCOgoPkEQ==
X-Google-Smtp-Source: ABdhPJzhmSe8MBSXLNIzfIAKACuSqoqdkwHZ3px74LTROha4izEqkIjWi4YfV/EIwUf9ri7fN/cX9xltHMn/uwh/Qi0=
X-Received: by 2002:a17:902:e481:b0:15c:dc24:64e8 with SMTP id
 i1-20020a170902e48100b0015cdc2464e8mr28432372ple.35.1651765222168; Thu, 05
 May 2022 08:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220504180822.29782-1-pali@kernel.org>
In-Reply-To: <20220504180822.29782-1-pali@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 5 May 2022 10:40:09 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLKjd3zPssbTo=mBfoa6nV144k9TamStk-jO3QbunmSAw@mail.gmail.com>
Message-ID: <CAL_JsqLKjd3zPssbTo=mBfoa6nV144k9TamStk-jO3QbunmSAw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/85xx: P2020: Add law_trgt_if property to PCIe DT nodes
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 1:09 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> DT law_trgt_if property defines Local Access Window Target Interface.

Documentation?

fsl,law-trgt-if would be the preferred form.

> Local Access Window Target Interface is used for identifying individual
> peripheral and mapping its memory to CPU. Interface id is defined by
> hardware itself.

Normally, we avoid instance indices like this, but if it is more than
just documentation convention maybe that's fine.

Rob
