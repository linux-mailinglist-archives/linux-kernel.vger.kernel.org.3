Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C69495D48
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 11:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379849AbiAUKIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 05:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240580AbiAUKIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 05:08:50 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB4EC061574;
        Fri, 21 Jan 2022 02:08:50 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so21124904wms.3;
        Fri, 21 Jan 2022 02:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y8ZgvxUuDvMPASUzYnlUG7u5a3DpOlNEJdmY/247HGY=;
        b=etPcju/1MxRY9JATTvg5CBIibQQNKGie7+8hppQ5Pyn/r8X1gijuohtVwQ5re5lMzg
         yNKMnkXDvxoGdovk0PdhO4iRGCR65menQCQzIIplj53mwge2wt+FfGG19jtppiqm95zo
         96m+D9dYkVb/3Cq18kTeyEbm1Nxa0Qg77K3Xt2nOdTSR65CfMdDmewDmwtVp8IrAkfzh
         BsWoXNtCRNY2Co8EKL4EZmg2wyfjZwT5eHalncKpGPQwUUsyl9VaNId12zJRclP0EQPO
         J4oijuM3KVSAZyfymoTDKmzmZgKEl86F7tQ0Gx00iJPMMfV99ciNDiDDKzIkE0LHRcQT
         yFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y8ZgvxUuDvMPASUzYnlUG7u5a3DpOlNEJdmY/247HGY=;
        b=jIsJBUDg0o4TAa06lvDv7z9fEaYWUg83v5Du82Dp0TbjwqN6hW9SrDamg4SHHG+4KK
         3KexBU09idBMS8P2Vwl4iwBI2wL/hg6/kR14ybtsC0jvtlt3VpXK9vBEF7EN0V5aGdfV
         9z+T7u2ZwltK0WZUczNl/bs0y3YF24fhtnRRH8PyHqoz1/mza3vOdMVY28NPnW+bUMkA
         lHK+sm9lg4NUxOGzjIZ+mh0lUXpOXTImHAPKgScPvdFboI6N3sF5lwC99guxEw1zfzq3
         USYAzDmYnHcSMtnhT8fSkhgaP2OhK565SRuo4yL69CBsIemTJ9IOdI+x/gM9byjILQxt
         Vi7Q==
X-Gm-Message-State: AOAM530muzTsyAS9ha9Bgjz6ZVJIUIIizs4ktE3SeGBNPAcx8MmmEWoh
        /oolZI8MK8vStGtNt80bDTo=
X-Google-Smtp-Source: ABdhPJx3H+tWPTkTeobp58QCfJQQ/MlwUv4k/fR0+l7o32+dB8T/PCDWmOptrxRisxLWHq6aKFpjuA==
X-Received: by 2002:adf:e3c5:: with SMTP id k5mr3071914wrm.571.1642759728794;
        Fri, 21 Jan 2022 02:08:48 -0800 (PST)
Received: from localhost.localdomain ([141.72.243.13])
        by smtp.gmail.com with ESMTPSA id g7sm5479526wmq.28.2022.01.21.02.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 02:08:48 -0800 (PST)
From:   Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
To:     mosescb.dev@gmail.com
Cc:     gregkh@linuxfoundation.org, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mchehab@kernel.org
Subject: Re: [PATCH] drivers: staging: media: omap4iss: Use BIT macro instead of left shifting
Date:   Fri, 21 Jan 2022 11:08:36 +0100
Message-Id: <20220121100837.337094-1-mosescb.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220121093722.320082-1-mosescb.dev@gmail.com>
References: <20220121093722.320082-1-mosescb.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
Dan,
Sorry, I missed it.

Use BIT(0) instead of 1

Best,
Moses


