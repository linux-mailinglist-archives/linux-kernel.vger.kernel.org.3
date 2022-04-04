Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABF94F2030
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240460AbiDDXUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243826AbiDDXTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:19:41 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D05E52
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 16:17:35 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-de3ca1efbaso12567900fac.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 16:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=3oavjVNL5tvXCS8rCyRmNRZyTNOmhHfeYfiVBThyPpY=;
        b=X40oLTAq3dSUcjtkQd9V5X6dkLJqgWLCPb38tSrT2KASFKB4M72dgY9+i9r7tRkAJX
         2WFTZ+Ls9Q46VhlgNLPHIorWQUAP/fwrYFHj1hg36kmxAgfvB+wWX1Daa4Fr7NL50Jwn
         6vlDJZw+urzzAJIWP9KHH0jDXdF4AqjIXKi3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=3oavjVNL5tvXCS8rCyRmNRZyTNOmhHfeYfiVBThyPpY=;
        b=roXdjBManjsYC/jCyW/2WBQa5q9nRdDKYgnb1/y//fjAohzN1ssCjoqddu6ngRgmvs
         KDKud4S+MJ1FiU1PjmS2lYARgScXgW9VEtF0ZDyFxM4IkpOMisy/ktQs7dT7veo5lt2i
         QlAwZ5hb8TGtXD5+FiaQGiXgSj2NPHDEyIQ5E0mc6t3naCY8EQpsOrNO5G+eM/gkni/y
         0IY/2LTqOdIk1YTcyw2BwRPR6daoVhMPsnpKrhVcWOwU8MTy3570xqBBWhjVCo8zCyyc
         Wxz+BxpV4uoP57Zm8gWNOK7v0xUvzAjJuje2odkyyX1VjtOps67k0voU2jk7RI6BGrkx
         j77g==
X-Gm-Message-State: AOAM533nj9dw2N7ml/dE4bfKrsG7T3OhK/taEOF/kxgolcEU3LcLiiyU
        aGJzRDcVvXQf4bS0uaMReJ3PWPHxpbeeIyetL8qxRw==
X-Google-Smtp-Source: ABdhPJw/tm7Cn1JQZT4ViERftJOcoWdd0d2O+5vIOoyfW+N1pdWhsxvqITjnxp3nXTPe4Psm2WQze1TU1CgHCqhalIQ=
X-Received: by 2002:a05:6870:558e:b0:e1:db7c:26aa with SMTP id
 n14-20020a056870558e00b000e1db7c26aamr274655oao.63.1649114255219; Mon, 04 Apr
 2022 16:17:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 4 Apr 2022 18:17:34 -0500
MIME-Version: 1.0
In-Reply-To: <1644813252-12897-1-git-send-email-quic_sibis@quicinc.com>
References: <1644813252-12897-1-git-send-email-quic_sibis@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 4 Apr 2022 18:17:34 -0500
Message-ID: <CAE-0n51qygskCKAv7MwJmM8BVV2D0wT46YCBwxtGKybP4QA+jQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add support for proxy interconnect bandwidth votes
To:     Sibi Sankar <quic_sibis@quicinc.com>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     ohad@wizery.com, agross@kernel.org, mathieu.poirier@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        krzysztof.kozlowski@canonical.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2022-02-13 20:34:09)
> Add support for proxy interconnect bandwidth votes during modem bootup on
> SC7280 SoCs.
>
> Sibi Sankar (3):
>   dt-bindings: remoteproc: qcom: Add interconnects property
>   remoteproc: qcom_q6v5_mss: Add support for interconnect bandwidth
>     voting
>   arm64: dts: qcom: sc7280: Add proxy interconnect requirements for
>     modem

Is this patch series going to be resent? Does it need to be applied to
sc7180 as well?
