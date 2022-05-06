Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9716651DAD2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442322AbiEFOol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348175AbiEFOoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:44:38 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDB5393CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 07:40:55 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-e5e433d66dso7381895fac.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 07:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=F82bZ9DmI62a6GWEEGersqAdKfD7GSoQLwzO2u5c+7Q=;
        b=EZyLNnvq88yM5iivGZeAhz9yUVcV+I/8pU1Bkf8ifgeGEcKCmanjgFOxfEnRGtpik0
         gnOangLfle/l8mqcajj8i2O5PFzENnsaCfNOnMTjApkQRkMic5hXELKUKuexPHHsh4xh
         xhpBnTM+W+CQ6Ju0zQFm5BWqvCb3sEyPNAylg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=F82bZ9DmI62a6GWEEGersqAdKfD7GSoQLwzO2u5c+7Q=;
        b=WGjmvb78ZOdQFu1stqF5w8QHbAcpxRm2swRYgkT/AcJCbWU7LfWoHaOQwVEL/lxWsf
         2p9qsLfiWpE8032GrGPbdPhmU9bB+eLLc5FJ5C7FLMDgmc4lA3NfGNGcXKdG98jctCbi
         O/MoU+eaeQt4jmOaHZ4WEaxRzSRZx9rhvC6wzlNqPYQ1MHy7sw8uDLBGOXl8QStvKAfj
         YyRMXOkNh1kM5cOl3xsEoFKRpw1PuIMHTtJ/+A0SkSPoHO3j9JM5WPxIkemuagPQHLci
         j/3qUc7XVRWnDyccToXpUOdWPW++gslQvg4vSe8kmhwSNCSoNuyqEokHnNhN/8ye5SaV
         FmMA==
X-Gm-Message-State: AOAM531vbN7OiFyLew8ojAKTOLyfw7XfhexW2WCzxSHOs/5RHxBh91gF
        eU44WO60sex8JIWRkWMdlHQGpHV3RU7278WW1NDl9znhxqM=
X-Google-Smtp-Source: ABdhPJxN0yptjNkxQGuaxRHu1excLtNj9MDZpVR1yVH8NLGHwEiPJNV3RJgc5+rmGuPNF6+nXeKc5DjH0O901xDuADY=
X-Received: by 2002:a05:6870:558e:b0:e1:db7c:26aa with SMTP id
 n14-20020a056870558e00b000e1db7c26aamr1469962oao.63.1651848054799; Fri, 06
 May 2022 07:40:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 May 2022 10:40:54 -0400
MIME-Version: 1.0
In-Reply-To: <1651742739-12338-3-git-send-email-quic_c_skakit@quicinc.com>
References: <1651742739-12338-1-git-send-email-quic_c_skakit@quicinc.com> <1651742739-12338-3-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 6 May 2022 10:40:54 -0400
Message-ID: <CAE-0n52E6kgXuRRnwcm+koc_5C9OV2Ttwua=9mQLc8VafHg=cw@mail.gmail.com>
Subject: Re: [PATCH V11 2/9] dt-bindings: mfd: pm8008: Change the address cells
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_jprakash@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-05-05 02:25:32)
> Change the address cells as '2' so that the first cell
> describes the i2c address offset of the clients.
> This helps us to define the child nodes of all
> clients under the same parent mfd node, instead of
> adding separate mfd DT nodes.
>
> Change the gpios reg value accordingly.
>
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
