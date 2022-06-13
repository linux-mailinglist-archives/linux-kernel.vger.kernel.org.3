Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BC654A10E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbiFMVOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351816AbiFMVNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:13:17 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7241942A1D;
        Mon, 13 Jun 2022 13:53:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bg6so13503084ejb.0;
        Mon, 13 Jun 2022 13:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0xKpA2CkarcNm8NsicwZmWQkXSJdlfuX89TYCY5IOVo=;
        b=oqcBeVuuOMRJM412U3KFCHQa2M87fcxpRnxTqck08gJQDouywpryfANrktU2bzTpFl
         fsd1PpSOY3yl1qhqTmYGgpebhL0fZQk5JejqxS4kHZJPGxXieBsaGZgWRYC8IkhYJqZh
         ueGwr+q0B7dEVqMyenU1G8A3iOt7yHSiRqN1gKyA6OySiWaxwsgiKg4xobRn2m2xgN9L
         PF1cdR1mlZyG0pNLiDxgUQHDpgxWuY1TcsM5HWYgAXIKM34kElxXrTKcOd94PT5IMdd5
         PXBxlmbyTMjE1mQOwAw3YJIKodTKz5uLmBLvnaVTXDoPzwJh3RnHoqVInxNL4eyJBJZd
         EgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0xKpA2CkarcNm8NsicwZmWQkXSJdlfuX89TYCY5IOVo=;
        b=zESkymhMT1LM2CixGurHFWZGGoIz5J1wmKIu95gEcytUcdPj6FrmcfZBihcb1MZ4Bw
         6bsbUDRx9aFjbCiJFg4Ow/mNvfdl3CvmsrYdwhar/xUoMbH7PBgOukX4ghMDWSD7dsQi
         QBumx4kBDa3YdozoFfX4ecu7CVofcjNjxOuEiQXN06gVXv9yGRCgCcE0t3Ub5HANBMqZ
         1lIx2HmvzLU2Npe5ChSKDAl+BJXnggiYUKZ1hjHRYq4x/Rn3OjyWcwLn+2Zal6FZP4kQ
         SJFAthFxJ3T3ujxj2C4ykX6TaiPjJuG8O1KeLXwU7+K4Wqg8HT9FeePpGzADNgZDl8Pg
         ByqA==
X-Gm-Message-State: AOAM533AvZCkzo3gMnREBQNeaR5BllSHoiou4LKIoE9iFRNcZVSAz6y0
        FAnN1D3YdVcgvWWfVHukdZSlOCYa93x23Q==
X-Google-Smtp-Source: ABdhPJwfkzRmgw0YzkxGU9voWfn/nUs7UdNN6/bLuU+oxejU3G6rzltetr68M0tPwtfEuI1tzCNTQw==
X-Received: by 2002:a17:906:a383:b0:6f5:132c:1a14 with SMTP id k3-20020a170906a38300b006f5132c1a14mr1410151ejz.21.1655153587911;
        Mon, 13 Jun 2022 13:53:07 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id gl6-20020a170906e0c600b006fec63e564bsm4224434ejb.30.2022.06.13.13.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:53:07 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: Re: [PATCH 1/2] ARM: dts: sunxi: Use constants for RTC clock indexes
Date:   Mon, 13 Jun 2022 22:53:06 +0200
Message-ID: <2632539.mvXUDI8C0e@kista>
In-Reply-To: <5831557.lOV4Wx5bFT@kista>
References: <20220607012438.18183-1-samuel@sholland.org> <5831557.lOV4Wx5bFT@kista>
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

Dne nedelja, 12. junij 2022 ob 22:45:47 CEST je Jernej =C5=A0krabec napisal=
(a):
> Dne torek, 07. junij 2022 ob 03:24:37 CEST je Samuel Holland napisal(a):
> > The binding header provides descriptive names for the RTC clock indexes,
> > since the indexes were arbitrarily chosen by the binding, not by the
> > hardware. Let's use the names, so the meaning is clearer.
> >=20
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
>=20
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Applied both, thanks!

Best regards,
Jernej



