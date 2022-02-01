Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4989D4A5695
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiBAFXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiBAFU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:20:57 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438B5C061776
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:50 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id s6-20020a0568301e0600b0059ea5472c98so15127971otr.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WzLZQ6lqZkdpbMj57Uomypo+FFPWINPWh+G9g9l2vFk=;
        b=wH3sVAxrtlabEH9t+p8eycVZyRMffqonXWKa9TB17eplnIXin7L8SrU8q5bDfUwMc0
         VNi9kyXXXdA+W0cxzVu1lGdOx9f4jG1P8GVlIq64raPUWQDlHZUxzksxBdLwVwchUyBt
         NshsUmCwZQz8WPW4PGx79uJp8H2O5q7SlCqK5PWRDE2GOck1dfL+i4Y3hOSYmk6yUBdl
         2hvg38PSQcE2YFOd5WIY9XucqnRETRvLv74z1BNQMAUu4MtN5Oz3u/i5R0ry482zraaQ
         PJpJKfQ97sBcfOoLTjRGDVRUSQl1kL1mZ31zSUYiusicx6To1PIgHiEQrcr6pYVKsFkF
         +qyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WzLZQ6lqZkdpbMj57Uomypo+FFPWINPWh+G9g9l2vFk=;
        b=s8I8GM6q6Ki8WUdNPSPrf/j+Ng6ZgV965gm/6edx0bdW5PfxXyrS98oXT2EwpuxYJC
         +Z+4OXxwVlPp+LrDIBM0wQ165bmSfzVlU8Xzk5aQMSFN+mqCW1RUE1nKlhLfFzJM1dGC
         BvXjvZaSgmd23hK5Rcbj4mafU/U1CHb8tztDNlC4vcdQwCwINHt/m2MknNGggqhf04fr
         VdJ4EGCV+TPCDDbqzM744mest8qHEUnUOgZIvfKyJMX2vgv6WmUkfT16O5nb1OkwDD+e
         nYVFEkilHWPrp5BX4AXbL2IIknz33st0wIIDMF2uzObPCU1EHZjZ3kFKuW9W3rKhg83/
         N0Fg==
X-Gm-Message-State: AOAM533s0J1RGuF2KAEzxK0UnDREzF/zD5TiC9WMc4cMeZkVC00leAwh
        N1UE8T4x6ZfR6kXrwW4Rz7Ng/w==
X-Google-Smtp-Source: ABdhPJyYpaWYOdpJeH3gASdDGJTJNMiU1xS4VylhMyKAKho/YJs1MxaV3JBb8NXCXcH8iicocUwoaw==
X-Received: by 2002:a05:6830:1204:: with SMTP id r4mr11445595otp.32.1643692849683;
        Mon, 31 Jan 2022 21:20:49 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:49 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-arm-msm@vger.kernel.org, Rayyan Ansari <rayyan@ansari.sh>
Cc:     Rob Herring <robh+dt@kernel.org>, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 3/3] ARM: dts: qcom: pm8226: Add node for the MPP
Date:   Mon, 31 Jan 2022 23:19:59 -0600
Message-Id: <164369277345.3095904.948418340291861432.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124171538.18088-3-rayyan@ansari.sh>
References: <20220124171538.18088-1-rayyan@ansari.sh> <20220124171538.18088-3-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 17:15:38 +0000, Rayyan Ansari wrote:
> The PM8226 provides 8 Multi-Purpose Pins (or MPPs for short).
> Add a node to support them.
> 
> 

Applied, thanks!

[3/3] ARM: dts: qcom: pm8226: Add node for the MPP
      commit: 5fbd593756be9a0ee710b15e14d2797bfbca108f

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
