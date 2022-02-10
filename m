Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BA44B0BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbiBJLMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:12:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbiBJLMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:12:43 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2562FBC4;
        Thu, 10 Feb 2022 03:12:45 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id k25so14393664ejp.5;
        Thu, 10 Feb 2022 03:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6U7aF4ObJyDWzraFLe5UBX3z5gmmdFgy9SvdwQK+hYc=;
        b=EAXLFc6K1/fUlqnuYsnYxz8TjOZVV/1KEIUlIoGQ3ooaxcfslXNgeamlgXfKCE6/IX
         KtldEVRsBfUiya46pfk7348CKRCngQH5KAR0itpR3qpzFxTi8pN9GA7fo0+V5vard7b/
         13EFBMBjx3yEkzDHUDUOoXi5OMmFNPa7zn53emwPYgdk2VOCXfBwD2eiwZy1P43Q+1Pf
         M9WsEm3BlX/YcZLULPuqORQ6SCOOaJRo1DAQQypowq4v2pI3I/ytl+3SR5Y6LJgibKSi
         OaTfnmVrFx4ffTsL9GT7+57+Zctq+EyMXuyqc7J1loPDzAdS8RLpxX0+Ejk+/fmhCrQM
         ZbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6U7aF4ObJyDWzraFLe5UBX3z5gmmdFgy9SvdwQK+hYc=;
        b=BOCHxUN6xdmdRGo/PCRTW1RZIATtNU6AyoIiimNbfV4ybhf6jIsQ/qss2bXFE8AANU
         U4715Rgxsz8+Bjcd2TUUXdapPTl+DZkqrVAe6Yft8hPIde1IjDFHdNPuzSTAiOS2Owc1
         RALJ41JOWjKyelZhm/rkqsdUGstGyQG/WZjykhh2998IdJDkH0Gvw4QTj7IS9TA1Exg+
         fAy4tiSlE2Q4/JRiOcqiU7SJ4Y46GcgVRqCxVKvyjBCO7yJ5782sSMOCcJZWZJ32k/Lr
         6kHNfR4vZ7iP8Y7CLhfP78EOwLoeWFQ0K77RlJMKlRFVYhAgaaPrM+2n0OlvlY9L+Tk6
         j56Q==
X-Gm-Message-State: AOAM533VsvjH5pXfPJfncbgCPLVsfwsKu16OaEH4J+eK+RGVRcDxJbYN
        qdo/cI7YIH+/nvG++0s0SZjlJXyk3+etXEr248U=
X-Google-Smtp-Source: ABdhPJzkCMLdqG6Vw9eSFrwRrEkPH1p/y0OytAcfu9aOTrlRegu6yU/rynP8zS9Bzp6xR2qqoTrAXc3CgnWrSabIfCY=
X-Received: by 2002:a17:907:2d92:: with SMTP id gt18mr5741496ejc.579.1644491563562;
 Thu, 10 Feb 2022 03:12:43 -0800 (PST)
MIME-Version: 1.0
References: <20220209203414.23491-1-zev@bewilderbeest.net>
In-Reply-To: <20220209203414.23491-1-zev@bewilderbeest.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Feb 2022 13:11:13 +0200
Message-ID: <CAHp75VdyNsrm8oeO0KvyPXNR23VdQEMd9LHks20bLbkE_g7kuw@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_aspeed_vuart: add PORT_ASPEED_VUART port type
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Konstantin Aladyshev <aladyshev22@gmail.com>,
        Oskar Senft <osk@google.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
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

On Wed, Feb 9, 2022 at 10:53 PM Zev Weiss <zev@bewilderbeest.net> wrote:

...

> +/* ASPEED AST2x00 virtual UART */
> +#define PORT_ASPEED_VUART      123

If you are going to put it here, use the existing gap first, no need
to expand the last number.

-- 
With Best Regards,
Andy Shevchenko
