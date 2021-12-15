Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2631A4765C8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhLOW2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhLOW17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:27:59 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBEFC06175C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:27:58 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id bf8so33743375oib.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UC5FFFIEaBIcd+if/NsLlcrGmZyHpY0pwIoSIAZRAVw=;
        b=X4lKGKCm+rdrvOSy39APcDmLo4IH/i6MV/Gatz3eBdNQsr7zVenJ4TaKTwIHKZNkqY
         fEgQ0zsqjs+PVI1kDwnleMn3IRIXSEDYLQ5SyGYztcdBAcBeiXEE3jc25uDSZ2XoT/jw
         dpieoqzBNSqsMciO60X/e5Nezqns5w1U/Y0EuHAmHrvXAhop6+bMNGWeAm/aPsZowV/G
         u+FqLporbZFxHFvf+1w5Ea1yRzeM5RJR8cNdiPWRtpi8vaNzQBGDK4dvOG0bU7gS4JCM
         Vk6iNgVaJl2hGGnwghPcltk7A/wzni9ECxSqMjsiKBZMUcWj+HmmAU3h5o2g7Qn2Gj0g
         11UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UC5FFFIEaBIcd+if/NsLlcrGmZyHpY0pwIoSIAZRAVw=;
        b=OiTfEZhKgEj+IEDJoYP1VhO4Nqb+/6SR07WTdED7n4YzMrI70jaupRH/3HS2wUprHa
         8PtDyuTGQiw6PXfzZxRnzRW8RduUaqToznBFHrY10TYm3LkJvM3FULw/1vKTk49EiHJd
         erLIH5sP9uze2wq/NFhU8YqSC87wAi66n/LFLc/RhDVHZKKx83cyITQXMBVMAiTbP7kL
         vCms1jenrA3vmkM9e8FQrEluB1HvoiHDRryH8u4wUOjyWvWCqAe48Mx2J7IddNre815y
         Gm7UhAmaGz7pZHxSg9FNP90a+dbzHcHN5+Amez5MbOPWJpwF5l6Fl934hG1EYt7L+pTi
         Hi5Q==
X-Gm-Message-State: AOAM530EKWwx6vmY1D5fwPrjsXW+bb3g/b8lxa7RA41wCtI+5+zgW1Dg
        HTUFpNu3BpXLdPn7tNhW/lMcFjOC+xoz5w==
X-Google-Smtp-Source: ABdhPJzTU2VpkLAjgTbI1X/iOh81NlsmJ4bBQWhK/AZv7UEvOiDnZKGQP/dyhmnPT+TdEDeardcpDg==
X-Received: by 2002:a05:6808:211f:: with SMTP id r31mr1895634oiw.64.1639607278198;
        Wed, 15 Dec 2021 14:27:58 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t14sm700500oth.81.2021.12.15.14.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:27:57 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, mka@chromium.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] soc: qcom: rpmhpd: Cleanups and mx/cx fixup for sc7280
Date:   Wed, 15 Dec 2021 16:27:30 -0600
Message-Id: <163960723734.3062250.17358735565446311094.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1638871712-18636-1-git-send-email-quic_rjendra@quicinc.com>
References: <1638871712-18636-1-git-send-email-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2021 15:38:29 +0530, Rajendra Nayak wrote:
> v2:
> * Fixed the wrong assumption in v1 that only sdm845 needed mx to be
> parent of cx, turned out all existing upstream SoCs need it except sc7280
> * Added another cleanup patch to sort power-domain defines and lists in
> alphabetical order as suggested by Matthias
> 
> Mostly cleanups, with a fixup to remove the parent/child relationship
> across mx/cx for sc7280 SoC.
> 
> [...]

Applied, thanks!

[1/3] soc: qcom: rpmhpd: Rename rpmhpd struct names
      commit: 8f3d4dd65abd03a5edcf7b5d5a7a3e2a4866db15
[2/3] soc: qcom: rpmhpd: Remove mx/cx relationship on sc7280
      commit: 65e7b31cc48581e32bee4546b59cea404252a138
[3/3] soc: qcom: rpmhpd: Sort power-domain definitions and lists
      commit: 8beb290d17f280f690857897af11dc90ac2e1f3d

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
