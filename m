Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAAD55D20B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242394AbiF1AdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 20:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241604AbiF1AdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 20:33:19 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D800BF6E;
        Mon, 27 Jun 2022 17:33:18 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id o18so9651154plg.2;
        Mon, 27 Jun 2022 17:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ILcFMpZ8TChsc8dbgIsJy5/15HeyPjzmKmhPwi39Lcw=;
        b=Gtfez6APTy0b2WwpyhyPtNnqdK2yEAishsjbeXoSDui+KQDAT9Sd1EDoVGAkGGlDxi
         irQoiM26g38FLFeHA7iVIYs+TO2CjZfbVwBtmxw7gpQRPbcrpPZP/Fi3YgX722QTyl4d
         MJ4seMckx5L4VUz0NJenplLrcpkvoCXjz2qGSS+91AvpxmAqbFZxdPoAkmWyFglnxaca
         aIT7B/5KnFyvFScYvcoKkKYRYSz4A08bNDZZWaTriDujQ4yuOASiehKC5+juXgB725Ha
         LKlYPfk/39uFCcK6D2G0iXSdZmfHX6/TyRmQZeH0rWIs3+5gnbOLoJjskzdsfEOr9ypF
         dRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ILcFMpZ8TChsc8dbgIsJy5/15HeyPjzmKmhPwi39Lcw=;
        b=H5Kf5kWjeq3Vs6epENrGZeFCDzZVeeJiEtp5oJT+S+kFjrhQJZcJU+E3NdLfXW4iTr
         xm/EdIZBOazFtw9tOJEGIosou7bx3Wx1mgZLNaZtmcCd8oa1QIu6sDyKPu6baNFKfsr9
         96KrlhTy25tGgkI0mMrWfIOW7ANevZvFcgMnQzrVFO2fw0i2uz9ZxDnxdPV+0OFRG7S0
         8bdoyEUe9TCMoewOyU9Wbl4XE/lKTHo61TPAkCW5Id6HK/f6Srck7HO0Y+qCsZIJTeRo
         KM7mMl6CxNwv6CfrBTyz/YsDxD5gKw0agWn3v8svMDwx4YWfV0RlxynznUF82dQi1BUU
         5apw==
X-Gm-Message-State: AJIora/G31Vqji4g7GTxs3VL7dv93YgeKwf2sTf/ty7PQ1fskYUUFfui
        EPSaBRyOG5cuq8/arKuKbNEvVXIXNRU=
X-Google-Smtp-Source: AGRyM1vdoL1oBThtd9EHb8LghSUwYayC5QsqHUs+kMhAZfe935FJBZrdXCpjdDSWjqAjgEJ+PF6ZVg==
X-Received: by 2002:a17:903:2cb:b0:14f:4fb6:2fb0 with SMTP id s11-20020a17090302cb00b0014f4fb62fb0mr2107125plk.172.1656376397672;
        Mon, 27 Jun 2022 17:33:17 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-39.three.co.id. [116.206.12.39])
        by smtp.gmail.com with ESMTPSA id f72-20020a62384b000000b00525167c5ab5sm7912965pfa.81.2022.06.27.17.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 17:33:17 -0700 (PDT)
Message-ID: <6fec7316-6dd2-d457-7e47-33cc7c074c42@gmail.com>
Date:   Tue, 28 Jun 2022 07:33:13 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RESEND v2] leds: Add leds-qcom-lpg entry to documentation
 table of contents
Content-Language: en-US
To:     linux-doc@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Jonathan Corbet <corbet@lwn.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220612000125.9777-1-bagasdotme@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220612000125.9777-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 6/12/22 07:01, Bagas Sanjaya wrote:
> After merging linux-leds tree to the mainline [1], htmldocs build produces
> a new warning:
> 
> checking consistency... /home/bagas/repo/linux-stable/Documentation/leds/leds-qcom-lpg.rst: WARNING: document isn't included in any toctree
> 
> The warning above is because leds-qcom-lpg.rst is missing in the table of
> contents.
> 
> Add the missing entry.
> 

ping
