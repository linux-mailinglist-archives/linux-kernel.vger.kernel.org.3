Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9F758F600
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbiHKCv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiHKCvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:51:55 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E591C883C5;
        Wed, 10 Aug 2022 19:51:54 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id d1so12464452qvs.0;
        Wed, 10 Aug 2022 19:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=MaRTXfYyFqr0HiXCCqqjA5Tp2gofP6+S10DAm5IeLT4=;
        b=A1Ywx5+d6yl1vB1SqyqWKvyOpgv+mfVVheGmkvUrQJC5qkmBzjHMaM2n1NC2EWPUyg
         SZS09u2yr71Dv/ueyxwbBjGFWvC6lGbR2cCPAP8K/u9XKfs/q8ijOUpkFcO959ZYnxUA
         NaJ5+HES9ZlkPmCcrhfnhD3h6HG8BH+ng8ElxFxnSYOd+8s3ocaJIZL7prHzi/xgWF8w
         QmLENU1eBGrFSnRN9uyTx0kuHnGWpeMPs09ZX8gjUCCBiIzN0M0+rfbhMtoPk3SH+3vS
         AIVjnQaBIWlDnzzDuV/zHwW/0znh05/8U/jBK3O0yHhj3wNSEGPORAzZkH/VzBl5vPC8
         JVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=MaRTXfYyFqr0HiXCCqqjA5Tp2gofP6+S10DAm5IeLT4=;
        b=7fwSqHpKNhK7qzXe9oNyTNkJIBIw2oZgsLwCyVyq97sbvi/nHoOxg/SgPXX3EhShlb
         GQ8x1SJgc0ZtH5U52tiCeMN5hwtCto1b0EK13fh1HRgMPQw0Ok/cyC5i8bwEbi/HnTCL
         bpoM0h0z+XKX097CHR/gFJC8iK+nhqjCQ6Gqvi0QMV3mEDp6XYsYFTs9jRFDb+e5gdUI
         WeEvpFjLMCTPmYbEpxrJX4rFSjQ9bMtwLM5C86nNMdu4upyOArAiuZAHiYPvbiRtnOv6
         dNpZPxugXaHuqYcDvhdkv+lA4fJJrbx3jzrdJwvaof985RZJrnSbN7njWTcx3jPLp/wS
         6FEg==
X-Gm-Message-State: ACgBeo0CQVL0eEcYUg5ql5JAbX4IcdPKpREB+9fqtz34+fd0B8vknxL9
        iwEGzWJmkm9tCEO4zEqZNRn/0t3B1brCKP0IsSs=
X-Google-Smtp-Source: AA6agR4AgzQzC7Ec26xU8Xdd3LO5LAt4FVM3x6beEWkiuAGReSYSVbm6ydAFwrTFMcKIwg4ZhXuZtA==
X-Received: by 2002:a05:6214:27ca:b0:476:c754:6288 with SMTP id ge10-20020a05621427ca00b00476c7546288mr26008634qvb.54.1660186313920;
        Wed, 10 Aug 2022 19:51:53 -0700 (PDT)
Received: from ?IPV6:2600:4040:2036:c00:c070:f2e9:e1e5:7d17? ([2600:4040:2036:c00:c070:f2e9:e1e5:7d17])
        by smtp.gmail.com with ESMTPSA id t25-20020ac87399000000b00342f80223adsm877426qtp.89.2022.08.10.19.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 19:51:52 -0700 (PDT)
Message-ID: <499c8b49-a09e-e775-3242-13d37a13877e@gmail.com>
Date:   Wed, 10 Aug 2022 22:51:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] ARM: msm8960: Rename cxo_board to cxo-board and
 add alias
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, david@ixit.cz, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
References: <20220808234723.5184-2-guptarud@gmail.com>
 <20220809000300.6384-1-guptarud@gmail.com> <YvQMyQLohqcc8Fug@ripper>
From:   Rudraksha Gupta <guptarud@gmail.com>
In-Reply-To: <YvQMyQLohqcc8Fug@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > Clock and dts patches goes through two different paths towards mainline,

 > so they should be separated.

Gotcha, thanks. I will do that.


 > This breaks compatibility with existing DTB files.

 > What you probably want is to make sure that any clocks with parent name

 > of "cxo", should have a .fw_name = "cxo", then you can make a

 > phandle-based reference in DT and these global names doesn't matter (and

 > in the end we can remove this board_clk from the driver).

Ah, I see. If I understand correctly, it should be something like this, 
right?
https://github.com/torvalds/linux/blob/master/drivers/clk/qcom/gcc-msm8996.c#L169-L172
