Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD3B5882F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 22:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbiHBUKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 16:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbiHBUKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 16:10:41 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA5AFD39
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 13:10:40 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id h12so16788378ljg.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 13:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=CixUSBcZNq9i0WpR8GtdvttXmNXU/G94pZeb65hTEM0=;
        b=WyNxtYqk3qeNX2OkEahMvbK034jsOfS/qAlqgpXcbok6ytj9bMkyg7zn1hiX32tp+/
         OEVHYAeSEdlMmm7Sc6SbDiw7Mx9W1vaadsB4Xkk/WBkl2toPvBPIHlr7yGzeFohoua9s
         dLAK1biH6/qLzRReNqLfwDG/bZnlOSo70OtmxpvLAoHfCyrlv6ycBip2qW/PYgBsxN1o
         jbkkIjkImEBZ8wQkzDMZdPt67/kUDDu7twHPSTzIhgHP+v+a8/ujqcNZZ++psR7/4hPh
         occvRR2zXeSz/WK65qdff/r4nsCevELyHFnBXmFme4DtRavFn/LwK+ImehnrnaZxbfs9
         hDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=CixUSBcZNq9i0WpR8GtdvttXmNXU/G94pZeb65hTEM0=;
        b=4K++eI5YdVLDi1Ddot/MVzo600XYgyNPeldeWcLHrHzI7+Ar5hxOYDsay36PtCN0pG
         lTkNFLa/US1V42JtCxPXntfelZy64hgFrY3bkTYE21yV9tBCd6rzdNXGJMmwPd0eToJo
         +0vCbQ1TBVZEyra6o6RMWUJgtblSxN6OrnAkCJFm0TkORrcgS+ssVuobZWJvapxZVYVG
         pmQXzFPwNg1sI3cEP8kexiqa0eO+/aD0Tagd8SUiJs/O0ozZKgVmZVRkxwyIyu2aw/Ol
         Rgxl1Qp1CDHimrgMJAInNcL+G/Z+7/SLRPiK0K+pU3JlZ5UJwCtsvkgVyDMHdf25pKqF
         WWJg==
X-Gm-Message-State: AJIora9bAu4wlATE+nBr3pk33HG71gpmCruquWzEE7wXnjbNTuWtsH5P
        POSE69ka7efn7s9bqdzG0GY=
X-Google-Smtp-Source: AGRyM1t1sO0Omp3yxQjOR809RdRPIRBJhuRvsggT+FA6u4dXikm/vOHoeh7Yy9QJQO8lUgJaMi1KfQ==
X-Received: by 2002:a05:651c:11c5:b0:25e:22c9:19e1 with SMTP id z5-20020a05651c11c500b0025e22c919e1mr6791233ljo.428.1659471038665;
        Tue, 02 Aug 2022 13:10:38 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.227.117])
        by smtp.gmail.com with ESMTPSA id o18-20020ac24352000000b0048af397c827sm1161237lfl.218.2022.08.02.13.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 13:10:28 -0700 (PDT)
Message-ID: <2e838551-e6a3-df5d-a889-baf60c7f99fd@gmail.com>
Date:   Tue, 2 Aug 2022 23:10:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] staging: r8188eu: convert rtw_set_802_11_add_wep
 error code semantics
Content-Language: en-US
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        martin@kaiser.cx, straube.linux@gmail.com, fmdefrancesco@gmail.com,
        abdun.nihaal@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220728231150.972-1-phil@philpotter.co.uk>
 <20220728231150.972-3-phil@philpotter.co.uk>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220728231150.972-3-phil@philpotter.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

Phillip Potter <phil@philpotter.co.uk> says:
> -	if (!rtw_set_802_11_add_wep(padapter, &wep)) {
> +	if (rtw_set_802_11_add_wep(padapter, &wep)) {
>   		if (rf_on == pwrpriv->rf_pwrstate)
>   			ret = -EOPNOTSUPP;
>   		goto exit;

is it intentional to ignore an error in case of rf_on != 
pwrpriv->rf_pwrstate?




With regards,
Pavel Skripkin
