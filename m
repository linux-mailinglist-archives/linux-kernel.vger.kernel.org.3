Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CFB4E2B94
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349873AbiCUPQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241870AbiCUPQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:16:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF81EDF0B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:14:39 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d18so13018050plr.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vi2+JCSaediMV4fIRxpn8hEQFvyNR6zHSaSxlfbydg8=;
        b=mLSbZHC5mXRJErPc17RhtONtOQCHY8pq0NzHcS7uaZ910+4dxBn9jTc0IKBXhFIuhs
         ccpSCGG4YvS1YN8hLFwH9A5NWkZfCHOywaFpvlU4UTxmL0QBCB1k3SuyD7GUEQzF+U+u
         AKPENS44CZC7tmpv3Ny11bGHLN9JK8YhNonpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vi2+JCSaediMV4fIRxpn8hEQFvyNR6zHSaSxlfbydg8=;
        b=5a/vcMeiSSZw6Qy0TShKqOFrgcMsLOPp2PaeNTRQka52Gd1g0obtHvVVf5Xs93QUYy
         caBMX1OXSG+lLefjq7Nnc2GBZgaNxE0LIA+3sbJv8GBJX+ZB/XX2PxOq+vOuzSmoUNAf
         ssy0XTeexCk1YA7brXLGyw+QIGPKM0LRQf61G7jKgwQslHvQxpNWyz9FJ/FAClknQzoj
         NIxAcHlj2wGxcxJB3ymmKBGpDu5q+M8efFMxUZckA5+1m63wJZX87KtphFEXI4hcjKNR
         eqmrdLowmHUMDJlxlH+x8uTQN2KRblu9tXgIKOXX8g4K6lZ+bMKB2RfA6UwvyLLbVTsj
         LBwQ==
X-Gm-Message-State: AOAM530ky2NBHAUesSzFOFFuRdkMkdXP8LNjB0M4JUarMuIo1pduQWu3
        llIGHHxSNEX+RuyAyJiZczAjpg==
X-Google-Smtp-Source: ABdhPJxSC/CLQYd2LeqNM7sSaZIcmei/abLlLofHzwrzcpTZquto/ceY3Edydh9kY4LGGH98pFuBMQ==
X-Received: by 2002:a17:902:ce8e:b0:154:2ebc:8d49 with SMTP id f14-20020a170902ce8e00b001542ebc8d49mr11701225plg.135.1647875679186;
        Mon, 21 Mar 2022 08:14:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b32a:e805:a393:534b])
        by smtp.gmail.com with UTF8SMTPSA id s3-20020a056a00194300b004f6da3a1a3bsm20367875pfk.8.2022.03.21.08.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 08:14:38 -0700 (PDT)
Date:   Mon, 21 Mar 2022 08:14:36 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] arm64: dts: qcom: sc7280: Add 'piglin' to the
 crd-r3 compatible strings
Message-ID: <YjiWXA40Nh0jBPO9@google.com>
References: <20220316172814.v1.1.I2deda8f2cd6adfbb525a97d8fee008a8477b7b0e@changeid>
 <20220316172814.v1.2.Ib0fbb7e5218201c81a2d064ff13c9bc1b0863212@changeid>
 <c808dc08-09c8-bb08-6656-18dd649af036@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c808dc08-09c8-bb08-6656-18dd649af036@quicinc.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 11:14:56AM +0530, Rajendra Nayak wrote:
> 
> On 3/17/2022 5:58 AM, Matthias Kaehlcke wrote:
> > With newer bootloader versions the crd-r3 (aka CRD 1.0 and 2.0) is
> > identified as a 'piglin' board (like the IDP2 board), instead of 'hoglin'
> > Add the compatible strings 'google,piglin-rev{3,4}'. The hoglin entries
> > are kept to make sure the board keeps booting with older bootloader
> > versions.
> 
> The older bootloaders really look for the google,hoglin-rev3/google,hoglin-rev4
> compatibles or just google,hoglin? If its just google,hoglin, won;t it pick the
> crd-rev5+ dtb now?

They look for the -revN compatible, I confirmed that on my CRD 2.0.
