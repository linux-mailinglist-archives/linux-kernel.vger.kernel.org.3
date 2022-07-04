Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1732C565E4B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 22:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiGDUPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 16:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiGDUPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 16:15:50 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8352711172;
        Mon,  4 Jul 2022 13:15:49 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id mf9so18445470ejb.0;
        Mon, 04 Jul 2022 13:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zq8nwhfZFDBdfn/duNmrPIOqKRSkTctWskb5xtCNo5k=;
        b=lCYbp2cPEbm8M2iIKtY0ggEUvS2rJzHwBa/0wSQYVhYeBf1fhd6mUilSUA0/2LET5q
         1IENQ9Fv1tojeq98CTDE0jAgrLlrWXh3SvlhiOt0fhAoIVB+hUVXbmuHUuWBsqHiEn+e
         3hWMcm9x0EzoWP45559L4HjbR/vMq2JWKHZEnLr53p+TFhrfk9zu7xZfa8aPO1qAHu7j
         c0kIdsrBhD9TC7YWcpxailb4bk9jWDkJ4ZbiVoZhVmPeNs3XknojiXBBMaYtHA56EYKD
         lZvehRDguR5CmZEqXVS0O1MEUpPg49dZflyNjqU8Gf1ECoquk4U3gCey+fOzruNp1Pqk
         07Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zq8nwhfZFDBdfn/duNmrPIOqKRSkTctWskb5xtCNo5k=;
        b=ZVrvD2q/bhGwtFPQ5riIs0arY5Uq8UMUR+1v+jw5Qn+RUlLY4TLEwjAwWWnSFGDt0d
         E7MwayAt4iuagfvi5mV1pctfw3tXzlz55yMgKDRLPEcq6AFmOwQoV0YLDFaZe0WjBlA2
         q4VThmo79gxy6R4ffpRboa9MeO+uGeaDTrFDcLtPJMgLOhSAine/kCtKcWukUljH8DfK
         svTZsq3oCjOFgYp8y4nGTp8w6/jzcWr08jSVqX0wHfSA913oKZvrTaGQMcHRgdk32dwM
         MAAt4yXzXXwidxFIQwI+6tNkBtD6sz42alxYYaY0Cp8coP1lCYPBNwQZXwHEn+kp8pPw
         rekg==
X-Gm-Message-State: AJIora+oUAxtJSqR9bEWgH57Ti65odMEyNyFPZl8sfkgvU93Lcu4Qwae
        Y7qvoV8Norqb4jDHeL9TQhM=
X-Google-Smtp-Source: AGRyM1tqc+U2aR3adyxagbWpNJk3jHnPtRzv+1Lv5ma/FMbfuO9AWx2uN37hw3RNVSGq2Y/qU5XXww==
X-Received: by 2002:a17:907:971b:b0:72a:b002:7c87 with SMTP id jg27-20020a170907971b00b0072ab0027c87mr12113195ejc.393.1656965748104;
        Mon, 04 Jul 2022 13:15:48 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id m11-20020a50ef0b000000b0043a6c9e50f4sm1917577eds.29.2022.07.04.13.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 13:15:47 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: Re: [PATCH] arm64: dts: allwinner: a64: orangepi-win: Fix LED node name
Date:   Mon, 04 Jul 2022 22:15:46 +0200
Message-ID: <3496901.R56niFO833@kista>
In-Reply-To: <21517512.EfDdHjke4D@jernej-laptop>
References: <20220702132816.46456-1-samuel@sholland.org> <21517512.EfDdHjke4D@jernej-laptop>
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

Dne sobota, 02. julij 2022 ob 21:03:14 CEST je Jernej =C5=A0krabec napisal(=
a):
> Dne sobota, 02. julij 2022 ob 15:28:15 CEST je Samuel Holland napisal(a):
> > "status" does not match any pattern in the gpio-leds binding. Rename the
> > node to the preferred pattern. This fixes a `make dtbs_check` error.
> >=20
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
>=20
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Applied, thanks!

Best regards,
Jernej


