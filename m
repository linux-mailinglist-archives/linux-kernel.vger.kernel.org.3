Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07D756D78B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiGKIPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiGKIPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:15:18 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D3013F46
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:15:06 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id ay25so2588964wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0ohNaZr3lv1nqXX2GzcOrF9fPgAdvp4Pa47LXBtmeYg=;
        b=Q+NSo0SPyqwA0GSEAUCgVvRtpAObd6hq/ZxEIj1aKML/rztjUPjvr2gYXxY5zilTq3
         ZTBjAvniWx57HNJR8UhYCrelLbU68ZD+wQ79Qlqs726JXTXBl6Kj09Hi+V9GqDCFGz0D
         3Fus09xbLlqGiJfNgCCjjrCgvPNq9NhTSL6zD1eKGbjCrkEpvbIpnLIeUNj835NJBqSz
         HDMsRNaQKBDlm+KQb7yejO97KalyFmJeFc5inI3Cb6DsSQgkhOGGNJowceUEwtf4XMys
         rYTth8pRLwc393E5bEmx94aXslbCu58lWrdZMyouVYs+tBFPiJGMjEMnnqF7OSnmkVuq
         ru7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0ohNaZr3lv1nqXX2GzcOrF9fPgAdvp4Pa47LXBtmeYg=;
        b=DBswvCzmxHvxPVfah8Pd8ctB5NZ8N+uGfl0Gf5Y00AIOKl/Zq7U2EaEa9zillxqkju
         x5GFxYMmWPYIWKqFd0PRv3BNFM9n7XRHARThRlVzy9ZEtx0zrzrOQn7tLNAbyBGEa5fk
         oE0m19HFd9ExZ4QSowhJSj3m6TeavTOAFk0hgG5QVOfRvO0oVfv3N6k4lKEN+13TevBF
         B+Tyl16uVQrGV3Ar4P5IbgASt3EZl9kV4DAtawWfFaQnj2xozTI8hANiE5FJ9IIDSzje
         3uHaQcPLjU2hsc2MZfMQYnvk9T4z0bIU3BASW2lZoipL9EaIXwIqwgPlc0WxL15aAvbV
         MXQA==
X-Gm-Message-State: AJIora9CfePqs4GgNr78+f1kNSfwKWLU4RNqBjytd0LSXYwd2gsZHtrk
        RE5GaosbZB7JDf4TnlqhZahmVoiTLvTtyQ==
X-Google-Smtp-Source: AGRyM1tX4ohXQX0IfA8L3XFk0w6PySpb3441711DWgGskfBGusVEEq2GWfRtaPNz2r9cQ+Z+Ekx95g==
X-Received: by 2002:a05:600c:3845:b0:3a2:daf6:89c5 with SMTP id s5-20020a05600c384500b003a2daf689c5mr14623843wmr.120.1657527304774;
        Mon, 11 Jul 2022 01:15:04 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c434700b003a2da6b2cbesm5947791wme.33.2022.07.11.01.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:15:04 -0700 (PDT)
Date:   Mon, 11 Jul 2022 09:15:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Orlando Chamberlain <redecorating@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Add Intel Meteor Lake-P PCI IDs
Message-ID: <YsvcBroosqD/wN9n@google.com>
References: <20220628223047.34301-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628223047.34301-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2022, Andy Shevchenko wrote:

> Add Intel Meteor Lake-P LPSS PCI IDs.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
