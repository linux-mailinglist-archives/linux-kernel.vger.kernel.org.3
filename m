Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD1458CD94
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243542AbiHHSYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238455AbiHHSYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:24:06 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8129713DEF
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:24:05 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id h4so289661qtj.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 11:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=x+IXXbX8n1SzplLgFQFMWHXuNOYBYl5/4C1Itv/q88E=;
        b=j/UdIVmnNTxs95JeDTbaXQqHzWLQ2WtNNg9M5uqRJRJhUwdEYiPrloEbN8fQBtBjpZ
         EevDBUHagRHl4CpQh/gpCXZzTKgkxdHR1dGFng4xJgkLT1Jitru5FdwQ5Np9ZWQBXERG
         Ov0pL86fkUBagYqLD1Irf4e/sZ7j0CRd37xcHJ9smzt1FSI8Ye6iMDPAmOTL8o9L6Ppg
         DVd6/xBHN3alQYzhxCRtYdI8rs7XqszGrhG5re8TbDqlIzWi7rg5GhbwZj/YovqaObtO
         ukj7pcHEc2mTGN8gvRTaOdnhVoJZt+pqIlkUcADxgwqkMJWq5+85N4gt4Fg8/1WLyZUa
         AdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=x+IXXbX8n1SzplLgFQFMWHXuNOYBYl5/4C1Itv/q88E=;
        b=Y+W4z18g//dcOl+F5iAqIn5zEDoECIQeet71rFeCI5pi+ywvtzjtiNtwY49ja0b5ox
         cGWduQdtL02omZMry0L8lVeWnVASMAub57gdUBS5daI2WgLoU/utg0jO5UwxWqilrXNl
         utr7aw3aU+Pb1/581vB9s7FnrqlqkWwdrkgNmLP7a4hVFibHG4G0oJz7QyTo8dLMQu7z
         4B0Zu/qeXGPe6WK4jCOV3ma+RLnLOrcYdo8jD30W8Tfetzr9K/0Wgjx4FeI2ZE7p79XU
         WTG4dc13VMDizmqU58MgGJrNL6cF6E1li8+Q7LAzmv1hnO4RQUghAx5QsydXbjx5Rrcx
         Y/bA==
X-Gm-Message-State: ACgBeo1BHHQxeVNsYytJi202/5oea//vvQqGm7gMUE5VreXo2yzdKott
        rkW6XoayjXJC/Hm0ud6i6AyBld+4ya09Xh4bC9o=
X-Google-Smtp-Source: AA6agR77aPk54YPe5EmbsJQ2hsbu3yH9kOxVoIadV7VeIEmOIxDEQvUeNSUaMtASXiDop9hBBuiEpTIs/4vDTesrc6s=
X-Received: by 2002:a05:622a:14cf:b0:343:5b6:68ca with SMTP id
 u15-20020a05622a14cf00b0034305b668camr402165qtx.195.1659983044547; Mon, 08
 Aug 2022 11:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com>
 <YvEKgkhRWCKtXdD4@sirena.org.uk> <CAHp75VeeZAgKdZhJffNouFh26rwGzmqGuJX7bcObSVV+dFS-tA@mail.gmail.com>
 <YvEUJ12TmgRaR4Ub@sirena.org.uk> <CAHp75Vd_wks4d4HyFQpWWUQO-DPj7bmm6e66LSZ3F0+O6fC6bw@mail.gmail.com>
 <YvExSVixNUpOivja@sirena.org.uk>
In-Reply-To: <YvExSVixNUpOivja@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 20:23:28 +0200
Message-ID: <CAHp75VfL2kKqP5m1SZfBdd0Z-kLg=rcccAxmQ4LOd88gOuFcww@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] regmap: mmio: Don't unprepare attached clock
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 8, 2022 at 5:52 PM Mark Brown <broonie@kernel.org> wrote:
> On Mon, Aug 08, 2022 at 04:42:28PM +0200, Andy Shevchenko wrote:
> > On Mon, Aug 8, 2022 at 3:48 PM Mark Brown <broonie@kernel.org> wrote:
> > > On Mon, Aug 08, 2022 at 03:41:48PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Aug 8, 2022 at 3:19 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > > > regmap_mmio_attach_clk() prepares the clock that's passed in, we should
> > > > > undo that when detaching otherwise we're leaking a prepare (as we do in
> > > > > the explicit detach).
>
> > > > Why do we allow the user to avoid explicit detach? What is the point
> > > > of having that API in the case we take care of it?
>
> > > I think just for symmetry so it's obvious that error handling is
> > > happening if people want it to be.
>
> > So, the only user of that API calls it explicitly. Should I rewrite a
> > commit message somehow?
>
> No.  Your commit would just introduce a bug.

There is no bug with the existing codebase after this commit. Are you
talking about out-of-tree modules? Or maybe there is documentation
that says that regmap clears all additionally attached resources?

Okay I may admit that Fixes tag might be wrong due to potential users
in the past. However, in the current state of affairs either we can
proceed with a patch, or amend documentation (if not yet done) to
clarify this aspect of regmap MMIO. From the above I may assume that
you would rather expect the latter to be done (if not yet).

-- 
With Best Regards,
Andy Shevchenko
