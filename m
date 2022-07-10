Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF98256CE69
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 11:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiGJJZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 05:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGJJZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 05:25:30 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DD6EE21;
        Sun, 10 Jul 2022 02:25:27 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id m20so1207144ili.3;
        Sun, 10 Jul 2022 02:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dDcm180fm+ElwiYllP9baiSE8hAH5n7RT1WDFPn6W+w=;
        b=NOxp8GF+crpixiSaDZ0VjacsSdvTr5ppianVyqUB2v0fLYW7jdlTmhsiSWcIlAaG3c
         J3vDDLOv7o3P6uuYp2zQvG9IRlii0qVTo8hVth49GFT89nPu9fkP0jgMih5k2n4xD86M
         7BMXi3ka8BehNzG9qOS0dJJe5IOirXrs+ou5Lccd3skZRxGIWn/LWX84h76+N6wv3oCz
         n2M47B61MWnNmpe5c4cMo8XsFYDo/KyDBMoWA6ijLHF3SyxGY2eRyeSUS4COtpPwHSnt
         NW0+kjX8vKFvjiI26LlMYqG2+Ueytr1EGPl+9u8OSNO1KJ822M5KrH0pWrLQX86urY8I
         FSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDcm180fm+ElwiYllP9baiSE8hAH5n7RT1WDFPn6W+w=;
        b=EgeFAX2LA4g/Gl29lKRoMHhDmq9jkUMFIaV+gRoe7BfAUvoil7tRy/YJCYgtsxbNU6
         O5yW/sqTnM2ol+kr2cSFF+1FIFpgPyYDHs2WPFiWKiSutaUSDD2PEe9d4+ZL0ABkgFBd
         Q+Pe9xoo/fwkLr/1oo7AxPhrmZZvfWIAH9/Rlajrlp/a9+QRxX9Cq39Wocho/o+Xu7O8
         EUaRMbsweNYyN8kWRgrz7qrOh0aETp0oIho65ueskVgniQ4eyQqsRwgVNrlrYxf4Rkmr
         WfjIWkA0y7LWL7v8u2gx24YIW+UZ+zT3KhZaJjP9BqgkAo643U+sfkGr0ScbusAnn0Eo
         ZljQ==
X-Gm-Message-State: AJIora/BLfG63OsXnjH/9YjQBJfovBFhmkVo3nkXAxXSwXqCYKnfgSyv
        UsgTyqPibXBEs9cmLvS24AQqPbqkjDTls0BuxuOTXdIqyIU=
X-Google-Smtp-Source: AGRyM1uAF6VU95iZifNfnA8tG/sZyzsGjN7ncQ/VAiGx7IljlEfMrNHtielexzXYCVkLdWM4v1MNmGJJg7Q5cvps7u8=
X-Received: by 2002:a05:6e02:1845:b0:2dc:777d:1ef8 with SMTP id
 b5-20020a056e02184500b002dc777d1ef8mr858558ilv.246.1657445127237; Sun, 10 Jul
 2022 02:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220710092135.1743411-1-eugene.shalygin@gmail.com>
In-Reply-To: <20220710092135.1743411-1-eugene.shalygin@gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Sun, 10 Jul 2022 11:25:16 +0200
Message-ID: <CAB95QASE==Z4m4eseyRKbA7gjeAvKLFho+fchA4e=auvxuchbQ@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add definitions for ROG ZENITH
 II EXTREME
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Nabajour <nab@halo.lampshade.ch>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

> From: Nabajour <nab@halo.lampshade.ch>

Contributor provided an internal email address. I'll update the patch
once I know the real one.

Eugene
