Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C0357981D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbiGSLEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiGSLEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:04:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5B52B61A;
        Tue, 19 Jul 2022 04:04:00 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v5so6447wmj.0;
        Tue, 19 Jul 2022 04:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=F0eJCq3BQrFrsvl/YxQ+KJ/XG6zkAiePh9NmlptAJeU=;
        b=q4Zl9oE1tmdvGAUsK4D6sGjHCJYiBtU3LPEHUc7TQ2CsVvhb/4GXVHwKMYBrk/kQhQ
         nY4AvOZeHRxslLazsFqOYxWgGgMKvshUwVeBX0hrrKgZmazBbMQiBcACxNzUxoZ4gODU
         ol+x5DeKowN5e/gFT1DdUcJAD0h52MWZQZ2hy0Vsy2QwjvRIkBJg5QACRMPotoKiNuI/
         fnQejsIxAFS2elOnUzMPBpwFHSYxUobj91rEnTCkm2pBz7/3m6oykR7Z8CdfiVJhRacy
         3T7GMn4l5EncZi2UXIb3ArgKAr6YRkSaERCWtGL6FOxgMANKcrHREPDH3K/jhO/4dNcp
         Nh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=F0eJCq3BQrFrsvl/YxQ+KJ/XG6zkAiePh9NmlptAJeU=;
        b=wCh8sBtW4plfUWHetm7fS+LKuzMSIcNSCv+aPgIBgRZn9zmNt/EQthjRFSomyS+GPH
         U4CAt/O8gzIcNbKrQ8XfBEfN2ZQoe1CAl65c3MzyeRX9isdSmBKnVTZkC9Jo+6MBYCiO
         lPNK/1Epa1G35zy1YJshgJJZkb3VYO9beUbSgMxpDDoTYrcssLro4oqfIb2tezOf+zRh
         kxb11LQKNrpQd3/ayBhCFE8p5+b5puusnF2E7c04DCZIkxJSN/MuKJ3o0NMZwR5gVMh9
         5OvDuBvHjah90m1jN7iEg8VxKNeqGmiXxOWkZbBYq+U+XZkJ5hDzTPNDvDJMrATSDezP
         9qrQ==
X-Gm-Message-State: AJIora/3AmIRzx8uaL/vnIqaQb/w+CXrpcYtCUgCJw4hMu8m/N5jm3Rc
        3E+5J1B1mH+vwSfJzfh3aIkfZFH/Ao0=
X-Google-Smtp-Source: AGRyM1sFUMv3zqHy77kf/Etv6/JjZuANfHf3nCUv0WBd1B+dKG78pmkhmOBrsWyL4Yh0lvlgDnqzeA==
X-Received: by 2002:a05:600c:502b:b0:3a3:22c1:ca61 with SMTP id n43-20020a05600c502b00b003a322c1ca61mr2497051wmr.10.1658228638974;
        Tue, 19 Jul 2022 04:03:58 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id x5-20020a05600c21c500b003a3188bef63sm8740187wmj.11.2022.07.19.04.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 04:03:58 -0700 (PDT)
Message-ID: <62d68f9e.1c69fb81.985fb.30aa@mx.google.com>
X-Google-Original-Message-ID: <YtZx8pBqxJVJfddg@Ansuel-xps.>
Date:   Tue, 19 Jul 2022 10:57:22 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: qcom: ipq8064: reorganize node order and
 sort them
References: <20220718153815.29414-1-ansuelsmth@gmail.com>
 <7f2a4f21-5e07-9320-8f7b-573ccc562f43@linaro.org>
 <CAA8EJppCxrcQOtCDZvUX-CThGV7aZXYv__gz3KRBf28TCRTBEg@mail.gmail.com>
 <78230095-6b45-4536-f41d-12bb23308d34@linaro.org>
 <f625ccde-8ecd-c06d-e8b2-ecb51c9ac9b8@somainline.org>
 <62d686c0.1c69fb81.4a957.bf03@mx.google.com>
 <26b43f6d-2b35-aab7-f906-31458c1b824b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26b43f6d-2b35-aab7-f906-31458c1b824b@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 12:56:18PM +0200, Krzysztof Kozlowski wrote:
> On 19/07/2022 10:19, Christian Marangi wrote:
> > On Tue, Jul 19, 2022 at 12:22:24PM +0200, Konrad Dybcio wrote:
> >>
> >>
> >> On 19.07.2022 12:16, Krzysztof Kozlowski wrote:
> >>> On 19/07/2022 11:59, Dmitry Baryshkov wrote:
> >>>> On Tue, 19 Jul 2022 at 12:56, Krzysztof Kozlowski
> >>>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>>
> >>>>> On 18/07/2022 17:38, Christian Marangi wrote:
> >>>>>> Reorganize node order and sort them by address.
> >>>>>>
> >>>>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >>>>>> ---
> >>>>>>
> >>>>>> This was picked from for-next qcom branch [1]. Reorganize dtsi as requested.
> >>>>>>
> >>>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/?h=for-next
> >>>>>
> >>>>> If this is picked by qcom branch, no need to resend it.
> >>>>>
> >>>>> I don't see value in such reshuffle. Reviewing is not possible and you
> >>>>> did not mention tests (results should be equal).
> >>>>
> >>>> The value is usual for all the cleanups: make it follow the
> >>>> established practice.
> >>>
> >>> Are you sure this is established practice?
> >> Yes.
> >>
> >>  New DTSI files (see SC8280XP,
> >>> sm8450 although sc7280 looked ordered) do not always follow it, so why
> >>> imposing it for existing code?
> >> Perhaps it slipped through review.. Partially my bad.
> >>
> >>
> >> Such reshuffle can cause conflicts thus
> >>> stops parallel development. Review is close to impossible...
> >> Almost any addition or removal also causes conflicts, because git is
> >> not as smart as we would like it to be. If the commit is structured
> >> properly (i.e. it *only* changes the order and nothing else),
> >> decompiling the dtbs before and after applying it and using a tool
> >> like meld that can find similar chunks of text at different offsets
> >> review is definitely possible, though not very pleasant (you can't
> >> just diff them, as order is preserved & phandles change due to that)
> >> as you have to look at it manually and can't tell much by just taking
> >> a look at the email.
> >>
> > 
> > Can you give me an example of such tool? So I can put these data in the
> > commit description. I have to rebase this anyway as more changes got
> > merged so it might be a good idea to add more info about how this won't
> > make actualy changes.
> > 
> 
> scripts/dtc/dtx_diff
> fdtdump + diff
> 
> There should be an empty diff from at least one of methods above. If you
> have a difference, I am not sure how can we verify this.
> 
> 
> Best regards,
> Krzysztof

This [1] is the output of dtx_diff.
The file diff is just phanle change that are related to the node order.

Seems a nice way to verify if the shuffle didn't drop any node.

[1] https://gist.github.com/Ansuel/5ea821af51b8126292f4b3cd57e18555

-- 
	Ansuel
