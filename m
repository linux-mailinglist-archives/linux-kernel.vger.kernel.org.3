Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C30F4ADAEE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377745AbiBHONt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245666AbiBHONr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:13:47 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D805C03FED1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 06:13:46 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id ki18-20020a17090ae91200b001b8be87e9abso1663022pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 06:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=wUs61oZJqlck5gF/NSnB+WfYV6TsIOcAjV18fUOsHlk=;
        b=ZuEWBeUc9bEG2LQdnQyHE5UBcFUs8oJSTQ6GPLYPoIjEhRE/LDCWcWCXCAU3m/eMVq
         ws08ZFiONPO0S/hSLSZomLJ9dX+wvzxaFBpOb8Ci4ojNJWNNgPXyTjv/T7lglm1xII/c
         wnGAlINh+EY26z0uO8ZPjM911jlqHBhj1tis9NjM3nd+eD6fTeFCwnrvSgO/VTch78J0
         ZKG2dYPFELaTD1C96wVBKYKu9le83VkbBjXJHamQatoBfxBk91rHxIEaHr4y4UiKNnvC
         jgAaIYjdqoAxzwc2FTLCK90G1ABjKKKZCdxEQ19loDJZmRnEPvkzZVCPWArpqmS8uPqB
         nvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=wUs61oZJqlck5gF/NSnB+WfYV6TsIOcAjV18fUOsHlk=;
        b=hd1YMytEs4NGUEv3IYGRJ+NRfYCtQyOr4cseqkxGd0+j1Kt6SaW6R1gr2IiyLOcqnz
         NNDpYybkzuHWTC2z1knRxRRUjHAGoOnLWGUeCG8piEifjtFxr0NpLOCfjf0QNroxHiSS
         DfzEelEjRAiTcJPUuS6CjuMcVYrLQBjdzig2cdxlUVSgWD2EpGiu04Gx6KvStR0HHxUh
         kHkzyfqjOD6Cs43rk3KYijOK+d9Xmx5ZexXyB17+ObywLrh6IMxmVU0ajRGeJtrJ6DIj
         ZCHJyv6yqPf52rrjxGZQTzpTKWVjG9RbqwCy/FFb35c5qcBR0el3Ic5yxf1jx/b7t2O5
         xt/w==
X-Gm-Message-State: AOAM533kiXgQQ64J59+Zr/j2hhT3A/KLHyrG0F5XQfxG3A3JEU2PNIt/
        7Cb//aP3UiDPu1Dvrl/vBX/6e7rewEnV7IoZmtIhCg==
X-Google-Smtp-Source: ABdhPJzkOPqpuKjkoaUj11A2U5adT1XOMis3E2cn7BT/wkP8nSrGThhgEaXL6pbGnpEWOkbCWnGvmyLtRYUiMXiAwOU=
X-Received: by 2002:a17:90b:1e06:: with SMTP id pg6mr1633156pjb.4.1644329625500;
 Tue, 08 Feb 2022 06:13:45 -0800 (PST)
MIME-Version: 1.0
References: <20220120001621.705352-2-jsd@semihalf.com> <20220202144302.1438303-1-jsd@semihalf.com>
 <20220202144302.1438303-2-jsd@semihalf.com> <YfqtkBIZZxp2Au2l@smile.fi.intel.com>
 <YgEr7LtUAd4QWiiR@shikoro>
In-Reply-To: <YgEr7LtUAd4QWiiR@shikoro>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Tue, 8 Feb 2022 15:13:34 +0100
Message-ID: <CAOtMz3MEFyW+g8n880rWiZbfU-2Gtfj2b3GNOtZswrFQg_m-yA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] i2c: designware: Add AMD PSP I2C bus support
To:     Wolfram Sang <wsa@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>, upstream@semihalf.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Easow, Nimesh" <Nimesh.Easow@amd.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

pon., 7 lut 2022 o 15:25 Wolfram Sang <wsa@kernel.org> napisa=C5=82(a):
>
>
> > Side note, please start a new email thread for new version of the serie=
s.
>
> Yes, please. Also, neither me nor patchwork got patch 1 of this series.
> So, please ensure the series is complete when you resend.

Right, I fixed this in v4.

Best Regards,
Jan
