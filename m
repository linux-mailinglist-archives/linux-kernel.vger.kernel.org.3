Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2495258DA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 02:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359712AbiEMAFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 20:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbiEMAFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 20:05:10 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9247F28B692;
        Thu, 12 May 2022 17:05:08 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j4so11780356lfh.8;
        Thu, 12 May 2022 17:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SlfhMbp5iyzTfChO69bAmUIAvfEyCMoB+tx0aPIA+Sg=;
        b=atGEAT27zERw+mbC5R/3f5L3+yFIjuuh2dVyXLejPQiu+z/ksELwDSnGDl+278jWo/
         55Yx9p33S3YChjtHQMq/squrzOYtlEeRQ70co9j0BkxvnOphGKXfNWwHWG1JvFw9VSzB
         eSkreu85IktJChhF8Ib5XMZY/wofyCiF/timcngk3L0nYSTR0E7E5wwfWRtfD99kN2eZ
         +OIn/+3ZXLtiZwqAreatcW5/elnXGmDm/U3Stcn+rsYAOZzPjrIRLo4xGXVImamVw4jT
         2VPuVcHYzjGY5//HSvBzma22A0yWow4AytVvz13W8yz4DvXC4ODhfbRPNa3pZMd57do7
         GZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SlfhMbp5iyzTfChO69bAmUIAvfEyCMoB+tx0aPIA+Sg=;
        b=yhbq9bxFUqdVtgltNzpz8CsiSdepOy25fXGldEjZMb5mklN9+2Rtp9Wn74TM8CRzu1
         +E5xcMQU2dVIAZD7EVNGfb+tzXZoyfIvOnHbZ4o761M8E194BXfSBtKVqPlasjEfzvnT
         gx97zld7Am/8vL+pq5QrBtYHVlKtzZNJziBuOu155HaZygFKzt0DUs9oGCboEi714n2S
         4bsqfYtrIeZ7y2T0AQvtEUvFJn0FspZyWGGLMWXHPVF53jHaO2r+3F4GiSjrm94wRFd+
         vC1mTlxHncpwzTpoAzewpnrmyMocrIf4j1NIe/gVQhcxo4Ln/PHrUUJFp9D5uE5oTmQm
         L5eA==
X-Gm-Message-State: AOAM531KG1Ia+CVjBJDjZY1A3A8k7RZVZSx4CZuckVDyjMb4Idgv0Dx3
        m1hSrjOTbQyEagWLWOlDmiU=
X-Google-Smtp-Source: ABdhPJxkQsnFzJWKlV6Dad4XHTMXRwx2sJrDc18zpKcoER5jRaiKliUc5P2eZ+28Zyq2zQgbKSH1GQ==
X-Received: by 2002:a19:ca0f:0:b0:474:40ca:af2 with SMTP id a15-20020a19ca0f000000b0047440ca0af2mr1560901lfg.320.1652400306859;
        Thu, 12 May 2022 17:05:06 -0700 (PDT)
Received: from [192.168.2.145] (109-252-137-244.dynamic.spd-mgts.ru. [109.252.137.244])
        by smtp.googlemail.com with ESMTPSA id u6-20020a2e8546000000b0024f3d1daeeesm155864ljj.118.2022.05.12.17.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 17:05:06 -0700 (PDT)
Message-ID: <8f5f9c62-3809-baa9-416a-7a0860e9add7@gmail.com>
Date:   Fri, 13 May 2022 03:05:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 3/3] iio: light: Add support for ltrf216a sensor
Content-Language: en-US
To:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com
References: <20220511094024.175994-1-shreeya.patel@collabora.com>
 <20220511094024.175994-4-shreeya.patel@collabora.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220511094024.175994-4-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

11.05.2022 12:40, Shreeya Patel пишет:
> +static int ltrf216a_get_lux(struct ltrf216a_data *data)
> +{
> +	int greendata, cleardata;
> +	u64 lux, div;
> +
> +	greendata = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);
> +	cleardata = ltrf216a_read_data(data, LTRF216A_CLEAR_DATA_0);

Could you please explain what is cleardata?
