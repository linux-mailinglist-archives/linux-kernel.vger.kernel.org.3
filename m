Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2323F4EB56C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 23:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbiC2VqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 17:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbiC2VqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 17:46:00 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B8943EE8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:44:15 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 85so15221432qkm.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 14:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=RPVCvXEj2fSP0jCf4nfbpt4FS8RxE46kWjrp2C5Rtc8=;
        b=c6D44etGx0qubq5Qah67D2wS1+8OpAbrmGUZfR2L/9sKuKyDXs9pNGbViZ9sijWDLN
         7x6MvSi2fXTFikPS70xVCn0ZoHzeN7Ble5bK/JZEe8uVc/y7ivP08TJxoW58xkcaSFWv
         kmztjZ7hYlRagpmWqyG86H6YS7fkRD2XDy6nAmHp2Q3DRUjibZoSf0COxwgOLk5cTxrL
         racYUgewp6cKdsk6aeCvTAVhiFLj5+3rHRAIjAvZnvowUAyYQ8ZtVXz8S8qjubWXSAKm
         65M2/1m3+sGhFK/jKwmjIS2DMbSFefFlswyvYXH4nc18PQvWxjDQigfNBFO/fQ+5AL/g
         BwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RPVCvXEj2fSP0jCf4nfbpt4FS8RxE46kWjrp2C5Rtc8=;
        b=zQLjG4b2TIvK92fsir2G46AH7MYzkuFxuHNB+knaq5S0rDgicEoZOBPI0cuWmmvCU3
         H02pwK1NTI0Gu+/reKYnOFEDxqM1mj8lqb3Sj6UAcHo9yGunain8yRXKahBZsWAqwiNu
         2YGUYJpWRXd7/0WCU43+1078464JI81rSuwmet5IfCm7lVDZsoLdlhZU/LqLj/llqyIa
         CqZJcQnDfTajHwskkm/4rFDf0IB47bwWsyX3uj6/MIRzGB9Rbos6q6TgGxrGcodAcxXp
         2nCtRbezZ0rz2hwH2+d+1lWtxHNYOK3lh4d040YAApzdxtHfn2sJywZfbmFHPAID68+x
         tg6w==
X-Gm-Message-State: AOAM5315W6Gb9ub7dOXWDrc9r7dOqt+lSDmL81H+ZRRMMoLKZWKuydty
        jV0w83PbwbLt1WJeDVIe/R8HCsTWRkizXLbrg/0=
X-Google-Smtp-Source: ABdhPJxxit05l4b9axxHzTP6O+F35VYJemO7TcWF9bPCRR0jtrlmu5P8gqdkD/Kn/7R05amq/93Eivmwa5XBb8J7PC4=
X-Received: by 2002:a05:620a:22d7:b0:67b:1bef:7701 with SMTP id
 o23-20020a05620a22d700b0067b1bef7701mr21567154qki.268.1648590254606; Tue, 29
 Mar 2022 14:44:14 -0700 (PDT)
MIME-Version: 1.0
From:   mark williams <markwiliams2mr@gmail.com>
Date:   Tue, 29 Mar 2022 22:44:01 +0100
Message-ID: <CAOZvAFxout=H9=2WZ2Btw3=4RmX7iO9yt8eicepVs_8NN0egbA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering if you could recommend someone?
