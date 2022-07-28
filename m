Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF23583855
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 07:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiG1F7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 01:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiG1F7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 01:59:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922105C36D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 22:59:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bp15so1339488ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 22:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=qwj55DDSOy6+Qm8DQ0l9gecTgOsx8eBbhcnPeMNmnks=;
        b=iIeVoA/yqmwYT62l3a4EmTNLnYNVJvfJsZoHyxzZ05dg5y1rCgk7DwtRfkxr/O6VdX
         hfesSR+l5hUBs1CXIg/d/5mxrth6ksw1zcm3pjoqTf58eolO/yrdcE1scR48RlBgoYy1
         3nGUwzNs7fL5DDhmaV6hEuBDlUrFWxPrjomClwer2lcXfmekDvbW8QYj+3h5oaNYQCWG
         M04kK0gHEhlrJTIXXnyGuVxrWbh2O+YC3yuWy9gegTqk/+ee+0LWbVQgq7zNgLGamd8z
         Fq3oda5xZ2N8h6kP51DT3V0JRuM8rhA03xQ3Wt/SU/w0QB78WrD8RzddkJ1TuEcYKAyE
         amaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=qwj55DDSOy6+Qm8DQ0l9gecTgOsx8eBbhcnPeMNmnks=;
        b=NUC5Ag8OMgVB4AArcmpRBcwJwEw9HsS1/m3I7chtb23HfqqITvn9kGgZtwLlo2Xf8O
         QN3VG5bV3SD6jspZ5F9MCVA+ByKNBazMsqpbyDFLuU3WL7eEN9/vbNQvGlWHJ6dn0jdx
         i49RtEHzaA1a4GGe/OfDevceJYsbelCdHIyb+Y4McitTwZD21BUjlasBp1tkhyxc27gH
         deispwZYOGn+7MH1HySYVadfRFriV78E0LxHxCu/EGsuvAHhBRcz3Xss+b4v0HCOoEi1
         Gy1KCc2c6f/SWBdepIE/XsuyKaLEP0ZQ2OXfuQlbEA+GSUlEWDnPN4JGkmG2IxEs2ye+
         6goQ==
X-Gm-Message-State: AJIora+295a5I1X/EBLtmeuxli8bo/CEF1iLflIFA0XmMeFYAjJSyy6M
        ZypGmJznWNLaWV7cK3uHoTdsIPcfI6k=
X-Google-Smtp-Source: AGRyM1u1BJqIUwBCFbMb+oovECm8I7jIzRf4TkNjVfBVDRq/Y+nUDkH4IJv7BcLj/xOQ3QJkc/p+2A==
X-Received: by 2002:a17:907:9810:b0:72f:36e5:266c with SMTP id ji16-20020a170907981000b0072f36e5266cmr19897983ejc.105.1658987969125;
        Wed, 27 Jul 2022 22:59:29 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id k10-20020a05640212ca00b0043a7c24a669sm71927edx.91.2022.07.27.22.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 22:59:28 -0700 (PDT)
Date:   Thu, 28 Jul 2022 07:59:18 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] staging: vt6655: Convert multiline macro to static
 function
Message-ID: <cover.1658986804.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert multiline macro to static function.
Multiline macros are not liked by kernel community.

Tested with vt6655 on mini PCI Module
Transferred this patch over wlan connection of vt6655

V1 -> V2: Combined patch "Rename byOrgValue to reg_value in a macro" with
          patch "Convert macro vt6655_mac_clear_stck_ds to function"
          Improved to early line breaks in patch descriptions
          Removed function declaration of vt6655_mac_clear_stck_ds
          Changed variable declaration in vt6655_mac_clear_stck_ds

Philipp Hortmann (2):
  staging: vt6655: Rename MACvClearStckDS
  staging: vt6655: Convert macro vt6655_mac_clear_stck_ds to function

 drivers/staging/vt6655/mac.c | 11 ++++++++++-
 drivers/staging/vt6655/mac.h |  8 --------
 2 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.37.1

