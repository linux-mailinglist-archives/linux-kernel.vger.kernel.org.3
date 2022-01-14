Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338AB48E8F1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 12:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbiANLK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 06:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiANLKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 06:10:55 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB3EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 03:10:55 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id v186so23058713ybg.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 03:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Su/5RgSHszn1KZYanZr3x4TQ785FhafdwvX6U+xnCLE=;
        b=gubXWEfkHsebSFsYundbXG4m98xWgR3I3ajxkYAfc0A7ksYYcokzCh29MDpGwsXDZ3
         IwC54HYBhJgL3nLpbnHJ4OZFwSPSK8XOmC3s5ONOFO1eS8GrokZXeIFhyGFtVDh/JSW1
         pjoiYND99BzM+3ugozBAru0v4/EO81EWEGt/K2+msLQtQZxhnLqrADWH9GoIu2GPQl0R
         PMAZh8eljNjLjB+1cjx3CiD3VIOGAz1bAHxA9iVSvvF1WXzQJYljgepIuUSdda8sb0Ab
         jqxvoKiFi0smWiIixi816c1b49LV5N1jgI7G3XGISGa5g8O21Jy/6XHWCEYmw0UydUO6
         tAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=Su/5RgSHszn1KZYanZr3x4TQ785FhafdwvX6U+xnCLE=;
        b=b5hpgRgoSJ7j/OFSri2+ye6dpOjTcBRgfxLwwiUNvR8u2od4kxbdYdE+YxcPCGJ+L4
         fSu18MNCbkJt1Z9+++P3wkJr7Pq8F2BlePPAU61uFFDDP1w/GqO7OIBYcABs1Duo+Id7
         tnOWe2MVQzgPBdKTRatNzl7+o1V1l8AxWojxEBE1KTRwf8nND19B/Qzm+Ys2STjb1RDa
         WovMPq8Y26BxHcalL951Z+aJpGAivLUKz7915hb6qRbKVyhwlnGKssCxBxZXzT2o/U37
         njQ8nmfBYIRFNmJhI9Au7zRLLZTYH0grjFKL5YoHDQJpOZKr0ohsTTa1bBNlnQq406nm
         EkRQ==
X-Gm-Message-State: AOAM5311vW0nU+dj4Yc85acQcaRZ8wtpLQ4zMsiBum2cRXznR3fFDHdr
        6nDjwi4WUpHXxHBoS+OkonruzjMY46NVCdVpzBU=
X-Google-Smtp-Source: ABdhPJzq2m92due2Yiy/ahI0QEH9j8ywKMZmMbprd+X8E7UCawN1UIRMaK6vkIvI4BNGa9Vff+TNNLYv5x243JvCuAU=
X-Received: by 2002:a25:bb46:: with SMTP id b6mr11942954ybk.306.1642158654782;
 Fri, 14 Jan 2022 03:10:54 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:261a:b0:11c:ab6e:9941 with HTTP; Fri, 14 Jan 2022
 03:10:54 -0800 (PST)
Reply-To: worldbankinternational002@aol.com
In-Reply-To: <CAGaJ9Ptu8by94O9gsJ2iBWn-_REAjg=XM0_sQ7f7uM21L1zfVg@mail.gmail.com>
References: <CAGaJ9PvsvriNQZ=pUb17M9ELE+tPzV_wpyUSM4mkYDnKBMz9Tw@mail.gmail.com>
 <CAGaJ9PudCuJKG7KX+TgehP-jq3byZgH+7f0BMiMSKQ=BJwp4pg@mail.gmail.com>
 <CAGaJ9PsxG3i9=KueCWON10JDLGrrf-2mOWX3EkyjUGfhEhyVyQ@mail.gmail.com>
 <CAGaJ9PsEkBg0hww4W_hbL-TekmRQZf9ndkmqq7MWnWAnE722mw@mail.gmail.com>
 <CAGaJ9PvhLT43JKYQpRB-sFENcLovxvxv9ZQcU-y_oVNPGpFd9A@mail.gmail.com> <CAGaJ9Ptu8by94O9gsJ2iBWn-_REAjg=XM0_sQ7f7uM21L1zfVg@mail.gmail.com>
From:   BTCI lOME <davidbilly.indonesian@gmail.com>
Date:   Fri, 14 Jan 2022 11:10:54 +0000
Message-ID: <CAGaJ9Ps0x7EM9jY+opUho8HPPuaB_ejDUxCUboLdkHkJicU27A@mail.gmail.com>
Subject: Atbilde
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0J/QvtC70YPRh9C40LvQuCDQu9C4INCy0Ysg0L/QuNGB0YzQvNC+INC+INGB0LLQvtC10Lkg0L/Q
vtCx0LXQtNC1LCDQutC+0YLQvtGA0L7QtSDQv9GA0L7QstC10LTQtdGCINCy0LDRgSDRh9C10YDQ
tdC3INCy0LDRiA0K0LDQtNGA0LXRgSDRjdC70LXQutGC0YDQvtC90L3QvtC5INC/0L7Rh9GC0Ysg
NjUwMCDQtNC+0LvQu9Cw0YDQvtCyPw0KMSkg0J/QtdGA0LXQstC+0LQg0LjQtyDQsdCw0L3QutCw
INCyINCx0LDQvdC6Lg0KMikg0K3QutGB0L/RgNC10YHRgS3QtNC+0YHRgtCw0LLQutCwINGH0LXR
gNC10Lcg0LHQsNC90LrQvtC80LDRgi4NCg==
