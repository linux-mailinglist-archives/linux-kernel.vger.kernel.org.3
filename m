Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE22588548
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbiHCBGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiHCBGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:06:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7105509D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 18:06:36 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z2so9237957edc.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 18:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=BL2LJhfQwbcF5VFCfFrQSTX5mJFxVlayWxkzu0y+oC4=;
        b=lVx9LUf4DuWysf289ns9U0A9jYY91M6F+gSRMt9eDSGiKJU2hJAu2xU6F27PbASezf
         BN1IdMeUx/JCEzuEXJlFcEttSukuwkvj5vKKIWDR6SphMoVBxnoKIa97YjJKbHpOwp2c
         wOOsSi1aBEn2AC9Y0XFOl/hkTwAcOHMENGaERWHBtWZXP2+mFYDfcflX4v3mNJfbKyK1
         w+tHkfd8n1NlxGNtCDPoAUVq5FuYhl8dUCcIbKXbuDr+fX/XxAz4dcUXaMpiZthHHAMq
         o4MgDhhqwzGiv/xoYaFZ2kFaB/1ka7l+fhAKWANdD2h6/AaGiKgT5786gIl6q6jy1R0E
         veEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=BL2LJhfQwbcF5VFCfFrQSTX5mJFxVlayWxkzu0y+oC4=;
        b=CYg7UjWiAgSxcCQDHWqrUaKg8I3Zy+v0prNYQwNdmnk8ywGNKCVF3ZlWkotMRZt+89
         FUQuup7Mb9myr12iIU/CJlvf3v9xEnAKp/bCRTpMvkuWOEV9fgSS4WRq/WTKwaOZFZEX
         k2eecL973CAc0trtphmzY6jo8aIzFexwbEbmqeFJXQBU8H/StWfCoHYga8R5EWhYSN5o
         9ZfDdtKP7ABXu3sRO5kS7gxmgJGygys4JdtkgwvBuKMpYlHORJW35e4iJGBFLyRHlmuT
         TyzO5pFGDrl6xrm8vxK89gC7sygRqrHavQpNNf5QpLP/0c0zxl/Cu5KwOWEzxad4kryB
         V8XA==
X-Gm-Message-State: ACgBeo2l0xCC+aO79mhfnMgKd+ZstVBB6531aZi6I4oE7KmwfQ24/uga
        fY2RYQdb64C+VEdslwtEKSGfu0k68APforLMvRE=
X-Google-Smtp-Source: AA6agR6DpOQsFV/Fev/y2hOx480bZj+6Y5rOvBSSEgm/V6eM9RH8boK1XtOg8SXLlHHBw4miIsex840OG5GdELm0nrA=
X-Received: by 2002:a05:6402:35c:b0:43c:8f51:130 with SMTP id
 r28-20020a056402035c00b0043c8f510130mr5507197edw.393.1659488795166; Tue, 02
 Aug 2022 18:06:35 -0700 (PDT)
MIME-Version: 1.0
Sender: wkatherine722@gmail.com
Received: by 2002:a17:906:6017:b0:72f:25bf:5fc2 with HTTP; Tue, 2 Aug 2022
 18:06:34 -0700 (PDT)
From:   Jessica Daniel <jessicadaniel7833@gmail.com>
Date:   Wed, 3 Aug 2022 01:06:34 +0000
X-Google-Sender-Auth: CiyFQ3zsdDWN9gJlPsuOz4bQoYc
Message-ID: <CAKDaF79vSpPQWPFP-q9TDAFNf2cCZG_+9=EJA=zDoB8tBhhnww@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello.?
Nice to meet you
my name is Jessica Daniel. i will be glad if we get to know each other
more better and share pictures i am?
expecting your reply
thanks?
