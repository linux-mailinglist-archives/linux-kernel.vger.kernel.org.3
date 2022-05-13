Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D06526A75
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 21:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383786AbiEMTgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 15:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383692AbiEMTgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 15:36:43 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D17E271A
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 12:36:42 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id i24so8519302pfa.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 12:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MVy7iZsksoOMOAm3NNokxlKH1OgviSGLirV/jH2bp6g=;
        b=oT5OvAp1Zz7AUlM0aKl+8ZIvs1C599gkbilzsnIpz1AO0oVZtegSofmqZGgF3owSwx
         e8aeEmF7v4n8qZXGa+DBCVXRNsxBwn4zoGlpEV6qhQ787uUrQWaSqVnM7yebGfhktUlW
         vTbi4mb7fLQDubyl82mTHh+SczIl1wnGaEF44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MVy7iZsksoOMOAm3NNokxlKH1OgviSGLirV/jH2bp6g=;
        b=YNRFmNOFtxSRxEgp3T0s8JaE1EHZaXkYAOwFI/3kTSXANBnQ/vT9whe7Uzonu2n076
         SOF5g/P3UXnogwoaw8wZbB66GTtMS1/XzUG11Wk8aNSCwWO1kvvcOs3L/D9g0XMN6IQL
         8jfPyZzRZrD34AXQIKA5Q3Hozfvru2jiRDnsEsXm7qxA3gJNJlgq2vy2kq0EsdS8zXgf
         YAwFZPHsIk/QecAFpRpJOKYu1siqlZsC4ftEkPNaEOgr8is9gHANA+tQRakY6UYh4p9t
         EGLtzK1Vij3jMQILMOYwm98J2oAX4bDkXlytWa5cpxf9lwrl9ooDubbdeJU6mdMCASdS
         pgVw==
X-Gm-Message-State: AOAM533nmaqsWNKSAj2hNRgJ32nwy7Mo2cfGWmZp8xNXjLsBQ489wPot
        W2KlJLF+m2ewq9HtTf8+wrfNKA==
X-Google-Smtp-Source: ABdhPJxGphb+a3j/4IMs2jeADD8wkkmOnIgagtQf5njkuMbaHesyMm7dlmo28dn15Im4KjxHYXi02A==
X-Received: by 2002:a63:605:0:b0:3db:a8bc:fb71 with SMTP id 5-20020a630605000000b003dba8bcfb71mr2548020pgg.125.1652470601682;
        Fri, 13 May 2022 12:36:41 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:bc87:9632:bcce:8e17])
        by smtp.gmail.com with UTF8SMTPSA id l17-20020a629111000000b0050dc7628186sm2181056pfe.96.2022.05.13.12.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 12:36:41 -0700 (PDT)
Date:   Fri, 13 May 2022 12:36:39 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Alexandru M Stan <amstan@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: arm: qcom: Add / fix sc7280 board
 bindings
Message-ID: <Yn6zR5k5EwP+qFBr@google.com>
References: <20220513095722.v2.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
 <20220513095722.v2.3.I1318c1ae2ce55ade1d092fc21df846360b15c560@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220513095722.v2.3.I1318c1ae2ce55ade1d092fc21df846360b15c560@changeid>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 09:59:19AM -0700, Douglas Anderson wrote:
> This copy-pastes compatibles from sc7280-based boards from the device
> trees to the yaml file. It also fixes the CRD/IDP bindings which had
> gotten stale.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
