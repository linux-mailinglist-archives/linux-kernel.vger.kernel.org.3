Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D99C4B3874
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 23:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiBLW7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 17:59:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiBLW7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 17:59:23 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F645C35A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 14:59:18 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id a42so1914741ljq.13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 14:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=SEcNjOSXP8wGpHSIQOVacqlW5iquJAh9dHc2B4bb5SE=;
        b=mp5FozxriUB5rEnGupdE+VP9Ju52rDZM2AIbr2BYR+zkHL1alcb9/aOwb9mpqXijIr
         A2dmPS77YSJvkJrzKgpV4uU44cRgQs1Ru+Wg2Chf0tmRFSIPCGFJsdCGGMGKXdYs+YJk
         j5kH0KQ6q1n6T43lPLmIm+0hyfIcIgCerNHZGX5VcqCgybPPmUUO3fVdHjyiHSnc9XJe
         QTT0NPG2tcSJ3VLLeWO0OEB02ynoQjEjiXtpMzpeVlGMYyXpMz1mLrAOpM6hKNf9+z0U
         sw3sH0xT2LL0DwkET9dxCFPET9crFVa1WlJhf5N0APXjtimaaSt/1s/PPZmx/fe7050T
         Wh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=SEcNjOSXP8wGpHSIQOVacqlW5iquJAh9dHc2B4bb5SE=;
        b=eDIdbMpFgI/wPil+AG2S48UMQiNCypDn6QCRYqL/fQTtXrXnEKqnmtUu6GEJCIBNyz
         UTp3eqJ1DI9DkcIRoXR7VHcaSoMT8q57DmJSy8+crbn7T04E84oohmQK7oAsy/80kKFa
         oyehdo/GuRn/H+NGdAM5a5D44fUWY2UKqg9wGgec3eVyrNV0vk3JA5zWKYbA7gtUlypC
         SqFBWNpnJPykZcwLNc2TBsbLJipzSuOE/N76/LwpS3UyDrTjSCBoNJTm1HVq8BbtmHHo
         6YZWnxJRLGXYPj7NaAGHVje8CdIwhrsKQe8EGwWGaAwlg1ZTpLVglMhkMWC9x/22IBQ+
         fVdA==
X-Gm-Message-State: AOAM532PWM5ZyHbeXLjbonB08SFsShHBqz0BcYOAtmqEmOJn2XlaA71t
        ByyH+2EVZ4Tu2flBWGDsBaeHdhU0CMQoLcYT2l8=
X-Google-Smtp-Source: ABdhPJwIH/BcWwAZgshczFZrwvk4RLtP2XYJLunHucMtr9vF3xtveEXvmpzqBnKsPpqmRmm1IwHAgfyAEgZpYFaPZiQ=
X-Received: by 2002:a05:651c:1a2c:: with SMTP id by44mr4605610ljb.319.1644706757138;
 Sat, 12 Feb 2022 14:59:17 -0800 (PST)
MIME-Version: 1.0
Sender: michealkevin122@gmail.com
Received: by 2002:ac2:5df4:0:0:0:0:0 with HTTP; Sat, 12 Feb 2022 14:59:16
 -0800 (PST)
From:   Aisha Al-Qaddafi <aisha.gdaff21@gmail.com>
Date:   Sat, 12 Feb 2022 14:59:16 -0800
X-Google-Sender-Auth: Uc0nCAEtdT7LkONoiZZEoXuhjXY
Message-ID: <CAKC2Uf6=ZYCeVRgVWJ6Pk7F0dqw4USNDB6r=dutLJ25KD4md1A@mail.gmail.com>
Subject: Your Urgent Reply Will Be Appreciated
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,MONEY_FRAUD_5,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assalamu Alaikum Wa Rahmatullahi Wa Barakatuh
I came across your e-mail contact prior a private search while in need
of your assistance. I am Aisha Al-Qaddafi, the only biological
Daughter of Former President of Libya Col. Muammar Al-Qaddafi. Am a
single Mother and a Widow with three Children.
I have investment funds worth Twenty Seven Million Five Hundred
Thousand United State Dollar ($27.500.000.00 ) and i need a trusted
investment Manager/Partner because of my current refugee status,
however, I am interested in you for investment project assistance in
your country, may be from there, we can build business relationship in
the nearest future.
I am willing to negotiate investment/business profit sharing ratio
with you base on the future investment earning profits.
If you are willing to handle this project on my behalf kindly reply
urgent to enable me provide you more information about the investment
funds.
