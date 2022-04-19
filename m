Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6B6506655
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349606AbiDSHzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349603AbiDSHy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:54:59 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3B82E6BD;
        Tue, 19 Apr 2022 00:52:17 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id bo5so7806145pfb.4;
        Tue, 19 Apr 2022 00:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LbagtcGr17cUgL/Dxb7Jxl0XjRMyxocFSQk1tlSTw6M=;
        b=ZHpPsCtFnq/XYFTKouYXbPY5DqJmJKcMuAuLML53z0iyg9Y9UqH5uD69IkDt3+TM04
         Vi/NZ8lowc8khFkPHVCCk7KvzaUJK96iKuVBY7Fs5QbSEPoIcBCW6VcW8JV1NWtAdbao
         Rg7lz9yijbk3Sm7zdQZHI9iq7UBfBLMY3rS9uKDUonyZ3R1jd+traMOhon+1sia9bxF8
         AbaGarU3vP4WONcgLUzEds3KcCXwR6a/CfkhMUQDwzGBRs1hSVQwmVTv7agU8h3J/KWC
         htpG1/MGt84ORalmadjIOcRIjFzaykN0cDQLjl+0Z8J0zSYsxmhl3GF639RP9Qyq0bLl
         E0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LbagtcGr17cUgL/Dxb7Jxl0XjRMyxocFSQk1tlSTw6M=;
        b=7y54CIcJAP4upSuxsW+wxgWBZ4d/neIzlTwzY6+JbrU3mY/MmrAOEZLW/2kWiOpts9
         jVhIdcx0QVxVdhd7X90RZyD7srVSB1ajluyFbndOrEJmv+2PqKQAKQFSx5xrP9ktUAih
         Iin72MCNsgpPgOnt2Cr7W6bLVPt6MR5E07ThndalPyAZxMmer5GZcoHX+fOFRNl0ltym
         neJdUDT4AMEFiie6gaJHf0KJYwbGoKpHH2kTzOI+Yhs/Ap0sym3Wrj8L5CToytKlkHCf
         ChDD6533y7hFyLh9kt08StBuWsdSKeUDWdOakk72aU1tcMP3mWdbdlGhSrwjEOFP+MyL
         dmEg==
X-Gm-Message-State: AOAM530Gv8Pe7WPWq4wsp5KGg4XRfKAZgD8AtrD4J1zVpFE4y72UrIo3
        aWezGmK1wAuMzL7sjEF89CVIgTyQwA0=
X-Google-Smtp-Source: ABdhPJzJycYbzJJsaA2D055+vWJ21xmPpMzbl2F3whdYaeQElDGMkYTAAw9LlvJlcqJVh4m9jdaQhw==
X-Received: by 2002:a63:d456:0:b0:399:4c5a:2682 with SMTP id i22-20020a63d456000000b003994c5a2682mr13240841pgj.573.1650354737287;
        Tue, 19 Apr 2022 00:52:17 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id b25-20020aa78719000000b0050a4b5cf892sm12169108pfo.60.2022.04.19.00.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 00:52:16 -0700 (PDT)
Date:   Tue, 19 Apr 2022 13:22:10 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] arm64: dts: qcom: msm8996: User generic node name
 for DMA
Message-ID: <20220419075210.GA51180@9a2d8922b8f1>
References: <20220417210436.6203-1-singh.kuldeep87k@gmail.com>
 <20220417210436.6203-4-singh.kuldeep87k@gmail.com>
 <CAH=2Nty6gTX-u1LZZ_g3FZfpkX2CaV3Gh+R8DJODuh4489nCyw@mail.gmail.com>
 <20220418192721.GA6884@9a2d8922b8f1>
 <CAH=2NtxNcs31dQDuGwqs_U9fwhpUdJ1OVLOs5Epe7YwMHDd0aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH=2NtxNcs31dQDuGwqs_U9fwhpUdJ1OVLOs5Epe7YwMHDd0aQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 02:37:19AM +0530, Bhupesh Sharma wrote:
> My patch already has an ACK from the DMA maintainer, whereas your's is
> still in review.

Sincere apologies, I saw your original patch only and missed Ack.
Please note, mine change is reviewed by FDT maintainer.

> So please drop this patch from the next version.

If we are going to have mine binding version, then skipping dts change
here will trigger Rob's bot warning.
