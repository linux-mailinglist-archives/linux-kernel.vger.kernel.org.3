Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A4B57972F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbiGSKDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbiGSKCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:02:44 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ADB3ED6F;
        Tue, 19 Jul 2022 03:02:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b26so20831451wrc.2;
        Tue, 19 Jul 2022 03:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=HePNQfIxEzRcgJBnXtRCPMuQUpFRYVKZooSQivsw3sM=;
        b=gIVVJDQGEOSP/1DkYOPUl6lPSqcIcCGEPtoNi9otdLpkGHEbgN/9mPM0bUX1nNS23+
         pkKzCvI9H40r6c7YhhIkBK13jn6GUtghJdtrGmCB4/t9E+kIYX4/EpzoubL8DG8+7MtH
         0iPvJlW7LVkW5iIrkKlkS7UxrJ6S0FuDsMcTmpLmPST6Tbn/RQIxYARNIZ3Kixg4vIQF
         Os8PqTFzekmX5uaErJLxt6vNfHoSU03JwiZMvLsc+o0HfxRvgeEx4hPifJ0EbrWkQP3d
         e4+kiCziHUyxiSFniKDsysAbMtxGNPGBPyKOBsw8L6ilAAVyyZGTirFOtODUUOnMAR9G
         8ZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=HePNQfIxEzRcgJBnXtRCPMuQUpFRYVKZooSQivsw3sM=;
        b=2EkWIIETBvYfWtGCFDrfIzs7J8mA8rPPNv9Rh4h7tINa/PQtRHxnfiupuZldulnZZ3
         iVrby0YKrf40ioXoPOhGbkZJFkWFCdHt5Pgz5FKsrklRbLrL2lcCp4Etzog+5X+1VzfC
         JcR4SVWBVcegZG3j7mvN7/kQCiDyT9l7o7+/GX0Qk1VALyn1GZcik6IBlKrzWaFCmolh
         JW2xRQ4rAC1KqZgD52MO+59a+sFspY7AWEViR7BhDo78NnRenR9LxIASxaR8D8MavyS6
         q7JpvLo/l+mkuBSouKwrUmY+TCpJvwffZbZwbSBgIlES2Aq91TYh4fRjPPze/MFMVNZA
         oKgA==
X-Gm-Message-State: AJIora8pPDjI77ne0gVMLFGaahriFLv3Rcfqp+dz93N4QyauBzcwJOrj
        tEl5AKO9DWW4/XaIqQVjuB/96cJgMi0=
X-Google-Smtp-Source: AGRyM1tjeczl6PRZ70xvXDj4Cze/X8G4xzD7Qb1qkz8HEj1zdquWNqxQL/g5O6QP5UgfRFOiwFMaJw==
X-Received: by 2002:adf:c64c:0:b0:21a:7a3:54a4 with SMTP id u12-20020adfc64c000000b0021a07a354a4mr25838568wrg.163.1658224940429;
        Tue, 19 Jul 2022 03:02:20 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id v7-20020a7bcb47000000b003a32490c95dsm1291791wmj.35.2022.07.19.03.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 03:02:19 -0700 (PDT)
Message-ID: <62d6812b.1c69fb81.9ea82.2940@mx.google.com>
X-Google-Original-Message-ID: <YtZjf242zOdIKkPm@Ansuel-xps.>
Date:   Tue, 19 Jul 2022 09:55:43 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: qcom: ipq8064: reorganize node order and
 sort them
References: <20220718153815.29414-1-ansuelsmth@gmail.com>
 <7f2a4f21-5e07-9320-8f7b-573ccc562f43@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f2a4f21-5e07-9320-8f7b-573ccc562f43@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 11:56:20AM +0200, Krzysztof Kozlowski wrote:
> On 18/07/2022 17:38, Christian Marangi wrote:
> > Reorganize node order and sort them by address.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > 
> > This was picked from for-next qcom branch [1]. Reorganize dtsi as requested.
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/?h=for-next
> 
> If this is picked by qcom branch, no need to resend it.
> 
> I don't see value in such reshuffle. Reviewing is not possible and you
> did not mention tests (results should be equal).
> 
>

Bjorn asked me if I could send a patch to sort the dtsi since it was a
mess with the order. It's really just a node move with no implementation
change. Also no code deleted/added.

Don't know if I should split this or add other thing to this. Just
addressing a request from Bjorn.

> 
> Best regards,
> Krzysztof

-- 
	Ansuel
