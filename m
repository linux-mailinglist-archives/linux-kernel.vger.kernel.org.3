Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D08542C40
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbiFHJ7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbiFHJ7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:59:34 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A513153A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:32:58 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-fe023ab520so3276100fac.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=8q0UkAZ4dvNknvTQvko17+mn/F0IPrhf3ct/EHs1tCQ=;
        b=A7MjXE4VcaXoOAmyh7nf9xzgX9BEtqG1opT3uX56iGR9vQ720O6KPMpDmUkq7q9Hk2
         UHK8CiuE1ZJuzTgAkiWlaGmkZgE0/FWjU0m6+b5HnDa0WTRviE1aQIh3gXZPR3m/XCBs
         Qlgm9t1XhwhPwXpye9wgmynSPEcVFxfrXyDxqeHD8P75XfXvVTOzP03yZwVZbBP+ApdS
         NpC62LAyhyGdRo+/6Ul6gaO0PsQFh8Fe8Aj1dlck56SjNafWgedveQxuSRHKoCnbrBzK
         M+UYGcFTLTo/w93K595LRFMNzpZm+nxewl97rPoa6N1NLsiDDdqSTJO9yePjRXz4udYa
         nIiQ==
X-Gm-Message-State: AOAM531YPxWn8HY6+raHmvZDtm1sJz5xh+5QD13AWWHDFPy6Ks4JQczt
        4M+5du6y8MbHLPupS0n1vRb1g7N19qr5fbUIcpI=
X-Google-Smtp-Source: ABdhPJzDC4rfQ2h72frt9dZYgo7p6s/mGWoR9neFT1AICp5chVHIamtKDi4iNqVMNjw1NMwuzyXGfA==
X-Received: by 2002:a17:90b:3a90:b0:1e6:a203:c7dd with SMTP id om16-20020a17090b3a9000b001e6a203c7ddmr31913271pjb.144.1654680766972;
        Wed, 08 Jun 2022 02:32:46 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090a1c0200b001dcf49d92a1sm13623279pjs.28.2022.06.08.02.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 02:32:46 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Johnson Wang <johnson.wang@mediatek.com>, cw00.choi@samsung.com,
        krzk+dt@kernel.org, robh+dt@kernel.org, kyungmin.park@samsung.com
Cc:     djakov@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Johnson Wang <johnson.wang@mediatek.com>
Subject: Re: [PATCH v7 0/2] Introduce MediaTek CCI devfreq driver
In-Reply-To: <20220607140556.6278-1-johnson.wang@mediatek.com>
References: <20220607140556.6278-1-johnson.wang@mediatek.com>
Date:   Wed, 08 Jun 2022 02:32:45 -0700
Message-ID: <7hr13z7b5u.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johnson Wang <johnson.wang@mediatek.com> writes:

> The Cache Coherent Interconnect (CCI) is the management of cache
> coherency by hardware. CCI DEVFREQ is DVFS driver for power saving by
> scaling clock frequency and supply voltage of CCI. CCI uses the same
> input clock source and power rail as LITTLE CPUs on Mediatek SoCs.

Tested-by: Kevin Hilman <khilman@baylibre.com>
