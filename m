Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20EF4BE58A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379948AbiBUQMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:12:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236097AbiBUQMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:12:24 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1072BCE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:12:00 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j17so1279270wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zlMFpcP0zNNriVnT5doP/SyJTwdm7nH+VKFwP5oEA8M=;
        b=yR2PUefhHHXddq0ZZeBLi0plQyYgvn0D8x3KItsVGFh6ni4JOUJbjnoBJqWJ/9qpHp
         RGN3lyzVFfzJqFUgngJEy08hEqOjt0iSgamn1nDIDemPbWeCXMif4BfBmIMKpKFGfLmv
         AXUWG2HqimBK1BM08WiBrEGwp2YT8BLO3YYndzkgujGRwykzkBUuqQptkpw28rBrY0Qq
         GWNptMlkuoIlcXdZT1WuIicQWe+xs6vKUlyxkItsmx/60HD7/t3uXhmp+JkpWg0+MycQ
         kcyxccYPfTha0/+REIyv4f5xIC3B04Eu6vXwRhxr3If4ld1wbjoH1UkRUoguOZ++3EmC
         uS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zlMFpcP0zNNriVnT5doP/SyJTwdm7nH+VKFwP5oEA8M=;
        b=K1zV4t8qQ/Teag+gR1nF2zifhI3c9uYvurlIkmBhZnXA5QbbdXVMiUjSkn/Qc/BJhJ
         OOYw5vF50AnlbReYFLgINvCooRFDLQ2O6v6IzNIhUszbEYPjoeSIOXMxnqTbav/E+sn7
         91DFJQPbizdEP9oofiUwqq+E4lUA/xQpBpuvQc6lQ6Ec6m4gSiLbCDN4tahV7t+TXxJs
         c7Zohq1tb2e2z9IsfDCWgXKjU7Nf9T6qevxWFdAxd7dPWVIu9IUWdTFw7IXNtejMTrUV
         I55ZLLQ445Gv9hShMuIVxdVYy1J7/qZkVvY8W7ZrFmwYB5dp76GR9WrW0fJyxbuqWGLF
         u0ZQ==
X-Gm-Message-State: AOAM5313HikhKZ0KlO9ZOJkzcYJ9Q11uIcYorzKL8s52yB0gobbmWFxA
        hQ578XhvT545+KiOdJ2xpUdPHw==
X-Google-Smtp-Source: ABdhPJyDpq3A74100QuIQ6OMl/1/0C5WUkzHL4jQxF7X3+yOs91rMUhAVfAZD1S8e2lUJuD1eJ/Pow==
X-Received: by 2002:a5d:64c3:0:b0:1e5:94d3:5bf2 with SMTP id f3-20020a5d64c3000000b001e594d35bf2mr16370510wri.488.1645459919309;
        Mon, 21 Feb 2022 08:11:59 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id 24sm7818702wmf.48.2022.02.21.08.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 08:11:58 -0800 (PST)
Message-ID: <d8f1db40-33ce-671c-2041-5f12608afee5@linaro.org>
Date:   Mon, 21 Feb 2022 16:11:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 09/10] ASoC: codecs: tx-macro: setup soundwire clks
 correctly
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
References: <20220221131037.8809-1-srinivas.kandagatla@linaro.org>
 <20220221131037.8809-10-srinivas.kandagatla@linaro.org>
 <YhOx+nQ/G+HNRXbq@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <YhOx+nQ/G+HNRXbq@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/02/2022 15:38, Mark Brown wrote:
> On Mon, Feb 21, 2022 at 01:10:36PM +0000, Srinivas Kandagatla wrote:
>> For SoundWire Frame sync to be generated correctly we need both MCLK
>> and MCLKx2 (npl). Without pm runtime enabled these two clocks will remain on,
>> however after adding pm runtime support its possible that NPl clock could be
>> turned off even when SoundWire controller is active.
>>
>> Fix this by enabling mclk and npl clk when SoundWire clks are enabled.
> 
> A lot of these commit messages sound like earlier patches in the series
> introduced bugs which isn't going to be ideal for bisection.
Yes that is true, I did think about sending this as a fix.

Adding a fix tag would not really make any functional difference as we 
will be hitting the issue only when we enable pm runtime in codec and
SoundWire controller, so I did add this as part of pm runtime patches.

Without runtime pm the clocks are left always on, so it worked so far.


--srini
