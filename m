Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AF455A5A2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 02:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiFYArO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 20:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiFYArM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 20:47:12 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE549792A3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 17:47:11 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id b125so3024765qkg.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 17:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oKczyqyJVXbwPP+eN8sAth8R0lhAg6AZnihqaYYUBRA=;
        b=RugWSFqunQ09plkfj1ThuMovNx8NR85FBmWxOQnjmCKgfHgQEmmnP60305jkJsdndI
         HkQI9u8W895QQbso6DdkTclFUERlmrT83EaiqnV94vasxjcMmdiac4GwL2yZwViAwk/v
         HHz26Gq5Fqu8G+Tp5CIMzXBJmJPAWeiIPA1YpFSp77gMOprozrILol5W4VVxRViw/4Ii
         rGTOquoPSkEyt4kt7G6LtMGCAPuu+TqpBwT7F/P57CcEiAgx18H6Lpr6WCAxL4mDoBUd
         qO7qFUx8434SYKqXEUZpRkUGH1RSozh8tFSqUoGIt1EMveGd1LBmyKsFaviNWvosUsid
         VqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKczyqyJVXbwPP+eN8sAth8R0lhAg6AZnihqaYYUBRA=;
        b=PtTPkDLIUjG/fPa10W0nv77STElJVThbP4TazmtNNPIIj6w0TUIh6RF6Tjn4/D7qU1
         E+fJ8pPvZpGAMIBmYRB17cK6InKiFhSvwveJ4QHbFhPMMzfPef+9u3FEPmCdTBisuHnu
         beVQWFs6nvzKugDuopEOVH8YoRVkkqW8DY+Eiqks6qxWOsxR8OyxRerNKag746s9jrbU
         1ogFkPWoQta4vqbTuQXBqdETFkdUJ9EyUsuQnoeyNBNgwljb8ZtefxUeOU7RFOLtE9wT
         Yu4BcVS3lSTN0Bp3CeP92o5ei6pMfxF5wM2/9wY7g251k0Gl3Pi76SxJ2/DL3xTDpsK6
         ro+g==
X-Gm-Message-State: AJIora8NvZSnNpSRmbVCt4CYpHlTlWNNKcF5bwkN2mfrqWUiTHeahJaY
        b+ouxLAMgyMYkUMsXPgWrfzG3TKjma1kTc/RDbpkWw==
X-Google-Smtp-Source: AGRyM1vQ1vDDBzdPJoGeWwsffL+nmSpD3bXYcuiqaJJ3hxzqY/MRBObekDuzlqII+ZoMkbx+3P9PZsnLsBcCxWn/v34=
X-Received: by 2002:ae9:ed56:0:b0:6ae:f7cf:7f5c with SMTP id
 c83-20020ae9ed56000000b006aef7cf7f5cmr1475378qkg.59.1656118030003; Fri, 24
 Jun 2022 17:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <1656090912-18074-1-git-send-email-quic_khsieh@quicinc.com>
 <1656090912-18074-3-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n52RW+UFJ=hqMWjwR8qvEbww7QjzPW1nhL3Atd97QXAnYw@mail.gmail.com>
 <007ea4c9-9701-f4ab-3278-5d36bf2018c4@quicinc.com> <CAE-0n53kNCK0ajHfY2WQr5HEQZtZSBLnhfbTuZwaUNEOZhsKPg@mail.gmail.com>
 <fa7f8bf1-33cd-5515-0143-6596df2bd740@quicinc.com> <CAE-0n51g-EVsC-i9=sJV-ySa8VnE+yT7cg=b-TNMi9+3uBiOVA@mail.gmail.com>
 <326912ff-9771-0711-366d-79acd436908b@quicinc.com> <CAE-0n51qrdrFtSr0vRwgYkMgSZfnzQuinaUROQsp30QoDchWQA@mail.gmail.com>
 <0ff3d6a3-dc5c-7c77-f8a1-6c4f6c1a3215@quicinc.com> <CAE-0n515hMKqQ+Vj1Sg54PpwkbWMYJ77QN+y+KZNBWymjhpWKw@mail.gmail.com>
 <66ff4642-f268-f5b0-7e28-b196368c508a@quicinc.com> <5cf094cf-343a-82d7-91c4-1284683f9748@quicinc.com>
 <CAA8EJprqq=vxXT2DmEWii_Ajx2UbkHRexPTT58xFcWkBa_D5hA@mail.gmail.com>
 <26263c16-8cbc-ccca-6081-7eba14635d73@quicinc.com> <CAA8EJpqEoXXA=eKGHRGuQ3VOHnmEShY8u_SMZ6WFWORCFhFcrw@mail.gmail.com>
 <8445f93a-00f0-64af-5650-07f2bc487742@quicinc.com> <CAA8EJpqB2KPyvFehK9WRGgiVnqvD24cz5BcHsw8a5PQ2Vs1oKA@mail.gmail.com>
In-Reply-To: <CAA8EJpqB2KPyvFehK9WRGgiVnqvD24cz5BcHsw8a5PQ2Vs1oKA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 25 Jun 2022 03:46:58 +0300
Message-ID: <CAA8EJppZdyutyNBG+OFinickQoDxg0i4GwbaNQubo_LSRWNh4w@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] drm/msm/dp: decoupling dp->id out of dp
 controller_id at scxxxx_dp_cfg table
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dri-devel@lists.freedesktop.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org,
        quic_aravindh@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jun 2022 at 03:28, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Sat, 25 Jun 2022 at 03:23, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
> > On 6/24/2022 5:21 PM, Dmitry Baryshkov wrote:
> > > On Sat, 25 Jun 2022 at 03:19, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
> > >> How can I have eDP call dpu_encoder_init() before DP calls with
> > >> _dpu_kms_initialize_displayport()?
> > > Why do you want to do it? They are two different encoders.
> >
> > eDP is primary display which in normal case should be bring up first if
> > DP is also presented.
>
> I do not like the concept of primary display. It is the user, who must
> decide which display is primary to him. I have seen people using just
> external monitors and ignoring built-in eDP completely.
>
> Also, why does the bring up order matters here? What do you gain by
> bringing up eDP before the DP?

I should probably rephrase my question to be more clear. How does
changing the order of DP vs eDP bringup help you 'to fix screen
corruption'.

-- 
With best wishes
Dmitry
