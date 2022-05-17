Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0499D52A4E5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348965AbiEQObt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348934AbiEQObo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:31:44 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FA52E9E8
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:31:41 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id m6so1452413ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/O66yZapi0BSSMqvuLDb5QljJcIprafeIHhXXNrM3HQ=;
        b=dPeUZnTqyPM8BGsOzR2Y+Vt6GWYdXlYfL5HGJ+hst8ZLbeLdCV6ulIEiqONwOKQcra
         TdpSy6uqP4eKoOYsGzQ82XN6kf8kNeNOt4h45xHODQi04EBKLRe3GQMdPGlL6GBCeZxX
         EddyM9xIYr6I+BLfuuv9u8reT0fIAFtJGV7+ja7H2ZE2syV/wgC2NHDjNIDGRY/hnwuD
         PY6/Q/WKOItv1ABnAyxYNLEFFIBOKCkcxT8jLoX0LEYxOp9mPgcxwdub5FuaocQ+m11O
         m7OD0Hu4p3qcZzvs4ErNx7rKHwLXAvNkSriouSucnP5hJKzgSjNpbARacbqJcth0dSOl
         6oNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/O66yZapi0BSSMqvuLDb5QljJcIprafeIHhXXNrM3HQ=;
        b=U6lkgbUBkJnE1CP27aHDgo/1e1lbjaynZxGfUI72pe5VDqGTRhTCYaGBdU14J11Ewv
         H7XTED9bJ1hLZ+f1r2UOaGJvvKI/9wbuUby1NXaaRzFyldc+YBw7PvPucQ/40qfA+WUR
         09KUPgo/vGGjRMIhyVanO0ADdrCoSCLK8gLDmn3ZSlRrxeeIRho6PiS6H4Y/CWVdPeT0
         Ck+BITwNTLE4NydhjVuWlr16o6cd7Wm9y6dqKxAsapnEFvm5/nAgrSnH2za54AYQrnPg
         m9UMrNjRZ7h9hdJqoNm2rBc6no3lyohBzgS6rrJYVYmQSlLKliGQJuYB0qBZ2zI02Cqr
         lqBA==
X-Gm-Message-State: AOAM532RVXn/t3ZXKwWjtEqNPplM+bDrsSikGoU5gS2W+iW+Fp7U/OXV
        TtINxy0byGxUy3rayDpacbSbGg==
X-Google-Smtp-Source: ABdhPJxxH/bRh33U48YhgwMI8fGJcxcks+r3F5hkC/o+Ksawa9rFxEQPN3vWjkiewjDkCSZZd5vnGA==
X-Received: by 2002:a2e:2a82:0:b0:253:b73f:fc31 with SMTP id q124-20020a2e2a82000000b00253b73ffc31mr2056434ljq.449.1652797900225;
        Tue, 17 May 2022 07:31:40 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q27-20020ac2511b000000b0047255d211a3sm1601359lfb.210.2022.05.17.07.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 07:31:39 -0700 (PDT)
Message-ID: <24965f6d-f146-0b44-481f-041a17256ee1@linaro.org>
Date:   Tue, 17 May 2022 16:31:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 5/6] dt-bindings: arm: mt8192-clock: Remove unnecessary
 'items'
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sboyd@kernel.org, chun-jie.chen@mediatek.com,
        rex-bc.chen@mediatek.com, wenst@chromium.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220517101514.21639-1-angelogioacchino.delregno@collabora.com>
 <20220517101514.21639-6-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220517101514.21639-6-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 12:15, AngeloGioacchino Del Regno wrote:
> There's no need for 'items' when there's only one item.
> 
> Fixes: 4a803990aeb1 ("dt-bindings: ARM: Mediatek: Add new document bindings of MT8192 clock")

The same - no bugs to fix here and this can be squashed.


Best regards,
Krzysztof
