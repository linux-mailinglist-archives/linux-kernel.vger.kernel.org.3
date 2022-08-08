Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5BE58CDC3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243940AbiHHSjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiHHSjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:39:44 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73906E1C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:39:43 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id u8so7000984qvv.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 11:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=MjsfulMvXImm/5gkc88mPKDzUUEETEDq7PG84qllcEE=;
        b=JjChwS4eSuMYxoxHjbv9BGTzcPpXyl8jXiPTHf2sCDyQbHNnl1qedNT6BQeuLrSNis
         dcpocoNKV/DSti/G2P8l4nYFfJAjETrujwyxrITUFzVOqt3aVWOvA8tvYK2HfOoF30nb
         km7KK4m5iTLTv07viVjQaJuE6EhAQM0nFXIfYBE2YJUIh7+qZ9GMRlKoArWueGCQJvzY
         XU1JYIwOdb6ajaUn/MJ0JJMwB8Vd2tKcqw8qT5aQ6ROU0vlSxkfqEt2p/evRuBwcObUl
         AKZ082HSMug14BJ8iZRlE+gfusp3u4Ru/lQbrD51w51qeo0VR+m6/GuS2qgzhPZcEgZJ
         VJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=MjsfulMvXImm/5gkc88mPKDzUUEETEDq7PG84qllcEE=;
        b=yFKqA/6ncK44ndjmw0pYIaP5V0JWAecSwtv8oRPjzIkF4HFyWa+Rmh0Qlpl7yhmBi9
         VupZsd3B5RjuShRQMbj7zyf6L1DC1v9QLYqUny3d50f28hnb980K2kJMPutc2JOgX+k1
         JA++KLjL96ABH8XzpegasZGGORsqKwr2bmi6ov1nexNd0sSqCmgHawN1wc6uI3u9b3dd
         sXUint4SDOyrNtBPq2kb1Oh0Smlwk53CTsCoSoFuDAUKl8e6RBPKqGl+Raep/AsPmqcX
         XOR9tKAk3F0lJXgnjswTJFbgJLXOevcSKGUoktyIvm7euvcPkdXE5n1B7nLLBCzmlt7B
         lEmw==
X-Gm-Message-State: ACgBeo3aBZdQIs9mw52KVW/vurpbIy+lNxxwfvNbIqAJ3J6b27Ovx5ST
        o7N9prvQn4E2BR/B8xgD7a+JYae2kb2Jhsyamdg=
X-Google-Smtp-Source: AA6agR6zaX6iD6tWWUMPFXBe2xIlspptGnOS8FD6r67o+GkyK5zFMaOKZMpuPEj8uFaM4owsEgOHBmOUCdL8n0fjJHs=
X-Received: by 2002:a05:6214:5290:b0:479:5df:e654 with SMTP id
 kj16-20020a056214529000b0047905dfe654mr14905814qvb.97.1659983982531; Mon, 08
 Aug 2022 11:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com>
 <20220805205321.19452-5-andriy.shevchenko@linux.intel.com>
 <YvENHSRQuwAzfQJW@sirena.org.uk> <CAHp75VeA8tA-m_gHu5iuhriSfm_qo1PRnUWe7kQ68CCm+UCgHA@mail.gmail.com>
 <YvE0KroZDQuPVd+V@sirena.org.uk>
In-Reply-To: <YvE0KroZDQuPVd+V@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 20:39:06 +0200
Message-ID: <CAHp75Vd6eyP5Jd-xD85PgnWh9ATLX61=dbXpTt-gje=krqmP2w@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] regmap: mmio: Introduce IO accessors that can talk
 to IO port
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

On Mon, Aug 8, 2022 at 6:05 PM Mark Brown <broonie@kernel.org> wrote:
> On Mon, Aug 08, 2022 at 04:40:26PM +0200, Andy Shevchenko wrote:
> > On Mon, Aug 8, 2022 at 3:31 PM Mark Brown <broonie@kernel.org> wrote:
> > > On Fri, Aug 05, 2022 at 11:53:21PM +0300, Andy Shevchenko wrote:

...

> > > > That said, reimplement current Big Endian MMIO accessors by replacing
> > > > ioread()/iowrite() with respective read()/write() and swab() calls.
> > > > While at it, add IO port support with a corresponding flag added.
>
> > > This should be a separate patch.
>
> > OK! Then we remove some code and (re-)add it later. Do we need this churn?
> > Another way is to add IO port accessors and then fix the MMIO.
>
> Add and then fix seems sensible,

Got it, thanks!

-- 
With Best Regards,
Andy Shevchenko
