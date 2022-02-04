Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050944A9F33
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377726AbiBDSgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377606AbiBDSfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:35:38 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F474C06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 10:35:38 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id t75-20020a4a3e4e000000b002e9c0821d78so5619110oot.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 10:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zqEj9p/XENdztjP9JvnEudW0qgy+L4tI7wrcK+wUDS4=;
        b=VlCUdMf4nZkR+xOWCG4KqzAW9lsRXK8gsUptkMgD9hE+2TIUxX/JYJQN1dmRihFw6F
         wRivUFtNDHNxNaPWlsWFMuQ56xOhggGLS8kzqqcW78/iIBidQdbCNMQ+KozWieKYwGXD
         i/enA0BYauTlzy04ew2THxJLnW/4LoOX0yWx3yBD224Os7XNX6IRaQD0alF8APP6pKwb
         5corqced332YC8ScUqRfaN5fwhkuAs+qtlpuTTeHy+7cE20EV/2v21GfCBpL+RCkr6yN
         +znkrETJUBDkdzsbErLG5cFHGFiU1pU60UBCcsLYH+vvsRqJjNu3bUPCAQCJQIjS0v8P
         izqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zqEj9p/XENdztjP9JvnEudW0qgy+L4tI7wrcK+wUDS4=;
        b=Q/O3lPzBl8DZfKNykNtekGIMiUPgSHonOX3y12b62irTfGqnh+e1muSjSvgqDCc6uV
         jggDwaVs0vbv2wbAekFAY2yBDE87dRKycm8zRXjZLeEtQr4C6G0o6JwQkTJrTQYyPzO0
         AFiDftQVfSu8XeB4LPCCw8acTk1O9TUHZGZaYBi1Bpwm6WSo7QUCwoSObuZd0pAotbn7
         oPMIotuClem/JZnEjtZe4927ITSc4sEf6+7XnYN76MkmapuJ4rvE/X2UFrbOoEcCXDE7
         v8v2DgNfnG+G5RaathnGImU6Jrf8dwQ3bmHaEgUkaoCc7UC7uliKN77mTWUrqkuLCHY8
         gZpA==
X-Gm-Message-State: AOAM532NlamCpqGXgh3Jc9ScHBDnYOdLgotaaeCZjUQRvONCWiMbZfVL
        JuG0ztr0/f7BFdwpr8nR/X/eHw==
X-Google-Smtp-Source: ABdhPJwrIiXG0pIlxHrIPbxG0yzNBdEDeFjRGHQ5Xdo2/1lI78nif6Yyfuop6B45MwDCqz1O8di4Bg==
X-Received: by 2002:a4a:2f97:: with SMTP id p145mr80987oop.8.1643999738002;
        Fri, 04 Feb 2022 10:35:38 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id 100sm1044182oth.75.2022.02.04.10.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 10:35:37 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     agross@kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH -next RESEND] firmware: qcom: scm: Fix some kernel-doc comments
Date:   Fri,  4 Feb 2022 12:35:26 -0600
Message-Id: <164399969245.3386915.10151672354950599865.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211230141245.29444-1-yang.lee@linux.alibaba.com>
References: <20211230141245.29444-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2021 22:12:45 +0800, Yang Li wrote:
> Fix qcom_scm_call(), qcom_scm_call_atomic,
> and qcom_scm_cpu_power_down() kernel-doc comment to remove
> remove warnings found by running scripts/kernel-doc, which
> is caused by using 'make W=1'.
> drivers/firmware/qcom_scm.c:191: warning: Function parameter or member
> 'res' not described in 'qcom_scm_call'
> drivers/firmware/qcom_scm.c:191: warning: Excess function parameter
> 'svc_id' description in 'qcom_scm_call'
> drivers/firmware/qcom_scm.c:191: warning: Excess function parameter
> 'cmd_id' description in 'qcom_scm_call'
> drivers/firmware/qcom_scm.c:219: warning: Excess function parameter
> 'svc_id' description in 'qcom_scm_call_atomic'
> drivers/firmware/qcom_scm.c:219: warning: Excess function parameter
> 'cmd_id' description in 'qcom_scm_call_atomic'
> drivers/firmware/qcom_scm.c:360: warning: Function parameter or member
> 'flags' not described in 'qcom_scm_cpu_power_down'
> 
> [...]

Applied, thanks!

[1/1] firmware: qcom: scm: Fix some kernel-doc comments
      commit: a5d32f6d2e59a654036d5a4f59d9202302b23388

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
