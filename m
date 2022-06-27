Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122D355B4E1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 03:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiF0BKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 21:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiF0BKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 21:10:13 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800C826E9;
        Sun, 26 Jun 2022 18:10:12 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 25R19uS5010238;
        Mon, 27 Jun 2022 10:09:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 25R19uS5010238
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1656292197;
        bh=5BLN0cyqfGikv5WV62zBzoDe5H8TTxZ+zfg+tx/rKAI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MTVj7kms14DUS/IVI8COXaEGLvTBJVqBEGhvdd6NzhzRlbOnFx7dfzwbwtjuUIOaz
         lzMRKB8NKveAK0azBXCZSHst7o6Z/+IAYWmvWzzVxD6PvsAkeb0npPnqSaNai6VUUB
         OsL3a9g5yhdNKwokK2s0WwjteevNCLwQ1WTXaKqQvJQ74xV3vodf4QQ7W8jdPsNwrC
         kz0hd5NMo0pLm60igPklbYtBzI2NrFHKH0ZQSEzC59jDvgMSLR0LSTGyIlxiYwlWn6
         47Aq2FPI+budX7PmXEuFdtEAQslkiOkLWHZmdjWPBq19Wz3PswaKn3UZ0TXad8EFhK
         9inuXME1A9+mg==
X-Nifty-SrcIP: [209.85.221.52]
Received: by mail-wr1-f52.google.com with SMTP id v14so10861859wra.5;
        Sun, 26 Jun 2022 18:09:57 -0700 (PDT)
X-Gm-Message-State: AJIora+9kt5E1HaHl3Td4gVY+O8zeK/IwwW+qK61bNd7byTpTeqRgN1X
        91NMszQBdc/tczeMUp0sA7a3KL9Dcur2/P2djPk=
X-Google-Smtp-Source: AGRyM1ufanJCl9KWCeyKvSCdGOORFzfHQTyAPXmN4eSgxzhpsGwZTjKzLo8WRFdi+h/pbUr4G+Oj9FbmjxGUhR6OuLc=
X-Received: by 2002:adf:e104:0:b0:21b:9938:b07a with SMTP id
 t4-20020adfe104000000b0021b9938b07amr9763735wrz.682.1656292195865; Sun, 26
 Jun 2022 18:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNARjq-x+8rdXfkVt2YEoJsjnZNntxurYTwOqEaAX71m04w@mail.gmail.com>
 <CAHk-=wgcsUU-TNoLS7Q6YF3RCSVAKwNM7gFOwqnPQTiU_oGEWA@mail.gmail.com>
In-Reply-To: <CAHk-=wgcsUU-TNoLS7Q6YF3RCSVAKwNM7gFOwqnPQTiU_oGEWA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 27 Jun 2022 10:09:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQLUGMfWqCNcXQ88xVq2oKTO-daY3JWF7GTKfJMeZ=jOw@mail.gmail.com>
Message-ID: <CAK7LNAQLUGMfWqCNcXQ88xVq2oKTO-daY3JWF7GTKfJMeZ=jOw@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild fixes for v5.19-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,


On Mon, Jun 27, 2022 at 3:20 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Jun 25, 2022 at 3:16 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Please pull a couple of Kbuild fixes.
>
> Masahiro, I already complained about this once:
>
>     Section mismatch in reference from the variable .. declared __init
>
> and now you re-introduced this sneakily by just putting it in another place.
>
> I told you last time that you need to *FIX* these things before adding
> the warning, instead of adding a warning and then waiting for others
> to fix them.

Sorry for not explaining this in my email.

I just thought I had fixed all the warnings,
at least the ones previously reported in linux-next:
https://lore.kernel.org/all/20220602092809.04008a86@canb.auug.org.au/




> Yes, it's fixing an earlier mistake, but that earlier mistake is over
> a decade old by now.
>
> Now, the only warning that seems to show up for me is about
> tick_nohz_full_setup. Which is only called from housekeeping_setup()
> in kernel/sched/isolation.c if I grepped correctly.


Sorry, I did not notice this.
It did not show up in allmodconfig test.
tick_nohz_full_setup() is only compiled when CONFIG_NO_HZ_FULL=y.

I rely on the 0day bot for randconfig tests, but I did not get the report.


Sorry about that.


>
> And that seems only ever built-in as far as I can tell, so the whole
> export seems pointless, and the fix is presumably to remove the
> export_SYMBOL_GPL entirely.
>
> So it seems fixable.
>
> But I'm upset about this sneaking in when we _talked_ about this issue earlier.
>
> Paul - that export was added by commit ae9e557b5be2 ("time: Export
> tick start/stop functions for rcutorture"), and it seems to have been
> bogus even at that time.
>
>               Linus


I can send a patch.


-- 
Best Regards
Masahiro Yamada
