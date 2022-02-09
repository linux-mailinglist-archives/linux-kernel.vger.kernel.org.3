Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6684AFE79
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiBIUa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:30:59 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiBIUaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:30:55 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14265C002B5D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 12:30:57 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id r19so6370730pfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 12:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=H8UvkuaPa9oG6MBcN88+EFcgU6RwUy+XLZ3L+fuvwWs=;
        b=jLSqHONTNlyEU0X36UjWm1OP1joipm2nCVWebcdjjAetYBRag2vvSJpPamuNKix4yP
         rwNNjw1RlAYXs2IL0B2gDrPemV4PSFexAl7LW4k/P83PpiO5dN+gxwb4Sgv+8t56Fa5i
         8JaSKqWn+o/nkY2XIM+I2sBbvBFeL1MGcxdBNvYaOCU8YMQqtKpPPXc2VZmdawXxmy0S
         LJ2iCFCbGYdY+JVuIDZGIZ4SWKk7VLbnBFMyEooeL2WFWVKf30pucY+hBWoZcYcfTvor
         296JPhFbIryEeulXN9SjrmIFNcQXBZf5goMqiW0G/5tE7Fu0gUSt4OOfY/492CjnIkzh
         IyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=H8UvkuaPa9oG6MBcN88+EFcgU6RwUy+XLZ3L+fuvwWs=;
        b=yFGbVNJX492p5KuP/25CZJVfKX+mZZXXcH7W2ne5jx57SSLmF8F8UZIm5l2f9Aivvr
         7Jxb/jWOCjhhu/79AM4/5vHcuPuA8FDxvbuglcJ8fcqGFCHHh43g9rtFIYiccHYwMs8n
         cHzEXDzgaI/FaFsQNAm1D7fHMY1A6TeeiM1z8oiEgiRLU5uyxaP4kQGwW/yYeqojaPM0
         aNt30N3yXJL7C7bjDzZUOQLOVo4iCX6Go35HpE2kbD5/nqWHVhRk5i0F3FcF5D33e0io
         LatRDEY5PaVXDZJPf5bainAn7qGfgnO2uFRX2otPYruPjpl3YUoWiM8XDe4j9q/YL4Kj
         tOWg==
X-Gm-Message-State: AOAM532A0tjcACgL8BHovDOkUb9Tebwo3DVranQPynqGiXnqqjicdFYr
        3PNLdp6cye3ccOqINx2XA61ahlCFwVv4AQ==
X-Google-Smtp-Source: ABdhPJy424vIOl7jQpbzE1qFJbQKb1wuakkXY166U9x9NY98U7JPd35QgGjJclqbpBouDlTQZCmKtQ==
X-Received: by 2002:a63:844a:: with SMTP id k71mr3226964pgd.559.1644438656578;
        Wed, 09 Feb 2022 12:30:56 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id d10sm20577340pfl.16.2022.02.09.12.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 12:30:55 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     "shunzhou.jiang@amlogic.com" <shunzhou.jiang@amlogic.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        jbrunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "jianxin.pan" <jianxin.pan@amlogic.com>
Subject: Re: Re: [PATCH 2/2] soc: s4: Add support for power domains controller
In-Reply-To: <202202091001287547451@amlogic.com>
References: <20220126061018.705338-1-shunzhou.jiang@amlogic.com>
 <20220126061018.705338-3-shunzhou.jiang@amlogic.com>
 <7hzgnal5yu.fsf@baylibre.com> <202202091001287547451@amlogic.com>
Date:   Wed, 09 Feb 2022 12:30:55 -0800
Message-ID: <7hee4bok8w.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"shunzhou.jiang@amlogic.com" <shunzhou.jiang@amlogic.com> writes:

> Hi  Kevin:
> Thanks your reply.
> Please refer to below comment,
>> S4_VPU_HDMI:  for vpu domain,  this domain provide power to many moudles(osd, vpp, hdr, dv, di), if close, will cause system crash
>> S4_USB_COMB domain: for usb, if not always on,  all usb status will clear to 0, that's not right status for usb

Yes, I understand, this is teh same as for other SoCs (e.g. A1.)   The
solution is not to set the domain to always on.  The solution is for the
drivers for the devices in these domains use runtime PM so that when the
drivers are active, the power domain does not get shut off.

>> S4_ETH: for ethernet online wakeup, and if power down, status also not right

OK, this one makes sense for "always on" since it used by firmware for
wakeup.

Kevin
