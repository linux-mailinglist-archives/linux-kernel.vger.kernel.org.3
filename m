Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F6D49DF10
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbiA0KUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239130AbiA0KUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:20:13 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3240C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 02:20:12 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso5542529wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 02:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=w2Rs4mwi45xUoHXB6ktckbxGR2wA8oiVCenicr727qo=;
        b=iL159WM4h3CR1WEMSHsJUyvk7IWX2583+J0PELCP291Ze1ImSMNxNNkgzdSJdyzpuT
         XcgsxUMOch2n94FVcVd3nZk2Y80VNyKiSvKcozkvk9oNWQSp27nhFTjTz46DxPfnx45m
         yq1nvQ7FzzDC84FIBqC4LOimGsXasAQJC3Rvptc7qWw1BMB+3sSsiQgwbLDFiA9iI6/i
         Ec8vAXn1JX/zTar62kTOidCeSS0Geizt0ov4pPbxR8R9dsHKBcHFo6ks965te525X0S+
         wAeX0jINYcMgvaV/qsqQweCQa8Dg+hVv+ARMsFSiTJjiaftIChIu8l0HUDa65ULUMN8W
         I2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=w2Rs4mwi45xUoHXB6ktckbxGR2wA8oiVCenicr727qo=;
        b=7uHFENB6NfqajBqwmVwn6trASiobQEy40MXXnZUZ21DVQKb1oX2SCqouiDaMqoWpQh
         WOD5wyYteNXjtGbzfBV+EBZVF4pWe1bQnFolhyeiCOnscIprL72aydHEcsXfg9VIY86o
         8JMnw6SuliyEQ+1BhqiBVe4NBYt7UvomCxIQBR0DhEJGqXDpJ5MxQxoVmKPB6lxJGma8
         ylalFXSfq7cZZG953/oAHO+nJ6U7ovx2lxd7n7cr3mEp59B/+PybDt/41fBvG7TFP6Y2
         ios6fy1inFT3doWsZqND8Jt+/KfMtj6uE6Pycsz69Yte6i7mFE3CawxaLvOWPE7vEYhs
         B0nA==
X-Gm-Message-State: AOAM530ViX9K9dVpB14xbU0oUHG7RglLCxpYQiHoZMx9aoUxHy3Rcyi1
        a9/QkO37SOvmTIMwaAsO4sbZlQ==
X-Google-Smtp-Source: ABdhPJwuNpjWEYC4SRjTDUdeHq+XZFr5+laKEEgp44okKUufaFdh35+Rg2dn5kFHO5duH7bcs0mLUg==
X-Received: by 2002:a1c:7c05:: with SMTP id x5mr2631809wmc.71.1643278811266;
        Thu, 27 Jan 2022 02:20:11 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id g5sm2251211wri.108.2022.01.27.02.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 02:20:10 -0800 (PST)
Message-ID: <bd870824-c171-85df-23d9-537a0c6e7036@linaro.org>
Date:   Thu, 27 Jan 2022 10:20:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/4] ASoC: qcom: fixes for Qualcomm codecs and q6apm
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
References: <20220126113549.8853-1-srinivas.kandagatla@linaro.org>
 <YfFMsvoqrJLbw28Q@sirena.org.uk>
Content-Language: en-US
In-Reply-To: <YfFMsvoqrJLbw28Q@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Mark,

On 26/01/2022 13:29, Mark Brown wrote:
> On Wed, Jan 26, 2022 at 11:35:45AM +0000, Srinivas Kandagatla wrote:
> 
>> Some recent testing found few issues with wcd938x and lpass-tx codec drivers.
>> WCD938x was accessing array out of boundaries resulting in corruption and
>> system crashes along with not handling kcontrol put return values correctly
>> and rx-macro had incorrect sidetone registers offsets. One final fix in q6apm
>> to add a check if graph started before stopping it.
> 
> You probably want to run the new mixer kselftest on these devices,

Yes, this is really good test indeed already found few issues with 
existing mixers. I will test this on all the Qualcomm boards and get 
back with some fixes.

I also made some improvements to the mixer test to not keep writing new 
values to controls that have returned -EPERM in cases like where put 
callback is NULL, In my case I have a Impedance value read only control 
whose value range is MAX_INT.

--srini

> including with the patch I posted the other day testing out of bounds
> writes.  It doesn't cover change notifications yet, you might want to
> set up some automation for that for whenever someone gets round to
> adding coverage.
