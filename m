Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADF14A894A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiBCRH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiBCRH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:07:28 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2773FC06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 09:07:27 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o16-20020a17090aac1000b001b62f629953so10598605pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 09:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LJp09xp8M+uPz3Zlp081AW6/VRw1By1H8gO/Cef3cHM=;
        b=Adjh+T+uMn674K4lzSPEJAOpNaiO0jvKaXqteiO+51Q25gNHZ0YDnj8MXXM2f6ibRN
         XWE1E3TNYEGYF4gqqPa6wBgMUEggrkOkie5/EOw77olyQeOmi8/yiRbc5pwWanV02BRY
         L+6njpOsMrmUmGjN6zB6Rn8Z+b18QkFYGZWVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LJp09xp8M+uPz3Zlp081AW6/VRw1By1H8gO/Cef3cHM=;
        b=Yqk2Hsvi0NBdPCHEJ8nyhVgWRRN+CXOf25vsWWLkVMdPWGV7qfzh+CsQWX7WXZ3DDX
         uMiIuszd7Cokm6d6KuS1AY/XlWxXnoqzIzNlvxMsSSVUr0w/iT5NzcDTfiNmPqHDRsfP
         Y2KfD2TlxMSPOXJvUl09iPVDPAayIohHJcrlvcbtE99cY8EJb2wVZk8quP+F6xFPA1mV
         umM8LowKVw5uXGhvMbzLlK7JbF7+Rqd3VrXfVU7Sp9mcH6AV2VzbXrHX+QjIE3HJHRvQ
         qKSiTCDnMCmMzgkSLc8f27xR1DzrU147DtUD2+rHIaHI/snIsPtUtTTSX51d+RLwt/zR
         FL3g==
X-Gm-Message-State: AOAM532efSAjrSb42OKgmhn44HHJHF7pcGsbCRpzuPvpNRm0aVRJdH8n
        NDYT6mz6d8wC7qpqpu+zFTzUEg==
X-Google-Smtp-Source: ABdhPJwlQtEnkwSVb6H/ujF0qK6GiHZBbZkSdS5LPsi/mn5p/6hLJIxQDWBkk3LMCBzm6bPY7W1VsA==
X-Received: by 2002:a17:90b:33d2:: with SMTP id lk18mr14724761pjb.224.1643908046695;
        Thu, 03 Feb 2022 09:07:26 -0800 (PST)
Received: from localhost ([2620:15c:202:201:c0cb:3065:aa0:d6c9])
        by smtp.gmail.com with UTF8SMTPSA id mi11sm10907797pjb.37.2022.02.03.09.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 09:07:26 -0800 (PST)
Date:   Thu, 3 Feb 2022 09:07:24 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        pmaliset@codeaurora.org, quic_rjendra@quicinc.com,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        kgodara@codeaurora.org, konrad.dybcio@somainline.org,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        sibis@codeaurora.org, swboyd@chromium.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/14] arm64: dts: qcom: sc7280: Move pcie1_clkreq
 pull / drive str to boards
Message-ID: <YfwLzJP/QuBJasAq@google.com>
References: <20220202212348.1391534-1-dianders@chromium.org>
 <20220202132301.v3.8.Iffff0c12440a047212a164601e637b03b9d2fc78@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220202132301.v3.8.Iffff0c12440a047212a164601e637b03b9d2fc78@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 01:23:42PM -0800, Douglas Anderson wrote:
> Pullups and drive strength don't belong in the SoC dtsi file. Move to
> the board file.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
