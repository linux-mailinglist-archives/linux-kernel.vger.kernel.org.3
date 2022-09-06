Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0365AE194
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbiIFHtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiIFHta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:49:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F022AE56;
        Tue,  6 Sep 2022 00:49:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB987B815A0;
        Tue,  6 Sep 2022 07:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85ED5C433C1;
        Tue,  6 Sep 2022 07:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662450566;
        bh=LLY9XiJ3fgQyYXrECJDqGHa9WhvvXhgQjyVm6qCG85o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vLZlAckCCoTDfBteD/wDw2mxEKOKDJfVH3KBt1I5UrZ922Dg0ikN5KyRm7JfNQgqB
         /TSZ+t83lvarXI+Qq+ZQvpH3OMqO+bbGx/9Mf+JUSD/+0QJYdiFv+68pvViTL5daLV
         FUjeahv198rRhqg6xrOiDPeedDjF3tdERhxh/JMwqDaJLrlKTBAsB3Z6KtPlb3YfMh
         E8T1K+JPnCcJOuRHk88YMTTE9G3/6hbdju98a2hZ+LtWLVtcwcSRVenJWSxR6Tmyih
         6i9zTfuVM0XdmjSLlC5qBrVdtDnbzJmxzIrRn5skTht6h6HxwTm4KKeCIEpnWCS/vA
         KPKepkSpUspwg==
Received: by mail-ot1-f50.google.com with SMTP id t11-20020a05683014cb00b0063734a2a786so7530505otq.11;
        Tue, 06 Sep 2022 00:49:26 -0700 (PDT)
X-Gm-Message-State: ACgBeo0pCodcEZZzhkHeZ9QR7Thl+MViWmKbvzwp9Ts126mGLND39ZkY
        p2kSB2vzs0r7Tkwgrfi1zK+Z7utp/L+91cCNcCU=
X-Google-Smtp-Source: AA6agR6R1Q6aly46JZw+xyVtYw5+83EKI8kdg8A/XvbISjUQ8FinO6dK0+Lx8PUJ9lBDWQp28kIol+KCYXS1Yqap8Ag=
X-Received: by 2002:a9d:383:0:b0:639:2c3a:fa26 with SMTP id
 f3-20020a9d0383000000b006392c3afa26mr21705512otf.8.1662450565652; Tue, 06 Sep
 2022 00:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220906073746.1f2713f7@canb.auug.org.au> <c2131428c8398da5c1b4d9c5c0a491c2a262bb74.camel@toradex.com>
In-Reply-To: <c2131428c8398da5c1b4d9c5c0a491c2a262bb74.camel@toradex.com>
From:   Shawn Guo <shawnguo@kernel.org>
Date:   Tue, 6 Sep 2022 15:49:14 +0800
X-Gmail-Original-Message-ID: <CAJBJ56KKr1jK3okYVN4WkHmY3BTC3zL8kiaDt_CO12LvZp9ZVg@mail.gmail.com>
Message-ID: <CAJBJ56KKr1jK3okYVN4WkHmY3BTC3zL8kiaDt_CO12LvZp9ZVg@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the imx-mxs tree
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 3:23 PM Marcel Ziswiler
<marcel.ziswiler@toradex.com> wrote:
>
> Hi Stephen and Shawn
>
> On Tue, 2022-09-06 at 07:37 +1000, Stephen Rothwell wrote:
> > Hi all,
> >
> > In commit
> >
> >   47170487f674 ("arm64: dts: imx8mm-verdin: extend pmic voltages")
> >
> > Fixes tag
> >
> >   Fixes: commit 6a57f224f734 ("arm64: dts: freescale: add initial support for verdin imx8m mini")
> >
> > has these problem(s):
> >
> >   - leading word 'commit' unexpected
>
> Sorry, I missed this and checkpatch did not warn about that one.
>
> @Shawn: Can you fix this or do I or Philippe need to do anything like sending you another version with this
> fixed?

I have fixed it up.

Shawn
