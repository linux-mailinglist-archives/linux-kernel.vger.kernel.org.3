Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15584527815
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 16:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbiEOO2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 10:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237292AbiEOO1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 10:27:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C222A26D
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 07:27:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id tk15so753511ejc.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 07:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3lqX7aU3kAbTaAiZDHaxWxMC1d/fz3MRjO0exPuJ6f0=;
        b=KF4w++tVBm2Oj3AgycZ4VvGK/RwGTZhGeirZQ9CoWvCSOu7sua7rUOyqBrLo6fOV7o
         iabiG3qaoxkRqkjiuWSNBKvThJFoXyPFkq3Lt9DNYtEKi4/SgDCaxFmFYA2pZ0uxuBka
         yQdOUUuUKc+WTOwUba1k55rRffWpt00DkxQfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3lqX7aU3kAbTaAiZDHaxWxMC1d/fz3MRjO0exPuJ6f0=;
        b=5bmUWisy8alx3XRIFZbdP7V2ZmLFsVoIyo0cLTxyNubusMuTZIdC+w2ScCmBiQIAYk
         0HyknZDjNSeGrAWNb3fTy+AKMqfzAka+2mMey+hYGGv7qSaPNbN6i4Ufchd3xXhQkUSC
         k7p0WR5J8nQLlg9R0ZCMq2J2O7C8NdbGcv8UcLnEfW2ZXI+DIw9wvAe90k8rlgeMcwMY
         mummPdXXDbe/fJJ+43ipWodIAZepzCFCnXTN/TuVHQZAmgvteLjvgV2oJuGuWuFrhpom
         +u5OpnhyWvncn906z8PEFlK8fk4AE8jmCofkz/aSdFpi56yNTg62TVUzNX609Bu+Stf5
         MSYA==
X-Gm-Message-State: AOAM533bPUuM/RrpFSgHrdjXQ7xy634GfVEKTygqw2xggmAJW5APr2mL
        8MjZkRHciKPn5f15yvRfOIqBrg==
X-Google-Smtp-Source: ABdhPJxQNfPsnYCJnjzwmJFAODy9Mp4m3uKPr3Ccjujms9epEu+q1g0WgYEUpk/8EWbCWdoCxCHTRw==
X-Received: by 2002:a17:907:a0ca:b0:6f8:5bef:b9c with SMTP id hw10-20020a170907a0ca00b006f85bef0b9cmr11827478ejc.630.1652624828956;
        Sun, 15 May 2022 07:27:08 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-59-245.cust.vodafonedsl.it. [188.217.59.245])
        by smtp.gmail.com with ESMTPSA id ht7-20020a170907608700b006f3ef214dafsm2716329ejc.21.2022.05.15.07.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 07:27:08 -0700 (PDT)
Date:   Sun, 15 May 2022 16:27:06 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     evicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: px30 evb mini v11 20190507 camera issue ov5695
Message-ID: <20220515142706.GK649073@tom-ThinkPad-T14s-Gen-2i>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,
Sorry for the first mail, I send you twice because invalid I set an
invalid Subject.

I'm working on px30 mini evb v11 20190507, in particular on camera side. I
see your patch on dts to support ov5695 camera. Once I have enabled the
right config:

CONFIG_VIDEO_OV5695=y

I'm not able to probe the ov5695 camera correctly. In particular I got
the following error:

[    2.427936] ov5695 2-0036: Unexpected sensor id(000000), ret(-5)
[    2.438224] ov5695: probe of 2-0036 failed with error -5

Seem's that the camera is in reset, dumping bus 2 I got no address
from ov5695:

root@px30-evb:~# i2cdetect -y 2
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -

I'm missing something?

Thanks in advance.
Tommaso

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
