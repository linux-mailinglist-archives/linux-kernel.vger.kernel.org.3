Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1234E2C5D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350305AbiCUPei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344805AbiCUPed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:34:33 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB31634E;
        Mon, 21 Mar 2022 08:33:05 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id h23so20609133wrb.8;
        Mon, 21 Mar 2022 08:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3LRliTmfLlH3oKVFP57IUFaZfYEaxuZudtlO6I7qIIs=;
        b=tSshbf46XCiFT/cS9MYxBW/VSFzYcnshB9vln1gUGNJfBlshI4ppzJn8Xvz8HbeMwt
         V+qpZkDApL9k0rkF5tcXVOmBwU5y1Ks5pFbJn8do2OcvRfKW1mQDlI+lt7YdiHR3y5VJ
         i8M8n1LW2xZ2J2tnilFWudYUd+x3mm81k4B46uUQdXypOo51XWT6SoJHrukUdwRLKWBi
         mSfapkagaeuSBT2Cut134wju1SwaPS5gi74Xjw+RtNh4CZf++nakTINu5Y8UvburOELu
         Ufu+YnectCsuMgeqJBj99UcwWL/GxckTk78WSe55Jgqh5FD1eQa5LvBZkbEy83p5vfJE
         KJ1g==
X-Gm-Message-State: AOAM531P9rt5TLOMMpNC/VMjrrfRjMxvaIlO370DGk4rHCidN3JidjE3
        kkx8Lg0hW5FgA6mkUmnsgNA=
X-Google-Smtp-Source: ABdhPJyoMJgUZCvV0Y0flDAyJ4coI02yk9wt3cl8Asvux4XUXpEuGTL0bFFEZcGPxGZh3Sj1ux4c7g==
X-Received: by 2002:adf:e18d:0:b0:204:981:9f73 with SMTP id az13-20020adfe18d000000b0020409819f73mr6510342wrb.99.1647876783791;
        Mon, 21 Mar 2022 08:33:03 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id d14-20020a056000186e00b0020405198faasm6736607wri.52.2022.03.21.08.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 08:33:03 -0700 (PDT)
Message-ID: <3ee94d1d-4e16-a744-c217-c4bc69ad96b4@kernel.org>
Date:   Mon, 21 Mar 2022 16:33:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 15/18] dt-bindings: clock: Add L2 clocks to
 qcom,krait-cc Documentation
Content-Language: en-US
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20220321144825.11736-1-ansuelsmth@gmail.com>
 <20220321144825.11736-16-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220321144825.11736-16-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2022 15:48, Ansuel Smith wrote:
> Krait-cc qcom driver provide also L2 clocks and require the acpu_l2_aux
> and the hfpll_l2 clock to be provided. Add these missing clocks to the
> Documentation.
> 

Thanks. It would be also nice to see here short sentence about expected
impact, e.g. there are no in-tree DTSes which would be affected, no out
of tree known users etc.

Because basically with this requirement you change the ABI, so you might
break some users.

I will leave it to platform maintainers to decide whether it is accepted
or not.


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
