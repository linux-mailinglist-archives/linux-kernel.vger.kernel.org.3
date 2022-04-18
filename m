Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD94505E88
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 21:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347720AbiDRTaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 15:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237761AbiDRTaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 15:30:07 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE141176;
        Mon, 18 Apr 2022 12:27:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id bx5so13790710pjb.3;
        Mon, 18 Apr 2022 12:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F+OdSGTAnIEJSUgGpzlltUFmc6PQAZrJed35GOZ5DHc=;
        b=YByHTPdpVJZcPEAovX0IgWXavcHP7vm/vlzK9+Z4V63SwNzsIxJRSJVv4dTwsHww2s
         WgEJkMUVWN61zoxfmSlQcX2ZvJm3qJaS5iYgd/X1N7fNz7gDgMNu26cM7orUuhGyenuM
         6zbg73hTlpIwJDAGBp7qsOHjSPEQtqYxIYAppNOhBtdh6azSYa9pHn78SoLLbWJsk54C
         qUFC4BZPi0BgZl5avF3oZZegwCMI6mWq/iEuUrOlOr7BYjwSHT1xctEBSET7ujmyY5ox
         QR08B95TIQyIlWvgZF+Mb0CILNjYi2rm4bXMNRD9a/UVcc9s/8tpBykhWnSFrDzXoGLT
         F5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F+OdSGTAnIEJSUgGpzlltUFmc6PQAZrJed35GOZ5DHc=;
        b=iMorcdt2lvgd2qZ0EdviVhfqsIMfywb4tSOrKGIFDuCW4/YYeflXDJe3u4JyMzunAI
         MCO11WgIvEgNRN3PkG+wm9pEJp4+ksOzif+B6bnlldfFQ3IxHjSGs9stS37qg/CXWpqY
         S1RHuqUrSMevH9InSbI1MWgEdHD4CBGCNLrtHSlHbvnlrfk2iGSQJqOkQnp+POi0Ix3k
         gqcvbRVhCAGMbuzM0WEXPuqERUoP3yGcOQkqTRuYTAL557kaLMQaoLVY5DzNWjnA30Xy
         bmdBLN0UN/sWJ0j0LmVBzrUYnnVTxnYXEdd3GXAqpAYXGnK+1VN3nRN98NytKrpkPGb8
         T0Tg==
X-Gm-Message-State: AOAM5338NR347KirlzOiUVvj2BeDgROxe3NNjU+hF5JrZazBOBNUjoWX
        lcqpTSNVCumGvoHN8OBf8Iox2kg8hR8=
X-Google-Smtp-Source: ABdhPJzyexcTwHx6iBvzCp/0ZitXIcYa+5GQJvNZamARcMIbWb2DthFC/wWxEOO0myRdgowOB+WvpQ==
X-Received: by 2002:a17:902:6506:b0:158:251b:cb61 with SMTP id b6-20020a170902650600b00158251bcb61mr12227840plk.157.1650310047629;
        Mon, 18 Apr 2022 12:27:27 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id v65-20020a626144000000b0050a839e490bsm2902710pfb.185.2022.04.18.12.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 12:27:27 -0700 (PDT)
Date:   Tue, 19 Apr 2022 00:57:21 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 3/6] arm64: dts: qcom: msm8996: User generic node name
 for DMA
Message-ID: <20220418192721.GA6884@9a2d8922b8f1>
References: <20220417210436.6203-1-singh.kuldeep87k@gmail.com>
 <20220417210436.6203-4-singh.kuldeep87k@gmail.com>
 <CAH=2Nty6gTX-u1LZZ_g3FZfpkX2CaV3Gh+R8DJODuh4489nCyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH=2Nty6gTX-u1LZZ_g3FZfpkX2CaV3Gh+R8DJODuh4489nCyw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 11:02:11AM +0530, Bhupesh Sharma wrote:
> This is already fixed with in-flight patch
> <https://lore.kernel.org/lkml/20220211214941.f55q5yksittut3ep@amazon.com/T/#mb84230b9b8e06544859ccf5e16a7651fac79c933>

Your change is currently not accepted/merged and don't think it's in
maintainer's queue as well. So, probably it's not in-flight patch as of
now.
