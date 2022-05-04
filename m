Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2308F51B0AC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240385AbiEDVg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238121AbiEDVgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:36:25 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A63C4E399
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 14:32:48 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id x12so2148282pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 14:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WjEPs1op8LxvfkfWukwIS5BU2GeJEGL3fw9qBagDE0I=;
        b=N39qyWd0B9QXcrtEOgpz+XlRsSUtsOaISsV//j38XXGM2Hz30Y3BuDkZPsjNuL9JlH
         VmfX4usEBxTLo/kc3iHbcTUXTBYqZ085pa+hYck48mTkCv2C8SrIGBPWgRNOExixQcYZ
         6mA+JXh8aMwkih5IYrvVTvRd04xT0A6AqAZ0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WjEPs1op8LxvfkfWukwIS5BU2GeJEGL3fw9qBagDE0I=;
        b=hhVfU7QIjyscRSODtFNxTIh8/vVeKZZUsaQy3bNwLaKrt3l9rlae8t7WX96J+ImxYb
         Xo0fWKYbbaKyXdzCxMq0YIAh8Op+cCY9uM+cYdeDQcQDBqb9dx/9HbYYnX7f1/j22kE7
         Y5AMrMJt0Ae7DoHHF0+YkCVDei1TLLv+Q+x0T9LtIy4H3WUTfGg/cP2Y/g5YOR0mQlQq
         pp2uVNZGZWgq0KKZBR6VIexveQ87aWvh1dQRoFDylY6qtqeB/I4MhdKLdpwHpVHdbX7Q
         YmEFwviqNA7lAQCyUyBgQWEqwknwVTrQ4zrCkJjRJu55adldVVRbaMprJeiyC7rgs1n9
         Xxgg==
X-Gm-Message-State: AOAM530BAgCwl7gT+PHnfoBTPS8SdsM7ZurE8dWtRKX8iGGmIDfiI9A8
        R0hDFvZ0+IEF7S3Ydz/mUg1dkg==
X-Google-Smtp-Source: ABdhPJxwBSF1pIaHNG1nGISIY7eznOLyP5goqHIsXBFpaErUNk/5iojUC7knD+9FCtCBOkmQbxSiDA==
X-Received: by 2002:a62:bd14:0:b0:50d:4bec:ff78 with SMTP id a20-20020a62bd14000000b0050d4becff78mr22482662pff.71.1651699967711;
        Wed, 04 May 2022 14:32:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:35b6:c77b:be04:3bd5])
        by smtp.gmail.com with UTF8SMTPSA id m31-20020a63581f000000b003c2677c9c9esm3905015pgb.67.2022.05.04.14.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 14:32:47 -0700 (PDT)
Date:   Wed, 4 May 2022 14:32:46 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v11 04/12] arm64: dts: qcom: sc7280: Add wcd9385 codec
 node for CRD 1.0/2.0 and IDP boards
Message-ID: <YnLw/tw1FzAPtKSo@google.com>
References: <1651664649-25290-1-git-send-email-quic_srivasam@quicinc.com>
 <1651664649-25290-5-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1651664649-25290-5-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 05:14:01PM +0530, Srinivasa Rao Mandadapu wrote:
> Add wcd9385 codec node for audio use case on sc7280 based platforms
> of revision 3, 4 (aka CRD 1.0 and 2.0) and IDP boards.
> Add tlmm gpio property for switching CTIA/OMTP Headset.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>

Carrying over from v10:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Coming back to my earlier comments about per-patch change logs:

The cover letter change log looks like this:

Changes Since V10:
 -- Modify digital macro codecs pin control labels.
 -- Updated dependency list.

Changes Since V9:
 -- Move wcd codec and digital codec nodes to sc7280-qcard file.
 -- Modify the reg property as per link number in sound node.
 -- Fix the us-euro pin control usage in wcd codec node.
 -- Move wcd pin control nodes to specific crd board files.
 -- Sort max98360a codec node in alphabetical order.
 -- Modify the commit messages.

...

There is no mention in which patches changes were made, in some cases
you can guess it, in others not, in any case you are placing the
burden to figure that out on the reviewers even though you already
have that information. So please send future series (this one is
hopefully close to landing) with per-patch change logs.
