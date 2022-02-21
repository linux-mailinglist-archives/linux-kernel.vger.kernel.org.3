Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C894BEC02
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 21:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiBUUnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 15:43:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiBUUnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 15:43:35 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306EF237DC;
        Mon, 21 Feb 2022 12:43:12 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cm8so22213985edb.3;
        Mon, 21 Feb 2022 12:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e85OJ4CgtA9DJpWGpHMOai4BmUzdNbzlqReJyl7Naj0=;
        b=O59iubOpvKVoQdhIdeRmp7BxrK9CMv57257A4soMHRveLxnaIKR5YQ0ewI89Xg1w8Q
         AUuNrMxd+0xVX+4GkOZAm13I9Uq5cy7JYyJiBwOHM+9BtiFeiQ3F0VUAixf46f84jDB6
         zjPjxQZ9c5gQwq+jHx+8f3MdYZnRSp/ByHqCXPlhvCKnsOnWXHV9NSNzk1goBB/ZKfU9
         vlAOVDA66Wk85U4lBi8COolnneHPzXKO5MWVqhU6nQ+IUzIjLWrmAKadEicfPaqIkXGd
         tt6udaqEDPVVASX/V7G6My1aUQjz79+vT5uTpcnTGGr4e0ExWsZgUj3i06a8Mt5G31Lm
         qZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e85OJ4CgtA9DJpWGpHMOai4BmUzdNbzlqReJyl7Naj0=;
        b=1oVxXqROVdTnS5MdN2QIya3hcta0VvF8U7w/VAeAQ1QcDzX30V/YeXU4EBG9RpsaiX
         a573PKbk/8yXrWwdAEd8vXm4CH1RFJe3p3YZGLUuFnZyHzH8kHJaRS5B6p9WFZwWH3hF
         /kYGZqPidS4S9diDJ7cf8OsdH3w9HTrqShbXmX+0SCqZCX9E6Sk5ZEANYYi+IK2JaJh3
         q2euFE8l1TR/XH1JM7uB50vJOlks82TTHFyEzy6yDZJxxZWQ4wywgIMxhr3M4Bta1FQA
         w2G563CJpMyfRJ15NeI1r+9sH8RVSA4PPL8rwDn2iwfzPxfEzXBKNLy5M5yqmjqpxU/G
         /rKA==
X-Gm-Message-State: AOAM531x6NweDgAnpCcvTxcDh/26shqkrVzjIakb1rVDyFzwM05hpWZQ
        cgc3Zq0oz5GWMbNopRWxIFCJ0O9Vc/DPO+/J4n4=
X-Google-Smtp-Source: ABdhPJzXYOg3294XcMQ+uihr1i7+0aR4l2bqn0GHhiATiaRmuVl597hmK5ctLYY/nmq3l+1VWQ2D2D++vDJoHqjXOCg=
X-Received: by 2002:a05:6402:198:b0:410:83e3:21d7 with SMTP id
 r24-20020a056402019800b0041083e321d7mr23625509edv.159.1645476190819; Mon, 21
 Feb 2022 12:43:10 -0800 (PST)
MIME-Version: 1.0
References: <20220218042038.15176-1-jagathjog1996@gmail.com> <20220218042038.15176-5-jagathjog1996@gmail.com>
In-Reply-To: <20220218042038.15176-5-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Feb 2022 21:42:35 +0100
Message-ID: <CAHp75Vd9Tz2QrTQV3x0567o6uN7zmbWd0X-aPhT1K0LYJW1kTQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] iio: potentiometer: Change to firmware provided data
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, sst@poczta.fm,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Feb 18, 2022 at 5:20 AM Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> Using firmware provided data to get the device specific
> structure, if not available fall back to id->driver_data.

You probably will need to add

#include <linux/property.h>

-- 
With Best Regards,
Andy Shevchenko
