Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC1F5274E0
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 03:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbiEOBlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 21:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiEOBlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 21:41:09 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B3D63FD
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 18:41:05 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id m12so11365489plb.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 18:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Jc0v104lAi6LQZ9bNwfoLv9IlNQJbUMoTUwN44UnNY8=;
        b=S3NffwHKxmXFbZIww15L2xMm2XRyxD20H7GDKGHFC0VOz46uDYF5X5T7n98MvubJDe
         pZhTWk0hQXIT6YM0OmK4CIa7NRHQU3fJwSumf0kkeW4tdLc2srQvbNtWIdGi3ju4Bd26
         h8+XLRH4ZhPy5gqXPwQewUFNGY7C4C2x2C7suuw/WMVfyJfmuDN8e6QupLk4iYMrvtRm
         j95OE7u+D6hA4z7csW2XMQtE4PnHgGqltxal1nZBFAxiQy6GTpVO8XKBwJMMrqbhmMlz
         XNyxlJsYZVdHOOfiaRw3QfiK+uRgA44t9jqRIfmSQeTiPB1eL8m8f8XwA76rQwQ2RhdG
         +ewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Jc0v104lAi6LQZ9bNwfoLv9IlNQJbUMoTUwN44UnNY8=;
        b=dEgXCb5DHtzJPY+mDJASzZSLHYrmi6znGwfHQPNwe0uVKZrVB7PCBrtKx/mYN+D019
         BmrU8zSeWQksJxmJtRh5wpQoaHV+2u6V5nXBvC3uIXQLEsGhbrDvUApJy73Md83GdMOy
         Uiqlq2VuDpnQX++5iWG2mLQFgMGa3PrKln8wlDVCcLGkfdkzmkebEY7YjBG62apMD2xn
         /9BWJkmrWtwiOPoX2xrn3MQuVqha7H+3E0oBCHKBQYQbVr2MrPaxvo/MqCRaNSgYYvvC
         Gbv7s6qBBX5QqmVyFk28AuXgJnPAEIioyToiDRpliBjd6p/r0mFpwoO+iyySqnkJcDsD
         4deA==
X-Gm-Message-State: AOAM530kpeztZvoQ8SnJv37V0ye4PmwVh/wkcSIooTHCcAWJpltzbe+D
        gSM03A+c/Z83OD50V81OULnuIEeAAmMNu4VyVQQ=
X-Google-Smtp-Source: ABdhPJwt4QUDAdEOcLMr3qmr7vMPpzs8HrBsta9F1uU/06WM+mVa0L5N6R1mzYKBGklS2lnURvCukq4r6zqI9H45eMU=
X-Received: by 2002:a17:903:32c6:b0:15e:c1cc:2400 with SMTP id
 i6-20020a17090332c600b0015ec1cc2400mr11566127plr.153.1652578865358; Sat, 14
 May 2022 18:41:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90b:4a0a:0:0:0:0 with HTTP; Sat, 14 May 2022 18:41:04
 -0700 (PDT)
From:   raymond <tomsteveoo661@gmail.com>
Date:   Sat, 14 May 2022 18:41:04 -0700
Message-ID: <CAGiZt91dS6hAJvhAa77sWwXfJWPfc05-nrMmNpy0h8pBCzA7jQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
ATTENTION; Business  deal worth $47.1M USD for you
