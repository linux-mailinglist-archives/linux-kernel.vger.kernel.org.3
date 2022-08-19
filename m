Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8370559A956
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239693AbiHSXZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244280AbiHSXY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:24:58 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA95B6029;
        Fri, 19 Aug 2022 16:24:29 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id c20so4416244qtw.8;
        Fri, 19 Aug 2022 16:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9kj8YADm8du70l4gQ+EusuiOAvks8txJezrna7w9qAE=;
        b=TLGJR6BH78Ku2XRy50XMpy9E0iSRYnRxuvCc+nA5yToS01jHWC0aYsueR14qRdZCRm
         lvV/K9kkYKj8XK6zc9NKqNxeUNg228APIv07V9yhX6bMSMfLXgvBSxuGdHds+VCP4iVI
         RCQju+JEVbtKiwVV2xcq/fSYZns1DCqj4koRA3Fw/Y+P0Bo/kkmE3AwNAam7Frh/vMbc
         cBJjC1Z1hoawTDW5AQgswfvCCxtXVXv/Ogr0d26NpLFtX4thINlfoV7enGM/pENBKdey
         GzQXYV+N/qwuD8wj2ib07utbZeBnQigUfT9TQnzERwmcG9z3SA3BBcx5xkS2T4qdgw2N
         TOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9kj8YADm8du70l4gQ+EusuiOAvks8txJezrna7w9qAE=;
        b=GP1GHYTPzcGy+sabJ7vm7OGRGVsTjL129AZkovvAaAfA1huFvtH8P/d/I9nd92nMgk
         huf5taN8ZGG1noCG3ITy/TaVeL9h6SmOi1s9Erxrtx/GKHYkkjhxeHOE0iTR6sJRlo1I
         Elup5hXI4TB5vnRCayt+DryMZNoVophM5CnbKdXcP7MlGNWvn3eJMV4ih3OyivCLR1uG
         jlap8eAuY6zlYGRqRXdCSUza8RBuNEibpB3J0lV30Ws+u+YMqYF3N4EdrrCCaUzxbi33
         /u81oJTEhUPdENyQ2icuJ/y/XGAh4iHup/HoE9gHdNxut9E9Jw0Sm1auv4mV7CyGjDay
         KYjg==
X-Gm-Message-State: ACgBeo0werKSf8IeXq6A9GmiIz9TrHl59nsZwalABltLoE0edO/00VnA
        t5VQqSSGXTc/PyxjquhLnJz7qTfAXr6fKq0YO1c=
X-Google-Smtp-Source: AA6agR7b9hjrEla6ZbAwec9YTGFqrakS7HOziDFtiFYKG01c+pvBlvapThT5k++u/jjDQvsh2a90zjYOrn0o5GYnN+0=
X-Received: by 2002:a05:622a:491:b0:344:95bf:8f05 with SMTP id
 p17-20020a05622a049100b0034495bf8f05mr6893450qtx.61.1660951468982; Fri, 19
 Aug 2022 16:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220816191842.14020-1-ddrokosov@sberdevices.ru>
 <20220816191842.14020-4-ddrokosov@sberdevices.ru> <CAHp75VewJ1taLhsCb4_yEQHpw4VDXRhkxpL0jzdu-JsajfF6oA@mail.gmail.com>
 <20220819125818.37qc66akgercd6zb@CAB-WSD-L081021.sigma.sbrf.ru>
In-Reply-To: <20220819125818.37qc66akgercd6zb@CAB-WSD-L081021.sigma.sbrf.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 20 Aug 2022 02:23:52 +0300
Message-ID: <CAHp75VcUPQF21+gq3Hn_CLeY+y9sTFSLrbHYKgFJssveL+badg@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] iio: add MEMSensing MSA311 3-axis accelerometer driver
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jbhayana@google.com" <jbhayana@google.com>,
        "lucas.demarchi@intel.com" <lucas.demarchi@intel.com>,
        "jani.nikula@intel.com" <jani.nikula@intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Fri, Aug 19, 2022 at 3:58 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
> On Fri, Aug 19, 2022 at 11:41:55AM +0300, Andy Shevchenko wrote:

...

> > > Spec: https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf
> >
> > Have you ever seen such a tag?
> > We have the Datasheet that is more or less established for this kind of links.
>
> As I mentioned before, if I use Datasheet tag, line length limit will be
> exceeded. If it's okay, I don't mind.

Tags must be one-liners, that's the convention. It doesn't matter how
long they are.


-- 
With Best Regards,
Andy Shevchenko
