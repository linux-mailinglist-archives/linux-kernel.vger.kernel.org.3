Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C3050BDBF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352712AbiDVRBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiDVRBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:01:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D7260D89
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:58:07 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id s14so12111302plk.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nsFsSZ9xU/v0PMYpVq83wyniIq3VfJOQeOaPDdSEOLU=;
        b=gmu6AGMNw0UpOEQCmqAYanxSJtRw0aGzPIAgdVQsj6Hzg6iRJ6IIHr9suloBpbhg/H
         eI8fvM3Xm2W8Fva8iE5Z1M8en9AuTJdEIwmfCTlqInVJpfLkmwcko0sQMT0cyiRjtkUv
         Cx5Zc4UKsgxi/7D1AktfN/Ykm33o7Qt/Y9eG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nsFsSZ9xU/v0PMYpVq83wyniIq3VfJOQeOaPDdSEOLU=;
        b=JADuN0PHtDZUg9SFMdPKdbTOjErXM/8sMtRyAr6DczzHnC3zIa19knhjctwvj4EY73
         /6CR+TNVS1w9/ifqydRAFxPzdu9dpqTCvJcGyU5wmnBbOSz6Im8OIvQoyn8KGgrnOLXd
         YhF3rDriw5P990FZMp2ytDR7gbi/knS4NpmZ0eA6AtY/+CHJvTmWiieaJzYY2vJa+ca9
         9vNzeTMwwWd4EBKK4cnUfStEFtdc7PVu2ZJ4OjyksQ4rieRixqoOmsarWWLAGW/kyOXq
         /GQf6hiWL08YB35LArIQswbnXaK9z9gM0gy2Jr0AuE/kUmas8zIO0cO1xdPoiQcR78d9
         6qSA==
X-Gm-Message-State: AOAM533laT3v48dv2kZchb2M2Bk/aFguB6QoEKRNUC6kHmdN4QCifwGD
        uNXGbpxIZSiMexMqoPtmNwLX+g==
X-Google-Smtp-Source: ABdhPJx8Ai6tZ7rW1kUYJ3DGMJkmpGNHbBnH3oDMcjTtP7yTqj8ZF4SQmjQ9j8/CvfFqmenW9pt5ow==
X-Received: by 2002:a17:90a:193:b0:1d5:a5dd:852 with SMTP id 19-20020a17090a019300b001d5a5dd0852mr6368897pjc.176.1650646686813;
        Fri, 22 Apr 2022 09:58:06 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:404c:8721:29:87a4])
        by smtp.gmail.com with UTF8SMTPSA id c18-20020a056a000ad200b004cdccd3da08sm3338421pfl.44.2022.04.22.09.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 09:58:06 -0700 (PDT)
Date:   Fri, 22 Apr 2022 09:58:04 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v10 07/12] arm64: dts: qcom: sc7280: herobrine: Add
 max98360a codec node
Message-ID: <YmLenJYD2dSlvmd+@google.com>
References: <1650636521-18442-1-git-send-email-quic_srivasam@quicinc.com>
 <1650636521-18442-8-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650636521-18442-8-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 07:38:36PM +0530, Srinivasa Rao Mandadapu wrote:
> Add max98360a codec node for audio use case on all herobrine boards.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
