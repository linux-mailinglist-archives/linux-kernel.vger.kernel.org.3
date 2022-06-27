Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF4555CCFF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbiF0QAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238796AbiF0QAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:00:02 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411F1B1CF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:00:01 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id m2so8572878plx.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PYA86m3m6KKN8+fip9lvQ6xHPvZviw+uoFD0wwDrX2s=;
        b=VaXTBEE75YJL3sPSVnzDJZanyQb+K05AMlW8ddb1VOmVKzy5RB1VeN1qu7bpE5wOSe
         s73BAXy7osQre4GY163jc4W9ApmRiCOxCe0RK2ifyBf9bfyR1yXG3D6P2t4q8/oFg5cR
         4k0HFBZLliZcx3te7RGHevgzkkZAz6LuNSca4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PYA86m3m6KKN8+fip9lvQ6xHPvZviw+uoFD0wwDrX2s=;
        b=bPr2YyH6NqQCgQ0RFDk+xSlxjWsRxL+vVbxsAzKyJw2PBvYM9jF9zQifTyqLHsNmtE
         s+3GPCETSbqBYji4ze+49UX/8wuTH60zti0ELQpJW22Xa/pimyG8Cb3YhtHfpKhFTnVG
         CxXXrCIbHrmVicsbADU2UaTDi/oYnWYVwY8fXevYO+j0QIjQDwx7OwNXOoQ+Sc1ovMaL
         RSV198S09qj8SP7F5BZoMslbyH2J1vXmJd82t8XsVSXehVG4TjClg67648KgFXcwIjUz
         OpjeWk6WUkKIvuYq7QsltKL2TGAg3810WyX+cnrDlV0eqNCtTFQBselp2IFg0xPziOb6
         s2LA==
X-Gm-Message-State: AJIora9RgYGf3xE2s5P+ZTxw3qnMRr4hqjmX13X2TV+Vb+6J350xlA8v
        qJkkx/j6vRBO+eYpPf2f/YRROQ==
X-Google-Smtp-Source: AGRyM1u1abSyl7cHfPGKO4JsjkUtSSoO2KNWPcgWwtXRGWesBkLxWWJ4bz+viP5u9BJTxE3M6D66kA==
X-Received: by 2002:a17:903:1249:b0:168:e059:59c9 with SMTP id u9-20020a170903124900b00168e05959c9mr15550467plh.103.1656345600738;
        Mon, 27 Jun 2022 09:00:00 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:f31c:687c:3a61:62c5])
        by smtp.gmail.com with UTF8SMTPSA id s21-20020a056a00179500b0051c4ecb0e3dsm7640113pfg.193.2022.06.27.08.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 09:00:00 -0700 (PDT)
Date:   Mon, 27 Jun 2022 08:59:58 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     Judy Hsiao <judyhsiao@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, cychiang@google.com, judyhsiao@google.com,
        tzungbi@chromium.org, swboyd@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3 0/3] Add dtsi for sc7280 herobrine boards that using rt5682
 codec
Message-ID: <YrnT/nLN0erv6VRz@google.com>
References: <20220525014308.1853576-1-judyhsiao@chromium.org>
 <YrfJkQYFCsxPpUzi@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrfJkQYFCsxPpUzi@builder.lan>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 09:50:57PM -0500, Bjorn Andersson wrote:
> On Tue 24 May 20:43 CDT 2022, Judy Hsiao wrote:
> 
> > Put sound node and lpass_cpu node settings for boards that use rt5682
> > codec in the sc7280-herobrine-audio-rt5682.dtsi as there are different
> > choices of headset codec for herobrine projects. Common audio setting
> > for the internal speaker is in sc7280-herobrine.dtsi.
> > 
> > This series depends on:
> > "Add lpass pin control support for audio on sc7280 based targets" [1]
> > "Add soundcard support for sc7280 based platforms" [2]
> > 
> > [1]
> > https://patchwork.kernel.org/project/linux-arm-msm/list/?series=638776
> 
> Afaict this is applied.
> 
> > [2]
> > https://patchwork.kernel.org/project/linux-arm-msm/list/?series=643589
> > 
> 
> But [2] doesn't compile and hence this series doesn't compile.

If I'm not mistaken the main contender is the "Add support for audio clock
gating resets for SC7280" series [1], which still has open comments.

[1] https://patchwork.kernel.org/project/linux-arm-msm/list/?series=650267

> Can you please submit a single series with all the audio dts patches you
> want me to apply, where it's possible to run "make dtbs" after every
> single patch in the series.
> 
> Thanks,
> Bjorn
> 
> > 
> > Changes Since V2:
> >     -- Add bias-disable for i2s ws line.
> >     -- Fix typo in the commit message.
> > 
> > Changes Since V1:
> >     -- Remove sound-dai-cells in sound node.
> >     -- Add dependency list.
> >     -- Update patch subject.
> > 
> > Judy Hsiao (3):
> >   arm64: dts: qcom: sc7280: herobrine: Add pinconf settings for mi2s1
> >   arm64: dts: qcom: sc7280: Add sc7280-herobrine-audio-rt5682.dtsi
> >   arm64: dts: qcom: sc7280: include sc7280-herobrine-audio-rt5682.dtsi
> >     in villager and herobrine-r1
> > 
> >  .../qcom/sc7280-herobrine-audio-rt5682.dtsi   | 121 ++++++++++++++++++
> >  .../qcom/sc7280-herobrine-herobrine-r1.dts    |   1 +
> >  .../dts/qcom/sc7280-herobrine-villager-r0.dts |   1 +
> >  .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  15 +++
> >  4 files changed, 138 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
> > 
> > -- 
> > 2.36.1.124.g0e6072fb45-goog
> > 
