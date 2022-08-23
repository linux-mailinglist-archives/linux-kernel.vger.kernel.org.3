Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC79359EC4B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiHWT2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiHWT2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:28:17 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E704F3258
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:15:38 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id o184so16943574oif.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=9K7K88FsF8kEbdkhom65oGNYjCLYbs6+n8/9saUSNLQ=;
        b=YonbyMFZtTtCbC+1zsmXeE4UMqMAnd1q2E2yfR06k4ejLcZlWwvVWpfAT5pVpPDiaS
         PSe7eZKCLiZwsP4/dOsyA/PUJPA4EXVcXYEfdKmYhTPwcmSC4cGyBuWPExZRfrbKr59z
         s94ctp68HWHdo27sJ8NgbeNLeMuFd2Pbf0sYd6wVZinkf9+meb2I3ixzEvKtc0hvEUK+
         ModwGHBOtVGI/eJpBMqHi3ic7J2A+7sIWigR7kHoRHjnTiKrMaDc26MnzUBPyUUSx4JJ
         chSzfOGbZIDlL45ZNaPHuAnVQydWcrjKOntUQz8Ha/f2RIUexdjrCVpbJ2jxmSF5Eh5W
         kI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=9K7K88FsF8kEbdkhom65oGNYjCLYbs6+n8/9saUSNLQ=;
        b=VTjF30W4XKeQzip8Jc6eqEomxOZbUil6rGabaRnqKxkQThGju53sYBgSng24a3g/EY
         7aHzIODzRMxP7X56SvJZ1jl+rudIOcs+hqniUBqpEhXDwpNuYiH975+7pit5Njf3FfPX
         bpALAfXKqxEFus2/ogv003ebDZqj6EBJJM4T65euwVxs2iWe1xF+2htOv6MjKM5QW1eQ
         grc+ZZy507t3u0AqHaLcgFuEd99uCxAHnzqjuRTFJkCwehCj0p65dPdrUoeSdVEUDBI4
         vsqkY+ZxBOLVn9qE3eiWL/v8Ni0QrNAvWKhPRrUDPJsWlZnQSWNwmGN9ktF6kwSqf/Lg
         RCSg==
X-Gm-Message-State: ACgBeo3yBmLpB6cjc67ovYy5jM6LA4SWc/iaiVdvoiRX9HbpMbvUt285
        QUi1cE27L+xcveZMCjEsH8oVbaDQ2hYcU8VQiX0=
X-Google-Smtp-Source: AA6agR7VJ0kv6VTSNAEyR9ldpSjuxqBcShQsKHcRrM9HUxTIQMcFCYl4ayZ4iZ2qqqgGXjAIzRcSzSIQh7AZNkhKMC0=
X-Received: by 2002:a05:6808:130a:b0:344:e23f:811b with SMTP id
 y10-20020a056808130a00b00344e23f811bmr1758301oiv.82.1661278508214; Tue, 23
 Aug 2022 11:15:08 -0700 (PDT)
MIME-Version: 1.0
Sender: davidscottman334@gmail.com
Received: by 2002:a05:6358:880b:b0:b5:9917:7822 with HTTP; Tue, 23 Aug 2022
 11:15:07 -0700 (PDT)
From:   "Mr. Jimmy Moore" <jimmymoore265@gmail.com>
Date:   Tue, 23 Aug 2022 21:15:07 +0300
X-Google-Sender-Auth: ApQygC0XgkOtpB-sxrTHlJ7ra-I
Message-ID: <CAB0r4CO1Duf6NF-QweDh7mdcze2DQU9SQ9udkv52jAXRjiv2wA@mail.gmail.com>
Subject: COVID-19 COMPENSATION FUNDS.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,LOTTO_DEPT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UNITED NATIONS COVID-19 OVERDUE COMPENSATION UNIT.
REFERENCE PAYMENT CODE: 8525595
BAILOUT AMOUNT: $500,000.00 USD
ADDRESS: NEW YORK, NY 10017, UNITED STATES

Dear award recipient, Covid-19 Compensation funds.

You are receiving this correspondence because we have finally reached
a consensus with the UN, IRS, and IMF that your total fund worth
$500,000.00 USD of Covid-19 Compensation payment shall be delivered to
your nominated mode of receipt, and you are expected to pay the sum of
$10,000 for levies owed to authorities after receiving your funds.

You have a grace period of 2 weeks to pay the $10,000 levy after you
have received your Covid-19 Compensation total sum of $500,000.00 USD.
We shall proceed with the payment of your bailout grant only if you
agree to the terms and conditions stated.

Contact Dr. Mustafa Ali for more information by email at: (
mustafaliali180@gmail.com ) Your consent in this regard would be
highly appreciated.

Regards,
Mr. Jimmy Moore.
Undersecretary-General United Nations
Office of Internal Oversight-UNIOS.
