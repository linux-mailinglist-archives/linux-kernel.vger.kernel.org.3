Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C68F486622
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbiAFOer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240163AbiAFOeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:34:46 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4232EC061245;
        Thu,  6 Jan 2022 06:34:46 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id j21so10124859edt.9;
        Thu, 06 Jan 2022 06:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUe6YDJn8/YUK5uuxVc1cV6eQGCStzVD0xbFRP9ogOY=;
        b=duw5Vuz9b4CX2X7CiJTPr1yyK7urT9/yj2Vxr+YIjLbxxUyEuuDqCNNSZ+hK3RSFmK
         AZt+QyN5fHV7uFx5nhtSWGobfCYdkClopP4JnnMhkSo4bskbuQw47SvlvvzSYXbi31cT
         F8u+lFV5BASlwYUROhG199fexFzH/skaDYbRmoCBspGooorNv/u+FzXsYN3fym+yf3GI
         WXyEwHBydOU2VYOlmkPDxoOuK5FhQC9CAMDFka9qqgVvngiqY7SZdVFZ36YQ6hKpwAWv
         4IAYsMO9SsRpmF43NJWl3WJOUQaPmFFjz6XvTDmpfC5uIkJGVcjp4AUakH2me4klAi6R
         6XgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUe6YDJn8/YUK5uuxVc1cV6eQGCStzVD0xbFRP9ogOY=;
        b=ipm0AgrI67S3ZLOYmheyxcD8gidhOc7TsaNLSPosvfegJVqlnqhmW/W5gMa0rw1dZT
         SqD7MDc3ImFUDdDWIt1Y7aLO4FDyTQVe1wPARFXr5cZLvZqhQ/WDnWUEZ6uUn4Jn2JoV
         21gNomFeqe8FRgHyH0ldy/QqxKiygge/ff2MzbtaifumZ4cKgCZgSvQluQX1L1oaj0zD
         NzfXptbyXdeSk3XuRa13oGk6aQJAoz/d2OHY3Ol6HCDTGoLa5/9jSNUTcz0+Kg7VI5ma
         dsOzJhgqwo/vgds3S0HPCcSD991OXcD/3LYUWXNB77r21t6OskZraG9inJBvPjxqv5xV
         jblw==
X-Gm-Message-State: AOAM530QKYbqn4pL89nFzw8CKoWTBF60dCoeyQlmKHiRwHM/98q4/NDp
        fJwnl/dKB1TzVDJG7codMBEF2RUQjoGRwWzjzBo=
X-Google-Smtp-Source: ABdhPJxFeIxFijPPQQXMHowmkJMvHVjo68XMpUtPKIAZQ9cWkWbNrblNY3txHDmJtv7AvsYmTMIE5v2/pJUK2t041ZA=
X-Received: by 2002:a05:6402:12c4:: with SMTP id k4mr56539100edx.218.1641479684878;
 Thu, 06 Jan 2022 06:34:44 -0800 (PST)
MIME-Version: 1.0
References: <20220106053810.934797-1-kai.heng.feng@canonical.com>
In-Reply-To: <20220106053810.934797-1-kai.heng.feng@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 6 Jan 2022 16:34:08 +0200
Message-ID: <CAHp75Vf3OAoPvz_iO4FHb=uwj6yiJeiZDpy6+aNs+nJ5wXUC7g@mail.gmail.com>
Subject: Re: [PATCH] Input: adxl34x: Add ACPI HID table
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 7:38 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> x86 boards may use ACPI HID "ADS0345" to for adxl34x device.
>
> So add an ACPI match table for that accordingly.

All the same comments as per hdc100x patch.

-- 
With Best Regards,
Andy Shevchenko
