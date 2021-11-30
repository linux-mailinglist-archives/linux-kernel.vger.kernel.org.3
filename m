Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB864639A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbhK3PSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243414AbhK3POu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:14:50 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E513AC07E5E2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:05:44 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id v19so15134728plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=GMS93CoAKETSWOkFC+22mbrWOJMWtsdrV7yN8LPC6To=;
        b=Gr/0gPC8lB7hClztyBfA8bZYPb1qw88etxhbyUOldIVUA7/2Hft5u7xmkJrR/Ykq07
         tKB/cVGCBt1GC+h2NgQ4QpLEwv1snnLlAQUXomv84PfuUHNwLvHs3JcjpwaudcyyttmW
         yLuZLxXFAGks4srfIJD46TIoBRLY+f12OkpDoO/IEF4MmXI6+SrljRHu8kUqK4CniWYt
         1UitFxP+DVzRoC6V1oBDjIEVQCMWfStQ2ODEaXM/uZYLCLlhuUXAlk/e/nbmsZh3DNiT
         Gkaeerjqqgy+/TvQKnfF57lVB+OQyHQnh34o/2tvAHeziBqlEbg2XYG+V+//iPsswhCM
         Cnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=GMS93CoAKETSWOkFC+22mbrWOJMWtsdrV7yN8LPC6To=;
        b=MoOcIOakhMgEUe/WVfgOn38dyYTOHhQNRvaReA30cS/qK7dw4bIyJNgo6hXMd+r32T
         eQqBtg5lo9qIQR2kmcwEFmDyglmoUNJkwoeLWNU6KdrApbNq6p6/O3+laacAR/y3Tkqp
         AqbCBVTiq6O8yEFXTb1ohdYQt0kjBcu0bO9lnPRD5gke97SUFViWAWvz+qBP8LJnj6Ve
         KwE20kuEm18fq0UtmXM3o5BwSn0+3dLhxzY2Gt4SPe0XJLt50UxfBmdAOW/fPXAzEefi
         29rCemYlfU8/CKOT0SGfUlX3ZiFb0xnyXnTGeSEAGtF9Sx413xosZEzIwEH5lHhVybIt
         EQAg==
X-Gm-Message-State: AOAM531YNEZoDECvF/yQQGjqwfAxInwRglrjp1rZR8RwjTXds4d21xQE
        bRZjX7Bowru1dbNJc7rWYLZ+DtdbQEXwE0ZMYCk=
X-Google-Smtp-Source: ABdhPJyuj+JnUyVPHBaHNZW5LcliSXJs3ofEDz3lepXTR2R12FEFlA7NOujFruurOTHjO5wl2MOOmI1s4+A6RrAy2/w=
X-Received: by 2002:a17:902:860b:b0:143:87bf:648f with SMTP id
 f11-20020a170902860b00b0014387bf648fmr68782658plo.11.1638284744262; Tue, 30
 Nov 2021 07:05:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:ed0c:0:0:0:0 with HTTP; Tue, 30 Nov 2021 07:05:43
 -0800 (PST)
Reply-To: phillipknight903@gmail.com
In-Reply-To: <CAG3vQXaF_StLE0pZfoU4tEQ2kTvkBsR_U9jD4V4+UEO233ggcg@mail.gmail.com>
References: <CAG3vQXaF_StLE0pZfoU4tEQ2kTvkBsR_U9jD4V4+UEO233ggcg@mail.gmail.com>
From:   Phillip Knight <anajose19004@gmail.com>
Date:   Tue, 30 Nov 2021 07:05:43 -0800
Message-ID: <CAG3vQXaAuZDotrg8cgF=KM9uqFgsNqeSdBmzwn-bus_zxc0RzQ@mail.gmail.com>
Subject: Covid 19 Department
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Dear Friend , The first =E2=82=AC6000 euros was sent to you today.
