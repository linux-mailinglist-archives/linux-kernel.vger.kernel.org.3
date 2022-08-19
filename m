Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD472599932
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347813AbiHSJv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347553AbiHSJvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:51:24 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18680E3983;
        Fri, 19 Aug 2022 02:51:23 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id g16so2901315qkl.11;
        Fri, 19 Aug 2022 02:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=h/PR0k733hyrl6lHcrFIlsUlVMQgdaDl258OUpePefw=;
        b=OYQI3R9MZf0Gjf/yY1ii/zCSkw8hxBHExqiib71w8ptddLzO0/ZeQbNBp+PHGvtWHz
         KwTxErR0W1FphOeNp7yjLv8g5o+HtHz+1Xbubnfu/k//8NMLLyItI40ddmQ9GYxfM37C
         HC8BHltODVADzn59MtscT7kJIUiati2MyxOFIVbZ05gzsQOwWiYO0kdZI2gf5wO/K63C
         8S+ezvVWsof+qRkD86RAVAkBvdfx2SZv0bdJGp7YN45CmZQpWrnyIGRx9r1J0KRszL5l
         x1+pss4yFx1jGezHlIQ1eVYHKlMgq1mlHSkPqAVwnTcReUs9afw+KKinvLm51eK5qVAI
         ITCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=h/PR0k733hyrl6lHcrFIlsUlVMQgdaDl258OUpePefw=;
        b=tlb50mx4PieVNjWHkV8xIPzTH1GV4IkZWlECQm1WeMOqvCabfebob9MkGYlgAG6uUv
         6rX0pg3g6Ff18SrlkM4JOtRJPgMfTv3HGKYX4aC5bJXzxpOZml4E/jYImEiCxnE1mOTR
         u5P1QmWFqEgS6A2ZRcpP6HlHC/umZQ+GnrYozyqcDVbxZ5UR2USif5nzkV4kbqUzGeiP
         Q6CYHNTd/o+VPGMKf1syva32Fb01gPTMVKOLPVf+vBqjWgKgHdGpsXJ2n3hPf/CLxdlX
         dj4XcVxAvkXUHNwKpD6gW10sBPhUqapJ42227056jriTKnKUBCUEUDmzePUflbKs2bdH
         Cwew==
X-Gm-Message-State: ACgBeo0TXXaKD6KXPhCVWvBCTYOaf2rf28LLQgj8YkPO5NSQQUS4RZG0
        9PiD74w4MYZQGubZKX+Mk5VcGwuUxPxCZwAqOrg=
X-Google-Smtp-Source: AA6agR5hLMuik+jVmU8ueaGANnd5tx75g1qPiBYDm96WbaQK9YgqTHHggn6sU7WdKBihWqnIL4UotHq1oE5z/M1Dpa0=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr4630906qko.383.1660902682860; Fri, 19
 Aug 2022 02:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220730125024.87764-1-andriy.shevchenko@linux.intel.com> <20220818232256.GA3505808@roeck-us.net>
In-Reply-To: <20220818232256.GA3505808@roeck-us.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Aug 2022 12:50:46 +0300
Message-ID: <CAHp75Vc5CtOwFFJxLEe2kNTpU0xqWmcwDLAYtFgkhJVx7KvwqA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] hwmon: (iio_hwmon) Make use of device properties
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>
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

On Fri, Aug 19, 2022 at 2:52 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On Sat, Jul 30, 2022 at 03:50:24PM +0300, Andy Shevchenko wrote:
> > Convert the module to be property provider agnostic and allow
> > it to be used on non-OF platforms.
> >
> > Add mod_devicetable.h include.
> >
> What does that have to do with this patch ?

See below.

> > +#include <linux/mod_devicetable.h>

> > -#include <linux/of.h>

The of.h implicitly included missed headers. The mod_devicetable.h is
necessary when we drop of.h. OTOH I haven't checked if
mod_devicetable.h is still included indirectly. Either way the correct
approach is to include mod_devicetable.h since we use a data type from
it (of_device_id IIRC).

-- 
With Best Regards,
Andy Shevchenko
