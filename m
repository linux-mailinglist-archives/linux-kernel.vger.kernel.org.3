Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819BE57493E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbiGNJlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiGNJlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:41:08 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F4946DA0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:41:06 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso866583wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=7ITMCkMys6kS4GnXThXCrFzJ+x2vhA9RLy8nRC7h2Ps=;
        b=Gw9dcPoI0AL9EIzTPqcn/DgkG46lOCjZSI+d228Po8/eSLZq1aFCIFSRsKmoXtVQYE
         4eYsxmidFPWa0stqbEZ+FDPYK5lQ4CFlOgkjSDGStJemY8WBzQDgb+Lnkqh6e1SS/PYM
         XCR4iM1wN2NZOToZvzsH+VCSdTT8V+yOK431BOA9ZWmArvc7wFoYN1vzr4X1yGX93fHU
         KSkHNk9DkkAzhlYjVQxU5EdiixnM7VTs6YDfQSjrGlmIYpoKIajENRZwKubr7EbELYa3
         MgOeUfFhBHB+kJSS642sqGcWkp/9Pu4iiBJh2SCuNOEKt2tKiBU9WutNQvdZOs3Iuk7A
         UR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=7ITMCkMys6kS4GnXThXCrFzJ+x2vhA9RLy8nRC7h2Ps=;
        b=dIBUuRnNCVl+TanELXFDUB1VH0qd8gZ120pmWYAuaJbEBECTly7sYuhuIdRqq+xbJQ
         PCM8iKJFV3xE8E/RJcygeSKfBMM0Apc0qu3skppt2oHls46T/XPN9lNhkrFBOM99LwtC
         ywDVCp7iskXSE7D9/UodQ91hNuZLE1vl3XsH7shRmVtVev93qG/UWedHLBciVWIVuSj/
         BLbXSpzHFAfg2H5Z68Xt0lJT/9LARKvYR0aozGqwiNs19EDPnaaJna5gx4KQsuEZcctn
         rxVJD/0hvLkSYv/HP2ugddv4+16Jj3rBUnxzrZR7+HEhVDXJ6x+7Ox4Z4VPqJo+yl8uR
         a6Dw==
X-Gm-Message-State: AJIora8+f+HzKlYxUw9n3lI69KL66uSK9vUtY2AxDMQDeUNVYziEKFuh
        jbM+aBTiNHl59FgyCl7tNF1KRQ==
X-Google-Smtp-Source: AGRyM1uvvCgbY/zqupYYF5H/QLQQ666JHCfrYo6l6n0KvQHoHbigrzbYsCrsDByVcOr+YUriQDyvTA==
X-Received: by 2002:a05:600c:3ac6:b0:3a2:ce07:d011 with SMTP id d6-20020a05600c3ac600b003a2ce07d011mr13688557wms.99.1657791665264;
        Thu, 14 Jul 2022 02:41:05 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003973c54bd69sm4766784wmq.1.2022.07.14.02.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 02:41:04 -0700 (PDT)
Date:   Thu, 14 Jul 2022 10:41:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-leds@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: LED Maintainership
Message-ID: <Ys/kruf8DE4ISo8M@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel, et al.,

Not sure what's going on behind the scenes, but it looks as though the
LED subsystem has been left unmaintained for at least 2 months now.

Does anyone have any objection to me stepping in as temporary
maintainer until the situation is resolved?

Kind regards,
Lee

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
