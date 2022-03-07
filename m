Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC154D0524
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbiCGRWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbiCGRWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:22:17 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F27290FDD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 09:21:22 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m42-20020a05600c3b2a00b00382ab337e14so10602584wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 09:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IAk3PhzzFGV0B1v2wNJhqD7ncx2tZ/E4HW4CrzZxjvg=;
        b=PaUpUTCA0A/A6CIulO0e7HGJdVj9N3rHXbHC+6DwVntIWt976EdU4JtWRGZoHOFEmY
         QyQuNyKQPGcd6ddGTOVXKN1vcXREQKFtN2iGHK8V9SMP/TOcbBbjVSIoG4UlfCOP0eyG
         CmirCDFq8NZKvgRXAOYEpf4h7PMAwQeEvbjzKZfwdznPxFjgBS8cNk8/r5O7izqwifii
         VW885WGpyvZFIGLk2fH2p+CP7cO3PCn4V5584kMNi/coIXAzvxmddup9dlzLGn1y5HVx
         U06uaPPHJbkPqDO390ZOcLvrp3fnwqhi9t9w+tBH13TimxNj3HZBsn8V/gb9r38C2fmh
         9mew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IAk3PhzzFGV0B1v2wNJhqD7ncx2tZ/E4HW4CrzZxjvg=;
        b=TbbXuPE5SSi2nHigIPZjkkMkPP/hhbG0J2DqxrbgGqFvuPmx1+7pRc7mPmAeP1WzA8
         HslO6fOvv/VDBQXmnRDbXR4pbp2CNnNECMT8nbb8ykUpu63+MbCuXe6rrvMTolJlFDsR
         hNrg8R3KSz/bkLG7bZb83rMDdgm3UWoLoMHIGD2bKghP615nWlicf22r/AzBM+t2VwPC
         WwEHP7b43Cfam+E0H3zDkQw95e+k45Bbpa950d0iRscekyIiga0Mj6PTDHdi/S6pGssM
         0xhqvYDrL6M4i1jEJl0KXOcJH1bwh9uXd8PnDdnizZHO436sq/lmEU4m219KltW6A54r
         6tEw==
X-Gm-Message-State: AOAM530Ui+sRJvZyHgs7pBYjOD3eNXyIR+4BIAZ3ZDty1Q1l23/7tzK7
        dKVjfa0b7+8s0B9+SjNOhZPArg==
X-Google-Smtp-Source: ABdhPJwGMQtZ3E63B/mV0G4eYSgvz/jkQ7+cCCZeFbDF8//gLskmpO84n3wySVlfltI0QtSFVKGSqA==
X-Received: by 2002:a1c:7c0a:0:b0:389:8d53:260e with SMTP id x10-20020a1c7c0a000000b003898d53260emr9662454wmc.69.1646673681048;
        Mon, 07 Mar 2022 09:21:21 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:6cbe:1901:15e:e188? ([2a01:e34:ed2f:f020:6cbe:1901:15e:e188])
        by smtp.googlemail.com with ESMTPSA id m3-20020a5d6a03000000b001f06621641fsm9794789wru.96.2022.03.07.09.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 09:21:20 -0800 (PST)
Message-ID: <174e42ce-13c7-e7ba-0ce8-227979383db1@linaro.org>
Date:   Mon, 7 Mar 2022 18:21:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9 2/2] clocksource: Add Intel Keem Bay timer support
Content-Language: en-US
To:     shruthi.sanil@intel.com, tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        srikanth.thokala@intel.com, lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com
References: <20220307113147.19496-1-shruthi.sanil@intel.com>
 <20220307113147.19496-3-shruthi.sanil@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220307113147.19496-3-shruthi.sanil@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 12:31, shruthi.sanil@intel.com wrote:
> From: Shruthi Sanil <shruthi.sanil@intel.com>

[ ... ]

> +	/* Prescaler bit must be enabled for the timer to function */
> +	if (!(val & TIM_CONFIG_PRESCALER_ENABLE)) {
> +		pr_err("%pOF: FW_BUG: Prescaler is not enabled\n", np);
> +		ret = -ENODEV;

		return -ENODEV;

> +	}

[ ... ]

FW_BUG macro comment was already spotted

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
