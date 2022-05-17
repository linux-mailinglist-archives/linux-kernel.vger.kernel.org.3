Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C22752A39B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346627AbiEQNin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244994AbiEQNib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:38:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C928F4CD68;
        Tue, 17 May 2022 06:38:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84609B8189E;
        Tue, 17 May 2022 13:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A48C385B8;
        Tue, 17 May 2022 13:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652794707;
        bh=B/9vOYnzTrgGAM82dic4PZwU7tuJWN1ABrpQlOcm1YM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U2VEo48P5IDqpJ+elC6h2zXkm7G6M4s+vBL+up/wdrsk9U879lIvtg5Wn4IuPtX5T
         1m97h3bPvrnftmMX0d5nvz9NCNKR/C2GZHmawatn1dIzdAkwO27xv21eAtR1vftTEl
         Yr1GfXOBJFf52nC3IeJuFYDU8EzPZps+jVpTtmOJ3II8fZPjmdVbRYDYqlNms9wXu0
         n89R9q9ov5lsOEcz0Lpue/WazdmKFH5/T6brzbqXrQP3QEIyvkSZYR+5xRp6vx3Uch
         xAxOt8NSPbEMlrjyml23JyYYzrAkkg5AfWN3WV6JjGWK98tHi39lPdypJVK9g6dplz
         fBXIbACzE2EwQ==
Received: by mail-ej1-f42.google.com with SMTP id z2so34762552ejj.3;
        Tue, 17 May 2022 06:38:27 -0700 (PDT)
X-Gm-Message-State: AOAM533Zl8e280HJNAXs0aDtIh95iDZY50ri2mvqCZ2rvjUD6+Zhbx+M
        5QBW/t6WdxdmCRO/u5ln/lhTUaPjhcQQTKi66g==
X-Google-Smtp-Source: ABdhPJx1Ius5cnAY+s3ZmHKBruzkli4FvXOrTtKjrVX6wSYZY22ZjzVCQDq4nFBw0C8uno2E89KpcX8tgO1EF5UPVo4=
X-Received: by 2002:a17:907:c30f:b0:6fe:5637:c130 with SMTP id
 tl15-20020a170907c30f00b006fe5637c130mr5165915ejc.270.1652794705444; Tue, 17
 May 2022 06:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220510221333.2770571-1-robh@kernel.org> <CAK7LNAQYL7rkqsWfNSdS53_sf-SLqpuVeoSmZuGqRNNtScT6Hw@mail.gmail.com>
 <20220517011214.GA3716531-robh@kernel.org> <CAK7LNAR_59AAEQ8wZzpmi5M4SyGspUGdyFgOqQR689DmpE_RCQ@mail.gmail.com>
In-Reply-To: <CAK7LNAR_59AAEQ8wZzpmi5M4SyGspUGdyFgOqQR689DmpE_RCQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 17 May 2022 08:38:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJTEL5Z+Qmerfdwn43KtKYQi02T+M2C1nUGUyqNFhYeTw@mail.gmail.com>
Message-ID: <CAL_JsqJTEL5Z+Qmerfdwn43KtKYQi02T+M2C1nUGUyqNFhYeTw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Remove example file on dt-extract-example error
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 10:03 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Tue, May 17, 2022 at 10:12 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, May 11, 2022 at 09:27:00AM +0900, Masahiro Yamada wrote:
> > > On Wed, May 11, 2022 at 7:13 AM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > As 'dt-extract-example' writes the example dts files to stdout, a file
> > > > is always created even on an error such as Ctrl-C. The resulting empty
> > > > file(s) then cause unexpected errors on subsequent builds. Fix this by
> > > > removing the output file on any error.
> > > >
> > >
> > >
> > > Did you really set it?
> >
> > Set what?
>
> Sorry for the typo.   I meant "Did you really see it?"
>
>
> >
> > I'm sure I've gotten empty files which then throw errors on the next
> > run.
>
>
> Hmm, OK.
>
> When you observed this issue, were you using
> a pipe to another program?
>
> For example,
>
>   $  make  dt_binding_check  2>&1  |  tee  dt_binding_check.log
>

Indeed, I am. I only do that all the time in my build script...

>
> > > The target deletion on interrupt is automatic
> > > since the following commit:
> > >
> > >
> > >
> > > commit 9c2af1c7377a8a6ef86e5cabf80978f3dbbb25c0
> > > Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > Date:   Fri Jul 20 16:46:33 2018 +0900
> > >
> > >     kbuild: add .DELETE_ON_ERROR special target
> >
> > You're saying I shouldn't need this change? For some reason I do...
> >
> > Rob
>
>
> If .DELETE_ON_ERROR works as the manual [1] explains,
>
> [1] https://www.gnu.org/software/make/manual/make.html#Special-Targets
>
> the deletion of the target is automatic.
>
>
> Basically, it worked like that, except when Make is piped to another program.
>
> I asked this in GNU Make ML before.
>
> When Make is piped to another program, which is terminated by Ctrl-C,
> Make is also killed by SIGPIPE before cleaning up the incomplete targets.

Humm, that seems to make the feature less useful to rely on.

Rob
