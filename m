Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97A350BDCD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353609AbiDVREL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346231AbiDVREH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:04:07 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7FF694AA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:01:12 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z30so633659pfw.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2ssm8SlVpUAdYUX8NJ5ygl5WmKBmGptdiRc0zZplIcQ=;
        b=MEa9TP9tUL4rIAWU8cn+2RmgeUo70g0LorhSa3S1wb2ol7+XaWCo7fg0SGU+foCc0Q
         fFDKNfX8ViL/anLjuy4WhSwKr66ytsjiLyC8mYgFsTClucVw1z5M2vNqzO6h4wi40jH2
         yz3D0z8p/jmWIc0ZTaEReosuR6wIfZkaLKLKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2ssm8SlVpUAdYUX8NJ5ygl5WmKBmGptdiRc0zZplIcQ=;
        b=75O9HRAYbI2eGh3cudYWoFqKOTWeFOiJ2zGGeL2KvVj2G6aVceGTbOyM04n7bIqpES
         pwf8JrVNaHW9JHjlivvvtqrMhyCBX+XN5M1zUcz3u92RcAEqwOiUw7wBAR5SNPMNoc5t
         WyLsBoGMAarChKGcQNBJOL8xTNhvBV5c+wXsN2HQlghQrUfUmHM0U/lAvaXxGiqwuJFo
         XzAexBMbgw3mNjPEhBDfqSmrhR87bCVJv7mRW6xBq9wCBx21T09OAzUeIrQ8raFbh07d
         1MLPm1QhB5H7aFKSwHoS5+fWMPV0b1ku2vfy+dbl4uQ5C022aa/viNpVTMlDwm6bxypA
         t7dw==
X-Gm-Message-State: AOAM5320OAEo9vpTbECOXE4rb36DeHfN5dhiuJR6+7eUx57pyKZk6TyB
        EsECBveEgnMRtHXWvI4pwEU7cA==
X-Google-Smtp-Source: ABdhPJzU9uCn+3NGsSMPcHFyJiMo+chnryIKI5u5Sd9aSdva7FAxl8UUtQSYGo5bCSnGTYue8MwIWw==
X-Received: by 2002:a65:6543:0:b0:39d:5e6e:24c3 with SMTP id a3-20020a656543000000b0039d5e6e24c3mr4731509pgw.560.1650646871636;
        Fri, 22 Apr 2022 10:01:11 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:404c:8721:29:87a4])
        by smtp.gmail.com with UTF8SMTPSA id l5-20020a63f305000000b0039daaa10a1fsm2611881pgh.65.2022.04.22.10.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 10:01:10 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:01:09 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v10 11/12] arm64: dts: qcom: sc7280: Add sound node for
 CRD 1.0/2.0 and IDP boards
Message-ID: <YmLfVd6MrIKIQNt8@google.com>
References: <1650636521-18442-1-git-send-email-quic_srivasam@quicinc.com>
 <1650636521-18442-12-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650636521-18442-12-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 07:38:40PM +0530, Srinivasa Rao Mandadapu wrote:
> Add dt nodes for sound card support on revision 3, 4
> (aka CRD 1.0 and 2.0) and IDP boards, which is using WCD9385 headset
> playback, capture, I2S speaker playback and DMICs via VA macro.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
