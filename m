Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85A753EEE2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbiFFTvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbiFFTvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:51:19 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C66663DF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 12:51:18 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-f2bb84f9edso20421093fac.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 12:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=wUE0WYijKz/I9WB3BAXy+vr8DpFKXrMlnfOuumpeD0s=;
        b=cs4bfETKtnutHfKnMRa8EDDF/SGg0Ol3SZDgvq2v6rDjqMPEVozqvGlftR+7NtXnnx
         ZFfs0bZ5sKKXhTYSPNDrousmupAvxoLeIv0BCTQHDt393fs72j4NHYDc4HLULrjZSHX2
         1tPgngy5jRf1rRTLFlCDhojXu+H93PWIkKFnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=wUE0WYijKz/I9WB3BAXy+vr8DpFKXrMlnfOuumpeD0s=;
        b=SKiYDVT4YKse4YLi6CJs6gt0dIGkrpQr+G1AlxBpSDQRscYB2DUc5p9NAs3VEJN2RH
         aLpAnS0EYYvu1JD5bFjk1W6giFXZC4mBvxoDSXCtnIi7ZUezu5GJ6BP94Oe3xvFb/5uE
         XDURvyUjXFasAvUM4/j3atWPTyb4cBcM0Cu6aWxkk/SqWX1lR330LVk1nZOLK0rAY0dW
         JbhV+QDazpWT2La8XYxbZTVMkt23PvBM7rZqq01ngQlzpRSr+d5qR0HIndHjCr4olDvu
         h2vZpdjzLCJ9XPixxKGNT0EJzxS8jlZ6Rgxpc2t0UUxIIfAuJTcpXRqjaHM7cif7xRZg
         e+RA==
X-Gm-Message-State: AOAM532laHfhPBejD5G93anZVPfkTWd4ax6l8oSby7zFIqptPtW5HsB7
        caIuHT1F/usJZxes/MdnIPN/qsCotNTrwZbCRgxtjA==
X-Google-Smtp-Source: ABdhPJyA+8bj5MPF+OqCsgGfdq8U0lMbu6ZpxmSpJ/QCRTM+wYpE9wn/YOFZUpgt/HDEEtcKS0IhaqQHFdgpGb1STd8=
X-Received: by 2002:a05:6870:558e:b0:e1:db7c:26aa with SMTP id
 n14-20020a056870558e00b000e1db7c26aamr14772185oao.63.1654545077326; Mon, 06
 Jun 2022 12:51:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jun 2022 12:51:16 -0700
MIME-Version: 1.0
In-Reply-To: <1cbd12ad-4147-5d97-ef7f-4104b630244b@linaro.org>
References: <20220517193307.3034602-1-swboyd@chromium.org> <ceb32b66-1341-d54f-a60a-5c342119c784@linaro.org>
 <CAE-0n50rUW7Lqk4CwfSUgKYEJzwjXuVohAnbj9uKA=kEkXikyw@mail.gmail.com> <1cbd12ad-4147-5d97-ef7f-4104b630244b@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 6 Jun 2022 12:51:16 -0700
Message-ID: <CAE-0n504nsfiuvgs=c0gBA1CV-WAgQsYTdKCSdADJP480fhDVg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Remove ipa_fw_mem node on trogdor
To:     Alex Elder <elder@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alex Elder (2022-05-17 13:56:06)
> On 5/17/22 3:06 PM, Stephen Boyd wrote:
> > Quoting Alex Elder (2022-05-17 12:51:34)
> >> On 5/17/22 2:33 PM, Stephen Boyd wrote:
> >>> We don't use this carveout on trogdor boards, and having it defined in
> >>> the sc7180 SoC file causes an overlap message to be printed at boot.
> >>>
> >>>    OF: reserved mem: OVERLAP DETECTED!
> >>>    memory@86000000 (0x0000000086000000--0x000000008ec00000) overlaps with memory@8b700000 (0x000000008b700000--0x000000008b710000)
> >>>
> >>> Delete the node in the trogdor dtsi file to fix the overlap problem and
> >>> remove the error message.'
> >>
> >> Is the mpss_mem node (which defines 0x86000000-0x8ec00000) correct?
> >
> > I think it is. Modem is working for me.
> >
> >>
> >> You're right, we don't use that memory on Chrome OS, but I just
> >> wondered whether the other node might also have a problem.
> >
> > What sort of problem are you thinking about?
>
> At some point in the past I think some of these carved out
> areas got updated (perhaps on sdm845?).  I.e. they were
> wrong, and got corrected later.  Some things worked despite
> that.  So the problem, for example, might be that the
> mpss region is bigger than it needs to be.
>
> I don't *assume* there's a problem, I was just asking,
> and maybe Bjorn or someone else can verify what's right.
>
> I'm done for the day right now; otherwise I'd spend a
> little more time trying to track the information down
> myself...

Did you find anything? Otherwise, can you provide a Reviewed-by tag?
