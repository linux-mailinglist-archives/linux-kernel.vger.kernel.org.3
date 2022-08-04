Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F16758A29B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 22:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbiHDU6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 16:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiHDU6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 16:58:44 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0422A253;
        Thu,  4 Aug 2022 13:58:43 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t22so779070lfg.1;
        Thu, 04 Aug 2022 13:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=HHRxra4X537rFoFLJVgbKCdXy3OgEpyBQ3xZYMyvpjQ=;
        b=RmYddp5MQJnZzXnr8V2AYL6D/FVJBs0IagfHmjm/yzhO1l9jSKd4IFV2QMdxuCeSLy
         Wct5aoV58PnZVzkpPjTA9+I/s3kzdtD8V/izMHLlSJeI1DiCI6pZCoyd0GIeQ9cbGFIO
         UyuizjsIA9ysCGBiJTdxuuAughj61pBJFqEmFnAzR7OKmuQ/k5mUNXSx8muv1MHEc6a+
         zUWRuz67D3GXvFo1aYvPMu0WoyVd/WP9OKd4lx8HSLKE6wPraRYX/jqg3dCxH9lHyvFJ
         6O/1r+vG7EhyfjJgjOvqmw1JCz/9QfYp6oT7JOCs9fU0bR0jgL/GT0eTZwcvKDbaMAmX
         EF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=HHRxra4X537rFoFLJVgbKCdXy3OgEpyBQ3xZYMyvpjQ=;
        b=3Rvts7jxHQUE4lpbGJ3UiRLmpHJHa2dpA9t2F9ydhDhJCwWn3xcv3mRMJbl1VGVrHY
         +dASQmocYdzarWjhBjxFnkQMD7+13Go79F2+hTaEP8Gg0Ezat829yjdOpW5hyQib+kmI
         +g3eAAAHyCNdofUEhORjsR3JEZjBb1WYIGyrwoevzjt9RHSo5zqrjLtThmY8seQUMfDF
         zJVWMqyhOSpDA0CaSFpDlpNghCER2Q8fSBeoxjCcKApwDbFPvmEW99vaW4JyyxWcHCBo
         Lu0cfITSXUz1PW6dufNnV9o35HQi6YxSNucKZPNGBOkrpL02WtLUAoJRq1pN4ROtjW2q
         WIAg==
X-Gm-Message-State: ACgBeo2PgabxHeq6GtWPPrfFLp4H2xPyYsignxpgt6Ei3a+dzEJzhxZ1
        +fjeK1oDppllELnGwiU11zY=
X-Google-Smtp-Source: AA6agR5EKgutuExmcrsuCmY+FSTABsMDT5T5D217XKizNZ3lCL5+bACCWYACNuHci4qxuT3uksCwRw==
X-Received: by 2002:a05:6512:2806:b0:48a:f74d:da0e with SMTP id cf6-20020a056512280600b0048af74dda0emr1415679lfb.477.1659646721622;
        Thu, 04 Aug 2022 13:58:41 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru. [109.252.119.232])
        by smtp.googlemail.com with ESMTPSA id s9-20020ac24649000000b0048a9e899693sm238517lfo.16.2022.08.04.13.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 13:58:40 -0700 (PDT)
Message-ID: <1355f1f6-d6c9-6d5f-9b5f-333084c6561b@gmail.com>
Date:   Thu, 4 Aug 2022 23:58:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC] PM: domains: Reverse the order of performance and enabling
 ops
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
References: <20220720110246.762939-1-abel.vesa@linaro.org>
 <CAPDyKFoh8UV=QC6RhOkc=FSvoeqF_UiWp97h0Qp8dniB=sS+8A@mail.gmail.com>
 <YuA0luCtQ1J+ExBi@linaro.org>
 <CAPDyKFo4tryzYQK=q6aPGxocmoq=duC2B1RMh1QoV_maVCApjA@mail.gmail.com>
 <20220729094646.xqlhfjzxo3gk4n27@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220729094646.xqlhfjzxo3gk4n27@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

29.07.2022 12:46, Abel Vesa пишет:
>> I have looped in Dmitry and Thierry to see if they think the change
>> should be fine for Tegra platforms too.
>>
> Good. But the tegra usecase uses only the ->set_performance and does not
> use ->power_on and ->power_off for that specific PD. So I don't think
> their usecase will be affected by the order reverse.
> 

For Tegra it indeed shouldn't change anything.
