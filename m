Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF2147F087
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 19:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353420AbhLXSKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 13:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353413AbhLXSKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 13:10:39 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB2AC061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 10:10:38 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso11770774otf.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 10:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O+E1w+hgBca1POJJ3V7WgopBSO82CqmpublPBn7uXlQ=;
        b=Y/PW+6Ww6SSHO9pEv/h/fMW+QRkfMMQarxizT6K3x6EJCKFKWzm2qrgcXTwXuJ24rf
         4iPYkxEmxzFJucNKluuk5sVPHH6foy/LCAnHP3Shnc/LuhuhkN12mt4T3344tTD0YGNk
         g5SG8m5EP+yEb5PI3o02keKX46GWjeYvfKkdB490cnZNJ8KwLKmqXaTPLnepa4Uk1TfB
         pNti15oXos1s3jKQZ8fTmqkAhQIQ1dDX2PTwvIfRkNfrdsogo72BbZL97S3HA09LqJHk
         59O01WdgG0fLc2oCADooPiQlLCw+oiex6LQ9vQddlFxEexI2Hi9dzBbV+FVCF2+shezR
         r4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O+E1w+hgBca1POJJ3V7WgopBSO82CqmpublPBn7uXlQ=;
        b=TatL2497OdRoq1pZqA5QZxvv7oEyv1MLLMLVuYWYvxQVTcemLM0gljIWoqmtWDpWO9
         I4Iqu3X8SQL1UDp0Be06Jo5p5bAoBTiCi3y/r9hHQY2dqCGn8t6TVDWoEvirqwqHdQxD
         0skQBwkS0yT2/IpYMJPbjwIpQGhCCwJbOnkqzUaqb2T864EWWMquoCLX7WuuNaI4eNNo
         sLKQQzED5prINnqrRRKSGJJOE7LF2vg36UKRnoItFd8hdph9jQhMLZDoFBXi+bLu9dzD
         rYowSJU2OkOkWPYRgn/5q/dPDMDjLmi0BKXIJyF4Jp0OzMRbKon+OluB6jt6ySjpraLJ
         h2LQ==
X-Gm-Message-State: AOAM531SpLPaeJzR7RidfFHuL4iljB/aCx+E4Te8YnB6L/U3J82apMd1
        6qWDzQfyop6FjnUyDNQEAM+avQ==
X-Google-Smtp-Source: ABdhPJzcy58aEyxi+kpkVGGjeuCAvblEfeKTXjQa+cRZQkwV2Fcspki9WHDYTBSeryUiLK2beEbHpw==
X-Received: by 2002:a05:6830:1e13:: with SMTP id s19mr5383465otr.358.1640369438032;
        Fri, 24 Dec 2021 10:10:38 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o19sm1785949oiw.22.2021.12.24.10.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 10:10:37 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~okias/devicetree@lists.sr.ht
Subject: Re: [PATCH] ARM: dts: qcom: sdx55: use standartized naming for spmi node
Date:   Fri, 24 Dec 2021 12:10:32 -0600
Message-Id: <164036941060.3935440.6919654945648950806.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211224162937.53404-1-david@ixit.cz>
References: <20211224162937.53404-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2021 17:29:37 +0100, David Heidelberg wrote:
> Following naming convention, rename qcom,spmi@ node to spmi@.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: sdx55: use standartized naming for spmi node
      commit: 4c444c21bf14a748466be0cf627380cb51cb6877

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
