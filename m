Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AFF4C8F6D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbiCAPtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbiCAPtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:49:10 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0904C3EA92
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 07:48:29 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so1524615wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 07:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Q5q+I3mRSPToISMhreZ/pZhh32DUa17y+Sq8nIfcv54=;
        b=fiO0sPTAx7mXH7nL3kpxA5yMywFvku03CQdOpmNm8atk6l/Uo5iBG5UhlFRWTwoe+P
         7mG3abfuf3qcSrDsS9NpfpOG3Ht0ZTTtHbHtKMo+mulkZnAAssOu675prvAZCH89mOiL
         /XzxSEifSYeh+RpGRU1Pcn7/C4jU/nU2cYMptDEYHWLo2jIaKbu+cLxC/tVMSCNeCxbk
         bs1rcCwnJoS4LXsfcwaRUChelbpRW7b0jk1EE2tstxGQmgWIVQjrN8UmGc24+wjaSXMJ
         zR7awKnkBQlstDArR6XVXVLbeyvhy7s5/F8cGRJ/+PrV8qXfTS9TCE34s27Vb/mVdJZV
         xSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Q5q+I3mRSPToISMhreZ/pZhh32DUa17y+Sq8nIfcv54=;
        b=D1OZKNk1LxqKWl45xP+kTlT9ihqdRLKvnGeYsJYCIdMYxggeA/zqPa0UIjytbgLtqV
         Q5CJDfIpchpoYXLFsY//kiEedNJi7BCYcSN+qxBTOYWMr8M6hOyE0FMPXb1kQD1BDQIZ
         5TFfrU/ECMJWJ1CvNSucfSjFolN5l8w2GTT3Uit1WVIHfcUtn4xSi8BDmETr6uVd7i7r
         ripZt4A/pghcPZn8pJ6lq491Nd1WuPZ8dVIqZlh0bDfOGy46CM8ioFo1X++/SciaLU9S
         DZ3YWw9pJw6yoa9xUmZSVkjd3nW7aqwzlqEM/JZehuQ3FXNulJXLqWDjnNxjXjrSNgbm
         bl6g==
X-Gm-Message-State: AOAM530JmnD3AoqSY9xjnxYPSGP7Jtw/HGbsSDghLEMK5AxQuYVo5Fop
        9F/uWGr8wG3Cw4YNW3dt3nU=
X-Google-Smtp-Source: ABdhPJwrd6S4GE89Dxm3+Tyi9IZxfFX0Ja2PhFVNG4k5xsd9tvqnez1pTu1/laiuOf2T7nyxdSsmOA==
X-Received: by 2002:a7b:c14c:0:b0:381:32fb:a128 with SMTP id z12-20020a7bc14c000000b0038132fba128mr17184573wmi.116.1646149707545;
        Tue, 01 Mar 2022 07:48:27 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id z2-20020a056000110200b001e7140ddb44sm13440259wrw.49.2022.03.01.07.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 07:48:27 -0800 (PST)
Date:   Tue, 1 Mar 2022 16:48:25 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: boot flooded with unwind: Index not found
Message-ID: <Yh5ASXVoWoMj7/Rr@Red>
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

I booted today linux-next (20220301) and my boot is flooded with:
[    0.000000] unwind: Index not found c0f0c440
[    0.000000] unwind: Index not found 00000000
[    0.000000] unwind: Index not found c0f0c440
[    0.000000] unwind: Index not found 00000000

This happen on a sun8i-a83t-bananapi-m3

Regards
