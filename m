Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3C0463BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243913AbhK3QhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbhK3QhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:37:01 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD90BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:33:41 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a9so45739522wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HRnctZBN3KhAIJkBe2HZYJWNwVrPzx0pDMVoslI75XM=;
        b=P0thRGylkwgkwe5JrcvGJEUyRiKjZaaVV/oow9f9vVq0QSt5xQL0NDr4uvHuqheUew
         XrvKbxvZ/TyA6p68OGvEJKqzxsPewzFwIR9g2aAAoQTS7IvGBEsxRzb6hG8N00HqgHZF
         vWZ9JGHbAVV091c64Qde1cvjR19LiIqfFgRat+Cxaa3B3SJhh61gWJ0IGCu++7BauNu1
         W9Isf2WGFXwxEeZz16gNViyZSn5VCq1rMUED1A1eobCGk+tf4Vs+bViUodqAt2wosY/+
         4xk87MeAWqnQc6ge/zsURP7UAb6zuNL/eWqxLoltJ7zlniTHqxyy1vybnpqcz0qkmluU
         cqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HRnctZBN3KhAIJkBe2HZYJWNwVrPzx0pDMVoslI75XM=;
        b=DUJBIbqywwl79gevOuVUrOnvDQYL+q3BbCil+Aw96lPbCOptQKwRUG/vXtfn2pvXal
         sRal1X4EXam0QRcaqtgo6xNUejtLR07cGn0S6mQdSXw/bbC+Vfb60e+TI1HuibdgBLas
         Gf9kz4zwGnPHVHLDWqXn3uK5fjV++j/b8sypoC9TNScFRuaZN2SA+VstVSgFyfGk+akj
         oJKzzqImcEwSL6Mp7K7uhj2h5Fqjpnb5zcJF0VsX5A+EKp8YNXasR0mcjfXY1kC1yAin
         SqOvn+P4s+5yCpliDGEZGOVMp9jIhq3fsKD4o1Zx0eSpRtdKEx7BKQauE4/gfBpeo3My
         DvIw==
X-Gm-Message-State: AOAM5302a0oVM4a3hVZfaV+asrjvT3G222wNXl/WyjqKKFC8PTUIE+87
        UxlIC8vVMTAMdUZqSjYXRYBVsp7fuNLQtw==
X-Google-Smtp-Source: ABdhPJxDvVSIxypQLPI5sKKXXwPixI86qAmokC49hWqFpxnWDPCBTHPW5JcCFMMIkxCEwqb7AKMsQQ==
X-Received: by 2002:a5d:61ca:: with SMTP id q10mr33081wrv.102.1638290020056;
        Tue, 30 Nov 2021 08:33:40 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id t17sm3325441wmq.15.2021.11.30.08.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 08:33:39 -0800 (PST)
Subject: Re: [PATCH 2/4] ASoC: codecs: wcd934x: remove redundant ret variable
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20211130160507.22180-1-srinivas.kandagatla@linaro.org>
 <20211130160507.22180-3-srinivas.kandagatla@linaro.org>
 <YaZR56MLanjnQH1p@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <8279f250-59cc-368d-13aa-b46cc3cb108e@linaro.org>
Date:   Tue, 30 Nov 2021 16:33:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaZR56MLanjnQH1p@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/11/2021 16:31, Mark Brown wrote:
> On Tue, Nov 30, 2021 at 04:05:05PM +0000, Srinivas Kandagatla wrote:
>> return value form snd_soc_dapm_put_enum_double() directly instead
>> of taking this in another redundant variable.
> 
> Cleanups like this should come after any fixes in a series.
> 

Noted, do you want me to resend a v2 fixing the order?

--srini
