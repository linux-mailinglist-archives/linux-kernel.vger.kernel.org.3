Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B51F58CB53
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243718AbiHHPeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237965AbiHHPel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:34:41 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FCD1402F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:34:41 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id u12so6789065qtk.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pkIOxRI75elKX84Ltag3sPcyywVqagQ5FUb/B/7UN30=;
        b=WSRRlHsAuStjpJC5+Mc4iDw+d5oIPnDM1crNQHyAdHNEKCztvm8kECq5eNh60fhSdg
         GWQk6a1Sl3dMo+LGkQRoJ4gL4SUnQEv0/JTXMCw3LDbxPtJmf7Wu8N6RDh0Z9ALhN93o
         +S33OtHuFKJf2LOynn86DJuutjIp2Fi47Sr+J6ynEVGTISmZPYa9A0CLk5QDoA+/91YH
         WD+wLKD7qfficsrzIkgS5SNQikEhukOgyTCumxzP/8GTivml+FvLNW//V4jswNotkN3O
         aWRd8Jk+FWNMfltepao+fLhgPwoyO2BQCXadbnVbny7RynzbM4Q783xiSvtBZKGsP676
         7wUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pkIOxRI75elKX84Ltag3sPcyywVqagQ5FUb/B/7UN30=;
        b=zJ4rpIIlhYj1OQjX7jgOj6Etd3Qh49C4Ai/NXodTOHEm/ZsfU1A52YNQbu8yiT7QoV
         5fc5fIDwP0MXpeK+T5wyPZfgCQ8+1FJ8Qgvw2D1dapEkFF3O5FgEDtm9NYJlmm3jVgn/
         vIIjB1GDzUQVADcz4sDinaEo/quF5NyE120ktKpPZFvZhlB8o3gZDmMYHrZ0JxuQvVQi
         SNuuxi7qvu8INDasAcKeM5qsGj8O4gkZ4oLxcoY45o7hDCM7D8IdUVBAkkL3AKOePsQQ
         uOy4qlUiyPO58GEpQbHT7qaSeuz/zes5aVlImqpLubMfRYq4QFHzhidVyuNVqDk0Qzma
         PO8Q==
X-Gm-Message-State: ACgBeo136k5QOEccheNnfsiPkatS5H3RS+uR4OPStNjr7ifxAE7EAj3J
        hft0O6qEe+GQGGyYoPequl/VTyCtxJprPp1gWgI=
X-Google-Smtp-Source: AA6agR7Hc2NGGQ7d/HSoy2lOC9JETTDgfvJLnyRUEOVYhnKVZ8aPlkhwIMxcZmG0nGXbmv7Wh2AzY6wCFaeJvV4T8Q0=
X-Received: by 2002:a05:622a:48f:b0:343:463:351a with SMTP id
 p15-20020a05622a048f00b003430463351amr1035780qtx.61.1659972880250; Mon, 08
 Aug 2022 08:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220718122328.8287-1-andriy.shevchenko@linux.intel.com> <YvEqFguuc4JMijJk@google.com>
In-Reply-To: <YvEqFguuc4JMijJk@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 17:34:03 +0200
Message-ID: <CAHp75Vea6r1845S2PsqD6xaYfxQ1BUCnBvHuTOV0vZ9qFME5Kg@mail.gmail.com>
Subject: Re: [RESEND][PATCH v1 1/9] mfd: intel_soc_pmic_crc: Use devm_regmap_add_irq_chip()
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
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

On Mon, Aug 8, 2022 at 5:22 PM Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 18 Jul 2022, Andy Shevchenko wrote:
>
> > Use devm_regmap_add_irq_chip() to simplify the code.
> >
> > While at it, replace -1 magic parameter by PLATFORM_DEVID_NONE when
> > calling mfd_add_devices().
> >
> > Note, the mfd_add_devices() left in non-devm variant here due to
> > potentially increased churn while wrapping pwm_remove_table().

> Doesn't apply, please rebase the set (probably on -next).

It was a wrong series, and I guess the latest one is this:
https://lore.kernel.org/lkml/20220801114211.36267-1-andriy.shevchenko@linux.intel.com/

-- 
With Best Regards,
Andy Shevchenko
