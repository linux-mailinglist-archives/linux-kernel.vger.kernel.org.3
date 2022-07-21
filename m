Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E415A57C3C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 07:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiGUFeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 01:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGUFeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 01:34:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BEE4BD13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:34:02 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bu1so646666wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 22:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pLuaJ2LEb4NfU4vvBKr0ulQIYPO0Q2uVSE08ta5PpNs=;
        b=UZdKi+5jMjtx9+tlEyQBKQQStLl66JDK3Vo6Zre0xl3sBn+tCTd0AnzKQLMK7OKaO7
         UETWKRZ6WccUHsliHG3iMU/QyjZgVE3x3Voq9IJsz4ALn5J1PXfDGexPF6gvYxX+e6O+
         5SRA3GUPfQ9rZgrJhMo28Tzu0v2brHvFJtAaAesubUF/3kYO7mAmvTTJlaCeTgMKJwmG
         q/8UKggAJtVS77zDsEm4r65N8HnHW4LmhKkZ7Nx+5/PL4Pet6Z0YapXiWPVuXWiTTPH5
         ow62/wzkbCRZXEvAlTr9K5UhgFJ1IXnA6c1y7FX0Cmey6wVMpkib2LgtPBZy9ZEJEvmB
         rxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pLuaJ2LEb4NfU4vvBKr0ulQIYPO0Q2uVSE08ta5PpNs=;
        b=CJAIhEn2NajKMt76ie6GWAARdmUYABUZS3z4vLqCyln/LA2fwcWi1j1+/OdxnNlyGS
         i4One0sPCEET+gjuVIvwc3Bv2/py+rFksxDTjo2q0WCStf4nbnrZW4PFJFzmwM4Mu9Z9
         EmAUocMl7/2lkxSWsncRzhtfQP2HoP5DD2J6/zzhjxl5XLitj1bHPIKU490chlhxEiC1
         J3dEsKWl1Lwsd4jxZ07V+vC8UUQJJHB7L4ZCPkpkvIfSF4KyuJ73tODQTMzzRtctt8Jq
         QNRs+uHrvtDivuW95QLSTsRphCLMG0TAw5yD3v6pESVP+w9KghQ10yZpPkmMFfnDOVn4
         GgSw==
X-Gm-Message-State: AJIora8mEkLVEOpLLH2AQ8cGOPcrY9W/2kCulBlJhzdg6wDQIrXKIpvQ
        D4c7luw9l4F4Jalf56z/loHV/2SRXnQROeQCaMRr0A==
X-Google-Smtp-Source: AGRyM1tnX459j02NM7ciHe1lLHAJ6aHOObLD3951hy7Fq78xuph4pEBkFBpJ4hGor2tXgntNmnMQ3bUyJMO5YpKBr9Q=
X-Received: by 2002:a05:6000:1a8e:b0:21d:a7a8:54f4 with SMTP id
 f14-20020a0560001a8e00b0021da7a854f4mr33978134wry.654.1658381640252; Wed, 20
 Jul 2022 22:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220721090500.35774b43@canb.auug.org.au> <CAP-5=fV+Oo+__sWTgfqyVKwyr1FxYYSv9H6H72CgdQN_Jv1ZAQ@mail.gmail.com>
 <20220721135556.5443eff4@canb.auug.org.au>
In-Reply-To: <20220721135556.5443eff4@canb.auug.org.au>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Jul 2022 22:33:48 -0700
Message-ID: <CAP-5=fXWH2Hm=n5YCaOL3cYys6UXQfPo3H3OeZKTOSvNQu64UA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the perf tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <rogers.email@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 8:56 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Ian,
>
> On Wed, 20 Jul 2022 19:35:45 -0700 Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, Jul 20, 2022 at 4:05 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > I installed python3-setuptools.
> >
> > Thanks, could you give more details? Are you overriding python to be
> > an older version on the command line? What does "python --version" and
> > "python3 --version" show? Installing python3-setuptools should be what
> > you need, but I'm not sure why that's not working for you.
>
> I am not doing anything unusual.  What I meant was "To fix this, I
> installed python3-setuptools as I did not have it installed before".
> It built fine once I installed that.

Ah, thanks for the clarification. We could do something to make the
remedy of this problem clearer.

Thanks,
Ian

> --
> Cheers,
> Stephen Rothwell
