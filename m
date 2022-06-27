Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B7155E1C3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbiF0JLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiF0JLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:11:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06711264D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:11:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id z9so4963320wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=QGnQXstTtOMMmxkkwxBbkG3HBESo9l7toZWbWyhnomM=;
        b=kpAWdgFtUsqdk7zGNkgsPjhU0ZXYzzFp0tqLRkAY7dIDHpTYCF0SGPLxUqvy16itLP
         YAJBe8VwdT7OerVzxdD1WDU7knZ5ZU8r1E+V2hzLKqMCqHrHwqDNMGEE/eY2Bew7ehFq
         yW1ocdRZ+O3poGkLOGzPFwWE3XSisYoyJbDxmqvHyNOfknqo+aiyX23YDEMuhJ9tpb+B
         Qb7AFDXPsT3sgmdrKQNcfHW9dNy/CPNtbqU2ZKwpf1w1He/Lu7zcXcZQcC1FZP2F/eGl
         KPrp5WGsQdjYIaT9xTJ6DOGgjml/YEh4dr0GgZgp8K4+g/+S4JC6OjraGgxNaadhwN3h
         KXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=QGnQXstTtOMMmxkkwxBbkG3HBESo9l7toZWbWyhnomM=;
        b=c07vOHGaNvfyBavgO36wjxqbyHT0n3Bq3EHt5Cj1XFajvFvF69RUGSUpUypuQ/NQ17
         Q0C5lDpq1yNlztTaOSYGSPpS45DlBoCoEIUaXXsaxd6wKgjUimpNxVVnb/eCfNOsIy5T
         ACUu14/+6TUuwcOnEFRxbsjxRYWL36UPp05orsw4QNFVu6+yTj9RXe80xlVhvsD20Yce
         8geFKupY6uXmvNRSNmS3+D3n/GYYqEYphRDEezWr5os3io/lwoPE9rnL8oKTOxDYl1PP
         BSsMThUDpYKozmydjceazMmxl7PbaXVayvHNECRpqvHQ4JAiMq238U0eDl66FF/mePnK
         +hkw==
X-Gm-Message-State: AJIora+7YhbHJUQox8rX1E3NfU132zQoMXNKm6jUISRKqGNU+jHiGXF+
        UOk7KZHPcZincxYtLut5nD4=
X-Google-Smtp-Source: AGRyM1sa+483ixHk8LLd1czgaNOg8grOGRS6/H4rp5IvxvkaG0tWklZT3tyArlMXVv547MYU6Dym8A==
X-Received: by 2002:a7b:c003:0:b0:39c:5642:e415 with SMTP id c3-20020a7bc003000000b0039c5642e415mr18725420wmb.111.1656321077585;
        Mon, 27 Jun 2022 02:11:17 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id g12-20020a7bc4cc000000b003a03185231bsm12245230wmk.31.2022.06.27.02.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:11:17 -0700 (PDT)
Date:   Mon, 27 Jun 2022 11:11:12 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     linusw@kernel.org, kaloz@openwrt.org, khalasa@piap.pl
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: intel-ixp42x-welltech-epbx100 does not boot anymore since 5.19-rc1
Message-ID: <Yrl0MN6rtN1xHHPZ@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

My intel-ixp42x-welltech-epbx100 does not boot anymore since 5.19-rc1.
I bisected the problem to: "ARM: config: Refresh IXP4xx config after multiplatform"
From all CONFIG change, KERNEL_XZ is the problem.
Deleting it from defconfig lead to a successfull boot.

I tried to debug further but I fail for the moment to do some earlyprintk.

Regards
