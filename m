Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41814B4EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352903AbiBNLm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:42:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354205AbiBNLmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:42:19 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184A26734B;
        Mon, 14 Feb 2022 03:34:23 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id lw4so5945600ejb.12;
        Mon, 14 Feb 2022 03:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nUkoHrCi+rll5X6AfJ1JcOE/KlEsuP9QQ8DjW9JKI+o=;
        b=cqYL0nGG8/rPIZ7WxPDeV+I0AaE94962Wq5Zf3FTYLkvxb2GtxsW77QL+OXZEMOy5i
         7ktpTYe0JXDwZ+HcWjz/tfgDMH39Dr2og3pHCbQS3YIGf1kTwe1icZ8LmTOc+L0zuoX5
         oloCczNMFvVeNXQ/6wJ4R/+5BbeSKqMKx37G2kZ6jqbSqq35kvMo2DEy7J7FQj7b+kyC
         8eFrRPDnVYIpinsNkBFZS/t3fB8pXKtzWUbEqKVV5Qpj/UN/Ut6y8Y57dKD8Eom41Efu
         qcQvzGcdafwz1xGdYVFUa3U4ZWS2gNJg5VaN9/EpUJKsJLh33fX7D+2iKyG5vYk1uTuC
         T9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nUkoHrCi+rll5X6AfJ1JcOE/KlEsuP9QQ8DjW9JKI+o=;
        b=1Y9P6kvGTa/UD/oQIUbhl8vhaMABHVMMx8rcFq9PTrYcnbQIC5bZhF8dLfNoQYpfnb
         5NXfTxN094PFmL5dKmv1nmFH2NFnqn8ABoL6D8Eq07qyb+kJL5A7epRbkPkUlRK/szs3
         u6GUvPtCtTpuDXm1iz7tBZgBAMD7z5kHdeMeEw11OdYgL0EEcUKHqMJtNXFUeineNZwL
         l6NaUJ1218pk7jc6XGKwZDca3PSdsp7vcxTYH2I+8YCIdk8OFoOsOACeElXIALu6k8DG
         BTarlXWGbab2hukOqFa+n5xcKegRZFKzc6+zVybT58NUXHP3VFqBIwzauUlkNZblCPJI
         9tRQ==
X-Gm-Message-State: AOAM530Lk6Zv+2nWlvNpzMm0WSZAIrwjWBI14umtbSIZnpVe//xCe2Ao
        rKhyNXgsbKhmnv4T+Yrtwya5E/YS3OHIQFtQUEc=
X-Google-Smtp-Source: ABdhPJxw09XfaALgfNFPqIB3VPo5LLEnVjpiia+mqWDZjpHX4sq4Ei9sz5Tu7lm+TNtWdcrTizPS0paxQgLatnnKyLg=
X-Received: by 2002:a17:907:6d0d:: with SMTP id sa13mr11637554ejc.44.1644838461662;
 Mon, 14 Feb 2022 03:34:21 -0800 (PST)
MIME-Version: 1.0
References: <20220214033620.4059-1-jagathjog1996@gmail.com> <20220214033620.4059-5-jagathjog1996@gmail.com>
In-Reply-To: <20220214033620.4059-5-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 14 Feb 2022 13:32:53 +0200
Message-ID: <CAHp75VfmTwC8j=1kuQxJ3HOb00YWOHtOCEVbyHmPjD+P20fepA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dt-bindings: iio: potentiometer: Add Maxim DS3502
 in trivial-devices
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Slawomir Stepien <sst@poczta.fm>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Feb 14, 2022 at 5:36 AM Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> Maxim DS3502 is a 7 bit nonvolatile digital potentiometer.
> Add DS3502 binding into trivial-devices.yaml

Missed grammar period here.

-- 
With Best Regards,
Andy Shevchenko
