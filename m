Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03B048D92E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 14:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbiAMNir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 08:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbiAMNin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 08:38:43 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50A6C061748;
        Thu, 13 Jan 2022 05:38:42 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a18so23134827edj.7;
        Thu, 13 Jan 2022 05:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=siyJ3IKXuv9/oXQcC3ByBW3sK+ajKYeDNQ9b24NHasA=;
        b=SuIrGVq1bJEoTnScH9ukWm/PR9SVmz8tZS2b7BAY4tT425S1Dw7stDcKK9AwJy5QPV
         LnsrQ8EPjjG40SgpschtSa2IUy7rEgzicMPrk8Brs9TI2xI8+nFxrAey+09COfrJUZTc
         Dnta0FEUwgCvYpl/V5G/Te57MMMeD8TAC8lYl0+20dnBrsS4S3suYAybFFfVWKxMBGh8
         izEdMbXDj/Q8lXEEa5J8wfaQAV6ZRwnQHDuBpwv8abEHCqNOvJEhRTORo0VC4oAqHgEs
         dXddppB17ugfz/yDfW2XHk8x8wTLl5aDGlYoTSS4rCpSb86/LhM/KguMWXGkV8qe/e86
         IgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=siyJ3IKXuv9/oXQcC3ByBW3sK+ajKYeDNQ9b24NHasA=;
        b=VA7f6wzzshBC04w6vHRe8wcqvtBlMQLNYZUsEWHjuL7Ytd69DKgJ8iQCOLotQ7+gAt
         kV5tiaAiWzfpWKgFQPkQKIEJ6cC0OImYDzEZeFOvLdpV8Ll2pETX30Z7Gdv3jFQnp9+5
         XkFsvY3zWo+Y4YVwQpAAueTRKLTulePCL2eVWhp3NwZztf1vjWslHKyIHkLrHdM+MGWb
         cTxsFsuwU8krKebuVmNz2B7taM7BhLSs1ZHhMQjHwQbPN7wvNmfysdHLHsXoKF1nYlA7
         8nPcxcfPbjKvc+pLyXO1AOFBguMktVXOsFgXX6DV28EN+csE7x5GUM1YMioGDTxMbCoX
         Gsdw==
X-Gm-Message-State: AOAM533ntvkOM4LedAMDkM88zL4Ifa3EmG5VgrmbspjjmOgT46Tak11P
        RMl6lnnPoH6SBD6fFsb7/YxtnAq7pr0=
X-Google-Smtp-Source: ABdhPJzcXAHLZiu/iFg2Y61Kfg2PaoKFH4SZxjLNRihSEjlzsA6ybrqVrRYiTlo45ixeinSjTlw1pA==
X-Received: by 2002:a17:907:97d0:: with SMTP id js16mr3523729ejc.577.1642081121336;
        Thu, 13 Jan 2022 05:38:41 -0800 (PST)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id qa35sm898766ejc.67.2022.01.13.05.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 05:38:40 -0800 (PST)
Date:   Thu, 13 Jan 2022 14:38:38 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] dt-bindings: trivial-devices: misc (whitespace) fixes
Message-ID: <cover.1642080090.git.stano.jakubek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes some minor issues in trivial-devices DT bindings.

Stanislav Jakubek (3):
  dt-bindings: trivial-devices: fix swapped comments
  dt-bindings: trivial-devices: fix double spaces in comments
  dt-bindings: trivial-devices: fix comment indentation

 .../devicetree/bindings/trivial-devices.yaml  | 314 +++++++++---------
 1 file changed, 157 insertions(+), 157 deletions(-)

-- 
2.25.1

