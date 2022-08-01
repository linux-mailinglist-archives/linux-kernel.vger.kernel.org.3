Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB902586C6B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiHAN6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiHAN6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:58:04 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B554625C7D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 06:58:03 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id w7so10487172ply.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 06:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=BB24aZrQzWx7b/4V6aQ9XY05tsIpeq4BoURTiaKXIoo=;
        b=Mkvw4rmTd45cfr18gIKd5gdZlpfz626XmBvvPXXz99GV6TTC7i62ozrHKBtoeJNY7W
         rN9yr58q0V3qwXmuRzqR++1C3m5e104/N7tQ15nHWXmNk+dtLnqKM9/y9As03G6NLIx7
         mTTUK9NuxTuxrEmtRRqUeUnWbOfWMcDyxaGTKqQ99Ti/R890xIxAqpxWzA0trc9Pl4OQ
         ZVhwTiN2j7HT++kwNXtNXufoUe/CXqEJRf4hVBzoxTq1LRnqIKS+KrZP5OLjXjYTcqVf
         KkclJaWYVBEylBySgvAeFCoK6mj00DNP+ds0NjRirxutJYk+vokq6c0f0v72gZRBw0tR
         wQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=BB24aZrQzWx7b/4V6aQ9XY05tsIpeq4BoURTiaKXIoo=;
        b=HuChGm2gQhBlgOPxutENug4ssCd7avUcXh5dPLurliuiQyW0ghzbnoBy2lUL7MnfPi
         8rZyXONsTx2dZQn1oYPKIDjZNxQ4tYJgjh5Bjwn1XAk6UsE5ZnZru3V3eYJqJaFjzznm
         WrXT9XRLG9p5uokxIACqjDwSgCxJ/IW7F0/n+NK+dltFWxMGsd3yHqWpbstYhfU3AvPd
         TB6HWrf32RtJoyaS/VR2YS1N9wzIzKKQ8BwX+GsMNGLLKgibiGdVzPwdBJrfOQncs+X7
         kisO30xNQA3lRcVnKB9MekyxUdRcgyFYhU2ZctxxEkxtjjRTCuoey3JjJjnooYQD1xE5
         6uuA==
X-Gm-Message-State: ACgBeo30/GFE/7gX2e6/0HIBUJEud+gnpF0LAYa/xftmT9zqbOImPpN8
        JoYLItuIQY7vGlBYtZ54b+IL1XthEejXhkDFvPibiA==
X-Google-Smtp-Source: AA6agR7u2AdTNxFh13tZed3hx6+3zIzZNu+TCh8Oe8USjtdQCd3Qg1Q1lVqzolCbNm86oJepkCHRpNDfX0RAIn/HLqg=
X-Received: by 2002:a17:90b:198d:b0:1f3:f72:cfdc with SMTP id
 mv13-20020a17090b198d00b001f30f72cfdcmr19910303pjb.237.1659362283145; Mon, 01
 Aug 2022 06:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220728190810.1290857-1-robh@kernel.org> <CABb+yY2jV7c8oX7=F=nocfvGrOMHJAYov7zS2nT0=qFoNyoxJQ@mail.gmail.com>
 <CABb+yY0JzztBB+giBu+RCt-dzgwYWF32sCR3WKKP9U5K9UvhxA@mail.gmail.com>
 <20220729111051.5me4vklrzskvsj4w@bogus> <CABb+yY1=cppy9QAN=cLWmhvmYrQ5QpY5adE+nRev1rVrtp-QUw@mail.gmail.com>
 <20220801102309.efvmde2ackh3vyg4@bogus>
In-Reply-To: <20220801102309.efvmde2ackh3vyg4@bogus>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Mon, 1 Aug 2022 08:57:52 -0500
Message-ID: <CAJe_ZhdCJ7ba26cGY6-kJC0mCUXU+ACBW1k1VNmXS9gZcLi16Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mailbox: arm,mhu: Make secure interrupt optional
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2022 at 05:23, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Fri, Jul 29, 2022 at 10:18:04AM -0500, Jassi Brar wrote:
>
> > > Anyways I can insert a module that requests this channel and bring down
> > > the system as accessing anything configure secure from non-secure side
> > > on Juno results in system hang/error.
> > >
> > Why go to those lengths? These are already simpler options available  ;-)
> > 1)   while (1) ;      // preferably in some atomic context
> > 2)   *((int *) 0) = 0;   // you might want to iterate over offset for
> > guaranteed results
> > 3) Slightly more work, but you also have the opportunity to erase your
> > storage device
>
> I know these simple methods but can I hinder secure side services with
> these ?
>
Ideally, no. And neither if we enumerate the secure-channel in dt and driver.

See, even if you remove support for the secure channel in the kernel,
a doped super-user could always insmod a module that attempts to
access the secure address space that you want to "hide".

cheers.
