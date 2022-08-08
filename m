Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D8358C2E5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 07:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbiHHFer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 01:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiHHFep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 01:34:45 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078C0B1E1;
        Sun,  7 Aug 2022 22:34:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x10so7607761plb.3;
        Sun, 07 Aug 2022 22:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=5mx8frCO4JQPtx0aeLxBWUqJKTGhhLdcJJ3zxZKM3Zk=;
        b=YQBW1FSvXmRBogXKLCzsWMgyT72qpOhkuBPgIBecilYJReYB0ZRJ4191vT1J/R2r/m
         XpWR4UJuAx6KeGzyIA6an7+j8uoQ2Kju+VoVFhXnTUzp6sSIGS8nON3OH0nmVptnUsFs
         nfI6OUMWbHh55bhElQppAsnW68yKCOS5pJHNjv05AjR/RkWMekb6rOdNoE6JT/Ufn64Y
         G1+Mnhuz/2faEpv91CM6l4QQ93YFnr+CCTpGqJFhyFKYnRqawJij5hKwc3/PHT7Mq/wG
         kh2zo3LOmdkx+eOsKybLLkpVK7UHUMbRJBX8x1Y9rUXnAVy7XdOfn2OhN302Rw75Dgab
         ROtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=5mx8frCO4JQPtx0aeLxBWUqJKTGhhLdcJJ3zxZKM3Zk=;
        b=AG2MPhb5En+gDJMfo95R/rCSmuz8qByJeoDD1LYYYzbB43J7yQ6I55mwzt4bQUtx+I
         mFLrALKhl9tYk3KTlGuZbLCgIRPurUsyI8frSOVUEnEtQPKNDw/VMWQZXGa2w4AWpKLg
         UBl/CJ+rRL2mgBirKrJb4n/D6mS3mtyn9Bun8CMTpz2k9glEajaP9JUAKZjzuA9p7w5U
         BiD1a7P8ETPwV51CLsJUT1P+CST8hVyEqjW+67m0vfR1XOzII7QHR3cFajINzgzTgZBM
         0S+Q0CeSKv5Fg1K19x4WkEm4lFik+nX3rZ415JMDSWE04P44jpaFqx7napHSWlbq/ndM
         cFIw==
X-Gm-Message-State: ACgBeo1f43mbP0iUel3nD+7LmmDmthXDXqM09OavccQ+w4Nufacp3lof
        Qq7g5FQPgXmn2HkMI3L31QI=
X-Google-Smtp-Source: AA6agR4MUv5BhhH63BDimTTz91vaQdqo+mPL9JtPgeddDcU8hjwwuiFVfV1d1/LUGmfpwB5kgOYX/Q==
X-Received: by 2002:a17:902:f551:b0:16e:d000:543b with SMTP id h17-20020a170902f55100b0016ed000543bmr16691749plf.22.1659936883497;
        Sun, 07 Aug 2022 22:34:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w79-20020a627b52000000b0052c0a9234e0sm7876006pfc.11.2022.08.07.22.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 22:34:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 7 Aug 2022 22:34:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] hwmon updates for v5.20
Message-ID: <20220808053441.GA556090@roeck-us.net>
References: <20220730022529.497941-1-linux@roeck-us.net>
 <Yu+OzWv2JDbI89mW@gmail.com>
 <CAHk-=wiGO=pfxyW6E7HdxCnRwWOF_STL=z7yUNwZK__DrV1WmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiGO=pfxyW6E7HdxCnRwWOF_STL=z7yUNwZK__DrV1WmQ@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 07, 2022 at 09:45:08AM -0700, Linus Torvalds wrote:
> Added Kees - this *looks* like it's a compiler bug.
> 
> On Sun, Aug 7, 2022 at 3:07 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Just a quick build regression report, i386 allmodconfig fails to build due
> > to a 'string overread' compiler warning in drivers/hwmon/lm90.o:
> 
> I tried to see it here with gcc-12.1, but it's not triggering, so it's
> presumably compiler-dependent.
> 

I don't see it with gcc 11.3. either, but I do indeed see the problem
with gcc 11.2.

The problem is in lm90_detect_nuvoton() which returns ERR_PTR(-ENODEV)
instead of NULL on error. I'll send a patch.

Thanks, and sorry for the problem.

Guenter
