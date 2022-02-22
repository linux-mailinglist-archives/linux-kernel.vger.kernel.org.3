Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D104BF7DB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiBVMI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiBVMIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:08:55 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9B19E57F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:08:30 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id k1so32784835wrd.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yL3pDh0UdEVLDaNpndoSvDFj+AT3Eq41Xkt0nDOjcQ0=;
        b=Z4OMOOvgcGbdmLQhjzNiQ8E9w95cVCCHZuMtJ6oBvC6QGBKNZ3jVzKkvnj2lFgvZ/q
         oeb5xRoiwPJ6hnsUrppVfQ0NiiUoWzK7RpYF48MHxn3PlWY/25BkcCjtZRyJv7bPcfjg
         ErOt9/wFCOdRMhM5ust8XjrJnf+SQZDXl7xM6fa+7nURbAZ5Gvagn9EtCJUno4oHicdq
         ykdXYvZHopS0ldd8WtV8vJLfZ1Ffng6D9yixLjUDjtk+vyNcRkHTKlWk6A7SFrrGTa/5
         CD4ZFWjzrzT1Xe+7S3lFiOPeIwIG2ScznqEsoAnYUfEaknTcxdmzGNjPBi9NmMFivpY8
         LnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yL3pDh0UdEVLDaNpndoSvDFj+AT3Eq41Xkt0nDOjcQ0=;
        b=g2phE5ISKsGI+dn5HjpMShdX6AQe8eqafFcnqWZkx/KH3UfDHS2CyWRRtukqjuh298
         ZP/eeGXp+qk4UiHhJy1QUxrd6BO3lWQdsfAVxKtV/4YG50gic3n4RiohDsbU0UR884S7
         xBYwjWLd9osUQsp1PKTF/63QzzufkbvH7Cr2gajbcVnfQp/mxm1cebE9X0QwqY7B6ioW
         gvOK0W02f2sLfjpLn9iGNYi9A193JwT7mq5t+HYGHBuqIJimYrrQ26PHthERaS2jZq23
         4Ff88EuDXAU1Wh5QatsRdilJMACjGiOL+9KMv6po1lBkT3iKHwjWJn3N4iCx0bigtUOr
         Lgag==
X-Gm-Message-State: AOAM530r1WxGJC0M94+3t0rEY8RnwvPHO3biseCNA881oEES0D/N6EeR
        7FEgrcn7Aunj/JcCNeLpujBYZA==
X-Google-Smtp-Source: ABdhPJzp3KFQ+SQsem4sfDVHru0HVSXjbyVlnsS4yDRYWFDop64xr0sAk/GbsLri3TUvPPegU5uVew==
X-Received: by 2002:adf:8bc6:0:b0:1e3:200d:a363 with SMTP id w6-20020adf8bc6000000b001e3200da363mr20189447wra.105.1645531708678;
        Tue, 22 Feb 2022 04:08:28 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id p20-20020a7bcc94000000b0037d587d4841sm2157977wma.42.2022.02.22.04.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 04:08:28 -0800 (PST)
Message-ID: <c5cd6811-d1d2-0ab1-067d-b200e225438a@linaro.org>
Date:   Tue, 22 Feb 2022 12:08:26 +0000
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
 <d8f1db40-33ce-671c-2041-5f12608afee5@linaro.org>
 <YhPCWDmS2PV/AD1E@sirena.org.uk>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <YhPCWDmS2PV/AD1E@sirena.org.uk>
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



On 21/02/2022 16:48, Mark Brown wrote:
> On Mon, Feb 21, 2022 at 04:11:56PM +0000, Srinivas Kandagatla wrote:
>> On 21/02/2022 15:38, Mark Brown wrote:
> 
>>> A lot of these commit messages sound like earlier patches in the series
>>> introduced bugs which isn't going to be ideal for bisection.
> 
>> Yes that is true, I did think about sending this as a fix.
> 
>> Adding a fix tag would not really make any functional difference as we will
>> be hitting the issue only when we enable pm runtime in codec and
>> SoundWire controller, so I did add this as part of pm runtime patches.
> 
>> Without runtime pm the clocks are left always on, so it worked so far.
> 
> You still need to pull this before you introduce changes that cause
> trouble, not after - it needs to be preparation for those other changes.
I agree, Will reorder this in next spin.

--srini
