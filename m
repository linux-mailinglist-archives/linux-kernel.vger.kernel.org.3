Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5275655A7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiGDMnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbiGDMnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:43:49 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD6EE0DD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:43:44 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id f39so15616927lfv.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=C5JrFNsrdURrynIRcNZ5G8lGyEvwaVaUcx1O/DPUMCE=;
        b=JjPXbMtWA9vv8tvadTWpTLKLbjayx2W7t+ABNkO1YA/UxRrfamtA/YmMlUg/w2z2js
         9udkArH5j8quI+j9Ql9xioaDARBfnPc0bEstZ2hMmTc2oviNnO5Soa1ce6lbmehPpKcV
         t4WXObEOkimkLSUmqXqbmbyKyK6P2OZtEQOIgV6zzzvvPWBdDPv31Ntw7RKeklOIfsLm
         Q6slfXgeFvKe6nV+Pnl1YdcRKqaI17NX3rM9akGSpDb4OIBJ8+9swkD2L5skjWRB8gfM
         7t6Lyaq4VaKxmGciBoLo6Ih+p7rJ0zUG6vjTd6FF+NUc89vbXdbsqvg4fdnCXXwha4Sp
         QuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C5JrFNsrdURrynIRcNZ5G8lGyEvwaVaUcx1O/DPUMCE=;
        b=5TzodummqqT9EqjYifoW1W63u0noAfyL8jFA1fJ9P3yUAthlWiCOcrbzJmw0X26B/a
         1oCzk22zdvUWOKshAjcS+KvBbZHnSi1m0lpnD9ieWnZo2Ck0OdYJKTvAq24pRmk3QnyZ
         wqn6GGC/D678TUN8QVfCxhJ+BEyXnMnIUxtjwRQCCYrc+DRzkNaisAcAYfcsL/nHzkz+
         QR1B1EKHttYKT0pCnaJ1rf/+JRFBD0GNuxpn0B/M8kh7IfPU0wJbEHZKiWYBRmA2GdPP
         KuaqQq3v2e7fK84FAAIYEFEpCBx6xAN1+ekXVeCspyKqj1I236v9nbWUoyzvDTlKm6I2
         qkdA==
X-Gm-Message-State: AJIora9Q0YgahWLpdz9pfHr6z/3/COA6tomV5u+FVePY08AY+JIrDjkR
        1Qre+YaPeZY1+S9AD7pDjCEAYg==
X-Google-Smtp-Source: AGRyM1vteyLrUKmrJEdE96gqsOwiHpBoFFKT52joX+DoYuA8q+pmgAV06t9T0wuyGgrz7nqwUaAwiw==
X-Received: by 2002:a19:4316:0:b0:481:484c:404c with SMTP id q22-20020a194316000000b00481484c404cmr16640237lfa.559.1656938622879;
        Mon, 04 Jul 2022 05:43:42 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id bj16-20020a2eaa90000000b0025d254180d7sm284672ljb.113.2022.07.04.05.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 05:43:42 -0700 (PDT)
Message-ID: <8c2e1b9e-9fbb-2593-912f-0893529748ed@linaro.org>
Date:   Mon, 4 Jul 2022 14:43:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 01/11] dt-bindings: arm: mediatek: Add MT8195 Cherry
 Tomato Chromebooks
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        hsinyi@chromium.org, nfraprado@collabora.com,
        allen-kh.cheng@mediatek.com, gtk3@inbox.ru, luca@z3ntu.xyz,
        sam.shih@mediatek.com, sean.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
References: <20220704101321.44835-1-angelogioacchino.delregno@collabora.com>
 <20220704101321.44835-2-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220704101321.44835-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2022 12:13, AngeloGioacchino Del Regno wrote:
> Document board compatibles for the MT8195 Cherry platform's
> Tomato Chromebooks, at the time of writing composed of four
> revisions (r1, r2, r3-r4).
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> 
> Note for Krzysztof:
> 
> I had to add the model number to the description in here, but I
> wasn't sure whether I should've kept your Reviewed-by tag or not.
> 
> Since I was in doubt, I decided to not keep it just to be on the safe side.

These were trivial changes, so keep the tag. Anyway no problem:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
