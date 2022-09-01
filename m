Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31F35A99F0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbiIAOSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbiIAOSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:18:39 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B533DBEF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:18:38 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id g21so13335950qka.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 07:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=3ucMKyqz7e32uoIZAO72/kRTxuWUtg26iR9Djc8eyf8=;
        b=Q0AmSOUOel3ozZBBdyAiYlmVy9ecfh7Tj2GLp/Wqwkf1S2qlqPLi1zGiHR9OeMu9Zs
         uRxvYpghtqRAKERxQ0vNT6IptyboZjyjEjF/Wgvnf7MKU8eTonIpgqlDMsU3ZSZsS4uI
         bjjm1XkYR5zqPqrF1x9w8+cFIpsHRYHQXMztR/UVuMvCL0KWMMdRyE9q+6E6uZTcVXe3
         5w53SNJjZVNjMG7lz20k/hY6PGRjXKB1FkJkNJiNXu2Ep2vjlI+izNR6uD+n7/jHgjlw
         d4a+jfpcYyy+0Mq7Vmev8Hl1xSZphO9E+jVuxZ9vOy7vhwLqExo/qo4r654CthPIDVX6
         5NVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3ucMKyqz7e32uoIZAO72/kRTxuWUtg26iR9Djc8eyf8=;
        b=50bgD2V6BribINM3RAeN4Hac0EG5+Zy0C96Mf5xzFBNi3rFDUezxZVDJ225i2FDoEG
         MAJGuTOfcBzY0rnOP5FqfdnNzYVEWHeHxuQL8Pj1ZEthyPThu3sVxFM3O3JVe3QMm0GS
         DyTQDmidW1YAMp2zMI7qy6e8AxPIIYzVtZc7/Bh0vf+m9LctYuA7VAt60JQ1Kd20uHag
         ewRrxdQq728f7I68MsD6OyUrtgPMEeVGT/+XSjE1eAcF0H3oEhKVOBdgE67U5goFR4YE
         86x0zYqtji/rh7AylryqTMqNbHkChfbP2IMT2vN8tzd6DrWdx7U6TfV1gWA0PBGAfbSg
         BNZQ==
X-Gm-Message-State: ACgBeo20jSLqhDBzlmudJejECQJ9faKwxkNhhm8D85/IlD1oR5jH1YCt
        gZZTm5ZM7CZ5AvtiwfiOdCzUB9+9SNzn/iz7XCE=
X-Google-Smtp-Source: AA6agR4R7YMCpz5zcqp80dUyJkXNkIqNk5KoR+s3a5UYOImQOcAmv39vC2eCsfByyQMW6436DYmOz0haYm1/y075cfY=
X-Received: by 2002:a05:620a:410e:b0:6bc:5cdc:88ec with SMTP id
 j14-20020a05620a410e00b006bc5cdc88ecmr19847942qko.734.1662041917739; Thu, 01
 Sep 2022 07:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220901132336.33234-1-andriy.shevchenko@linux.intel.com>
 <20220901132336.33234-2-andriy.shevchenko@linux.intel.com> <YxC0SYShl14TSw2o@sirena.org.uk>
In-Reply-To: <YxC0SYShl14TSw2o@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Sep 2022 17:18:01 +0300
Message-ID: <CAHp75VcrBS=+bxXz62HB6joB3+6meVK9YJtJOYSS3PNrY13AVg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] regmap: trace: Remove explicit castings
To:     Mark Brown <broonie@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
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

On Thu, Sep 1, 2022 at 5:15 PM Mark Brown <broonie@kernel.org> wrote:
> On Thu, Sep 01, 2022 at 04:23:35PM +0300, Andy Shevchenko wrote:
> > There is no need to have explicit castings to the same type the
> > variables are of. Remove the explicit castings.
>
> IIRC this was an idiom that the trace code was using for some deep magic
> reason to do with some fiddly preprocessor stuff.

Perhaps that (dark) magic disappeared a long time ago since in my
practice of adding trace events this is the first (and probably
oldest) one which has these castings. Perhaps Steven can shed a light.

-- 
With Best Regards,
Andy Shevchenko
