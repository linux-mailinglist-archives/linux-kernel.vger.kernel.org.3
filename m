Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C0C5652FE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiGDLF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbiGDLFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:05:24 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9226160
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:05:24 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id r133so8330772iod.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 04:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UjveiQnnH7duUmyxECyFreiQgRIipABjT6N1bpCr7Ko=;
        b=N5atQUy3O2qwSePHHmylXkrOLzktL+57srgucwl+xvBcwyvgToK8l8yboujQzFNqbB
         SOI3/y8YizMAj9rn/xcH07y67WpBSCRVEZNvwZkRZZuAW53LDrL0XaOKepOFsCLMQ1wn
         lk0xVI+Ic7z6b02iDQCn2V+IltWXGBaYjh2jGOAoe9sZH3IAvQRYwwH1BO6IIickW+CO
         NhNi+VqnDCwZWJIH5Bu+/yb/Xf1BYK2LEgJwODeDCxa+WAqUWpe9NGzMZ5oMN0/PSG8H
         rhLkeLaKCI2Y3cKUyBi9A9HFap8JX4MPHbPmu7/4dPVIZl8fSqbgk3lr+gxEqmNWP6da
         158Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UjveiQnnH7duUmyxECyFreiQgRIipABjT6N1bpCr7Ko=;
        b=nhCNthArI+B4KNfsSijQESJv9LKAplMJ+YahjRYAlXbWfMlStvPYpoY6ysWOKr07VL
         iZL4eDCr/rNsZRV/0qSn2EhiXA+EON5l5e97NcY7vSKxvNRBZehZzSiwMz86ohcVeFOT
         i8L3nOUkA7lvnz2XScc98z+XsSjOvKXw8YWfx43Dk49opOSA3NRBNY8amqmX2M2+0bgA
         k2MQ8sGFZCF0fkzUtjRrQidNV0MX3XQAdVMiI+y7fQnXIjyRsqPEn8IOhIebPxqk7RYO
         OezxgVyIyb2wO544LDmEk3tmNnhlTfT/5hQH494iKym7H/Vx9RE/bF+7B08d8A7s9gGp
         buLg==
X-Gm-Message-State: AJIora9mbymgRoFB3hb/ptrId223Hi2A/C7VAoG8NFH5LMfkD37AbsN2
        CywPQhEyzV9oNT26/Q5gD/2u3N3CvCB4M70JuQtHYd0x
X-Google-Smtp-Source: AGRyM1s9haKFMdDwF41VfG90crZ9XM3TfQBAyt7Sr1QHmCYrzqiGPZzoz3TV+YA6SyY/PXCh98icJ5VKozTG8ejTawc=
X-Received: by 2002:a02:9f86:0:b0:339:cfef:741a with SMTP id
 a6-20020a029f86000000b00339cfef741amr17592704jam.4.1656932723677; Mon, 04 Jul
 2022 04:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220703053225.2203-1-xw897002528@gmail.com> <f7876785-3895-7494-6d64-7ba64a5d290d@opensource.cirrus.com>
In-Reply-To: <f7876785-3895-7494-6d64-7ba64a5d290d@opensource.cirrus.com>
From:   He X <xw897002528@gmail.com>
Date:   Mon, 4 Jul 2022 19:05:12 +0800
Message-ID: <CAPG2z084-Kzc3mSF9iO-hWxUCvqmHpXZ1eyMNzGaG4tVfATqzw@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda: add CSC3551 support for UM5302TA
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Before accepting any new laptops to be supported, we would like to get
the Firmware support merged first.

You mean if the firmware is loaded, the ACPI will be fixed?

But I have no idea where the firmware is. I can not find it in the
audio driver. Any advice for that?

Thanks

He Wang
