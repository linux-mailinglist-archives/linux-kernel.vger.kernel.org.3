Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4E3565E3A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 22:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiGDUGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 16:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiGDUGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 16:06:02 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BD460C5;
        Mon,  4 Jul 2022 13:06:00 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id fi2so18292967ejb.9;
        Mon, 04 Jul 2022 13:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aZEfm8OgA9a8APggMVbXRa6KOD2e0raMcZC/Lo67ezY=;
        b=kDbYoPRMPnJY4F43ynxUS7bOlPI+9tgrMccJAY3tWYxFqE34Jix0e6P+69Q6ghduI7
         ummaw3aH8l/y6Zl0QWsC2XSbpnqh/LfNpOQ7L89WKeC5z2KALLCJAQJ+2wDlHEs10qby
         T48pmfvcFE73nQUnTa4USOEknxkxqqnbyPx0CA24XCbCgfSxyOlQNM6jm4c6VPbsriba
         tsG9fWKjgc1CCrTC2H9j/X+0b8zgVoBPQQlLKa43Vkr0d/E9vqvzQ+Y0suSWR9QuBSwV
         qROK2TjwLqqGQn/2PKZim11d9Gcqt5mzSHQrNbUr9mYdnS4lqvo20mSpnTkXb66WZ4vm
         zLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aZEfm8OgA9a8APggMVbXRa6KOD2e0raMcZC/Lo67ezY=;
        b=HFjUrmFdWQdO2jugKjzTpPwE+BMoyzpSMoSASo/QI8EvAuzxWusCNjtnlMlowkmCkZ
         /OHZI/GQnfLe7jP1v94kdHOQtZzYyoTt7e1zxPc9jtvkJXTazGtjuXug5rGzWHW/UuUc
         3I8LCR+wl2L24/pS8xZuK1tKRANlvy094hxmWgDO0H9kjyh+ei1QAyoygcOn45NNwxQc
         6rzoJXO9t/zuejaFiTUC/VhfYZsU41sA0auyfVX3BuGu0Pc5pWF0+71fHoNqk/q9QwIh
         YqGJn1IcwkqtfHpuWUrQBoUkwCeO8njkIAoqXRNmAUcaMSyooqzXft/xYNGzpYKa4InK
         rH3Q==
X-Gm-Message-State: AJIora9vJbNSXB/pnNuJk41ZIYDL1gXiIBpnLj7FZeGG5oeOca27RFQU
        EROq6H/MXLaGKqMwTPopygM=
X-Google-Smtp-Source: AGRyM1soYWQRElaa4bKg07yrmpQSLf+0z38tMffHvSF+UC5jmKc27NSdJAUqiu/Dt70DCxYeFU0dmQ==
X-Received: by 2002:a17:906:844a:b0:72a:392d:4c3 with SMTP id e10-20020a170906844a00b0072a392d04c3mr27765840ejy.379.1656965158956;
        Mon, 04 Jul 2022 13:05:58 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906500f00b00722dceb3f8bsm14686851ejj.151.2022.07.04.13.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 13:05:58 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: Re: [PATCH 1/2] clk: sunxi: Limit legacy clocks to 32-bit ARM
Date:   Mon, 04 Jul 2022 22:05:57 +0200
Message-ID: <4196041.ejJDZkT8p0@kista>
In-Reply-To: <8956393.CDJkKcVGEf@jernej-laptop>
References: <20220702190135.51744-1-samuel@sholland.org> <8956393.CDJkKcVGEf@jernej-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Dne sobota, 02. julij 2022 ob 21:09:18 CEST je Jernej =C5=A0krabec napisal(=
a):
> Dne sobota, 02. julij 2022 ob 21:01:34 CEST je Samuel Holland napisal(a):
> > The sunxi legacy clocks were never compatible with any 64-bit SoC,
> > so there is no point in building them as part of a 64-bit ARM kernel.
> > They make even less sense being built in to a 64-bit RISC-V kernel.
> >=20
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
>=20
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Applied both, thanks!
=20
Best regards,
Jernej


