Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C9755CA8E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbiF0NX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbiF0NXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:23:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C60D62F3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:23:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m6-20020a05600c3b0600b003a0489f412cso1400021wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 06:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=imH5PVeh3wR5UpM7EpqvZezB/FkoCboH22AdmqXpTFo=;
        b=xEIWHES4r9jNHW8smiOte9yLvrmureDa6G02r1PHQOx1RB0775lNWZr7nDao5/ioum
         Igt4VQM/fGhV4GKnPVgih4WZtR6bGLELhMQHlhB1sqbQ5cDLKNhxLVKgGIZnr3YuVc/S
         BCngGl2FO0wGnOV2ExLh5uc67kkKVi56/XsQO5qWY3dtP4/cOg8lD0zM2zChuNVZIz2K
         M9pH5LloAY1ngw1avhV9kRsK+OM8Z3SoGoFBh15JKLEPOZHO06IwFj05eBHcRGroD+Wb
         /asny5D9Il2KxYTVMJKrAYPi7nubQIY706mYcgf8uUB2Qc56zQGq2jxvpIFwBmWhwOw+
         kYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=imH5PVeh3wR5UpM7EpqvZezB/FkoCboH22AdmqXpTFo=;
        b=fIYhwk3m7CasASTexWsInO0bcc/Avp7P7oJPx8eE1yOx94/OhM4CBPb638/6N34NCP
         aL3g//RetlR0svLgWHorMne6slA33SfBDRoUMXBZjVRmIi7AXxwYdnX8soxwhf3fMZGL
         NbPi7oTJpnKsJrTqGeX2tQ2nIZuNnfesjboqr4YARzwA6ezWBe9EGE6NgDkfUNTK1jO0
         H0bizNOAKiOFQIuXXQxfMv7uk9BSi+7CFR7uMwpuGuderhkpATWSPOlxkQZS+7VzOelS
         QpNg2ehT3duUaEF0ERxA4v+KLNzdz1q6IQbd9vtkdOe3VQgUUAN0vK3EmM+DLj0Am8Pl
         Q4AA==
X-Gm-Message-State: AJIora8UtRGoaPy1HjkEcpPwHkLUjLjR5qEV/ZDkrhRI+vFFP2B/uEsC
        VB8VMlv8ugSNHf8nFSPSfM86nw==
X-Google-Smtp-Source: AGRyM1t+0V5h4xi3+83pcFt7usLymYBtDIXaHmLiioPN62N6+5Y/9QfO30iIqQiuQftpFBCLJ8UYbA==
X-Received: by 2002:a05:600c:3b02:b0:397:5cfb:b849 with SMTP id m2-20020a05600c3b0200b003975cfbb849mr15218541wms.183.1656336202818;
        Mon, 27 Jun 2022 06:23:22 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id u19-20020a05600c19d300b0039c4f53c4fdsm22391696wmq.45.2022.06.27.06.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 06:23:22 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:23:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 2/9] mfd: intel_soc_pmic: Move non-Intel Makefile
 entries to their own group
Message-ID: <YrmvSHO1eUTpscQJ@google.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <20220616182524.7956-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220616182524.7956-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022, Andy Shevchenko wrote:

> It looks like a random position for couple of Makefile entries that are
> disrupting Intel PMIC group. Move them to their own group.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/Makefile | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
