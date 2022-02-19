Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A2A4BCA4F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 19:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbiBSSyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 13:54:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiBSSym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 13:54:42 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D810694BC;
        Sat, 19 Feb 2022 10:54:23 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id d23so11271215lfv.13;
        Sat, 19 Feb 2022 10:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=Ci6QRGwAlkUphSDT6SSS26W4w72+zrbvF3RFtSti1zA=;
        b=hxmOALR7fu4NSCDBQpNlkYo3cbQuBRUGBm6lqCfXOABtakxfFcfezKMvO+rZUKfYYB
         K7nd2fsc2Y2y8Fo3EbiQKJsxIpdlW68MopfYn9lH59b5EvdJSK/rc2co4kiBiHTMCxJr
         5mixYHCQduWGM1vSXhLxd7X44w9m6tHtBzUxgCM5DcUFR6pfYQFRDt1VBtXLR1G6ZMkA
         AWDtx6ST7x2efloQyAMVCN7wXJfIUwUAAApgInco0cEY8j5L/B6gEXM3Qv/aViH93nPc
         ku0aOl5uiULvMBHjnODgB2UFdF1T4J1TGbSbktZ4H9hnay+tfEw7SGlajbPSd69mgFyN
         sy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=Ci6QRGwAlkUphSDT6SSS26W4w72+zrbvF3RFtSti1zA=;
        b=0V0hsNwS8AncWgNRIugHfjPWmn9I0zaos9wiGmIuk69w2/KUjP3R6wiMwmp4rEFn2g
         ro1Q331bWeoVjoRNktmIgtBe4dArx0Z3j3CaR7q8Eqz+uNGOr5DXXZjwqLDTbEXHgmTm
         47wg3BXDBE0mhiiIIbDgefSRkK+rqPZ0AmA543DYgnH9Qf9KfvUiHzIa/mYGN0Pj0MrQ
         uVBiWKcJKExWYM7MSjQD7OS/dEYIzHM7ycQbjK32gF2oc6nkBy/aPjHgoXo2U0lr9LO5
         kChL7mGC4b4d1MP0vUqSyA1khI07Fp0YzVFlSI3JQ4sUMS1dD0rv/DcSPUl2R7uot3Ls
         /+HA==
X-Gm-Message-State: AOAM531Gob0N/01kNH9pFotghr01hbAED7E6TvWizHOlDM0+0+EvfxYD
        oUrVlgVr7u+G6+Kw0URjpIE=
X-Google-Smtp-Source: ABdhPJxmMnmGlPqJgyh+vYOuXmx5fXZ96x5FviI71xKObjIWMROoDlv5HlFyEEe4tE1z3VFN7Oh3sg==
X-Received: by 2002:a05:6512:220b:b0:443:3113:ef90 with SMTP id h11-20020a056512220b00b004433113ef90mr9303085lfu.475.1645296861746;
        Sat, 19 Feb 2022 10:54:21 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id h11sm638555lfr.208.2022.02.19.10.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 10:54:21 -0800 (PST)
Message-ID: <7f4e4c47-59f1-1def-36bf-a2ded912f76d@gmail.com>
Date:   Sat, 19 Feb 2022 21:54:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 8/9] drm/tegra: vic: Implement get_streamid_offset
Content-Language: en-US
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org,
        robh+dt@kernel.org, robin.murphy@arm.com
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-9-mperttunen@nvidia.com>
 <b1df816b-6838-c435-1a23-5029144e4cfe@gmail.com>
In-Reply-To: <b1df816b-6838-c435-1a23-5029144e4cfe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19.02.2022 21:49, Dmitry Osipenko пишет:
> 18.02.2022 14:39, Mikko Perttunen пишет:
>> +static int vic_get_streamid_offset(struct tegra_drm_client *client)
>> +{
>> +	struct vic *vic = to_vic(client);
>> +	int err;
>> +
>> +	err = vic_load_firmware(vic);
> 
> You can't invoke vic_load_firmware() while RPM is suspended. Either
> replace this with RPM get/put or do something else.
> 
>> +	if (err < 0)
>> +		return err;
>> +
>> +	if (vic->can_use_context)
>> +		return 0x30;
>> +	else
>> +		return -ENOTSUPP;
> 
> If (!vic->can_use_context)
> 	return -ENOTSUPP;
> 
> return 0x30;

and s/ENOTSUPP/EOPNOTSUPP/
