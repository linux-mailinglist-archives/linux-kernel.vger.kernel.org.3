Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA464C64AB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 09:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiB1IQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 03:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbiB1IQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 03:16:06 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1EC6A07D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 00:15:16 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r10so14070883wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 00:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BFT085Aa31HeFs5LB4HrIpa0aRd98Ram1JsH0G2Zlh8=;
        b=zvaVLKC4SymPnaezNsk+ymnzitO/ojJEuWRG4kOW4BgI4E9mb5pYWu06uob9YLwJyg
         YiM9Z5/MCStj0zqOycbwsZYF6CS83RxeB5f/CohZZjfGhjRJWC/Qm0pKPcNmWiqDIxCE
         ZdqGL9esM1QqkprAOl4+aSUEXJxgtJgHZL9v+tiQ8ZgdTkiL1vt0fIGoKu+JkdgKr3P8
         XX2GEUeTywMeF1B+I8fAft5X0KEx+bDej1np+M8g0Xbg3J0XIBIX+Unohvke41GvQw+z
         J+6zWRW2QtlmS0i86MOin3GQqpo/iAL89Wg/XbU/Ymo+m1NAc0rs17IxQG6+wfGNAW+h
         FXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BFT085Aa31HeFs5LB4HrIpa0aRd98Ram1JsH0G2Zlh8=;
        b=Aonn3ZPByhVGuthxYNlzqwtbbJ3vx7eWplkLkd/SaXVuRTavbVlaFGP7+Q/EQsD7h3
         UIIltoAbS6neynEg3sqsAsotRIl/vJIONrBAAxFCGJ5mwnh2i3Owp5sUw25GjoThaoc8
         +qrjWJGVMjyDziUUT+ONyPYPUEigdi8stOg+Bra188HTdmBPMwhrBJDZVQy6Ws8bOPOj
         ucpzbjLxPmyB360qhJNXQypyMOzo4TnjvjFQFkHOlHppCL41AwBgA2gnjU+DPyXRQw28
         PpU8KNqyuyhWViYmrTUXEe8ZlSd98qxNeHBL0hipQXihSwce3QtEQC34aTDZh5F3zDOa
         2CRg==
X-Gm-Message-State: AOAM531b5TgA7lQfSTpgKE/x4oc9mmN0YC3fmnxmZLbrnsoLHNQbNAiI
        KMP1/Sr9CQiDmShoXAZQ7Qi+mQ==
X-Google-Smtp-Source: ABdhPJzq5Tpnssuni66DwnEVMQoqTOwrUR+RUINHPg/1US+4UzCRXmrEya8nFf9j0OjDgbpYTs6zOA==
X-Received: by 2002:adf:912f:0:b0:1e3:909:a6b6 with SMTP id j44-20020adf912f000000b001e30909a6b6mr15003391wrj.684.1646036108352;
        Mon, 28 Feb 2022 00:15:08 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d4a4c000000b001e68ba61747sm9882590wrs.16.2022.02.28.00.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 00:15:07 -0800 (PST)
Date:   Mon, 28 Feb 2022 08:15:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Claudiu.Beznea@microchip.com
Cc:     groeck@google.com, shraash@google.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        Ludovic.Desroches@microchip.com, groeck@chromium.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mfd: Avoid unused variable 'atmel_flexcom_pm_ops' warning
Message-ID: <YhyEikHqphURkOeE@google.com>
References: <20220225101520.3188373-1-shraash@google.com>
 <CABXOdTcMj_=XqTnTiUmT8r585W2N2-12ddg4OGDHpwaiTp-Tjw@mail.gmail.com>
 <e13337ff-508c-ff69-1ba2-70ca2b503b6e@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e13337ff-508c-ff69-1ba2-70ca2b503b6e@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022, Claudiu.Beznea@microchip.com wrote:

> On 25.02.2022 21:00, Guenter Roeck wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Fri, Feb 25, 2022 at 2:15 AM Aashish Sharma <shraash@google.com> wrote:
> >>
> >> Fix this kernel test robot warning:
> >>
> >> drivers/mfd/atmel-flexcom.c:108:32: warning: unused
> >> variable 'atmel_flexcom_pm_ops' [-Wunused-const-variable]
> >>
> >> The variable atmel_flexcom_pm_ops is unused when CONFIG_PM
> >> is not selected, so marking it as __maybe_unsed.
> >>
> >> Signed-off-by: Aashish Sharma <shraash@google.com>
> > 
> > Reviewed-by: Guenter Roeck <groeck@google.com>
> 
> There is already [1] posted a while ago...
> 
> [1] https://lkml.org/lkml/2021/12/7/474

Lost in the ether!

If this happens again, please resubmit a [RESEND].

Applied now though, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
