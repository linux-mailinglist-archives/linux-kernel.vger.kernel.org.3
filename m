Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17933579849
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiGSLS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiGSLSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:18:55 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4A4402E2;
        Tue, 19 Jul 2022 04:18:54 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so11724429wme.0;
        Tue, 19 Jul 2022 04:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=JbnYQuui70Y/Ms1wXAVwGJwZJLjCCiU12nP+XPGmJC8=;
        b=JPG4epajEQbHfiUIeMJJt3pFNUKqqmyUkXJ/02Q5rn3s4j3Nlk+w2TmvLm7HlyGEr2
         4NhVjOuG2SRyd3ZIfihEwdh7qr9RY2t83kPYsdG3NQMk0qxO3OUrVBYtAtI9+7GwbmVl
         APSPjCQKQifyP8kyMnfJ4+M4JLa0IUVOpoIilTfI+kdkffzGMf8O5alcgYM/ccnA5QBE
         95wM0PcLdPivefROvGGN+csoiKmQEAWDFLmagx/Tt1f7if3v5LrirjipcDqyQOxied6+
         bXbHSa2gxlGe8ELY8vWxyn6IQcvzeBfjtutElhNAZ70Vc5PqIETe4vZ0JyRq7CbCLXyY
         p0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=JbnYQuui70Y/Ms1wXAVwGJwZJLjCCiU12nP+XPGmJC8=;
        b=Z6dqwqHFHehfP0EHArqW9gjIF2i4MZk7Z5enhL697Ycg9LiBPvkpjXUIZ4Z797t/Jv
         AIerrw+VgZSHGL/IlCs8B9fFcKR5OMMRc9e6Ca6ImLZpW9xhgkCZknDVqj7mvErQbEku
         cp2Xto4kYwnSmU9qwqIuvfx8Ygnrg8oNkqqx3kFa0PieleYnpg2wd6v1qEphrAYke4SY
         VFpGfeo6GS7zAUTHUP3wKkChroa/CuTKepSfYkXB24E92axla5GAiLcABWHXr2ech12Q
         ep6+cBJqXiMoA622SRSAk3r7RCOMNn+H9AxNIO4ytLd1uGKPxme0tRnriVfpKdxW4Onp
         8lrQ==
X-Gm-Message-State: AJIora9GW2JoJMS96cm1N+4YCqpe+bNrzxuJAZbJccWY4j5ctQskQjj6
        oP8v5PICPlRtmdltRyqsXpnKd65sySE=
X-Google-Smtp-Source: AGRyM1vCH8CxH4xNyPG04XJoYjHl39Y3c/BK5BAWRUStY/i2wFc5kUaMXeX+FP/mbcVaq0uBTpakrg==
X-Received: by 2002:a05:600c:4e49:b0:3a3:117b:f785 with SMTP id e9-20020a05600c4e4900b003a3117bf785mr15654529wmq.138.1658229532882;
        Tue, 19 Jul 2022 04:18:52 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id h18-20020a05600c351200b003a3199c243bsm10680763wmq.0.2022.07.19.04.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 04:18:52 -0700 (PDT)
Message-ID: <62d6931c.1c69fb81.8b9a9.8594@mx.google.com>
X-Google-Original-Message-ID: <YtZ1cJ18fI5CSL92@Ansuel-xps.>
Date:   Tue, 19 Jul 2022 11:12:16 +0200
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
 <62d68f9e.1c69fb81.985fb.30aa@mx.google.com>
 <a4c805c3-8d78-98bd-40be-204fe98e6153@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4c805c3-8d78-98bd-40be-204fe98e6153@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 01:14:07PM +0200, Krzysztof Kozlowski wrote:
> On 19/07/2022 10:57, Christian Marangi wrote:
> > On Tue, Jul 19, 2022 at 12:56:18PM +0200, Krzysztof Kozlowski wrote:
> >> On 19/07/2022 10:19, Christian Marangi wrote:
> >>> On Tue, Jul 19, 2022 at 12:22:24PM +0200, Konrad Dybcio wrote:
> >>>>
> >>>>
> >>>> On 19.07.2022 12:16, Krzysztof Kozlowski wrote:
> >>>>> On 19/07/2022 11:59, Dmitry Baryshkov wrote:
> >>>>>> On Tue, 19 Jul 2022 at 12:56, Krzysztof Kozlowski
> >>>>>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>>>>
> >>>>>>> On 18/07/2022 17:38, Christian Marangi wrote:
> >>>>>>>> Reorganize node order and sort them by address.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >>>>>>>> ---
> >>>>>>>>
> >>>>>>>> This was picked from for-next qcom branch [1]. Reorganize dtsi as requested.
> >>>>>>>>
> >>>>>>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/?h=for-next
> >>>>>>>
> >>>>>>> If this is picked by qcom branch, no need to resend it.
> >>>>>>>
> >>>>>>> I don't see value in such reshuffle. Reviewing is not possible and you
> >>>>>>> did not mention tests (results should be equal).
> >>>>>>
> >>>>>> The value is usual for all the cleanups: make it follow the
> >>>>>> established practice.
> >>>>>
> >>>>> Are you sure this is established practice?
> >>>> Yes.
> >>>>
> >>>>  New DTSI files (see SC8280XP,
> >>>>> sm8450 although sc7280 looked ordered) do not always follow it, so why
> >>>>> imposing it for existing code?
> >>>> Perhaps it slipped through review.. Partially my bad.
> >>>>
> >>>>
> >>>> Such reshuffle can cause conflicts thus
> >>>>> stops parallel development. Review is close to impossible...
> >>>> Almost any addition or removal also causes conflicts, because git is
> >>>> not as smart as we would like it to be. If the commit is structured
> >>>> properly (i.e. it *only* changes the order and nothing else),
> >>>> decompiling the dtbs before and after applying it and using a tool
> >>>> like meld that can find similar chunks of text at different offsets
> >>>> review is definitely possible, though not very pleasant (you can't
> >>>> just diff them, as order is preserved & phandles change due to that)
> >>>> as you have to look at it manually and can't tell much by just taking
> >>>> a look at the email.
> >>>>
> >>>
> >>> Can you give me an example of such tool? So I can put these data in the
> >>> commit description. I have to rebase this anyway as more changes got
> >>> merged so it might be a good idea to add more info about how this won't
> >>> make actualy changes.
> >>>
> >>
> >> scripts/dtc/dtx_diff
> >> fdtdump + diff
> >>
> >> There should be an empty diff from at least one of methods above. If you
> >> have a difference, I am not sure how can we verify this.
> >>
> >>
> >> Best regards,
> >> Krzysztof
> > 
> > This [1] is the output of dtx_diff.
> > The file diff is just phanle change that are related to the node order.
> > 
> > Seems a nice way to verify if the shuffle didn't drop any node.
> 
> Therefore run the second method - fdtdump.
>

The output I have with fdtdump keeps the original node order so it doesn't
produce correct correct diff as it will find difference with moved
nodes. (unless i'm calling fdtdump or diff with the wrong args)

> Best regards,
> Krzysztof

-- 
	Ansuel
