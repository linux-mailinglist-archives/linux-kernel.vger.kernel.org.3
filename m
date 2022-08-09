Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FE958D17E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 02:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244773AbiHIAxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 20:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbiHIAxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 20:53:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999FC186D2;
        Mon,  8 Aug 2022 17:53:30 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id e13so13247398edj.12;
        Mon, 08 Aug 2022 17:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc;
        bh=XvyFwW8Ho60oSZew5uOeBihtI9BfP1sOrcezBlDDeak=;
        b=FHz67+toURTh0Yb7HzDZsHG/8r/QpytqYb81DRGPQ2LKOapSzVsx3mOi+drwD0xM1n
         lKouoiEbLATMokRYfoIGu7hq0NKsdEmQ+6mSyXoq5z16lkjs1z1K/edLL195z6TkPeL/
         Y4BAxcClmkrnzTa9GKaJ2AfFOpeowPDaOVsQsXXj0S/XhXMO50kveGTaCXB1sdLlYXFt
         5+qrxMcEgkYmy7XwpuzBsp/EMIe42FoyMs0OnTS+9vb9AhwwI4ILUVX/O2rB/1wUlhfl
         Tg67MdR6zN7sXKe3CsRefnMkWhVNTSpb1yibneiIkE8G9KLN4OSFVNfJMOAUvJCtB433
         ccpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=XvyFwW8Ho60oSZew5uOeBihtI9BfP1sOrcezBlDDeak=;
        b=diriGKsqVzvVucM4x5L8FdySVoXAQxXSgG8nRxbz9bM/dC+MjaO2BDyEtArzw3YtNS
         Nt518oa/FcYR4La8LdGWAlOSj/09mH9x1D/fWlkqz2vNGwtq4efgewp3f0bf0kR7ZwNY
         AEaebH0yiZiQuOUyccJyNDxFWePtIp7H4C/ifPAM+NMZ+T5P9KIC1KkIJamYK3xJmDF4
         n8okrP4VHeZQxOe/2/UgCFW9jc0ehVDiGahLolthaqtdwo0P+Pj6rJAkE4VQ81TH3Q3q
         qQiCZbhaDcC3Ne7NKdIQ1tZWdOVtnGJEHGTLd1ZPSlcqW6hnTxF0xtF/jziU9Hb0MJ0W
         8mMw==
X-Gm-Message-State: ACgBeo0FabPObJs1J6QvO7fTQR/ofp55B2n66g6sMho/HkXf7U7Uqp29
        /9zm0sHJ1OihWd1qWXn0c6A=
X-Google-Smtp-Source: AA6agR6zpoOnCSipuQNy365yK44T2T67w/iZRbUIxiPeDhazTpbtt/k1Hg/MPlnC8AgmV2cIgFRStg==
X-Received: by 2002:a05:6402:40ce:b0:43d:f8a0:9c4f with SMTP id z14-20020a05640240ce00b0043df8a09c4fmr19970504edb.95.1660006409086;
        Mon, 08 Aug 2022 17:53:29 -0700 (PDT)
Received: from [10.21.0.9] ([37.120.217.82])
        by smtp.gmail.com with ESMTPSA id d23-20020a05640208d700b0043a7134b381sm5176218edz.11.2022.08.08.17.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 17:53:28 -0700 (PDT)
Message-ID: <86b63b7b-afda-d7f4-7bfa-175085d5a8ef@gmail.com>
Date:   Tue, 9 Aug 2022 02:53:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
To:     jaschultzms@gmail.com
Cc:     benjamin.tissoires@redhat.com, biju.das.jz@bp.renesas.com,
        bjorn.andersson@linaro.org, catalin.marinas@arm.com,
        corbet@lwn.net, devicetree@vger.kernel.org, dmanti@microsoft.com,
        dmitry.baryshkov@linaro.org, dmitry.torokhov@gmail.com,
        geert+renesas@glider.be, jaschultz@microsoft.com, jikos@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel.ziswiler@toradex.com, robh+dt@kernel.org,
        shawnguo@kernel.org, vkoul@kernel.org, will@kernel.org
References: <20220707165902.3184-1-jaschultzMS@gmail.com>
Subject: Re: [PATCH v5 0/6] Add spi-hid, transport for HID over SPI bus
Content-Language: en-US
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20220707165902.3184-1-jaschultzMS@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/22 09:58, Jarrett Schultz <jaschultzms@gmail.com> wrote:
> Surface Duo devices use a touch digitizer that communicates to the main
> SoC via SPI and presents itself as a HID device. This patch's goal is to
> add the spi-hid transport driver to drivers/hid. The driver follows the
> publically available HID Over SPI Protocol Specification version 1.0.

As far as I can tell based on the downstream code you provide in [1],
your proposed driver (and v1.0 spec) is incompatible with the version
used on current Surface devices (Surface Duo 1 and 2, Surface Pro X, and
I assume some AMD/x86 based devices on which you also use spi-hid for the
digitizer). On those, SPI_HID_SUPPORTED_VERSION is 0x0100 whereas it is
0x0300 for the driver proposed here, along with at least some protocol
struct changes.

Do you have any plans on supporting those devices (i.e. protocol version
0x0100) at some point?

Regards,
Max

[1]: https://github.com/microsoft/surface-duo-oss-kernel.msm-5..4/tree/surfaceduo2/11/2022.108.8/drivers/hid/spi-hid
