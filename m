Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818CC489F74
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242146AbiAJSos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239534AbiAJSoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:44:44 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C79C06173F;
        Mon, 10 Jan 2022 10:44:44 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id w16so57282920edc.11;
        Mon, 10 Jan 2022 10:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jtE0Rv+bum5sJgWKzx4ASlY9bVyREWYzZIOQJxZM5iY=;
        b=AhI2Gg6YdCwaIhrAu5mqDabtZ/GZlXpoGpgT6vvCGNXFP2dgdqap32qKD9Xpo7OMHJ
         ylabTTmEvwqrb02HRKgXvdPXIDJqbaWiU1alJt0308qvtPfi2joy8NGpeu2ACyLBHKxh
         5HYNCzZZq+aFByZLSgWJLAWUWMspRUOGVUS3b5eSqs6Lm0IR66CoDfjRfqMDuKH6VRZ+
         kfaQuXNJYxDNZ3MDsLL7ARZTt1sFDOd+7nwmhm2fAgal0/I1hAUAAB15EoZkYyd8xogk
         3xcCMAOElWqYC2+r7vzdYvQu7U4mDy9hfw424pYx1sqU+wzWrBIJ3VjRHVySYKsSt/4I
         b4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jtE0Rv+bum5sJgWKzx4ASlY9bVyREWYzZIOQJxZM5iY=;
        b=xfdHxF3dPSMUjgMwjK/AXmU/ARv5hlnRoBCShieRohE3zeAEu5nTe1yL7SrAdkvIFc
         /LMZSqUa5hwNosQHh1yAAwsW7Bzg4ak/Z4GqfhAX4Z4udL2yHX7mYWiUvO9It9IMr6qN
         IU17PKsnrPlmFWH8uLQZWAaBPcsd1sQJHXn0RyQPL+vUcjQohrV+q/D/xe4Sm8ttFSZv
         sLuhCTs0fIkyIJ+/Xr2vDEgw4Vy2V+tQWMltgJCod2VcZJHb62OEiLZpTfkVAqjsxHVS
         clI+af+SIVrFQAqRBM4Mr9x9XeRJHx2ervmSwL60Bs10FxJ+WkYcoozc88r/AWvIwLXL
         X5jQ==
X-Gm-Message-State: AOAM531FvrCGcePNHFjlQXgOLSTaVHxFLzx1uYIQGfdGg68uJEl1Ntt9
        aNEHeBGtHXRRtSaBPVEyMw/vBLqLiNnvKMilfMk=
X-Google-Smtp-Source: ABdhPJxmqyqaucGkcSzCFWyIp16vMFyJRkqtG9MqY7GjEaenhNbAZR5xixkY+sqGnW5/IK5vzwD4oPXNR2rXXVToc7s=
X-Received: by 2002:a17:907:968c:: with SMTP id hd12mr773695ejc.639.1641840282660;
 Mon, 10 Jan 2022 10:44:42 -0800 (PST)
MIME-Version: 1.0
References: <1640331779-18277-1-git-send-email-wellslutw@gmail.com>
 <1640331779-18277-3-git-send-email-wellslutw@gmail.com> <CAHp75Vd3iMM+NteJXP_mMAyw5momk3xzp1Y2GX-YJZfFSAwo9A@mail.gmail.com>
 <0f6a382cd66d4d5d84201da0a29145a3@sphcmbx02.sunplus.com.tw>
In-Reply-To: <0f6a382cd66d4d5d84201da0a29145a3@sphcmbx02.sunplus.com.tw>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 Jan 2022 20:42:55 +0200
Message-ID: <CAHp75VftFc8DNnrKp0dGsPvyzTrp+1z0_JP79Dzv5i0HMtsoUA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] pinctrl: Add driver for Sunplus SP7021
To:     =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Cc:     Wells Lu <wellslutw@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "dvorkin@tibbo.com" <dvorkin@tibbo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 8:16 PM Wells Lu =E5=91=82=E8=8A=B3=E9=A8=B0 <wells=
.lu@sunplus.com> wrote:
>
> Hi Andy,
>
> Could you please answer my questions in previous mail?
> I need your answers to proceed submission.
>
> Sorry, I am not sure if my previous mail is lost or you are busy.

Please, do not top-post! Also remove unrelated context, make your
message small enough and neat.

I have answered your questions.

--=20
With Best Regards,
Andy Shevchenko
