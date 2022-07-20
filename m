Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEB557B8AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 16:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbiGTOmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 10:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiGTOma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 10:42:30 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F15C4D805
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:42:30 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d8so6482215wrp.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 07:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4yQPkEDwmQ6fY2iybkkwsInOBKjeMVTN1PcfvnBQKzo=;
        b=pRXqu2oIYMA1vWokaOPCwKcrVUSXNmwiKNKzrT/ZJhIuvfD3uCnbgNmkKar7aVuj90
         x8E0rgiN4OFH5o56fJJ78Q4iXwNo7uB7uGeqowrDvvpeOalDH86VWUQbnDR46CN6QBW0
         y2EhbfF1W2SzJ2GSGikx9bF+yzcwc4WAwXWyjRdjtGA4pcMAlEVu4mIh/i9M/iDN4918
         p+/3imvrstXEpHPGXDM0uPXC3NZr/RNSNvT5Fe0uTW5lA5ECIGEOYbaGuJIxHcrbkVft
         zVZqJLANIDOXrHMb0/G9WRK1pcFeOgalD1PUBOfbYITLvgVnN8tnYBGEgSbnXikhmPRd
         cJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4yQPkEDwmQ6fY2iybkkwsInOBKjeMVTN1PcfvnBQKzo=;
        b=GBOVVIGTP50V3GvlLZw3LLIQ/ySGl3M97tY/iVFUXtmXVktY2WfNQDNOjQdT6rK5OJ
         nDIQ0ta/dDfP3+0N+OAx4CDTKZ13Q9Xud/Z4ykR15T4fnlybpLrnJ1t09VqoVWyfflV4
         CeMt6seqk31LtbpANW+Y+RsJP9YqZUDlp/0OKax0PmFkPWVji4KK/EZbDylOWtG3Mq1o
         LKeVBIkwf1/guXFQvOOQJ1SEmaZ6eOYNz886txej8Ei1w7BUiM9Ha5uauCGKpJbd7T9p
         p4DWHXqRU4W7jyClYQjNSiWrlY223XJwjQgJlMuT7hapbc9dYdc0IWwQGwtufgX3Z5t+
         syfA==
X-Gm-Message-State: AJIora9nsmpxbpYCdMiR6wUYP+ql3RXwigDKluRSnyGjJqag+PzidkjR
        ZsxhHZ/oD6wGSA4RDahgIGkrXQ==
X-Google-Smtp-Source: AGRyM1vSAU4Vq87yHXgIdRiCpZq90qfgO2OmqyTn7r5WFUepyZ3vi981pLtyTOD1B4FfEwsijPJQBQ==
X-Received: by 2002:a05:6000:1548:b0:21d:acfc:29f5 with SMTP id 8-20020a056000154800b0021dacfc29f5mr29917158wry.520.1658328148617;
        Wed, 20 Jul 2022 07:42:28 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:5c9a:ee80:52f5:6a1? ([2a05:6e02:1041:c10:5c9a:ee80:52f5:6a1])
        by smtp.googlemail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm8169634wms.3.2022.07.20.07.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 07:42:28 -0700 (PDT)
Message-ID: <9403166d-4960-29e3-1de1-9d17c76752c6@linaro.org>
Date:   Wed, 20 Jul 2022 16:42:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] clocksource/drivers/sun4i: remove unnecessary (void*)
 conversions
Content-Language: en-US
To:     XU pengfei <xupengfei@nfschina.com>, tglx@linutronix.de,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
References: <20220720020735.3771-1-xupengfei@nfschina.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220720020735.3771-1-xupengfei@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2022 04:07, XU pengfei wrote:
> remove unnecessary void* type casting.
> 
> Signed-off-by: XU pengfei <xupengfei@nfschina.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
