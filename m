Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A629A53F180
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiFFVSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiFFVSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:18:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BEABA996;
        Mon,  6 Jun 2022 14:18:47 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q26so11094775wra.1;
        Mon, 06 Jun 2022 14:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b90hW8drEyy5YYKt22ECTDBgbLU7QvF4PUTDrepHozg=;
        b=EviXLTC+O0326MiB+E0EQ4e2BWONx/XIdbjQNzoIDhKJM/Uej5bJMJ4EaZ0hviASdA
         PwDpvTuFrmHBJRTsacj6WByLrRcJ4ihseBuzy0eqju2mgloCjodOSh7N4DgVx6uowQ5l
         W8fTB8GVLm9Xrlf9KvDsDR0zjVeEjBNLWqRH55r/GM/rdlkr75PkLh2+IJ/fm2h5nBuP
         exTBMIp+T+Z1U4kFfmZ2b78SvMKaXwmSsNH6dXJo8xYP7drb/ee5/FJDzz58QUlkPGfF
         1iYfAH+cKi0AW+ds6O+vgmKyP+kAuzQBubDK0k/4QmUeANxfKAgLM1Mvm+P7VWhW/e0J
         TYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b90hW8drEyy5YYKt22ECTDBgbLU7QvF4PUTDrepHozg=;
        b=v6ArNpSeQcRPm/kIyi6LKUwlEcSF3pvaT0xeEtizCnYkmHgs2etmeiToQDe//7Ckai
         ZfT2pEYLriXWFvf9JJjeVE737mtaWo4p+HHEY9v7RaxqZfs3MmiwaJW65RLusHTEQxL2
         Mp2omncfBNXwbXXKnV03EsnaxBTSzWkSOrUD+oHZ7kZ87RXOqG44DCapfmFIpi1tx3NA
         6woBN7kdsBPvsckVEDS85ApdqyIn6qPx0PVkG1A0aPQJZmqIbk+IjiCJjgYQd9yhda98
         lSncwvyZJXszNzCpjIgLLhymts2Ins7kdIqWgs/YaVMKW1eeUGJxB4ZSc8gY/i3+sXWk
         HvWQ==
X-Gm-Message-State: AOAM531E1pj1axwXSEHOSHrRHFyRLFfRhGUO9KI0YDR6ZY0EU9FNrqty
        smE6nRwtWQnP0iHd5eSf3/8=
X-Google-Smtp-Source: ABdhPJzKxihbpGpcKekDPf0iLWBTi+acGwFgbpc62pRVAYpGNuctw/Z5+1aY2B1Iy2Td94WthY69VA==
X-Received: by 2002:adf:a3d3:0:b0:213:baff:7654 with SMTP id m19-20020adfa3d3000000b00213baff7654mr19011995wrb.158.1654550325795;
        Mon, 06 Jun 2022 14:18:45 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id l9-20020a7bc349000000b0039746638d6esm18144278wmj.33.2022.06.06.14.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:18:45 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: Re: [PATCH] ARM: dts: sun5i: adjust whitespace around '='
Date:   Mon, 06 Jun 2022 23:18:44 +0200
Message-ID: <5572060.DvuYhMxLoT@kista>
In-Reply-To: <1893171.PYKUYFuaPT@kista>
References: <20220526203547.830848-1-krzysztof.kozlowski@linaro.org> <1893171.PYKUYFuaPT@kista>
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

Dne =C4=8Detrtek, 26. maj 2022 ob 22:47:30 CEST je Jernej =C5=A0krabec napi=
sal(a):
> Dne =C4=8Detrtek, 26. maj 2022 ob 22:35:46 CEST je Krzysztof Kozlowski=20
napisal(a):
> > Fix whitespace coding style: use single space instead of tabs or
> > multiple spaces around '=3D' sign in property assignment.  No functional
> > changes (same DTB).
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Applied, thanks!

Best regards,
Jernej


