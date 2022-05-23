Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F844530F88
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbiEWK6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbiEWK5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:57:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50073286E7;
        Mon, 23 May 2022 03:57:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u27so19956707wru.8;
        Mon, 23 May 2022 03:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=BG7Id+lD+AQs0Pegzcqk1XktexibNQHiu13oHrpbb3M=;
        b=R6hjr4vVGrFUXLG1QDuRZ3HDw6zAcnC9oR0wGnabT+tDUhO0BdqFnTJVAfJeALzc/j
         ZHvPBQbbc4Z2heu9EjRjiZXXTt2cbdQEvBNNXqhGbkRwt+cQXmgMJ7/hG6fERNlGnlsx
         SS2a01naIC5RPByBPFfaZBefQZ05aAJEnL9pZTrp6Z4Befp2M+K16xQ9Mi6VSuTT9fdK
         iygWO3hIFNhbxo64OndbysVlNlMf6ZCpzspjLznSa+T4xhjplCz2L4299OArzxRkG4eL
         UvvCugiIKttC7KT9lis3g0TzGRPLKsqKA6coX3ZK9CRs9lxK0jJYJS1ZR+oOvro/05SR
         ZkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=BG7Id+lD+AQs0Pegzcqk1XktexibNQHiu13oHrpbb3M=;
        b=bghAPkaFy0OCRQ4M9rzTVymyIuxnZ5OqLBqMDnJ/Izvr3vm7SPePtrnaFJLEWwfwAg
         cDCvGolQ9RYccT9zj4yc2qcPTNddsCzn+HW7KEcPtizHj9EGxqk83JQWyl2NcpPXUAVi
         sePtP+gpWwimUM6lSKNq5k94nwk/ll7gc8Gjtb6xRuiWoxHEqmPZF5ajVpepxO8dJ+lC
         rfPAqbF5KUzSAcxpxWuqASQMGyFhqSnLi8bz0gbmHZERtNjf15w25WX6QUQkmF+wO+xi
         wBiKNhlLdUOhT0PkDIE01A6l8cS/KF3qkUxl4SlPbAHV8hV2xwdxQHK6iswkomlB015t
         oOYA==
X-Gm-Message-State: AOAM533DVUiB3dj7H6hHayVZwoESv5hk6MrkOFZHg5UMyW6JMa+smKa1
        c+OYoMeAtbZDR1NrySkCDyw=
X-Google-Smtp-Source: ABdhPJzcu/U7hQf2EKjkWxdjrxDDsZbj+4xkWy47utplrljg5CDn1H+9R4diFxBpCAClUAm6OUSYsQ==
X-Received: by 2002:a05:6000:24b:b0:20d:24e:a1ce with SMTP id m11-20020a056000024b00b0020d024ea1cemr10309067wrz.159.1653303449301;
        Mon, 23 May 2022 03:57:29 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p2-20020adfa202000000b0020adc114136sm11704389wra.0.2022.05.23.03.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 03:57:28 -0700 (PDT)
Message-ID: <652139e639c7e80795e01b3b4f88ba03b85d66c5.camel@gmail.com>
Subject: Re: [PATCH v10 03/21] drm/edid: Convert cea_sad helper struct to
 kernelDoc
From:   Matthias Brugger <matthias.bgg@gmail.com>
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Helge Deller <deller@gmx.de>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org
Date:   Mon, 23 May 2022 12:57:26 +0200
In-Reply-To: <20220523104758.29531-4-granquet@baylibre.com>
References: <20220523104758.29531-1-granquet@baylibre.com>
         <20220523104758.29531-4-granquet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-23 at 12:47 +0200, Guillaume Ranquet wrote:
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>=20

We need a commit message here.

> ---
> =C2=A0include/drm/drm_edid.h | 12 +++++++++---
> =C2=A01 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> index 144c495b99c4..37c420423625 100644
> --- a/include/drm/drm_edid.h
> +++ b/include/drm/drm_edid.h
> @@ -359,12 +359,18 @@ struct edid {
> =C2=A0
> =C2=A0#define EDID_PRODUCT_ID(e) ((e)->prod_code[0] | ((e)->prod_code[1]
> << 8))
> =C2=A0
> -/* Short Audio Descriptor */
> +/**
> + * struct cea_sad - Short Audio Descriptor.
> + * @format: See HDMI_AUDIO_CODING_TYPE_*.
> + * @channels: max number of channels - 1.
> + * @freq: See CEA_SAD_FREQ_*.
> + * @byte2: meaning depends on format.
> + */
> =C2=A0struct cea_sad {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 format;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 channels; /* max number of =
channels - 1 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 channels;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 freq;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 byte2; /* meaning depends o=
n format */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 byte2;
> =C2=A0};
> =C2=A0
> =C2=A0struct drm_encoder;

