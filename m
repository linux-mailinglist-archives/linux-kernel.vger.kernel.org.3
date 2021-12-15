Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641494765D5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhLOW2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhLOW2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:28:11 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06E5C061223
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:28:08 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso26727550otj.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 14:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jT4a+xEhIK+SVAkBmdeCICawKg4FNoRvYcNXbWrlWNc=;
        b=Hc5/fDs4WRE4QmhZqB4/bFEqCnNTQkbEj2u9x4T6p2xlyWopfm8NqP8EsHEYuNF+JV
         LUD4HQMVRL3Oi95SdU0xn1sfxzzEPEdAkXlcU3gek/wUkaO46Wicdsk0l8iaebwda0UL
         h/UTw+jDFkc7wWsigbTqoAEow1qx8KBmmJ9L6Aobo2AiW2UV1bSHvylAE6becG/JwO9C
         M5n6kccexw0Z+33zxZV3B3KD81Bq1w1RlEi0V7BYtFDM8e5skJWbrtT31WVKYUGKi3Q8
         2ySLmTvQ3AnprjhfpHEryTf78giV6tySR06FDgAvNtGreNnhxnbY3KfbXrz5AvTcISuU
         MztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jT4a+xEhIK+SVAkBmdeCICawKg4FNoRvYcNXbWrlWNc=;
        b=d6bParirJ4YiFHIPj+iOKtAHH7pHdyPfNYfZXHmlE7iLdFKa4ebeOBcn+Vxk36B8UN
         9BRb70owp5GwoPOlDWE/o/pVJv8M2F3DBk6XcsWZ8U7svvQLONHinYuj4aqMffIBJyFL
         kQBFWZW8zQQLzpqtkb/sQZpjsnuMS010yvuICNcFffLQi3xQUUa82aVdsr5HQLAHx4zd
         01T75QyAPcjq1W7SYpg6MMwEIcZVwxrEFK7dF3sCxG8HKtm3oddwWeg8JfwXiMKH5P48
         Vrh+hdzQ+8ClkLxIO2xECf7XcNZ6VwoUiveCOJBdfsxwR37m4BYR4lg307CAIbH5etLt
         De9A==
X-Gm-Message-State: AOAM531co0Jjm+CYMJb+4/49hbdPTUSVa9NoWitCTFiA0FL1WpAIAS+l
        SHVf6U2QxC8L1/okgHB4+o/82g==
X-Google-Smtp-Source: ABdhPJyj7hr2nIOKDGVEPflX6oa9DhTDQBWoBdlSnXRKjmat/ygobjRbdzcjKqxvDI9f19+p2efppw==
X-Received: by 2002:a05:6830:1358:: with SMTP id r24mr10762267otq.8.1639607288210;
        Wed, 15 Dec 2021 14:28:08 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t14sm700500oth.81.2021.12.15.14.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:28:07 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] soc: qcom: rpmh-rsc: Fix typo in a comment
Date:   Wed, 15 Dec 2021 16:27:41 -0600
Message-Id: <163960723734.3062250.6877130242356070905.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211211090626.248801-1-wangborong@cdjrlc.com>
References: <20211211090626.248801-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2021 17:06:26 +0800, Jason Wang wrote:
> The double `for' in the comment in line 694 is repeated. Remove one
> of them from the comment.
> 
> 

Applied, thanks!

[1/1] soc: qcom: rpmh-rsc: Fix typo in a comment
      commit: 73efacc6bd1d58e9b318f4861072501d97ebf7c4

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
