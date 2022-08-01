Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7500586D5A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiHAPAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiHAPAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:00:32 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE43647B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:00:31 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id y11so8616463qvn.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 08:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VH9MjgED0AWITndim501l1CH8RMaZNy1yKl/Ru3+vOI=;
        b=nvKz/XHSj68KdSTanByg6d4KCigA8S6DVIxtXtNsB5E82D3aY43nigcQSYITM3ssP3
         O3oy90WdaMCut5i1JVBixoB329/SGYXcJ13oGCeYYYrXe32Gu8QIaOPA3XFfLA9pbqfp
         YTDyaCEcMIp7VcnWdFzu0lLahnmMWB9Um2hUiKVbRngfc+lPFKyw1stelQPkVCogZj0k
         iYsKXpEjYQ4om1eovrnOo7R0/gPU3mFPtAwK+4TmWKgVQMuXredBqnQt0GsWxFCGT6iz
         mz8rdrAcVf7XSWYY0TfMXjygKYwRbwI3L2Sfp2/l8NdjfMzp81N0Wc5JZGToQhc19bkZ
         WFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VH9MjgED0AWITndim501l1CH8RMaZNy1yKl/Ru3+vOI=;
        b=Nvz2egIC3e223iW1zW5M3hWmc2jHmSJdkeKlOILhX8doljmSS/GNiqBIHpbp1eR8Vb
         OQ71YmYefDL+iygT3yEbbJ7QRHkbimq3cS8ZqT9JMsycZ8PvUzILtOLdu6BTQnQabtxE
         6fnta7ypAStCXD14Yb9a+gtsuS3NGE+kYXSjgVocYlAnJ+ESzYg3ECovVT9KSeMpfAar
         Hw+eEdp/TobXlcILh/RtnBQGxHMQxBGpd6cAXgIrOgW7Rya20LRnmJlAHDwdCyEhH28U
         3KSRddK3+mkR1sHcDZigPOMREHiERyzqkwaBk5juGZ13oK7mmcuvm0mohxkFsIMJNPNC
         NP9A==
X-Gm-Message-State: ACgBeo2cNTib870UegNvFhN3r3vUazyuptIgsmKyvHWPePgvNL3k7U/g
        Tti3H1OvwfJg4CKomkCgQBg1NVwNbvLC2BW46Z/trg==
X-Google-Smtp-Source: AA6agR48bKZ7gnfltlVl1dBF4hEAWGRSmEMqBE3ThX5K1gCRT1iMR2DjmeVyYc+nbfG0UAL9FyuoK2Qs9LxAp3tY+Z4=
X-Received: by 2002:a0c:8ecc:0:b0:473:2fa4:df7c with SMTP id
 y12-20020a0c8ecc000000b004732fa4df7cmr14424536qvb.55.1659366030428; Mon, 01
 Aug 2022 08:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <BY5PR02MB70099020AC1D181D15909F64EA9A9@BY5PR02MB7009.namprd02.prod.outlook.com>
 <BY5PR02MB700972E09CC9D8ED6EFBA59AEA9A9@BY5PR02MB7009.namprd02.prod.outlook.com>
In-Reply-To: <BY5PR02MB700972E09CC9D8ED6EFBA59AEA9A9@BY5PR02MB7009.namprd02.prod.outlook.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 1 Aug 2022 18:00:19 +0300
Message-ID: <CAA8EJpqBVaPt6dc+=u1YZwxEo9i4Y6+QFK5ko0Gd3091pKYXjw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add support for Xiaomi Poco F1 EBBG variant
To:     Joel Selvaraj <joel.selvaraj@outlook.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 1 Aug 2022 at 14:44, Joel Selvaraj <joel.selvaraj@outlook.com> wrote:
>
> To be honest, I have no idea why my patch series doesn't get linked
> properly. I think there is some issue in my OS. I use git format-patch
> and git send-mail to send patches. It used to work fine. But it doesn't
> want to work anymore :/ Is there a mailing list for sending test mails?
> or how do I debug this? Kindly let me know if anyone has any
> suggestions.

Judging from the following headers, it's not your OS, it is M$
rewriting the headers.

Message-ID: <BY5PR02MB70099020AC1D181D15909F64EA9A9@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Microsoft-Original-Message-ID:
<20220801112512.209047-1-joel.selvaraj@outlook.com>

According to some mentions on the Internet, M$ relies on headers
rewriting and will not change this behaviour.

I'd suggest switching to another SMTP submission host. I think it
should be e.g. possible to tell GMail to send mails with @outlook.com
addresses. However this might confuse some of the mail clients into
believing it is spam since the email will SOFTFAIL the SPF check.

Switching to another mail provider might be an option too.

-- 
With best wishes
Dmitry
