Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A1648EF8D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244041AbiANR4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244038AbiANR4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:56:07 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34638C061401;
        Fri, 14 Jan 2022 09:56:07 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id m1so32713766lfq.4;
        Fri, 14 Jan 2022 09:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=I8hcofcLYD+Zpm5J0maGDlJJKWipNGz/q/C4EW7Hvh8=;
        b=kp4cXZBX/aQFlQodYxApNBklNJKixR8jnBHVFEmL/B1DSfx9L5Smn/SSPket0SNZ/C
         Gu7K4ILGsEXn5F1G8a4B1tPKVG+lGoqfxyjdPDC+rIbcYJUDQgribnP4ulHeJEQ0Fe8Y
         0oWCvVwOGgSVCxGg8u1qC+52p0andGU1L4YaHYnEbltBgd2BXWtNJFQmatyz6M6veMOf
         RuAadUjG5TEhgLS4efBFvKSG5mTcYuPwaj9SXcOVla8XAZfjQz8heowzgiEftTe7iTYW
         iYJlio93NEVZ1I0Lyq4LM5d1ODkgG5Y6DbRcqZ/gr7Mjc1vMRUUdAUJUf/2n7pUBCM5g
         qSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=I8hcofcLYD+Zpm5J0maGDlJJKWipNGz/q/C4EW7Hvh8=;
        b=V2uc0YzM/24QcLqDIEuC0Kt+3OvKu8TiCw2yfYHWVfiLfoqw81+xFvwY4YT4WpHgST
         KJMROqSWNw+Y/ikM8ja72+ioOWBU3TaSBZCQc+DNbITLDgNTcoDVwYcpTw+T8Kfm6tta
         OWn2/2lI4XYUuQr9qOMmegr99LT0UYyPMQSWeW+1DotPLgvMeUvglmOAKKqB4MmK3Vai
         nmppcpRnZgz7CqwX7LzXPyw9Q7CGAKpKCk7vI3d8AJ7BleIZ6ZeQxLiLzrjSV8KHxoMT
         0o6AtI1GPCYTp8aUc8peuW0rGgCyAq8QeVByg5sRcsgsf7dqAlUQNT4zHHFJAOIiCxNZ
         9RNA==
X-Gm-Message-State: AOAM533/5MO/uNLyY6VwaLzaIgQAO2RePOAUdauEWCeBW9cJMuUPfomm
        6/KzN32irNwvymTo5ZVm67I=
X-Google-Smtp-Source: ABdhPJyTW+5UwoYjNipAZmvmCmGzRo7aTk2SYc+F3kvAVXytxsSgHRB1o8u7jRFQ6LpxtDWk5J5yiQ==
X-Received: by 2002:a2e:bba0:: with SMTP id y32mr7190379lje.24.1642182965558;
        Fri, 14 Jan 2022 09:56:05 -0800 (PST)
Received: from smtpclient.apple (31-178-191-245.dynamic.chello.pl. [31.178.191.245])
        by smtp.gmail.com with ESMTPSA id g26sm644542lfb.105.2022.01.14.09.56.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jan 2022 09:56:05 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: Enable the GPU on Quartz64
 Model A
From:   Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <d2d54776-b4ee-2cda-334d-f868a6bbdf8b@arm.com>
Date:   Fri, 14 Jan 2022 18:56:03 +0100
Cc:     Alex Bee <knaerzche@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-rockchip@lists.infradead.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <37D4623A-2DEA-4CA6-8DD8-1E3E88CBB250@gmail.com>
References: <20211126151729.1026566-1-knaerzche@gmail.com>
 <20211126151729.1026566-5-knaerzche@gmail.com>
 <EB2E04F1-BACA-4A4F-97F9-0257F29D57B5@gmail.com>
 <d2d54776-b4ee-2cda-334d-f868a6bbdf8b@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Wiadomo=C5=9B=C4=87 napisana przez Robin Murphy <robin.murphy@arm.com> =
w dniu 14.01.2022, o godz. 17:42:
>=20
>>=20
>=20
> 517 is EPROBE_DEFER, which implies it's waiting for the relevant clock =
provider to show up. I see from patch #2 that SCMI is involved, so I'd =
check that that's working and you have CONFIG_COMMON_CLOCK_SCMI enabled.
>=20
> Robin.

Robin,

Many thx!
Indeed issue was with SCMi CLK.
Now i see:

[    3.092350] panfrost fde60000.gpu: clock rate =3D 594000000
[    3.092906] panfrost fde60000.gpu: bus_clock rate =3D 500000000
[    3.138340] panfrost fde60000.gpu: clock rate =3D 594000000
[    3.138904] panfrost fde60000.gpu: bus_clock rate =3D 500000000
[    3.171244] panfrost fde60000.gpu: clock rate =3D 594000000
[    3.171888] panfrost fde60000.gpu: bus_clock rate =3D 500000000

good.

(unfortunately mesa 21.3.4 still goes with llvmpipe but this seems to be =
other issue i need to investigate)

thx again!



