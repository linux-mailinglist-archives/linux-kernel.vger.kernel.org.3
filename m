Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523925797A3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbiGSK0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236799AbiGSK0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:26:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938371B798;
        Tue, 19 Jul 2022 03:26:10 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n185so8680019wmn.4;
        Tue, 19 Jul 2022 03:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=sBELIeZgPRDKUHPcPvhxurTRi0JEg9+rEax950Jf2jU=;
        b=l771Wu5jV5JlLWZgJjK7+WFiRmpDAEHVhyhAWmLC/iepK2wqCGfK1Kfx0BZa2m1bnD
         Mo/yoextmslOcCVRSmaLSCtDFJkbyMoE5CPMVLYcyLA+G1rHgGlFawDKCs5SCw363YZN
         L+sp+9EAP7YAedFmizdbSO1YHMnP53gmHKKdKZafEX8wUSqxt0ppzRIQm6fy15aNIWVr
         Lm7ZNH4MVkkyl2gsKvLQq2vp4R9ry/ywDOTWCvZttZjjvMbtU16rzu+nrxRVBku2v8Ea
         m71JJHnFx6Zc/yJ70gRh+M0BIgpUUvdlwQNf0eaU6RYep+pWh6xmzTEnktxELsQC+LzD
         kuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=sBELIeZgPRDKUHPcPvhxurTRi0JEg9+rEax950Jf2jU=;
        b=Ca1ilue1X8aAh0crk4+I/Jcf8SV0SckY6kN09P7t5tVQ//pUC0f+nLUxDKF9zrHfPm
         bcNuQviUbl9L/HS0iJ4i+4gqn72kcgCnD5Ci2dC1Jm+PTEjvPYX6F0CWVwTGvSH+v7/e
         uIgwwpKDvV87unB9/SgAOwZeNH26l9i9BhmGlXjon8AZNr9uu337w5Aclwkq6Ury/MU1
         ZDJQMFU4i1N1tgKtoQtJM1c8f8pdz6mG5qe+QyCMZ/YeWf79DqF/QBkPRFXARYA/PEr4
         WZV1+Geai85vsFUDR/sa5+4B4HeFJ+xpYmfhVZHo9qqDE7vtbXfrhne+D/jfSO05L1Kv
         5ulg==
X-Gm-Message-State: AJIora9DlucmCkWmde0iRJjVWKtw7vqbBgsGXUa8KU8kZ2+6ZJXKUjfQ
        0vIIDXTyrkrlxCF6K2OcEZo=
X-Google-Smtp-Source: AGRyM1vdvPBiI946I+xQZx1j2LM8A/idnkBSuz9/7S3Rb787mrs6ksAp9nBfkVgcIoX+Ox89/5HKBw==
X-Received: by 2002:a7b:c85a:0:b0:3a3:1884:6391 with SMTP id c26-20020a7bc85a000000b003a318846391mr10671713wml.196.1658226368972;
        Tue, 19 Jul 2022 03:26:08 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id i10-20020adfe48a000000b0021b90cc66a1sm12862000wrm.2.2022.07.19.03.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 03:26:08 -0700 (PDT)
Message-ID: <62d686c0.1c69fb81.4a957.bf03@mx.google.com>
X-Google-Original-Message-ID: <YtZpFEoZ4gayOnWt@Ansuel-xps.>
Date:   Tue, 19 Jul 2022 10:19:32 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f625ccde-8ecd-c06d-e8b2-ecb51c9ac9b8@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 12:22:24PM +0200, Konrad Dybcio wrote:
> 
> 
> On 19.07.2022 12:16, Krzysztof Kozlowski wrote:
> > On 19/07/2022 11:59, Dmitry Baryshkov wrote:
> >> On Tue, 19 Jul 2022 at 12:56, Krzysztof Kozlowski
> >> <krzysztof.kozlowski@linaro.org> wrote:
> >>>
> >>> On 18/07/2022 17:38, Christian Marangi wrote:
> >>>> Reorganize node order and sort them by address.
> >>>>
> >>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >>>> ---
> >>>>
> >>>> This was picked from for-next qcom branch [1]. Reorganize dtsi as requested.
> >>>>
> >>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/?h=for-next
> >>>
> >>> If this is picked by qcom branch, no need to resend it.
> >>>
> >>> I don't see value in such reshuffle. Reviewing is not possible and you
> >>> did not mention tests (results should be equal).
> >>
> >> The value is usual for all the cleanups: make it follow the
> >> established practice.
> > 
> > Are you sure this is established practice?
> Yes.
> 
>  New DTSI files (see SC8280XP,
> > sm8450 although sc7280 looked ordered) do not always follow it, so why
> > imposing it for existing code?
> Perhaps it slipped through review.. Partially my bad.
> 
> 
> Such reshuffle can cause conflicts thus
> > stops parallel development. Review is close to impossible...
> Almost any addition or removal also causes conflicts, because git is
> not as smart as we would like it to be. If the commit is structured
> properly (i.e. it *only* changes the order and nothing else),
> decompiling the dtbs before and after applying it and using a tool
> like meld that can find similar chunks of text at different offsets
> review is definitely possible, though not very pleasant (you can't
> just diff them, as order is preserved & phandles change due to that)
> as you have to look at it manually and can't tell much by just taking
> a look at the email.
>

Can you give me an example of such tool? So I can put these data in the
commit description. I have to rebase this anyway as more changes got
merged so it might be a good idea to add more info about how this won't
make actualy changes.

> Konrad
> > 
> > Best regards,
> > Krzysztof

-- 
	Ansuel
