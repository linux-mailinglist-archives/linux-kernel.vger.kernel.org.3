Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01CE55DCC7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbiF0HJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbiF0HJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:09:21 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17915F8C;
        Mon, 27 Jun 2022 00:09:19 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t25so14966930lfg.7;
        Mon, 27 Jun 2022 00:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iCs6pLn8hT0XgzeDdl4O3hO03FQgcu4uIQD+eW26lwU=;
        b=KwWPFHNH+XQBHdtaA1zl11WMHMfdvxbVPj74+Va2G5AwiJNxYbEu6htwbR1o79VM4j
         VHgsbNLV4TyXyyHnZJMJJoSQfjMcHXFKPL7HKHyOFmrRiecIfHqL3PTb339MjSHYLvzi
         W2l9/61IuDswJpVaq6+x3+6YKifWtWQH7AeNuRzlRkw12ai3EkdazF5oDlXJhFugV5Xc
         dKi3T8KlH2/G9HtzeoA+hwdoRurjdHB/Tz0UzIYZr7YPE+6jBTCZ4yRpaIs0GeN6YzQ5
         5wbnBzYSbLcSKPy/ROLC5obGsJJ79IT6wGppzCECOscjaWM5iUZ6NTbn4rMB/WInNhY2
         lTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iCs6pLn8hT0XgzeDdl4O3hO03FQgcu4uIQD+eW26lwU=;
        b=6IaawhASj55uU6iAdxzFFrTzSX9AVNMfFN/YRZNFIKNHt4Emnq/OQejqCyNsOl0RhI
         xYW44vl/Th1ROSLivlxx4hmB4FTAL4E7QAvUi5mYSa+JVK1wc4fAiYK5nC/9OV/vL5kI
         xgRgMMvJUfHqgDbs+//aiyRL3zG06/j34hbKuJTOO3D5ZnqUtA0iRw006GfVc8Hlzp5V
         BqGMbXOK06hXCgk9gZFzOzMmds9Z6iqwDnM/LZhzeBiEehlGDWZaRTNSvRpa2u8IN2fJ
         X1/92Bx2NN/NBkJyP38ErCVr96PEU9wLWrujTpUMWbuM0DdSpWsbuCpUYetVpFsiWglo
         COQQ==
X-Gm-Message-State: AJIora8DrAnUeuv0KA//9lOGxJGuB8cTfRBf624L9hfynKqmk2kVVdD+
        oLNjEs1VubCvayWALI+GaBw=
X-Google-Smtp-Source: AGRyM1vH6333c+1uGKcseyiJYYdrdESGsGn8+yWZ/m7fFD06a6/eEo00s4JE7b5FRYzsqDURXb8Ghw==
X-Received: by 2002:a05:6512:3043:b0:481:1b20:5860 with SMTP id b3-20020a056512304300b004811b205860mr2256891lfb.671.1656313758128;
        Mon, 27 Jun 2022 00:09:18 -0700 (PDT)
Received: from [192.168.2.145] (109-252-118-164.nat.spd-mgts.ru. [109.252.118.164])
        by smtp.googlemail.com with ESMTPSA id s28-20020a05651c049c00b002556b0cd5acsm1288477ljc.56.2022.06.27.00.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 00:09:17 -0700 (PDT)
Message-ID: <d18a1f18-d78c-2db8-9b19-196dc88978c2@gmail.com>
Date:   Mon, 27 Jun 2022 10:09:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/5] OPP: Remove custom OPP helper support
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Keerthy <j-keerthy@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <cover.1653991004.git.viresh.kumar@linaro.org>
 <2e6ee73dbc8a231377547a8e9497561cadb38166.1653991004.git.viresh.kumar@linaro.org>
 <565ff879-11e4-1ae4-08d8-1237a875ef12@gmail.com>
 <20220627060636.rfpok75zydgcwwo6@vireshk-i7>
 <4a8114f7-4ee6-a9ad-f5be-ceaf64be8a0e@gmail.com>
 <20220627064155.jo7iqz5h33l7a4vn@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220627064155.jo7iqz5h33l7a4vn@vireshk-i7>
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

27.06.2022 09:41, Viresh Kumar пишет:
> On 27-06-22, 09:10, Dmitry Osipenko wrote:
>> Okay, but Tegra 3d driver doesn't need config_regulators(), it needs
>> customized set_opp() to set clock rate for both 3d engines.
> 
> What does that mean, you need to set two clocks ? There is separate
> support added for that already [1].
> 

Yes, I missed that multi-clock OPP patch, thanks.

Seems _opp_compare_key() won't work properly for the multi-clocks since
Tegra doesn't have bandwidth nor level for the 3d OPPs. Why does it need
to check opp_table->clk_count == 1? Shouldn't it be opp_table->clk_count
> 0?
