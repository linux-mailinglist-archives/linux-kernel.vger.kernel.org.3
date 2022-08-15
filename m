Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED03A5933C0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbiHORAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbiHORAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:00:50 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6621711C18;
        Mon, 15 Aug 2022 10:00:49 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id bx38so8174546ljb.10;
        Mon, 15 Aug 2022 10:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc;
        bh=SqgMO61HKo9LO3ZR8aj5lCUUOKdlsT1EAnLa0+nEyII=;
        b=HqrGB3waUaPwt3dbHwnXeNuvp64MFi2z7gFBM7uC6E00IFaxdSjoXBRAtAL7Fhbu7P
         UbKCSTmwXwkIbmZTMFveEwrS17UJKFAmQo5/AfMFKYrZCyAdzToW80FF/jo+i+MeHDYn
         jM8CQfzsQYHhOtb7DXpIoDdcWhom0YeoImgwSZH5sy8uhBMve8jZKlifYYVsM2lPqrGm
         IbrZGxkc4LAuNs2Cm1zv/A6GS8RR5qP7uo3U3jHbkgLqRTK4s9dWR7JT8z7tzsV27IQ+
         Htt7Puz1TMhnK+HtW/2/78vLOb2ZIXGYlmov72TBueMTVn5JVhVu8pDbLbxhQsZ89VIH
         jKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc;
        bh=SqgMO61HKo9LO3ZR8aj5lCUUOKdlsT1EAnLa0+nEyII=;
        b=6ln48VwZ3L7HuOclzIoy7YbDBGN3esQWI2hb/3B7bZ2Vgi2eeF+dyWGXKdqzBpbRoX
         RNP/bBuYtdijytsNLW4fhtx4qgUV+UQZcMclDWPmSp+X88Ike81ApFsL4dYCgPVUVUub
         izp1KUuMTMd4ylZfhiW4zCzrrPdxghPmehjVVlnEhMAZ/xCGgbbXEfkUR5kJSK6Me/Hh
         h+ADC4XCRqCWmZF0cISKZLmyAosJsBoRrVEayWY5xlm6KhWcnDjJ/44Q9X43SD2Z3/1p
         set9ThdhTmJIRw4mW9LcMxYhmvbDw/UjBQNb4UoW0lAWqjQ4xs0Oj1xTe6vC6Qp7s7OR
         9Cyg==
X-Gm-Message-State: ACgBeo17OAJzIY9TKp+W+rBLz+xN3BAUfTIc6VOSonfcCiqMZ3hut040
        8BQkLKjEIqXM7HeAi84nfb1T0FI+Lbo=
X-Google-Smtp-Source: AA6agR5+vnjUDUMm4sYZlKOzZknd6MiC7wdFA2gl0BVCnOf04hu87bgTEZ6uSrZ1YngMeA5ZVd+tzQ==
X-Received: by 2002:a2e:878b:0:b0:25e:c46f:12a3 with SMTP id n11-20020a2e878b000000b0025ec46f12a3mr4966094lji.466.1660582847612;
        Mon, 15 Aug 2022 10:00:47 -0700 (PDT)
Received: from razdolb (95-31-189-152.broadband.corbina.ru. [95.31.189.152])
        by smtp.gmail.com with ESMTPSA id x8-20020a19e008000000b0048afb8b8e53sm1148441lfg.80.2022.08.15.10.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 10:00:46 -0700 (PDT)
References: <20220712141925.678595-1-mike.rudenko@gmail.com>
User-agent: mu4e 1.7.27; emacs 28.1
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: Re: [PATCH 0/2] Add Omnivision OV4689 image sensor driver
Date:   Mon, 15 Aug 2022 19:59:14 +0300
In-reply-to: <20220712141925.678595-1-mike.rudenko@gmail.com>
Message-ID: <87zgg530ht.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping. Still waiting for any [2/2] review. Should I resend?


On 2022-07-12 at 17:19 +03, Mikhail Rudenko <mike.rudenko@gmail.com> wrote:
> Hello,
>
> this series implements support for Omnivision OV4689 image
> sensor. The Omnivision OV4689 is a high performance, 1/3-inch, 4
> megapixel image sensor. Ihis chip supports high frame rate speeds up
> to 90 fps at 2688x1520 resolution. It is programmable through an I2C
> interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
> connection.
>
> The driver is based on Rockchip BSP kernel [1]. It implements 4-lane CSI-2
> and single 2688x1520 @ 30 fps mode. The driver was tested on Rockchip
> 3399-based FriendlyElec NanoPi M4 board with MCAM400 camera module.
>
> While porting the driver, I stumbled upon two issues:
>
> (1) In the original driver, horizontal total size (HTS) was set to a
> value (2584) lower then the frame width (2688), resulting in negative
> hblank. In this driver, I increased HTS to 2688, but fps dropped from
> 29.88 to 28.73. What is the preferred way to handle this?
>
> (2) The original driver exposes analog gain range 0x0 - 0x7ff, but the
> gain is not linear across that range. Instead, it is piecewise linear
> (and discontinuous). 0x0-0xff register values result in 0x-2x gain,
> 0x100-0x1ff to 0x-4x, 0x300-0x3ff to 0x-8x, and 0x700-0x7ff to 0x-16x,
> with more linear segments in between. Rockchip's camera engine code
> chooses one of the above segments depenging on the desired gain
> value. The question is, how should we proceed keeping in mind
> libcamera use case? Should the whole 0x0-0x7ff be exposed as-is and
> libcamera will do the mapping, or the driver will do the mapping
> itself and expose some logical gain units not tied to the actual gain
> register value? Meanwhile, this driver conservatively exposes only
> 0x0-0xf8 gain register range.
>
> [1] https://github.com/rockchip-linux/kernel/blob/develop-4.19/drivers/media/i2c/ov4689.c
>
> Mikhail Rudenko (2):
>   media: dt-bindings: media: i2c: document OV4689 DT bindings
>   media: i2c: add support for ov4689
>
>  .../bindings/media/i2c/ovti,ov4689.yaml       | 122 +++
>  MAINTAINERS                                   |   8 +
>  drivers/media/i2c/Kconfig                     |  14 +
>  drivers/media/i2c/Makefile                    |   1 +
>  drivers/media/i2c/ov4689.c                    | 899 ++++++++++++++++++
>  5 files changed, 1044 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
>  create mode 100644 drivers/media/i2c/ov4689.c


--
Best regards,
Mikhail Rudenko
