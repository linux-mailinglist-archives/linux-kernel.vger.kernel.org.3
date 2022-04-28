Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDC05132D4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbiD1LyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbiD1LyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:54:20 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38B871DA7;
        Thu, 28 Apr 2022 04:51:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gh6so9129835ejb.0;
        Thu, 28 Apr 2022 04:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=egD9TWiQgZ00ABqrlpVUqX07Bqzo15fCup+voob9j6g=;
        b=WL1Az0l4M71t6wH3bpologdHI+2TTcuoscgjnsBJKMEICZric1CBnR4C+iqFz40wp2
         WduxOA3DY68wKKncU5lIgYNo3SNSThAyo7vsLzBPYwn90G7eAkr+t2XUGZAoEIvL3XXl
         ONaIN7YHpPSW3nloam1m74lWGBzKVTCkfJ7C7Vzfs89uM5mllkCSsiNClcUaos4lvRtS
         288uNt0JBuhVd9u4Wc70I6n9QqasFOhbZbGnut7fp6kl34H0ZJwMLWrpcF9Of1kHY2eF
         CDcaFvF98+zajvfK2GhQf5AR+uNasFZ0WElVRW1r7LER7Viun70c9lwZbOjsnUIKowOK
         9Ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=egD9TWiQgZ00ABqrlpVUqX07Bqzo15fCup+voob9j6g=;
        b=Cup4COTLQBOEOxRKI0HPRaKIciT+QFf7ZYnHmzhUZhTWWVhSEensOweN87ORE3XmAQ
         Cuq9M+B8o1J624lphAy+Y7jDt5B2O0Z0YdxpuwjwWjFkUwoQtg3CwnAD2URLUgVkiirN
         QcLL4vdnxOCBJVdwL+18gBVU+7v0xXpmnaKxyg1OLDjFo6+UxGls95OfEmoWkcSWYYxS
         9+nMb+zUQ4Z1jPiDMQkhG4DHMFaRorFfEZjYC4eq9GVBSZ/1QfwxJHyWnOBgPgNn+5wh
         hWs0i9d/Cj9tzkYBifRuzCPYgcDgOhgzJ2IKcjtTsEPZf4XkYVL3AvSpnKYMjBHLkBsX
         VaBw==
X-Gm-Message-State: AOAM530BdOaU5YoJXKsWa76aKRa+hCJltrDuktYMJzMeEL2uK+cNemGd
        ii5TMakQD2n4Q5lFNhnBXSgEDZgC8pUVYY668vg=
X-Google-Smtp-Source: ABdhPJz7sphZYsAcSHkuYWOXutg/BiHeCdlfJ7IswfBYScK2TZOjRTZA+jBvaIFK4z2tXF9uaATwhh/UhZCbUQlMNqY=
X-Received: by 2002:a17:906:c147:b0:6df:f047:1677 with SMTP id
 dp7-20020a170906c14700b006dff0471677mr30824800ejc.4.1651146664432; Thu, 28
 Apr 2022 04:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <1651138365-17362-1-git-send-email-u0084500@gmail.com> <1651138365-17362-5-git-send-email-u0084500@gmail.com>
In-Reply-To: <1651138365-17362-5-git-send-email-u0084500@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Thu, 28 Apr 2022 14:50:53 +0300
Message-ID: <CANhJrGN8avK7mehqVDHVCjBzoG3RU4CykHEaFdQqt40_LjSh1A@mail.gmail.com>
Subject: Re: [PATCH 4/4] leds: flash: mt6360: Add mt6360 isnk channel hardwre
 breath mode support
To:     cy_huang <u0084500@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Gene Chen <gene_chen@richtek.com>, linux-leds@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ChiYuan!

On Thu, Apr 28, 2022 at 1:03 PM cy_huang <u0084500@gmail.com> wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> Add mt6360 isnk channel hardware breath mode support.
>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>
> +static int mt6360_gen_breath_reg_config(struct led_pattern *pattern, u32 len,
> +                                       u8 *vals, int val_len)
> +{
> +       static const struct linear_range tranges[MT6360_ILED_RANGE_MAX] = {
> +               { 125, 0, 15, 250 }, /* tr/f12 and ton, unit: millisecond */
> +               { 250, 0, 15, 500 }, /* toff, unit: millisecond */
> +       };

It's nice to see you are using the linear_ranges helpers here! Just a
minor remark - do you think you could use field names in linear_ranges
initializations? That would make it less likely the driver breaks if
someone changes the struct linear_range definition. Eg, use something
like:

static const struct linear_range tranges[MT6360_ILED_RANGE_MAX] = {
        /* tr/f12 and ton, unit: millisecond */
        { .min = 125, .min_sel = 0, .max_sel = 15, .step = 250 },
        /* toff, unit: millisecond */
        { .min = 250, .min_sel = 0, .max_sel = 15, .step = 500 },
};

Do you think that would work?

Best Regards
-- Matti

-- 

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
