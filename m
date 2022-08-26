Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE235A2879
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344322AbiHZNZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiHZNZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:25:14 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACC8220DC
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:25:13 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-324ec5a9e97so35574497b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+5rwRrMz6Vgpr3kuJ/Qy6k3D5LZq6ZW9xqvVpBwo1dA=;
        b=T/eL4/5hHoofaXhX9Y5APeNn3CoGJUkZD7XlLvCeI9p4CsNvhZq91jZX2DS5LIOLAA
         +6ZiQF3vnc1B5ZOYN3ZZESKE0AQJMeGdbv3v8YL0KospQUudBMJ+NjmHSPP3NEaCHLUO
         GM6MmX1gOvSVySc25t8BG24jR6U3HzsmTRbRjbOD83JKujYkvG3VXTis0nH3v9bO4nFM
         cEmw9sxqhZWvNHjsenUnWjuX2L8eInP5EOD1Ajj/B/d3LzpuOfnrJrv4qolSffd9saXG
         6k29HKmKrZpciz8nmVxgPUsuvpm/udctDMSCGZdDOV4ZkUxxA8OaUb4FS7CLS0xo1M+1
         FJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+5rwRrMz6Vgpr3kuJ/Qy6k3D5LZq6ZW9xqvVpBwo1dA=;
        b=Wu20SXTlljYWuLqQXjk8idaF71uexL9FizHwnGzMhs1IS78loMjnXXJFSLyA6ikhBh
         w+zw6QNr7dHIyWh590GNlF3NU36eBhNJpK5Q2MOp5q5MLgGqlMowTvCITyIqHPjWVIIR
         uAIGcuQ4K7alWlunB18XZ9V8MbOOLUDfYE86CpG2haRkZW7sFFdbz4wjdUdDa3t7pQVQ
         mTHB636zr3X4rKNKev1t8iVVNkbPsSxEAvT9ath1aW8tsK2Nxu9uvMQCN/eso55Ah+4V
         QUIu8I24whzisEY7a+xKOFrY0wtd1pFeemIOQn5OGALDvEis6DcIzCdwWe/1UZW/gaIb
         rHRQ==
X-Gm-Message-State: ACgBeo2n2aH5pKlK+snUMyh5gf1djJLU31DRjPmCC1FhCrj0rWz78d96
        pYc+nECVGs5TyPmfQ7OjGyp5eamYsg8RObRnUqCuaQ==
X-Google-Smtp-Source: AA6agR527zHsKUzzsXeecDEZwR/Wz1n7Y8bEF0Yc3d7UjNiESUXEgXppL2Fx09osZSmUMJqXEsw6lM5NTKiWc6NjaFA=
X-Received: by 2002:a25:7902:0:b0:67b:d842:1184 with SMTP id
 u2-20020a257902000000b0067bd8421184mr7386841ybc.374.1661520312394; Fri, 26
 Aug 2022 06:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220823230753.14799-1-mario.limonciello@amd.com> <6ffb775a97384ff59676d9c4337481f0@AcuMS.aculab.com>
In-Reply-To: <6ffb775a97384ff59676d9c4337481f0@AcuMS.aculab.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Aug 2022 15:24:59 +0200
Message-ID: <CACRpkdZoX806ZbhHWptX6b3D-7p0Hsa6HXW5XsSj1Y2WFR3K7g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: amd: Pick some different unicode symbols
To:     David Laight <David.Laight@aculab.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Kent Gibson <warthog618@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 3:51 PM David Laight <David.Laight@aculab.com> wrote:

> I hope I'm never the person you tries to write a test script
> to check the output....
> Or describe them to someone else...

I think these are the people doing those scripts at AMD.

> The best 'fix' is to remove all the stupid characters.

I let the people using the debugfs decide :P

Yours,
Linus Walleij
