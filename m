Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AF94A830B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350174AbiBCLWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346538AbiBCLW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:22:27 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7220BC06173D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 03:22:26 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id g13so2262215qvw.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 03:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VFgYrjPaXbaCyhiJtjuKM14hRfwmOgSRClt+H9UQLmM=;
        b=Rs0L00p9DTqKBRCpB5LQwSRqcoStwt4JefJjetRROuDj99tI4OJD14ySouAxTzRCx5
         hiUmfmcqoEW5sXcI/8d2+lekHOzMEoHAkXfT/ePaorxBq+3tiO0cCvl+4PQ5QwOt/vlG
         D1MYEkgg5VEzuZQPUPss1HOxHTTUsNvAQV4lKgp8aSczf8qiLNe6bjKrx6vZjIlSyA4a
         l6OPGgpIvAurUPA+yfMIeH4jquVSnVRkAvoy66PJMFvLyOyPS72ouOo+gQHk81V0hIqN
         pS5JY6xaVH2H0fbZkbSMUW3j+LCt5hWMrpeY7KqNIOGOHVPPgsJz5ihI+tSAmlhQnpvJ
         K0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VFgYrjPaXbaCyhiJtjuKM14hRfwmOgSRClt+H9UQLmM=;
        b=3P/D/VgsRI87zacGd2vrbgHZ8NRPfdTkP+xWlCqlmCkmjXIfSoDV8WcuBuHrWQWbTo
         kcnLc+kNL9dLAgzM5shhPNr4otVT3g+uVA/hnDDLubetxb8hf4UFbWMwy3FmVuDLOt1a
         lZTA6wZflh7SvmqoKU7Mx6vs+MiXmkDEmEDPctzTWIzVa+daWUs47UDj7meNOytmzN5W
         Nl9+7A/wy/qGyl7UqAeMv7YpvCFtAY60nYd8TKrXlfrJ/tUm0oa4GliWxvlfGWsJgIUI
         hxAV3obWo2VhRa4JU6Mw78zwhV+hTWasW7A1l0hQOBydUt27tiLzNYY6xJuH8EMq+QT6
         aV3g==
X-Gm-Message-State: AOAM533U5SX7Aa3il+3RmbvCBVBMVA2FzIuC1yiwTeOPiA2OxE3Cjfl5
        CsTSO8b9rqjVh7fwQ7zG2a6jpg==
X-Google-Smtp-Source: ABdhPJzKYiRB01G1IrJ36Wu5AeAMpjN8WUwgRuzoB5Tjgwh1/Ur32+CaEBwWaGPCMhSAfOe37748/g==
X-Received: by 2002:ad4:5969:: with SMTP id eq9mr30207343qvb.93.1643887345503;
        Thu, 03 Feb 2022 03:22:25 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id c14sm12586791qtc.31.2022.02.03.03.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 03:22:24 -0800 (PST)
Message-ID: <6d303dbb-bdbc-bac1-526d-be593f329d23@linaro.org>
Date:   Thu, 3 Feb 2022 05:22:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH net 2/2] net: ipa: request IPA register values be retained
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org, mka@chromium.org,
        evgreen@chromium.org, cpratapa@codeaurora.org,
        avuyyuru@codeaurora.org, jponduru@codeaurora.org,
        subashab@codeaurora.org, elder@kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220201140412.467233-1-elder@linaro.org>
 <20220201140412.467233-3-elder@linaro.org>
 <20220202210248.6e3f92ef@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220202210248.6e3f92ef@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 11:02 PM, Jakub Kicinski wrote:
> On Tue,  1 Feb 2022 08:04:12 -0600 Alex Elder wrote:
>> Fixes: 2775cbc5afeb6 ("net: ipa: rename "ipa_clock.c"")
> 
> The Fixes tag should point at the place the code was introduced,
> even if it moved or otherwise the patch won't apply as far back.

The problem was not "activated" until this commit:
   1aac309d32075 net: ipa: use autosuspend


And that commit was merged together in a series that
included the one I mentioned above:
   2775cbc5afeb6 net: ipa: rename "ipa_clock.c"

The rename commit is two commits after "use autosuspend".

The merge commit was:
   863434886497d Merge branch 'ipa-autosuspend'


Until autosuspend is enabled, this new code is
completely unnecessary, so back-porting it beyond
that is pointless.  I supplied the commit in the
"Fixes" tag because I thought it would be close
to equivalent and would avoid some trouble back-porting.

Perhaps the "use autosuspend" commit is the one that
should be in the "Fixes" tag, but I don't believe it
should be back-ported any further than that.

Re-spinning the series to fix the tag is trivial, but
before I do that, can you tell me which commit you
recommend I use in the "Fixes" tag?

The original commit that introduced the microcontroller
code (and also included the clock/power code) is:
   a646d6ec90983 soc: qcom: ipa: modem and microcontroller

Thanks.

					-Alex
