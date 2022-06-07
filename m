Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDD253F9F7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238775AbiFGJhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239767AbiFGJhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:37:17 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1822C5;
        Tue,  7 Jun 2022 02:37:10 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d22so14348098plr.9;
        Tue, 07 Jun 2022 02:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gxs0+aWvYM3LWxC7EUUZ0v49Q04+LWa6qfJ61uUqW8g=;
        b=itMtcieRDU81frhTBFtGjbAXgvv62YzbLl8XRi7v/gXGpy/tIM3BYjMKK5ECQAfPOB
         03sfW6r2inxS0tC9t3Wd4oKlafJW5M8VyVTCvYWhod8n9gfgXGYVl9s5pPVMbQL4DBga
         0P385VzeZYDMhyCAnwfSEL2Bbsvd4ONTAuvIQadPIQzTToZJhmKSdNMJpM9A0r2SRd5b
         T2EKmwPlNaetQrQ1WTfXGWXiTrO0SGXherfMFEzyZ/TjQAcchxEynd2Q8OyjN5isFrxz
         imO6VmrkTIwFvVIMsytoqp64ejZOj6LQ512hzOFbBh4c1ODe2iGYwqNLa3LqzBtT1Oys
         l1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gxs0+aWvYM3LWxC7EUUZ0v49Q04+LWa6qfJ61uUqW8g=;
        b=f9NvTc5GVf/CXvSi6pIr12gGpDLqHJw0d4XXm6793L24amxcW5WjIopKamomt/OsPW
         s6Pz8LExlZI+EhSzcI4yqrhjts3BITZWwm9icEiJU7kjp5uXO8GzTjvTQTKW2dNnbKKm
         CVX+XP6sSx93zRxM0UTx5o4V54n4wJsehUd9ddrn7d1UgSsp1gQHf2epUG/3SaxsFjj7
         YXwCOLh0suarzvVe/JEa0Ato+Q1Kw3br/wiXIzseWfrFtVXTpyA2gzoYF0jeFVBi/zDi
         f8kQ+IUrVuJT5Ft7cC6hqEVuTLUTmSBILjreAlD9XKizG4aX6Ti1dlj8/f6hP0uV6ABa
         jXLw==
X-Gm-Message-State: AOAM532m4rgEEKfz1MH6UDBaZr7VODHPGoqcO7+tv2mDd+/5Le/yMWxK
        oFN6V9FfL/KmKIMSpnZ0A85kGZ3eONg=
X-Google-Smtp-Source: ABdhPJxraJAaBzAWGKH5jd/RrR8C7QJhzYi9X0l8/MFx2nfDP7LAo4FI4dWrWi/EW0pd0RtCLb81VA==
X-Received: by 2002:a17:90b:503:b0:1e2:f129:5135 with SMTP id r3-20020a17090b050300b001e2f1295135mr31179593pjz.22.1654594630407;
        Tue, 07 Jun 2022 02:37:10 -0700 (PDT)
Received: from localhost (subs28-116-206-12-32.three.co.id. [116.206.12.32])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902ab8600b0015e8d4eb25fsm11971380plr.169.2022.06.07.02.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:37:09 -0700 (PDT)
Date:   Tue, 7 Jun 2022 16:37:07 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: linux-next: build warnings after merge of the hwmon-staging tree
Message-ID: <Yp8cQ1BcDXuZ9Cv4@debian.me>
References: <20220607141958.1e31971d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220607141958.1e31971d@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 02:19:58PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the hwmon-staging tree, today's linux-next build (htmldocs)
> produced these warnings:
> 
> Documentation/hwmon/lt7182s.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> Documentation/hwmon/lt7182s.rst:75: WARNING: Malformed table.
> Text in column margin in table line 33.
> 
> ======================  ====================================
> curr[1-2]_label         "iin[12]"
> curr[1-2]_input         Measured input current
> curr[1-2]_max           Maximum input current
> curr[1-2]_max_alarm     Current high alarm
> 
> curr[3-4]_label         "iout[1-2]"
> curr[3-4]_input         Measured output current
> curr[3-4]_highest       Highest measured output current
> curr[3-4]_max           Maximum output current
> curr[3-4]_max_alarm     Output current high alarm
> 
> in[1-2]_label           "vin[12]"
> in[1-2]_input           Measured input voltage
> in[1-2]_highest         Highest measured input voltage
> in[1-2]_crit            Critical maximum input voltage
> in[1-2]_crit_alarm      Input voltage critical high alarm
> in[1-2]_min             Minimum input voltage
> in[1-2]_min_alarm       Input voltage low alarm
> in[1-2]_rated_min       Rated minimum input voltage
> in[1-2]_rated_max       Rated maximum input voltage
> in1_reset_history       Write to reset history for all attributes
> 
> in[3-5]_label           "vmon[1-3]"
> in[3-5]_input           Measured voltage on ITH1/ITH2/EXTVCC pins
>                         Only available if enabled with MFR_ADC_CONTROL_LT7182S
>                         command.
> 
> in[3-4|6-7]_label       "vout[1-2]"
> in[3-4|6-7]_input       Measured output voltage
> in[3-4|6-7]_highest     Highest measured output voltage
> in[3-4|6-7]_lcrit       Critical minimum output voltage
> in[3-4|6-7]_lcrit_alarm Output voltage critical low alarm
> in[3-4|6-7]_min         Minimum output voltage
> in[3-4|6-7]_max_alarm   Output voltage low alarm
> in[3-4|6-7]_max         Maximum output voltage
> in[3-4|6-7]_max_alarm   Output voltage high alarm
> in[3-4|6-7]_crit        Critical maximum output voltage
> in[3-4|6-7]_crit_alarm  Output voltage critical high alarm
> 
> power[1-2]_label        "pout[1-2]"
> power[1-2]_input        Measured output power
> 
> temp1_input             Measured temperature
> temp1_crit              Critical high temperature
> temp1_crit_alarm        Chip temperature critical high alarm
> temp1_max               Maximum temperature
> temp1_max_alarm         Chip temperature high alarm
> ======================  ====================================
> 
> Introduced by commit
> 
>   3d6bcaa21fbd ("hwmon: (pmbus) Add support for Analog Devices LT7182S")
> 

Hi Stephen,

The warning above doesn't appear when doing htmldocs build using Sphinx
installed from pip on my system.

Cc-ing linux-doc list.

-- 
An old man doll... just what I always wanted! - Clara
