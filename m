Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D214E6A85
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355257AbiCXWNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 18:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240339AbiCXWNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 18:13:31 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58C9A0BF9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:11:58 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so6480090pjp.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rgB6wQBNZL5Us/fhN+fvZAq6CyINYkA8oSSRX75u7u0=;
        b=FWvB3+owZDEtQZt08RkXl+l2pBVX3KtwfEnkTGRa3UK4p02H5FqNfJpFP6v5y8ezIL
         //skUivcm8U+2qGTCUXClU2OxpXrpo/PN61DdNAHt7mAX5fkfrTsK/ZmPgV51vaKMAC7
         2pKRH6b/hw1n6J1a4n9yeBETeYFp7PQt2b7fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rgB6wQBNZL5Us/fhN+fvZAq6CyINYkA8oSSRX75u7u0=;
        b=6w8GAq+qsPNj3k/JS6aJyylfENeiyOur/lk5qebLkbIvku6ZkhicRQ9ZzBhFNRztl0
         YMAckczMi/MP9EnMmOdWbb3F2DuVF5K112NeP8ClEaURIE5gylpMTi66JnQJWO9Ujyl3
         LXM9GIXqaPjfRa4mgRMfROox2X8WwxKA+Zx6rrXWkc6bZHzR4sn6x86PK2cDjKBTNsng
         +cpKgbDHrAMTUhymILxeBFA+gZ4nRStDE0S2Zf49cfgrmwspGWQliv2cKAzcqtM54NxO
         28w4A/CYCQGGynuKvwLIJwSaOdU8z3Uc8/+LQSbOtSoaaM8h7oMSqIgruakH2wtpSEdO
         cBcg==
X-Gm-Message-State: AOAM5303I4UluHIpmqrntY4/cfslECUEhF8yXVm+W2mwlmyG+jdX7lxL
        xSI4iEClMzK2r6jZ4CTnI4KN0XysfISNVQ==
X-Google-Smtp-Source: ABdhPJxPOu1ylzQy8wNkSGs4G0tUp4V0n/Yovs3nCbtGMhnLDP7RAXe8IHk/7EftxQpLPqaX0v9Mtw==
X-Received: by 2002:a17:903:3091:b0:153:9dcf:de71 with SMTP id u17-20020a170903309100b001539dcfde71mr8127700plc.7.1648159918355;
        Thu, 24 Mar 2022 15:11:58 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:690f:642:3ebe:c89d])
        by smtp.gmail.com with UTF8SMTPSA id q7-20020a056a00084700b004faeee0fcdfsm3633994pfk.33.2022.03.24.15.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 15:11:57 -0700 (PDT)
Date:   Thu, 24 Mar 2022 15:11:55 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Add device tree for
 herobrine villager
Message-ID: <YjzsqyEhxOLwJzUL@google.com>
References: <20220324101242.v1.1.Iebdb5af0db7d3d6364cb229a27cd7c668f1063ae@changeid>
 <CAD=FV=XchtJx3ZsL4Bxj29b_-43E8p2fiJ5SBQSzbW8wp+gNfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=XchtJx3ZsL4Bxj29b_-43E8p2fiJ5SBQSzbW8wp+gNfg@mail.gmail.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 12:59:51PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Mar 24, 2022 at 10:13 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Add a basic device tree for the herobrine villager board.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >
> >  arch/arm64/boot/dts/qcom/Makefile             |   1 +
> >  .../dts/qcom/sc7280-herobrine-villager-r0.dts | 274 ++++++++++++++++++
> >  2 files changed, 275 insertions(+)
> 
> Question: how does this interact with the patch:
> 
> https://lore.kernel.org/r/20220316172814.v1.3.Iad21bd53f3ac14956b8dbbf3825fc7ab29abdf97@changeid/
> 
> Specifically, if that patch lands first don't you need to add a patch
> to turn on "pp3300_codec" ?

Right, I missed that. I'll add it in the next version, thanks!

> I was also looking at whether we should be enabling the wf_cam
> regulators for villager. I believe that answer is "no",

I agree to keep them disabled.

> but _also_ I believe that we should be _disabling_ the uf_cam
> regulators for villager, right?

it is not clear yo me which regulator you have in mind for the UF cam,
could you clarify?

> > +                         "MOS_LAA_AS_EN",              /* 90 */
> > +                         "SD_CD_ODL",
> 
> I was somewhat surprised that "SD_CD_ODL" was listed here since,
> diffing this with Herobrine, it appears that Villager doesn't have SD.
> I checked the schematics, though, and I can confirm that the GPIO is
> named this even if it just goes to a testpoint on the board. ;-) ...so
> I'm fine keeping it here.

:)
