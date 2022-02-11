Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682604B2484
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349486AbiBKLgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:36:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343573AbiBKLgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:36:18 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34461E9B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:36:18 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 200so8039960qki.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=z2gFosycv/4d8F4IH6M5EFvOMVfX/xiPl+lWjQfsKQI=;
        b=GH6rnxlQa7pKNjEQnolaZU35YnXATMMaIEv/EgjGDcfLKG6UJ9EBOr2pcjSc4J1VJO
         BTqltSgJL8G2aCptNRD0PVpBJ7WDQReVx0z66wzwhKe1s4Vt/sIDaYiQgVUzRb7k8kuE
         vjAyQoHdlml/JUxTC7qSd4vz5P3Q+AtcJ8H5TCc+zQ6OPY8EA06JQtcoCgJfZDYHYC7J
         TKdbr1QDS+LKGe67wERxIX03UxuSYv0cghWefW90yg789TT9rg+6mN7uGCCHRbh+exq/
         234G/GEHxEkAa5ieM2CvmTwo2o27Aw6X02yT0PEQZPZ+YIpLqrupYGZaS800V15pHF0V
         ocGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=z2gFosycv/4d8F4IH6M5EFvOMVfX/xiPl+lWjQfsKQI=;
        b=3y3E8P2X5G0jfoWs8jXz/w44fAXl0A4Ks/6Dk0uVTqtteIsO5P1qaHBJdZVZtmvll/
         uRLvcFIMslR1VIsjliHgACsJumZ7GQ+gc0j1rS2t9ybcUqBlv97N525I2cRYSM3EdP5K
         ISCn+KjwFF6ThbITyhYs6v2gDZX9E6fqeSqiUUe2sKkPpKIJJxkAJbhVtv9rXGxZTeiK
         bEnfnkkihZ/pV1DYJjEo7EXVYKayyLCx24m472QtNIhoC8XlvLvwokb7qFzhsOTafHOI
         2JJyta6ZxLoo7gil/EXKFuNlV9eYP673usQRq2+GE+FMHEJLxbuhTBY1E1L1gS/05lzk
         Uwrg==
X-Gm-Message-State: AOAM532eaVTuw0ZAxmqSOY4FiZo+2XgZSO6HK5pAXiELMSPVPzerutVd
        SNR0NG7fsfBl/VAiFoDwgNCKIZ63uyyNsE0kUNovm3mdocinvqY1
X-Google-Smtp-Source: ABdhPJw+zRKiCGuV/1ZWcPlYBvRrQjpU5Z6uQC8o9T0TfxgGs2cdTfNB2ENGcWUcVcMRirXpB/llqb3XudKxcG/4gOo=
X-Received: by 2002:a05:620a:254a:: with SMTP id s10mr473911qko.724.1644579377319;
 Fri, 11 Feb 2022 03:36:17 -0800 (PST)
MIME-Version: 1.0
From:   Du Dengke <pinganddu90@gmail.com>
Date:   Fri, 11 Feb 2022 19:36:06 +0800
Message-ID: <CAKHP1dtwQRD4Q6poVopyZ1WXtBL5kavw1BYQZBU1_LP1VNtJMA@mail.gmail.com>
Subject: 
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unsubscribe linux-kernel
