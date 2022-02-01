Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185C04A5670
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbiBAFVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbiBAFUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:20:35 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071AFC061772
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:32 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id r27so9033470oiw.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 21:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YXCF17Q4B18FRMKASBAO0jdm9uEHBXBZnFCmMAjPImw=;
        b=ZMRCrzGNqoTGw3rS4Q4pjqzNuSGbgME24kh4va7T5AehZIOtV1+FJBmAIjNaihl9Me
         QYdirlsDeYYU8aLRf9fCHL3PyGG9vv6sfXsIL2/EpEF3SM8l2mVkl7cxw35eNojCRkgf
         SO5K3/qs9yQ0DTnAfVK1VyBv1NTj4FY/+zd4mxrXlNYygGjR+g7EN5UsmO7VAw/Yo0sk
         6NTsGbMW3/yYVm5fGAaEtbanhFUvRLLuf+WoKLIKmS38UDdcfmjWwTgxrEgvcX5v4wLt
         3WXxizn3BSsaMSKufRgUIVA+JXy0C4FAlHWX3nxqbTjDIoOLfp4p5yvLOQgK3hQGDgYo
         Y6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YXCF17Q4B18FRMKASBAO0jdm9uEHBXBZnFCmMAjPImw=;
        b=CAas7FD1tyHQxiff6MxootUUAsjd6u/OQNO1ToDcBoOB65I8VIc9llWuQ9zAADv1b+
         w6q+ZDpUcrytuBTHvM97iorAX4frBt0kt8v/4ko7Bfu1cHwt/UQQhgadAyBtXxUI800E
         wqR60LTz7RQtqE9ioMvvEcaJ2VNdtuWnI+UugqsKonzQC1KIe0bNtT+V4yuzjOQ6Mv8B
         6HTzaE+XzyZLeVI5clk0IXfG0SDE0frAnO2NL5wsNeWjA6S+tiWPXkGHr7JaCRzNVXcF
         Tv84viSggMz2KxjrN0vKwl1Y/P4g3wAa3VsXBsaSDHSldnNN7vh4TPkhMKaSB08OpmY1
         zspw==
X-Gm-Message-State: AOAM530VkcfMFNnwX6ZuZbqmOtHl5no68NkezOZrw3hkjlinQ49uXMxo
        EU1td7xHLuFw5w+p63/glhBduw==
X-Google-Smtp-Source: ABdhPJz2ayn9g8vmF6Z31x69pJcy3R213lZBVrvfXZ7GGZ54ZcZYaQUj4rVrsihcUgzuuLpLvEcxdg==
X-Received: by 2002:a05:6808:1141:: with SMTP id u1mr219909oiu.161.1643692831391;
        Mon, 31 Jan 2022 21:20:31 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm8193107ooh.19.2022.01.31.21.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 21:20:30 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        David Heidelberg <david@ixit.cz>
Cc:     devicetree@vger.kernel.org, ~okias/devicetree@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] ARM: dts: qcom: apq8060: correct mvs switch name
Date:   Mon, 31 Jan 2022 23:19:39 -0600
Message-Id: <164369277344.3095904.14857852358744642406.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220108170545.54127-1-david@ixit.cz>
References: <20220108170545.54127-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jan 2022 18:05:45 +0100, David Heidelberg wrote:
> mvs0 doesn't exist in documentation nor driver.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: apq8060: correct mvs switch name
      commit: 251632433637acd76bbcba954b07fc1c0522a7f0

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
